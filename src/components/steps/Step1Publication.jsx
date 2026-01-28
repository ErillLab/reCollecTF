import { useState, useEffect } from "react";
import { useCuration } from "../../context/CurationContext";

export default function Step1Publication() {
  const { publication, setPublication, goToNextStep } = useCuration();

  const [query, setQuery] = useState(""); //input
  const [loading, setLoading] = useState(false); //si està buscant
  const [article, setArticle] = useState(null);
  const [error, setError] = useState("");

  const PROXY = "https://corsproxy.io/?";
  const BASE = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils";

  useEffect(() => { //mostra dades al anar enrere
    if (publication) {
      setArticle({
        ...publication,
        doi: normalizeDOI(publication.doi),
      });
      if (publication.pmid) setQuery(publication.pmid);
      else if (publication.doi) setQuery(publication.doi);
    }
  }, [publication]);


  //Main search function (PMID, DOI o TITLE)
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

      // SEARCH BY PMID
      if (isPMID) {
        const url = `${BASE}/esummary.fcgi?db=pubmed&id=${q}&retmode=json`;
        const res = await fetch(PROXY + encodeURIComponent(url));
        const json = await res.json();
        const rec = json.result?.[q];

        if (!rec) throw new Error("PMID not found.");

        data = {
          pmid: q,
          title: rec.title || "Title not available",
          authors: (rec.authors || []).map((a) => a.name).join(", "),
          journal: rec.fulljournalname || "Unknown",
          pubdate: rec.pubdate || "No date",
          doi: normalizeDOI(rec.elocationid),
        };
      }

      // SEARCH BY DOI (PubMed → fallback CrossRef)
      if (!data && isDOI) {
        // Try PubMed first
        const esearchUrl = `${BASE}/esearch.fcgi?db=pubmed&retmode=json&term=${encodeURIComponent(
          q
        )}[doi]`;

        const r1 = await fetch(PROXY + encodeURIComponent(esearchUrl));
        const js1 = await r1.json();
        const pmid = js1.esearchresult?.idlist?.[0];

        if (pmid) {
          const esumUrl = `${BASE}/esummary.fcgi?db=pubmed&id=${pmid}&retmode=json`;
          const r2 = await fetch(PROXY + encodeURIComponent(esumUrl));
          const js2 = await r2.json();
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

        // Fallback: CrossRef
        if (!data) {
          const crUrl = `https://api.crossref.org/works/${encodeURIComponent(
            q
          )}`;
          const crRes = await fetch(PROXY + encodeURIComponent(crUrl));
          const crJson = await crRes.json();
          const m = crJson.message;

          if (!m) throw new Error("DOI not found in CrossRef.");

          data = {
            pmid: null,
            title: m.title?.[0] || "Title not available",
            authors: (m.author || [])
              .map((a) => `${a.family || ""} ${a.given || ""}`)
              .join(", "),
            journal:
              m["container-title"]?.[0] || "Unknown journal",
            pubdate:
              m.issued?.["date-parts"]?.[0]?.join("-") || "No date",
            doi: q,
          };
        }
      }

      // SEARCH BY TITLE (PubMed)
      if (!data && !isPMID && !isDOI) {
        const esearchUrl = `${BASE}/esearch.fcgi?db=pubmed&retmode=json&retmax=1&term=${encodeURIComponent(
          q
        )}[title]`;

        const r1 = await fetch(PROXY + encodeURIComponent(esearchUrl));
        const js1 = await r1.json();
        const pmid = js1.esearchresult?.idlist?.[0];

        if (!pmid) {
          throw new Error("No PubMed articles found with this title.");
        }

        const esumUrl = `${BASE}/esummary.fcgi?db=pubmed&id=${pmid}&retmode=json`;
        const r2 = await fetch(PROXY + encodeURIComponent(esumUrl));
        const js2 = await r2.json();
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

      if (!data) throw new Error("No results found.");

      setArticle(data);
    } catch (e) {
      console.error(e);
      setError(
        "Error searching the article. Please enter a PMID, DOI or article title."
      );
    } finally {
      setLoading(false);
    }
  }

  function normalizeDOI(raw) {
    if (!raw) return "No DOI";
    const m = raw.match(/10\.\d{4,9}\/\S+/i);
    return m ? m[0] : raw;
  }

  const handleConfirm = () => {
    if (article) {
      setPublication(article);
      goToNextStep();
    }
  };

  return (
    <div className="space-y-4">
      <h2 className="text-2xl font-bold mb-4">Step 1 – Publication</h2>

      <div className="flex gap-2">
        <input
          className="form-control"
          placeholder="PMID, DOI or article title"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
        <button className="btn" onClick={handleSearch} disabled={loading}>
          {loading ? "Searching..." : "Search"}
        </button>
      </div>

      <a
        href="https://pubmed.ncbi.nlm.nih.gov/"
        target="_blank"
        rel="noopener noreferrer"
        className="inline-block text-sm text-blue-400 hover:text-blue-300 underline mt-1"
      >
        Search article directly on PubMed
      </a>

      {error && <p className="text-red-400">{error}</p>}

      {article && (
        <div className="bg-surface border border-border rounded p-4 space-y-1">
          <h3 className="text-xl font-semibold">{article.title}</h3>
          <p>
            <strong>Authors:</strong> {article.authors}
          </p>
          <p>
            <strong>Journal:</strong> {article.journal}
          </p>
          <p>
            <strong>Date:</strong> {article.pubdate}
          </p>
          <p>
            <strong>PMID:</strong> {article.pmid || "—"}
          </p>
          <p>
            <strong>DOI:</strong> {article.doi}
          </p>

          <div className="pt-3">
            <button className="btn" onClick={handleConfirm}>
              Confirm and continue →
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
