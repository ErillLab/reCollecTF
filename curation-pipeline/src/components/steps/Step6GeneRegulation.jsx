// src/components/steps/Step6GeneRegulation.jsx
import { useEffect, useMemo, useState } from "react";
import { useCuration } from "../../context/CurationContext";

function distIntervals(aStart, aEnd, bStart, bEnd) {
  return Math.max(Number(aStart), Number(bStart)) - Math.min(Number(aEnd), Number(bEnd));
}

function distGeneToSite(g, siteStart, siteEnd) {
  return distIntervals(g.start, g.end, siteStart, siteEnd);
}

function distGeneToGene(ga, gb) {
  return distIntervals(ga.start, ga.end, gb.start, gb.end);
}

export default function Step6GeneRegulation() {
  const { step4Data, step6Data, setStep6Data, goToNextStep, genomes, strainData } = useCuration();

  const expressionEnabled = !!strainData?.expressionInfo;

  const sites = step4Data?.sites || [];
  const choice = step4Data?.choice || {};
  const exactHits = step4Data?.exactHits || {};
  const fuzzyHits = step4Data?.fuzzyHits || {};

  // Ho mantenim per sessions velles, però la font bona és choice + hits
  const selectedBySite = step4Data?.selectedBySite || {};

  const [regulation, setRegulation] = useState({});
  const [activeSite, setActiveSite] = useState(null);

  useEffect(() => {
    if (step6Data) setRegulation(step6Data);
  }, [step6Data]);

  useEffect(() => {
    if (!sites.length) {
      setActiveSite(null);
      return;
    }
    setActiveSite((prev) => (prev && sites.includes(prev) ? prev : sites[0]));
  }, [sites]);

  if (!step4Data) {
    return (
      <div className="text-sm text-red-400">
        Step 4 data not found. Please complete Reported Sites first.
      </div>
    );
  }

  function getSelectedHit(site) {
    const sel = choice?.[site];
    if (!sel) return null;

    if (sel.startsWith("ex-")) {
      const idx = parseInt(sel.split("-")[1], 10);
      const hit = exactHits?.[site]?.[idx];
      return hit && hit !== "none" ? hit : null;
    }

    if (sel.startsWith("fz-")) {
      const idx = parseInt(sel.split("-")[1], 10);
      const hit = fuzzyHits?.[site]?.[idx];
      return hit && hit !== "none" ? hit : null;
    }

    return null;
  }

  // Refem el càlcul de nearby genes igual que al Step4
  function findGenesForHit(acc, hitStart1, hitEnd1) {
    const genome = (genomes || []).find((g) => g.acc === acc);
    if (!genome || !genome.genes || genome.genes.length === 0) return [];

    const genes = genome.genes;

    // Normalitzem a 0-based per fer els càlculs
    const siteStart = Math.min(Number(hitStart1), Number(hitEnd1)) - 1;
    const siteEnd = Math.max(Number(hitStart1), Number(hitEnd1)) - 1;

    const nearbyGenesRaw = [];

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

    // Overlap sempre entra
    for (const g of overlapGenes) nearbyGenesRaw.push(g);

    // Esquerra: el més proper si va a '-'
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

    // Dreta: el més proper si va a '+'
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

    // Si no hi ha res, el més proper global
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

    // Treure duplicats i adaptar al format que pinta la UI
    const seen = new Set();
    const result = [];

    for (const g of nearbyGenesRaw) {
      const locus = g?.locus || "";
      if (!locus) continue;
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

  function toggleGene(site, gene) {
    if (!expressionEnabled) return;

    setRegulation((prev) => {
      const current = prev?.[site]?.regulatedGenes || [];
      const exists = current.some((g) => g.locus === gene.locus);

      const updated = exists ? current.filter((g) => g.locus !== gene.locus) : [...current, gene];

      return {
        ...prev,
        [site]: {
          ...(prev?.[site] || {}),
          regulatedGenes: updated,
        },
      };
    });
  }

  function handleConfirm() {
    setStep6Data(regulation);
    goToNextStep();
  }

  const visibleSites = useMemo(() => {
    if (!sites.length) return [];
    if (activeSite && sites.includes(activeSite)) return [activeSite];
    return [sites[0]];
  }, [sites, activeSite]);

  return (
    <div className="space-y-6 text-sm">
      <h2 className="text-2xl font-bold">Step 6 – Gene Regulation</h2>

      {!expressionEnabled && (
        <div className="bg-surface border border-border rounded p-4 text-sm text-muted">
          Expression data was not indicated in Step 2, so gene regulation cannot be curated for this manuscript.
          You can review the nearby genes, but selection is disabled.
        </div>
      )}

      {sites.length > 0 && (
        <div className="bg-surface border border-border rounded p-3">
          <div className="text-sm font-semibold mb-2">Select a site</div>

          <div className="border border-border rounded overflow-hidden">
            {sites.map((s) => {
              const selected = activeSite === s;
              const hit = getSelectedHit(s);
              const hasHit = !!hit;

              return (
                <button
                  key={s}
                  type="button"
                  onClick={() => setActiveSite(s)}
                  className={[
                    "w-full text-left px-3 py-2 text-sm border-b last:border-b-0",
                    "hover:bg-muted",
                    selected ? "bg-accent text-black" : "hover:bg-muted text-gray-300",
                    !hasHit ? "opacity-60" : "",
                  ].join(" ")}
                  title={!hasHit ? "No selected genomic mapping in Step 4" : ""}
                >
                  {s}
                </button>
              );
            })}
          </div>
        </div>
      )}

      {visibleSites.map((site) => {
        const bundle = selectedBySite?.[site];
        const hit = getSelectedHit(site) || bundle?.hit || null;

        if (!hit) {
          return (
            <div key={site} className="bg-surface border border-border rounded p-4 text-muted">
              No genomic mapping selected for <span className="font-mono">{site}</span> in Step 4.
            </div>
          );
        }

        const genes = findGenesForHit(hit.acc, hit.start + 1, hit.end + 1);

        return (
          <div key={site} className="bg-surface border border-border rounded p-4 space-y-3">
            <div className="font-mono text-xs">
              {hit.site} {hit.strand}[{hit.start + 1},{hit.end + 1}] {hit.acc}
            </div>

            {genes.length === 0 ? (
              <div className="text-muted">No nearby genes found for this mapping.</div>
            ) : (
              <div className="space-y-2">
                {genes.map((g) => {
                  const checked = regulation?.[site]?.regulatedGenes?.some((x) => x.locus === g.locus) || false;

                  return (
                    <label
                      key={g.locus || `${g.start}-${g.end}`}
                      className={[
                        "flex items-start gap-2 cursor-pointer border border-border rounded px-3 py-2",
                        "hover:bg-muted/30",
                        !expressionEnabled ? "opacity-70 cursor-not-allowed" : "",
                      ].join(" ")}
                    >
                      <input
                        type="checkbox"
                        checked={checked}
                        disabled={!expressionEnabled}
                        onChange={() => toggleGene(site, g)}
                        className="mt-1"
                      />

                      <div className="min-w-0">
                        <div className="font-semibold">
                          {g.locus}
                          {g.geneLabel && g.geneLabel !== "—" ? ` (${g.geneLabel})` : ""}
                        </div>

                        <div className="text-xs text-muted">{g.product || "—"}</div>

                        <div className="text-xs text-muted mt-1">
                          start: {g.start} &nbsp; end: {g.end}
                          {g.strand ? `  |  strand: ${g.strand}` : ""}
                        </div>
                      </div>
                    </label>
                  );
                })}
              </div>
            )}
          </div>
        );
      })}

      <button className="btn mt-4" onClick={handleConfirm}>
        Confirm and continue →
      </button>
    </div>
  );
}
