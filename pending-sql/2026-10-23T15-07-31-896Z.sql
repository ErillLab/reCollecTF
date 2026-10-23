PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

INSERT INTO core_publication
  (publication_type, pmid, authors, title, journal, publication_date, url,
   contains_promoter_data, contains_expression_data, submission_notes, curation_complete,
   reported_TF, reported_species)
SELECT
  'pubmed',
  '42099580',
  'Pérez-Varela M, Sánchez-Osuna M, Campoy S, Aranda J, Barbé J, Erill I',
  'A phage repressor involved in the DNA-damage response of Francisella.',
  'PNAS nexus',
  '2026 May',
  'https://doi.org/10.1093/pnasnexus/pgag114',
  0,
  1,
  NULL,
  0,
  'LexA',
  'Francisella hispaniensis FSC454'
WHERE NOT EXISTS (
  SELECT 1 FROM core_publication WHERE pmid='42099580'
);

UPDATE core_publication
SET
  authors = CASE WHEN authors IS NULL OR authors='' THEN 'Pérez-Varela M, Sánchez-Osuna M, Campoy S, Aranda J, Barbé J, Erill I' ELSE authors END,
  title = CASE WHEN title IS NULL OR title='' THEN 'A phage repressor involved in the DNA-damage response of Francisella.' ELSE title END,
  journal = CASE WHEN journal IS NULL OR journal='' THEN 'PNAS nexus' ELSE journal END,
  publication_date = CASE WHEN publication_date IS NULL OR publication_date='' THEN '2026 May' ELSE publication_date END,
  url = CASE WHEN url IS NULL OR url='' THEN 'https://doi.org/10.1093/pnasnexus/pgag114' ELSE url END,
  reported_TF = CASE WHEN reported_TF IS NULL OR reported_TF='' THEN 'LexA' ELSE reported_TF END,
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN 'Francisella hispaniensis FSC454' ELSE reported_species END,
  contains_promoter_data = 0,
  contains_expression_data = 1,
  curation_complete = 0,
  submission_notes = CASE
    WHEN submission_notes IS NULL OR submission_notes='' THEN submission_notes
    ELSE submission_notes
  END
WHERE pmid='42099580';

INSERT INTO core_tf (name, family_id, description)
SELECT 'LexA', 3, 'The LexA transcriptional repressor is the eponymous member of the LexA family. First described in Escherichia coli, LexA coordinates the expression of the SOS response by activating the expression of repair enzymes, cell division inhibitors and translesion synthesis polymerases in the advent of DNA damage [PMID::18726173] [PMID::17883408]. LexA normally represses the genes coding for all these factors by binding to their promoter region as a dimer using its Helix-Turn-Helix DNA binding domain [PFAM::PF01726]. LexA usually targets palindromic sites and prevents RNA-polymerase from binding, but has been shown to target strikingly different motifs across bacteria and to sometimes activate promoters [PMID::17883408][PMID::11917014]. After DNA damage, activated RecA molecules bind LexA and promote its self-catalytic cleavage, mediated by its Peptidase S24-like domain [PFAM::PF00717], inducing the SOS response.'
WHERE NOT EXISTS (
  SELECT 1 FROM core_tf WHERE lower(name)=lower('LexA')
);

UPDATE core_tf
SET
  family_id = COALESCE(family_id, 3),
  description = CASE WHEN description IS NULL THEN 'The LexA transcriptional repressor is the eponymous member of the LexA family. First described in Escherichia coli, LexA coordinates the expression of the SOS response by activating the expression of repair enzymes, cell division inhibitors and translesion synthesis polymerases in the advent of DNA damage [PMID::18726173] [PMID::17883408]. LexA normally represses the genes coding for all these factors by binding to their promoter region as a dimer using its Helix-Turn-Helix DNA binding domain [PFAM::PF01726]. LexA usually targets palindromic sites and prevents RNA-polymerase from binding, but has been shown to target strikingly different motifs across bacteria and to sometimes activate promoters [PMID::17883408][PMID::11917014]. After DNA damage, activated RecA molecules bind LexA and promote its self-catalytic cleavage, mediated by its Peptidase S24-like domain [PFAM::PF00717], inducing the SOS response.' ELSE description END
WHERE lower(name)=lower('LexA');

INSERT INTO core_tfinstance (refseq_accession, uniprot_accession, description, TF_id, notes, GO_term_id)
SELECT
  'WP_066046500.1',
  'A0AAC9J5Y6',
  'LexA family transcriptional repressor',
  (SELECT TF_id FROM core_tf WHERE lower(name)=lower('LexA') LIMIT 1),
  '',
  ''
WHERE NOT EXISTS (
  SELECT 1 FROM core_tfinstance WHERE uniprot_accession='A0AAC9J5Y6'
);

UPDATE core_tfinstance
SET
  TF_id = COALESCE(TF_id, (SELECT TF_id FROM core_tf WHERE lower(name)=lower('LexA') LIMIT 1)),
  refseq_accession = COALESCE(NULLIF(refseq_accession,''), 'WP_066046500.1'),
  description = COALESCE(NULLIF(description,''), 'LexA family transcriptional repressor'),
  notes = COALESCE(notes, ''),
  GO_term_id = COALESCE(GO_term_id, '')
WHERE uniprot_accession='A0AAC9J5Y6';

INSERT INTO core_curation
  (TF_species, site_species, experimental_process, forms_complex,
   complex_notes, notes, last_modified, curator_id, publication_id, created, validated_by_id)
VALUES
  ('Francisella hispaniensis FSC454', 'Francisella hispaniensis FSC454', NULL,
   0, NULL, 'From RNA-seq data, gene responsive to ciprofloxacin is detected. Motif elicited with MEME from orthologous promoters and validated by EMSA and site-directed mutagenesis.',
   datetime('now'), (SELECT curator_id FROM core_curator ORDER BY curator_id LIMIT 1), (SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1), datetime('now'), NULL);

INSERT INTO core_curation_TF_instances (curation_id, tfinstance_id)
SELECT (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1), (SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='A0AAC9J5Y6' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_curation_TF_instances
  WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1) AND tfinstance_id=(SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='A0AAC9J5Y6' LIMIT 1)
);

