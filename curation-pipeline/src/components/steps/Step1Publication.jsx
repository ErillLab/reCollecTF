import { useState, useEffect } from "react";
import { useCuration } from "../../context/CurationContext";

const PROXY = "https://corsproxy.io/?";
const BASE = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils";

export default function Step1Publication() {
  const { publication, setPublication, goToNextStep } = useCuration();

  // Estat local del formulari
  const [query, setQuery] = useState("");
  const [loading, setLoading] = useState(false);
  const [article, setArticle] = useState(null);
  const [error, setError] = useState("");

  // Quan tornem enrere al pipeline, recuperem les dades guardades
  useEffect(() => {
    if (!publication) return;

    setArticle({
      ...publication,
      doi: normalizeDOI(publication.doi),
    });

    if (publication.pmid) setQuery(publication.pmid);
    else if (publication.doi) setQuery(publication.doi);
  }, [publication]);

  // Aquí fem un fetch amb alternatives, perquè els proxys públics a vegades peten (403, CORS, etc.)
  async function fetchWithFallback(url, { timeoutMs = 12000 } = {}) {
    const proxyOrder = ["direct", "allorigins", "isomorphic", "corsproxy"];
    let lastErr = null;

    for (const proxy of proxyOrder) {
      const finalUrl = proxify(url, proxy);
      const ctrl = new AbortController();
      const t = setTimeout(() => ctrl.abort(), timeoutMs);

      try {
        const res = await fetch(finalUrl, {
          method: "GET",
          signal: ctrl.signal,
          headers: { Accept: "application/json" },
        });

        clearTimeout(t);

        if (!res.ok) {
          lastErr = new Error(`HTTP ${res.status} (${proxy})`);
          continue;
        }

        const json = await res.json();
        return json;
      } catch (e) {
        clearTimeout(t);
        lastErr = e;
        continue;
      }
    }

    throw lastErr || new Error("No s'ha pogut fer la petició (tots els proxys han fallat).");
  }

  function proxify(url, proxyKind) {
    const enc = encodeURIComponent(url);

    if (proxyKind === "direct") return url;
    if (proxyKind === "allorigins") return `https://api.allorigins.win/raw?url=${enc}`;
    if (proxyKind === "isomorphic") return `https://cors.isomorphic-git.org/${url}`;
    if (proxyKind === "corsproxy") return `${PROXY}${enc}`;

    return url;
  }

  // Cerca principal: pot ser PMID, DOI o títol
  async function handleSearch(e) {
    e.preventDefault();
    setError("");
    setArticle(null);

    if (!query.trim()) return;

    setLoading(true);

    try {
      let data = null;
      const q = query.trim();
      const isPMID = /^\d+$/.test(q);
      const isDOI = q.includes("/");

      // Cerca directa per PMID
      if (isPMID) {
        const url = `${BASE}/esummary.fcgi?db=pubmed&id=${q}&retmode=json`;
        const json = await fetchWithFallback(url);
        const rec = json.result?.[q];

        if (!rec) throw new Error("PMID no trobat");

        data = {
          pmid: q,
          title: rec.title || "Title not available",
          authors: (rec.authors || []).map((a) => a.name).join(", "),
          journal: rec.fulljournalname || "Unknown",
          pubdate: rec.pubdate || "No date",
          doi: normalizeDOI(rec.elocationid),
        };
      }

      // Cerca per DOI (primer PubMed, després CrossRef)
      if (!data && isDOI) {
        const esearchUrl = `${BASE}/esearch.fcgi?db=pubmed&retmode=json&term=${encodeURIComponent(
          q
        )}[doi]`;

        const js1 = await fetchWithFallback(esearchUrl);
        const pmid = js1.esearchresult?.idlist?.[0];

        if (pmid) {
          const esumUrl = `${BASE}/esummary.fcgi?db=pubmed&id=${pmid}&retmode=json`;
          const js2 = await fetchWithFallback(esumUrl);
          const rec = js2.result?.[pmid];

          if (rec) {
            data = {
              pmid,
              title: rec.title || "Title not available",
              authors: (rec.authors || []).map((a) => a.name).join(", "),
              journal: rec.fulljournalname || "Unknown",
              pubdate: rec.pubdate || "No date",
              doi: normalizeDOI(rec.elocationid || q),
            };
          }
        }

        // Fallback a CrossRef si PubMed no retorna res
        if (!data) {
          const crUrl = `https://api.crossref.org/works/${encodeURIComponent(q)}`;
          const crJson = await fetchWithFallback(crUrl);
          const m = crJson.message;

          if (!m) throw new Error("DOI no trobat a CrossRef");

          data = {
            pmid: null,
            title: m.title?.[0] || "Title not available",
            authors: (m.author || [])
              .map((a) => `${a.family || ""} ${a.given || ""}`)
              .join(", "),
            journal: m["container-title"]?.[0] || "Unknown journal",
            pubdate: m.issued?.["date-parts"]?.[0]?.join("-") || "No date",
            doi: q,
          };
        }
      }

      // Cerca per títol (PubMed)
      if (!data && !isPMID && !isDOI) {
        const esearchUrl = `${BASE}/esearch.fcgi?db=pubmed&retmode=json&retmax=1&term=${encodeURIComponent(
          q
        )}[title]`;

        const js1 = await fetchWithFallback(esearchUrl);
        const pmid = js1.esearchresult?.idlist?.[0];

        if (!pmid) throw new Error("Cap article trobat amb aquest títol");

        const esumUrl = `${BASE}/esummary.fcgi?db=pubmed&id=${pmid}&retmode=json`;
        const js2 = await fetchWithFallback(esumUrl);
        const rec = js2.result?.[pmid];

        data = {
          pmid,
          title: rec.title || "Title not available",
          authors: (rec.authors || []).map((a) => a.name).join(", "),
          journal: rec.fulljournalname || "Unknown",
          pubdate: rec.pubdate || "No date",
          doi: normalizeDOI(rec.elocationid),
        };
      }

      if (!data) throw new Error("Sense resultats");

      setArticle(data);
    } catch (e) {
      console.error(e);
      setError("Error cercant l’article. Introdueix un PMID, un DOI o el títol.");
    } finally {
      setLoading(false);
    }
  }

  // Normalitza el DOI quan ve incrustat en altres camps
  function normalizeDOI(raw) {
    if (!raw) return "";
    const m = raw.match(/10\.\d{4,9}\/\S+/i);
    return m ? m[0] : raw;
  }

  function handleConfirm() {
    if (!article) return;
    setPublication(article);
    goToNextStep();
  }

  return (
    <div className="space-y-4">
      <h2 className="text-2xl font-bold mb-4">Step 1 – Publication</h2>

      <div className="flex gap-2">
        <input
          className="form-control"
          placeholder="PMID, DOI o títol de l’article"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
        <button className="btn" onClick={handleSearch} disabled={loading}>
          {loading ? "Cercant..." : "Cerca"}
        </button>
      </div>

      <a
        href="https://pubmed.ncbi.nlm.nih.gov/"
        target="_blank"
        rel="noopener noreferrer"
        className="inline-block text-sm text-blue-400 hover:text-blue-300 underline mt-1"
      >
        Cercar directament a PubMed
      </a>

      {error && <p className="text-red-400">{error}</p>}

      {article && (
        <div className="bg-surface border border-border rounded p-4 space-y-1">
          <h3 className="text-xl font-semibold">{article.title}</h3>
          <p><strong>Autors:</strong> {article.authors}</p>
          <p><strong>Revista:</strong> {article.journal}</p>
          <p><strong>Data:</strong> {article.pubdate}</p>
          <p><strong>PMID:</strong> {article.pmid || "—"}</p>
          <p><strong>DOI:</strong> {article.doi || "—"}</p>
          
          <div className="pt-3">
            <button className="btn" onClick={handleConfirm}>
              Confirmar i continuar →
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
