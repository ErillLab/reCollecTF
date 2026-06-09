import { data } from "react-router-dom";
    
const Result = ({ result }) => {
    if (!Array.isArray(result) || result.length === 0) {
        return <div>No results</div>;
    }

    const TF_NAME = result[0].uniprot_accession;

    const regColors = {
        "ACT": "#4CAF50",   // green
        "REP": "#F44336",   // red
        "DUAL": "#FFEB3B",  // yellow
        "N/A": "#2196F3"  // blue
    };

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

    return (
        <div className="w-full max-w-7xl mx-auto">
            <table className="table-fixed w-full border-collapse border border-gray-400 text-center text-sm">

                <thead>
                    <tr>
                        <th className="border p-2">Genome</th>
                        <th className="border p-2">TF</th>
                        <th className="border p-2">TF conformation</th>
                        <th className="border p-2">Site Sequence</th>
                        <th className="border p-2">Site Location</th>
                        <th className="border p-2">Experimental Techniques</th>
                        <th className="border p-2">Gene Regulation</th>
                        <th className="border p-2">Curation</th>
                        <th className="border p-2">PMID</th>
                    </tr>
                </thead>

                <tbody>
                    {Array.from(tableMap.entries()).map(([id, data]) => (
                        <tr key={id}>

                            <td className="border p-2">
                                <a
                                    className="text-accent hover:underline"
                                    href={`https://www.ncbi.nlm.nih.gov/nuccore/${data.genome_accession}`}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    {data.genome_accession}
                                </a>
                            </td>

                            <td className="border p-2">
                                <a
                                    className="text-accent hover:underline"
                                    href={`http://uniprot.org/uniprot/${TF_NAME}`}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    {TF_NAME}
                                </a>
                            </td>

                            <td className="border p-2">{data.TF_type}</td>

                            <td className="border p-2 break-words">
                                {data.annotated_seq}
                            </td>

                            <td className="border p-2">
                                {`${data.strand === '-1' ? '- ' : '+ '} [${data.start}, ${data.end}]`}
                            </td>

                            <td className="border p-2">
                                {data.techniques
                                    .map(t =>
                                        t.EO_term
                                            ? `${t.tech_name} (${t.EO_term})`
                                            : t.tech_name
                                    )
                                    .join(', ')
                                }
                            </td>

                            <td className="border p-2">
                            {data.gene_regulation.map((g, index) => {
                                if (!g.gene_name || !g.locus_tag) return null;
                                
                                console.log(g.gene_name);
                                console.log(g.evidence_type);
                                console.log(g.TF_function);


                                if (g.evidence_type == "exp_verified") {
                                    var key = g.TF_function;
                                }
                                else {
                                    var key = null;
                                }

                                return (
                                <span key={g.locus_tag}>
                                    <span style={{ color: regColors[key] || "#ffffff" }}>
                                    {g.gene_name} ({g.locus_tag})
                                    </span>
                                    {index < data.gene_regulation.length - 1 && ", "}
                                </span>
                                );
                            })}
                            </td>

                            <td className="border p-2">
                                {data.curation_id}
                            </td>

                            <td className="border p-2" >
                                {result[0].pmid && (
                                    <a
                                        className="text-accent hover:underline"
                                        href={`https://pubmed.ncbi.nlm.nih.gov/${result[0].pmid}`}
                                        target="_blank"
                                        rel="noopener noreferrer"
                                    >
                                        {result[0].pmid}
                                    </a>
                                )}
                            </td>

                        </tr>
                    ))}
                </tbody>

            </table>
        </div>
    );
};

export default Result;