INSERT INTO core_genome (genome_accession, organism, gi)
SELECT
  'NZ_CP018093.1',
  'Francisella hispaniensis FSC454',
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM core_genome WHERE genome_accession='NZ_CP018093.1'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaA',
  'chromosomal replication initiator protein DnaA',
  1,
  1476,
  1,
  'FSC454_RS00005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaN',
  'DNA polymerase III subunit beta',
  1513,
  2616,
  1,
  'FSC454_RS00010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044905.1',
  'MFS transporter',
  2659,
  3918,
  -1,
  'FSC454_RS00015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044903.1',
  'APC family permease',
  4119,
  5642,
  1,
  'FSC454_RS00020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'zinc transporter ZntB',
  5709,
  6679,
  1,
  'FSC454_RS00025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044899.1',
  'hypothetical protein',
  6693,
  7160,
  -1,
  'FSC454_RS00030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247098.1',
  'hypothetical protein',
  7238,
  7555,
  -1,
  'FSC454_RS00035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547347.1',
  'DMT family transporter',
  7645,
  8517,
  -1,
  'FSC454_RS00040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ssrA',
  '—',
  9096,
  9516,
  -1,
  'FSC454_RS00050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046761.1',
  'aromatic amino acid transport family protein',
  9575,
  10798,
  -1,
  'FSC454_RS00055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'NAD(P)-dependent oxidoreductase',
  11340,
  12088,
  1,
  'FSC454_RS00060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794746.1',
  'IS630 family transposase',
  12109,
  12921,
  -1,
  'FSC454_RS00065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'NAD(P)-dependent oxidoreductase',
  12968,
  13096,
  1,
  'FSC454_RS09890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pyrB',
  'aspartate carbamoyltransferase',
  13101,
  14024,
  -1,
  'FSC454_RS00070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'carB',
  'carbamoyl-phosphate synthase large subunit',
  14141,
  17409,
  -1,
  'FSC454_RS00075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'carA',
  'glutamine-hydrolyzing carbamoyl-phosphatesynthase small subunit',
  17433,
  18600,
  -1,
  'FSC454_RS00080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045210.1',
  'histidine-type phosphatase',
  18936,
  19991,
  1,
  'FSC454_RS00085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045208.1',
  'thiopurine S-methyltransferase',
  20006,
  20674,
  -1,
  'FSC454_RS00090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045206.1',
  'dihydroorotase',
  20802,
  22148,
  1,
  'FSC454_RS00095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247105.1',
  'DJ-1/PfpI family protein',
  22138,
  22773,
  1,
  'FSC454_RS00100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uilS',
  'UilS family quorum-quenching N-acyl-homoserinelactonase',
  22898,
  23770,
  -1,
  'FSC454_RS00105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045200.1',
  'DUF1415 domain-containing protein',
  23917,
  24462,
  1,
  'FSC454_RS00110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045198.1',
  'FUSC family protein',
  24581,
  25633,
  -1,
  'FSC454_RS00115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045196.1',
  'HlyD family secretion protein',
  25620,
  26585,
  -1,
  'FSC454_RS00120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045194.1',
  'DUF3568 family protein',
  26658,
  27065,
  -1,
  'FSC454_RS00125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045192.1',
  'LysR family transcriptional regulator',
  27192,
  28061,
  1,
  'FSC454_RS00130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045190.1',
  'SOUL family heme-binding protein',
  28062,
  28685,
  -1,
  'FSC454_RS00135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045189.1',
  'chorismate mutase',
  28828,
  29373,
  1,
  'FSC454_RS00140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045186.1',
  'transglutaminase family protein',
  29423,
  32797,
  -1,
  'FSC454_RS00145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pyrF',
  'orotidine-5''-phosphate decarboxylase',
  33672,
  34304,
  1,
  'FSC454_RS00150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'diguanylate cyclase',
  34306,
  35048,
  1,
  'FSC454_RS00155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tyrA',
  'bifunctional chorismate mutase/prephenatedehydrogenase',
  35328,
  36164,
  -1,
  'FSC454_RS00160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dtd',
  'D-aminoacyl-tRNA deacylase',
  36167,
  36604,
  -1,
  'FSC454_RS00165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045177.1',
  'MFS transporter',
  36713,
  37945,
  -1,
  'FSC454_RS00170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156860525.1',
  'GH32 C-terminal domain-containing protein',
  37964,
  39679,
  -1,
  'FSC454_RS09895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'leuB',
  '3-isopropylmalate dehydrogenase',
  39754,
  40833,
  -1,
  'FSC454_RS00180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'leuD',
  '3-isopropylmalate dehydratase small subunit',
  40835,
  41404,
  -1,
  'FSC454_RS00185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'leuC',
  '3-isopropylmalate dehydratase large subunit',
  41407,
  42816,
  -1,
  'FSC454_RS00190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045167.1',
  'hydroxymethylglutaryl-CoA lyase-like TIM-barrelprotein',
  42818,
  44398,
  -1,
  'FSC454_RS00195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045165.1',
  'branched-chain amino acid transaminase',
  44409,
  45296,
  -1,
  'FSC454_RS00200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ppdK',
  'pyruvate, phosphate dikinase',
  45696,
  48329,
  -1,
  'FSC454_RS00205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456243.1',
  'hypothetical protein',
  48640,
  48927,
  -1,
  'FSC454_RS00210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'feoB',
  'Fe(2+) transporter permease subunit FeoB',
  49143,
  51386,
  -1,
  'FSC454_RS00215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045159.1',
  'hypothetical protein',
  51487,
  52059,
  -1,
  'FSC454_RS00220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'orn',
  'oligoribonuclease',
  52094,
  52630,
  -1,
  'FSC454_RS00225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'efp',
  'elongation factor P',
  52633,
  53202,
  -1,
  'FSC454_RS00230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547388.1',
  'type IV pilin protein',
  53239,
  53646,
  -1,
  'FSC454_RS00235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045153.1',
  'lysophospholipid acyltransferase family protein',
  53659,
  54582,
  -1,
  'FSC454_RS00240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045151.1',
  'lysophospholipid acyltransferase family protein',
  54643,
  55542,
  -1,
  'FSC454_RS00245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yidC',
  'membrane protein insertase YidC',
  55549,
  57204,
  -1,
  'FSC454_RS00250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yidD',
  'membrane protein insertion efficiency factorYidD',
  57213,
  57461,
  -1,
  'FSC454_RS00255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rnpA',
  'ribonuclease P protein component',
  57437,
  57790,
  -1,
  'FSC454_RS00260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmH',
  '50S ribosomal protein L34',
  57780,
  57914,
  -1,
  'FSC454_RS00265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045148.1',
  'hypothetical protein',
  58005,
  58463,
  -1,
  'FSC454_RS00270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroE',
  'shikimate dehydrogenase',
  58582,
  59355,
  1,
  'FSC454_RS00275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murC',
  'UDP-N-acetylmuramate--L-alanine ligase',
  59426,
  60781,
  1,
  'FSC454_RS00280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsmI',
  '16S rRNA(cytidine(1402)-2''-O)-methyltransferase',
  60774,
  61646,
  1,
  'FSC454_RS00285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045142.1',
  'hypothetical protein',
  61633,
  62391,
  -1,
  'FSC454_RS09745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045141.1',
  'YqeG family HAD IIIA-type phosphatase',
  62468,
  63031,
  1,
  'FSC454_RS00295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148260.1',
  'RCC1 domain-containing protein',
  63129,
  63860,
  1,
  'FSC454_RS00300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045137.1',
  'DEAD/DEAH box helicase',
  63864,
  66605,
  1,
  'FSC454_RS00305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045135.1',
  'universal stress protein',
  66681,
  67517,
  1,
  'FSC454_RS00310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794749.1',
  'MFS transporter',
  67644,
  68882,
  1,
  'FSC454_RS00315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045133.1',
  '5-oxoprolinase subunit B family protein',
  68904,
  69521,
  1,
  'FSC454_RS00320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547405.1',
  '5-oxoprolinase subunit PxpA',
  69521,
  70219,
  1,
  'FSC454_RS00325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045131.1',
  '5-oxoprolinase subunit C family protein',
  70224,
  71036,
  1,
  'FSC454_RS00330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794750.1',
  'alkaline phosphatase family protein',
  71043,
  72587,
  -1,
  'FSC454_RS00335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547409.1',
  'hypothetical protein',
  72894,
  73550,
  1,
  'FSC454_RS00340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547410.1',
  'inorganic phosphate transporter',
  73568,
  74563,
  1,
  'FSC454_RS00345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045126.1',
  'hypothetical protein',
  74751,
  74933,
  1,
  'FSC454_RS09600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470852.1',
  'hypothetical protein',
  75085,
  75258,
  1,
  'FSC454_RS09605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794751.1',
  'cytochrome b',
  75577,
  76092,
  1,
  'FSC454_RS00355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045124.1',
  'LysR family transcriptional regulator',
  76099,
  77046,
  -1,
  'FSC454_RS00360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045122.1',
  'nitroreductase',
  77118,
  77783,
  -1,
  'FSC454_RS00365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045119.1',
  'YoaK family protein',
  78191,
  78883,
  1,
  'FSC454_RS00370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045117.1',
  'amino acid permease',
  78880,
  80085,
  -1,
  'FSC454_RS00375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsmG',
  '16S rRNA (guanine(527)-N(7))-methyltransferaseRsmG',
  80185,
  80802,
  1,
  'FSC454_RS00380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045112.1',
  'YggS family pyridoxal phosphate-dependentenzyme',
  80799,
  81467,
  1,
  'FSC454_RS00385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810686.1',
  'FUSC family protein',
  81464,
  82345,
  -1,
  'FSC454_RS00390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'LysR family transcriptional regulator',
  82552,
  83446,
  -1,
  'FSC454_RS00395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045108.1',
  'multidrug effflux MFS transporter',
  83550,
  84701,
  1,
  'FSC454_RS00405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'COG3415 family protein',
  84794,
  85176,
  -1,
  'FSC454_RS09750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045106.1',
  'hypothetical protein',
  85231,
  86217,
  -1,
  'FSC454_RS00415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794752.1',
  'TauD/TfdA dioxygenase family protein',
  86226,
  87083,
  -1,
  'FSC454_RS00420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'MFS transporter',
  87260,
  87401,
  1,
  'FSC454_RS09620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'glycoside hydrolase',
  87427,
  89727,
  -1,
  'FSC454_RS10160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045102.1',
  'D-sedoheptulose-7-phosphate isomerase',
  89907,
  90503,
  1,
  'FSC454_RS00430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547426.1',
  'outer membrane protein assembly factor BamE',
  90511,
  90867,
  1,
  'FSC454_RS00435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsT',
  '30S ribosomal protein S20',
  90937,
  91209,
  -1,
  'FSC454_RS00440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lepA',
  'translation elongation factor 4',
  91477,
  93261,
  1,
  'FSC454_RS00445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045100.1',
  'NUDIX domain-containing protein',
  93277,
  93699,
  1,
  'FSC454_RS00450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mnmA',
  'tRNA 2-thiouridine(34) synthase MnmA',
  93751,
  94827,
  1,
  'FSC454_RS00455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810685.1',
  'FTN_0109 family protein',
  94845,
  95846,
  -1,
  'FSC454_RS00460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'def',
  'peptide deformylase',
  95928,
  96446,
  -1,
  'FSC454_RS00465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ribH',
  '6,7-dimethyl-8-ribityllumazine synthase',
  96449,
  96892,
  -1,
  'FSC454_RS00470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ribB',
  '3,4-dihydroxy-2-butanone-4-phosphate synthase',
  96902,
  98113,
  -1,
  'FSC454_RS00475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045090.1',
  'riboflavin synthase',
  98106,
  98711,
  -1,
  'FSC454_RS00480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ribD',
  'bifunctionaldiaminohydroxyphosphoribosylaminopyrimidinedeaminase/5-amino-6-(5-phosphoribosylamino)uracilreductase RibD',
  98704,
  99771,
  -1,
  'FSC454_RS00485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547436.1',
  'cation:proton antiporter',
  100160,
  101410,
  1,
  'FSC454_RS00490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045086.1',
  'alpha-keto acid decarboxylase family protein',
  101419,
  103116,
  -1,
  'FSC454_RS00495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547438.1',
  '(2Fe-2S) ferredoxin domain-containing protein',
  103234,
  103587,
  -1,
  'FSC454_RS00500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sppA',
  'signal peptide peptidase SppA',
  103673,
  104596,
  1,
  'FSC454_RS00505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547440.1',
  'OmpH family outer membrane protein',
  104686,
  105225,
  1,
  'FSC454_RS00510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547441.1',
  'rhodanese-like domain-containing protein',
  105358,
  105780,
  1,
  'FSC454_RS00515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secB',
  'protein-export chaperone SecB',
  105810,
  106259,
  1,
  'FSC454_RS00520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recA',
  'recombinase RecA',
  106283,
  107362,
  1,
  'FSC454_RS00525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045081.1',
  'regulatory protein RecX',
  107349,
  107804,
  1,
  'FSC454_RS00530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547445.1',
  'single-stranded DNA-binding protein',
  107965,
  108444,
  1,
  'FSC454_RS00535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045079.1',
  'acetate/propionate family kinase',
  109243,
  110397,
  1,
  'FSC454_RS00545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pta',
  'phosphate acetyltransferase',
  110407,
  112503,
  1,
  'FSC454_RS00550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045075.1',
  'NAD-dependent succinate-semialdehydedehydrogenase',
  112518,
  113951,
  1,
  'FSC454_RS00555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045073.1',
  'MFS transporter',
  113987,
  115195,
  1,
  'FSC454_RS00560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aspS',
  'aspartate--tRNA ligase',
  115375,
  117150,
  1,
  'FSC454_RS00565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045070.1',
  'glycosyltransferase family 4 protein',
  117285,
  118229,
  1,
  'FSC454_RS00570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247125.1',
  'hypothetical protein',
  118407,
  118778,
  -1,
  'FSC454_RS10165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DUF3281 family protein',
  120273,
  121083,
  1,
  'FSC454_RS00585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045068.1',
  'glycosyl transferase family 90',
  121229,
  122194,
  -1,
  'FSC454_RS00590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045066.1',
  'ribonuclease catalytic domain-containingprotein',
  122369,
  124225,
  1,
  'FSC454_RS00595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045065.1',
  'alpha/beta hydrolase',
  124557,
  125225,
  1,
  'FSC454_RS00600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemC',
  'hydroxymethylbilane synthase',
  125222,
  126124,
  1,
  'FSC454_RS00605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'crcB',
  'fluoride efflux transporter CrcB',
  126125,
  126517,
  1,
  'FSC454_RS00610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045060.1',
  'hypothetical protein',
  126514,
  126918,
  1,
  'FSC454_RS00615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470848.1',
  'hypothetical protein',
  127060,
  127677,
  1,
  'FSC454_RS00620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003014123.1',
  'zinc-finger domain-containing protein',
  127674,
  127847,
  -1,
  'FSC454_RS00625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045059.1',
  'ABC transporter permease',
  127977,
  129776,
  1,
  'FSC454_RS00630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547463.1',
  'ABC transporter ATP-binding protein',
  129795,
  131111,
  1,
  'FSC454_RS00635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865137.1',
  'DUF3573 domain-containing protein',
  131196,
  132767,
  1,
  'FSC454_RS00640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045057.1',
  'cation:proton antiporter',
  132814,
  134700,
  1,
  'FSC454_RS00645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547466.1',
  'gamma carbonic anhydrase family protein',
  134685,
  135224,
  1,
  'FSC454_RS00650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lolB',
  'lipoprotein insertase outer membrane proteinLolB',
  135175,
  135819,
  1,
  'FSC454_RS00655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ispE',
  '4-(cytidine5''-diphospho)-2-C-methyl-D-erythritol kinase',
  135807,
  136634,
  1,
  'FSC454_RS00660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  136653,
  136727,
  1,
  'FSC454_RS00665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148261.1',
  'hypothetical protein',
  136886,
  137455,
  1,
  'FSC454_RS09905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045050.1',
  'M14 family metallopeptidase',
  137526,
  138440,
  1,
  'FSC454_RS00675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045048.1',
  'YggT family protein',
  138456,
  139010,
  1,
  'FSC454_RS00680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470847.1',
  'hypothetical protein',
  139325,
  140398,
  1,
  'FSC454_RS00685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794753.1',
  'hypothetical protein',
  140497,
  140784,
  1,
  'FSC454_RS00690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794754.1',
  'hypothetical protein',
  140786,
  141214,
  1,
  'FSC454_RS00695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794755.1',
  'hypothetical protein',
  141183,
  141500,
  1,
  'FSC454_RS00700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045042.1',
  'GNAT family N-acetyltransferase',
  141483,
  141908,
  -1,
  'FSC454_RS00705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045040.1',
  'RimK family ATP-grasp domain-containing protein',
  141895,
  143364,
  -1,
  'FSC454_RS00710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045038.1',
  'ComEC/Rec2 family competence protein',
  143535,
  145553,
  1,
  'FSC454_RS00715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045036.1',
  '1-acylglycerol-3-phosphate O-acyltransferase,YihG family',
  145717,
  146607,
  1,
  'FSC454_RS00720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045034.1',
  'intracellular proliferation membrane proteinRipA',
  147033,
  147569,
  -1,
  'FSC454_RS00725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045032.1',
  'L-threonylcarbamoyladenylate synthase',
  147667,
  148209,
  -1,
  'FSC454_RS00730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsA',
  '30S ribosomal protein S1',
  148338,
  150008,
  -1,
  'FSC454_RS00735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tadA',
  'tRNA adenosine(34) deaminase TadA',
  150157,
  150618,
  1,
  'FSC454_RS00740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547482.1',
  'D-alanine--D-alanine ligase',
  150622,
  151512,
  1,
  'FSC454_RS00745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045027.1',
  'cell division protein FtsQ/DivIB',
  151509,
  152192,
  1,
  'FSC454_RS00750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftsA',
  'cell division protein FtsA',
  152295,
  153557,
  1,
  'FSC454_RS00755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftsZ',
  'cell division protein FtsZ',
  153602,
  154747,
  1,
  'FSC454_RS00760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxC',
  'UDP-3-O-acyl-N-acetylglucosamine deacetylase',
  154772,
  155632,
  1,
  'FSC454_RS00765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaX',
  'DNA polymerase III subunit gamma/tau',
  155643,
  157283,
  -1,
  'FSC454_RS00770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'prfB',
  'peptide chain release factor 2',
  157444,
  158533,
  1,
  'FSC454_RS00775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lysS',
  'lysine--tRNA ligase',
  158766,
  160448,
  1,
  'FSC454_RS00780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045015.1',
  'hypothetical protein',
  160453,
  160977,
  -1,
  'FSC454_RS00785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046320.1',
  'TIGR00645 family protein',
  161383,
  161925,
  -1,
  'FSC454_RS00790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glsA',
  'glutaminase A',
  162062,
  163606,
  -1,
  'FSC454_RS00795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547493.1',
  'glutamine synthetase beta-graspdomain-containing protein',
  163680,
  164717,
  -1,
  'FSC454_RS00800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'holA',
  'DNA polymerase III subunit delta',
  164836,
  165813,
  -1,
  'FSC454_RS00805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046323.1',
  'lipocalin family protein',
  165900,
  166418,
  1,
  'FSC454_RS00810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046324.1',
  'aromatic amino acid transport family protein',
  166613,
  167881,
  1,
  'FSC454_RS00815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purH',
  'bifunctionalphosphoribosylaminoimidazolecarboxamideformyltransferase/IMP cyclohydrolase',
  168031,
  169578,
  -1,
  'FSC454_RS00820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046326.1',
  'adenylosuccinate synthase',
  169755,
  171041,
  1,
  'FSC454_RS00825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hpt',
  'hypoxanthine phosphoribosyltransferase',
  171045,
  171578,
  1,
  'FSC454_RS00830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547500.1',
  'dienelactone hydrolase family protein',
  171591,
  172313,
  -1,
  'FSC454_RS00835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470894.1',
  'metal ABC transporter permease',
  172411,
  173253,
  -1,
  'FSC454_RS00840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046328.1',
  'metal ABC transporter ATP-binding protein',
  173195,
  173872,
  -1,
  'FSC454_RS00845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046329.1',
  'metal ABC transporter solute-binding protein,Zn/Mn family',
  173874,
  174791,
  -1,
  'FSC454_RS00850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046330.1',
  'MFS transporter',
  174865,
  176088,
  -1,
  'FSC454_RS00855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046331.1',
  'outer membrane lipoprotein',
  176218,
  176676,
  -1,
  'FSC454_RS00860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'wrbA',
  'NAD(P)H:quinone oxidoreductase',
  176687,
  177283,
  -1,
  'FSC454_RS00865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046332.1',
  'YhjD/YihY/BrkB family envelope integrityprotein',
  177290,
  178486,
  1,
  'FSC454_RS00870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  178509,
  179084,
  1,
  'FSC454_RS00875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'priA',
  'replication restart helicase PriA',
  179081,
  181234,
  1,
  'FSC454_RS00880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046334.1',
  'MFS transporter',
  181302,
  182480,
  -1,
  'FSC454_RS00885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046335.1',
  'transporter substrate-binding domain-containingprotein',
  182553,
  183293,
  -1,
  'FSC454_RS00890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794756.1',
  'CydX/CbdX family cytochrome bd oxidase smallsubunit',
  183370,
  183468,
  -1,
  'FSC454_RS00895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cydB',
  'cytochrome d ubiquinol oxidase subunit II',
  183484,
  184677,
  -1,
  'FSC454_RS00900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046337.1',
  'cytochrome ubiquinol oxidase subunit I',
  184688,
  186442,
  -1,
  'FSC454_RS00905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046338.1',
  'MFS transporter',
  186948,
  188315,
  -1,
  'FSC454_RS00910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cyoA',
  'ubiquinol oxidase subunit II',
  188764,
  189666,
  1,
  'FSC454_RS00915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cyoB',
  'cytochrome o ubiquinol oxidase subunit I',
  189705,
  191735,
  1,
  'FSC454_RS00920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cyoC',
  'cytochrome o ubiquinol oxidase subunit III',
  191732,
  192334,
  1,
  'FSC454_RS00925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cyoD',
  'cytochrome o ubiquinol oxidase subunit IV',
  192336,
  192668,
  1,
  'FSC454_RS00930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cyoE',
  'heme o synthase',
  192694,
  193542,
  1,
  'FSC454_RS00935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxD',
  'UDP-3-O-(3-hydroxymyristoyl)glucosamineN-acyltransferase',
  193705,
  194748,
  -1,
  'FSC454_RS00940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046343.1',
  'radical SAM protein',
  194823,
  195518,
  -1,
  'FSC454_RS00945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pdxY',
  'pyridoxal kinase',
  195518,
  196369,
  -1,
  'FSC454_RS00950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046345.1',
  'DUF3568 family protein',
  196376,
  196810,
  -1,
  'FSC454_RS00955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046346.1',
  'AAA family ATPase',
  196956,
  197912,
  1,
  'FSC454_RS00960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046347.1',
  'DUF58 domain-containing protein',
  197925,
  198836,
  1,
  'FSC454_RS00965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046348.1',
  'DUF4381 domain-containing protein',
  198826,
  199302,
  1,
  'FSC454_RS00970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046349.1',
  'vWA domain-containing protein',
  199299,
  200300,
  1,
  'FSC454_RS00975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046350.1',
  'vWA domain-containing protein',
  200302,
  201300,
  1,
  'FSC454_RS00980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794757.1',
  'tetratricopeptide repeat protein',
  201291,
  202265,
  1,
  'FSC454_RS00985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045941.1',
  'BatD family protein',
  202255,
  203880,
  1,
  'FSC454_RS00990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pcp',
  'pyroglutamyl-peptidase I',
  203887,
  204555,
  1,
  'FSC454_RS00995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS00995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045938.1',
  'transporter suffix domain-containing protein',
  204565,
  205047,
  1,
  'FSC454_RS01000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DNA polymerase III subunit chi',
  205081,
  205517,
  1,
  'FSC454_RS01005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045932.1',
  'sodium-dependent bicarbonate transport familypermease',
  205593,
  206549,
  1,
  'FSC454_RS01010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045929.1',
  'valine--tRNA ligase',
  206651,
  209410,
  1,
  'FSC454_RS01015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045926.1',
  'hypothetical protein',
  209411,
  210544,
  1,
  'FSC454_RS01020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_269446660.1',
  'phosphoenolpyruvate carboxylase',
  210616,
  211029,
  -1,
  'FSC454_RS10080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_269446659.1',
  'phosphoenolpyruvate carboxylase',
  211025,
  212938,
  -1,
  'FSC454_RS01025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865149.1',
  'hypothetical protein',
  212875,
  213150,
  -1,
  'FSC454_RS09910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045923.1',
  'hypothetical protein',
  213452,
  213787,
  1,
  'FSC454_RS01030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045920.1',
  'alpha-hydroxy acid oxidase',
  213776,
  214942,
  -1,
  'FSC454_RS01035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nfsB',
  'oxygen-insensitive NAD(P)H nitroreductase',
  214969,
  215622,
  -1,
  'FSC454_RS01040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045913.1',
  'NUDIX hydrolase',
  215765,
  216142,
  1,
  'FSC454_RS01045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fumC',
  'class II fumarate hydratase',
  216314,
  217705,
  1,
  'FSC454_RS01050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gltX',
  'glutamate--tRNA ligase',
  217837,
  219243,
  1,
  'FSC454_RS01055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'hypothetical protein',
  219243,
  220210,
  1,
  'FSC454_RS01060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  220295,
  220370,
  1,
  'FSC454_RS01065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045903.1',
  'arginine deiminase-related protein',
  220436,
  221359,
  -1,
  'FSC454_RS01070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247159.1',
  'dihydrofolate reductase',
  221442,
  221984,
  -1,
  'FSC454_RS01075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsB',
  '30S ribosomal protein S2',
  222183,
  222902,
  1,
  'FSC454_RS01080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tsf',
  'translation elongation factor Ts',
  222924,
  223793,
  1,
  'FSC454_RS01085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pyrH',
  'UMP kinase',
  223797,
  224546,
  1,
  'FSC454_RS01090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'frr',
  'ribosome recycling factor',
  224573,
  225130,
  1,
  'FSC454_RS01095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uppS',
  'polyprenyl diphosphate synthase',
  225214,
  225936,
  1,
  'FSC454_RS01100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547554.1',
  'phosphatidate cytidylyltransferase',
  225950,
  226744,
  1,
  'FSC454_RS01105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dut',
  'dUTP diphosphatase',
  226755,
  227201,
  1,
  'FSC454_RS01110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pgsA',
  'CDP-diacylglycerol--glycerol-3-phosphate3-phosphatidyltransferase',
  227205,
  227801,
  1,
  'FSC454_RS01115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsL',
  '30S ribosomal protein S12',
  227936,
  228310,
  1,
  'FSC454_RS01120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsG',
  '30S ribosomal protein S7',
  228349,
  228822,
  1,
  'FSC454_RS01125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fusA',
  'elongation factor G',
  228837,
  230951,
  1,
  'FSC454_RS01130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsJ',
  '30S ribosomal protein S10',
  230972,
  231289,
  1,
  'FSC454_RS01135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplC',
  '50S ribosomal protein L3',
  231393,
  232025,
  1,
  'FSC454_RS01140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplD',
  '50S ribosomal protein L4',
  232058,
  232681,
  1,
  'FSC454_RS01145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplW',
  '50S ribosomal protein L23',
  232678,
  232977,
  1,
  'FSC454_RS01150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplB',
  '50S ribosomal protein L2',
  232998,
  233822,
  1,
  'FSC454_RS01155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsS',
  '30S ribosomal protein S19',
  233837,
  234115,
  1,
  'FSC454_RS01160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplV',
  '50S ribosomal protein L22',
  234131,
  234466,
  1,
  'FSC454_RS01165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsC',
  '30S ribosomal protein S3',
  234481,
  235152,
  1,
  'FSC454_RS01170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplP',
  '50S ribosomal protein L16',
  235152,
  235565,
  1,
  'FSC454_RS01175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmC',
  '50S ribosomal protein L29',
  235565,
  235765,
  1,
  'FSC454_RS01180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsQ',
  '30S ribosomal protein S17',
  235778,
  236029,
  1,
  'FSC454_RS01185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplN',
  '50S ribosomal protein L14',
  236121,
  236489,
  1,
  'FSC454_RS01190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplX',
  '50S ribosomal protein L24',
  236511,
  236828,
  1,
  'FSC454_RS01195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplE',
  '50S ribosomal protein L5',
  236840,
  237379,
  1,
  'FSC454_RS01200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsN',
  '30S ribosomal protein S14',
  237398,
  237703,
  1,
  'FSC454_RS01205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsH',
  '30S ribosomal protein S8',
  237720,
  238118,
  1,
  'FSC454_RS01210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplF',
  '50S ribosomal protein L6',
  238137,
  238673,
  1,
  'FSC454_RS01215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplR',
  '50S ribosomal protein L18',
  238696,
  239049,
  1,
  'FSC454_RS01220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsE',
  '30S ribosomal protein S5',
  239077,
  239577,
  1,
  'FSC454_RS01225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmD',
  '50S ribosomal protein L30',
  239584,
  239769,
  1,
  'FSC454_RS01230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplO',
  '50S ribosomal protein L15',
  239776,
  240207,
  1,
  'FSC454_RS01235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secY',
  'preprotein translocase subunit SecY',
  240218,
  241543,
  1,
  'FSC454_RS01240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmJ',
  '50S ribosomal protein L36',
  241567,
  241680,
  1,
  'FSC454_RS01245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsM',
  '30S ribosomal protein S13',
  241797,
  242153,
  1,
  'FSC454_RS01250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsK',
  '30S ribosomal protein S11',
  242191,
  242580,
  1,
  'FSC454_RS01255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsD',
  '30S ribosomal protein S4',
  242602,
  243222,
  1,
  'FSC454_RS01260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547573.1',
  'DNA-directed RNA polymerase subunit alpha',
  243281,
  244252,
  1,
  'FSC454_RS01265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplQ',
  '50S ribosomal protein L17',
  244298,
  244735,
  1,
  'FSC454_RS01270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'htpG',
  'molecular chaperone HtpG',
  244910,
  246796,
  1,
  'FSC454_RS01275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045865.1',
  'hypothetical protein',
  246854,
  247231,
  -1,
  'FSC454_RS01280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yfcC',
  'putative basic amino acid antiporter YfcC',
  247372,
  248883,
  -1,
  'FSC454_RS01285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045860.1',
  'CTP synthase',
  249170,
  250810,
  1,
  'FSC454_RS01290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ndk',
  'nucleoside-diphosphate kinase',
  250883,
  251305,
  1,
  'FSC454_RS01295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'accD',
  'acetyl-CoA carboxylase, carboxyltransferasesubunit beta',
  251346,
  252248,
  1,
  'FSC454_RS01300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045852.1',
  'bifunctional folylpolyglutamatesynthase/dihydrofolate synthase',
  252263,
  253444,
  1,
  'FSC454_RS01305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tsaE',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexATPase subunit type 1 TsaE',
  253422,
  253832,
  1,
  'FSC454_RS01310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045847.1',
  'tetratricopeptide repeat protein',
  253915,
  254973,
  1,
  'FSC454_RS01315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murJ',
  'murein biosynthesis integral membrane proteinMurJ',
  254996,
  256537,
  1,
  'FSC454_RS01320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gshA',
  'glutamate--cysteine ligase',
  256590,
  258095,
  1,
  'FSC454_RS01325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmE',
  '50S ribosomal protein L31',
  258306,
  258521,
  -1,
  'FSC454_RS01330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547586.1',
  'ferredoxin--NADP reductase',
  258643,
  259374,
  -1,
  'FSC454_RS01335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247172.1',
  'hypothetical protein',
  259457,
  259852,
  1,
  'FSC454_RS01340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547588.1',
  'Cif family virulence factor',
  259861,
  260310,
  1,
  'FSC454_RS01345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547589.1',
  'SPFH domain-containing protein',
  260338,
  261234,
  1,
  'FSC454_RS01350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  261429,
  261505,
  -1,
  'FSC454_RS01355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547590.1',
  'ProQ/FINO family protein',
  261681,
  262382,
  1,
  'FSC454_RS01360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045840.1',
  'FTL_1709 family lipoprotein',
  262407,
  262952,
  1,
  'FSC454_RS01365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247176.1',
  'potassium transporter TrkG',
  262972,
  264426,
  -1,
  'FSC454_RS01370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547593.1',
  'CBU_0585 family protein',
  264538,
  264741,
  1,
  'FSC454_RS01375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lolA',
  'outer membrane lipoprotein periplasmic chaperoneLolA',
  265136,
  265753,
  -1,
  'FSC454_RS01380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045834.1',
  'DNA translocase FtsK',
  265754,
  268252,
  -1,
  'FSC454_RS01385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxF',
  'lipid A 4''-phosphatase LpxF',
  268374,
  269042,
  1,
  'FSC454_RS01390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045827.1',
  'amino acid permease',
  269288,
  270742,
  1,
  'FSC454_RS01395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547599.1',
  'alpha/beta hydrolase',
  270754,
  271392,
  1,
  'FSC454_RS01400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glpX',
  'class II fructose-bisphosphatase',
  271411,
  272397,
  1,
  'FSC454_RS01405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'putP',
  'sodium/proline symporter PutP',
  272700,
  274166,
  1,
  'FSC454_RS01410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045819.1',
  'glycosyltransferase family 2 protein',
  274237,
  275916,
  1,
  'FSC454_RS01415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045817.1',
  'hemolysin family protein',
  275927,
  277234,
  1,
  'FSC454_RS01420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547604.1',
  'PulJ/GspJ family protein',
  277304,
  277651,
  1,
  'FSC454_RS01425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045814.1',
  'PilW family protein',
  277635,
  278561,
  1,
  'FSC454_RS01430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045812.1',
  'hypothetical protein',
  278558,
  279964,
  1,
  'FSC454_RS01435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045809.1',
  'hypothetical protein',
  279975,
  280595,
  1,
  'FSC454_RS01440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865150.1',
  'type II secretion system protein',
  280706,
  281383,
  1,
  'FSC454_RS09915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045806.1',
  'PilW family protein',
  281402,
  282322,
  1,
  'FSC454_RS01455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045804.1',
  'hypothetical protein',
  282335,
  284143,
  1,
  'FSC454_RS01460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045802.1',
  'hypothetical protein',
  284166,
  285968,
  1,
  'FSC454_RS01465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cysS',
  'cysteine--tRNA ligase',
  286051,
  287430,
  1,
  'FSC454_RS01470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'prmB',
  '50S ribosomal protein L3 N(5)-glutaminemethyltransferase',
  287434,
  288378,
  1,
  'FSC454_RS01475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'MFS transporter',
  288434,
  289624,
  1,
  'FSC454_RS01480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045797.1',
  'GNAT family N-acetyltransferase',
  289636,
  290127,
  1,
  'FSC454_RS01485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045794.1',
  'DUF4282 domain-containing protein',
  290143,
  290424,
  -1,
  'FSC454_RS01490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045791.1',
  'APC family permease',
  290437,
  291939,
  -1,
  'FSC454_RS01495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'hypothetical protein',
  292069,
  292304,
  -1,
  'FSC454_RS10215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547618.1',
  'hypothetical protein',
  292294,
  293037,
  -1,
  'FSC454_RS01505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ubiG',
  'bifunctional 2-polyprenyl-6-hydroxyphenolmethylase/3-demethylubiquinol 3-O-methyltransferase UbiG',
  293040,
  293735,
  -1,
  'FSC454_RS01510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045782.1',
  'MlaA family lipoprotein',
  293876,
  294976,
  1,
  'FSC454_RS01515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045779.1',
  'BolA/IbaG family iron-sulfur metabolism protein',
  295196,
  295432,
  -1,
  'FSC454_RS01520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045776.1',
  'STAS domain-containing protein',
  295449,
  295742,
  -1,
  'FSC454_RS01525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045775.1',
  'MlaC/ttg2D family ABC transportersubstrate-binding protein',
  295742,
  296404,
  -1,
  'FSC454_RS01530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mlaD',
  'outer membrane lipid asymmetry maintenanceprotein MlaD',
  296479,
  297012,
  -1,
  'FSC454_RS01535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045769.1',
  'MlaE family lipid ABC transporter permeasesubunit',
  297012,
  297776,
  -1,
  'FSC454_RS01540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045766.1',
  'ABC transporter ATP-binding protein',
  297780,
  298583,
  -1,
  'FSC454_RS01545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'minE',
  'cell division topological specificity factorMinE',
  298599,
  298871,
  -1,
  'FSC454_RS01550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'minD',
  'septum site-determining protein MinD',
  298874,
  299698,
  -1,
  'FSC454_RS01555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'minC',
  'septum site-determining protein MinC',
  299738,
  300424,
  -1,
  'FSC454_RS01560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmG',
  '50S ribosomal protein L33',
  300459,
  300614,
  -1,
  'FSC454_RS01565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmB',
  '50S ribosomal protein L28',
  300641,
  300877,
  -1,
  'FSC454_RS01570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lptM',
  'LPS translocon maturation chaperone LptM',
  301010,
  301351,
  -1,
  'FSC454_RS01575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045760.1',
  'ATP-dependent DNA helicase RecG',
  301480,
  303519,
  1,
  'FSC454_RS01580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547632.1',
  'fumarate hydratase',
  304285,
  305799,
  1,
  'FSC454_RS01590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359440.1',
  'hypothetical protein',
  305803,
  305949,
  1,
  'FSC454_RS09755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547634.1',
  'NUDIX hydrolase N-terminal domain-containingprotein',
  306281,
  306886,
  1,
  'FSC454_RS01595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547635.1',
  'arsenate reductase family protein',
  306916,
  307269,
  1,
  'FSC454_RS01600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547636.1',
  'hypothetical protein',
  307293,
  307628,
  -1,
  'FSC454_RS01605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045758.1',
  'hypothetical protein',
  307807,
  308052,
  -1,
  'FSC454_RS01610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045756.1',
  'NCS2 family permease',
  308133,
  309446,
  -1,
  'FSC454_RS01615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045747.1',
  'bifunctional aspartate transaminase/aspartate4-decarboxylase',
  309518,
  311098,
  -1,
  'FSC454_RS01620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aspT',
  'aspartate-alanine antiporter',
  311115,
  312830,
  -1,
  'FSC454_RS01625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dprA',
  'DNA-processing protein DprA',
  312905,
  314011,
  -1,
  'FSC454_RS01630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045739.1',
  'OmpA family protein',
  314011,
  315264,
  -1,
  'FSC454_RS01635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fkpB',
  'FKBP-type peptidyl-prolyl cis-trans isomerase',
  315460,
  315924,
  1,
  'FSC454_RS01640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ispH',
  '4-hydroxy-3-methylbut-2-enyl diphosphatereductase',
  315905,
  316867,
  1,
  'FSC454_RS01645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroH',
  'chorismate mutase',
  316869,
  317231,
  1,
  'FSC454_RS01650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_080555301.1',
  'CDP-alcohol phosphatidyltransferase familyprotein',
  317240,
  318061,
  1,
  'FSC454_RS01655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045729.1',
  'hypothetical protein',
  318066,
  318290,
  -1,
  'FSC454_RS01660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tolQ',
  'protein TolQ',
  318444,
  319151,
  1,
  'FSC454_RS01665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tolR',
  'protein TolR',
  319167,
  319607,
  1,
  'FSC454_RS01670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tolA',
  'cell envelope integrity protein TolA',
  319594,
  320505,
  1,
  'FSC454_RS01675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045720.1',
  'beta-propeller domain-containing protein',
  320517,
  321824,
  1,
  'FSC454_RS01680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045718.1',
  'hypothetical protein',
  321834,
  322079,
  1,
  'FSC454_RS01685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045715.1',
  'OmpA family protein',
  322098,
  322721,
  1,
  'FSC454_RS01690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rimO',
  '30S ribosomal protein S12 methylthiotransferaseRimO',
  322828,
  324147,
  1,
  'FSC454_RS01695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045709.1',
  'type I restriction endonuclease subunit R',
  324161,
  327133,
  1,
  'FSC454_RS01700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810694.1',
  'restriction endonuclease subunit S',
  327126,
  328535,
  1,
  'FSC454_RS09525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794759.1',
  'endonuclease domain-containing protein',
  328630,
  329067,
  1,
  'FSC454_RS01710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045706.1',
  'AAA family ATPase',
  329070,
  330188,
  1,
  'FSC454_RS01715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045703.1',
  'virulence RhuM family protein',
  330191,
  331204,
  1,
  'FSC454_RS01720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045699.1',
  'type I restriction-modification system subunitM',
  331197,
  332888,
  1,
  'FSC454_RS01725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045696.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  333005,
  333727,
  1,
  'FSC454_RS01730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547656.1',
  'TIGR03643 family protein',
  333751,
  333981,
  1,
  'FSC454_RS01735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045692.1',
  'FAD-binding domain-containing protein',
  333962,
  335461,
  1,
  'FSC454_RS01740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045690.1',
  'cryptochrome/photolyase family protein',
  335461,
  336990,
  1,
  'FSC454_RS01745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547659.1',
  'DUF2256 domain-containing protein',
  336987,
  337124,
  1,
  'FSC454_RS01750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_080555306.1',
  'bile acid:sodium symporter family protein',
  337250,
  338179,
  1,
  'FSC454_RS01755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045687.1',
  'helix-turn-helix transcriptional regulator',
  338226,
  338849,
  1,
  'FSC454_RS01760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045684.1',
  'sulfite exporter TauE/SafE family protein',
  338873,
  339631,
  1,
  'FSC454_RS01765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  339675,
  339764,
  1,
  'FSC454_RS01770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045681.1',
  'transglutaminase-like domain-containing protein',
  340257,
  341243,
  1,
  'FSC454_RS01775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045677.1',
  'ArsB/NhaD family transporter',
  341414,
  342655,
  1,
  'FSC454_RS01780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045674.1',
  'DUF423 domain-containing protein',
  342668,
  343057,
  -1,
  'FSC454_RS01785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045671.1',
  'thiol-disulfide oxidoreductase DCC familyprotein',
  343077,
  343436,
  -1,
  'FSC454_RS01790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ubiA',
  '4-hydroxybenzoate octaprenyltransferase',
  343450,
  344307,
  -1,
  'FSC454_RS01795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045666.1',
  'chorismate--pyruvate lyase family protein',
  344300,
  344812,
  -1,
  'FSC454_RS01800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rph',
  'ribonuclease PH',
  344911,
  345618,
  1,
  'FSC454_RS01805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003014552.1',
  'hypothetical protein',
  345672,
  345995,
  -1,
  'FSC454_RS01810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470869.1',
  'type IV pilin protein',
  346100,
  347050,
  -1,
  'FSC454_RS10170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'htpX',
  'zinc metalloprotease HtpX',
  347154,
  348224,
  -1,
  'FSC454_RS01825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045659.1',
  'LemA family protein',
  348228,
  348803,
  -1,
  'FSC454_RS01830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045655.1',
  'LysR substrate-binding domain-containingprotein',
  348886,
  349773,
  -1,
  'FSC454_RS01835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045652.1',
  'FAD-dependent oxidoreductase',
  349912,
  350967,
  1,
  'FSC454_RS01840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045649.1',
  'heavy metal translocating P-type ATPase',
  350969,
  353134,
  -1,
  'FSC454_RS01845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003026546.1',
  'ArsR/SmtB family transcription factor',
  353131,
  353496,
  -1,
  'FSC454_RS01850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045646.1',
  'C39 family peptidase',
  353639,
  354292,
  1,
  'FSC454_RS01855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470868.1',
  'hypothetical protein',
  354304,
  354435,
  -1,
  'FSC454_RS10085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045644.1',
  'NAD(P)H-dependent glycerol-3-phosphatedehydrogenase',
  354612,
  355610,
  1,
  'FSC454_RS01860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045642.1',
  'CvpA family protein',
  355611,
  356147,
  -1,
  'FSC454_RS01865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'radA',
  'DNA repair protein RadA',
  356152,
  357522,
  -1,
  'FSC454_RS01870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045636.1',
  'PilZ domain-containing protein',
  357530,
  358297,
  -1,
  'FSC454_RS01875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045633.1',
  'DedA family protein',
  358294,
  358905,
  -1,
  'FSC454_RS01880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroC',
  'chorismate synthase',
  358908,
  359966,
  -1,
  'FSC454_RS01885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045627.1',
  'PQ-loop repeat-containing protein',
  360111,
  360755,
  -1,
  'FSC454_RS01890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'msrB',
  'peptide-methionine (R)-S-oxide reductase MsrB',
  360774,
  361298,
  -1,
  'FSC454_RS01895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045619.1',
  'superoxide dismutase family protein',
  361455,
  362012,
  1,
  'FSC454_RS01900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045616.1',
  'sterol desaturase family protein',
  362016,
  362807,
  1,
  'FSC454_RS01905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045613.1',
  'amino acid permease',
  362782,
  364176,
  -1,
  'FSC454_RS01910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547691.1',
  'phosphomannose isomerase type II C-terminalcupin domain',
  364327,
  364689,
  1,
  'FSC454_RS01915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045610.1',
  'S-(hydroxymethyl)glutathione dehydrogenase/classIII alcohol dehydrogenase',
  364782,
  365894,
  1,
  'FSC454_RS01920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'pyridoxal phosphate-dependent aminotransferase',
  365945,
  367050,
  -1,
  'FSC454_RS01925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045605.1',
  'cation diffusion facilitator family transporter',
  367253,
  368140,
  1,
  'FSC454_RS01930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recN',
  'DNA repair protein RecN',
  368226,
  369875,
  1,
  'FSC454_RS01935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045599.1',
  'pilin',
  370172,
  371404,
  -1,
  'FSC454_RS01940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045596.1',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein',
  371568,
  372008,
  -1,
  'FSC454_RS01945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045592.1',
  'pilin',
  372141,
  372536,
  -1,
  'FSC454_RS01950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxE',
  'lipid A 1-phosphatase LpxE',
  373048,
  373767,
  1,
  'FSC454_RS01955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'folD',
  'bifunctional methylenetetrahydrofolatedehydrogenase/methenyltetrahydrofolate cyclohydrolaseFolD',
  373907,
  374773,
  1,
  'FSC454_RS01960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purM',
  'phosphoribosylformylglycinamidine cyclo-ligase',
  374898,
  375941,
  1,
  'FSC454_RS01965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045582.1',
  'phosphoribosylaminoimidazolesuccinocarboxamidesynthase',
  375941,
  378253,
  1,
  'FSC454_RS01970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purN',
  'phosphoribosylglycinamide formyltransferase',
  378257,
  378835,
  1,
  'FSC454_RS01975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purE',
  '5-(carboxyamino)imidazole ribonucleotide mutase',
  378946,
  379437,
  1,
  'FSC454_RS01980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045579.1',
  '5-(carboxyamino)imidazole ribonucleotidesynthase',
  379440,
  380537,
  1,
  'FSC454_RS01985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045576.1',
  'YraN family protein',
  380534,
  380887,
  -1,
  'FSC454_RS01990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045573.1',
  'M3 family metallopeptidase',
  380969,
  382975,
  -1,
  'FSC454_RS01995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS01995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045569.1',
  'Mth938-like domain-containing protein',
  383066,
  383437,
  1,
  'FSC454_RS02000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpnA',
  'outer member lipoprotein TUL4/LpnA',
  383519,
  383965,
  1,
  'FSC454_RS02005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045564.1',
  'hypothetical protein',
  384116,
  384595,
  1,
  'FSC454_RS02010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045561.1',
  'hypothetical protein',
  384696,
  385214,
  1,
  'FSC454_RS02015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpnB',
  'TUL4 family outer member lipoprotein LpnB',
  385237,
  385704,
  1,
  'FSC454_RS02020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045555.1',
  'O-antigen ligase family protein',
  385777,
  387219,
  1,
  'FSC454_RS02025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'topA',
  'type I DNA topoisomerase',
  387275,
  389569,
  -1,
  'FSC454_RS02030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549400.1',
  'AAA family ATPase',
  389768,
  390409,
  1,
  'FSC454_RS02035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045548.1',
  'ParB/RepB/Spo0J family partition protein',
  390402,
  391316,
  1,
  'FSC454_RS02040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547717.1',
  'glutamine amidotransferase-related protein',
  391330,
  392037,
  1,
  'FSC454_RS02045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045545.1',
  'SGNH/GDSL hydrolase family protein',
  392040,
  392921,
  1,
  'FSC454_RS02050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'HD domain-containing protein',
  392918,
  393508,
  1,
  'FSC454_RS02055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rlmE',
  '23S rRNA (uridine(2552)-2''-O)-methyltransferaseRlmE',
  393559,
  394179,
  -1,
  'FSC454_RS02060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045539.1',
  'hypothetical protein',
  394337,
  394804,
  1,
  'FSC454_RS02065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lspA',
  'signal peptidase II',
  394799,
  395284,
  -1,
  'FSC454_RS02070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ileS',
  'isoleucine--tRNA ligase',
  395271,
  398078,
  -1,
  'FSC454_RS02075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ribF',
  'bifunctional riboflavin kinase/FAD synthetase',
  398171,
  399091,
  -1,
  'FSC454_RS02080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547725.1',
  'NAD-dependent malic enzyme',
  399242,
  401056,
  1,
  'FSC454_RS02085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045531.1',
  'DUF3573 domain-containing protein',
  401224,
  402909,
  1,
  'FSC454_RS02090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045528.1',
  'DUF3573 domain-containing protein',
  402925,
  404370,
  1,
  'FSC454_RS02095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'der',
  'ribosome biogenesis GTPase Der',
  404586,
  405983,
  1,
  'FSC454_RS02100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045524.1',
  'UDP-N-acetylglucosamine1-carboxyvinyltransferase',
  405952,
  407256,
  1,
  'FSC454_RS02105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murB',
  'UDP-N-acetylmuramate dehydrogenase',
  407264,
  408112,
  1,
  'FSC454_RS02110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045518.1',
  'hypothetical protein',
  408191,
  409066,
  1,
  'FSC454_RS02115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547732.1',
  'methyltransferase domain-containing protein',
  409077,
  409844,
  -1,
  'FSC454_RS02120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547733.1',
  'ComF family protein',
  409869,
  410522,
  1,
  'FSC454_RS02125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547734.1',
  'hypothetical protein',
  410639,
  410770,
  1,
  'FSC454_RS10090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045515.1',
  'histidine triad nucleotide-binding protein',
  410787,
  411125,
  -1,
  'FSC454_RS02130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ubiB',
  'ubiquinone biosynthesis regulatory proteinkinase UbiB',
  411131,
  412789,
  -1,
  'FSC454_RS02135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045944.1',
  'ubiquinone biosynthesis accessory factor UbiJ',
  412782,
  413369,
  -1,
  'FSC454_RS02140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ubiE',
  'bifunctional demethylmenaquinonemethyltransferase/2-methoxy-6-polyprenyl-1,4-benzoquinolmethylase UbiE',
  413371,
  414123,
  -1,
  'FSC454_RS02145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glk',
  'glucokinase',
  414217,
  415233,
  1,
  'FSC454_RS02150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045503.1',
  'hypothetical protein',
  415235,
  415504,
  -1,
  'FSC454_RS02155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547741.1',
  'septation protein A',
  415578,
  416108,
  -1,
  'FSC454_RS02160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045500.1',
  'L-threonylcarbamoyladenylate synthase',
  416169,
  416783,
  1,
  'FSC454_RS02165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045496.1',
  'YigZ family protein',
  416832,
  417434,
  1,
  'FSC454_RS02170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045492.1',
  'MFS transporter',
  417431,
  418654,
  -1,
  'FSC454_RS02175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'metG',
  'methionine--tRNA ligase',
  418670,
  420694,
  -1,
  'FSC454_RS02180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  420873,
  420964,
  1,
  'FSC454_RS02185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  420995,
  421070,
  1,
  'FSC454_RS02190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470865.1',
  'hypothetical protein',
  421260,
  421541,
  1,
  'FSC454_RS02195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  422359,
  423886,
  1,
  'FSC454_RS02200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  423983,
  424059,
  1,
  'FSC454_RS02205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  424074,
  424150,
  1,
  'FSC454_RS02210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  424203,
  427089,
  1,
  'FSC454_RS02215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rrf',
  '—',
  427137,
  427251,
  1,
  'FSC454_RS02220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'cupin domain-containing protein',
  427560,
  428239,
  1,
  'FSC454_RS02225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794760.1',
  'ligand-gated ion channel',
  428456,
  429511,
  -1,
  'FSC454_RS02230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794761.1',
  'site-2 protease family protein',
  429624,
  430280,
  -1,
  'FSC454_RS02235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359441.1',
  'hypothetical protein',
  430615,
  430788,
  1,
  'FSC454_RS09765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fevR',
  'transcriptional regulator FevR',
  431497,
  431832,
  1,
  'FSC454_RS02240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'asd',
  'archaetidylserine decarboxylase',
  431805,
  432656,
  -1,
  'FSC454_RS02245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046693.1',
  'hypothetical protein',
  432755,
  433735,
  1,
  'FSC454_RS02250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046695.1',
  'bifunctional nicotinamide-nucleotideadenylyltransferase/Nudix hydroxylase',
  433744,
  434787,
  1,
  'FSC454_RS02255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glmU',
  'bifunctional UDP-N-acetylglucosaminediphosphorylase/glucosamine-1-phosphateN-acetyltransferase GlmU',
  434801,
  436168,
  1,
  'FSC454_RS02260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glmS',
  'glutamine--fructose-6-phosphate transaminase(isomerizing)',
  436189,
  438027,
  1,
  'FSC454_RS02265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046701.1',
  'GNAT family N-acetyltransferase',
  438121,
  438633,
  1,
  'FSC454_RS02270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  438630,
  438827,
  -1,
  'FSC454_RS02275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003017957.1',
  'cold-shock protein',
  438827,
  439030,
  -1,
  'FSC454_RS02280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547759.1',
  'MazG nucleotide pyrophosphohydrolasedomain-containing protein',
  439283,
  439612,
  -1,
  'FSC454_RS02285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'map',
  'type I methionyl aminopeptidase',
  439738,
  440508,
  1,
  'FSC454_RS02290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046707.1',
  'hypothetical protein',
  440510,
  441358,
  1,
  'FSC454_RS02295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'parC',
  'DNA topoisomerase IV subunit A',
  441461,
  443686,
  1,
  'FSC454_RS02300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046711.1',
  '5''-methylthioadenosine/adenosylhomocysteinenucleosidase',
  443686,
  444372,
  1,
  'FSC454_RS02305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046713.1',
  'hypothetical protein',
  444359,
  444961,
  -1,
  'FSC454_RS02310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046715.1',
  'exo-alpha-sialidase',
  444954,
  446072,
  -1,
  'FSC454_RS02315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810679.1',
  'lytic transglycosylase domain-containingprotein',
  446274,
  448250,
  1,
  'FSC454_RS02320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865131.1',
  'hypothetical protein',
  448662,
  448910,
  -1,
  'FSC454_RS09920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794763.1',
  'DUF2254 family protein',
  449244,
  450506,
  1,
  'FSC454_RS02330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaE',
  'DNA polymerase III subunit alpha',
  450745,
  454224,
  1,
  'FSC454_RS02335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470838.1',
  'peptide deformylase',
  454332,
  454946,
  1,
  'FSC454_RS02340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rrf',
  '—',
  455010,
  455124,
  1,
  'FSC454_RS02345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547775.1',
  'lipoprotein-releasing ABC transporter permeasesubunit',
  455658,
  456920,
  1,
  'FSC454_RS02350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044811.1',
  'ABC transporter ATP-binding protein',
  456913,
  457608,
  1,
  'FSC454_RS02355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547777.1',
  'lysine decarboxylase LdcC',
  457718,
  459859,
  1,
  'FSC454_RS02360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gcvT',
  'glycine cleavage system aminomethyltransferaseGcvT',
  459950,
  461026,
  1,
  'FSC454_RS02365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gcvH',
  'glycine cleavage system protein GcvH',
  461081,
  461464,
  1,
  'FSC454_RS02370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gcvPA',
  'aminomethyl-transferring glycine dehydrogenasesubunit GcvPA',
  461529,
  462896,
  1,
  'FSC454_RS02375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gcvPB',
  'aminomethyl-transferring glycine dehydrogenasesubunit GcvPB',
  462902,
  464347,
  1,
  'FSC454_RS02380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865132.1',
  'CPBP family intramembrane glutamicendopeptidase',
  464475,
  465161,
  1,
  'FSC454_RS02385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044820.1',
  'type ISP restriction/modification enzyme',
  465233,
  468574,
  1,
  'FSC454_RS02390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044822.1',
  'shikimate dehydrogenase family protein',
  468594,
  469445,
  -1,
  'FSC454_RS02395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pulA',
  'type I pullulanase',
  469471,
  472683,
  -1,
  'FSC454_RS02400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glgB',
  '1,4-alpha-glucan branching protein GlgB',
  472717,
  474639,
  -1,
  'FSC454_RS02405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044827.1',
  'alpha-D-glucose phosphate-specificphosphoglucomutase',
  474940,
  476574,
  1,
  'FSC454_RS02410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glgC',
  'glucose-1-phosphate adenylyltransferase',
  476608,
  477879,
  1,
  'FSC454_RS02415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glgA',
  'glycogen synthase GlgA',
  477889,
  479358,
  1,
  'FSC454_RS02420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044831.1',
  'glycogen/starch/alpha-glucan phosphorylase',
  479463,
  481736,
  1,
  'FSC454_RS02425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'malQ',
  '4-alpha-glucanotransferase',
  481778,
  483241,
  1,
  'FSC454_RS02430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glyQ',
  'glycine--tRNA ligase subunit alpha',
  483332,
  484222,
  1,
  'FSC454_RS02435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044837.1',
  'UDP-N-acetylmuramoyl-L-alanyl-D-glutamate--2,6-diaminopimelate ligase',
  484433,
  485860,
  1,
  'FSC454_RS02440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_325148002.1',
  'DUF4156 domain-containing protein',
  485915,
  486310,
  1,
  'FSC454_RS02445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044840.1',
  'UDP-N-acetylmuramoyl-tripeptide--D-alanyl-D-alanine ligase',
  486479,
  487837,
  1,
  'FSC454_RS02450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'asd',
  'aspartate-semialdehyde dehydrogenase',
  487838,
  488962,
  -1,
  'FSC454_RS02455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'aspartate kinase',
  489058,
  491545,
  1,
  'FSC454_RS02460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044845.1',
  'homoserine kinase',
  491542,
  492495,
  1,
  'FSC454_RS02465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'thrC',
  'threonine synthase',
  492508,
  493791,
  1,
  'FSC454_RS02470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044849.1',
  'UDP-2,3-diacylglucosamine diphosphatase',
  493833,
  494555,
  -1,
  'FSC454_RS02475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pyrE',
  'orotate phosphoribosyltransferase',
  494545,
  495171,
  -1,
  'FSC454_RS02480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mpl',
  'UDP-N-acetylmuramate:L-alanyl-gamma-D-glutamyl-meso-diaminopimelate ligase',
  495331,
  496701,
  1,
  'FSC454_RS02485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rlmB',
  '23S rRNA(guanosine(2251)-2''-O)-methyltransferase RlmB',
  496698,
  497444,
  1,
  'FSC454_RS02490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DALR anticodon-binding domain-containingprotein',
  497655,
  497767,
  1,
  'FSC454_RS09925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044857.1',
  'hypothetical protein',
  497821,
  498237,
  -1,
  'FSC454_RS02495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044858.1',
  'hypothetical protein',
  498490,
  498909,
  1,
  'FSC454_RS02500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'argS',
  'arginine--tRNA ligase',
  498961,
  500706,
  -1,
  'FSC454_RS02505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044862.1',
  'LPS-assembly protein LptD',
  500832,
  503438,
  1,
  'FSC454_RS02510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044864.1',
  'SurA N-terminal domain-containing protein',
  503438,
  504847,
  1,
  'FSC454_RS02515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsmA',
  '16S rRNA(adenine(1518)-N(6)/adenine(1519)-N(6))-dimethyltransferase RsmA',
  504849,
  505637,
  1,
  'FSC454_RS02520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044868.1',
  'symmetrical bis(5''-nucleosyl)-tetraphosphatase',
  505649,
  506476,
  1,
  'FSC454_RS02525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroQ',
  'type II 3-dehydroquinate dehydratase',
  506480,
  506917,
  1,
  'FSC454_RS02530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'accB',
  'acetyl-CoA carboxylase biotin carboxyl carrierprotein',
  506923,
  507393,
  1,
  'FSC454_RS02535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'accC',
  'acetyl-CoA carboxylase biotin carboxylasesubunit',
  507457,
  508812,
  1,
  'FSC454_RS02540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044874.1',
  'helix-turn-helix domain-containing protein',
  508910,
  509605,
  1,
  'FSC454_RS02545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044876.1',
  'mechanosensitive ion channel family protein',
  509651,
  510769,
  1,
  'FSC454_RS02550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'epmA',
  'EF-P lysine aminoacylase EpmA',
  510774,
  511697,
  -1,
  'FSC454_RS02555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044879.1',
  'biotin--[acetyl-CoA-carboxylase] ligase',
  511694,
  512476,
  -1,
  'FSC454_RS02560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recJ',
  'single-stranded-DNA-specific exonuclease RecJ',
  512473,
  514218,
  -1,
  'FSC454_RS02565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044881.1',
  'AI-2E family transporter',
  514212,
  515318,
  -1,
  'FSC454_RS02570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gadC',
  'glutamate transporter GadC',
  515420,
  516829,
  -1,
  'FSC454_RS02575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044885.1',
  'polyamine ABC transporter substrate-bindingprotein',
  516913,
  518094,
  1,
  'FSC454_RS02580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DUF3281 family protein',
  518339,
  519155,
  -1,
  'FSC454_RS02585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsgA',
  'ribosome small subunit-dependent GTPase A',
  519369,
  520256,
  -1,
  'FSC454_RS02590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044889.1',
  'DUF2147 domain-containing protein',
  520412,
  521131,
  1,
  'FSC454_RS02595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044891.1',
  'DUF2147 domain-containing protein',
  521199,
  521861,
  1,
  'FSC454_RS02600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mutL',
  'DNA mismatch repair endonuclease MutL',
  521868,
  523670,
  1,
  'FSC454_RS02605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044893.1',
  'MFS transporter',
  523856,
  525073,
  1,
  'FSC454_RS02610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794764.1',
  'MFS transporter',
  525091,
  526359,
  -1,
  'FSC454_RS02615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trxB',
  'thioredoxin-disulfide reductase',
  526464,
  527414,
  -1,
  'FSC454_RS02620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044953.1',
  'HAD-IA family hydrolase',
  527536,
  528213,
  -1,
  'FSC454_RS02625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044955.1',
  'LysR family transcriptional regulator',
  528271,
  529197,
  -1,
  'FSC454_RS02630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044957.1',
  'MFS transporter',
  529308,
  530474,
  1,
  'FSC454_RS02635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044959.1',
  'copper homeostasis protein CutC',
  530489,
  531211,
  -1,
  'FSC454_RS02640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DUF1543 domain-containing protein',
  531574,
  532076,
  1,
  'FSC454_RS02645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044961.1',
  'glycosylasparaginase',
  532268,
  533188,
  -1,
  'FSC454_RS02650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044963.1',
  'peptide MFS transporter',
  533192,
  534637,
  -1,
  'FSC454_RS02655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044965.1',
  'ATP-grasp domain-containing protein',
  534874,
  536094,
  1,
  'FSC454_RS02660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470841.1',
  'AI-2E family transporter',
  536238,
  537278,
  -1,
  'FSC454_RS02665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044968.1',
  'SDR family oxidoreductase',
  537348,
  538055,
  -1,
  'FSC454_RS02670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865136.1',
  'hypothetical protein',
  538473,
  538913,
  -1,
  'FSC454_RS09930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sucD',
  'succinate--CoA ligase subunit alpha',
  539027,
  539899,
  -1,
  'FSC454_RS02680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sucC',
  'ADP-forming succinate--CoA ligase subunit beta',
  539931,
  541094,
  -1,
  'FSC454_RS02685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794765.1',
  'TIGR03546 family protein',
  541264,
  543180,
  1,
  'FSC454_RS02690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dusA',
  'tRNA dihydrouridine(20/20a) synthase DusA',
  543300,
  544274,
  -1,
  'FSC454_RS02695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'chaC',
  'gamma-glutamylcyclotransferase ChaC',
  544309,
  545109,
  -1,
  'FSC454_RS02700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gyrB',
  'DNA topoisomerase (ATP-hydrolyzing) subunit B',
  545291,
  547702,
  1,
  'FSC454_RS02705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pdxS',
  'pyridoxal 5''-phosphate synthase lyase subunitPdxS',
  547832,
  548695,
  1,
  'FSC454_RS02710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pdxT',
  'pyridoxal 5''-phosphate synthase glutaminasesubunit PdxT',
  548698,
  549237,
  1,
  'FSC454_RS02715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mutM',
  'bifunctional DNA-formamidopyrimidineglycosylase/DNA-(apurinic or apyrimidinic site) lyase',
  549240,
  550064,
  -1,
  'FSC454_RS02720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'migR',
  'iglABCD operon regulator MigR',
  550158,
  552257,
  1,
  'FSC454_RS02725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsmH',
  '16S rRNA (cytosine(1402)-N(4))-methyltransferaseRsmH',
  552263,
  553180,
  1,
  'FSC454_RS02730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftsL',
  'cell division protein FtsL',
  553177,
  553527,
  1,
  'FSC454_RS02735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'peptidoglycan D,D-transpeptidase FtsI familyprotein',
  553520,
  555218,
  1,
  'FSC454_RS02740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsO',
  '30S ribosomal protein S15',
  555324,
  555590,
  1,
  'FSC454_RS02745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pnp',
  'polyribonucleotide nucleotidyltransferase',
  555646,
  557730,
  1,
  'FSC454_RS02750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'erpA',
  'iron-sulfur cluster insertion protein ErpA',
  557772,
  558122,
  1,
  'FSC454_RS02755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'kdsA',
  '3-deoxy-8-phosphooctulonate synthase',
  558153,
  558980,
  1,
  'FSC454_RS02760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'udk',
  'uridine kinase',
  558991,
  559656,
  1,
  'FSC454_RS02765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpoZ',
  'DNA-directed RNA polymerase subunit omega',
  559649,
  559867,
  1,
  'FSC454_RS02770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  559931,
  560006,
  1,
  'FSC454_RS02775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044992.1',
  'hypothetical protein',
  560131,
  560697,
  1,
  'FSC454_RS02780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rlmD',
  '23S rRNA (uracil(1939)-C(5))-methyltransferaseRlmD',
  560786,
  562135,
  1,
  'FSC454_RS02785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044996.1',
  'ROK family protein',
  562138,
  563103,
  1,
  'FSC454_RS02790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044998.1',
  'ROK family protein',
  563103,
  564050,
  1,
  'FSC454_RS02795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  564071,
  564835,
  1,
  'FSC454_RS02800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470843.1',
  'MFS transporter',
  564920,
  566173,
  1,
  'FSC454_RS02805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'eno',
  'phosphopyruvate hydratase',
  566281,
  567651,
  1,
  'FSC454_RS02810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547878.1',
  'FtsB family cell division protein',
  567659,
  567949,
  1,
  'FSC454_RS02815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ispD',
  '2-C-methyl-D-erythritol 4-phosphatecytidylyltransferase',
  567939,
  568628,
  1,
  'FSC454_RS02820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'amino acid permease',
  568633,
  569894,
  -1,
  'FSC454_RS02825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tdh',
  'L-threonine 3-dehydrogenase',
  569896,
  570951,
  -1,
  'FSC454_RS02830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045007.1',
  'glycine C-acetyltransferase',
  570969,
  572162,
  -1,
  'FSC454_RS02835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794767.1',
  'glycosyl hydrolase family 18 protein',
  572600,
  575257,
  1,
  'FSC454_RS02840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'upp',
  'uracil phosphoribosyltransferase',
  575459,
  576088,
  1,
  'FSC454_RS02845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purU',
  'formyltetrahydrofolate deformylase',
  576170,
  577003,
  1,
  'FSC454_RS02850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046835.1',
  'tautomerase family protein',
  577128,
  577469,
  1,
  'FSC454_RS02855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046837.1',
  'MFS transporter',
  577530,
  578750,
  1,
  'FSC454_RS02860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dgt',
  'dGTP triphosphohydrolase',
  578734,
  580059,
  -1,
  'FSC454_RS02865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'katG',
  'catalase/peroxidase HPI',
  580161,
  582380,
  -1,
  'FSC454_RS02870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046844.1',
  'adenosine deaminase',
  582632,
  583582,
  1,
  'FSC454_RS02875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470918.1',
  'SDR family oxidoreductase',
  583673,
  584458,
  -1,
  'FSC454_RS02880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dacB',
  'D-alanyl-D-alaninecarboxypeptidase/D-alanyl-D-alanine endopeptidase',
  584452,
  585846,
  -1,
  'FSC454_RS02885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046850.1',
  'MFS transporter',
  585861,
  587177,
  -1,
  'FSC454_RS02890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046852.1',
  'glycerophosphodiester phosphodiesterase',
  587282,
  588310,
  -1,
  'FSC454_RS02895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046854.1',
  'HlyD family secretion protein',
  588454,
  589425,
  1,
  'FSC454_RS02900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046856.1',
  'ABC transporter ATP-binding protein',
  589422,
  590354,
  1,
  'FSC454_RS02905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046858.1',
  'ABC transporter permease',
  590351,
  591469,
  1,
  'FSC454_RS02910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046860.1',
  'SulP family inorganic anion transporter',
  591565,
  593109,
  1,
  'FSC454_RS02915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046862.1',
  'RidA family protein',
  593109,
  593489,
  1,
  'FSC454_RS02920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dctA',
  'C4-dicarboxylate transporter DctA',
  593627,
  594877,
  1,
  'FSC454_RS02925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046866.1',
  'type I restriction-modification system subunitM',
  594971,
  596587,
  1,
  'FSC454_RS02930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046868.1',
  'restriction endonuclease subunit S',
  596571,
  597722,
  1,
  'FSC454_RS02935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046869.1',
  'hypothetical protein',
  597725,
  598015,
  1,
  'FSC454_RS02940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046871.1',
  'hypothetical protein',
  597999,
  598493,
  1,
  'FSC454_RS02945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003035998.1',
  'AbrB/MazE/SpoVT family DNA-bindingdomain-containing protein',
  598690,
  598941,
  1,
  'FSC454_RS02950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549563.1',
  'type II toxin-antitoxin system PemK/MazF familytoxin',
  598938,
  599270,
  1,
  'FSC454_RS02955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'type I restriction endonuclease subunit R',
  599278,
  602088,
  1,
  'FSC454_RS10220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456248.1',
  'IS630 family transposase',
  602108,
  602641,
  -1,
  'FSC454_RS02965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045226.1',
  'IS630 transposase-related protein',
  602571,
  602921,
  -1,
  'FSC454_RS02970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'type I restriction enzyme endonucleasedomain-containing protein',
  602966,
  603298,
  1,
  'FSC454_RS02975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cydC',
  'heme ABC transporter ATP-bindingprotein/permease CydC',
  603299,
  604948,
  -1,
  'FSC454_RS02980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cydD',
  'heme ABC transporter permease/ATP-bindingprotein CydD',
  604945,
  606726,
  -1,
  'FSC454_RS02985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045964.1',
  'rotein',
  607032,
  607541,
  1,
  'FSC454_RS02990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045966.1',
  'hypothetical protein',
  607567,
  607767,
  1,
  'FSC454_RS02995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS02995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045969.1',
  'lipopolysaccharide biosynthesis protein',
  607772,
  609031,
  -1,
  'FSC454_RS03000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_414842596.1',
  'amino acid permease',
  609096,
  610451,
  -1,
  'FSC454_RS03005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045975.1',
  'ROK family protein',
  610561,
  611451,
  -1,
  'FSC454_RS03010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'serS',
  'serine--tRNA ligase',
  611562,
  612842,
  -1,
  'FSC454_RS03015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gpmI',
  '2,3-bisphosphoglycerate-independentphosphoglycerate mutase',
  612857,
  614395,
  -1,
  'FSC454_RS03020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045982.1',
  'FAD-binding and (Fe-S)-binding domain-containingprotein',
  614613,
  617645,
  1,
  'FSC454_RS03025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  617667,
  617742,
  1,
  'FSC454_RS03030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045987.1',
  'tyrosine-type recombinase/integrase',
  617909,
  619171,
  1,
  'FSC454_RS03035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045989.1',
  'CopG family transcriptional regulator',
  619306,
  619536,
  1,
  'FSC454_RS03040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865151.1',
  'type II toxin-antitoxin system mRNA interferasetoxin, RelE/StbE family',
  619630,
  619818,
  1,
  'FSC454_RS03045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046429.1',
  'hypothetical protein',
  619917,
  620597,
  1,
  'FSC454_RS03050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046430.1',
  'helix-turn-helix transcriptional regulator',
  620751,
  620930,
  1,
  'FSC454_RS03055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_279625859.1',
  'hypothetical protein',
  621292,
  621426,
  1,
  'FSC454_RS10095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794768.1',
  'hypothetical protein',
  621404,
  621610,
  1,
  'FSC454_RS03065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148263.1',
  'hypothetical protein',
  621623,
  621898,
  1,
  'FSC454_RS09945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148264.1',
  'toprim domain-containing protein',
  622038,
  622523,
  1,
  'FSC454_RS09950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046222.1',
  'DUF3987 domain-containing protein',
  622525,
  624036,
  1,
  'FSC454_RS03075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794769.1',
  'hypothetical protein',
  624386,
  624787,
  1,
  'FSC454_RS03080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046489.1',
  'TA system antitoxin ParD family protein',
  624885,
  625106,
  1,
  'FSC454_RS03085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865163.1',
  'type II toxin-antitoxin system RelE/ParE familytoxin',
  625090,
  625368,
  1,
  'FSC454_RS03090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046493.1',
  'hypothetical protein',
  625504,
  625806,
  1,
  'FSC454_RS03095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046495.1',
  'hypothetical protein',
  625806,
  626021,
  1,
  'FSC454_RS03100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046497.1',
  'CopG family transcriptional regulator',
  626018,
  626197,
  1,
  'FSC454_RS09770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046498.1',
  'hypothetical protein',
  626206,
  626394,
  1,
  'FSC454_RS03110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794770.1',
  'terminase small subunit',
  626394,
  626828,
  1,
  'FSC454_RS03115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046500.1',
  'LexA family protein',
  627176,
  627829,
  -1,
  'FSC454_RS03120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046502.1',
  'normocyte binding protein 2b',
  627997,
  628428,
  1,
  'FSC454_RS03125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046504.1',
  'DMT family transporter',
  628383,
  629249,
  -1,
  'FSC454_RS03130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046506.1',
  'FMN-binding glutamate synthase family protein',
  629429,
  631015,
  1,
  'FSC454_RS03135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recC',
  'exodeoxyribonuclease V subunit gamma',
  631092,
  634304,
  1,
  'FSC454_RS03140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046510.1',
  'FUSC family protein',
  634288,
  634818,
  1,
  'FSC454_RS03145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recB',
  'exodeoxyribonuclease V subunit beta',
  634859,
  638479,
  1,
  'FSC454_RS03150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recD',
  'exodeoxyribonuclease V subunit alpha',
  638472,
  640244,
  1,
  'FSC454_RS03155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'type III pantothenate kinase',
  640377,
  641146,
  -1,
  'FSC454_RS03160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'panD',
  'aspartate 1-decarboxylase',
  641150,
  641485,
  -1,
  'FSC454_RS03165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'panC',
  'pantoate--beta-alanine ligase',
  641479,
  642264,
  -1,
  'FSC454_RS03170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'panB',
  '3-methyl-2-oxobutanoatehydroxymethyltransferase',
  642251,
  643048,
  -1,
  'FSC454_RS03175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'panG',
  '2-dehydropantoate 2-reductase PanG',
  643050,
  643766,
  -1,
  'FSC454_RS03180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ligA',
  'NAD-dependent DNA ligase LigA',
  644083,
  646119,
  1,
  'FSC454_RS03185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047524.1',
  'YiiX/YebB-like N1pC/P60 family cysteinehydrolase',
  646116,
  646655,
  1,
  'FSC454_RS03190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047521.1',
  'GNAT family N-acetyltransferase',
  646752,
  647243,
  1,
  'FSC454_RS03195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsmB',
  '16S rRNA (cytosine(967)-C(5))-methyltransferaseRsmB',
  647221,
  648501,
  -1,
  'FSC454_RS03200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047515.1',
  'inositol monophosphatase family protein',
  648501,
  649289,
  -1,
  'FSC454_RS03205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548697.1',
  'YeiH family protein',
  649376,
  650428,
  -1,
  'FSC454_RS03210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tsgA',
  'MFS transporter TsgA',
  650527,
  651741,
  -1,
  'FSC454_RS03215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mnmC2',
  'tRNA(5-methylaminomethyl-2-thiouridine)(34)-methyltransferaseMnmC2',
  651864,
  652550,
  1,
  'FSC454_RS03220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003018210.1',
  'YciI family protein',
  652540,
  652824,
  -1,
  'FSC454_RS03225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fabF',
  'beta-ketoacyl-ACP synthase II',
  652911,
  654170,
  -1,
  'FSC454_RS03230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'acpP',
  'acyl carrier protein',
  654251,
  654535,
  -1,
  'FSC454_RS03235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fabG',
  '3-oxoacyl-ACP reductase FabG',
  654632,
  655375,
  -1,
  'FSC454_RS03240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fabD',
  'ACP S-malonyltransferase',
  655389,
  656309,
  -1,
  'FSC454_RS03245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548690.1',
  'beta-ketoacyl-ACP synthase III',
  656358,
  657329,
  -1,
  'FSC454_RS03250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'plsX',
  'phosphate acyltransferase PlsX',
  657428,
  658474,
  -1,
  'FSC454_RS03255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmF',
  '50S ribosomal protein L32',
  658574,
  658756,
  -1,
  'FSC454_RS03260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047505.1',
  'YceD family protein',
  658800,
  659303,
  -1,
  'FSC454_RS03265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tkt',
  'transketolase',
  659437,
  661428,
  1,
  'FSC454_RS03270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gap',
  'type I glyceraldehyde-3-phosphate dehydrogenase',
  661470,
  662471,
  1,
  'FSC454_RS03275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047497.1',
  'phosphoglycerate kinase',
  662492,
  663670,
  1,
  'FSC454_RS03280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pyk',
  'pyruvate kinase',
  663686,
  665122,
  1,
  'FSC454_RS03285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fba',
  'class II fructose-bisphosphate aldolase',
  665133,
  666197,
  1,
  'FSC454_RS03290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047529.1',
  'trehalase family glycosidase',
  666290,
  667747,
  -1,
  'FSC454_RS03295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148265.1',
  'MFS transporter',
  667749,
  668900,
  -1,
  'FSC454_RS03300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'anmK',
  'anhydro-N-acetylmuramic acid kinase AnmK',
  669121,
  670236,
  1,
  'FSC454_RS03305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047485.1',
  'Pathogenicity determinant protein D',
  670336,
  674070,
  1,
  'FSC454_RS03310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tssB',
  'type VI secretion system contractile sheathsmall subunit',
  674149,
  674703,
  1,
  'FSC454_RS03315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tssC',
  'type VI secretion system contractile sheathlarge subunit',
  674715,
  676235,
  1,
  'FSC454_RS03320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'iglC',
  'type VI secretion system tube protein IglC',
  676252,
  676881,
  1,
  'FSC454_RS03325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tssK',
  'type VI secretion system baseplate subunit TssK',
  676902,
  678098,
  1,
  'FSC454_RS03330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pdpE',
  'type VI secretion system protein PdpE',
  678208,
  678798,
  -1,
  'FSC454_RS03335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pdpC',
  'type VI secretion system effector PdpC',
  678816,
  682790,
  -1,
  'FSC454_RS03340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'iglJ',
  'type VI secretion system baseplate protein IglJ',
  682831,
  683538,
  -1,
  'FSC454_RS03345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794775.1',
  'type VI secretion system protein IglI familyprotein',
  683562,
  684722,
  -1,
  'FSC454_RS03350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044915.1',
  'DotU family type IV/VI secretion system protein',
  684737,
  685363,
  -1,
  'FSC454_RS03355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'iglH',
  'type VI secretion system baseplate subunitTssF/IglH',
  685376,
  686809,
  -1,
  'FSC454_RS03360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'iglG',
  'type VI secretion system PAAR-like protein IglG',
  686822,
  687343,
  -1,
  'FSC454_RS03365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'iglF',
  'type VI secretion system putative effector IglF',
  687344,
  689073,
  -1,
  'FSC454_RS03370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tssI',
  'type VI secretion system tip protein TssI/VgrG',
  689077,
  689571,
  -1,
  'FSC454_RS03375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'iglE',
  'type VI secretion system lipoprotein IglE',
  689584,
  689958,
  -1,
  'FSC454_RS03380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794776.1',
  'hypothetical protein',
  689948,
  693226,
  -1,
  'FSC454_RS03385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046688.1',
  'pathogenicity determinant protein PdpA1',
  693231,
  695693,
  -1,
  'FSC454_RS03390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  696074,
  697600,
  1,
  'FSC454_RS03395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  697697,
  697773,
  1,
  'FSC454_RS03400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  697788,
  697863,
  1,
  'FSC454_RS03405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  697916,
  700803,
  1,
  'FSC454_RS03410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rrf',
  '—',
  700851,
  700965,
  1,
  'FSC454_RS03415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046449.1',
  'hypothetical protein',
  701194,
  701490,
  1,
  'FSC454_RS03420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'helix-turn-helix domain-containing protein',
  701931,
  702053,
  -1,
  'FSC454_RS09645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046450.1',
  'transposase',
  702146,
  702433,
  -1,
  'FSC454_RS03425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS630 transposase-related protein',
  702492,
  702851,
  -1,
  'FSC454_RS09955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794777.1',
  'DUF892 family protein',
  703238,
  703693,
  1,
  'FSC454_RS03435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046451.1',
  'disulfide bond formation protein B',
  703732,
  704304,
  -1,
  'FSC454_RS03440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003025430.1',
  'DUF5993 family protein',
  704322,
  704480,
  -1,
  'FSC454_RS09775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046452.1',
  'PLP-dependent cysteine synthase family protein',
  704567,
  705490,
  -1,
  'FSC454_RS03445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046453.1',
  'linear amide C-N hydrolase',
  705711,
  706766,
  -1,
  'FSC454_RS03450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046454.1',
  'LysR family transcriptional regulator',
  706899,
  707792,
  1,
  'FSC454_RS03455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mnmE',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis GTPase MnmE',
  708046,
  709398,
  -1,
  'FSC454_RS03460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548656.1',
  'hypothetical protein',
  709401,
  709646,
  -1,
  'FSC454_RS03465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hpf',
  'ribosome hibernation-promoting factor, HPF/YfiAfamily',
  709765,
  710061,
  1,
  'FSC454_RS03470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548655.1',
  'PTS sugar transporter subunit IIA',
  710098,
  710553,
  1,
  'FSC454_RS03475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548654.1',
  'RNA methyltransferase',
  710546,
  711295,
  1,
  'FSC454_RS03480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rnhB',
  'ribonuclease HII',
  711292,
  711849,
  1,
  'FSC454_RS03485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'sodium:solute symporter family protein',
  711853,
  713113,
  1,
  'FSC454_RS03490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mglB',
  'transcriptional regulator MglB',
  713119,
  713526,
  -1,
  'FSC454_RS03495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mglA',
  'transcriptional regulator MglA',
  713528,
  714145,
  -1,
  'FSC454_RS03500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsI',
  '30S ribosomal protein S9',
  714204,
  714593,
  -1,
  'FSC454_RS09535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplM',
  '50S ribosomal protein L13',
  714609,
  715037,
  -1,
  'FSC454_RS09540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046459.1',
  'NAD(P)-binding protein',
  715176,
  716360,
  -1,
  'FSC454_RS03510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mltA',
  'murein transglycosylase A',
  716353,
  717504,
  -1,
  'FSC454_RS03515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'grpE',
  'nucleotide exchange factor GrpE',
  717608,
  718195,
  1,
  'FSC454_RS03520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaK',
  'molecular chaperone DnaK',
  718291,
  720219,
  1,
  'FSC454_RS03525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaJ',
  'molecular chaperone DnaJ',
  720308,
  721429,
  1,
  'FSC454_RS03530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548644.1',
  'LysR family transcriptional regulator',
  721451,
  722347,
  -1,
  'FSC454_RS03535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046463.1',
  'pirin family protein',
  722448,
  723146,
  1,
  'FSC454_RS03540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046464.1',
  'flavodoxin family protein',
  723161,
  723727,
  1,
  'FSC454_RS03545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046465.1',
  'hypothetical protein',
  723822,
  724244,
  -1,
  'FSC454_RS03550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nadE',
  'NAD(+) synthase',
  724348,
  725097,
  -1,
  'FSC454_RS03555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'silC',
  'TolC family protein SilC',
  725224,
  726696,
  -1,
  'FSC454_RS03560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548638.1',
  'HlyD family secretion protein',
  726706,
  727731,
  -1,
  'FSC454_RS03565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046468.1',
  'MDR family MFS transporter',
  727752,
  729281,
  -1,
  'FSC454_RS03570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456266.1',
  'AraC family transcriptional regulator',
  729447,
  730274,
  1,
  'FSC454_RS03575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548635.1',
  'long-chain-fatty-acid--CoA ligase',
  730262,
  731953,
  -1,
  'FSC454_RS03580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_080555366.1',
  'oligopeptide:H+ symporter',
  732060,
  733550,
  -1,
  'FSC454_RS03585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548633.1',
  '16S rRNA (uracil(1498)-N(3))-methyltransferase',
  733772,
  734500,
  -1,
  'FSC454_RS03590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794778.1',
  'DUF445 family protein',
  734571,
  735257,
  1,
  'FSC454_RS03595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046483.1',
  'hypothetical protein',
  735247,
  735945,
  -1,
  'FSC454_RS03600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548630.1',
  'MlaD family protein',
  735950,
  736675,
  -1,
  'FSC454_RS03605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046471.1',
  'ABC transporter ATP-binding protein',
  736685,
  737446,
  -1,
  'FSC454_RS03610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548628.1',
  'MlaE family ABC transporter permease',
  737461,
  738561,
  -1,
  'FSC454_RS03615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046473.1',
  'glucosaminidase domain-containing protein',
  738637,
  739449,
  -1,
  'FSC454_RS03620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548626.1',
  'RluA family pseudouridine synthase',
  739427,
  740422,
  -1,
  'FSC454_RS03625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548625.1',
  'outer membrane protein assembly factor BamD',
  740510,
  741334,
  1,
  'FSC454_RS03630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046475.1',
  'FAD-dependent oxidoreductase',
  741448,
  743244,
  1,
  'FSC454_RS03635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046477.1',
  'hypothetical protein',
  743295,
  744746,
  -1,
  'FSC454_RS03640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glyA',
  'serine hydroxymethyltransferase',
  744942,
  746195,
  -1,
  'FSC454_RS03645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yjgA',
  'ribosome biogenesis factor YjgA',
  746299,
  746847,
  1,
  'FSC454_RS03650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DUF6056 family protein',
  746862,
  748132,
  -1,
  'FSC454_RS03655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794838.1',
  'O-antigen ligase family protein',
  748352,
  749680,
  1,
  'FSC454_RS03660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794779.1',
  'glycosyltransferase family 8 protein',
  749705,
  750595,
  -1,
  'FSC454_RS03665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045393.1',
  'hypothetical protein',
  750588,
  751682,
  -1,
  'FSC454_RS03670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156860526.1',
  'transposase',
  751836,
  752114,
  1,
  'FSC454_RS03675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794781.1',
  'transposase',
  752093,
  752470,
  1,
  'FSC454_RS03680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS5 family transposase',
  752503,
  753243,
  1,
  'FSC454_RS03685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS982 family transposase',
  753344,
  754205,
  1,
  'FSC454_RS03690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044633.1',
  'glycosyltransferase family 4 protein',
  754326,
  755390,
  1,
  'FSC454_RS03695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044635.1',
  'choloylglycine hydrolase family protein',
  755391,
  756536,
  -1,
  'FSC454_RS03700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794783.1',
  'peptide MFS transporter',
  756723,
  758159,
  1,
  'FSC454_RS03705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tilS',
  'tRNA lysidine(34) synthetase TilS',
  758168,
  759365,
  -1,
  'FSC454_RS03710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'serA',
  'phosphoglycerate dehydrogenase',
  759366,
  760602,
  -1,
  'FSC454_RS03715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044642.1',
  'thymidylate synthase',
  760613,
  761437,
  -1,
  'FSC454_RS03720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lgt',
  'prolipoprotein diacylglyceryl transferase',
  761422,
  762228,
  -1,
  'FSC454_RS03725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044644.1',
  'Rne/Rng family ribonuclease',
  762243,
  764903,
  -1,
  'FSC454_RS03730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044646.1',
  'cysteine desulfurase family protein',
  765152,
  766327,
  1,
  'FSC454_RS03740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044648.1',
  'hypothetical protein',
  766320,
  766649,
  1,
  'FSC454_RS03745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recO',
  'DNA repair protein RecO',
  766633,
  767331,
  1,
  'FSC454_RS03750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044652.1',
  'VTT domain-containing protein',
  767401,
  768048,
  -1,
  'FSC454_RS03755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044653.1',
  'VTT domain-containing protein',
  768104,
  768730,
  -1,
  'FSC454_RS03760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044655.1',
  'BolA family protein',
  768738,
  769004,
  -1,
  'FSC454_RS03765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044657.1',
  '5-formyltetrahydrofolate cyclo-ligase',
  769007,
  769555,
  -1,
  'FSC454_RS03770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ssrS',
  '—',
  769580,
  769775,
  -1,
  'FSC454_RS03775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044659.1',
  'UPF0149 family protein',
  770000,
  770536,
  1,
  'FSC454_RS03780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044661.1',
  'FAD-dependent monooxygenase',
  770545,
  771756,
  1,
  'FSC454_RS03785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044663.1',
  'UbiH/UbiF/VisC/COQ6 family ubiquinonebiosynthesis hydroxylase',
  771746,
  773005,
  1,
  'FSC454_RS03790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044665.1',
  'hypothetical protein',
  773028,
  773489,
  1,
  'FSC454_RS03795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'queA',
  'tRNA preQ1(34) S-adenosylmethionineribosyltransferase-isomerase QueA',
  773515,
  774531,
  1,
  'FSC454_RS03800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044668.1',
  'Cof-type HAD-IIB family hydrolase',
  774839,
  775624,
  1,
  'FSC454_RS03805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044670.1',
  'hypothetical protein',
  775689,
  776348,
  1,
  'FSC454_RS03810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548591.1',
  'queuosine precursor transporter',
  776360,
  777079,
  -1,
  'FSC454_RS03815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gloA',
  'lactoylglutathione lyase',
  777195,
  777578,
  1,
  'FSC454_RS03820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548589.1',
  'hypothetical protein',
  777578,
  778153,
  1,
  'FSC454_RS03825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548588.1',
  'hypothetical protein',
  778142,
  778387,
  -1,
  'FSC454_RS03830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044672.1',
  'LOG family protein',
  778401,
  779114,
  -1,
  'FSC454_RS03835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548586.1',
  'enoyl-ACP reductase FabI',
  779395,
  780177,
  1,
  'FSC454_RS03840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044673.1',
  'KpsF/GutQ family sugar-phosphate isomerase',
  780551,
  781522,
  -1,
  'FSC454_RS03845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpe',
  'ribulose-phosphate 3-epimerase',
  781656,
  782324,
  1,
  'FSC454_RS03850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044678.1',
  'sugar transferase',
  782305,
  783699,
  1,
  'FSC454_RS03855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'galE',
  'UDP-glucose 4-epimerase GalE',
  783692,
  784711,
  1,
  'FSC454_RS03860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044682.1',
  'glycosyltransferase family 4 protein',
  784720,
  785835,
  1,
  'FSC454_RS03865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148266.1',
  'flippase',
  785741,
  787129,
  1,
  'FSC454_RS03870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044686.1',
  'nucleotide sugar dehydrogenase',
  787126,
  788295,
  1,
  'FSC454_RS03875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044688.1',
  'NAD-dependent epimerase/dehydratase familyprotein',
  788304,
  789167,
  1,
  'FSC454_RS03880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044690.1',
  'nucleotide-diphospho-sugar transferase',
  789169,
  790095,
  1,
  'FSC454_RS03885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156860527.1',
  'hypothetical protein',
  790092,
  790268,
  1,
  'FSC454_RS09650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359442.1',
  'polysaccharide pyruvyl transferase familyprotein',
  790298,
  791128,
  1,
  'FSC454_RS03890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794784.1',
  'nitroreductase family protein',
  791121,
  792125,
  1,
  'FSC454_RS03895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044697.1',
  'glycosyltransferase family 4 protein',
  792122,
  793360,
  1,
  'FSC454_RS03900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gmd',
  'GDP-mannose 4,6-dehydratase',
  793357,
  794475,
  1,
  'FSC454_RS03905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fcl',
  'GDP-L-fucose synthase',
  794477,
  795436,
  1,
  'FSC454_RS03910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148267.1',
  'glycosyltransferase family 2 protein',
  795461,
  796111,
  1,
  'FSC454_RS03915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044704.1',
  'glycosyltransferase family 2 protein',
  796268,
  797260,
  1,
  'FSC454_RS03920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044706.1',
  'glycosyltransferase family 4 protein',
  797263,
  798276,
  1,
  'FSC454_RS03925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044708.1',
  'pyrimidine 5''-nucleotidase',
  798295,
  798957,
  1,
  'FSC454_RS03930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044710.1',
  'YoaK family protein',
  799200,
  799844,
  -1,
  'FSC454_RS03935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044712.1',
  'multidrug effflux MFS transporter',
  799866,
  801065,
  -1,
  'FSC454_RS03940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044714.1',
  'FUSC family protein',
  801323,
  802366,
  1,
  'FSC454_RS03945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044715.1',
  'MFS transporter',
  802446,
  803672,
  1,
  'FSC454_RS03950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044717.1',
  'ATP-binding cassette domain-containing protein',
  803706,
  805547,
  1,
  'FSC454_RS03955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044718.1',
  'peptide MFS transporter',
  805619,
  807046,
  1,
  'FSC454_RS03960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044720.1',
  'glycosyltransferase family 39 protein',
  807075,
  808532,
  -1,
  'FSC454_RS03965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044722.1',
  'glutamine--tRNA ligase/YqeY domain fusionprotein',
  808553,
  810199,
  -1,
  'FSC454_RS03970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548558.1',
  'phosphoenolpyruvate carboxykinase (ATP)',
  810349,
  811935,
  1,
  'FSC454_RS03975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mraY',
  'phospho-N-acetylmuramoyl-pentapeptide-transferase',
  812010,
  813110,
  1,
  'FSC454_RS03980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murD',
  'UDP-N-acetylmuramoyl-L-alanine--D-glutamateligase',
  813110,
  814363,
  1,
  'FSC454_RS03985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftsW',
  'putative lipid II flippase FtsW',
  814377,
  815582,
  1,
  'FSC454_RS03990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'naxD',
  'N-acetylhexosamine deacetylase NaxD',
  815590,
  816396,
  -1,
  'FSC454_RS03995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS03995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470836.1',
  'glycosyltransferase family 2 protein',
  816495,
  817451,
  1,
  'FSC454_RS04000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044732.1',
  'ArnT family glycosyltransferase',
  817674,
  819437,
  -1,
  'FSC454_RS04005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548551.1',
  'oxidative damage protection protein',
  819529,
  819792,
  -1,
  'FSC454_RS04010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044734.1',
  'TusE/DsrC/DsvC family sulfur relay protein',
  819816,
  820130,
  -1,
  'FSC454_RS04015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sspA',
  'transcriptional regulator SspA',
  820216,
  820848,
  1,
  'FSC454_RS04020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sohB',
  'protease SohB',
  820860,
  821876,
  1,
  'FSC454_RS04025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044737.1',
  'DNA polymerase III delta subunit-relatedprotein',
  821884,
  822795,
  1,
  'FSC454_RS04030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yhbY',
  'ribosome assembly RNA-binding protein YhbY',
  822807,
  823085,
  1,
  'FSC454_RS04035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemB',
  'porphobilinogen synthase',
  823093,
  824064,
  1,
  'FSC454_RS04040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trmL',
  'tRNA(uridine(34)/cytosine(34)/5-carboxymethylaminomethyluridine(34)-2''-O)-methyltransferase TrmL',
  824066,
  824533,
  1,
  'FSC454_RS04045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044742.1',
  'asparaginase',
  824655,
  825719,
  1,
  'FSC454_RS04050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548542.1',
  'oligopeptide:H+ symporter',
  825743,
  827191,
  -1,
  'FSC454_RS04055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044744.1',
  'carbohydrate kinase family protein',
  827490,
  828596,
  -1,
  'FSC454_RS04060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548540.1',
  'cyanophycinase',
  828798,
  829616,
  1,
  'FSC454_RS04065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548539.1',
  'isoaspartyl peptidase/L-asparaginase',
  829818,
  830681,
  1,
  'FSC454_RS04070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  830739,
  830814,
  1,
  'FSC454_RS04075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  830832,
  830908,
  1,
  'FSC454_RS04080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  830917,
  830993,
  1,
  'FSC454_RS04085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  831021,
  831096,
  1,
  'FSC454_RS04090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  831103,
  831185,
  1,
  'FSC454_RS04095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548538.1',
  'MFS transporter',
  831351,
  832607,
  1,
  'FSC454_RS04100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pgsB',
  'poly-gamma-glutamate synthase PgsB',
  832688,
  833905,
  1,
  'FSC454_RS04105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pgsC',
  'poly-gamma-glutamate biosynthesis protein PgsC',
  833930,
  834394,
  1,
  'FSC454_RS04110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pgsW',
  'poly-gamma-glutamate system protein',
  834396,
  835610,
  1,
  'FSC454_RS04115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548535.1',
  'RelA/SpoT family protein',
  835679,
  837793,
  1,
  'FSC454_RS04120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recR',
  'recombination mediator RecR',
  837801,
  838403,
  -1,
  'FSC454_RS04125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044752.1',
  'YbaB/EbfC family nucleoid-associated protein',
  838403,
  838741,
  -1,
  'FSC454_RS04130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murG',
  'undecaprenyldiphospho-muramoylpentapeptidebeta-N-acetylglucosaminyltransferase',
  838751,
  839866,
  -1,
  'FSC454_RS04135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gcvH',
  'glycine cleavage system protein GcvH',
  839972,
  840352,
  1,
  'FSC454_RS04140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548530.1',
  'hypothetical protein',
  840342,
  840638,
  1,
  'FSC454_RS04145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044755.1',
  'lytic polysaccharide monooxygenase',
  840725,
  842515,
  -1,
  'FSC454_RS04150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'thrS',
  'threonine--tRNA ligase',
  842957,
  844861,
  1,
  'FSC454_RS04155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'infC',
  'translation initiation factor IF-3',
  844868,
  845404,
  1,
  'FSC454_RS04160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmI',
  '50S ribosomal protein L35',
  845447,
  845644,
  1,
  'FSC454_RS04165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplT',
  '50S ribosomal protein L20',
  845679,
  846035,
  1,
  'FSC454_RS04170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810676.1',
  'TVP38/TMEM64 family protein',
  846075,
  846779,
  1,
  'FSC454_RS04175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044761.1',
  'M13 family metallopeptidase',
  846869,
  848932,
  1,
  'FSC454_RS04180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpiA',
  'ribose-5-phosphate isomerase RpiA',
  848980,
  849654,
  -1,
  'FSC454_RS04185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044763.1',
  'SLC5/6 family protein',
  849656,
  851026,
  -1,
  'FSC454_RS04190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044765.1',
  'hypothetical protein',
  851040,
  851432,
  -1,
  'FSC454_RS04195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mnmG',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis enzyme MnmG',
  851441,
  853324,
  -1,
  'FSC454_RS04200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794839.1',
  'hypothetical protein',
  853466,
  854548,
  1,
  'FSC454_RS04205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046434.1',
  'FUSC family protein',
  854535,
  855440,
  1,
  'FSC454_RS04210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047284.1',
  'LysR family transcriptional regulator',
  855468,
  856367,
  -1,
  'FSC454_RS04215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047223.1',
  'SDR family oxidoreductase',
  856481,
  857203,
  1,
  'FSC454_RS04220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047225.1',
  'exodeoxyribonuclease I',
  857337,
  858785,
  1,
  'FSC454_RS04225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uvrB',
  'excinuclease ABC subunit UvrB',
  858786,
  860792,
  1,
  'FSC454_RS04230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247418.1',
  'nuclease-related domain-containing protein',
  860830,
  861627,
  1,
  'FSC454_RS04235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murI',
  'glutamate racemase',
  861627,
  862424,
  1,
  'FSC454_RS04240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'thiC',
  'phosphomethylpyrimidine synthase ThiC',
  862675,
  864453,
  1,
  'FSC454_RS04245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794785.1',
  'FAD-dependent oxidoreductase',
  864446,
  865498,
  1,
  'FSC454_RS04250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'thiS',
  'sulfur carrier protein ThiS',
  865501,
  865701,
  1,
  'FSC454_RS04255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047239.1',
  'thiazole synthase',
  865705,
  866484,
  1,
  'FSC454_RS04260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'thiD',
  'bifunctional hydroxymethylpyrimidinekinase/phosphomethylpyrimidine kinase',
  866496,
  867953,
  1,
  'FSC454_RS04265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548508.1',
  'HesA/MoeB/ThiF family protein',
  867954,
  868709,
  1,
  'FSC454_RS04270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047290.1',
  'MFS transporter',
  868801,
  870078,
  1,
  'FSC454_RS04275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047245.1',
  'hypothetical protein',
  870222,
  871415,
  1,
  'FSC454_RS04280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047248.1',
  'circularly permuted type 2 ATP-grasp protein',
  871629,
  873083,
  1,
  'FSC454_RS04285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865173.1',
  'alpha-E domain-containing protein',
  873143,
  874069,
  1,
  'FSC454_RS04290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047252.1',
  'class II glutamine amidotransferase',
  874086,
  875837,
  1,
  'FSC454_RS04295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047255.1',
  'M20 metallopeptidase family protein',
  875889,
  877049,
  -1,
  'FSC454_RS04300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047258.1',
  'hypothetical protein',
  877288,
  877530,
  1,
  'FSC454_RS04305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'xseA',
  'exodeoxyribonuclease VII large subunit',
  877677,
  879062,
  1,
  'FSC454_RS04310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'xseB',
  'exodeoxyribonuclease VII small subunit',
  879046,
  879246,
  1,
  'FSC454_RS04315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047267.1',
  'MFS transporter',
  879343,
  880614,
  1,
  'FSC454_RS04320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ttcA',
  'tRNA 2-thiocytidine(32) synthetase TtcA',
  880615,
  881376,
  -1,
  'FSC454_RS04325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'smpB',
  'SsrA-binding protein SmpB',
  881377,
  881850,
  -1,
  'FSC454_RS04330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548497.1',
  'type II toxin-antitoxin system RatA familytoxin',
  881925,
  882356,
  1,
  'FSC454_RS04335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548496.1',
  'RnfH family protein',
  882356,
  882661,
  1,
  'FSC454_RS04340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mnmC1',
  'FAD-dependent5-carboxymethylaminomethyl-2-thiouridine(34)oxidoreductase MnmC1',
  882706,
  883908,
  1,
  'FSC454_RS04345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047278.1',
  'MlaA family lipoprotein',
  883985,
  884905,
  1,
  'FSC454_RS04350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ggt',
  'gamma-glutamyltransferase',
  885020,
  886765,
  1,
  'FSC454_RS04355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794786.1',
  'hypothetical protein',
  887972,
  888940,
  1,
  'FSC454_RS04360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794787.1',
  'hypothetical protein',
  889424,
  890389,
  1,
  'FSC454_RS04365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794788.1',
  'hypothetical protein',
  890874,
  891845,
  1,
  'FSC454_RS04370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794789.1',
  'hypothetical protein',
  892329,
  893306,
  1,
  'FSC454_RS04375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794790.1',
  'hypothetical protein',
  893791,
  894753,
  1,
  'FSC454_RS04380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_269446667.1',
  'hypothetical protein',
  895082,
  895207,
  -1,
  'FSC454_RS10100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794791.1',
  'hypothetical protein',
  895472,
  896443,
  1,
  'FSC454_RS04385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'transposase',
  896739,
  896912,
  1,
  'FSC454_RS04390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'transposase',
  896929,
  897168,
  -1,
  'FSC454_RS04395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794794.1',
  'hypothetical protein',
  897277,
  898209,
  1,
  'FSC454_RS04400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794795.1',
  'hypothetical protein',
  898574,
  899128,
  1,
  'FSC454_RS04405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046232.1',
  'class I SAM-dependent methyltransferase',
  899118,
  899873,
  -1,
  'FSC454_RS04410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'typA',
  'translational GTPase TypA',
  900048,
  901865,
  -1,
  'FSC454_RS04415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046228.1',
  'hypothetical protein',
  901944,
  902558,
  -1,
  'FSC454_RS04420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046226.1',
  'hypothetical protein',
  902698,
  904254,
  1,
  'FSC454_RS04425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hsdR',
  'EcoAI/FtnUII family type I restriction enzmesubunit R',
  904469,
  906815,
  1,
  'FSC454_RS04430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046376.1',
  'hypothetical protein',
  907733,
  907921,
  1,
  'FSC454_RS04435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046352.1',
  'restriction endonuclease subunit S',
  908173,
  909414,
  1,
  'FSC454_RS04440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046353.1',
  'Abi family protein',
  909662,
  910246,
  1,
  'FSC454_RS04445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046354.1',
  'transposase',
  910502,
  911251,
  1,
  'FSC454_RS04450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'type I restriction-modification system subunitM',
  911232,
  912681,
  1,
  'FSC454_RS04455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046356.1',
  'tetratricopeptide repeat protein',
  912671,
  914419,
  -1,
  'FSC454_RS04460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ylqF',
  'ribosome biogenesis GTPase YlqF',
  914486,
  915355,
  -1,
  'FSC454_RS04465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nagA',
  'N-acetylglucosamine-6-phosphate deacetylase',
  915418,
  916551,
  1,
  'FSC454_RS04470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tsaB',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexdimerization subunit type 1 TsaB',
  916555,
  917193,
  1,
  'FSC454_RS04475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046359.1',
  'class II glutamine amidotransferase',
  917198,
  918004,
  1,
  'FSC454_RS04480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046360.1',
  'pyridoxal phosphate-dependent aminotransferase',
  918014,
  919204,
  1,
  'FSC454_RS04485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'era',
  'GTPase Era',
  919298,
  920215,
  1,
  'FSC454_RS04490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046362.1',
  'hypothetical protein',
  920229,
  920648,
  1,
  'FSC454_RS04495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046363.1',
  'FAD-binding and (Fe-S)-binding domain-containingprotein',
  920705,
  923425,
  1,
  'FSC454_RS04500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'adk',
  'adenylate kinase',
  923570,
  924220,
  -1,
  'FSC454_RS04505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046364.1',
  'type IV pili',
  924348,
  925352,
  1,
  'FSC454_RS04510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046365.1',
  'PilN domain-containing protein',
  925354,
  925917,
  1,
  'FSC454_RS04515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046366.1',
  'type IV pilus inner membrane component PilO',
  925911,
  926507,
  1,
  'FSC454_RS04520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046367.1',
  'pilus assembly protein PilP',
  926513,
  927103,
  1,
  'FSC454_RS04525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046368.1',
  'type IV pilus secretin PilQ family protein',
  927116,
  928903,
  1,
  'FSC454_RS04530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroK',
  'shikimate kinase AroK',
  929029,
  929559,
  1,
  'FSC454_RS04535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroB',
  '3-dehydroquinate synthase',
  929556,
  930641,
  1,
  'FSC454_RS04540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046370.1',
  'hypothetical protein',
  930696,
  930920,
  1,
  'FSC454_RS04545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003034246.1',
  'hypothetical protein',
  930985,
  931368,
  -1,
  'FSC454_RS04550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046371.1',
  'FAD assembly factor SdhE',
  931582,
  931869,
  1,
  'FSC454_RS04555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'putA',
  'bifunctional proline dehydrogenase/L-glutamategamma-semialdehyde dehydrogenase PutA',
  931886,
  935950,
  1,
  'FSC454_RS04560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247406.1',
  'APC family permease',
  936111,
  937619,
  1,
  'FSC454_RS04565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548462.1',
  'MFS transporter',
  937695,
  938879,
  1,
  'FSC454_RS04570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'coaBC',
  'bifunctional phosphopantothenoylcysteinedecarboxylase/phosphopantothenate--cysteine ligase CoaBC',
  938892,
  940067,
  1,
  'FSC454_RS04575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046374.1',
  'aldose epimerase family protein',
  940064,
  941059,
  1,
  'FSC454_RS04580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS1595 family transposase',
  941421,
  941579,
  1,
  'FSC454_RS09965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mfd',
  'transcription-repair coupling factor',
  941668,
  945096,
  -1,
  'FSC454_RS04585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548457.1',
  'Bax inhibitor-1/YccA family protein',
  945143,
  945829,
  -1,
  'FSC454_RS04590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794797.1',
  'hypothetical protein',
  945945,
  947201,
  -1,
  'FSC454_RS04595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045478.1',
  'DUF1841 family protein',
  947201,
  947632,
  -1,
  'FSC454_RS04600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nth',
  'endonuclease III',
  947629,
  948267,
  -1,
  'FSC454_RS04605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045474.1',
  'RnfABCDGE type electron transport complexsubunit B',
  948260,
  948889,
  -1,
  'FSC454_RS04610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'grxB',
  'glutaredoxin 2',
  948891,
  949535,
  -1,
  'FSC454_RS04615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045469.1',
  'peptide MFS transporter',
  949711,
  951183,
  1,
  'FSC454_RS04620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548450.1',
  'ferritin',
  951186,
  951686,
  -1,
  'FSC454_RS04625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lipA',
  'lipoyl synthase',
  951896,
  952879,
  1,
  'FSC454_RS04630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'elbB',
  'isoprenoid biosynthesis glyoxalase ElbB',
  952909,
  953568,
  1,
  'FSC454_RS04635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'YebC/PmpR family DNA-binding transcriptionalregulator',
  953584,
  954330,
  1,
  'FSC454_RS04640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ruvC',
  'crossover junction endodeoxyribonuclease RuvC',
  954427,
  954943,
  1,
  'FSC454_RS04645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045458.1',
  'MFS transporter',
  955025,
  956218,
  1,
  'FSC454_RS04650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ruvA',
  'Holliday junction branch migration protein RuvA',
  956231,
  956881,
  1,
  'FSC454_RS04655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS5/IS1182 family transposase',
  956977,
  957111,
  1,
  'FSC454_RS09655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045453.1',
  'ABC transporter permease',
  957213,
  958019,
  -1,
  'FSC454_RS04660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045451.1',
  'ABC transporter permease',
  958033,
  958914,
  -1,
  'FSC454_RS04665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003015139.1',
  'ABC transporter ATP-binding protein',
  958914,
  960035,
  -1,
  'FSC454_RS04670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045448.1',
  'hypothetical protein',
  960341,
  960601,
  1,
  'FSC454_RS04675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045445.1',
  'MFS transporter',
  960700,
  962157,
  -1,
  'FSC454_RS04680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'transposase',
  962319,
  962645,
  1,
  'FSC454_RS09970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794798.1',
  'glycogen/starch synthase',
  962959,
  965232,
  1,
  'FSC454_RS04685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865159.1',
  'hypothetical protein',
  965702,
  965842,
  1,
  'FSC454_RS09660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046390.1',
  'HAD-IB family phosphatase',
  965886,
  966536,
  1,
  'FSC454_RS04695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046389.1',
  'DUF475 domain-containing protein',
  966525,
  967547,
  -1,
  'FSC454_RS04700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046388.1',
  'DUF3301 domain-containing protein',
  967626,
  968024,
  1,
  'FSC454_RS04705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470898.1',
  'glutathione S-transferase family protein',
  968035,
  968742,
  1,
  'FSC454_RS04710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'alr',
  'alanine racemase',
  968896,
  969993,
  1,
  'FSC454_RS04715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046386.1',
  'APC family permease',
  970074,
  971684,
  1,
  'FSC454_RS04720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pheA',
  'prephenate dehydratase',
  971758,
  972600,
  1,
  'FSC454_RS04725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046384.1',
  'M48 family metallopeptidase',
  972625,
  973293,
  1,
  'FSC454_RS04730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046383.1',
  'L-serine ammonia-lyase',
  973347,
  974720,
  1,
  'FSC454_RS04735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046382.1',
  'aminotransferase class V-fold PLP-dependentenzyme',
  974822,
  976045,
  1,
  'FSC454_RS04740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046381.1',
  'HesB/IscA family protein',
  976066,
  976422,
  1,
  'FSC454_RS04745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sufT',
  'putative Fe-S cluster assembly protein SufT',
  976436,
  976987,
  1,
  'FSC454_RS04750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'coaD',
  'pantetheine-phosphate adenylyltransferase',
  976998,
  977486,
  1,
  'FSC454_RS04755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046378.1',
  'YfhL family 4Fe-4S dicluster ferredoxin',
  977492,
  977737,
  1,
  'FSC454_RS04760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fopA',
  'outer membrane protein FopA',
  977839,
  979017,
  1,
  'FSC454_RS04765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas9',
  'type II-B CRISPR-associated RNA-guidedendonuclease Cas9/Csx12',
  979941,
  984860,
  1,
  'FSC454_RS04770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas1',
  'CRISPR-associated endonuclease Cas1',
  984841,
  985566,
  1,
  'FSC454_RS04775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794800.1',
  'hypothetical protein',
  985579,
  985797,
  1,
  'FSC454_RS09975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas2',
  'CRISPR-associated endonuclease Cas2',
  985883,
  986176,
  1,
  'FSC454_RS04785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas4',
  'CRISPR-associated protein Cas4',
  986163,
  986747,
  1,
  'FSC454_RS04790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046311.1',
  'radical SAM/SPASM domain-containing protein',
  988252,
  989337,
  1,
  'FSC454_RS04795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046310.1',
  'glutaredoxin domain-containing protein',
  989330,
  989578,
  1,
  'FSC454_RS04800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046309.1',
  'acyl-CoA thioesterase',
  989575,
  990024,
  1,
  'FSC454_RS04805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046308.1',
  'hypothetical protein',
  990040,
  990393,
  -1,
  'FSC454_RS04810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046315.1',
  'linear amide C-N hydrolase',
  990607,
  991575,
  -1,
  'FSC454_RS04815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046307.1',
  'TrmH family RNA methyltransferase',
  991672,
  992424,
  -1,
  'FSC454_RS04820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046306.1',
  'BCCT family transporter',
  992564,
  994516,
  1,
  'FSC454_RS04825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046305.1',
  'TspO/MBR family protein',
  994509,
  994985,
  -1,
  'FSC454_RS04830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046304.1',
  'bifunctional methionine sulfoxide reductase B/Aprotein',
  995115,
  995969,
  1,
  'FSC454_RS04835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046303.1',
  'multidrug effflux MFS transporter',
  995966,
  997168,
  -1,
  'FSC454_RS04840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fipB',
  'DsbA-like infectivity potentiator lipoproteinFipB',
  997434,
  998549,
  -1,
  'FSC454_RS04845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fipA',
  'infectivity potentiator lipoprotein FipA',
  998569,
  998859,
  -1,
  'FSC454_RS04850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'queG',
  'tRNA epoxyqueuosine(34) reductase QueG',
  998929,
  1000035,
  -1,
  'FSC454_RS04855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsfS',
  'ribosome silencing factor',
  1000038,
  1000373,
  -1,
  'FSC454_RS04860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_331709118.1',
  'hypothetical protein',
  1000536,
  1000811,
  1,
  'FSC454_RS04865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046299.1',
  'ATP-dependent helicase',
  1000836,
  1002902,
  1,
  'FSC454_RS04870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046298.1',
  'hypothetical protein',
  1002899,
  1003345,
  -1,
  'FSC454_RS04875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'alaS',
  'alanine--tRNA ligase',
  1003501,
  1006098,
  1,
  'FSC454_RS04880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftlC',
  'TolC family protein FtlC',
  1006106,
  1007488,
  1,
  'FSC454_RS04885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046296.1',
  'M17 family metallopeptidase',
  1007491,
  1008870,
  1,
  'FSC454_RS04890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tal',
  'transaldolase',
  1009002,
  1009967,
  1,
  'FSC454_RS04895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046294.1',
  'hypothetical protein',
  1009988,
  1010566,
  1,
  'FSC454_RS04900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359443.1',
  'hypothetical protein',
  1010721,
  1010939,
  -1,
  'FSC454_RS10225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dinB',
  'DNA polymerase IV',
  1011150,
  1012205,
  -1,
  'FSC454_RS04910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DJ-1/PfpI family protein',
  1012210,
  1012814,
  -1,
  'FSC454_RS04915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046291.1',
  'ABC-F family ATP-binding cassettedomain-containing protein',
  1012925,
  1014811,
  1,
  'FSC454_RS04920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046290.1',
  'ribonucleotide-diphosphate reductase subunitbeta',
  1014808,
  1016040,
  -1,
  'FSC454_RS04925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046289.1',
  'glutaredoxin',
  1016047,
  1016307,
  -1,
  'FSC454_RS04930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046287.1',
  'ribonucleoside-diphosphate reductase subunitalpha',
  1016311,
  1018083,
  -1,
  'FSC454_RS04935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mdh',
  'malate dehydrogenase',
  1018286,
  1019245,
  -1,
  'FSC454_RS04940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046285.1',
  'MFS transporter',
  1019395,
  1019907,
  1,
  'FSC454_RS04945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'coq7',
  '2-polyprenyl-3-methyl-6-methoxy-1,4-benzoquinonemonooxygenase',
  1019922,
  1020557,
  1,
  'FSC454_RS04950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046282.1',
  'transglycosylase SLT domain-containing protein',
  1020566,
  1021135,
  -1,
  'FSC454_RS04955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046280.1',
  'tRNA threonylcarbamoyladenosine dehydratase',
  1021212,
  1021955,
  -1,
  'FSC454_RS04960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046278.1',
  'alpha/beta hydrolase family protein',
  1021959,
  1023455,
  -1,
  'FSC454_RS04965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046276.1',
  'HAD family hydrolase',
  1023510,
  1024091,
  -1,
  'FSC454_RS04970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548376.1',
  'peroxiredoxin',
  1024230,
  1024829,
  1,
  'FSC454_RS04975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548375.1',
  'hypothetical protein',
  1024893,
  1026269,
  1,
  'FSC454_RS04980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046275.1',
  'zinc ribbon domain-containing protein YjdM',
  1026374,
  1026706,
  1,
  'FSC454_RS04985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046272.1',
  'hypothetical protein',
  1026712,
  1026927,
  1,
  'FSC454_RS04990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046270.1',
  'hypothetical protein',
  1026932,
  1028431,
  1,
  'FSC454_RS04995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS04995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaQ',
  'DNA polymerase III subunit epsilon',
  1028483,
  1029175,
  1,
  'FSC454_RS05000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046266.1',
  'M15 family metallopeptidase',
  1029169,
  1029642,
  1,
  'FSC454_RS05005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046263.1',
  'COG3014 family protein',
  1029629,
  1031038,
  1,
  'FSC454_RS05010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046261.1',
  'saccharopine dehydrogenase family protein',
  1031295,
  1032410,
  1,
  'FSC454_RS05015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'amaB',
  'L-piperidine-6-carboxylate dehydrogenase',
  1032423,
  1033919,
  1,
  'FSC454_RS05020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046257.1',
  'DUF1338 domain-containing protein',
  1033924,
  1034718,
  1,
  'FSC454_RS05025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046256.1',
  'metal-sensitive transcriptional regulator',
  1034802,
  1035074,
  1,
  'FSC454_RS05030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046255.1',
  'MauE/DoxX family redox-associated membraneprotein',
  1035088,
  1035819,
  1,
  'FSC454_RS05035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'oxyR',
  'oxidative stress transcriptional regulator OxyR',
  1035822,
  1036691,
  -1,
  'FSC454_RS05040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548362.1',
  'peroxiredoxin',
  1036789,
  1037313,
  1,
  'FSC454_RS05045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046250.1',
  'short chain dehydrogenase',
  1037316,
  1037927,
  1,
  'FSC454_RS05050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cmk',
  '(d)CMP kinase',
  1037954,
  1038619,
  -1,
  'FSC454_RS05055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'serC',
  '3-phosphoserine/phosphohydroxythreoninetransaminase',
  1038606,
  1039658,
  -1,
  'FSC454_RS05060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046246.1',
  'histidine phosphatase family protein',
  1039734,
  1040942,
  -1,
  'FSC454_RS05065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemF',
  'oxygen-dependent coproporphyrinogen oxidase',
  1040963,
  1041889,
  -1,
  'FSC454_RS05070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865157.1',
  'pilin',
  1041980,
  1042462,
  1,
  'FSC454_RS05075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsF',
  '30S ribosomal protein S6',
  1042573,
  1042908,
  1,
  'FSC454_RS05080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsR',
  '30S ribosomal protein S18',
  1042924,
  1043142,
  1,
  'FSC454_RS05085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplI',
  '50S ribosomal protein L9',
  1043161,
  1043616,
  1,
  'FSC454_RS05090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaB',
  'replicative DNA helicase',
  1043708,
  1045102,
  1,
  'FSC454_RS05095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rlmN',
  'dual-specificity RNA methyltransferase RlmN',
  1045133,
  1046245,
  1,
  'FSC454_RS05100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046239.1',
  'pilus assembly protein PilF',
  1046235,
  1047140,
  1,
  'FSC454_RS05105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rluB',
  '23S rRNA pseudouridine(2605) synthase RluB',
  1047133,
  1047948,
  1,
  'FSC454_RS05110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046237.1',
  'chloroquine resistance protein',
  1047948,
  1048373,
  1,
  'FSC454_RS05115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046312.1',
  'GNAT family N-acetyltransferase',
  1048351,
  1048791,
  1,
  'FSC454_RS05120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359444.1',
  'hypothetical protein',
  1049239,
  1049409,
  1,
  'FSC454_RS09785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045226.1',
  'IS630 transposase-related protein',
  1049469,
  1049819,
  1,
  'FSC454_RS05125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470857.1',
  'transposase',
  1049821,
  1050282,
  1,
  'FSC454_RS05130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ygfZ',
  'CAF17-like 4Fe-4S cluster assembly/insertionprotein YgfZ',
  1050630,
  1051376,
  1,
  'FSC454_RS05135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548344.1',
  'UvrD-helicase domain-containing protein',
  1051370,
  1053385,
  1,
  'FSC454_RS05140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047022.1',
  'CvfB family protein',
  1053441,
  1054271,
  1,
  'FSC454_RS05145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trhO',
  'oxygen-dependent tRNA uridine(34) hydroxylaseTrhO',
  1054408,
  1055391,
  -1,
  'FSC454_RS05150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047028.1',
  'recombination-associated protein RdgC',
  1055585,
  1056445,
  1,
  'FSC454_RS05155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548340.1',
  'hypothetical protein',
  1056450,
  1056707,
  1,
  'FSC454_RS05160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1056716,
  1056792,
  -1,
  'FSC454_RS05165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047030.1',
  'sterol desaturase family protein',
  1056920,
  1057474,
  1,
  'FSC454_RS05170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rlmKL',
  'bifunctional 23S rRNA(guanine(2069)-N(7))-methyltransferase RlmK/23S rRNA(guanine(2445)-N(2))-methyltransferase RlmL',
  1057547,
  1059700,
  1,
  'FSC454_RS05175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fvfA',
  'Francisella virulence factor A',
  1059801,
  1060199,
  1,
  'FSC454_RS05180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fmt',
  'methionyl-tRNA formyltransferase',
  1060204,
  1061145,
  1,
  'FSC454_RS05185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gshB',
  'glutathione synthase',
  1061149,
  1062123,
  1,
  'FSC454_RS05190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemL',
  'glutamate-1-semialdehyde 2,1-aminomutase',
  1062113,
  1063414,
  1,
  'FSC454_RS05195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047049.1',
  'phospholipid carrier-dependentglycosyltransferase',
  1063424,
  1065124,
  1,
  'FSC454_RS05200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047052.1',
  'Rrf2 family transcriptional regulator',
  1065134,
  1065556,
  -1,
  'FSC454_RS05205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hmpA',
  'NO-inducible flavohemoprotein',
  1065662,
  1066837,
  1,
  'FSC454_RS05210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047058.1',
  'glycoside hydrolase family 3 protein',
  1066842,
  1068509,
  -1,
  'FSC454_RS05215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047061.1',
  '3-hydroxybutyrate dehydrogenase',
  1068569,
  1069351,
  -1,
  'FSC454_RS05220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047064.1',
  'acetoacetate decarboxylase',
  1069373,
  1070113,
  -1,
  'FSC454_RS05225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047075.1',
  'sugar MFS transporter',
  1070376,
  1071626,
  1,
  'FSC454_RS05230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047067.1',
  'ROK family protein',
  1071638,
  1072522,
  1,
  'FSC454_RS05235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047070.1',
  'biotin--[acetyl-CoA-carboxylase] ligase',
  1072546,
  1073508,
  1,
  'FSC454_RS05240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bioD',
  'dethiobiotin synthase',
  1073451,
  1074128,
  -1,
  'FSC454_RS05245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794801.1',
  'methyltransferase domain-containing protein',
  1074132,
  1074869,
  -1,
  'FSC454_RS05250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046929.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  1074856,
  1075974,
  -1,
  'FSC454_RS05255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bioB',
  'biotin synthase BioB',
  1075968,
  1076909,
  -1,
  'FSC454_RS05260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bioA',
  'adenosylmethionine--8-amino-7-oxononanoatetransaminase',
  1076999,
  1078285,
  1,
  'FSC454_RS05265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046923.1',
  'PaaI family thioesterase',
  1078287,
  1078787,
  -1,
  'FSC454_RS05270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bioJ',
  'pimeloyl-ACP methyl ester esterase BioJ',
  1078804,
  1079724,
  -1,
  'FSC454_RS05275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'folP',
  'dihydropteroate synthase',
  1079737,
  1081002,
  -1,
  'FSC454_RS05280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046918.1',
  'dihydroneopterin aldolase',
  1081004,
  1081357,
  -1,
  'FSC454_RS05285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046916.1',
  'class I adenylate-forming enzyme family protein',
  1081440,
  1082810,
  1,
  'FSC454_RS05290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046914.1',
  'chorismate-binding protein',
  1082803,
  1084566,
  1,
  'FSC454_RS05295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548263.1',
  'anthranilate synthase component II',
  1084568,
  1085122,
  1,
  'FSC454_RS05300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'MFS transporter',
  1085123,
  1086285,
  -1,
  'FSC454_RS05305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'aldo/keto reductase',
  1086355,
  1087430,
  -1,
  'FSC454_RS05310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046912.1',
  'aldo/keto reductase',
  1087505,
  1088569,
  -1,
  'FSC454_RS05315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'nitrilase-related carbon-nitrogen hydrolase',
  1088679,
  1089597,
  -1,
  'FSC454_RS05320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046908.1',
  'ABM domain-containing protein',
  1089677,
  1090102,
  -1,
  'FSC454_RS05325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046937.1',
  'YdcF family protein',
  1090244,
  1090930,
  -1,
  'FSC454_RS05330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'folE',
  'GTP cyclohydrolase I FolE',
  1090950,
  1091564,
  -1,
  'FSC454_RS05335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046904.1',
  'DEAD/DEAH box helicase',
  1091697,
  1093034,
  1,
  'FSC454_RS05340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dptA',
  'dipeptide and tripeptide permease A',
  1093031,
  1094572,
  -1,
  'FSC454_RS05345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046900.1',
  'YbjQ family protein',
  1094708,
  1095028,
  -1,
  'FSC454_RS05350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gorA',
  'glutathione-disulfide reductase',
  1095039,
  1096400,
  -1,
  'FSC454_RS05355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046896.1',
  '2''-5'' RNA ligase family protein',
  1096437,
  1097156,
  -1,
  'FSC454_RS05360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046894.1',
  'P-loop nucleotide/nucleoside kinase familyprotein',
  1097156,
  1097662,
  -1,
  'FSC454_RS05365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046935.1',
  'hypothetical protein',
  1097659,
  1098474,
  -1,
  'FSC454_RS05370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046891.1',
  'exodeoxyribonuclease III',
  1098464,
  1099252,
  -1,
  'FSC454_RS05375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548247.1',
  'M14 family zinc carboxypeptidase',
  1099423,
  1100523,
  1,
  'FSC454_RS05380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548246.1',
  'NAD(P)H-dependent oxidoreductase',
  1100542,
  1101132,
  1,
  'FSC454_RS05385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046933.1',
  'type 1 glutamine amidotransferasedomain-containing protein',
  1101248,
  1101910,
  1,
  'FSC454_RS05390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046889.1',
  '3-deoxy-7-phosphoheptulonate synthase',
  1101969,
  1103081,
  -1,
  'FSC454_RS05395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ffh',
  'signal recognition particle protein',
  1103112,
  1104488,
  -1,
  'FSC454_RS05400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247350.1',
  'DUF1634 domain-containing protein',
  1104568,
  1104834,
  -1,
  'FSC454_RS05405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548242.1',
  'sulfite exporter TauE/SafE family protein',
  1104831,
  1105673,
  -1,
  'FSC454_RS05410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'infA',
  'translation initiation factor IF-1',
  1105832,
  1106050,
  1,
  'FSC454_RS05415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'LysO family transporter',
  1106082,
  1106243,
  -1,
  'FSC454_RS05420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_208600927.1',
  'transposase',
  1106256,
  1106396,
  -1,
  'FSC454_RS10105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_208600928.1',
  'IS630 transposase-related protein',
  1106393,
  1107067,
  -1,
  'FSC454_RS09860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794802.1',
  'LysO family transporter',
  1107110,
  1107886,
  -1,
  'FSC454_RS05435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456242.1',
  'APC family permease',
  1107888,
  1109312,
  -1,
  'FSC454_RS05440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trkA',
  'Trk system potassium transporter TrkA',
  1109371,
  1110744,
  -1,
  'FSC454_RS05445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044791.1',
  'SUF system Fe-S cluster assembly regulator',
  1110895,
  1111305,
  1,
  'FSC454_RS05450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sufB',
  'Fe-S cluster assembly protein SufB',
  1111312,
  1112757,
  1,
  'FSC454_RS05455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044786.1',
  'GNAT family N-acetyltransferase',
  1112760,
  1113206,
  1,
  'FSC454_RS05460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sufC',
  'Fe-S cluster assembly ATPase SufC',
  1113229,
  1113978,
  1,
  'FSC454_RS05465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sufD',
  'Fe-S cluster assembly protein SufD',
  1113991,
  1115136,
  1,
  'FSC454_RS05470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044780.1',
  'dimethylarginine dimethylaminohydrolase familyprotein',
  1115229,
  1116011,
  1,
  'FSC454_RS05475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044778.1',
  'hypothetical protein',
  1116104,
  1116793,
  1,
  'FSC454_RS05480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trxA',
  'thioredoxin',
  1116797,
  1117123,
  1,
  'FSC454_RS05485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044774.1',
  'DUF3293 domain-containing protein',
  1117116,
  1117556,
  1,
  'FSC454_RS05490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044772.1',
  'winged helix-turn-helix domain-containingprotein',
  1117515,
  1117808,
  -1,
  'FSC454_RS05495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046597.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  1118094,
  1119335,
  1,
  'FSC454_RS05500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148251.1',
  'PAS domain-containing protein',
  1119658,
  1120638,
  1,
  'FSC454_RS05505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548226.1',
  'hypothetical protein',
  1121592,
  1121963,
  1,
  'FSC454_RS05510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044912.1',
  '(deoxy)nucleoside triphosphatepyrophosphohydrolase',
  1122167,
  1122571,
  -1,
  'FSC454_RS05515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548224.1',
  'YqgE/AlgH family protein',
  1122610,
  1123194,
  1,
  'FSC454_RS05520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ruvX',
  'Holliday junction resolvase RuvX',
  1123196,
  1123606,
  1,
  'FSC454_RS05525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044913.1',
  'tetratricopeptide repeat protein',
  1123705,
  1124283,
  1,
  'FSC454_RS05530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794804.1',
  'DUF3857 domain-containing transglutaminasefamily protein',
  1124421,
  1126304,
  1,
  'FSC454_RS05535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'leuS',
  'leucine--tRNA ligase',
  1126410,
  1128851,
  1,
  'FSC454_RS05540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810709.1',
  'LPS-assembly lipoprotein LptE',
  1128861,
  1129436,
  1,
  'FSC454_RS05545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'mechanosensitive ion channel family protein',
  1129497,
  1130687,
  1,
  'FSC454_RS05550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dcd',
  'dCTP deaminase',
  1130695,
  1131261,
  -1,
  'FSC454_RS05555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470929.1',
  'Mrp/NBP35 family ATP-binding protein',
  1131278,
  1132138,
  -1,
  'FSC454_RS05560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'MFS transporter',
  1132213,
  1133446,
  1,
  'FSC454_RS05565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cls',
  'cardiolipin synthase',
  1133505,
  1134932,
  1,
  'FSC454_RS05570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cls',
  'cardiolipin synthase',
  1135028,
  1136458,
  1,
  'FSC454_RS05575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794805.1',
  'HAD family hydrolase',
  1136619,
  1137605,
  1,
  'FSC454_RS05580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047464.1',
  'ZIP family metal transporter',
  1137627,
  1138373,
  -1,
  'FSC454_RS05585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047445.1',
  'GTP-binding protein',
  1138377,
  1139594,
  -1,
  'FSC454_RS05590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047448.1',
  'Fur family transcriptional regulator',
  1139742,
  1140164,
  1,
  'FSC454_RS05595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_425268605.1',
  'hypothetical protein',
  1140187,
  1140423,
  -1,
  'FSC454_RS10230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_208600929.1',
  'ABC transporter permease subunit',
  1140471,
  1141886,
  -1,
  'FSC454_RS05600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_208600930.1',
  'ABC transporter substrate-binding protein',
  1141887,
  1143290,
  -1,
  'FSC454_RS05605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'ABC transporter ATP-binding protein',
  1143442,
  1144998,
  -1,
  'FSC454_RS09795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359445.1',
  'nicotianamine synthase family protein',
  1145088,
  1145855,
  -1,
  'FSC454_RS05620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047459.1',
  'MFS transporter',
  1146001,
  1147188,
  1,
  'FSC454_RS05625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS982 family transposase',
  1147274,
  1147413,
  1,
  'FSC454_RS09670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'transposase',
  1147408,
  1147872,
  -1,
  'FSC454_RS09675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS982 family transposase',
  1148073,
  1148920,
  -1,
  'FSC454_RS05635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044797.1',
  'ribonuclease T2 family protein',
  1148983,
  1149699,
  -1,
  'FSC454_RS05640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS701 family transposase',
  1150215,
  1151264,
  1,
  'FSC454_RS10235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pheT',
  'phenylalanine--tRNA ligase subunit beta',
  1151342,
  1153714,
  -1,
  'FSC454_RS05655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pheS',
  'phenylalanine--tRNA ligase subunit alpha',
  1153735,
  1154748,
  -1,
  'FSC454_RS05660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045406.1',
  'DMT family transporter',
  1154834,
  1155727,
  -1,
  'FSC454_RS05665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'peptide MFS transporter',
  1155752,
  1157228,
  -1,
  'FSC454_RS05670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045408.1',
  'MFS transporter',
  1157463,
  1158923,
  1,
  'FSC454_RS05675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045410.1',
  'glycoside hydrolase family 31 protein',
  1158935,
  1161259,
  1,
  'FSC454_RS05680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045412.1',
  'mannitol dehydrogenase family protein',
  1161259,
  1162731,
  1,
  'FSC454_RS05685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uxuA',
  'mannonate dehydratase',
  1162733,
  1163923,
  1,
  'FSC454_RS05690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794806.1',
  'sugar kinase',
  1163910,
  1164866,
  1,
  'FSC454_RS05695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'eda',
  'bifunctional 4-hydroxy-2-oxoglutaratealdolase/2-dehydro-3-deoxy-phosphogluconate aldolase',
  1164863,
  1165411,
  1,
  'FSC454_RS05700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uxaC',
  'glucuronate isomerase',
  1165424,
  1166845,
  1,
  'FSC454_RS05705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'sugar porter family MFS transporter',
  1166907,
  1168293,
  1,
  'FSC454_RS05710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548196.1',
  'inositol oxygenase family protein',
  1168327,
  1169304,
  1,
  'FSC454_RS05715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794807.1',
  'MFS transporter',
  1169378,
  1170646,
  1,
  'FSC454_RS05720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794808.1',
  'retroviral-like aspartic protease familyprotein',
  1170631,
  1171590,
  -1,
  'FSC454_RS05725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046220.1',
  'DUF2975 domain-containing protein',
  1171721,
  1172257,
  1,
  'FSC454_RS05730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548192.1',
  'helix-turn-helix domain-containing protein',
  1172270,
  1172473,
  1,
  'FSC454_RS05735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148252.1',
  'hypothetical protein',
  1172762,
  1173055,
  1,
  'FSC454_RS05745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045387.1',
  'glucosaminidase domain-containing protein',
  1173390,
  1173977,
  1,
  'FSC454_RS05750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ruvB',
  'Holliday junction branch migration DNA helicaseRuvB',
  1174015,
  1175061,
  -1,
  'FSC454_RS05755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045379.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  1175125,
  1175850,
  -1,
  'FSC454_RS05760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548187.1',
  'CBS domain-containing protein',
  1175968,
  1176558,
  1,
  'FSC454_RS05765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'arylesterase',
  1176572,
  1177200,
  -1,
  'FSC454_RS05770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dxs',
  '1-deoxy-D-xylulose-5-phosphate synthase',
  1177320,
  1179173,
  -1,
  'FSC454_RS05775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'guaA',
  'glutamine-hydrolyzing GMP synthase',
  1179253,
  1180803,
  -1,
  'FSC454_RS05780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045375.1',
  'APC family permease',
  1180890,
  1182434,
  -1,
  'FSC454_RS05785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'truA',
  'tRNA pseudouridine(38-40) synthase TruA',
  1182490,
  1183266,
  -1,
  'FSC454_RS05790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045372.1',
  'alpha/beta hydrolase fold domain-containingprotein',
  1183269,
  1185101,
  -1,
  'FSC454_RS05795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045370.1',
  'fumarylacetoacetate hydrolase family protein',
  1185114,
  1185707,
  -1,
  'FSC454_RS05800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lptB',
  'LPS export ABC transporter ATP-binding protein',
  1185756,
  1186487,
  -1,
  'FSC454_RS05805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045367.1',
  'LptA/OstA family protein',
  1186561,
  1187394,
  -1,
  'FSC454_RS05810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lptC',
  'LPS export ABC transporter periplasmic proteinLptC',
  1187381,
  1188007,
  -1,
  'FSC454_RS05815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045364.1',
  'KdsC family phosphatase',
  1188015,
  1188554,
  -1,
  'FSC454_RS05820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ppa',
  'inorganic diphosphatase',
  1188645,
  1189166,
  -1,
  'FSC454_RS05825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dacD',
  'D-alanyl-D-alanine carboxypeptidase',
  1189325,
  1190659,
  1,
  'FSC454_RS05830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548174.1',
  'HP0495 family protein',
  1190691,
  1190975,
  1,
  'FSC454_RS05835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lipB',
  'lipoyl(octanoyl) transferase LipB',
  1190985,
  1191608,
  1,
  'FSC454_RS05840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045383.1',
  'MFS transporter',
  1192107,
  1193585,
  1,
  'FSC454_RS05845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045356.1',
  'alpha-glucosidase',
  1193588,
  1195597,
  1,
  'FSC454_RS05850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045354.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1195709,
  1196971,
  -1,
  'FSC454_RS05855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpoD',
  'RNA polymerase sigma factor RpoD',
  1197087,
  1198820,
  -1,
  'FSC454_RS05860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dnaG',
  'DNA primase',
  1198845,
  1200662,
  -1,
  'FSC454_RS05865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003026091.1',
  'GatB/YqeY domain-containing protein',
  1200683,
  1201129,
  -1,
  'FSC454_RS05870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  1201190,
  1201387,
  -1,
  'FSC454_RS05875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dacB',
  'D-alanyl-D-alaninecarboxypeptidase/D-alanyl-D-alanine endopeptidase',
  1201641,
  1203044,
  1,
  'FSC454_RS05880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548166.1',
  'transglycosylase SLT domain-containing protein',
  1203045,
  1203656,
  1,
  'FSC454_RS05885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045348.1',
  'acyl-CoA thioesterase',
  1203673,
  1204089,
  1,
  'FSC454_RS05890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ttcA',
  'tRNA 2-thiocytidine(32) synthetase TtcA',
  1204082,
  1204882,
  1,
  'FSC454_RS05895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045345.1',
  'FKBP-type peptidyl-prolyl cis-trans isomerase',
  1204896,
  1205756,
  1,
  'FSC454_RS05900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045343.1',
  'polyprenyl synthetase family protein',
  1205774,
  1206751,
  -1,
  'FSC454_RS05905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045341.1',
  'hypothetical protein',
  1206841,
  1207272,
  -1,
  'FSC454_RS05910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'PQ-loop repeat-containing protein',
  1207340,
  1207974,
  -1,
  'FSC454_RS05915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_279625857.1',
  'hypothetical protein',
  1208557,
  1209372,
  -1,
  'FSC454_RS10110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cysC',
  'adenylyl-sulfate kinase',
  1209998,
  1210600,
  -1,
  'FSC454_RS05925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cysN',
  'sulfate adenylyltransferase subunit CysN',
  1210620,
  1212032,
  -1,
  'FSC454_RS05930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359446.1',
  'hypothetical protein',
  1213569,
  1213733,
  -1,
  'FSC454_RS09800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047307.1',
  'hypothetical protein',
  1214484,
  1214684,
  -1,
  'FSC454_RS05940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cysD',
  'sulfate adenylyltransferase subunit CysD',
  1214794,
  1215690,
  -1,
  'FSC454_RS05945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794811.1',
  'nucleotidyltransferase family protein',
  1215719,
  1216816,
  -1,
  'FSC454_RS05950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794812.1',
  'sulfotransferase domain-containing protein',
  1216797,
  1217648,
  -1,
  'FSC454_RS05955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044803.1',
  'serine/threonine protein kinase',
  1217730,
  1218638,
  1,
  'FSC454_RS05960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148253.1',
  'ABC transporter ATP-binding protein',
  1218625,
  1220424,
  1,
  'FSC454_RS05965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046318.1',
  'PqqD family peptide modification chaperone',
  1220421,
  1220705,
  1,
  'FSC454_RS05970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046317.1',
  'lasso peptide biosynthesis B2 protein',
  1220702,
  1221196,
  1,
  'FSC454_RS05975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046316.1',
  'asparagine synthase-related protein',
  1221209,
  1223062,
  1,
  'FSC454_RS05980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148254.1',
  'hypothetical protein',
  1223059,
  1223907,
  1,
  'FSC454_RS05985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865145.1',
  'hypothetical protein',
  1223954,
  1224295,
  1,
  'FSC454_RS09990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865144.1',
  'hypothetical protein',
  1224312,
  1224758,
  1,
  'FSC454_RS09995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045439.1',
  'hypothetical protein',
  1225309,
  1225509,
  -1,
  'FSC454_RS05995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS05995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045436.1',
  'hypothetical protein',
  1225975,
  1226157,
  -1,
  'FSC454_RS06000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ilvC',
  'ketol-acid reductoisomerase',
  1226497,
  1227540,
  -1,
  'FSC454_RS06005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548144.1',
  'acetolactate synthase small subunit',
  1227568,
  1227885,
  -1,
  'FSC454_RS06010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ilvB',
  'biosynthetic-type acetolactate synthase largesubunit',
  1227890,
  1229587,
  -1,
  'FSC454_RS06015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ilvD',
  'dihydroxy-acid dehydratase',
  1229732,
  1231414,
  -1,
  'FSC454_RS06020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'alpha-isopropylmalate synthase regulatorydomain-containing protein',
  1231438,
  1231526,
  -1,
  'FSC454_RS10175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'thrC',
  'threonine synthase',
  1231510,
  1233234,
  -1,
  'FSC454_RS06025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yihA',
  'ribosome biogenesis GTP-binding proteinYihA/YsxC',
  1233377,
  1233970,
  -1,
  'FSC454_RS06030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045425.1',
  'low molecular weightprotein-tyrosine-phosphatase',
  1233967,
  1234452,
  -1,
  'FSC454_RS06035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hflC',
  'protease modulator HflC',
  1234453,
  1235379,
  -1,
  'FSC454_RS06040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hflK',
  'FtsH protease activity modulator HflK',
  1235381,
  1236448,
  -1,
  'FSC454_RS06045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'FAD-dependent monooxygenase',
  1236633,
  1237359,
  1,
  'FSC454_RS06050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456252.1',
  'hypothetical protein',
  1237416,
  1237697,
  1,
  'FSC454_RS10240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794746.1',
  'IS630 family transposase',
  1237740,
  1238552,
  1,
  'FSC454_RS06060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'transposase',
  1238595,
  1238786,
  1,
  'FSC454_RS06065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS982 family transposase',
  1238879,
  1239738,
  1,
  'FSC454_RS06070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'Rossmann-fold NAD(P)-binding domain-containingprotein',
  1239753,
  1240214,
  1,
  'FSC454_RS06075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hflX',
  'ribosome rescue GTPase HflX',
  1240224,
  1241531,
  -1,
  'FSC454_RS06080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hfq',
  'RNA chaperone Hfq',
  1241583,
  1241912,
  -1,
  'FSC454_RS06085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'miaA',
  'tRNA (adenosine(37)-N6)-dimethylallyltransferaseMiaA',
  1242016,
  1242943,
  -1,
  'FSC454_RS06090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047420.1',
  'peptidylprolyl isomerase',
  1242944,
  1244377,
  -1,
  'FSC454_RS06095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548131.1',
  'HU family DNA-binding protein',
  1244490,
  1244762,
  -1,
  'FSC454_RS06100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lon',
  'endopeptidase La',
  1244849,
  1247173,
  -1,
  'FSC454_RS06105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'clpX',
  'ATP-dependent Clp protease ATP-binding subunitClpX',
  1247198,
  1248451,
  -1,
  'FSC454_RS06110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'clpP',
  'ATP-dependent Clp endopeptidase proteolyticsubunit ClpP',
  1248475,
  1249080,
  -1,
  'FSC454_RS06115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tig',
  'trigger factor',
  1249106,
  1250422,
  -1,
  'FSC454_RS06120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047409.1',
  'DUF6790 family protein',
  1250577,
  1251032,
  1,
  'FSC454_RS06125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047406.1',
  'thymidine kinase',
  1251143,
  1251736,
  -1,
  'FSC454_RS06130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047426.1',
  'HAD family acid phosphatase',
  1251748,
  1252494,
  -1,
  'FSC454_RS06135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047403.1',
  'O-methyltransferase',
  1252678,
  1253313,
  -1,
  'FSC454_RS06140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'miaB',
  'tRNA (N6-isopentenyladenosine(37)-C2)-methylthiotransferase MiaB',
  1253576,
  1254904,
  1,
  'FSC454_RS06145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548121.1',
  'PhoH family protein',
  1254908,
  1255891,
  1,
  'FSC454_RS06150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ybeY',
  'rRNA maturation RNase YbeY',
  1255884,
  1256372,
  1,
  'FSC454_RS06155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047395.1',
  'CorC family transporter',
  1256362,
  1257204,
  1,
  'FSC454_RS06160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lnt',
  'apolipoprotein N-acyltransferase',
  1257204,
  1258694,
  1,
  'FSC454_RS06165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047389.1',
  'GNAT family N-acetyltransferase',
  1258696,
  1259226,
  -1,
  'FSC454_RS06170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047386.1',
  'VirK family protein',
  1259434,
  1259859,
  1,
  'FSC454_RS06175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794813.1',
  'ankyrin repeat domain-containing protein',
  1260021,
  1261505,
  -1,
  'FSC454_RS06180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'blaFTU',
  'FTU family class A beta-lactamase',
  1262001,
  1262864,
  1,
  'FSC454_RS06185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794814.1',
  'DNA/RNA non-specific endonuclease',
  1262855,
  1263862,
  -1,
  'FSC454_RS06190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046736.1',
  'aminopeptidase P family protein',
  1263970,
  1265763,
  -1,
  'FSC454_RS06195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pgeF',
  'peptidoglycan editing factor PgeF',
  1265789,
  1266496,
  -1,
  'FSC454_RS06200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ispG',
  'flavodoxin-dependent(E)-4-hydroxy-3-methylbut-2-enyl-diphosphate synthase',
  1266511,
  1267716,
  -1,
  'FSC454_RS06205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046730.1',
  'Nif3-like dinuclear metal center hexamericprotein',
  1267814,
  1268560,
  1,
  'FSC454_RS06210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046728.1',
  'acid phosphatase',
  1268557,
  1269267,
  -1,
  'FSC454_RS06215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046725.1',
  'sugar porter family MFS transporter',
  1269345,
  1270697,
  -1,
  'FSC454_RS06220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046723.1',
  'SIS domain-containing protein',
  1270730,
  1271758,
  -1,
  'FSC454_RS06225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046722.1',
  'dicarboxylate/amino acid:cation symporter',
  1271958,
  1273232,
  1,
  'FSC454_RS06230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046720.1',
  'protein adenylyltransferase SelO',
  1273264,
  1274658,
  -1,
  'FSC454_RS06235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548099.1',
  'PIN domain-containing protein',
  1274769,
  1275386,
  1,
  'FSC454_RS06240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003018715.1',
  'rubredoxin',
  1275474,
  1275644,
  1,
  'FSC454_RS06245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046717.1',
  '1-aminocyclopropane-1-carboxylate deaminase',
  1275653,
  1276525,
  1,
  'FSC454_RS06250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794815.1',
  'hypothetical protein',
  1276589,
  1277194,
  1,
  'FSC454_RS06255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'carbonic anhydrase',
  1277478,
  1278163,
  -1,
  'FSC454_RS06260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ansA',
  'asparaginase',
  1278230,
  1279267,
  -1,
  'FSC454_RS06265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rnhA',
  'ribonuclease HI',
  1279269,
  1279727,
  -1,
  'FSC454_RS06270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046127.1',
  'class I SAM-dependent methyltransferase',
  1279702,
  1280292,
  -1,
  'FSC454_RS06275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aroA',
  '3-phosphoshikimate 1-carboxyvinyltransferase',
  1280295,
  1281572,
  -1,
  'FSC454_RS06280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpoH',
  'RNA polymerase sigma factor RpoH',
  1281663,
  1282541,
  -1,
  'FSC454_RS06285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046132.1',
  'SH3 domain-containing protein',
  1282565,
  1283053,
  -1,
  'FSC454_RS06290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secF',
  'protein translocase subunit SecF',
  1283127,
  1284071,
  -1,
  'FSC454_RS06295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secD',
  'protein translocase subunit SecD',
  1284090,
  1286027,
  -1,
  'FSC454_RS06300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yajC',
  'preprotein translocase subunit YajC',
  1286084,
  1286440,
  -1,
  'FSC454_RS06305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046143.1',
  'hypothetical protein',
  1286696,
  1286893,
  -1,
  'FSC454_RS06310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046146.1',
  'cysteine hydrolase family protein',
  1286982,
  1287560,
  -1,
  'FSC454_RS06315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046149.1',
  'DMT family transporter',
  1287572,
  1288447,
  -1,
  'FSC454_RS06320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046152.1',
  'LysR family transcriptional regulator',
  1288552,
  1289427,
  1,
  'FSC454_RS06325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tgt',
  'tRNA guanosine(34) transglycosylase Tgt',
  1289565,
  1290668,
  -1,
  'FSC454_RS06330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046218.1',
  'DUF3281 family protein',
  1290998,
  1291822,
  -1,
  'FSC454_RS06335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810698.1',
  'DUF3281 family protein',
  1292368,
  1292550,
  -1,
  'FSC454_RS06340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456258.1',
  'DUF3281 family protein',
  1293022,
  1293204,
  -1,
  'FSC454_RS06345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_414842597.1',
  'DUF3281 family protein',
  1293375,
  1294205,
  -1,
  'FSC454_RS06350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046164.1',
  'DUF3281 family protein',
  1294320,
  1295177,
  -1,
  'FSC454_RS06355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046167.1',
  'DUF3281 family protein',
  1295343,
  1295942,
  -1,
  'FSC454_RS06360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046170.1',
  'DUF3281 family protein',
  1295983,
  1296534,
  -1,
  'FSC454_RS06365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'plsY',
  'glycerol-3-phosphate 1-O-acyltransferase PlsY',
  1297312,
  1297926,
  1,
  'FSC454_RS06370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046177.1',
  'methionine ABC transporter ATP-binding protein',
  1297913,
  1298965,
  1,
  'FSC454_RS06375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046180.1',
  'MetQ/NlpA family ABC transportersubstrate-binding protein',
  1298943,
  1300415,
  1,
  'FSC454_RS06380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046183.1',
  'aromatic amino acid transport family protein',
  1300486,
  1301697,
  1,
  'FSC454_RS06385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046186.1',
  'rhodanese-like domain-containing protein',
  1301771,
  1302520,
  1,
  'FSC454_RS06390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ispF',
  '2-C-methyl-D-erythritol 2,4-cyclodiphosphatesynthase',
  1302532,
  1303011,
  1,
  'FSC454_RS06395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046192.1',
  'Mur ligase family protein',
  1303012,
  1304697,
  -1,
  'FSC454_RS06400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cphA',
  'cyanophycin synthetase',
  1304723,
  1307545,
  -1,
  'FSC454_RS06405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046198.1',
  'competence/damage-inducible protein A',
  1307669,
  1308412,
  1,
  'FSC454_RS06410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046201.1',
  'glycerophosphodiester phosphodiesterase familyprotein',
  1308401,
  1309153,
  -1,
  'FSC454_RS06415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pilB',
  'type IV-A pilus assembly ATPase PilB',
  1309312,
  1311090,
  1,
  'FSC454_RS06420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003036879.1',
  'type II secretion system F family protein',
  1311105,
  1312334,
  1,
  'FSC454_RS06425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046208.1',
  'AAA family ATPase',
  1312506,
  1313666,
  -1,
  'FSC454_RS06430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046211.1',
  'FPM13 family metalloprotein',
  1313682,
  1314020,
  -1,
  'FSC454_RS06435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247309.1',
  'hypothetical protein',
  1314037,
  1314288,
  -1,
  'FSC454_RS06440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemH',
  'ferrochelatase',
  1314430,
  1315431,
  1,
  'FSC454_RS06445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046215.1',
  'cryptochrome/photolyase family protein',
  1315416,
  1316810,
  1,
  'FSC454_RS06450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046217.1',
  'hypothetical protein',
  1316929,
  1317165,
  -1,
  'FSC454_RS06455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865160.1',
  'hypothetical protein',
  1317645,
  1317968,
  1,
  'FSC454_RS06460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046427.1',
  'PRC-barrel domain-containing protein',
  1318023,
  1318358,
  1,
  'FSC454_RS06465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046426.1',
  'PRC-barrel domain-containing protein',
  1318437,
  1318862,
  1,
  'FSC454_RS06470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046425.1',
  'hypothetical protein',
  1318927,
  1319169,
  1,
  'FSC454_RS06475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046424.1',
  'SDR family oxidoreductase',
  1319348,
  1320211,
  1,
  'FSC454_RS06480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046423.1',
  'ChaB family protein',
  1320223,
  1320453,
  1,
  'FSC454_RS06485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046422.1',
  'glycosyltransferase',
  1320685,
  1321680,
  1,
  'FSC454_RS06490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glyS',
  'glycine--tRNA ligase subunit beta',
  1321964,
  1324048,
  -1,
  'FSC454_RS06495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046420.1',
  'TatD family hydrolase',
  1324240,
  1324986,
  1,
  'FSC454_RS06500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'recF',
  'DNA replication/repair protein RecF',
  1324990,
  1326039,
  1,
  'FSC454_RS06505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046418.1',
  'lysozyme inhibitor LprI family protein',
  1326061,
  1326354,
  1,
  'FSC454_RS06510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548046.1',
  'hypothetical protein',
  1326443,
  1326649,
  1,
  'FSC454_RS06515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DMT family transporter',
  1326655,
  1327574,
  -1,
  'FSC454_RS06520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'acs',
  'acetate--CoA ligase',
  1327586,
  1329523,
  -1,
  'FSC454_RS06525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'galU',
  'UTP--glucose-1-phosphate uridylyltransferaseGalU',
  1329645,
  1330508,
  -1,
  'FSC454_RS06530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046414.1',
  'cation diffusion facilitator family transporter',
  1330525,
  1331664,
  -1,
  'FSC454_RS06535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470900.1',
  'HXXEE domain-containing protein',
  1331755,
  1332324,
  -1,
  'FSC454_RS06540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1332468,
  1332555,
  1,
  'FSC454_RS06545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  1332834,
  1333034,
  -1,
  'FSC454_RS06550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046412.1',
  'hypothetical protein',
  1333280,
  1333609,
  1,
  'FSC454_RS06555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046411.1',
  'cold-shock protein',
  1333808,
  1334011,
  1,
  'FSC454_RS06560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046410.1',
  'N(5)-(carboxyethyl)ornithine synthase',
  1334023,
  1335132,
  -1,
  'FSC454_RS06565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'KamA family radical SAM protein',
  1335471,
  1336413,
  -1,
  'FSC454_RS06570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046408.1',
  'alpha/beta hydrolase',
  1336614,
  1337600,
  1,
  'FSC454_RS06575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046407.1',
  'IclR family transcriptional regulator',
  1337656,
  1338375,
  -1,
  'FSC454_RS06580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794816.1',
  'hypothetical protein',
  1338575,
  1338772,
  1,
  'FSC454_RS10005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046406.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1338778,
  1339635,
  1,
  'FSC454_RS06590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046405.1',
  'FUSC family protein',
  1339632,
  1341329,
  1,
  'FSC454_RS06595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046404.1',
  'DUF2797 domain-containing protein',
  1341426,
  1342241,
  -1,
  'FSC454_RS06600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046403.1',
  'Hsp15 family ribosome-associated heat shockprotein',
  1342362,
  1342730,
  1,
  'FSC454_RS06605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046402.1',
  'NAD(P)H-hydrate dehydratase',
  1342766,
  1344229,
  -1,
  'FSC454_RS06610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548000.1',
  'hypothetical protein',
  1344428,
  1344556,
  1,
  'FSC454_RS10115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046401.1',
  'alpha/beta fold hydrolase',
  1344573,
  1345214,
  -1,
  'FSC454_RS06615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046400.1',
  'dipeptide epimerase',
  1345227,
  1346297,
  -1,
  'FSC454_RS06620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046399.1',
  'DUF819 family protein',
  1346294,
  1347460,
  -1,
  'FSC454_RS06625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046398.1',
  'glutathione peroxidase',
  1347506,
  1347976,
  -1,
  'FSC454_RS06630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046397.1',
  'chorismate mutase',
  1348005,
  1348352,
  -1,
  'FSC454_RS06635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046396.1',
  'hypothetical protein',
  1348448,
  1349074,
  1,
  'FSC454_RS06640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dusB',
  'tRNA dihydrouridine synthase DusB',
  1349220,
  1350197,
  -1,
  'FSC454_RS06645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'prmA',
  '50S ribosomal protein L11 methyltransferase',
  1350187,
  1351032,
  -1,
  'FSC454_RS06650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046393.1',
  'alpha-hydroxy acid oxidase',
  1351356,
  1352504,
  -1,
  'FSC454_RS06655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547990.1',
  'hypothetical protein',
  1352744,
  1352908,
  -1,
  'FSC454_RS09805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tyrS',
  'tyrosine--tRNA ligase',
  1352922,
  1354112,
  -1,
  'FSC454_RS06660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046740.1',
  'lipoyl protein ligase domain-containing protein',
  1354226,
  1355146,
  1,
  'FSC454_RS06665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046743.1',
  'hypothetical protein',
  1355212,
  1355961,
  -1,
  'FSC454_RS06670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hslV',
  'ATP-dependent protease subunit HslV',
  1356152,
  1356703,
  1,
  'FSC454_RS06675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hslU',
  'ATP-dependent protease ATPase subunit HslU',
  1356711,
  1358078,
  1,
  'FSC454_RS06680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046757.1',
  'peptide MFS transporter',
  1358179,
  1359630,
  1,
  'FSC454_RS06685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247289.1',
  'ion channel',
  1359710,
  1360870,
  1,
  'FSC454_RS06690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sthA',
  'Si-specific NAD(P)(+) transhydrogenase',
  1360972,
  1362372,
  1,
  'FSC454_RS06695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547981.1',
  'prepilin peptidase',
  1362376,
  1363224,
  1,
  'FSC454_RS06700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DsbC family protein',
  1363234,
  1364080,
  1,
  'FSC454_RS06705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bla',
  'class A beta-lactamase',
  1364089,
  1364973,
  1,
  'FSC454_RS06710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pth',
  'aminoacyl-tRNA hydrolase',
  1364966,
  1365541,
  1,
  'FSC454_RS06715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ychF',
  'redox-regulated ATPase YchF',
  1365560,
  1366651,
  1,
  'FSC454_RS06720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046751.1',
  'hypothetical protein',
  1366666,
  1366944,
  1,
  'FSC454_RS06725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247283.1',
  'HlyC/CorC family transporter',
  1366977,
  1368236,
  -1,
  'FSC454_RS06730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplY',
  '50S ribosomal protein L25',
  1368333,
  1368623,
  -1,
  'FSC454_RS06735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547973.1',
  'ribose-phosphate pyrophosphokinase',
  1368723,
  1369691,
  -1,
  'FSC454_RS06740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247281.1',
  'succinylglutamate desuccinylase/aspartoacylasefamily protein',
  1369902,
  1370909,
  1,
  'FSC454_RS06745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247279.1',
  'MFS transporter',
  1370902,
  1372185,
  1,
  'FSC454_RS06750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046753.1',
  'MFS transporter',
  1372192,
  1373478,
  -1,
  'FSC454_RS06755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247277.1',
  'mechanosensitive ion channel domain-containingprotein',
  1373772,
  1374605,
  1,
  'FSC454_RS06760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247275.1',
  'cation:proton antiporter',
  1374583,
  1375758,
  -1,
  'FSC454_RS06765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047217.1',
  'VOC family protein',
  1376346,
  1376726,
  -1,
  'FSC454_RS06770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1376791,
  1377434,
  -1,
  'FSC454_RS06775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047211.1',
  'isochorismatase family protein',
  1377434,
  1377937,
  -1,
  'FSC454_RS06780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047208.1',
  'isochorismatase family protein',
  1378038,
  1378541,
  -1,
  'FSC454_RS06785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047205.1',
  'DNA-3-methyladenine glycosylase',
  1378667,
  1379248,
  1,
  'FSC454_RS06790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047202.1',
  'class II aldolase/adducin family protein',
  1379343,
  1380041,
  1,
  'FSC454_RS06795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047200.1',
  'histidine decarboxylase',
  1380056,
  1381192,
  1,
  'FSC454_RS06800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047197.1',
  'amidohydrolase family protein',
  1381179,
  1381991,
  -1,
  'FSC454_RS06805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047194.1',
  'metal-independent carbonic anhydrase familyprotein',
  1382154,
  1382615,
  1,
  'FSC454_RS06810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047191.1',
  'helix-turn-helix transcriptional regulator',
  1382651,
  1382947,
  1,
  'FSC454_RS06815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'cytochrome b/b6 domain-containing protein',
  1382969,
  1383111,
  -1,
  'FSC454_RS10245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047188.1',
  'DNA recombination protein RmuC',
  1383317,
  1384732,
  -1,
  'FSC454_RS06825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047186.1',
  'hypothetical protein',
  1385040,
  1385462,
  1,
  'FSC454_RS06830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nadB',
  'L-aspartate oxidase',
  1385526,
  1387016,
  -1,
  'FSC454_RS06835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nadC',
  'carboxylating nicotinate-nucleotidediphosphorylase',
  1387019,
  1387882,
  -1,
  'FSC454_RS06840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nadA',
  'quinolinate synthase NadA',
  1387892,
  1388916,
  -1,
  'FSC454_RS06845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gmk',
  'guanylate kinase',
  1388937,
  1389509,
  -1,
  'FSC454_RS06850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047174.1',
  'DEAD/DEAH box helicase',
  1389626,
  1391338,
  -1,
  'FSC454_RS06855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547950.1',
  'peptidylprolyl isomerase',
  1391403,
  1391681,
  -1,
  'FSC454_RS06860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047171.1',
  'sugar porter family MFS transporter',
  1391776,
  1393170,
  -1,
  'FSC454_RS06865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047168.1',
  'sugar porter family MFS transporter',
  1393208,
  1394590,
  -1,
  'FSC454_RS06870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047165.1',
  'UDP-glucose--hexose-1-phosphateuridylyltransferase',
  1394681,
  1395706,
  1,
  'FSC454_RS06875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'galactokinase',
  1395709,
  1396859,
  1,
  'FSC454_RS06880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047159.1',
  'HIT domain-containing protein',
  1396856,
  1397251,
  -1,
  'FSC454_RS06885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'kdsB',
  '3-deoxy-manno-octulosonate cytidylyltransferase',
  1397244,
  1397996,
  -1,
  'FSC454_RS06890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547943.1',
  'Trm112 family protein',
  1397989,
  1398177,
  -1,
  'FSC454_RS06895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047154.1',
  'phosphatase PAP2 family protein',
  1398516,
  1399133,
  -1,
  'FSC454_RS06900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uvrC',
  'excinuclease ABC subunit UvrC',
  1399202,
  1401040,
  -1,
  'FSC454_RS06905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547940.1',
  'ribonuclease D',
  1401147,
  1402241,
  1,
  'FSC454_RS06910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047221.1',
  'multidrug effflux MFS transporter',
  1402270,
  1403484,
  1,
  'FSC454_RS06915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047149.1',
  'DUF2237 family protein',
  1403481,
  1403858,
  -1,
  'FSC454_RS06920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpmA',
  '50S ribosomal protein L27',
  1404120,
  1404374,
  -1,
  'FSC454_RS06925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplU',
  '50S ribosomal protein L21',
  1404405,
  1404719,
  -1,
  'FSC454_RS06930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047142.1',
  'hypothetical protein',
  1404878,
  1405216,
  -1,
  'FSC454_RS06940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047139.1',
  'DNA-3-methyladenine glycosylase I',
  1405268,
  1405837,
  -1,
  'FSC454_RS06945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047136.1',
  'DUF6194 family protein',
  1405847,
  1406308,
  -1,
  'FSC454_RS06950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secA',
  'preprotein translocase subunit SecA',
  1406310,
  1409030,
  -1,
  'FSC454_RS06955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047131.1',
  'LPP20 family lipoprotein',
  1409162,
  1410190,
  1,
  'FSC454_RS06960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547930.1',
  'hypothetical protein',
  1410194,
  1410625,
  1,
  'FSC454_RS06965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'deoD',
  'purine-nucleoside phosphorylase',
  1410641,
  1411363,
  -1,
  'FSC454_RS06970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftsH',
  'ATP-dependent zinc metalloprotease FtsH',
  1411598,
  1413544,
  -1,
  'FSC454_RS06975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047124.1',
  'MFS transporter',
  1413758,
  1415146,
  1,
  'FSC454_RS06980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'uvrA',
  'excinuclease ABC subunit UvrA',
  1415152,
  1417974,
  -1,
  'FSC454_RS06985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'greA',
  'transcription elongation factor GreA',
  1418013,
  1418495,
  -1,
  'FSC454_RS06990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047119.1',
  'pilus assembly FimT family protein',
  1418529,
  1419110,
  -1,
  'FSC454_RS06995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS06995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pgi',
  'glucose-6-phosphate isomerase',
  1419111,
  1420733,
  -1,
  'FSC454_RS07000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047113.1',
  'thiamine diphosphokinase',
  1420720,
  1421373,
  -1,
  'FSC454_RS07005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'guaB',
  'IMP dehydrogenase',
  1421439,
  1422899,
  -1,
  'FSC454_RS07010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047107.1',
  'leucyl aminopeptidase',
  1422999,
  1424438,
  -1,
  'FSC454_RS07015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lptF',
  'LPS export ABC transporter permease LptF',
  1424604,
  1425686,
  1,
  'FSC454_RS07020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lptG',
  'LPS export ABC transporter permease LptG',
  1425686,
  1426747,
  1,
  'FSC454_RS07025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'M16 family metallopeptidase',
  1426755,
  1428007,
  1,
  'FSC454_RS07030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047100.1',
  'M16 family metallopeptidase',
  1428014,
  1429237,
  1,
  'FSC454_RS07035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rsmD',
  '16S rRNA (guanine(966)-N(2))-methyltransferaseRsmD',
  1429238,
  1429816,
  1,
  'FSC454_RS07040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014547914.1',
  'trimeric intracellular cation channel familyprotein',
  1429849,
  1430499,
  1,
  'FSC454_RS07045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047094.1',
  'MiaE family protein',
  1430551,
  1431162,
  -1,
  'FSC454_RS07050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'udp',
  'uridine phosphorylase',
  1431280,
  1432083,
  1,
  'FSC454_RS07055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cdd',
  'cytidine deaminase',
  1432104,
  1432505,
  1,
  'FSC454_RS07060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794819.1',
  'terminase small subunit',
  1432802,
  1433236,
  -1,
  'FSC454_RS07065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047088.1',
  'hypothetical protein',
  1433236,
  1433424,
  -1,
  'FSC454_RS07070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047085.1',
  'CopG family antitoxin',
  1433433,
  1433612,
  -1,
  'FSC454_RS07075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003040801.1',
  'hypothetical protein',
  1433609,
  1433821,
  -1,
  'FSC454_RS07080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047082.1',
  'hypothetical protein',
  1433830,
  1434144,
  -1,
  'FSC454_RS07085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047079.1',
  'helix-turn-helix transcriptional regulator',
  1434307,
  1434603,
  -1,
  'FSC454_RS07090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047077.1',
  'type II toxin-antitoxin system mRNA interferasetoxin, RelE/StbE family',
  1434614,
  1434904,
  -1,
  'FSC454_RS07095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794820.1',
  'hypothetical protein',
  1434976,
  1435377,
  -1,
  'FSC454_RS07100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046233.1',
  'DUF3987 domain-containing protein',
  1435629,
  1437134,
  -1,
  'FSC454_RS07105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046433.1',
  'primase/helicase family protein',
  1437136,
  1438035,
  -1,
  'FSC454_RS07110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046432.1',
  'hypothetical protein',
  1438048,
  1438365,
  -1,
  'FSC454_RS07115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046430.1',
  'helix-turn-helix transcriptional regulator',
  1438726,
  1438905,
  -1,
  'FSC454_RS07120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794821.1',
  'hypothetical protein',
  1439257,
  1439739,
  -1,
  'FSC454_RS07125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047371.1',
  'tyrosine-type recombinase/integrase',
  1439844,
  1441094,
  -1,
  'FSC454_RS07130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1441271,
  1441359,
  -1,
  'FSC454_RS07135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1441365,
  1441438,
  -1,
  'FSC454_RS07140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1441454,
  1441528,
  -1,
  'FSC454_RS07145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047368.1',
  'aq_1923 C-terminal domain',
  1441621,
  1443273,
  -1,
  'FSC454_RS07150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047365.1',
  'FeoA domain-containing protein',
  1443290,
  1443514,
  -1,
  'FSC454_RS07155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047362.1',
  'SPOR domain-containing protein',
  1443625,
  1444317,
  1,
  'FSC454_RS07160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047360.1',
  'hydroxyacylglutathione hydrolase',
  1444397,
  1445155,
  -1,
  'FSC454_RS07165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047358.1',
  'hypothetical protein',
  1445169,
  1446326,
  -1,
  'FSC454_RS07170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047356.1',
  'hypothetical protein',
  1446323,
  1447405,
  -1,
  'FSC454_RS07175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047354.1',
  'uroporphyrinogen-III synthase',
  1447371,
  1448120,
  -1,
  'FSC454_RS07180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548721.1',
  'SufE family protein',
  1448121,
  1448537,
  -1,
  'FSC454_RS07185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1448904,
  1448979,
  1,
  'FSC454_RS07190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047351.1',
  'disulfide bond formation protein B',
  1449382,
  1449918,
  1,
  'FSC454_RS07195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047346.1',
  'proline--tRNA ligase',
  1450182,
  1451879,
  1,
  'FSC454_RS07200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047343.1',
  'VOC family protein',
  1452159,
  1452641,
  1,
  'FSC454_RS07205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047340.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  1452872,
  1454005,
  1,
  'FSC454_RS07210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1454023,
  1454499,
  1,
  'FSC454_RS10180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047336.1',
  'hypothetical protein',
  1454607,
  1455515,
  1,
  'FSC454_RS10185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548727.1',
  'DUF3568 family protein',
  1455553,
  1455966,
  -1,
  'FSC454_RS07225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'amidohydrolase',
  1456133,
  1456904,
  1,
  'FSC454_RS07230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nusB',
  'transcription antitermination factor NusB',
  1456888,
  1457313,
  -1,
  'FSC454_RS07235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548730.1',
  'hypothetical protein',
  1457501,
  1457902,
  1,
  'FSC454_RS07240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047331.1',
  'hypothetical protein',
  1457920,
  1458432,
  1,
  'FSC454_RS07245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003022238.1',
  'YcgN family cysteine cluster protein',
  1458658,
  1459104,
  1,
  'FSC454_RS07250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548732.1',
  '2OG-Fe(II) oxygenase',
  1459156,
  1459764,
  1,
  'FSC454_RS07255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548733.1',
  'sulfite exporter TauE/SafE family protein',
  1459757,
  1460506,
  -1,
  'FSC454_RS07260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047329.1',
  'MBL fold metallo-hydrolase',
  1460507,
  1461193,
  -1,
  'FSC454_RS07265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047326.1',
  'FAD-dependent oxidoreductase',
  1461244,
  1462926,
  -1,
  'FSC454_RS07270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047323.1',
  'rhodanese-like domain-containing protein',
  1462951,
  1463469,
  -1,
  'FSC454_RS07275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047320.1',
  'ArsR/SmtB family transcription factor',
  1463531,
  1463833,
  -1,
  'FSC454_RS07280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas2',
  'CRISPR-associated endonuclease Cas2',
  1464196,
  1464468,
  -1,
  'FSC454_RS07285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas1',
  'type V CRISPR-associated endonuclease Cas1',
  1464449,
  1465453,
  -1,
  'FSC454_RS07290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas4',
  'type V CRISPR-associated protein Cas4',
  1465457,
  1466011,
  -1,
  'FSC454_RS07295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cas12a',
  'type V CRISPR-associated protein Cas12a/Cpf1',
  1466115,
  1470017,
  -1,
  'FSC454_RS07300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794822.1',
  'GNAT family N-acetyltransferase',
  1470089,
  1470619,
  -1,
  'FSC454_RS07305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794844.1',
  'hypothetical protein',
  1470625,
  1471341,
  -1,
  'FSC454_RS07310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trmB',
  'tRNA (guanosine(46)-N7)-methyltransferase TrmB',
  1471469,
  1472167,
  -1,
  'FSC454_RS07315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046441.1',
  'LysE family translocator',
  1472237,
  1472872,
  1,
  'FSC454_RS07320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046442.1',
  'NAD(+)/NADH kinase',
  1472869,
  1473759,
  -1,
  'FSC454_RS07325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548747.1',
  'glycosyltransferase family 2 protein',
  1473948,
  1474892,
  1,
  'FSC454_RS07330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046443.1',
  'ABC transporter permease',
  1474896,
  1475675,
  -1,
  'FSC454_RS07335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548749.1',
  'ABC transporter ATP-binding protein',
  1475684,
  1476607,
  -1,
  'FSC454_RS07340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046448.1',
  'TSUP family transporter',
  1476709,
  1477485,
  -1,
  'FSC454_RS07345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046444.1',
  'cupin domain-containing protein',
  1477485,
  1477814,
  -1,
  'FSC454_RS07350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046445.1',
  'TatD family hydrolase',
  1477948,
  1478715,
  -1,
  'FSC454_RS07355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046446.1',
  'MFS transporter',
  1478794,
  1480179,
  -1,
  'FSC454_RS07360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548754.1',
  'ferritin-like domain-containing protein',
  1480509,
  1480949,
  1,
  'FSC454_RS07365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1481158,
  1481244,
  -1,
  'FSC454_RS07370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548755.1',
  'DNA-directed RNA polymerase subunit alpha',
  1481253,
  1482209,
  -1,
  'FSC454_RS07375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046763.1',
  'AAA family ATPase',
  1482298,
  1483536,
  -1,
  'FSC454_RS07380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046765.1',
  'Ppx/GppA phosphatase family protein',
  1483704,
  1484630,
  -1,
  'FSC454_RS07385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trxA',
  'thioredoxin',
  1484828,
  1485151,
  1,
  'FSC454_RS07390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rho',
  'transcription termination factor Rho',
  1485194,
  1486456,
  1,
  'FSC454_RS07395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046767.1',
  'phosphomannomutase',
  1487378,
  1488862,
  -1,
  'FSC454_RS07400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046769.1',
  'mannose-1-phosphateguanylyltransferase/mannose-6-phosphate isomerase',
  1488893,
  1490299,
  -1,
  'FSC454_RS07405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'GDP-mannose 4,6-dehydratase',
  1490619,
  1490930,
  -1,
  'FSC454_RS07410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS1595 family transposase',
  1491034,
  1491627,
  1,
  'FSC454_RS07415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_425268617.1',
  'IS630 transposase-related protein',
  1491796,
  1492029,
  1,
  'FSC454_RS10250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'transposase',
  1492092,
  1492493,
  1,
  'FSC454_RS10190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS1595 family transposase',
  1492515,
  1492610,
  1,
  'FSC454_RS09695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046775.1',
  'O-antigen translocase',
  1492607,
  1493851,
  -1,
  'FSC454_RS07430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'asnB',
  'asparagine synthase (glutamine-hydrolyzing)',
  1493856,
  1495748,
  -1,
  'FSC454_RS07435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794845.1',
  'glycosyltransferase',
  1495750,
  1496862,
  -1,
  'FSC454_RS07440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046939.1',
  'glycosyltransferase family 4 protein',
  1496855,
  1497943,
  -1,
  'FSC454_RS07445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046941.1',
  'oligosaccharide repeat unit polymerase',
  1497909,
  1499201,
  -1,
  'FSC454_RS07450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046943.1',
  'SDR family oxidoreductase',
  1499198,
  1500172,
  -1,
  'FSC454_RS07455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'nucleotide sugar dehydrogenase',
  1500172,
  1501482,
  -1,
  'FSC454_RS07460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794823.1',
  'glycosyltransferase family 4 protein',
  1501486,
  1502589,
  -1,
  'FSC454_RS07465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046949.1',
  'NAD-dependent epimerase/dehydratase familyprotein',
  1502579,
  1503370,
  -1,
  'FSC454_RS07470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047018.1',
  'sugar transferase',
  1503372,
  1503989,
  -1,
  'FSC454_RS07475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046951.1',
  'polysaccharide biosynthesis protein',
  1503997,
  1505733,
  -1,
  'FSC454_RS07480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hrpA',
  'ATP-dependent RNA helicase HrpA',
  1506201,
  1510124,
  -1,
  'FSC454_RS07485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046956.1',
  'GumC domain-containing protein',
  1510145,
  1511038,
  -1,
  'FSC454_RS07490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046958.1',
  'NADP-dependent isocitrate dehydrogenase',
  1511048,
  1513264,
  -1,
  'FSC454_RS07495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046960.1',
  'arsenate reductase family protein',
  1513314,
  1513661,
  -1,
  'FSC454_RS07500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046962.1',
  'long-chain-fatty-acid--CoA ligase',
  1513882,
  1515576,
  1,
  'FSC454_RS07505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046964.1',
  'acyl-CoA dehydrogenase',
  1515607,
  1517847,
  1,
  'FSC454_RS07510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046966.1',
  'acyl-CoA-binding protein',
  1517920,
  1520613,
  1,
  'FSC454_RS07515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046968.1',
  'acetyl-CoA C-acyltransferase',
  1520626,
  1521813,
  1,
  'FSC454_RS07520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046970.1',
  'PaaI family thioesterase',
  1521877,
  1522365,
  1,
  'FSC454_RS07525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046972.1',
  'MFS transporter',
  1522358,
  1523638,
  -1,
  'FSC454_RS07530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046974.1',
  'HP1242/YdcH family protein',
  1523786,
  1524013,
  -1,
  'FSC454_RS07535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'nicotinate phosphoribosyltransferase',
  1524098,
  1525514,
  -1,
  'FSC454_RS07540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046978.1',
  'ornithine cyclodeaminase',
  1525585,
  1526601,
  -1,
  'FSC454_RS07545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ctlX',
  'citrulline utilization hydrolase CtlX',
  1526851,
  1527765,
  -1,
  'FSC454_RS07550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046982.1',
  'COG3014 family protein',
  1527913,
  1529304,
  -1,
  'FSC454_RS07555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046984.1',
  'penicillin-binding protein activator LpoB',
  1529311,
  1530294,
  -1,
  'FSC454_RS07560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794824.1',
  'DUF6844 domain-containing protein',
  1530305,
  1531723,
  -1,
  'FSC454_RS07565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpoB',
  'penicillin-binding protein activator LpoB',
  1531795,
  1532403,
  -1,
  'FSC454_RS07570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865171.1',
  'class I SAM-dependent methyltransferase',
  1532486,
  1532908,
  -1,
  'FSC454_RS07575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046988.1',
  'hypothetical protein',
  1533140,
  1533541,
  -1,
  'FSC454_RS07580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046990.1',
  'hypothetical protein',
  1533655,
  1534191,
  -1,
  'FSC454_RS07585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bfpR',
  'two-component system response regulator BfpR',
  1534334,
  1535023,
  1,
  'FSC454_RS07590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865172.1',
  'HAMP domain-containing sensor histidine kinase',
  1535073,
  1536044,
  1,
  'FSC454_RS07595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046995.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1536121,
  1537374,
  1,
  'FSC454_RS07600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046997.1',
  'DUF1365 domain-containing protein',
  1537368,
  1538144,
  1,
  'FSC454_RS07605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046999.1',
  'SAM-dependent methyltransferase',
  1538263,
  1539426,
  1,
  'FSC454_RS07610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047001.1',
  'chalcone isomerase family protein',
  1539419,
  1539937,
  1,
  'FSC454_RS07615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047003.1',
  'DUF3833 domain-containing protein',
  1539934,
  1540476,
  1,
  'FSC454_RS07620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047005.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  1540478,
  1541221,
  1,
  'FSC454_RS07625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047007.1',
  'acyl-CoA desaturase',
  1541235,
  1542065,
  1,
  'FSC454_RS07630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rnr',
  'ribonuclease R',
  1542073,
  1544370,
  -1,
  'FSC454_RS07635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'truB',
  'tRNA pseudouridine(55) synthase TruB',
  1544363,
  1545271,
  -1,
  'FSC454_RS07640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rnc',
  'ribonuclease III',
  1545258,
  1545950,
  -1,
  'FSC454_RS07645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lepB',
  'signal peptidase I',
  1545957,
  1546820,
  -1,
  'FSC454_RS07650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'qseB',
  'response regulator QseB',
  1546827,
  1547513,
  -1,
  'FSC454_RS07655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066047016.1',
  'PrpF domain-containing protein',
  1547947,
  1549038,
  -1,
  'FSC454_RS07660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS5 family transposase',
  1549203,
  1549943,
  1,
  'FSC454_RS07665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'proC',
  'pyrroline-5-carboxylate reductase',
  1550134,
  1550958,
  -1,
  'FSC454_RS07670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rdgB',
  'RdgB/HAM1 family non-canonical purine NTPpyrophosphatase',
  1551066,
  1551644,
  1,
  'FSC454_RS07675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'waaA',
  'lipid IV(A) 3-deoxy-D-manno-octulosonic acidtransferase',
  1551745,
  1553040,
  1,
  'FSC454_RS07680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046529.1',
  'polyprenyl synthetase family protein',
  1553037,
  1553918,
  1,
  'FSC454_RS07685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046531.1',
  'CDP-alcohol phosphatidyltransferase familyprotein',
  1553966,
  1554730,
  1,
  'FSC454_RS07690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ppk2',
  'polyphosphate kinase 2',
  1554799,
  1555608,
  1,
  'FSC454_RS07695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1555674,
  1555750,
  1,
  'FSC454_RS07700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'glycoside hydrolase family 3 N-terminaldomain-containing protein',
  1555919,
  1556912,
  -1,
  'FSC454_RS10195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'cell division protein ZipA C-terminalFtsZ-binding domain-containing protein',
  1557835,
  1558320,
  -1,
  'FSC454_RS10200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxB',
  'lipid-A-disaccharide synthase',
  1558528,
  1559406,
  -1,
  'FSC454_RS07715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxA',
  'acyl-ACP--UDP-N-acetylglucosamineO-acyltransferase',
  1559523,
  1560300,
  -1,
  'FSC454_RS07720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fabZ',
  '3-hydroxyacyl-ACP dehydratase FabZ',
  1560303,
  1560795,
  -1,
  'FSC454_RS07725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxD',
  'UDP-3-O-(3-hydroxymyristoyl)glucosamineN-acyltransferase',
  1560810,
  1561823,
  -1,
  'FSC454_RS07730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'OmpH/Skp family outer membrane protein',
  1561845,
  1562344,
  -1,
  'FSC454_RS07735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bamA',
  'outer membrane protein assembly factor BamA',
  1562480,
  1564859,
  -1,
  'FSC454_RS07740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dxr',
  '1-deoxy-D-xylulose-5-phosphate reductoisomerase',
  1564865,
  1566022,
  -1,
  'FSC454_RS07745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gyrA',
  'DNA gyrase subunit A',
  1566028,
  1568616,
  -1,
  'FSC454_RS07750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_331709119.1',
  'carbohydrate-binding protein',
  1569497,
  1570555,
  1,
  'FSC454_RS10205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ung',
  'uracil-DNA glycosylase',
  1570544,
  1571206,
  -1,
  'FSC454_RS07760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpdA',
  'dihydrolipoyl dehydrogenase',
  1571377,
  1572786,
  -1,
  'FSC454_RS07765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aceF',
  'pyruvate dehydrogenase complexdihydrolipoyllysine-residue acetyltransferase',
  1572802,
  1574673,
  -1,
  'FSC454_RS07770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'aceE',
  'pyruvate dehydrogenase (acetyl-transferring),homodimeric type',
  1574691,
  1577372,
  -1,
  'FSC454_RS07775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'class I SAM-dependent methyltransferase',
  1577675,
  1578851,
  -1,
  'FSC454_RS07780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'coaE',
  'dephospho-CoA kinase',
  1578983,
  1579597,
  1,
  'FSC454_RS07785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1579630,
  1579706,
  1,
  'FSC454_RS07790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1579721,
  1579795,
  1,
  'FSC454_RS07795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trpS',
  'tryptophan--tRNA ligase',
  1579894,
  1580898,
  1,
  'FSC454_RS07800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046558.1',
  'hypothetical protein',
  1580900,
  1581625,
  1,
  'FSC454_RS07805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046560.1',
  'cation:proton antiporter',
  1581635,
  1582939,
  1,
  'FSC454_RS07810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS701 family transposase',
  1583080,
  1583388,
  1,
  'FSC454_RS07815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148257.1',
  'sensor histidine kinase',
  1583432,
  1583980,
  -1,
  'FSC454_RS10030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS5 family transposase',
  1584866,
  1585605,
  1,
  'FSC454_RS07825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359448.1',
  'lipase family protein',
  1585593,
  1585871,
  1,
  'FSC454_RS07830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045397.1',
  'hypothetical protein',
  1586056,
  1586367,
  1,
  'FSC454_RS07835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046829.1',
  'response regulator transcription factor',
  1586575,
  1587300,
  1,
  'FSC454_RS07840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046827.1',
  'hypothetical protein',
  1587453,
  1587848,
  -1,
  'FSC454_RS07845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'murQ',
  'N-acetylmuramic acid 6-phosphate etherase',
  1587850,
  1588734,
  -1,
  'FSC454_RS07850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046824.1',
  'hypothetical protein',
  1588731,
  1590713,
  -1,
  'FSC454_RS07855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046822.1',
  'PilW family protein',
  1590722,
  1591735,
  -1,
  'FSC454_RS07860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548854.1',
  'hypothetical protein',
  1591719,
  1592219,
  -1,
  'FSC454_RS07865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046820.1',
  'acetyl-CoA carboxylase carboxyltransferasesubunit alpha',
  1592249,
  1593196,
  -1,
  'FSC454_RS07870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'mutS',
  'DNA mismatch repair protein MutS',
  1593363,
  1595900,
  1,
  'FSC454_RS07875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secB',
  'protein-export chaperone SecB',
  1595979,
  1596422,
  1,
  'FSC454_RS07880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046814.1',
  'ATP-grasp domain-containing protein',
  1596616,
  1597839,
  1,
  'FSC454_RS07885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046812.1',
  'amino acid permease',
  1597865,
  1599076,
  1,
  'FSC454_RS07890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046811.1',
  'tyrosine-type recombinase/integrase',
  1599086,
  1599964,
  1,
  'FSC454_RS07895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548861.1',
  'class I SAM-dependent methyltransferase',
  1599964,
  1600689,
  1,
  'FSC454_RS07900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046809.1',
  'hypothetical protein',
  1600695,
  1601309,
  -1,
  'FSC454_RS07905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046807.1',
  'DUF4124 domain-containing protein',
  1601397,
  1601975,
  1,
  'FSC454_RS07910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046805.1',
  'DUF4124 domain-containing protein',
  1602052,
  1602687,
  1,
  'FSC454_RS07915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'RelA/SpoT family protein',
  1602768,
  1604709,
  -1,
  'FSC454_RS07920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rnpB',
  '—',
  1604735,
  1605078,
  -1,
  'FSC454_RS07925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548866.1',
  'hypothetical protein',
  1605086,
  1605442,
  -1,
  'FSC454_RS07930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046803.1',
  'amino acid permease',
  1605476,
  1606672,
  -1,
  'FSC454_RS07935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046801.1',
  'DMT family transporter',
  1606904,
  1607782,
  1,
  'FSC454_RS07940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046799.1',
  'DnaJ C-terminal domain-containing protein',
  1607779,
  1608711,
  -1,
  'FSC454_RS07945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'APC family permease',
  1608931,
  1610166,
  1,
  'FSC454_RS10035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_341853300.1',
  'GNAT family N-acetyltransferase',
  1610413,
  1611135,
  1,
  'FSC454_RS10040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'membrane lipoprotein',
  1611245,
  1611629,
  -1,
  'FSC454_RS07955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'CDP-alcohol phosphatidyltransferase familyprotein',
  1611629,
  1612226,
  -1,
  'FSC454_RS07960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046793.1',
  'dihydrolipoyl dehydrogenase family protein',
  1612223,
  1613635,
  -1,
  'FSC454_RS07965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046791.1',
  'TVP38/TMEM64 family protein',
  1613638,
  1614330,
  -1,
  'FSC454_RS07970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046788.1',
  'methylated-DNA--[protein]-cysteineS-methyltransferase',
  1614374,
  1614937,
  1,
  'FSC454_RS07975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046786.1',
  'APC family permease',
  1615338,
  1616741,
  -1,
  'FSC454_RS07980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lysA',
  'diaminopimelate decarboxylase',
  1616756,
  1617940,
  -1,
  'FSC454_RS07985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794825.1',
  'L,D-transpeptidase family protein',
  1617949,
  1618641,
  -1,
  'FSC454_RS07990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gdhA',
  'NADP-specific glutamate dehydrogenase',
  1619141,
  1620490,
  1,
  'FSC454_RS07995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS07995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548880.1',
  'BaiN/RdsA family NAD(P)/FAD-dependentoxidoreductase',
  1620585,
  1621775,
  1,
  'FSC454_RS08000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046779.1',
  'FTL_1293 family small RNA FtrC-regulatedprotein',
  1621830,
  1622300,
  1,
  'FSC454_RS08005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_197456248.1',
  'IS630 family transposase',
  1622453,
  1622986,
  -1,
  'FSC454_RS08010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045226.1',
  'IS630 transposase-related protein',
  1622916,
  1623266,
  -1,
  'FSC454_RS08015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046564.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  1623405,
  1624229,
  1,
  'FSC454_RS08020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046566.1',
  'APC family permease',
  1624251,
  1625600,
  -1,
  'FSC454_RS08025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548884.1',
  'hypothetical protein',
  1625828,
  1626700,
  -1,
  'FSC454_RS08030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'groL',
  'chaperonin GroEL',
  1627027,
  1628667,
  -1,
  'FSC454_RS08035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548886.1',
  'co-chaperone GroES',
  1628705,
  1628992,
  -1,
  'FSC454_RS08040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046570.1',
  'PACE efflux transporter',
  1629296,
  1629730,
  1,
  'FSC454_RS08045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1629745,
  1629820,
  1,
  'FSC454_RS08050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003029898.1',
  'hypothetical protein',
  1629832,
  1629963,
  -1,
  'FSC454_RS10130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ffs',
  '—',
  1630170,
  1630266,
  -1,
  'FSC454_RS08055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'yaaA',
  'peroxide stress protein YaaA',
  1630380,
  1631144,
  1,
  'FSC454_RS08060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rlmH',
  '23S rRNA(pseudouridine(1915)-N(3))-methyltransferase RlmH',
  1631148,
  1631615,
  1,
  'FSC454_RS08065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'prmC',
  'peptide chain release factor N(5)-glutaminemethyltransferase',
  1631606,
  1632460,
  -1,
  'FSC454_RS08070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'prfA',
  'peptide chain release factor 1',
  1632453,
  1633538,
  -1,
  'FSC454_RS08075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046577.1',
  'glutamyl-tRNA reductase',
  1633539,
  1634783,
  -1,
  'FSC454_RS08080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046579.1',
  'YfgM family protein',
  1634964,
  1635602,
  1,
  'FSC454_RS08085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bamB',
  'outer membrane protein assembly factor BamB',
  1635605,
  1636972,
  1,
  'FSC454_RS08090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046581.1',
  'multidrug effflux MFS transporter',
  1636972,
  1638153,
  1,
  'FSC454_RS08095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'parE',
  'DNA topoisomerase IV subunit B',
  1638244,
  1640127,
  1,
  'FSC454_RS08100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ampD',
  '1,6-anhydro-N-acetylmuramyl-L-alanine amidaseAmpD',
  1640170,
  1640694,
  -1,
  'FSC454_RS08105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548898.1',
  'phosphatase PAP2 family protein',
  1640769,
  1641404,
  1,
  'FSC454_RS08110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548899.1',
  'RNA pyrophosphohydrolase',
  1641401,
  1641868,
  -1,
  'FSC454_RS08115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046586.1',
  'glucosyltransferase domain-containing protein',
  1642032,
  1643552,
  1,
  'FSC454_RS08120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247482.1',
  'EamA family transporter',
  1643670,
  1644554,
  1,
  'FSC454_RS08125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046588.1',
  'HAD family acid phosphatase',
  1644551,
  1645135,
  -1,
  'FSC454_RS08130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548904.1',
  '2OG-Fe(II) oxygenase family protein',
  1645140,
  1645985,
  -1,
  'FSC454_RS08135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'xerD',
  'site-specific tyrosine recombinase XerD',
  1646110,
  1646988,
  -1,
  'FSC454_RS08140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplS',
  '50S ribosomal protein L19',
  1647154,
  1647501,
  -1,
  'FSC454_RS08145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trmD',
  'tRNA (guanosine(37)-N1)-methyltransferase TrmD',
  1647501,
  1648259,
  -1,
  'FSC454_RS08150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rimM',
  'ribosome maturation factor RimM',
  1648555,
  1649064,
  -1,
  'FSC454_RS08155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpsP',
  '30S ribosomal protein S16',
  1649099,
  1649347,
  -1,
  'FSC454_RS08160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'metK',
  'methionine adenosyltransferase',
  1649641,
  1650801,
  1,
  'FSC454_RS08165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1650951,
  1652032,
  -1,
  'FSC454_RS08170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548911.1',
  'acyl-CoA desaturase',
  1652759,
  1653925,
  -1,
  'FSC454_RS08175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tsaD',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complextransferase subunit TsaD',
  1654038,
  1655048,
  -1,
  'FSC454_RS08180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247485.1',
  'lipopolysaccharide assembly protein LapAdomain-containing protein',
  1655048,
  1655284,
  -1,
  'FSC454_RS08185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpoC',
  'DNA-directed RNA polymerase subunit beta''',
  1655387,
  1659640,
  -1,
  'FSC454_RS08190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rpoB',
  'DNA-directed RNA polymerase subunit beta',
  1659702,
  1663779,
  -1,
  'FSC454_RS08195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplL',
  '50S ribosomal protein L7/L12',
  1663933,
  1664310,
  -1,
  'FSC454_RS08200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplJ',
  '50S ribosomal protein L10',
  1664373,
  1664891,
  -1,
  'FSC454_RS08205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplA',
  '50S ribosomal protein L1',
  1665062,
  1665757,
  -1,
  'FSC454_RS08210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rplK',
  '50S ribosomal protein L11',
  1665760,
  1666194,
  -1,
  'FSC454_RS08215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nusG',
  'transcription termination/antiterminationprotein NusG',
  1666266,
  1666799,
  -1,
  'FSC454_RS08220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secE',
  'preprotein translocase subunit SecE',
  1666815,
  1667246,
  -1,
  'FSC454_RS08225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1667381,
  1667456,
  -1,
  'FSC454_RS08230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tuf',
  'elongation factor Tu',
  1667474,
  1668658,
  -1,
  'FSC454_RS08235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1668703,
  1668778,
  -1,
  'FSC454_RS08240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1668807,
  1668880,
  -1,
  'FSC454_RS08245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1668882,
  1668966,
  -1,
  'FSC454_RS08250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045326.1',
  'ATP-dependent DNA helicase',
  1669123,
  1670538,
  -1,
  'FSC454_RS08255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548922.1',
  'mechanosensitive ion channel domain-containingprotein',
  1670538,
  1671035,
  -1,
  'FSC454_RS08260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045323.1',
  'hypothetical protein',
  1671028,
  1671726,
  -1,
  'FSC454_RS08265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045321.1',
  'MIP/aquaporin family protein',
  1671730,
  1672494,
  -1,
  'FSC454_RS08270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045319.1',
  'DUF5655 domain-containing protein',
  1672506,
  1673417,
  -1,
  'FSC454_RS08275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548926.1',
  'glycerol-3-phosphate dehydrogenase/oxidase',
  1673429,
  1674961,
  -1,
  'FSC454_RS08280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glpK',
  'glycerol kinase GlpK',
  1675093,
  1676592,
  -1,
  'FSC454_RS08285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045340.1',
  'MFS transporter',
  1676639,
  1677862,
  -1,
  'FSC454_RS08290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045315.1',
  'hypothetical protein',
  1678021,
  1678629,
  -1,
  'FSC454_RS08295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045313.1',
  'tetratricopeptide repeat protein',
  1678762,
  1679424,
  -1,
  'FSC454_RS08300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045311.1',
  'MFS transporter',
  1679560,
  1680762,
  1,
  'FSC454_RS08305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045309.1',
  'ABC transporter ATP-binding protein',
  1680766,
  1681740,
  -1,
  'FSC454_RS08310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045338.1',
  'ABC transporter ATP-binding protein',
  1681741,
  1682709,
  -1,
  'FSC454_RS08315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548935.1',
  'ABC transporter permease',
  1682713,
  1683573,
  -1,
  'FSC454_RS08320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548936.1',
  'ABC transporter permease',
  1683573,
  1684511,
  -1,
  'FSC454_RS08325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045307.1',
  'peptide ABC transporter substrate-bindingprotein',
  1684536,
  1686212,
  -1,
  'FSC454_RS08330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045305.1',
  'UvrD-helicase domain-containing protein',
  1686298,
  1688520,
  -1,
  'FSC454_RS08335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ftsY',
  'signal recognition particle-docking proteinFtsY',
  1688611,
  1689606,
  -1,
  'FSC454_RS08340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045302.1',
  'LysM peptidoglycan-binding domain-containingprotein',
  1689639,
  1690955,
  -1,
  'FSC454_RS08345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'peptide chain release factor 3',
  1691030,
  1692609,
  -1,
  'FSC454_RS08350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tmk',
  'dTMP kinase',
  1692671,
  1693300,
  -1,
  'FSC454_RS08355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'NupC/NupG family nucleoside CNT transporter',
  1693313,
  1694515,
  -1,
  'FSC454_RS08360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045299.1',
  'NupC/NupG family nucleoside CNT transporter',
  1694534,
  1695733,
  -1,
  'FSC454_RS08365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'deoC',
  'deoxyribose-phosphate aldolase',
  1695723,
  1696484,
  -1,
  'FSC454_RS08370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045295.1',
  'phosphopentomutase',
  1696447,
  1697691,
  -1,
  'FSC454_RS08375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045293.1',
  'type III pantothenate kinase',
  1697685,
  1698470,
  -1,
  'FSC454_RS08380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'polA',
  'DNA polymerase I',
  1698491,
  1701184,
  -1,
  'FSC454_RS08385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lpxK',
  'tetraacyldisaccharide 4''-kinase',
  1701280,
  1702248,
  -1,
  'FSC454_RS08390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'msbA',
  'lipid A export permease/ATP-binding proteinMsbA',
  1702254,
  1704083,
  -1,
  'FSC454_RS08395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045286.1',
  'CCA tRNA nucleotidyltransferase',
  1704188,
  1705294,
  1,
  'FSC454_RS08400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045284.1',
  'disulfide bond formation protein B',
  1705332,
  1705826,
  1,
  'FSC454_RS08405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548953.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1705839,
  1707212,
  1,
  'FSC454_RS08410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045282.1',
  'efflux RND transporter permease subunit',
  1707212,
  1710325,
  1,
  'FSC454_RS08415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'MFS transporter',
  1710457,
  1711738,
  1,
  'FSC454_RS08420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045280.1',
  'ATP-grasp domain-containing protein',
  1712172,
  1713452,
  -1,
  'FSC454_RS08425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045278.1',
  'hypothetical protein',
  1713456,
  1714415,
  -1,
  'FSC454_RS08430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548958.1',
  'sensor histidine kinase',
  1714529,
  1715956,
  1,
  'FSC454_RS08435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548959.1',
  'TIGR01777 family oxidoreductase',
  1715953,
  1716834,
  -1,
  'FSC454_RS08440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_231865141.1',
  'cytochrome ubiquinol oxidase subunit I',
  1717121,
  1718437,
  1,
  'FSC454_RS08445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548961.1',
  'cytochrome d ubiquinol oxidase subunit II',
  1718441,
  1719403,
  1,
  'FSC454_RS08450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247504.1',
  'DUF3429 domain-containing protein',
  1719414,
  1719860,
  1,
  'FSC454_RS08455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794827.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1719857,
  1720840,
  1,
  'FSC454_RS08460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045275.1',
  'type IV pilus twitching motility protein PilT',
  1720925,
  1721953,
  -1,
  'FSC454_RS08465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'acnA',
  'aconitate hydratase AcnA',
  1722048,
  1724861,
  -1,
  'FSC454_RS08470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045271.1',
  'Dyp-type peroxidase',
  1724966,
  1725844,
  -1,
  'FSC454_RS08475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045269.1',
  'GtrA family protein',
  1725914,
  1726291,
  1,
  'FSC454_RS08480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemW',
  'radical SAM family heme chaperone HemW',
  1726293,
  1727435,
  1,
  'FSC454_RS08485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045265.1',
  'PepSY domain-containing protein',
  1727432,
  1727884,
  -1,
  'FSC454_RS08490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045262.1',
  'LysR family transcriptional regulator',
  1727975,
  1728928,
  -1,
  'FSC454_RS08495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1729004,
  1729089,
  -1,
  'FSC454_RS08500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'secG',
  'preprotein translocase subunit SecG',
  1729098,
  1729451,
  -1,
  'FSC454_RS08505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tpiA',
  'triose-phosphate isomerase',
  1729439,
  1730200,
  -1,
  'FSC454_RS08510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'glmM',
  'phosphoglucosamine mutase',
  1730203,
  1731534,
  -1,
  'FSC454_RS08515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548972.1',
  'adenine phosphoribosyltransferase',
  1731545,
  1732072,
  -1,
  'FSC454_RS08520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'odhB',
  '2-oxoglutarate dehydrogenase complexdihydrolipoyllysine-residue succinyltransferase',
  1732112,
  1733581,
  -1,
  'FSC454_RS08525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045253.1',
  '2-oxoglutarate dehydrogenase E1 component',
  1733608,
  1736421,
  -1,
  'FSC454_RS08530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003035125.1',
  'succinate dehydrogenase iron-sulfur subunit',
  1736451,
  1737152,
  -1,
  'FSC454_RS08535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sdhA',
  'succinate dehydrogenase flavoprotein subunit',
  1737170,
  1738963,
  -1,
  'FSC454_RS08540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sdhD',
  'succinate dehydrogenase, hydrophobic membraneanchor protein',
  1738976,
  1739344,
  -1,
  'FSC454_RS08545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'sdhC',
  'succinate dehydrogenase, cytochrome b556subunit',
  1739320,
  1739700,
  -1,
  'FSC454_RS08550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045251.1',
  'citrate synthase',
  1740048,
  1741307,
  1,
  'FSC454_RS08555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548979.1',
  'AmpG family muropeptide MFS transporter',
  1741395,
  1742660,
  1,
  'FSC454_RS08560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_167359450.1',
  'hypothetical protein',
  1742672,
  1742860,
  -1,
  'FSC454_RS09820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045249.1',
  'superoxide dismutase',
  1742872,
  1743450,
  -1,
  'FSC454_RS08570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'grxD',
  'Grx4 family monothiol glutaredoxin',
  1743587,
  1743916,
  1,
  'FSC454_RS08575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045247.1',
  'glycosyl hydrolase family 18 protein',
  1743928,
  1746765,
  -1,
  'FSC454_RS08580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045244.1',
  'hypothetical protein',
  1746970,
  1748499,
  -1,
  'FSC454_RS08585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810690.1',
  'hypothetical protein',
  1748549,
  1749631,
  -1,
  'FSC454_RS08590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS701 family transposase',
  1749905,
  1750938,
  1,
  'FSC454_RS09575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045240.1',
  'hypothetical protein',
  1751133,
  1752245,
  1,
  'FSC454_RS08600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045239.1',
  'ETX/MTX2 family pore-forming toxin',
  1752552,
  1754216,
  1,
  'FSC454_RS08605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045237.1',
  'lactonase family protein',
  1754228,
  1755319,
  1,
  'FSC454_RS08610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045235.1',
  'arsenate reductase/protein-tyrosine-phosphatasefamily protein',
  1755316,
  1755912,
  1,
  'FSC454_RS08615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045233.1',
  'hypothetical protein',
  1756172,
  1757320,
  1,
  'FSC454_RS08620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794829.1',
  'hypothetical protein',
  1757746,
  1758933,
  1,
  'FSC454_RS08625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046118.1',
  'phytanoyl-CoA dioxygenase family protein',
  1759043,
  1760152,
  1,
  'FSC454_RS08630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794830.1',
  'ATP-grasp domain-containing protein',
  1760356,
  1761549,
  1,
  'FSC454_RS08635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046109.1',
  'F0F1 ATP synthase subunit epsilon',
  1761679,
  1762116,
  -1,
  'FSC454_RS08640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'atpD',
  'F0F1 ATP synthase subunit beta',
  1762129,
  1763505,
  -1,
  'FSC454_RS08645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548991.1',
  'F0F1 ATP synthase subunit gamma',
  1763515,
  1764411,
  -1,
  'FSC454_RS08650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'atpA',
  'F0F1 ATP synthase subunit alpha',
  1764426,
  1765967,
  -1,
  'FSC454_RS08655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046106.1',
  'F0F1 ATP synthase subunit delta',
  1765986,
  1766510,
  -1,
  'FSC454_RS08660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014548994.1',
  'F0F1 ATP synthase subunit B',
  1766530,
  1767000,
  -1,
  'FSC454_RS08665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003019757.1',
  'F0F1 ATP synthase subunit B',
  1767045,
  1767350,
  -1,
  'FSC454_RS08670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'atpB',
  'F0F1 ATP synthase subunit A',
  1767401,
  1768192,
  -1,
  'FSC454_RS08675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_082810696.1',
  'ATP synthase subunit I',
  1768257,
  1768628,
  -1,
  'FSC454_RS08680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_044247513.1',
  'MFS transporter',
  1768766,
  1770070,
  1,
  'FSC454_RS08685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046104.1',
  'RluA family pseudouridine synthase',
  1770079,
  1771002,
  -1,
  'FSC454_RS08690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'zapE',
  'cell division protein ZapE',
  1770995,
  1772062,
  -1,
  'FSC454_RS08695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549002.1',
  'MFS transporter',
  1772065,
  1773363,
  -1,
  'FSC454_RS08700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hisS',
  'histidine--tRNA ligase',
  1773370,
  1774635,
  -1,
  'FSC454_RS08705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rbfA',
  '30S ribosome-binding factor RbfA',
  1774643,
  1775074,
  -1,
  'FSC454_RS08710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'infB',
  'translation initiation factor IF-2',
  1775077,
  1777614,
  -1,
  'FSC454_RS08715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nusA',
  'transcription termination factor NusA',
  1777653,
  1779122,
  -1,
  'FSC454_RS08720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rimP',
  'ribosome maturation factor RimP',
  1779140,
  1779592,
  -1,
  'FSC454_RS08725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1779668,
  1779744,
  -1,
  'FSC454_RS08730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'hemE',
  'uroporphyrinogen decarboxylase',
  1779815,
  1780849,
  -1,
  'FSC454_RS08735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046091.1',
  'YifB family Mg chelatase-like AAA ATPase',
  1780904,
  1782412,
  -1,
  'FSC454_RS08740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046088.1',
  'accessory factor UbiK family protein',
  1782414,
  1782608,
  -1,
  'FSC454_RS08745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046085.1',
  'NADH-quinone oxidoreductase subunit N',
  1782688,
  1784139,
  -1,
  'FSC454_RS08750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046080.1',
  'complex I subunit 4 family protein',
  1784155,
  1785744,
  -1,
  'FSC454_RS08755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nuoL',
  'NADH-quinone oxidoreductase subunit L',
  1785770,
  1787779,
  -1,
  'FSC454_RS08760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nuoK',
  'NADH-quinone oxidoreductase subunit NuoK',
  1787789,
  1788121,
  -1,
  'FSC454_RS08765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549015.1',
  'NADH-quinone oxidoreductase subunit J',
  1788099,
  1788704,
  -1,
  'FSC454_RS08770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nuoI',
  'NADH-quinone oxidoreductase subunit NuoI',
  1788709,
  1789197,
  -1,
  'FSC454_RS08775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nuoH',
  'NADH-quinone oxidoreductase subunit NuoH',
  1789211,
  1790221,
  -1,
  'FSC454_RS08780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nuoG',
  'NADH-quinone oxidoreductase subunit NuoG',
  1790223,
  1792589,
  -1,
  'FSC454_RS08785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nuoF',
  'NADH-quinone oxidoreductase subunit NuoF',
  1792607,
  1793881,
  -1,
  'FSC454_RS08790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549019.1',
  'NADH-quinone oxidoreductase subunit NuoE familyprotein',
  1793888,
  1794376,
  -1,
  'FSC454_RS08795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549020.1',
  'NADH-quinone oxidoreductase subunit D',
  1794386,
  1795639,
  -1,
  'FSC454_RS08800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046071.1',
  'NADH-quinone oxidoreductase subunit C',
  1795661,
  1796305,
  -1,
  'FSC454_RS08805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_003017394.1',
  'NuoB/complex I 20 kDa subunit family protein',
  1796308,
  1796784,
  -1,
  'FSC454_RS08810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ndhC',
  'NADH-quinone oxidoreductase subunit A',
  1796775,
  1797173,
  -1,
  'FSC454_RS08815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046067.1',
  'DUF3573 domain-containing protein',
  1797404,
  1798972,
  1,
  'FSC454_RS08820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549023.1',
  'Fur family transcriptional regulator',
  1799057,
  1799479,
  1,
  'FSC454_RS08825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fslA',
  'rhizoferrin biosynthesis protein FslA',
  1799707,
  1801626,
  1,
  'FSC454_RS08830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fslB',
  'rhizoferrin export MFS transporter FslB',
  1801633,
  1802895,
  1,
  'FSC454_RS08835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fslC',
  'rhizoferrin biosystnesis N-citrylornithinedecarboxylase FslC',
  1802888,
  1804138,
  1,
  'FSC454_RS08840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fslD',
  'rhizoferrin import MFS transporter FslD',
  1804155,
  1805345,
  1,
  'FSC454_RS08845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fslE',
  'rhizoferrin import outer membrane protein FslE',
  1805431,
  1806957,
  1,
  'FSC454_RS08850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fslF',
  'protein FslF',
  1807005,
  1808497,
  1,
  'FSC454_RS08855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549030.1',
  'hypothetical protein',
  1808513,
  1808920,
  -1,
  'FSC454_RS08860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gatB',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatB',
  1808935,
  1810356,
  -1,
  'FSC454_RS08865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gatA',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatA',
  1810359,
  1811804,
  -1,
  'FSC454_RS08870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'gatC',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatC',
  1811813,
  1812094,
  -1,
  'FSC454_RS08875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046043.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1812177,
  1813247,
  -1,
  'FSC454_RS08880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046040.1',
  'ATP-binding cassette domain-containing protein',
  1813258,
  1814799,
  -1,
  'FSC454_RS08885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purB',
  'adenylosuccinate lyase',
  1814953,
  1816251,
  -1,
  'FSC454_RS08890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046034.1',
  'hypothetical protein',
  1816565,
  1817200,
  1,
  'FSC454_RS08895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046031.1',
  'hypothetical protein',
  1817211,
  1817984,
  1,
  'FSC454_RS08900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046028.1',
  'aldose 1-epimerase family protein',
  1818004,
  1818864,
  -1,
  'FSC454_RS08905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156860532.1',
  'hypothetical protein',
  1819185,
  1819364,
  -1,
  'FSC454_RS09715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794746.1',
  'IS630 family transposase',
  1819464,
  1820276,
  1,
  'FSC454_RS08915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purL',
  'phosphoribosylformylglycinamidine synthase',
  1820460,
  1824332,
  -1,
  'FSC454_RS08920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purF',
  'amidophosphoribosyltransferase',
  1824332,
  1825822,
  -1,
  'FSC454_RS08925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'pyridoxal-dependent decarboxylase',
  1825915,
  1826813,
  -1,
  'FSC454_RS08930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044925.1',
  '4''-phosphopantetheinyl transferase familyprotein',
  1826824,
  1827465,
  -1,
  'FSC454_RS08935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'tolC',
  'outer membrane channel protein TolC',
  1827474,
  1829003,
  -1,
  'FSC454_RS08940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044927.1',
  'protein-L-isoaspartate O-methyltransferasefamily protein',
  1829012,
  1829632,
  -1,
  'FSC454_RS08945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trhP',
  'prephenate-dependent tRNA uridine(34)hydroxylase TrhP',
  1829944,
  1831275,
  1,
  'FSC454_RS08950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549052.1',
  'multidrug effflux MFS transporter',
  1831317,
  1832498,
  -1,
  'FSC454_RS08955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nhaD',
  'sodium:proton antiporter NhaD',
  1832672,
  1834099,
  1,
  'FSC454_RS08960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044929.1',
  'ABC transporter ATP-binding protein/permease',
  1834089,
  1835759,
  -1,
  'FSC454_RS08965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044930.1',
  'APC family permease',
  1835763,
  1837637,
  -1,
  'FSC454_RS08970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'cgtA',
  'Obg family GTPase CgtA',
  1837644,
  1838648,
  -1,
  'FSC454_RS08975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044932.1',
  'amino acid permease',
  1838724,
  1839920,
  -1,
  'FSC454_RS08980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044934.1',
  'DUF6314 family protein',
  1840048,
  1840491,
  1,
  'FSC454_RS08985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS08985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_052298578.1',
  'outer membrane protein',
  1840514,
  1840933,
  -1,
  'FSC454_RS10210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044936.1',
  'response regulator transcription factor',
  1841224,
  1841910,
  -1,
  'FSC454_RS09000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044938.1',
  'ATP-binding protein',
  1841952,
  1844633,
  -1,
  'FSC454_RS09005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044940.1',
  'potassium-transporting ATPase subunit C',
  1844738,
  1845292,
  -1,
  'FSC454_RS09010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'kdpB',
  'potassium-transporting ATPase subunit KdpB',
  1845309,
  1847348,
  -1,
  'FSC454_RS09015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'kdpA',
  'potassium-transporting ATPase subunit KdpA',
  1847358,
  1849079,
  -1,
  'FSC454_RS09020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044943.1',
  'hypothetical protein',
  1849353,
  1849544,
  -1,
  'FSC454_RS09025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044945.1',
  'hypothetical protein',
  1849554,
  1849799,
  -1,
  'FSC454_RS09030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rrf',
  '—',
  1850005,
  1850119,
  -1,
  'FSC454_RS09035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1850167,
  1853051,
  -1,
  'FSC454_RS09040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1853104,
  1853179,
  -1,
  'FSC454_RS09045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1853194,
  1853270,
  -1,
  'FSC454_RS09050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1853367,
  1854894,
  -1,
  'FSC454_RS09055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794832.1',
  'pyridoxal phosphate-dependent aminotransferase',
  1855262,
  1856443,
  -1,
  'FSC454_RS09060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046601.1',
  'PLP-dependent decarboxylase',
  1856460,
  1857671,
  -1,
  'FSC454_RS09065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046603.1',
  '2,3,4,5-tetrahydropyridine-2,6-dicarboxylateN-succinyltransferase',
  1857676,
  1858425,
  -1,
  'FSC454_RS09070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'dapA',
  '4-hydroxy-tetrahydrodipicolinate synthase',
  1858450,
  1859337,
  -1,
  'FSC454_RS09075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046606.1',
  '4-hydroxy-tetrahydrodipicolinate reductase',
  1859328,
  1859999,
  -1,
  'FSC454_RS09080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'lysC',
  'lysine-sensitive aspartokinase 3',
  1860011,
  1861366,
  -1,
  'FSC454_RS09085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pip',
  'prolyl aminopeptidase',
  1861804,
  1862742,
  -1,
  'FSC454_RS09090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046612.1',
  'TatD family hydrolase',
  1862818,
  1863564,
  -1,
  'FSC454_RS09095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1863565,
  1864122,
  -1,
  'FSC454_RS09100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046618.1',
  'DUF3568 domain-containing protein',
  1864472,
  1864864,
  1,
  'FSC454_RS09105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046621.1',
  'DUF3568 domain-containing protein',
  1864885,
  1865295,
  1,
  'FSC454_RS09110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'DUF3568 family protein',
  1865298,
  1865687,
  1,
  'FSC454_RS09115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'clcA',
  'H(+)/Cl(-) exchange transporter ClcA',
  1865795,
  1867189,
  1,
  'FSC454_RS09120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046628.1',
  'carboxypeptidase M32',
  1867125,
  1868627,
  1,
  'FSC454_RS09125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046630.1',
  'aspartoacylase',
  1868637,
  1869506,
  -1,
  'FSC454_RS09130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trpB',
  'tryptophan synthase subunit beta',
  1869655,
  1870845,
  1,
  'FSC454_RS09135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trpA',
  'tryptophan synthase subunit alpha',
  1870845,
  1871657,
  1,
  'FSC454_RS09140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046636.1',
  'hypothetical protein',
  1871654,
  1871899,
  1,
  'FSC454_RS09145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046638.1',
  'LVIVD repeat-containing protein',
  1871915,
  1872730,
  1,
  'FSC454_RS09150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549085.1',
  'hypothetical protein',
  1872806,
  1873159,
  -1,
  'FSC454_RS09155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1873248,
  1873958,
  -1,
  'FSC454_RS09160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'clpB',
  'ATP-dependent chaperone ClpB',
  1874175,
  1876754,
  1,
  'FSC454_RS09165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046643.1',
  'glycosyl hydrolase family 18 protein',
  1876935,
  1879127,
  1,
  'FSC454_RS09170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'purT',
  'formate-dependent phosphoribosylglycinamideformyltransferase',
  1879181,
  1880341,
  1,
  'FSC454_RS09175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046647.1',
  'class I SAM-dependent methyltransferase',
  1880343,
  1880999,
  -1,
  'FSC454_RS09180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046649.1',
  'Frag1/DRAM/Sfk1 family protein',
  1881080,
  1881721,
  -1,
  'FSC454_RS09185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'fdxA',
  'ferredoxin FdxA',
  1881950,
  1882273,
  1,
  'FSC454_RS09190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549092.1',
  'lysophospholipid acyltransferase family protein',
  1882436,
  1883188,
  1,
  'FSC454_RS09195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046651.1',
  'lysophospholipid acyltransferase family protein',
  1883202,
  1883942,
  1,
  'FSC454_RS09200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046653.1',
  'endonuclease/exonuclease/phosphatase familyprotein',
  1883951,
  1884670,
  -1,
  'FSC454_RS09205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'nhaA',
  'Na+/H+ antiporter NhaA',
  1884735,
  1885883,
  -1,
  'FSC454_RS09210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046658.1',
  'Rieske 2Fe-2S domain-containing protein',
  1885976,
  1886872,
  1,
  'FSC454_RS09215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156470911.1',
  'cytochrome b',
  1886936,
  1887445,
  1,
  'FSC454_RS09220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046662.1',
  'MFS transporter',
  1887474,
  1888733,
  1,
  'FSC454_RS09225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'bcp',
  'thioredoxin-dependent thiol peroxidase',
  1889057,
  1889536,
  1,
  'FSC454_RS09230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046667.1',
  '2-hydroxyacid dehydrogenase',
  1889612,
  1890595,
  -1,
  'FSC454_RS09235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046669.1',
  'DUF1826 domain-containing protein',
  1890839,
  1891462,
  1,
  'FSC454_RS09240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046672.1',
  'hypothetical protein',
  1891530,
  1891922,
  -1,
  'FSC454_RS09245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046675.1',
  'zinc-binding dehydrogenase',
  1892020,
  1893009,
  1,
  'FSC454_RS09250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046677.1',
  'IS5 family transposase',
  1893056,
  1893799,
  -1,
  'FSC454_RS09255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046679.1',
  'class I SAM-dependent methyltransferase',
  1893850,
  1894572,
  -1,
  'FSC454_RS09260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'ettA',
  'energy-dependent translational throttle proteinEttA',
  1894620,
  1896299,
  -1,
  'FSC454_RS09265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046682.1',
  'MFS transporter',
  1896512,
  1897753,
  1,
  'FSC454_RS09270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046685.1',
  'hypothetical protein',
  1898054,
  1898266,
  -1,
  'FSC454_RS09280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'MBL fold metallo-hydrolase',
  1898378,
  1899282,
  1,
  'FSC454_RS09285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046435.1',
  'GRP family sugar transporter',
  1899291,
  1900295,
  -1,
  'FSC454_RS09290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'rbsK',
  'ribokinase',
  1900312,
  1901232,
  -1,
  'FSC454_RS09295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046437.1',
  'hypothetical protein',
  1901369,
  1901755,
  1,
  'FSC454_RS09300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046438.1',
  'sulfite exporter TauE/SafE family protein',
  1901906,
  1902685,
  1,
  'FSC454_RS09305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'aminopeptidase N C-terminal domain-containingprotein',
  1902719,
  1903522,
  -1,
  'FSC454_RS09310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_083576966.1',
  'IS630 transposase-related protein',
  1903815,
  1904093,
  1,
  'FSC454_RS09315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_244148270.1',
  'IS630 family transposase',
  1904117,
  1904626,
  1,
  'FSC454_RS09320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  'IS5/IS1182 family transposase',
  1904644,
  1904786,
  1,
  'FSC454_RS10050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS10050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044801.1',
  'hypothetical protein',
  1905659,
  1905988,
  1,
  'FSC454_RS09330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066044799.1',
  'IS982 family transposase',
  1906132,
  1907001,
  -1,
  'FSC454_RS09335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_156860534.1',
  'hypothetical protein',
  1907327,
  1908457,
  -1,
  'FSC454_RS09340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045481.1',
  'hypothetical protein',
  1908904,
  1909218,
  1,
  'FSC454_RS09345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'pepN',
  'aminopeptidase N',
  1909585,
  1912160,
  -1,
  'FSC454_RS09350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046021.1',
  'Hsp20/alpha crystallin family protein',
  1912360,
  1912788,
  1,
  'FSC454_RS09355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trpCF',
  'bifunctional indole-3-glycerol-phosphatesynthase TrpC/phosphoribosylanthranilate isomerase TrpF',
  1912785,
  1914146,
  -1,
  'FSC454_RS09360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046015.1',
  'GyrI-like domain-containing protein',
  1914239,
  1914652,
  -1,
  'FSC454_RS09365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'msrA',
  'peptide-methionine (S)-S-oxide reductase MsrA',
  1914657,
  1915346,
  -1,
  'FSC454_RS09370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046005.1',
  'nitrile hydratase subunit alpha',
  1915431,
  1915799,
  -1,
  'FSC454_RS09375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046003.1',
  'NHLP leader peptide family RiPP precursor',
  1915792,
  1916133,
  -1,
  'FSC454_RS09380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066046001.1',
  'hypothetical protein',
  1916201,
  1916602,
  -1,
  'FSC454_RS09385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trpD',
  'anthranilate phosphoribosyltransferase',
  1916675,
  1917695,
  -1,
  'FSC454_RS09390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_066045995.1',
  'aminodeoxychorismate/anthranilate synthasecomponent II',
  1917692,
  1918270,
  -1,
  'FSC454_RS09395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_071794834.1',
  'anthranilate synthase component 1',
  1918274,
  1919818,
  -1,
  'FSC454_RS09400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'trpR',
  'trp operon repressor',
  1919819,
  1920115,
  -1,
  'FSC454_RS09405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1920403,
  1920479,
  -1,
  'FSC454_RS09410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  '—',
  '—',
  1920484,
  1920559,
  -1,
  'FSC454_RS09415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  'WP_014549127.1',
  'Rne/Rng family ribonuclease',
  1920622,
  1922118,
  -1,
  'FSC454_RS09420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1) AND locus_tag='FSC454_RS09420'
);

INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '1224',
  'phylum',
  'Pseudomonadota',
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='1224'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'phylum'),
  name = COALESCE(NULLIF(name,''), 'Pseudomonadota'),
  parent_id = COALESCE(parent_id, NULL)
WHERE taxonomy_id='1224';

INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '1236',
  'class',
  'Gammaproteobacteria',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='1224' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='1236'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'class'),
  name = COALESCE(NULLIF(name,''), 'Gammaproteobacteria'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='1224' LIMIT 1))
WHERE taxonomy_id='1236';

INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '72273',
  'order',
  'Thiotrichales',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='1236' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='72273'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'order'),
  name = COALESCE(NULLIF(name,''), 'Thiotrichales'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='1236' LIMIT 1))
WHERE taxonomy_id='72273';

INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '34064',
  'family',
  'Francisellaceae',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='72273' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='34064'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'family'),
  name = COALESCE(NULLIF(name,''), 'Francisellaceae'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='72273' LIMIT 1))
WHERE taxonomy_id='34064';

INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '262',
  'genus',
  'Francisella',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='34064' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='262'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'genus'),
  name = COALESCE(NULLIF(name,''), 'Francisella'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='34064' LIMIT 1))
WHERE taxonomy_id='262';

INSERT INTO core_taxonomy (taxonomy_id, rank, name, parent_id)
SELECT
  '622488',
  'species',
  'Francisella hispaniensis',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='262' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='622488'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'species'),
  name = COALESCE(NULLIF(name,''), 'Francisella hispaniensis'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='262' LIMIT 1))
