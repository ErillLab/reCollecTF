// generateHTMLFromCurationData.js

import { buildHTMLFromData } from "../src/components/uniprot-tf-queries/generateExpressionHTML";
import { getMaxCurationId } from "../src/db/queries/uniprotQueries";
import { getSearchResult } from "../src/db/queries/search";
import { getTfInstanceFromUniAcc } from "../src/db/queries/uniprotQueries";

export async function generateHTMLFromCurationContext({
  tf,
  uniprotList,
  strainData,
  publication,
  techniques,
  genomeList,
  step4Data,
  step5Data,
  step6Data,
}) {


  // --- helpers (mismos que Step7) ---
  function pickFirstNonEmpty(...vals) {
    for (const v of vals) {
      if (v === 0) return 0;
      if (v === null || v === undefined) continue;
      const s = String(v).trim();
      if (s) return s;
    }
    return "";
  }

  function firstAcc(list) {
    const x = Array.isArray(list) ? list[0] : null;
    if (!x) return "";
    if (typeof x === "string") return x.trim();
    return String(x.accession || "").trim();
  }

  function normalizeStrand(str) {
    if (str === "-" || str === -1 || str === "-1") return -1;
    return 1;
  }

  const uniAcc = pickFirstNonEmpty(firstAcc(uniprotList), tf?.uniprot_accession, "");
  const species = pickFirstNonEmpty(
    strainData?.organismTFBindingSites,
    genomeList?.[0]?.organism,
    genomeList?.[0]?.description,
    ""
  );

  const dataSV = [
    {
      name: tf?.name || "",
      accession: uniAcc,
      species,
    },
  ];

  const pmid = pickFirstNonEmpty(publication?.pmid, "");
  const containsExpression = !!(strainData?.expressionInfo);
  const sitesList = step4Data?.sites || [];
  const selectedBySite = step4Data?.selectedBySite || {};
  const techList = Array.isArray(techniques) ? techniques : [];

  const tf_instance_id = await getTfInstanceFromUniAcc(uniAcc);

  console.log(tf_instance_id);

  let result = [];

  let resultFromDB = [];

  if (tf_instance_id != null) {
    if (tf_instance_id != null) {
      const raw = await getSearchResult(tf_instance_id) || [];
      resultFromDB = raw.map(row => ({
        ...row,
        start: Number(row.start),
        end: Number(row.end),
        strand: String(row.strand),
      }));
    }
  }

  result = [...resultFromDB];

  for (const site of sitesList) {
    const bundle = selectedBySite?.[site];
    const s5 = step5Data?.annotations?.[site] || {};
    const regsForSite = step6Data?.[site]?.regulatedGenes || [];

    if (!bundle || bundle.kind === "none" || !bundle.hit) continue;

    const hit = bundle.hit;
    const TF_type = pickFirstNonEmpty(s5?.tfType, "not specified");
    const TF_function = pickFirstNonEmpty(s5?.tfFunc, "not specified");
    const annotated_seq = pickFirstNonEmpty(s5?.annotated_seq, s5?.annotatedSeq, site);
    const start = Number(hit.start ?? 0);
    const end = Number(hit.end ?? 0);
    const strand = String(normalizeStrand(hit.strand));
    const genome_accession = hit.acc;
    const evidence_type = containsExpression ? "exp_verified" : "inferred";

    const techMap = s5?.techniques || {};
    const selectedECOs = Object.keys(techMap).filter((eco) => techMap[eco] === true);
    const siteTechniques = selectedECOs.map((eco) => {
      const found = techList.find(
        (t) => (t?.ecoId || t?.eco || t?.EO_term || t?.id || t?.code) === eco
      );
      return {
        technique_id: eco,
        tech_name: found?.name || eco,
        EO_term: eco !== "nan" ? eco : null,
      };
    });
    const nextCurationId = await getMaxCurationId() + 1 || 0;
    alert 

    if (regsForSite.length > 0) {
      for (const g of regsForSite) {
        const gene_name = pickFirstNonEmpty(g?.geneLabel, g?.gene, g?.name, "");
        const locus_tag = pickFirstNonEmpty(g?.locus, "");
        if (!gene_name && !locus_tag) continue;

        for (const tech of siteTechniques.length ? siteTechniques : [{ technique_id: null, tech_name: "", EO_term: null }]) {
          result.push({
            uniprot_accession: uniAcc,
            genome_accession,
            TF_type,
            TF_function,
            annotated_seq,
            start,
            end,
            strand,
            pmid,
            curation_id: nextCurationId,
            technique_id: tech.technique_id,
            tech_name: tech.tech_name,
            EO_term: tech.EO_term,
            gene_name,
            locus_tag,
            evidence_type,
          });
        }
      }
    } 
  }
  
  return buildHTMLFromData(dataSV, result);
}