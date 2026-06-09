import Result from "../../uniprot-tf-queries/detail/common/Result";

const ResultView = ({ result }) => {

    if (!result || !result.table_data) {
        return <div>No results</div>;
    }

    const TF_NAME = result.uniprot_accession;

    // Canviem dades a dades aplanades per utilitzar en Result
    const flattenedData = [];

    result.table_data.forEach((data) => {
        data.techniques.forEach((tech) => {
            data.gene_regulation.forEach((gene) => {
                flattenedData.push({
                    genome_accession: data.genome_accession,
                    TF_type: data.TF_type,
                    annotated_seq: data.annotated_seq,
                    start: data.start,
                    end: data.end,
                    strand: data.strand,
                    pmid: data.pmid,
                    curation_id: data.curation_id,

                    technique_id: tech.technique_id,
                    tech_name: tech.tech_name,
                    EO_term: tech.EO_term,

                    gene_name: gene.gene_name,
                    TF_function: gene.TF_function,
                    evidence_type: gene.evidence_type,
                    locus_tag: gene.locus_tag,

                    uniprot_accession: TF_NAME
                });
            });
        });
    });

    // Reutilitzem component Result
    return <Result result={flattenedData} />;
};

export default ResultView;