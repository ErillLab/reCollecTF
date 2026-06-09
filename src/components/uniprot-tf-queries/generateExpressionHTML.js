// generateDetailedViewHTML.js
import { getSearchResult } from "../../db/queries/search.js";
import { getQuerySplitView } from "../../db/queries/uniprotQueries.js";

const regColors = {
  "ACT":  "#4CAF50",
  "REP":  "#F44336",
  "DUAL": "#FFEB3B",
  "N/A":  "#2196F3"
};

function buildTableRows(result) {
  const TF_NAME = result[0].uniprot_accession;
  const tableMap = new Map();

  result.forEach(row => {
    const rowKey = `${row.annotated_seq}-${row.curation_id}-${row.start}-${row.end}`;

    if (!tableMap.has(rowKey)) {
      tableMap.set(rowKey, {
        genome_accession: row.genome_accession,
        TF_type: row.TF_type,
        annotated_seq: row.annotated_seq,
        start: row.start,
        end: row.end,
        strand: row.strand,
        pmid: row.pmid,
        curation_id: row.curation_id,
        techniques: [],
        gene_regulation: []
      });
    }

    const data = tableMap.get(rowKey);

    if (!data.techniques.some(t => t.technique_id === row.technique_id)) {
      data.techniques.push({
        technique_id: row.technique_id,
        tech_name: row.tech_name,
        EO_term: row.EO_term
      });
    }

    if (!data.gene_regulation.some(
      g => g.locus_tag === row.locus_tag && g.TF_function === row.TF_function
    )) {
      data.gene_regulation.push({
        gene_name: row.gene_name,
        locus_tag: row.locus_tag,
        TF_function: row.TF_function,
        evidence_type: row.evidence_type
      });
    }
  });

  let rows = "";
  for (const [, data] of tableMap.entries()) {
    const techniquesStr = data.techniques
      .map(t => t.EO_term ? `${t.tech_name} (${t.EO_term})` : t.tech_name)
      .join(", ");

    const geneRegStr = data.gene_regulation.map((g, index) => {
      if (!g.gene_name || !g.locus_tag) return "";
      const key = g.evidence_type === "exp_verified" ? g.TF_function : null;
      const color = regColors[key] || "#ffffff";
      const comma = index < data.gene_regulation.length - 1 ? ", " : "";
      return `<span><span style="color: ${color};">${g.gene_name} (${g.locus_tag})</span>${comma}</span>`;
    }).join("");

    const strandSymbol = data.strand === "-1" ? "- " : "+ ";
    const pmidLink = data.pmid
      ? `<a class="text-accent hover:underline" href="https://pubmed.ncbi.nlm.nih.gov/${data.pmid}" target="_blank" rel="noopener noreferrer">${data.pmid}</a>`
      : "";

    rows += `
      <tr>
        <td class="border p-2">
          <a class="text-accent hover:underline" href="https://www.ncbi.nlm.nih.gov/nuccore/${data.genome_accession}" target="_blank" rel="noopener noreferrer">${data.genome_accession}</a>
        </td>
        <td class="border p-2">
          <a class="text-accent hover:underline" href="http://uniprot.org/uniprot/${TF_NAME}" target="_blank" rel="noopener noreferrer">${TF_NAME}</a>
        </td>
        <td class="border p-2">${data.TF_type}</td>
        <td class="border p-2 break-words">${data.annotated_seq}</td>
        <td class="border p-2">${strandSymbol} [${data.start}, ${data.end}]</td>
        <td class="border p-2">${techniquesStr}</td>
        <td class="border p-2">${geneRegStr}</td>
        <td class="border p-2">${data.curation_id}</td>
        <td class="border p-2">${pmidLink}</td>
      </tr>`;
  }

  return rows;
}

