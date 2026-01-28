// src/components/steps/Step4ReportedSites.jsx
import React, { useEffect, useMemo, useRef, useState } from "react";
import { useCuration } from "../../context/CurationContext";
import genbankParser from "genbank-parser";

// -----------------------------
// Small sequence helpers
// -----------------------------
function revComp(seq) {
  const map = { A: "T", T: "A", C: "G", G: "C" };
  return seq
    .split("")
    .reverse()
    .map((c) => map[c] || "N")
    .join("");
}

function mismatches(a, b) {
  let n = 0;
  for (let i = 0; i < a.length; i++) if (a[i] !== b[i]) n++;
  return n;
}

function buildBars(a, b) {
  return a
    .split("")
    .map((c, i) => (c === b[i] ? "|" : " "))
    .join("");
}

// -----------------------------
// Networking helpers (CORS-safe)
// -----------------------------
const NCBI = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi";

function buildNcbiUrl({ db = "nuccore", id, rettype, retmode = "text" }) {
  const u = new URL(NCBI);
  u.searchParams.set("db", db);
  u.searchParams.set("id", id);
  u.searchParams.set("rettype", rettype);
  u.searchParams.set("retmode", retmode);
  return u.toString();
}

function proxify(url, proxyKind) {
  const enc = encodeURIComponent(url);
  switch (proxyKind) {
    case "direct":
      return url;
    case "allorigins":
      return `https://api.allorigins.win/raw?url=${enc}`;
    case "isomorphic":
      return `https://cors.isomorphic-git.org/${url}`;
    case "corsproxy":
      return `https://corsproxy.io/?${enc}`;
    default:
      return url;
  }
}

async function fetchTextWithFallback(originalUrl, { timeoutMs = 12000 } = {}) {
  const proxyOrder = ["direct", "allorigins", "isomorphic", "corsproxy"];
  let lastErr = null;

  for (const proxy of proxyOrder) {
    const url = proxify(originalUrl, proxy);
    const ctrl = new AbortController();
    const t = setTimeout(() => ctrl.abort(), timeoutMs);

    try {
      const res = await fetch(url, {
        method: "GET",
        signal: ctrl.signal,
        headers: { Accept: "text/plain,*/*" },
      });

      clearTimeout(t);

      if (!res.ok) {
        lastErr = new Error(`HTTP ${res.status} (${proxy})`);
        continue;
      }

      const txt = await res.text();

      if (txt && txt.toLowerCase().includes("<html")) {
        lastErr = new Error(`Unexpected HTML response (${proxy})`);
        continue;
      }

      return txt;
    } catch (e) {
      clearTimeout(t);
      lastErr = e;
      continue;
    }
  }

  throw lastErr || new Error("Failed to download resource (all proxies failed).");
}

