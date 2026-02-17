import { useEffect, useState } from "react";
import { runQuery } from "../../db/queryExecutor";
import { useCuration } from "../../context/CurationContext";

const ENTREZ_BASE = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils";
const UNIPROT_BASE = "https://rest.uniprot.org/uniprotkb";

// Petita limitació per no carregar NCBI a cops (1 req / ~700ms)
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
let __lastNcbiTs = 0;

async function ncbiRateLimit() {
  const now = Date.now();
  const wait = Math.max(0, 700 - (now - __lastNcbiTs));
  if (wait) await sleep(wait);
  __lastNcbiTs = Date.now();
}

async function fetchJson(url, { isNcbi = false } = {}) {
  if (isNcbi) await ncbiRateLimit();

  const r = await fetch(url, {
    method: "GET",
    headers: { Accept: "application/json" },
  });

  if (!r.ok) throw new Error(`Fetch failed ${r.status} for ${url}`);
  return await r.json();
}

// Cache en memòria (mateixa sessió) per evitar repetir crides
const taxonomyCacheByAcc = new Map();
const nuccoreCacheByAcc = new Map();

async function fetchNuccoreTaxInfo(acc) {
  if (nuccoreCacheByAcc.has(acc)) return nuccoreCacheByAcc.get(acc);

  const url1 = `${ENTREZ_BASE}/esearch.fcgi?db=nuccore&retmode=json&term=${encodeURIComponent(
    acc
  )}[accn]`;
  const j1 = await fetchJson(url1, { isNcbi: true });
  const uid = j1?.esearchresult?.idlist?.[0];
  if (!uid) return null;

  const url2 = `${ENTREZ_BASE}/esummary.fcgi?db=nuccore&id=${uid}&retmode=json`;
  const j2 = await fetchJson(url2, { isNcbi: true });
  const rec = j2?.result?.[uid];
  if (!rec) return null;

  const out = {
    taxid: rec.taxid ? String(rec.taxid) : "",
    organism: rec.organism || "",
    title: rec.title || "",
  };

  nuccoreCacheByAcc.set(acc, out);
  return out;
}

async function fetchTaxonomyLineageEx(taxid) {
  const url = `${ENTREZ_BASE}/esummary.fcgi?db=taxonomy&id=${encodeURIComponent(
    taxid
  )}&retmode=json`;
  const j = await fetchJson(url, { isNcbi: true });

  const node = j?.result?.[String(taxid)];
  if (!node) return null;

  const lineageEx = Array.isArray(node.lineageex) ? node.lineageex : [];

  const path = lineageEx.map((x) => ({
    taxid: x?.taxid ? String(x.taxid) : "",
    name: x?.scientificname || "",
    rank: x?.rank || "no rank",
  }));

  // Afegim el node final (taxid consultat) si no hi és
  const leaf = {
    taxid: String(taxid),
    name: node.scientificname || "",
    rank: node.rank || "no rank",
  };

  if (!path.length || path[path.length - 1].taxid !== leaf.taxid) path.push(leaf);

  // Neteja de duplicats i buits
  const seen = new Set();
  const cleaned = [];
  for (const n of path) {
    if (!n.taxid || seen.has(n.taxid)) continue;
    seen.add(n.taxid);
    cleaned.push(n);
  }

  // El format que guardem ja porta el parent_taxonomy_id per facilitar inserts
  return cleaned.map((n, i) => ({
    taxonomy_id: n.taxid,
    name: n.name,
    rank: n.rank,
    parent_taxonomy_id: i === 0 ? null : cleaned[i - 1].taxid,
  }));
}

async function computeTaxonomyForAcc(acc) {
  if (taxonomyCacheByAcc.has(acc)) return taxonomyCacheByAcc.get(acc);

  const info = await fetchNuccoreTaxInfo(acc);
  if (!info?.taxid) throw new Error(`No taxid for accession ${acc}`);

  const chain = await fetchTaxonomyLineageEx(info.taxid);
  if (!chain?.length) throw new Error(`No taxonomy lineage for taxid ${info.taxid}`);

  const payload = {
    accession: acc,
    organism: info.organism || "",
    title: info.title || "",
    taxid: info.taxid,
    chain,
    computedAt: new Date().toISOString(),
  };

  taxonomyCacheByAcc.set(acc, payload);
  return payload;
}