export function buildHTMLFromData(dataSV, result) {
  const tableRows = buildTableRows(result);

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${dataSV[0].name} - CollecTF</title>

  <!-- Tailwind CDN -->
  <script src="https://cdn.tailwindcss.com"></script>

  <style>
    body {
      min-height: 100vh;
      background-color: rgb(30, 30, 30);
      font-family: Segoe UI, sans-serif;
      color: rgb(245, 245, 245);
    }

    .btn {
      cursor: pointer;
      border-radius: 8px;
      border: 1px solid #444;
      background-color: rgb(51, 65, 85);
      padding: 0.5rem 1rem;
      color: rgb(245, 245, 245);
      transition: 0.2s;
    }

    .btn:hover {
      background-color: rgb(30, 41, 59);
    }

    .text-accent {
      color: rgb(79, 195, 247);
    }

    .bg-surface {
      background-color: rgb(42, 42, 42);
    }

    .border-border {
      border-color: rgb(68, 68, 68);
    }
  </style>
</head>

<body>

  <!-- HEADER -->
  <header class="flex justify-between items-center bg-surface px-8 py-4 border-b border-border">
    <a href="https://collectf.org/" 
    class="text-5xl font-bold text-accent cursor-pointer hover:text-white no-underline">
    CollecTF
    </a>
  </header>

  <!-- MAIN -->
  <main class="max-w-screen-xl mx-auto px-4 mt-6">

    <div class="mb-6">
      <b class="text-lg">${dataSV[0].name}</b>

      <p class="mt-2 text-sm text-gray-300">
        <a class="text-accent hover:underline"
           href="https://www.uniprot.org/uniprotkb/${dataSV[0].accession}/entry">
          UniProtKB: ${dataSV[0].accession}
        </a>
        regulon and binding site collection of ${dataSV[0].species}
      </p>
    </div>

    <!-- GUIDE -->
    <p class="mb-4 text-sm text-gray-300">
      For the selected transcription factor and species, the list of curated binding sites in the database are displayed below.
      Gene regulation diagrams show
      <span style="text-decoration: underline;">[binding sites]</span>,
      <span style="color: #4CAF50; text-decoration: underline;">[positively-regulated genes]</span>,
      <span style="color: #F44336; text-decoration: underline;">[negatively-regulated genes]</span>,
      <span style="color: #FFEB3B; text-decoration: underline;">[both positively and negatively regulated genes]</span>,
      <span style="color: #2196F3; text-decoration: underline;">[genes with unspecified type of regulation]</span>.
    </p>

    <!-- TABLE -->
    <div class="overflow-x-auto">
      <table class="w-full text-sm table-fixed border-collapse">

        <thead>
          <tr class="bg-surface">
            <th class="border border-gray-700 p-2">Genome</th>
            <th class="border border-gray-700 p-2">TF</th>
            <th class="border border-gray-700 p-2">TF conformation</th>
            <th class="border border-gray-700 p-2">Site Sequence</th>
            <th class="border border-gray-700 p-2">Site Location</th>
            <th class="border border-gray-700 p-2">Experimental Techniques</th>
            <th class="border border-gray-700 p-2">Gene Regulation</th>
            <th class="border border-gray-700 p-2">Curation</th>
            <th class="border border-gray-700 p-2">PMID</th>
          </tr>
        </thead>

        <tbody>
          ${tableRows}
        </tbody>

      </table>
    </div>

  </main>

</body>
</html>`;
}
export async function generateExpressionHTML(expressionId) {
  if (!expressionId || !/^EXPREG_[a-f0-9A-F]+$/.test(expressionId)) {
    throw new Error(`expressionId inválido: ${expressionId}`);
  }

  const tf_id = expressionId.replace("EXPREG_", "");
  const tf_id_parsed = parseInt(tf_id.slice(2, -1), 16);

  const [result, dataSV] = await Promise.all([
    getSearchResult(tf_id_parsed),
    getQuerySplitView(tf_id_parsed),
  ]);

  if (!dataSV || dataSV.length === 0) {
    throw new Error(`Sin datos para: ${expressionId}`);
  }

  if (!result || result.length === 0) {
    throw new Error(`Sin resultados de búsqueda para: ${expressionId}`);
  }

  return buildHTMLFromData(dataSV, result);
}