WHERE taxonomy_id='622488';

UPDATE core_genome
SET taxonomy_id = (
  SELECT id FROM core_taxonomy WHERE taxonomy_id='622488' LIMIT 1
)
WHERE genome_accession='NZ_CP018093.1';

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'EMSA', 'EMSA', NULL, 'ECO:0001807'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0001807'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'Site directed mutagenesis', 'Site directed mutagenesis', NULL, 'ECO:0005667'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005667'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'Motif-discovery', 'Motif-discovery', NULL, 'ECO:0005558'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005558'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'RNA-Seq', 'RNA-Seq', NULL, 'ECO:0005664'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005664'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'qRT-PCR [RNA]', 'qRT-PCR [RNA]', NULL, 'ECO:0001808'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0001808'
);

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'GTGCAGTTTTATTACAC',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1),
  627952,
  627968,
  -1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
    AND start=627952 AND end=627968 AND strand=-1
    AND _seq='GTGCAGTTTTATTACAC'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1),
   'GTGCAGTTTTATTACAC',
   0,
   'motif_associated',
   'ACT',
   'MONOMER');

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001807'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001807'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001807'
          LIMIT 1)
  );

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005667'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005667'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005667'
          LIMIT 1)
  );

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005558'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005558'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005558'
          LIMIT 1)
  );

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005664'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005664'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005664'
          LIMIT 1)
  );

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001808'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001808'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001808'
          LIMIT 1)
  );

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='FSC454_RS03120' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='FSC454_RS03120' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
          AND start=627952 AND end=627968 AND strand=-1
          AND _seq='GTGCAGTTTTATTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='FSC454_RS03125' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='FSC454_RS03125' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP018093.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

COMMIT;