computeTaxonomyForAcc(accession).then((payload) => {
  console.log("TAXONOMY payload", accession, payload);
});


export default function Step2GenomeTF() {
  const {
    tf,
    setTf,
    genomeList,
    setGenomeList,
    uniprotList,
    setUniprotList,
    refseqList,
    setRefseqList,
    strainData,
    setStrainData,
    goToNextStep,
    taxonomyData,
    setTaxonomyData,
  } = useCuration();

  // TF
  const [searchName, setSearchName] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  const [tfRow, setTfRow] = useState(null);

  const [showCreateForm, setShowCreateForm] = useState(false);
  const [newTFName, setNewTFName] = useState("");
  const [tfDesc, setTfDesc] = useState("");

  const [families, setFamilies] = useState([]);
  const [selectedFamily, setSelectedFamily] = useState("");
  const [showNewFamilyForm, setShowNewFamilyForm] = useState(false);
  const [newFamilyName, setNewFamilyName] = useState("");
  const [newFamilyDesc, setNewFamilyDesc] = useState("");

  const [finalError, setFinalError] = useState("");

  // Genomes
  const [genomeInput, setGenomeInput] = useState("");
  const [genomeSuggestions, setGenomeSuggestions] = useState([]);
  const [genomeItems, setGenomeItems] = useState([]);

  // UniProt
  const [uniprotInput, setUniprotInput] = useState("");
  const [uniprotSuggestions, setUniprotSuggestions] = useState([]);
  const [uniProtItems, setUniProtItems] = useState([]);

  // RefSeq
  const [refseqInput, setRefseqInput] = useState("");
  const [refseqSuggestions, setRefseqSuggestions] = useState([]);
  const [refseqItems, setRefseqItems] = useState([]);

  // Dades de soca/espècie
  const [sameStrainGenome, setSameStrainGenome] = useState(false);
  const [bindingOrganism, setBindingOrganism] = useState("");

  const [sameStrainTF, setSameStrainTF] = useState(false);
  const [reportedTFOrganism, setReportedTFOrganism] = useState("");

  const [promoterInfo, setPromoterInfo] = useState(false);
  const [expressionInfo, setExpressionInfo] = useState(false);

  // Quan tornem enrere, recuperem el que hi havia al context
  useEffect(() => {
    if (tf) {
      if (tf.TF_id) {
        setTfRow(tf);
        setSearchName(tf.name);
      } else {
        setShowCreateForm(true);
        setNewTFName(tf.name || "");
        setSearchName(tf.name || "");
        setTfDesc(tf.description || "");
        setSelectedFamily(tf.family_id || "");
        setShowNewFamilyForm(tf.isNewFamily || false);
        setNewFamilyName(tf.family || "");
        setNewFamilyDesc(tf.family_description || "");
      }
    }

    if (genomeList?.length) setGenomeItems(genomeList);
    if (uniprotList?.length) setUniProtItems(uniprotList);
    if (refseqList?.length) setRefseqItems(refseqList);

    if (strainData) {
      setSameStrainGenome(strainData.sameStrainGenome || false);
      setBindingOrganism(strainData.organismTFBindingSites || "");

      setSameStrainTF(strainData.sameStrainTF || false);
      setReportedTFOrganism(strainData.organismReportedTF || "");

      setPromoterInfo(strainData.promoterInfo || false);
      setExpressionInfo(strainData.expressionInfo || false);
    }

    // Si ja hi ha genomes guardats, calculem taxonomia si encara no hi és
    if (genomeList?.length) {
      genomeList.forEach((g) => {
        const acc = g?.accession;
        if (!acc) return;

        const chain = taxonomyData?.byAccession?.[acc]?.chain;
        if (Array.isArray(chain) && chain.length) return;

        computeTaxonomyForAcc(acc)
          .then((payload) => {
            setTaxonomyData((prev) => ({
              ...(prev || {}),
              byAccession: { ...((prev && prev.byAccession) || {}), [acc]: payload },
            }));
          })
          .catch((e) => {
            console.warn("Taxonomy compute failed:", acc, e?.message || e);
          });
      });
    }
  }, []);

  // Families disponibles al selector
  useEffect(() => {
    async function loadFamilies() {
      const rows = await runQuery(`
        SELECT tf_family_id, name, description
        FROM core_tffamily ORDER BY name ASC
      `);
      setFamilies(rows);
    }
    loadFamilies();
  }, []);

  // TF autocomplete (DB)
  async function handleAutocompleteTF(val) {
    setSearchName(val);
    setTfRow(null);
    setShowCreateForm(false);

    if (!val || val.length < 1) {
      setSuggestions([]);
      return;
    }

    const rows = await runQuery(
      `
      SELECT tf.TF_id, tf.name, fam.name AS family_name
      FROM core_tf tf
      LEFT JOIN core_tffamily fam ON fam.tf_family_id = tf.family_id
      WHERE LOWER(tf.name) LIKE LOWER(? || '%')
      ORDER BY tf.name ASC
      `,
      [val]
    );
    setSuggestions(rows);
  }

  async function loadTF(name) {
    const rows = await runQuery(
      `
      SELECT tf.*, fam.name AS family_name, fam.description AS family_description
      FROM core_tf tf
      LEFT JOIN core_tffamily fam ON fam.tf_family_id = tf.family_id
      WHERE LOWER(tf.name) = LOWER(?)
      LIMIT 1
      `,
      [name]
    );

    if (rows.length) {
      setTfRow(rows[0]);
      setTf(rows[0]);
      setShowCreateForm(false);
    } else {
      setTfRow(null);
      setShowCreateForm(true);
      setNewTFName(name);
    }
  }

  function saveNewTF() {
    setFinalError("");

    if (!newTFName.trim()) {
      setFinalError("Please enter a TF name.");
      return;
    }

    let familyName = "";
    let familyId = null;

    if (showNewFamilyForm) {
      if (!newFamilyName.trim()) {
        setFinalError("Please enter the new family name.");
        return;
      }
      familyName = newFamilyName;
    } else {
      if (!selectedFamily) {
        setFinalError("Please select a family.");
        return;
      }
      const fam = families.find((f) => f.tf_family_id == selectedFamily);
      familyName = fam?.name || "";
      familyId = fam?.tf_family_id || null;
    }

    const newObj = {
      name: newTFName,
      description: tfDesc,
      family: familyName,
      family_id: familyId,
      isNew: true,
      isNewFamily: showNewFamilyForm,
      newFamilyName,
      newFamilyDesc,
    };

    setTf(newObj);
    setSearchName(newObj.name);
    setTfRow(null);
    setShowCreateForm(false);
  }

  // Genomes autocomplete (DB)
  async function handleAutocompleteGenome(val) {
    setGenomeInput(val);

    if (!val) {
      setGenomeSuggestions([]);
      return;
    }

    const rows = await runQuery(
      `
      SELECT genome_id, genome_accession, organism
      FROM core_genome
      WHERE genome_accession LIKE ? || '%'
      ORDER BY genome_accession ASC
      `,
      [val]
    );
    setGenomeSuggestions(rows);
  }

  async function addGenomeItem(accession, description, organism) {
    if (genomeItems.some((x) => x.accession === accession)) return;

    const updated = [...genomeItems, { accession, description, organism }];
    setGenomeItems(updated);
    setGenomeList(updated);

    const chain = taxonomyData?.byAccession?.[accession]?.chain;
    if (!Array.isArray(chain) || chain.length === 0) {
      computeTaxonomyForAcc(accession)
        .then((payload) => {
          setTaxonomyData((prev) => ({
            ...(prev || {}),
            byAccession: { ...((prev && prev.byAccession) || {}), [accession]: payload },
          }));
        })
        .catch((e) => {
          console.warn("Taxonomy compute failed:", accession, e?.message || e);
        });
    }
  }

  function selectGenomeSuggestion(g) {
    addGenomeItem(g.genome_accession, g.organism, g.organism);
    setGenomeSuggestions([]);
    setGenomeInput("");
  }

  // Quan l’accession no és a la DB, el validem a NCBI
  async function fetchNuccoreSummary(acc) {
    const info = await fetchNuccoreTaxInfo(acc);
    if (!info) return null;
    return { title: info.title, organism: info.organism };
  }

  // UniProt: validació bàsica i nom/descripció
  async function fetchUniprotSummary(acc) {
    try {
      const url = `${UNIPROT_BASE}/${encodeURIComponent(acc)}.json`;
      const r = await fetch(url);
      if (!r.ok) return null;
      const j = await r.json();

      const name =
        j.proteinDescription?.recommendedName?.fullName?.value ||
        j.proteinDescription?.submissionNames?.[0]?.fullName?.value ||
        "";

      return {
        title: name || j.id || acc,
        organism: j.organism?.scientificName || "",
      };
    } catch {
      return null;
    }
  }

  // RefSeq: validació per NCBI (protein DB)
  async function fetchProteinSummary(acc) {
    const url1 = `${ENTREZ_BASE}/esearch.fcgi?db=protein&retmode=json&term=${encodeURIComponent(
      acc
    )}[accn]`;
    const j1 = await fetchJson(url1, { isNcbi: true });
    const uid = j1?.esearchresult?.idlist?.[0];
    if (!uid) return null;

    const url2 = `${ENTREZ_BASE}/esummary.fcgi?db=protein&id=${uid}&retmode=json`;
    const j2 = await fetchJson(url2, { isNcbi: true });
    const rec = j2?.result?.[uid];
    return rec ? { title: rec.title } : null;
  }

  async function handleGenomeEnter() {
    const acc = genomeInput.trim();
    if (!acc) return;

    if (genomeItems.some((g) => g.accession === acc)) {
      setGenomeInput("");
      return;
    }

    const rows = await runQuery(
      `
      SELECT genome_id, genome_accession, organism
      FROM core_genome
      WHERE genome_accession = ?
      LIMIT 1
      `,
      [acc]
    );

    if (rows.length) {
      const g = rows[0];
      await addGenomeItem(g.genome_accession, g.organism, g.organism);
      setGenomeInput("");
      setGenomeSuggestions([]);
      return;
    }

    const info = await fetchNuccoreSummary(acc);
    if (!info) return;

    await addGenomeItem(acc, info.title, info.organism);
    setGenomeInput("");
    setGenomeSuggestions([]);
  }

  // UniProt autocomplete (DB)
  async function handleAutocompleteUniprot(val) {
    setUniprotInput(val);

    if (!val) {
      setUniprotSuggestions([]);
      return;
    }

    const rows = await runQuery(
      `
      SELECT TF_instance_id, uniprot_accession, refseq_accession, description
      FROM core_tfinstance
      WHERE uniprot_accession LIKE ? || '%'
      ORDER BY uniprot_accession ASC
      `,
      [val]
    );
    setUniprotSuggestions(rows);
  }

  function addUniProtItem(accession, description) {
    if (uniProtItems.some((x) => x.accession === accession)) return;

    const updated = [...uniProtItems, { accession, description }];
    setUniProtItems(updated);
    setUniprotList(updated);
  }

  function selectUniProtSuggestion(u) {
    addUniProtItem(u.uniprot_accession, u.description || "");

    if (u.refseq_accession) {
      if (!refseqItems.some((x) => x.accession === u.refseq_accession)) {
        addRefseqItem(u.refseq_accession, u.description || "");
      }
    }

    setUniprotSuggestions([]);
    setUniprotInput("");
  }

  async function handleUniprotEnter() {
    const acc = uniprotInput.trim();
    if (!acc) return;

    if (uniProtItems.some((u) => u.accession === acc)) {
      setUniprotInput("");
      return;
    }

    const rows = await runQuery(
      `
      SELECT TF_instance_id, uniprot_accession, refseq_accession, description
      FROM core_tfinstance
      WHERE uniprot_accession = ?
      LIMIT 1
      `,
      [acc]
    );

    if (rows.length) {
      const r = rows[0];
      addUniProtItem(r.uniprot_accession, r.description || "");

      if (r.refseq_accession) {
        if (!refseqItems.some((x) => x.accession === r.refseq_accession)) {
          addRefseqItem(r.refseq_accession, r.description || "");
        }
      }

      setUniprotInput("");
      setUniprotSuggestions([]);
      return;
    }

    const info = await fetchUniprotSummary(acc);
    if (!info) return;

    addUniProtItem(acc, info.title);
    setUniprotInput("");
    setUniprotSuggestions([]);
  }

  // RefSeq autocomplete (DB)
  async function handleAutocompleteRefseq(val) {
    setRefseqInput(val);

    if (!val) {
      setRefseqSuggestions([]);
      return;
    }

    const rows = await runQuery(
      `
      SELECT TF_instance_id, refseq_accession, description
      FROM core_tfinstance
      WHERE refseq_accession LIKE ? || '%'
      ORDER BY refseq_accession ASC
      `,
      [val]
    );
    setRefseqSuggestions(rows);
  }

  function addRefseqItem(accession, description) {
    if (refseqItems.some((x) => x.accession === accession)) return;

    const updated = [...refseqItems, { accession, description }];
    setRefseqItems(updated);
    setRefseqList(updated);
  }

  function selectRefseqSuggestion(r) {
    addRefseqItem(r.refseq_accession, r.description || "");
    setRefseqSuggestions([]);
    setRefseqInput("");
  }

  async function handleRefseqEnter() {
    const acc = refseqInput.trim();
    if (!acc) return;

    if (refseqItems.some((r) => r.accession === acc)) {
      setRefseqInput("");
      return;
    }

    const rows = await runQuery(
      `
      SELECT TF_instance_id, refseq_accession, description
      FROM core_tfinstance
      WHERE refseq_accession = ?
      LIMIT 1
      `,
      [acc]
    );

    if (rows.length) {
      const r = rows[0];
      addRefseqItem(r.refseq_accession, r.description || "");
      setRefseqInput("");
      setRefseqSuggestions([]);
      return;
    }

    const info = await fetchProteinSummary(acc);
    if (!info) return;

    addRefseqItem(acc, info.title);
    setRefseqInput("");
    setRefseqSuggestions([]);
  }

  function removeGenome(index) {
    const updated = genomeItems.filter((_, i) => i !== index);
    setGenomeItems(updated);
    setGenomeList(updated);
  }

  function removeUniProt(index) {
    const updated = uniProtItems.filter((_, i) => i !== index);
    setUniProtItems(updated);
    setUniprotList(updated);
  }

  function removeRefseq(index) {
    const updated = refseqItems.filter((_, i) => i !== index);
    setRefseqItems(updated);
    setRefseqList(updated);
  }

  function handleFinalConfirm() {
    setFinalError("");

    if (!tf) {
      setFinalError("You must select or create a TF before continuing.");
      return;
    }
    if (genomeItems.length === 0) {
      setFinalError("Please add at least one genome accession.");
      return;
    }
    if (uniProtItems.length === 0) {
      setFinalError("Please add at least one UniProt accession.");
      return;
    }
    if (refseqItems.length === 0) {
      setFinalError("Please add at least one RefSeq accession.");
      return;
    }
    if (!sameStrainGenome && !bindingOrganism.trim()) {
      setFinalError("Please specify the organism where TF binding sites are reported.");
      return;
    }
    if (!sameStrainTF && !reportedTFOrganism.trim()) {
      setFinalError("Please specify the organism of origin for the TF.");
      return;
    }

    const strainObj = {
      sameStrainGenome,
      organismTFBindingSites: bindingOrganism,
      sameStrainTF,
      organismReportedTF: reportedTFOrganism,
      promoterInfo,
      expressionInfo,
    };

    setGenomeList(genomeItems);
    setUniprotList(uniProtItems);
    setRefseqList(refseqItems);
    setStrainData(strainObj);

    goToNextStep();
  }

  return (
    <div className="space-y-8">
      <h2 className="text-2xl font-bold">Step 2 – Genome & TF</h2>

      {/* TF */}
      <div className="space-y-2">
        <label className="block font-medium">TF Name</label>

        <div className="flex gap-2">
          <input
            className="form-control flex-1"
            placeholder="Example: LexA"
            value={searchName}
            onChange={(e) => handleAutocompleteTF(e.target.value)}
          />

          <button
            className="btn"
            onClick={() => {
              setShowCreateForm(true);
              setTfRow(null);
              setSuggestions([]);
              setNewTFName(searchName);
            }}
          >
            + Add TF
          </button>
        </div>

        {suggestions.length > 0 && (
          <div className="border border-border rounded bg-surface p-2 mt-1">
            {suggestions.map((s) => (
              <div
                key={s.TF_id}
                className="p-1 hover:bg-muted cursor-pointer"
                onClick={() => {
                  setSearchName(s.name);
                  setSuggestions([]);
                  loadTF(s.name);
                }}
              >
                {s.name} ({s.family_name})
              </div>
            ))}
          </div>
        )}
      </div>

      {tfRow && (
        <div className="bg-surface border border-border rounded p-4 space-y-2">
          <h3 className="text-lg font-semibold text-accent">{tfRow.name}</h3>
          <p><strong>ID:</strong> {tfRow.TF_id}</p>
          <p><strong>Family:</strong> {tfRow.family_name}</p>
          <p><strong>TF Description:</strong> {tfRow.description || "—"}</p>
          <p><strong>Family Description:</strong> {tfRow.family_description || "—"}</p>
        </div>
      )}

      {showCreateForm && (
        <div className="bg-surface border border-border rounded p-4 space-y-3">
          <h3 className="text-lg font-semibold text-accent">Create New TF</h3>

          <div>
            <label className="block font-medium mb-1">TF Name</label>
            <input
              className="form-control flex-1"
              value={newTFName}
              onChange={(e) => setNewTFName(e.target.value)}
            />
          </div>

          <div>
            <label className="block font-medium mb-1">Existing Family</label>
            <div className="flex gap-2">
              <select
                className="form-control flex-1"
                value={selectedFamily}
                onChange={(e) => {
                  setSelectedFamily(e.target.value);
                  setShowNewFamilyForm(false);
                }}
              >
                <option value="">Select a family...</option>
                {families.map((f) => (
                  <option key={f.tf_family_id} value={f.tf_family_id}>
                    {f.name}
                  </option>
                ))}
              </select>

              <button
                type="button"
                className="btn"
                onClick={() => {
                  setShowNewFamilyForm(true);
                  setSelectedFamily("");
                }}
              >
                + Add TF Family
              </button>
            </div>
          </div>

          {showNewFamilyForm && (
            <>
              <div>
                <label className="block font-medium">New Family Name</label>
                <input
                  className="form-control"
                  value={newFamilyName}
                  onChange={(e) => setNewFamilyName(e.target.value)}
                />
              </div>

              <div>
                <label className="block font-medium">Family Description</label>
                <textarea
                  className="form-control"
                  value={newFamilyDesc}
                  onChange={(e) => setNewFamilyDesc(e.target.value)}
                />
              </div>
            </>
          )}

          <div>
            <label className="block font-medium">TF Description</label>
            <textarea
              className="form-control"
              value={tfDesc}
              onChange={(e) => setTfDesc(e.target.value)}
            />
          </div>

          <div className="flex gap-2">
            <button type="button" className="btn" onClick={saveNewTF}>
              Save TF
            </button>
            <button
              type="button"
              className="btn"
              onClick={() => {
                setShowCreateForm(false);
                setFinalError("");
              }}
            >
              Cancel
            </button>
          </div>
        </div>
      )}

      {/* Genome */}
      <div className="space-y-2">
        <h3 className="text-lg font-semibold">Genome NCBI accession number</h3>
        <p className="text-sm text-muted">
          Paste the NCBI GenBank genome accession for the closest species or strain.
        </p>

        <input
          className="form-control flex-1"
          value={genomeInput}
          onChange={(e) => handleAutocompleteGenome(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              e.preventDefault();
              handleGenomeEnter();
            }
          }}
          placeholder="Example: NC_000913.2"
        />

        {genomeSuggestions.length > 0 && (
          <div className="border border-border rounded bg-surface p-2 mt-1">
            {genomeSuggestions.map((g) => (
              <div
                key={g.genome_id}
                className="p-1 hover:bg-muted cursor-pointer"
                onClick={() => selectGenomeSuggestion(g)}
              >
                {g.genome_accession} — {g.organism}
              </div>
            ))}
          </div>
        )}

        {genomeItems.length > 0 && (
          <ul className="list-disc pl-6 mt-2 text-sm">
            {genomeItems.map((g, i) => (
              <li key={i} className="list-item">
                <div className="flex items-center gap-2">
                  <span>
                    <strong>{g.accession}</strong> — {g.description}
                  </span>
                  <button
                    type="button"
                    onClick={() => removeGenome(i)}
                    className="text-red-400 hover:text-red-300"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.8}
                      stroke="currentColor"
                      className="w-5 h-5"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M6 7h12M9 7V4h6v3m-8 4h10l-1 9H8l-1-9z"
                      />
                    </svg>
                  </button>
                </div>
              </li>
            ))}
          </ul>
        )}

        <label className="inline-flex items-center gap-2 text-sm mt-2">
          <input
            type="checkbox"
            checked={sameStrainGenome}
            onChange={(e) => setSameStrainGenome(e.target.checked)}
          />
          <span>This is the exact same strain as reported in the manuscript for the sites.</span>
        </label>

        {!sameStrainGenome && (
          <div className="mt-4 space-y-1">
            <label className="block font-medium text-sm text-sky-300">
              Organism TF binding sites are reported in
            </label>

            <textarea
              className="form-control"
              value={bindingOrganism}
              onChange={(e) => setBindingOrganism(e.target.value)}
              placeholder="Example: Pseudomonas putida plasmid pEST1226"
            />

            <p className="text-xs text-muted">
              Used when the reported strain differs from the genome strain.
            </p>
          </div>
        )}
      </div>

      {/* UniProt */}
      <div className="space-y-2">
        <h3 className="text-lg font-semibold">TF UniProt accession number</h3>
        <p className="text-sm text-muted">Paste the UniProt accession for the TF.</p>

        <input
          className="form-control flex-1"
          value={uniprotInput}
          onChange={(e) => handleAutocompleteUniprot(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              e.preventDefault();
              handleUniprotEnter();
            }
          }}
          placeholder="Example: Q87KN2"
        />

        {uniprotSuggestions.length > 0 && (
          <div className="border border-border rounded bg-surface p-2 mt-1">
            {uniprotSuggestions.map((u) => (
              <div
                key={u.TF_instance_id}
                className="p-1 hover:bg-muted cursor-pointer"
                onClick={() => selectUniProtSuggestion(u)}
              >
                {u.uniprot_accession} — {u.description}
              </div>
            ))}
          </div>
        )}

        {uniProtItems.length > 0 && (
          <ul className="list-disc pl-6 mt-2 text-sm">
            {uniProtItems.map((u, i) => (
              <li key={i} className="list-item">
                <div className="flex items-center gap-2">
                  <span>
                    <strong>{u.accession}</strong> — {u.description}
                  </span>

                  <button
                    type="button"
                    onClick={() => removeUniProt(i)}
                    className="text-red-400 hover:text-red-300"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.8}
                      stroke="currentColor"
                      className="w-5 h-5"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M6 7h12M9 7V4h6v3m-8 4h10l-1 9H8l-1-9z"
                      />
                    </svg>
                  </button>
                </div>
              </li>
            ))}
          </ul>
        )}
      </div>

      {/* RefSeq */}
      <div className="space-y-2">
        <h3 className="text-lg font-semibold">TF NCBI RefSeq accession</h3>
        <p className="text-sm text-muted">Enter RefSeq TF protein accession.</p>

        <input
          className="form-control flex-1"
          value={refseqInput}
          onChange={(e) => handleAutocompleteRefseq(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              e.preventDefault();
              handleRefseqEnter();
            }
          }}
          placeholder="Example: WP_000037239"
        />

        {refseqSuggestions.length > 0 && (
          <div className="border border-border rounded bg-surface p-2 mt-1">
            {refseqSuggestions.map((r) => (
              <div
                key={r.TF_instance_id}
                className="p-1 hover:bg-muted cursor-pointer"
                onClick={() => selectRefseqSuggestion(r)}
              >
                {r.refseq_accession} — {r.description}
              </div>
            ))}
          </div>
        )}

        {refseqItems.length > 0 && (
          <ul className="list-disc pl-6 mt-2 text-sm">
            {refseqItems.map((r, i) => (
              <li key={i} className="list-item">
                <div className="flex items-center gap-2">
                  <span>
                    <strong>{r.accession}</strong> — {r.description}
                  </span>

                  <button
                    type="button"
                    onClick={() => removeRefseq(i)}
                    className="text-red-400 hover:text-red-300"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.8}
                      stroke="currentColor"
                      className="w-5 h-5"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M6 7h12M9 7V4h6v3m-8 4h10l-1 9H8l-1-9z"
                      />
                    </svg>
                  </button>
                </div>
              </li>
            ))}
          </ul>
        )}

        <label className="inline-flex items-center gap-2 text-sm mt-2">
          <input
            type="checkbox"
            checked={sameStrainTF}
            onChange={(e) => setSameStrainTF(e.target.checked)}
          />
          <span>This is the exact same strain as reported in the manuscript for the TF.</span>
        </label>

        {!sameStrainTF && (
          <div className="mt-4 space-y-1">
            <label className="block font-medium text-sm text-sky-300">
              Organism of origin for reported TF
            </label>

            <textarea
              className="form-control"
              value={reportedTFOrganism}
              onChange={(e) => setReportedTFOrganism(e.target.value)}
              placeholder="Example: Pseudomonas sp. ADP"
            />

            <p className="text-xs text-muted">
              Used when reported TF strain differs from the RefSeq strain.
            </p>
          </div>
        )}
      </div>

      {/* Promoter / Expression */}
      <div className="space-y-3 text-sm">
        <label className="flex items-start gap-2">
          <input
            type="checkbox"
            checked={promoterInfo}
            onChange={(e) => {
              const checked = e.target.checked;
              setPromoterInfo(checked);
              setStrainData((prev) => ({ ...(prev || {}), promoterInfo: checked }));
            }}
          />
          <span>
            The manuscript contains promoter information.
            <br />
            <span className="text-xs text-muted">
              Sequence or structure of a TF-regulated promoter.
            </span>
          </span>
        </label>

        <label className="flex items-start gap-2">
          <input
            type="checkbox"
            checked={expressionInfo}
            onChange={(e) => {
              const checked = e.target.checked;
              setExpressionInfo(checked);
              setStrainData((prev) => ({ ...(prev || {}), expressionInfo: checked }));
            }}
          />
          <span>
            The manuscript contains expression data.
            <br />
            <span className="text-xs text-muted">
              Evidence for TF-mediated differential gene expression.
            </span>
          </span>
        </label>
      </div>

      <div className="mt-6">
        <button className="btn" onClick={handleFinalConfirm}>
          Confirm and continue →
        </button>
      </div>

      {finalError && <p className="text-red-400 text-sm mt-2">{finalError}</p>}
    </div>
  );
}