// -----------------------------
// MAIN COMPONENT
// -----------------------------
export default function Step4ReportedSites() {
  const { genomeList, step4Data, setStep4Data, goToNextStep, genomes, setGenomes } = useCuration();

  const [accordion, setAccordion] = useState({ a1: true, a2: true, a3: false });
  const toggleAcc = (k) => setAccordion((p) => ({ ...p, [k]: !p[k] }));

  const [siteType, setSiteType] = useState("variable");
  const [rawSites, setRawSites] = useState("");
  const [sites, setSites] = useState([]);
  const [exactHits, setExactHits] = useState({});
  const [fuzzyHits, setFuzzyHits] = useState({});
  const [choice, setChoice] = useState({});
  const [showFuzzy, setShowFuzzy] = useState(false);
  const [activeSite, setActiveSite] = useState(null);

  // still used for disabling Save while loading; not displayed to user
  const [loadingGenomes, setLoadingGenomes] = useState(false);

  const genomeCacheRef = useRef(new Map());

  const hasSaved = sites.length > 0;

  const [selectedBySite, setSelectedBySite] = useState({});

  const [fuzzyLoadingBySite, setFuzzyLoadingBySite] = useState({});

  // -----------------------------
  // RESTORE state when coming back
  // -----------------------------
  useEffect(() => {
    if (!step4Data) return;

    setSiteType(step4Data.siteType || "variable");
    setRawSites(step4Data.rawSites || "");
    setSites(step4Data.sites || []);
    setExactHits(step4Data.exactHits || {});
    setFuzzyHits(step4Data.fuzzyHits || {});
    setChoice(step4Data.choice || {});
    setShowFuzzy(step4Data.showFuzzy || false);

    const restoredSites = step4Data.sites || [];
    setActiveSite(step4Data.activeSite || restoredSites[0] || null);

    setSelectedBySite(step4Data.selectedBySite || {});
  }, [step4Data]);

  useEffect(() => {
    if (!sites?.length) {
      setActiveSite(null);
      return;
    }
    setActiveSite((prev) => (prev && sites.includes(prev) ? prev : sites[0]));
  }, [sites]);

  // -----------------------------
  // LOAD GENOMES (FASTA + GENBANK)
  // -----------------------------
  function inferStrand(feature) {
    if (feature?.strand === -1 || feature?.strand === "-" || feature?.complement === true) return "-";
    const loc = String(feature?.location || "");
    if (loc.toLowerCase().includes("complement")) return "-";
    return "+";
  }

  useEffect(() => {
    if (!genomeList || genomeList.length === 0) return;

    // If genomes already loaded for these accessions, skip reload
    const accs = genomeList.map((g) => g.accession).filter(Boolean);
    const haveAll = accs.length > 0 && accs.every((acc) => genomes?.some((x) => x.acc === acc && x.sequence && x.genes?.length));
    if (haveAll) return;

    let cancelled = false;

    async function load() {
      setLoadingGenomes(true);

      const out = [];
      for (const g of genomeList) {
        const acc = g.accession;
        if (!acc) continue;

        if (genomeCacheRef.current.has(acc)) {
          out.push({ acc, ...genomeCacheRef.current.get(acc) });
          continue;
        }

        try {
          const fastaUrl = buildNcbiUrl({ db: "nuccore", id: acc, rettype: "fasta", retmode: "text" });
          const fastaText = await fetchTextWithFallback(fastaUrl);

          const seq = fastaText
            .replace(/>.*/g, "")
            .replace(/[^ATCGatcg]/g, "")
            .toUpperCase();

          if (!seq || seq.length < 100) {
            throw new Error(`Empty/invalid FASTA for ${acc}`);
          }

          const gbUrl = buildNcbiUrl({ db: "nuccore", id: acc, rettype: "gbwithparts", retmode: "text" });
          const gbText = await fetchTextWithFallback(gbUrl);

          const parsed = genbankParser(gbText);
          const entry = parsed?.[0];
          const features = entry?.features || [];

          // Merge gene + CDS by locus_tag
          // IMPORTANT:
          // - Product ALWAYS from /product (never /function)
          // - If /gene missing, use protein_id as a fallback label
          const locusMap = new Map();

          for (const f of features) {
            if (f.type !== "gene" && f.type !== "CDS") continue;

            const locus = f.notes?.locus_tag?.[0] || "";
            if (!locus) continue;

            const geneName = f.notes?.gene?.[0] || "";
            const proteinId = f.notes?.protein_id?.[0] || "";
            const product = f.notes?.product?.[0] || "";

            const start = f.start;
            const end = f.end;
            const strand = inferStrand(f);

            const geneLabel = geneName || proteinId || "—";

            if (!locusMap.has(locus)) {
              locusMap.set(locus, {
                locus,
                gene: geneName,
                proteinId,
                geneLabel,
                product,
                start,
                end,
                strand,
                hasCDS: f.type === "CDS",
              });
            } else {
              const existing = locusMap.get(locus);

              existing.start = Math.min(existing.start, start);
              existing.end = Math.max(existing.end, end);

              if (!existing.gene && geneName) existing.gene = geneName;
              if (!existing.proteinId && proteinId) existing.proteinId = proteinId;

              // recompute label if we got better info
              existing.geneLabel = existing.gene || existing.proteinId || existing.geneLabel || "—";

              // Prefer CDS product if present
              if (f.type === "CDS" && product) {
                existing.product = product;
                existing.hasCDS = true;
              } else if (!existing.product && product) {
                existing.product = product;
              }

              if (!existing.strand && strand) existing.strand = strand;
            }
          }

          const genes = Array.from(locusMap.values()).sort((a, b) => a.start - b.start);

          const payload = { sequence: seq, genes };
          genomeCacheRef.current.set(acc, payload);

          out.push({ acc, ...payload });
        } catch (err) {
          console.error("Error loading genome:", acc, err);
          out.push({ acc, sequence: "", genes: [], error: String(err?.message || err) });
        }
      }

      if (cancelled) return;
      setGenomes(out);
      setLoadingGenomes(false);
    }

    load();

    return () => {
      cancelled = true;
    };
  }, [genomeList]);

  // -----------------------------
  // Nearby genes — MATCH Python logic (Match.set_nearby_genes)
  // -----------------------------
  function distIntervals(aStart, aEnd, bStart, bEnd) {
    // same as python: max(a.start,b.start) - min(a.end,b.end)
    return Math.max(Number(aStart), Number(bStart)) - Math.min(Number(aEnd), Number(bEnd));
  }

  function distGeneToSite(g, siteStart, siteEnd) {
    return distIntervals(g.start, g.end, siteStart, siteEnd);
  }

  function distGeneToGene(ga, gb) {
    return distIntervals(ga.start, ga.end, gb.start, gb.end);
  }

  function findGenesForHit(acc, hitStart1, hitEnd1) {
    const genome = genomes.find((g) => g.acc === acc);
    if (!genome || !genome.genes || genome.genes.length === 0) return [];

    const genes = genome.genes; // already sorted by start

    // IMPORTANT:
    // In the UI we print hit.start+1 / hit.end+1 (1-based),
    // Python stores start/end 0-based internally and prints +1.
    // So normalize incoming coords to 0-based for computations.
    const siteStart = Math.min(Number(hitStart1), Number(hitEnd1)) - 1;
    const siteEnd = Math.max(Number(hitStart1), Number(hitEnd1)) - 1;

    const nearbyGenesRaw = [];

    // Partition genes into left (< siteStart), right (> siteEnd), and overlap
    // (overlap includes "site falls inside a gene")
    let leftCount = 0;
    for (let i = 0; i < genes.length; i++) {
      if (Number(genes[i].end) < siteStart) leftCount++;
      else break;
    }

    let rightCount = 0;
    for (let i = genes.length - 1; i >= 0; i--) {
      if (Number(genes[i].start) > siteEnd) rightCount++;
      else break;
    }

    const leftGenes = genes.slice(0, leftCount);
    const rightGenes = genes.slice(genes.length - rightCount);
    const overlapGenes = genes.slice(leftCount, genes.length - rightCount);

    // 1) genes overlapping the site are ALWAYS included first
    for (const g of overlapGenes) nearbyGenesRaw.push(g);

    // 2) LEFT side: pick nearest left gene; include only if strand == '-'
    if (leftGenes.length > 0) {
      let bestIdx = 0;
      let bestDist = Infinity;
      for (let i = 0; i < leftGenes.length; i++) {
        const d = distGeneToSite(leftGenes[i], siteStart, siteEnd);
        if (d < bestDist) {
          bestDist = d;
          bestIdx = i;
        }
      }

      const nearestLeft = leftGenes[bestIdx];
      if ((nearestLeft.strand || "+") === "-") {
        nearbyGenesRaw.push(nearestLeft);

        // expand to the left while:
        // - previous gene exists
        // - same strand '-'
        // - dist between consecutive genes < 150
        let i = bestIdx;
        while (
          i > 0 &&
          (leftGenes[i - 1].strand || "+") === "-" &&
          distGeneToGene(leftGenes[i - 1], leftGenes[i]) < 150
        ) {
          nearbyGenesRaw.push(leftGenes[i - 1]);
          i -= 1;
        }
      }
    }

    // 3) RIGHT side: pick nearest right gene; include only if strand == '+'
    if (rightGenes.length > 0) {
      let bestIdx = 0;
      let bestDist = Infinity;
      for (let i = 0; i < rightGenes.length; i++) {
        const d = distGeneToSite(rightGenes[i], siteStart, siteEnd);
        if (d < bestDist) {
          bestDist = d;
          bestIdx = i;
        }
      }

      const nearestRight = rightGenes[bestIdx];
      if ((nearestRight.strand || "+") === "+") {
        nearbyGenesRaw.push(nearestRight);

        // expand to the right while:
        // - next gene exists
        // - same strand '+'
        // - dist between consecutive genes < 150
        let i = bestIdx;
        while (
          i < rightGenes.length - 1 &&
          (rightGenes[i + 1].strand || "+") === "+" &&
          distGeneToGene(rightGenes[i], rightGenes[i + 1]) < 150
        ) {
          nearbyGenesRaw.push(rightGenes[i + 1]);
          i += 1;
        }
      }
    }

    // 4) If nothing collected, add nearest gene globally
    if (nearbyGenesRaw.length === 0) {
      let best = genes[0];
      let bestDist = distGeneToSite(best, siteStart, siteEnd);
      for (let i = 1; i < genes.length; i++) {
        const d = distGeneToSite(genes[i], siteStart, siteEnd);
        if (d < bestDist) {
          bestDist = d;
          best = genes[i];
        }
      }
      nearbyGenesRaw.push(best);
    }

    // Deduplicate by locus and map to the UI shape (keep your existing fields)
    const seen = new Set();
    const result = [];
    for (const g of nearbyGenesRaw) {
      const locus = g?.locus || "";
      if (seen.has(locus)) continue;
      seen.add(locus);

      result.push({
        locus,
        geneLabel: g.geneLabel || g.gene || g.proteinId || "—",
        product: g.product || "",
        start: g.start,
        end: g.end,
        strand: g.strand || "+",
      });
    }

    result.sort((a, b) => Number(a.start) - Number(b.start));
    return result;
  }

  // -----------------------------
  // Completion rules
  // -----------------------------
  function isCompleted(site) {
    const c = choice?.[site];
    return (
      typeof c === "string" &&
      (c.startsWith("ex-") || c.startsWith("fz-") || c === "none-both")
    );
  }


  const allCompleted = useMemo(() => {
    if (!sites?.length) return false;
    return sites.every((s) => isCompleted(s));
  }, [sites, choice]);

  // -----------------------------
  // SEARCH EXACT
  // -----------------------------
  function findExact() {
    const arr = rawSites
      .split(/\r?\n/g)
      .map((s) => s.trim().toUpperCase())
      .filter(Boolean);

    setSites(arr);

    const all = {};

    arr.forEach((site) => {
      const rc = revComp(site);
      const L = site.length;
      all[site] = [];

      genomes.forEach((g) => {
        if (!g.sequence) return;
        const seq = g.sequence;

        let i = seq.indexOf(site);
        while (i !== -1) {
          all[site].push({ type: "exact", site, match: site, start: i, end: i + L - 1, acc: g.acc, strand: "+" });
          i = seq.indexOf(site, i + 1);
        }

        let j = seq.indexOf(rc);
        while (j !== -1) {
          all[site].push({ type: "exact", site, match: rc, start: j, end: j + L - 1, acc: g.acc, strand: "-" });
          j = seq.indexOf(rc, j + 1);
        }
      });

      if (all[site].length === 0) all[site] = ["none"];
    });

    setExactHits(all);

    const ch = {};
    arr.forEach((s) => (ch[s] = null));
    setChoice(ch);

    setFuzzyHits({});
    setShowFuzzy(false);
    setActiveSite(arr[0] || null);

    setAccordion((p) => ({ ...p, a2: true }));
  }

  // -----------------------------
  // SEARCH FUZZY (up to 2 mismatches)
  // -----------------------------
  function findFuzzy(site) {
    setFuzzyLoadingBySite((p) => ({ ...p, [site]: true }));

    const L = site.length;
    const rc = revComp(site);
    const found = [];

    genomes.forEach((g) => {
      if (!g.sequence) return;
      const seq = g.sequence;

      for (let i = 0; i <= seq.length - L; i++) {
        const sub = seq.slice(i, i + L);

        const mmF = mismatches(sub, site);
        if (mmF > 0 && mmF <= 2) {
          found.push({ type: "fuzzy", site, match: sub, bars: buildBars(site, sub), start: i, end: i + L - 1, acc: g.acc, strand: "+", mm: mmF });
        }

        const mmR = mismatches(sub, rc);
        if (mmR > 0 && mmR <= 2) {
          found.push({ type: "fuzzy", site, match: sub, bars: buildBars(rc, sub), start: i, end: i + L - 1, acc: g.acc, strand: "-", mm: mmR });
        }
      }
    });

    if (found.length === 0) found.push("none");

    setFuzzyHits((p) => ({ ...p, [site]: found }));
    setShowFuzzy(true);
    setAccordion((p) => ({ ...p, a3: true }));

    setFuzzyLoadingBySite((p) => ({ ...p, [site]: false }));
  }

  // -----------------------------
  // Confirm & continue
  // -----------------------------
  function handleConfirm() {
    if (!allCompleted) return;

    const genesByAcc = Object.fromEntries((genomes || []).map(g => [g.acc, g.genes || []]));

    setStep4Data({
      siteType,
      rawSites,
      sites,
      exactHits,
      fuzzyHits,
      choice,
      showFuzzy,
      activeSite,
      selectedBySite,
      genesByAcc,
    });

    goToNextStep();
  }

  const visibleSites = useMemo(() => {
    if (!sites?.length) return [];
    if (activeSite && sites.includes(activeSite)) return [activeSite];
    return [sites[0]];
  }, [sites, activeSite]);

  // -----------------------------
  // UI
  // -----------------------------
  return (
    <div className="space-y-8">
      <h2 className="text-2xl font-bold">Step 4 – Reported Sites</h2>

      {/* ACCORDION 1 — INPUT */}
      <div className="bg-surface border border-border rounded p-4">
        <button className="flex justify-between w-full font-semibold mb-3" onClick={() => toggleAcc("a1")}>
          <span></span>
          <span>{accordion.a1 ? "▲" : "▼"}</span>
        </button>

        {accordion.a1 && (
          <div className="space-y-3 text-sm">
            <div className="space-y-1">
              <label className="flex items-center gap-2">
                <input type="radio" checked={siteType === "motif"} onChange={() => setSiteType("motif")} />
                Motif-associated (new motif)
              </label>

              <label className="flex items-center gap-2">
                <input type="radio" checked={siteType === "variable"} onChange={() => setSiteType("variable")} />
                Variable motif-associated
              </label>

              <label className="flex items-center gap-2">
                <input type="radio" checked={siteType === "nonmotif"} onChange={() => setSiteType("nonmotif")} />
                Non-motif-associated
              </label>
            </div>

            <textarea
              className="form-control w-full h-40 text-sm"
              value={rawSites}
              placeholder={"AAGATTTCTTT\nAAGATTACATT"}
              onChange={(e) => setRawSites(e.target.value)}
            />

            <button className="btn" onClick={findExact} disabled={loadingGenomes || genomes.length === 0}>
              Save
            </button>

            {(loadingGenomes || genomes.length === 0) && (
              <div className="text-xs text-muted">Please wait until genomes are loaded before searching for matches.</div>
            )}
          </div>
        )}
      </div>

      {/* SELECTOR OF SITES */}
      {sites.length > 0 && (
        <div className="bg-surface border border-border rounded p-3">
          <div className="text-sm font-semibold mb-2">Select a site</div>

          <div className="border border-border rounded overflow-hidden">
            {sites.map((s) => {
              const selected = activeSite === s;
              const done = isCompleted(s);

              return (
                <button
                  key={s}
                  type="button"
                  onClick={() => setActiveSite(s)}
                  className={[
                    "w-full text-left px-3 py-2 text-sm border-b last:border-b-0 transition-colors",
                    selected ? "bg-accent text-black" : "hover:bg-muted",
                    done ? "text-emerald-300 font-semibold" : "",
                  ].join(" ")}
                >
                  {s}
                </button>
              );
            })}
          </div>

          {!allCompleted && (
            <div className="text-xs text-muted">
              ⚠️ Select one valid mapping (exact or mismatch) for every site before continuing.
            </div>
          )}
        </div>
      )}

      {/* ACCORDION 2 — EXACT MATCHES (ONLY AFTER SAVE) */}
      {hasSaved && (
        <div className="bg-surface border border-border rounded p-4">
          <button className="flex justify-between w-full font-semibold mb-3" onClick={() => toggleAcc("a2")}>
            <span>Exact site matches</span>
            <span>{accordion.a2 ? "▲" : "▼"}</span>
          </button>

          {accordion.a2 && (
            <div className="space-y-4 text-sm">
              {visibleSites.map((site) => {
                const arr = exactHits[site] || [];
                const hasNone = arr.length === 1 && arr[0] === "none";
                const hasAny = arr.some((x) => x !== "none");

                return (
                  <div key={site} className="border border-border rounded p-3 space-y-2">
                    <div className="font-semibold text-accent">{site}</div>

                    {hasNone && <div className="text-xs text-muted">No exact matches were found in the loaded genomes for this site.</div>}

                    {hasAny &&
                      arr.map((hit, i) => {
                        if (hit === "none") return null;
                        const nearby = findGenesForHit(hit.acc, hit.start + 1, hit.end + 1);

                        return (
                          <label key={i} className="flex items-start gap-2 text-xs cursor-pointer">
                            <input
                              type="radio"
                              name={`ex-${site}`}
                              className="mt-[3px]"
                              checked={choice[site] === `ex-${i}`}
                              onChange={() => {
                                const nearby = findGenesForHit(hit.acc, hit.start + 1, hit.end + 1);

                                setChoice((p) => ({ ...p, [site]: `ex-${i}` }));
                                setSelectedBySite((p) => ({
                                  ...p,
                                  [site]: {
                                    kind: "exact",
                                    hit,
                                    nearbyGenes: nearby,
                                  },
                                }));
                                setActiveSite(site);
                              }}
                            />

                            <div className="space-y-1">
                              <div className="font-mono">
                                {hit.site} {hit.strand}[{hit.start + 1},{hit.end + 1}] {hit.acc}
                              </div>

                              {nearby.length > 0 && (
                                <table className="mt-1 text-[11px]">
                                  <thead>
                                    <tr>
                                      <th className="pr-4 text-left">locus tag</th>
                                      <th className="pr-4 text-left">gene name</th>
                                      <th className="pr-4 text-left">function</th>
                                      <th className="pr-4 text-left">start</th>
                                      <th className="pr-4 text-left">end</th>
                                      <th className="pr-2 text-left">strand</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {nearby.map((g, idx) => (
                                      <tr key={idx}>
                                        <td className="pr-4">{g.locus}</td>
                                        <td className="pr-4">{g.geneLabel}</td>
                                        <td className="pr-4">{g.product || ""}</td>
                                        <td className="pr-4">{g.start}</td>
                                        <td className="pr-4">{g.end}</td>
                                        <td className="pr-2">{g.strand}</td>
                                      </tr>
                                    ))}
                                  </tbody>
                                </table>
                              )}
                            </div>
                          </label>
                        );
                      })}

                    <label className="flex items-center gap-2 text-xs cursor-pointer mt-2">
                      <input
                        type="radio"
                        name={`ex-${site}`}
                        checked={choice[site] === "none"}
                        onChange={() => {
                          setChoice((p) => ({ ...p, [site]: "none" }));
                          setAccordion((p) => ({ ...p, a2: false })); // cerrar acordeón Exact Matches
                          setActiveSite(site);
                          findFuzzy(site);
                        }}
                      />
                      <span>No valid exact match → search mismatches</span>
                    </label>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}

      {/* ACCORDION 3 — MISMATCHES */}
      {showFuzzy && (
        <div className="bg-surface border border-border rounded p-4">
          <button className="flex justify-between w-full font-semibold mb-3" onClick={() => toggleAcc("a3")}>
            <span>Inexact matches (mismatches)</span>
            <span>{accordion.a3 ? "▲" : "▼"}</span>
          </button>

          {accordion.a3 && (
            <div className="space-y-4 text-sm">
              {visibleSites.map((site) => {
                const arr = fuzzyHits[site];
                if (!arr) return null;

                const hasNone = arr.length === 1 && arr[0] === "none";

                return (
                  <div key={site} className="border border-border rounded p-3 space-y-2">
                    <div className="font-semibold text-accent">{site}</div>

                    {fuzzyLoadingBySite?.[site] && (
                      <div className="mt-2 p-3 rounded border border-border bg-muted text-sm font-semibold">
                        Searching for inexact matches, please wait...
                      </div>
                    )}

                    {hasNone && <div className="text-xs text-muted">No mismatch hits were found.</div>}

                    {!hasNone &&
                      arr.map((hit, i) => {
                        if (hit === "none") return null;
                        const nearby = findGenesForHit(hit.acc, hit.start + 1, hit.end + 1);

                        return (
                          <label key={i} className="flex items-start gap-2 text-xs cursor-pointer">
                            <input
                              type="radio"
                              name={`fz-${site}`}
                              className="mt-[3px]"
                              checked={choice[site] === `fz-${i}`}
                              onChange={() => {
                                const nearby = findGenesForHit(hit.acc, hit.start + 1, hit.end + 1);

                                setChoice((p) => ({ ...p, [site]: `fz-${i}` }));
                                setSelectedBySite((p) => ({
                                  ...p,
                                  [site]: {
                                    kind: "fuzzy",
                                    hit,
                                    nearbyGenes: nearby,
                                  },
                                }));
                                setActiveSite(site);
                              }}
                            />

                            <div className="space-y-1">
                              <div className="font-mono whitespace-pre leading-4">
                                {hit.site}
                                {"\n"}
                                {hit.bars}
                                {"\n"}
                                {hit.match} {hit.strand}[{hit.start + 1},{hit.end + 1}] {hit.acc} (mm={hit.mm})
                              </div>

                              {nearby.length > 0 && (
                                <table className="mt-1 text-[11px]">
                                  <thead>
                                    <tr>
                                      <th className="pr-4 text-left">locus tag</th>
                                      <th className="pr-4 text-left">gene name</th>
                                      <th className="pr-4 text-left">function</th>
                                      <th className="pr-4 text-left">start</th>
                                      <th className="pr-4 text-left">end</th>
                                      <th className="pr-2 text-left">strand</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {nearby.map((g, idx) => (
                                      <tr key={idx}>
                                        <td className="pr-4">{g.locus}</td>
                                        <td className="pr-4">{g.geneLabel}</td>
                                        <td className="pr-4">{g.product || ""}</td>
                                        <td className="pr-4">{g.start}</td>
                                        <td className="pr-4">{g.end}</td>
                                        <td className="pr-2">{g.strand}</td>
                                      </tr>
                                    ))}
                                  </tbody>
                                </table>
                              )}
                            </div>
                          </label>
                        );
                      })}

                    <label className="flex items-center gap-2 text-xs cursor-pointer mt-2">
                      <input
                        type="radio"
                        name={`fz-${site}`}
                        checked={choice[site] === "none-both"}
                        onChange={() => {
                          setChoice((p) => ({ ...p, [site]: "none-both" }));
                          setSelectedBySite((p) => ({
                            ...p,
                            [site]: {
                              kind: "none",
                              hit: null,
                              nearbyGenes: [],
                            },
                          }));
                          setActiveSite(site);
                        }}
                      />
                      <span>No valid mismatch match (not completed)</span>
                    </label>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}

      <button className="btn mt-6" onClick={handleConfirm} disabled={!allCompleted} title={!allCompleted ? "Complete all sites first" : ""}>
        Confirm and continue →
      </button>
    </div>
  );
}
