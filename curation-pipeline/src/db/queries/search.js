//Functions that will run the queries

//Example 

import { runQuery } from "../queryExecutor";

export async function testQuery() {
    return runQuery("SELECT 1");
}

export async function getFirstAndSecondExpTechniques() {
  return runQuery("SELECT * FROM core_experimental_technique LIMIT 2");
}

export async function getTFNames() {
    return runQuery("SELECT name FROM core_TF")
}

export async function getTFWithFamilies() {

    const query = `
    SELECT 
        tff.tf_family_id as family_id, tff.name as family_name, 
        tf.TF_id as element_id, tf.name as element_name
    FROM core_tffamily tff
    LEFT JOIN core_tf tf ON tff.tf_family_id = tf.family_id
    ORDER BY tff.name, tf.name;
    `
    //This will return something like this:
    //[
    //  { family_id: 1, family_name: 'Family 1', element_id: 1, element_name: 'TF 1' },
    //  { family_id: 1, family_name: 'Family 1', element_id: 2, element_name: 'TF 2' },
    //  { family_id: 2, family_name: 'Family 2', element_id: 3, element_name: 'TF 3' },
    //  { family_id: 2, family_name: 'Family 2', element_id: 4, element_name: 'TF 4' },
    //  ...
    //]

    return runQuery(query)
}

export async function getAllTfFamilies() {
    return runQuery("SELECT tf_family_id, name FROM core_tffamily")
}

export async function getNameAndFamilyIdFromTf(tfId) {
    const query = `
    SELECT family_id, name FROM core_tf tf
    WHERE tf.TF_id = "${tfId}";
    `    
    return runQuery(query)
}

export async function getCategoryIdByTechnique(techniqueId) {
    const query = `
    SELECT etc.experimentaltechniquecategory_id as category_id FROM core_experimentaltechnique_categories etc
    WHERE etc.experimentaltechnique_id = ${techniqueId};
    `    
    return runQuery(query)
}

export async function getTaxonomy() {
    return runQuery("SELECT id, name, parent_id FROM core_taxonomy ORDER BY parent_id");
}

export async function getExpTechniques() {
    //core_experimentaltechniquecategory cat core_experimental_technique et have N-N relationship
    //The table that joins them by the ids is core_experimentaltechnique_categories

    const query = `
    SELECT 
        ET.preset_function AS type,
        CAT.category_id AS category_id, 
        CAT.name AS category_name, 
        ET.technique_id AS id, 
        ET.name AS technique_name
    FROM core_experimentaltechniquecategory CAT
    JOIN core_experimentaltechnique_categories ETC ON CAT.category_id = ETC.experimentaltechniquecategory_id
    JOIN core_experimentaltechnique ET ON ETC.experimentaltechnique_id = et.technique_id
    ORDER BY CAT.category_id, ET.name;
    `
    //This will return something like this:
    //[
    //  { category: 1, category_name: 'Category 1', id: 1, name: 'Technique 1' },
    //  { category: 1, category_name: 'Category 1', id: 2, name: 'Technique 2' },
    //  { category: 2, category_name: 'Category 2', id: 3, name: 'Technique 3' },
    //  { category: 2, category_name: 'Category 2', id: 4, name: 'Technique 4' },
    //  ...
    //]

    return runQuery(query)
}

const placeholders = (arr) => arr.map(() => '?').join(',');

export async function getSearchResults(tfs, species) {
    const conditions = [];
    const values = [];

    const tfIds = tfs.map(obj => obj.id);
    const speciesIds = species.map(obj => obj.id);

    if (tfIds.length > 0) {
        conditions.push(`TF.TF_id IN (${placeholders(tfIds)})`);
        values.push(...tfIds);
    }

    if (speciesIds.length > 0) {
        conditions.push(`TAX.id IN (${placeholders(speciesIds)})`);
        values.push(...speciesIds);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';
    
    const query = `
        SELECT
            TF.name AS TF_name, TFI.uniprot_accession, CUR.TF_species, CUR.curation_id, PUB.publication_type, PUB.pmid, 
            CURSI.annotated_seq, CURSI.TF_type, ET.name AS tech_name, ET.technique_id, ET.EO_term, SI.start, SI.end, SI.strand, 
            GENOME.genome_accession, GENE.name AS gene_name, GENE.locus_tag
        FROM 
            core_tf TF
        JOIN core_tfinstance TFI ON TF.TF_id = TFI.TF_id
        JOIN core_curation_TF_instances CURTF ON TFI.TF_instance_id = CURTF.tfinstance_id
        JOIN core_curation CUR ON CURTF.curation_id = CUR.curation_id
        JOIN core_publication PUB ON CUR.publication_id = PUB.publication_id
        JOIN core_curation_siteinstance CURSI ON CUR.curation_id = CURSI.curation_id
        JOIN core_curation_siteinstance_experimental_techniques CURSIET ON CURSI.id = CURSIET.curation_siteinstance_id
        JOIN core_experimentaltechnique ET ON CURSIET.experimentaltechnique_id = ET.technique_id
        JOIN core_siteinstance SI ON CURSI.site_instance_id = SI.site_id
        JOIN core_genome GENOME ON SI.genome_id = GENOME.genome_id
        JOIN core_gene GENE ON GENOME.genome_id = GENE.genome_id
        JOIN core_taxonomy TAX ON GENOME.taxonomy_id = TAX.id 
        JOIN core_regulation REG ON CURSI.id = REG.curation_site_instance_id AND GENE.gene_id = REG.gene_id
        ${whereClause};
    `;

    console.log("Executing query:", query);
    console.log("VALUES: ", values);
    
    return runQuery(query, values);
}