// src/components/steps/Step5SiteAnnotation.jsx
import React, { useEffect, useMemo, useState } from "react";
import { useCuration } from "../../context/CurationContext";

export default function Step5SiteAnnotation() {
  const { step4Data, techniques, step5Data, setStep5Data, goToNextStep } = useCuration();

  const sites = step4Data?.sites || [];
  const exactHits = step4Data?.exactHits || {};
  const fuzzyHits = step4Data?.fuzzyHits || {};
  const choice = step4Data?.choice || {};

  // annotations[site] = { selected, tfType, tfFunc, techniques: { ecoId: boolean } }
  const [annotations, setAnnotations] = useState({});

  const TF_TYPES = ["monomer", "dimer", "tetramer", "other", "not specified"];
  const TF_FUNCS = ["activator", "repressor", "dual", "not specified"];

  const [bulkTfType, setBulkTfType] = useState("monomer");
  const [bulkTfFunc, setBulkTfFunc] = useState("activator");

  // Normalize techniques from Step 3 (string or {ecoId,name})
  const techList = useMemo(() => {
    const arr = Array.isArray(techniques) ? techniques : [];
    return arr
      .map((t) => {
        const id =
          (typeof t === "string" && t) ||
          t?.ecoId ||
          t?.eco ||
          t?.EO_term ||
          t?.id ||
          t?.code ||
          t?.identifier ||
          "";

        if (!id) return null;

        const label = t?.name || t?.label || id;
        return { id, label };
      })
      .filter(Boolean);
  }, [techniques]);

  const emptyTechMap = useMemo(() => {
    const m = {};
    techList.forEach((t) => (m[t.id] = false));
    return m;
  }, [techList]);

  // Restore / init state (supports old "useTechniques" boolean)
  useEffect(() => {
    const restored = step5Data?.annotations || {};
    const next = {};

    sites.forEach((site) => {
      const prev = restored[site] || {};
      const oldUseAll = prev.useTechniques === true;
      const prevTechMap = prev.techniques || {};

      const mergedTechMap = { ...emptyTechMap };
      Object.keys(mergedTechMap).forEach((ecoId) => {
        mergedTechMap[ecoId] = oldUseAll ? true : !!prevTechMap[ecoId];
      });

      next[site] = {
        selected: !!prev.selected,
        tfType: prev.tfType || "monomer",
        tfFunc: prev.tfFunc || "activator",
        techniques: mergedTechMap,
      };
    });

    setAnnotations(next);

    if (step5Data) {
      setBulkTfType(step5Data.bulkTfType || "monomer");
      setBulkTfFunc(step5Data.bulkTfFunc || "activator");
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sites.length, techList.length]);

  function siteDisplayText(site) {
    const sel = choice[site];
    const ex = exactHits[site];
    const fz = fuzzyHits[site];

    let text = site;

    if (sel && sel.startsWith("ex-")) {
      const idx = parseInt(sel.split("-")[1], 10);
      const h = ex?.[idx];
      if (h) text = `${h.site} ${h.strand}[${h.start + 1},${h.end + 1}] ${h.acc}`;
    } else if (sel && sel.startsWith("fz-")) {
      const idx = parseInt(sel.split("-")[1], 10);
      const h = fz?.[idx];
      if (h) text = `${h.site}\n${h.bars}\n${h.match} ${h.strand}[${h.start + 1},${h.end + 1}] ${h.acc}`;
    }

    return text;
  }

  function toggleSelectAll() {
    const any = sites.some((s) => annotations[s]?.selected);
    const next = { ...annotations };
    sites.forEach((s) => {
      next[s] = { ...(next[s] || {}), selected: !any };
    });
    setAnnotations(next);
  }

  function applyTfTypeToSelected() {
    const next = { ...annotations };
    sites.forEach((s) => {
      if (!next[s]?.selected) return;
      next[s] = { ...next[s], tfType: bulkTfType };
    });
    setAnnotations(next);
  }

  function applyTfFuncToSelected() {
    const next = { ...annotations };
    sites.forEach((s) => {
      if (!next[s]?.selected) return;
      next[s] = { ...next[s], tfFunc: bulkTfFunc };
    });
    setAnnotations(next);
  }

  function applyTechniqueToSelected(ecoId) {
    const next = { ...annotations };
    sites.forEach((s) => {
      if (!next[s]?.selected) return;
      next[s] = { ...next[s], techniques: { ...(next[s].techniques || {}), [ecoId]: true } };
    });
    setAnnotations(next);
  }

  function clearTechniqueAll(ecoId) {
    const next = { ...annotations };
    sites.forEach((s) => {
      next[s] = { ...next[s], techniques: { ...(next[s].techniques || {}), [ecoId]: false } };
    });
    setAnnotations(next);
  }

  function handleConfirm() {
    setStep5Data({ annotations, bulkTfType, bulkTfFunc });
    goToNextStep();
  }

  return (
    <div className="space-y-8">
    <h2 className="text-2xl font-bold">
      Step 5 – Site annotation
    </h2>
      <div className="bg-surface border border-border rounded p-4">
        {/* Scroll container so many techniques never overlap */}
        <div className="overflow-x-auto">
          <table className="min-w-max w-full text-xs border-collapse">
            <thead>
              {/* Single header row */}
              <tr className="border-b border-border">
                <th className="text-left px-2 py-2" style={{ minWidth: 360 }}>
                  Site
                </th>
                <th className="text-left px-2 py-2" style={{ minWidth: 140 }}>
                  TF-type
                </th>
                <th className="text-left px-2 py-2" style={{ minWidth: 160 }}>
                  TF-function
                </th>

                {/* This is the group header like in your screenshot */}
                <th className="text-left px-2 py-2" colSpan={Math.max(1, techList.length)}>
                  Experimental techniques
                </th>
              </tr>
            </thead>

            <tbody>
              {/* BULK ROW: Select/Unselect all + bulk TF controls + technique headers HERE */}
              <tr className="border-b border-border bg-muted/40">
                <td className="px-2 py-2 align-top" style={{ minWidth: 360 }}>
                  <button type="button" className="text-blue-400 hover:text-blue-300 underline" onClick={toggleSelectAll}>
                    Select/Unselect all
                  </button>
                </td>

                <td className="px-2 py-2 align-top" style={{ minWidth: 140 }}>
                  <div className="flex flex-col gap-1">
                    <select className="form-control text-xs" value={bulkTfType} onChange={(e) => setBulkTfType(e.target.value)}>
                      {TF_TYPES.map((t) => (
                        <option key={t}>{t}</option>
                      ))}
                    </select>
                    <button type="button" className="text-blue-400 hover:text-blue-300 underline text-[11px]" onClick={applyTfTypeToSelected}>
                      Apply to selected
                    </button>
                  </div>
                </td>

                <td className="px-2 py-2 align-top" style={{ minWidth: 160 }}>
                  <div className="flex flex-col gap-1">
                    <select className="form-control text-xs" value={bulkTfFunc} onChange={(e) => setBulkTfFunc(e.target.value)}>
                      {TF_FUNCS.map((t) => (
                        <option key={t}>{t}</option>
                      ))}
                    </select>
                    <button type="button" className="text-blue-400 hover:text-blue-300 underline text-[11px]" onClick={applyTfFuncToSelected}>
                      Apply to selected
                    </button>
                  </div>
                </td>

                {techList.length > 0 ? (
                  techList.map((t) => (
                    <td key={t.id} className="px-2 py-2 align-top" style={{ minWidth: 190 }}>
                      <div className="font-semibold leading-4 break-words">{t.label}</div>
                      <div className="flex gap-2 text-[11px] mt-1 whitespace-nowrap">
                        <button
                          type="button"
                          className="text-blue-400 hover:text-blue-300 underline"
                          onClick={() => applyTechniqueToSelected(t.id)}
                        >
                          Apply to selected
                        </button>
                        <button
                          type="button"
                          className="text-blue-400 hover:text-blue-300 underline"
                          onClick={() => clearTechniqueAll(t.id)}
                        >
                          Clear all
                        </button>
                      </div>
                    </td>
                  ))
                ) : (
                  <td className="px-2 py-2 text-muted">—</td>
                )}
              </tr>

              {/* SITE ROWS */}
              {sites.map((site) => {
                const ann = annotations[site] || {
                  selected: false,
                  tfType: "monomer",
                  tfFunc: "activator",
                  techniques: { ...emptyTechMap },
                };

                return (
                  <tr key={site} className="border-b border-border">
                    <td className="px-2 py-2 align-top" style={{ minWidth: 360 }}>
                      <label className="flex gap-2 cursor-pointer">
                        <input
                          type="checkbox"
                          checked={!!ann.selected}
                          onChange={() =>
                            setAnnotations((p) => ({
                              ...p,
                              [site]: { ...ann, selected: !ann.selected },
                            }))
                          }
                        />
                        <span className="font-mono text-[11px] whitespace-pre-wrap">{siteDisplayText(site)}</span>
                      </label>
                    </td>

                    <td className="px-2 py-2 align-top" style={{ minWidth: 140 }}>
                      <select
                        className="form-control text-xs"
                        value={ann.tfType}
                        onChange={(e) =>
                          setAnnotations((p) => ({
                            ...p,
                            [site]: { ...ann, tfType: e.target.value },
                          }))
                        }
                      >
                        {TF_TYPES.map((t) => (
                          <option key={t}>{t}</option>
                        ))}
                      </select>
                    </td>

                    <td className="px-2 py-2 align-top" style={{ minWidth: 160 }}>
                      <select
                        className="form-control text-xs"
                        value={ann.tfFunc}
                        onChange={(e) =>
                          setAnnotations((p) => ({
                            ...p,
                            [site]: { ...ann, tfFunc: e.target.value },
                          }))
                        }
                      >
                        {TF_FUNCS.map((t) => (
                          <option key={t}>{t}</option>
                        ))}
                      </select>
                    </td>

                    {techList.length > 0 ? (
                      techList.map((t) => (
                        <td key={t.id} className="px-2 py-2 align-top text-center" style={{ minWidth: 190 }}>
                          <input
                            type="checkbox"
                            checked={!!ann.techniques?.[t.id]}
                            onChange={(e) =>
                              setAnnotations((p) => ({
                                ...p,
                                [site]: {
                                  ...ann,
                                  techniques: { ...(ann.techniques || {}), [t.id]: e.target.checked },
                                },
                              }))
                            }
                          />
                        </td>
                      ))
                    ) : (
                      <td className="px-2 py-2 text-muted">—</td>
                    )}
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      <button className="btn mt-6" onClick={handleConfirm}>
        Confirm and continue →
      </button>
    </div>
  );
}
