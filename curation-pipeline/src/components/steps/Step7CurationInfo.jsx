// src/components/steps/Step7CurationInfo.jsx
import { useMemo, useState } from "react";
import { useCuration } from "../../context/CurationContext";
import { dispatchWorkflow } from "../../utils/serverless";

function esc(str) {
  return String(str ?? "").replace(/'/g, "''");
}

function truthyBool(v) {
  return v ? 1 : 0;
}

function pickFirstNonEmpty(...vals) {
  for (const v of vals) {
    if (v === 0) return 0;
    if (v === false) return false;
    if (v === null || v === undefined) continue;
    const s = String(v).trim();
    if (s) return s;
  }
  return "";
}

function normalizeStrand(str) {
  if (str === "-" || str === -1) return -1;
  return 1;
}

function doiToUrl(doiRaw) {
  const doi = String(doiRaw || "").trim();
  if (!doi) return "";
  if (doi.toLowerCase().startsWith("http")) return doi;
  return `https://doi.org/${doi}`;
}

function firstAcc(list) {
  const x = Array.isArray(list) ? list[0] : null;
  if (!x) return "";
  if (typeof x === "string") return x.trim();
  return String(x.accession || "").trim();
}

function firstDesc(list) {
  const x = Array.isArray(list) ? list[0] : null;
  if (!x) return "";
  if (typeof x === "string") return "";
  return String(x.description || "").trim();
}

function getStep5ForSite(step5Data, site) {
  return step5Data?.annotations?.[site] || null;
}

export default function Step7CurationInfo() {
  const {
    publication,
    tf,
    genomeList,
    uniprotList,
    refseqList,
    strainData,
    techniques,
    step4Data,
    step5Data,
    step6Data,
    setStep7Data,
    taxonomyData,
  } = useCuration();

  const REVISION_REASONS = useMemo(
    () => [
      { value: "None", label: "None" },
      { value: "No comparable genome in NCBI", label: "No comparable genome in NCBI" },
      { value: "Matching genome still in progress", label: "Matching genome still in progress" },
      { value: "No comparable TF protein sequence in NCBI", label: "No comparable TF protein sequence in NCBI" },
      { value: "Other reason (specify in notes)", label: "Other reason (specify in notes)" },
    ],
    []
  );

  const [revisionReason, setRevisionReason] = useState("None");
  const [curationComplete, setCurationComplete] = useState(true);
  const [notes, setNotes] = useState("");

  const [loading, setLoading] = useState(false);
  const [msg, setMsg] = useState("");

  const canSubmit = useMemo(() => {
    return !!publication && !!tf?.name && !!step4Data && !loading;
  }, [publication, tf, step4Data, loading]);

  function buildFullSql() {
    if (!publication) throw new Error("Missing publication (Step 1).");
    if (!tf?.name) throw new Error("Missing TF name (Step 2).");
    if (!step4Data?.sites?.length) throw new Error("Missing sites (Step 4).");

    const pub = publication;

    const pubTitle = pickFirstNonEmpty(pub?.title, "");
    const pubAuthors = pickFirstNonEmpty(pub?.authors, "");
    const pubJournal = pickFirstNonEmpty(pub?.journal, "");
    const pubDate = pickFirstNonEmpty(pub?.pubdate, pub?.publication_date, "");
    const pmid = pickFirstNonEmpty(pub?.pmid, "");
    const doi = pickFirstNonEmpty(pub?.doi, "");
    const url = pickFirstNonEmpty(doiToUrl(doi), pub?.url, "");

    const pubKeyWhere = pmid
      ? `pmid='${esc(pmid)}'`
      : url
        ? `url='${esc(url)}'`
        : `title='${esc(pubTitle)}' AND journal='${esc(pubJournal)}' AND publication_date='${esc(pubDate)}'`;

    const tfName = String(tf.name).trim();

    // Families
    const rawFamilyId = tf?.family_id ?? tf?.familyId ?? tf?.familyID ?? null;
    const familyIdNum = Number(rawFamilyId);
    const hasFamilyId = Number.isFinite(familyIdNum) && familyIdNum > 0;

    const familyName = pickFirstNonEmpty(tf?.familyName, tf?.family_name, tf?.family, `AutoFamily:${tfName}`);
    const familyDesc = pickFirstNonEmpty(tf?.family_description, tf?.newFamilyDesc, "", "");
    const tfDesc = pickFirstNonEmpty(tf?.description, "", "");

    const uniAcc = pickFirstNonEmpty(firstAcc(uniprotList), tf?.uniprot_accession, tf?.uniprot, "");
    const refAcc = pickFirstNonEmpty(firstAcc(refseqList), tf?.refseq_accession, tf?.refseq, "");
    const tfInstanceDesc = pickFirstNonEmpty(firstDesc(uniprotList), firstDesc(refseqList), tfDesc, tfName, "—");
    const tfInstanceNotes = "";

    if (!uniAcc) throw new Error("Missing UniProt accession (Step 2).");
    if (!refAcc) throw new Error("Missing RefSeq accession (Step 2).");

    // Espècies tal com surt a Step2
    const siteSpecies = pickFirstNonEmpty(
      strainData?.organismTFBindingSites,
      (genomeList?.[0] && (genomeList[0].organism || genomeList[0].description)) || "",
      ""
    );

    const tfSpecies = pickFirstNonEmpty(strainData?.organismReportedTF, siteSpecies, "");
    const containsPromoter = truthyBool(strainData?.promoterInfo);
    const containsExpression = truthyBool(strainData?.expressionInfo);

    const requiresRevision = revisionReason !== "None";
    const submissionNotes = [requiresRevision ? `Revision reason: ${revisionReason}` : "", notes]
      .filter(Boolean)
      .join("\n");

    const selectedBySite = step4Data?.selectedBySite || {};
    const siteType = pickFirstNonEmpty(step4Data?.siteType, "");

    const sql = [];
    sql.push("PRAGMA foreign_keys = ON;");
    sql.push("BEGIN TRANSACTION;");

    // Publication (upsert)
    sql.push(
      `
INSERT INTO core_publication
  (publication_type, pmid, authors, title, journal, publication_date, url,
   contains_promoter_data, contains_expression_data, submission_notes, curation_complete,
   reported_TF, reported_species)
SELECT
  'ARTICLE',
  ${pmid ? `'${esc(pmid)}'` : "NULL"},
  '${esc(pubAuthors)}',
  '${esc(pubTitle)}',
  '${esc(pubJournal)}',
  '${esc(pubDate)}',
  ${url ? `'${esc(url)}'` : "NULL"},
  ${containsPromoter},
  ${containsExpression},
  ${submissionNotes ? `'${esc(submissionNotes)}'` : "NULL"},
  ${truthyBool(curationComplete)},
  '${esc(tfName)}',
  '${esc(siteSpecies)}'
WHERE NOT EXISTS (
  SELECT 1 FROM core_publication WHERE ${pubKeyWhere}
);
      `.trim()
    );

    sql.push(
      `
UPDATE core_publication
SET
  authors = CASE WHEN authors IS NULL OR authors='' THEN '${esc(pubAuthors)}' ELSE authors END,
  title = CASE WHEN title IS NULL OR title='' THEN '${esc(pubTitle)}' ELSE title END,
  journal = CASE WHEN journal IS NULL OR journal='' THEN '${esc(pubJournal)}' ELSE journal END,
  publication_date = CASE WHEN publication_date IS NULL OR publication_date='' THEN '${esc(pubDate)}' ELSE publication_date END,
  url = CASE WHEN url IS NULL OR url='' THEN ${url ? `'${esc(url)}'` : "url"} ELSE url END,
  reported_TF = CASE WHEN reported_TF IS NULL OR reported_TF='' THEN '${esc(tfName)}' ELSE reported_TF END,
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN '${esc(siteSpecies)}' ELSE reported_species END,
  contains_promoter_data = ${containsPromoter},
  contains_expression_data = ${containsExpression},
  curation_complete = ${truthyBool(curationComplete)},
  submission_notes = CASE
    WHEN submission_notes IS NULL OR submission_notes='' THEN ${submissionNotes ? `'${esc(submissionNotes)}'` : "submission_notes"}
    ELSE submission_notes
  END
WHERE ${pubKeyWhere};
      `.trim()
    );

    const publicationIdExpr = `(SELECT publication_id FROM core_publication WHERE ${pubKeyWhere} LIMIT 1)`;

    // TF family + TF
    if (!hasFamilyId) {
      sql.push(
        `
INSERT INTO core_tffamily (name, description)
SELECT '${esc(familyName)}', '${esc(familyDesc)}'
WHERE NOT EXISTS (
  SELECT 1 FROM core_tffamily WHERE lower(name)=lower('${esc(familyName)}')
);
        `.trim()
      );
    }

    const familyIdExpr = hasFamilyId
      ? `${familyIdNum}`
      : `(SELECT tf_family_id FROM core_tffamily WHERE lower(name)=lower('${esc(familyName)}') LIMIT 1)`;

    sql.push(
      `
INSERT INTO core_tf (name, family_id, description)
SELECT '${esc(tfName)}', ${familyIdExpr}, '${esc(tfDesc)}'
WHERE NOT EXISTS (
  SELECT 1 FROM core_tf WHERE lower(name)=lower('${esc(tfName)}')
);
      `.trim()
    );

    sql.push(
      `
UPDATE core_tf
SET
  family_id = COALESCE(family_id, ${familyIdExpr}),
  description = CASE WHEN description IS NULL THEN '${esc(tfDesc)}' ELSE description END
WHERE lower(name)=lower('${esc(tfName)}');
      `.trim()
    );

    const tfIdExpr = `(SELECT TF_id FROM core_tf WHERE lower(name)=lower('${esc(tfName)}') LIMIT 1)`;
    const forceTfOverride = !!tf?.isNew;

    // TF instance
    sql.push(
      `
INSERT INTO core_tfinstance (refseq_accession, uniprot_accession, description, TF_id, notes)
SELECT
  '${esc(refAcc)}',
  '${esc(uniAcc)}',
  '${esc(tfInstanceDesc)}',
  ${tfIdExpr},
  '${esc(tfInstanceNotes)}'
WHERE NOT EXISTS (
  SELECT 1 FROM core_tfinstance WHERE uniprot_accession='${esc(uniAcc)}'
);
      `.trim()
    );

    sql.push(
      `
UPDATE core_tfinstance
SET
  TF_id = ${forceTfOverride ? `${tfIdExpr}` : `COALESCE(TF_id, ${tfIdExpr})`},
  refseq_accession = COALESCE(NULLIF(refseq_accession,''), '${esc(refAcc)}'),
  description = ${forceTfOverride ? `'${esc(tfInstanceDesc)}'` : `COALESCE(NULLIF(description,''), '${esc(tfInstanceDesc)}')`},
  notes = COALESCE(notes, '')
WHERE uniprot_accession='${esc(uniAcc)}';
      `.trim()
    );

    const tfInstanceIdExpr = `(SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='${esc(
      uniAcc
    )}' LIMIT 1)`;

    // Curation
    const curatorIdExpr = `(SELECT curator_id FROM core_curator ORDER BY curator_id LIMIT 1)`;
    const curationNotes = pickFirstNonEmpty(submissionNotes, "");

    sql.push(
      `
INSERT INTO core_curation
  (TF_species, site_species, experimental_process, forms_complex,
   complex_notes, notes, last_modified, curator_id, publication_id, created, validated_by_id)
VALUES
  ('${esc(tfSpecies)}', '${esc(siteSpecies)}', NULL,
   0, NULL, '${esc(curationNotes)}',
   datetime('now'), ${curatorIdExpr}, ${publicationIdExpr}, datetime('now'), NULL);
      `.trim()
    );

    const curationIdExpr = `(SELECT curation_id FROM core_curation WHERE publication_id=${publicationIdExpr} ORDER BY curation_id DESC LIMIT 1)`;

    sql.push(
      `
INSERT INTO core_curation_TF_instances (curation_id, tfinstance_id)
SELECT ${curationIdExpr}, ${tfInstanceIdExpr}
WHERE NOT EXISTS (
  SELECT 1 FROM core_curation_TF_instances
  WHERE curation_id=${curationIdExpr} AND tfinstance_id=${tfInstanceIdExpr}
);
      `.trim()
    );

    // Genomes + genes
    const accessions = (genomeList || []).map((g) => g.accession).filter(Boolean);

    for (const acc of accessions) {
      sql.push(
        `
INSERT INTO core_genome (genome_accession, organism)
SELECT '${esc(acc)}', '${esc(siteSpecies)}'
WHERE NOT EXISTS (
  SELECT 1 FROM core_genome WHERE genome_accession='${esc(acc)}'
);
        `.trim()
      );
    }

    const genesByAcc = step4Data?.genesByAcc || null;
    if (genesByAcc) {
      for (const [acc, genes] of Object.entries(genesByAcc)) {
        if (!Array.isArray(genes) || genes.length === 0) continue;

        const genomeIdExpr = `(SELECT genome_id FROM core_genome WHERE genome_accession='${esc(acc)}' LIMIT 1)`;

        for (const g of genes) {
          const locus = pickFirstNonEmpty(g?.locus, "");
          if (!locus) continue;

          const geneName = pickFirstNonEmpty(g?.geneLabel, g?.gene, "—");
          const desc = pickFirstNonEmpty(g?.product, "—");
          const start = Number(g?.start ?? 0);
          const end = Number(g?.end ?? 0);
          const strand = normalizeStrand(g?.strand);

          sql.push(
            `
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  ${genomeIdExpr},
  '${esc(geneName)}',
  '${esc(desc)}',
  ${Number.isFinite(start) ? start : 0},
  ${Number.isFinite(end) ? end : 0},
  ${strand},
  '${esc(locus)}',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=${genomeIdExpr} AND locus_tag='${esc(locus)}'
);
            `.trim()
          );
        }
      }
    }

    // Taxonomia + link a genome
    const taxByAcc = taxonomyData?.byAccession || {};

    for (const acc of accessions) {
      const tInfo = taxByAcc?.[acc];
      const chain = Array.isArray(tInfo?.chain) ? tInfo.chain : [];
      if (!chain.length) continue;

      for (let i = 0; i < chain.length; i++) {
        const node = chain[i];
        const taxid = String(node.taxonomy_id || "").trim();
        const name = String(node.name || "").trim();
        const rank = String(node.rank || "no rank").trim();
        if (!taxid) continue;

        const parentTaxid = i > 0 ? String(chain[i - 1].taxonomy_id || "").trim() : "";
        const parentIdExpr = parentTaxid
          ? `(SELECT id FROM core_taxonomy WHERE taxonomy_id='${esc(parentTaxid)}' LIMIT 1)`
          : "NULL";

        sql.push(`
INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '${esc(taxid)}',
  ${rank ? `'${esc(rank)}'` : "NULL"},
  ${name ? `'${esc(name)}'` : "NULL"},
  ${parentIdExpr}
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='${esc(taxid)}'
);
    `.trim());

        sql.push(`
UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), ${rank ? `'${esc(rank)}'` : "rank"}),
  name = COALESCE(NULLIF(name,''), ${name ? `'${esc(name)}'` : "name"}),
  parent_id = COALESCE(parent_id, ${parentIdExpr})
WHERE taxonomy_id='${esc(taxid)}';
    `.trim());
      }

      const leafTaxid = String(chain[chain.length - 1]?.taxonomy_id || "").trim();
      if (leafTaxid) {
        sql.push(`
UPDATE core_genome
SET taxonomy_id = (
  SELECT id FROM core_taxonomy WHERE taxonomy_id='${esc(leafTaxid)}' LIMIT 1
)
WHERE genome_accession='${esc(acc)}';
    `.trim());
      }
    }


    // Tècniques
    const techList = Array.isArray(techniques) ? techniques : [];

    for (const t of techList) {
      const EO = pickFirstNonEmpty(t?.ecoId, t?.eco, t?.EO_term, t?.id, t?.code, "");
      if (!EO) continue;

      const preset = pickFirstNonEmpty(t?.presetFunction, t?.preset_function, "");
      const name = pickFirstNonEmpty(t?.name, EO);
      const desc = pickFirstNonEmpty(t?.description, t?.name, "—");

      sql.push(
        `
INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT '${esc(name)}', '${esc(desc)}', ${preset ? `'${esc(preset)}'` : "NULL"}, '${esc(EO)}'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='${esc(EO)}'
);
        `.trim()
      );
    }

    // Sites + mappings + regulation
    const sitesList = step4Data.sites || [];

    for (const site of sitesList) {
      const bundle = selectedBySite?.[site] || { kind: "none", hit: null, nearbyGenes: [] };
      const s5 = getStep5ForSite(step5Data, site);

      const TF_type = pickFirstNonEmpty(s5?.tfType, "not specified");
      const TF_function = pickFirstNonEmpty(s5?.tfFunc, "not specified");
      const annotatedSeq = pickFirstNonEmpty(s5?.annotated_seq, s5?.annotatedSeq, site);
      const qv = s5?.quantitative_value ?? s5?.qval ?? s5?.qValue ?? null;
      const qvNum = Number(qv);
      const quantitativeValue = Number.isFinite(qvNum) ? qvNum : null;

      if (!bundle || bundle.kind === "none" || !bundle.hit) {
        sql.push(
          `
INSERT INTO core_notannotatedsiteinstance (sequence, curation_id, TF_type, TF_function)
VALUES ('${esc(site)}', ${curationIdExpr},
        ${TF_type ? `'${esc(TF_type)}'` : "NULL"},
        ${TF_function ? `'${esc(TF_function)}'` : "NULL"});
          `.trim()
        );
        continue;
      }

      const hit = bundle.hit;
      const acc = hit.acc;
      const hitStart0 = Number(hit.start ?? 0);
      const hitEnd0 = Number(hit.end ?? 0);
      const strand = normalizeStrand(hit.strand);

      const genomeIdExpr = `(SELECT genome_id FROM core_genome WHERE genome_accession='${esc(acc)}' LIMIT 1)`;

      sql.push(
        `
INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  '${esc(site)}',
  ${genomeIdExpr},
  ${hitStart0},
  ${hitEnd0},
  ${strand}
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=${genomeIdExpr}
    AND start=${hitStart0} AND end=${hitEnd0} AND strand=${strand}
    AND _seq='${esc(site)}'
);
        `.trim()
      );

      const siteInstanceIdExpr = `(SELECT site_id FROM core_siteinstance
        WHERE genome_id=${genomeIdExpr}
          AND start=${hitStart0} AND end=${hitEnd0} AND strand=${strand}
          AND _seq='${esc(site)}'
        ORDER BY site_id DESC LIMIT 1)`;

      sql.push(
        `
INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  (${curationIdExpr},
   ${siteInstanceIdExpr},
   '${esc(annotatedSeq)}',
   ${quantitativeValue === null ? "NULL" : quantitativeValue},
   ${siteType ? `'${esc(siteType)}'` : "NULL"},
   '${esc(TF_function)}',
   '${esc(TF_type)}');
        `.trim()
      );

      const curationSiteInstanceIdExpr = `(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=${curationIdExpr}
          AND site_instance_id=${siteInstanceIdExpr}
        ORDER BY id DESC LIMIT 1)`;

      const techMap = s5?.techniques || {};
      const selectedECOs = Object.keys(techMap).filter((eco) => techMap[eco] === true);

      for (const eco of selectedECOs) {
        const techIdExpr = `(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='${esc(eco)}'
          LIMIT 1)`;

        sql.push(
          `
INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT ${curationSiteInstanceIdExpr}, ${techIdExpr}
WHERE ${techIdExpr} IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=${curationSiteInstanceIdExpr}
      AND experimentaltechnique_id=${techIdExpr}
  );
          `.trim()
        );
      }

      const regsForSite = step6Data?.[site]?.regulatedGenes || [];
      if (Array.isArray(regsForSite) && regsForSite.length > 0) {
        for (const g of regsForSite) {
          const locus = pickFirstNonEmpty(g?.locus, "");
          if (!locus) continue;

          const geneIdExpr = `(SELECT gene_id FROM core_gene
            WHERE locus_tag='${esc(locus)}' AND genome_id=${genomeIdExpr}
            ORDER BY gene_id DESC LIMIT 1)`;

          const evidenceType = containsExpression ? "exp_verified" : "inferred";

          sql.push(
            `
INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  ${curationSiteInstanceIdExpr},
  ${geneIdExpr},
  '${esc(evidenceType)}',
  NULL
WHERE ${geneIdExpr} IS NOT NULL;
            `.trim()
          );
        }
      }
    }

    sql.push("COMMIT;");
    return sql.join("\n\n");
  }

  async function handleSubmit() {
    setMsg("");
    setLoading(true);

    try {
      const sqlString = buildFullSql();

      await dispatchWorkflow({
        inputs: { queries: sqlString },
      });

      setStep7Data({
        revisionReason,
        curationComplete,
        notes,
        submittedAt: new Date().toISOString(),
      });

      setMsg("✅ Submit OK: inserts/updates executed successfully.");
    } catch (e) {
      console.error("Submit error full:", e);
      console.error("Submit error payload:", e?.payload);

      const details =
        typeof e?.payload === "string"
          ? e.payload
          : e?.payload
            ? JSON.stringify(e.payload, null, 2)
            : "";

      setMsg(`Error: ${e?.message || String(e)}\n\n${details}`);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Step 7 – Curation information</h2>

      <div className="bg-surface border border-border rounded p-4 space-y-3">
        <div>
          <label className="block font-medium mb-1">Revision required</label>
          <select className="form-control" value={revisionReason} onChange={(e) => setRevisionReason(e.target.value)}>
            {REVISION_REASONS.map((r) => (
              <option key={r.value} value={r.value}>
                {r.label}
              </option>
            ))}
          </select>
          <p className="text-xs text-muted mt-1">
            Select, if needed, the reason why this curation may require revision.
          </p>
        </div>

        <label className="inline-flex items-start gap-2 text-sm">
          <input type="checkbox" checked={curationComplete} onChange={(e) => setCurationComplete(e.target.checked)} />
          <span>
            <div className="font-medium">Curation for this paper is complete</div>
            <div className="text-xs text-muted">Check if there are no more curations pending for this paper.</div>
          </span>
        </label>

        <div>
          <label className="block font-medium mb-1">Notes</label>
          <textarea
            className="form-control w-full h-40"
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            placeholder="Any additional notes on the curation process..."
          />
          <p className="text-xs text-muted mt-1">
            Include any relevant notes (e.g., why sites were left out, surrogate genome choice, etc.).
          </p>
        </div>
      </div>

      <div className="flex items-center gap-3">
        <button
          className="btn"
          onClick={handleSubmit}
          disabled={!canSubmit}
          title={!canSubmit ? "Need Step1 + Step2 TF + Step4 completed." : ""}
        >
          {loading ? "Submitting..." : "Submit curation"}
        </button>
      </div>

      {msg && <div className={`text-sm ${msg.startsWith("✅") ? "text-green-400" : "text-red-400"}`}>{msg}</div>}
    </div>
  );
}
