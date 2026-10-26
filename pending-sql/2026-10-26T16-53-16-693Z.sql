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
  1,
  1,
  NULL,
  1,
  'LexA',
  'Francisella salimarina'
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
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN 'Francisella salimarina' ELSE reported_species END,
  contains_promoter_data = 1,
  contains_expression_data = 1,
  curation_complete = 1,
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
  ('Francisella salimarina', 'Francisella salimarina', NULL,
   0, NULL, '',
   datetime('now'), (SELECT curator_id FROM core_curator ORDER BY curator_id LIMIT 1), (SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1), datetime('now'), NULL);

INSERT INTO core_curation_TF_instances (curation_id, tfinstance_id)
SELECT (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1), (SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='A0AAC9J5Y6' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_curation_TF_instances
  WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1) AND tfinstance_id=(SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='A0AAC9J5Y6' LIMIT 1)
);

INSERT INTO core_genome (genome_accession, organism, gi)
SELECT
  'NZ_CP076680.1',
  'Francisella salimarina',
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM core_genome WHERE genome_accession='NZ_CP076680.1'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaA',
  'chromosomal replication initiator protein DnaA',
  1,
  1476,
  1,
  'KQR59_RS00005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaN',
  'DNA polymerase III subunit beta',
  1514,
  2617,
  1,
  'KQR59_RS00010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692169.1',
  'glycosyltransferase family protein',
  2619,
  3767,
  -1,
  'KQR59_RS00015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692170.1',
  'APC family permease',
  3925,
  5454,
  1,
  'KQR59_RS00020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_042524605.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  5606,
  6361,
  1,
  'KQR59_RS00025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692171.1',
  'hypothetical protein',
  6452,
  6757,
  -1,
  'KQR59_RS00030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463363.1',
  'DMT family transporter',
  6846,
  7718,
  -1,
  'KQR59_RS00035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368987.1',
  'hypothetical protein',
  7868,
  8056,
  1,
  'KQR59_RS00040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421553.1',
  'hypothetical protein',
  8053,
  8235,
  -1,
  'KQR59_RS00045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ssrA',
  '—',
  8314,
  8734,
  -1,
  'KQR59_RS00050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421554.1',
  'aromatic amino acid transport family protein',
  8793,
  10016,
  -1,
  'KQR59_RS00055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pyrB',
  'aspartate carbamoyltransferase',
  10164,
  11090,
  -1,
  'KQR59_RS00060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'carB',
  'carbamoyl-phosphate synthase large subunit',
  11245,
  14529,
  -1,
  'KQR59_RS00065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'carA',
  'glutamine-hydrolyzing carbamoyl-phosphatesynthase small subunit',
  14534,
  15700,
  -1,
  'KQR59_RS00070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921814.1',
  'hypothetical protein',
  16041,
  16163,
  -1,
  'KQR59_RS09535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692174.1',
  'histidine phosphatase family protein',
  16384,
  17442,
  1,
  'KQR59_RS00075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692175.1',
  'thiopurine S-methyltransferase',
  17450,
  18121,
  -1,
  'KQR59_RS00080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692176.1',
  'dihydroorotase',
  18255,
  19601,
  1,
  'KQR59_RS00085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692177.1',
  'macro domain-containing protein',
  19783,
  20439,
  1,
  'KQR59_RS00090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692178.1',
  'TIR domain-containing protein',
  20429,
  20944,
  1,
  'KQR59_RS00095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uilS',
  'UilS family quorum-quenching N-acyl-homoserinelactonase',
  21013,
  21885,
  -1,
  'KQR59_RS00100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692180.1',
  'DUF1415 domain-containing protein',
  22036,
  22581,
  1,
  'KQR59_RS00105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692181.1',
  'FUSC family protein',
  22624,
  23676,
  -1,
  'KQR59_RS00110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368995.1',
  'HlyD family secretion protein',
  23663,
  24628,
  -1,
  'KQR59_RS00115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692182.1',
  'DUF3568 family protein',
  24704,
  25111,
  -1,
  'KQR59_RS00120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692183.1',
  'LysR family transcriptional regulator',
  25232,
  26101,
  1,
  'KQR59_RS00125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692184.1',
  'SOUL family heme-binding protein',
  26110,
  26733,
  -1,
  'KQR59_RS00130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692185.1',
  'chorismate mutase',
  26873,
  27415,
  1,
  'KQR59_RS00135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692186.1',
  'transglutaminase family protein',
  27454,
  30828,
  -1,
  'KQR59_RS00140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pyrF',
  'orotidine-5''-phosphate decarboxylase',
  31122,
  31754,
  1,
  'KQR59_RS00145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692188.1',
  'HisA/HisF-related TIM barrel protein',
  31756,
  32496,
  1,
  'KQR59_RS00150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572843.1',
  'DUF6790 family protein',
  32500,
  32973,
  1,
  'KQR59_RS00155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tyrA',
  'bifunctional chorismate mutase/prephenatedehydrogenase',
  32964,
  33803,
  -1,
  'KQR59_RS00160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692190.1',
  'hypothetical protein',
  33831,
  34661,
  -1,
  'KQR59_RS00165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dtd',
  'D-aminoacyl-tRNA deacylase',
  34663,
  35100,
  -1,
  'KQR59_RS00170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692192.1',
  'glycosyltransferase family 39 protein',
  35193,
  36608,
  1,
  'KQR59_RS00175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692193.1',
  'MFS transporter',
  36583,
  37818,
  -1,
  'KQR59_RS00180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692194.1',
  'glycoside hydrolase family 32 protein',
  37838,
  39553,
  -1,
  'KQR59_RS00185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_088820636.1',
  'peptide MFS transporter',
  39702,
  41138,
  1,
  'KQR59_RS00190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'leuB',
  '3-isopropylmalate dehydrogenase',
  41152,
  42231,
  -1,
  'KQR59_RS00195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'leuD',
  '3-isopropylmalate dehydratase small subunit',
  42233,
  42802,
  -1,
  'KQR59_RS00200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'leuC',
  '3-isopropylmalate dehydratase large subunit',
  42805,
  44214,
  -1,
  'KQR59_RS00205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692197.1',
  'hydroxymethylglutaryl-CoA lyase-like TIM-barrelprotein',
  44216,
  45796,
  -1,
  'KQR59_RS00210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692198.1',
  'branched-chain amino acid transaminase',
  45808,
  46695,
  -1,
  'KQR59_RS00215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ppdK',
  'pyruvate, phosphate dikinase',
  47089,
  49722,
  -1,
  'KQR59_RS00220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_425513938.1',
  'DUF3573 domain-containing protein',
  49882,
  50136,
  1,
  'KQR59_RS09590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692201.1',
  'NAD-dependent epimerase/dehydratase familyprotein',
  50048,
  50944,
  -1,
  'KQR59_RS00230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692202.1',
  'class I SAM-dependent methyltransferase',
  50981,
  52207,
  -1,
  'KQR59_RS00235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692203.1',
  'dTDP-4-dehydrorhamnose 3,5-epimerase familyprotein',
  52204,
  52767,
  -1,
  'KQR59_RS00240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rfbG',
  'CDP-glucose 4,6-dehydratase',
  52764,
  53819,
  -1,
  'KQR59_RS00245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rfbF',
  'glucose-1-phosphate cytidylyltransferase',
  53819,
  54589,
  -1,
  'KQR59_RS00250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369016.1',
  'rhamnosyltransferase WsaF familyglycosyltransferase',
  54602,
  59062,
  -1,
  'KQR59_RS00255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692205.1',
  'class I SAM-dependent methyltransferase',
  59087,
  61255,
  -1,
  'KQR59_RS00260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692206.1',
  'ABC transporter ATP-binding protein',
  61258,
  62622,
  -1,
  'KQR59_RS00265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692207.1',
  'ABC transporter permease',
  62612,
  63361,
  -1,
  'KQR59_RS00270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'orn',
  'oligoribonuclease',
  63617,
  64153,
  -1,
  'KQR59_RS00275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'efp',
  'elongation factor P',
  64158,
  64727,
  -1,
  'KQR59_RS00280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921846.1',
  'type IV pilin protein',
  64758,
  65174,
  -1,
  'KQR59_RS00285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692209.1',
  'lysophospholipid acyltransferase family protein',
  65187,
  66110,
  -1,
  'KQR59_RS00290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369022.1',
  'lysophospholipid acyltransferase family protein',
  66171,
  67070,
  -1,
  'KQR59_RS00295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yidC',
  'membrane protein insertase YidC',
  67072,
  68727,
  -1,
  'KQR59_RS00300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yidD',
  'membrane protein insertion efficiency factorYidD',
  68724,
  69008,
  -1,
  'KQR59_RS00305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rnpA',
  'ribonuclease P protein component',
  68960,
  69313,
  -1,
  'KQR59_RS00310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmH',
  '50S ribosomal protein L34',
  69303,
  69437,
  -1,
  'KQR59_RS00315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692213.1',
  'hypothetical protein',
  69529,
  69981,
  -1,
  'KQR59_RS00320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465358.1',
  'shikimate dehydrogenase family protein',
  70105,
  70881,
  1,
  'KQR59_RS00325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murC',
  'UDP-N-acetylmuramate--L-alanine ligase',
  70951,
  72309,
  1,
  'KQR59_RS00330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsmI',
  '16S rRNA(cytidine(1402)-2''-O)-methyltransferase',
  72302,
  73171,
  1,
  'KQR59_RS00335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692216.1',
  'hypothetical protein',
  73180,
  73956,
  -1,
  'KQR59_RS00340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421602.1',
  'YqeG family HAD IIIA-type phosphatase',
  74034,
  74603,
  1,
  'KQR59_RS00345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572845.1',
  'RCC1 domain-containing protein',
  74668,
  75426,
  1,
  'KQR59_RS00350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692217.1',
  'DUF3427 domain-containing protein',
  75433,
  78171,
  1,
  'KQR59_RS00355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421605.1',
  'universal stress protein',
  78246,
  79082,
  1,
  'KQR59_RS00360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692218.1',
  'MFS transporter',
  79210,
  80439,
  1,
  'KQR59_RS00365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692219.1',
  '5-oxoprolinase subunit B family protein',
  80471,
  81088,
  1,
  'KQR59_RS00370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692220.1',
  '5-oxoprolinase subunit PxpA',
  81088,
  81786,
  1,
  'KQR59_RS00375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692221.1',
  '5-oxoprolinase subunit C family protein',
  81791,
  82609,
  1,
  'KQR59_RS00380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692222.1',
  'phosphoethanolamine transferase',
  82690,
  84339,
  1,
  'KQR59_RS00385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692223.1',
  'diacylglycerol kinase',
  84345,
  84710,
  1,
  'KQR59_RS00390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921870.1',
  'hypothetical protein',
  84962,
  85618,
  1,
  'KQR59_RS00395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369039.1',
  'inorganic phosphate transporter',
  85637,
  86632,
  1,
  'KQR59_RS00400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692224.1',
  'cytochrome b',
  86715,
  87227,
  1,
  'KQR59_RS00405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149377278.1',
  'LysR family transcriptional regulator',
  87231,
  88178,
  -1,
  'KQR59_RS00410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421615.1',
  'nitroreductase',
  88243,
  88908,
  -1,
  'KQR59_RS00415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421616.1',
  'YoaK family protein',
  89288,
  89980,
  1,
  'KQR59_RS00420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692225.1',
  'amino acid permease',
  89977,
  91182,
  -1,
  'KQR59_RS00425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsmG',
  '16S rRNA (guanine(527)-N(7))-methyltransferaseRsmG',
  91281,
  91895,
  1,
  'KQR59_RS00430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692227.1',
  'YggS family pyridoxal phosphate-dependentenzyme',
  91895,
  92563,
  1,
  'KQR59_RS00435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692228.1',
  'FUSC family protein',
  92560,
  93573,
  -1,
  'KQR59_RS00440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_187986024.1',
  'LysR family transcriptional regulator',
  93648,
  94544,
  -1,
  'KQR59_RS00445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692229.1',
  'MFS transporter',
  94649,
  95821,
  1,
  'KQR59_RS00450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463420.1',
  'D-sedoheptulose-7-phosphate isomerase',
  95901,
  96497,
  1,
  'KQR59_RS00455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921884.1',
  'outer membrane protein assembly factor BamE',
  96502,
  96861,
  1,
  'KQR59_RS00460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692230.1',
  'DUF6056 family protein',
  96874,
  98190,
  1,
  'KQR59_RS00465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_343213197.1',
  'hypothetical protein',
  98192,
  98557,
  -1,
  'KQR59_RS00470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsT',
  '30S ribosomal protein S20',
  98633,
  98905,
  -1,
  'KQR59_RS00475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lepA',
  'translation elongation factor 4',
  99173,
  100957,
  1,
  'KQR59_RS00480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mnmA',
  'tRNA 2-thiouridine(34) synthase MnmA',
  101072,
  102151,
  1,
  'KQR59_RS00485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692232.1',
  'FTN_0109 family protein',
  102173,
  103111,
  -1,
  'KQR59_RS00490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'def',
  'peptide deformylase',
  103207,
  103725,
  -1,
  'KQR59_RS00495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ribH',
  '6,7-dimethyl-8-ribityllumazine synthase',
  103729,
  104172,
  -1,
  'KQR59_RS00500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ribB',
  '3,4-dihydroxy-2-butanone-4-phosphate synthase',
  104176,
  105387,
  -1,
  'KQR59_RS00505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369055.1',
  'riboflavin synthase',
  105380,
  105985,
  -1,
  'KQR59_RS00510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ribD',
  'bifunctionaldiaminohydroxyphosphoribosylaminopyrimidinedeaminase/5-amino-6-(5-phosphoribosylamino)uracilreductase RibD',
  105978,
  107048,
  -1,
  'KQR59_RS00515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369057.1',
  'cation:proton antiporter',
  107417,
  108685,
  1,
  'KQR59_RS00520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692234.1',
  'cation:proton antiporter',
  108802,
  110052,
  1,
  'KQR59_RS00525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692235.1',
  'alpha-keto acid decarboxylase family protein',
  110061,
  111758,
  -1,
  'KQR59_RS00530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465562.1',
  '(2Fe-2S) ferredoxin domain-containing protein',
  111929,
  112285,
  -1,
  'KQR59_RS00535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692236.1',
  'S49 family peptidase',
  112373,
  113296,
  1,
  'KQR59_RS00540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921898.1',
  'OmpH family outer membrane protein',
  113388,
  113927,
  1,
  'KQR59_RS00545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369061.1',
  'rhodanese-like domain-containing protein',
  114078,
  114500,
  1,
  'KQR59_RS00550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secB',
  'protein-export chaperone SecB',
  114520,
  114969,
  1,
  'KQR59_RS00555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recA',
  'recombinase RecA',
  114996,
  116069,
  1,
  'KQR59_RS00560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921902.1',
  'regulatory protein RecX',
  116056,
  116511,
  1,
  'KQR59_RS00565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692237.1',
  'single-stranded DNA-binding protein',
  116588,
  117076,
  1,
  'KQR59_RS00570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692238.1',
  'acetate/propionate family kinase',
  117177,
  118331,
  1,
  'KQR59_RS00575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pta',
  'phosphate acetyltransferase',
  118341,
  120437,
  1,
  'KQR59_RS00580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692240.1',
  'NAD-dependent succinate-semialdehydedehydrogenase',
  120453,
  121886,
  1,
  'KQR59_RS00585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692241.1',
  'homocysteine S-methyltransferase family protein',
  122133,
  123194,
  1,
  'KQR59_RS00590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692242.1',
  'trans-sulfuration enzyme family protein',
  123326,
  124540,
  1,
  'KQR59_RS00595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692243.1',
  'peptide MFS transporter',
  124509,
  125972,
  1,
  'KQR59_RS00600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369071.1',
  'carbon-nitrogen hydrolase family protein',
  125981,
  127501,
  -1,
  'KQR59_RS00605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aspS',
  'aspartate--tRNA ligase',
  127734,
  129506,
  1,
  'KQR59_RS00610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692245.1',
  'glycosyltransferase family 32 protein',
  129589,
  130386,
  -1,
  'KQR59_RS00615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692246.1',
  'ribonuclease catalytic domain-containingprotein',
  130444,
  132318,
  1,
  'KQR59_RS00620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692247.1',
  'alpha/beta hydrolase',
  132650,
  133318,
  1,
  'KQR59_RS00625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemC',
  'hydroxymethylbilane synthase',
  133315,
  134217,
  1,
  'KQR59_RS00630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'crcB',
  'fluoride efflux transporter CrcB',
  134221,
  134613,
  1,
  'KQR59_RS00635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692249.1',
  'hypothetical protein',
  134610,
  135023,
  1,
  'KQR59_RS00640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692250.1',
  'YMGG-like glycine zipper-containing protein',
  135239,
  135415,
  1,
  'KQR59_RS00645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692251.1',
  'hypothetical protein',
  135502,
  136155,
  1,
  'KQR59_RS00650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921922.1',
  'zinc-finger domain-containing protein',
  136156,
  136323,
  -1,
  'KQR59_RS00655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369079.1',
  'ABC transporter permease',
  136452,
  138257,
  1,
  'KQR59_RS00660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921924.1',
  'ABC transporter ATP-binding protein',
  138278,
  139597,
  1,
  'KQR59_RS00665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692252.1',
  'DUF3573 domain-containing protein',
  139709,
  141217,
  1,
  'KQR59_RS00670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692253.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  141324,
  142049,
  1,
  'KQR59_RS00675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692254.1',
  'amidohydrolase family protein',
  142055,
  142873,
  1,
  'KQR59_RS00680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692255.1',
  'VUT family protein',
  142860,
  143549,
  -1,
  'KQR59_RS00685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692256.1',
  'cation:proton antiporter',
  143729,
  145621,
  1,
  'KQR59_RS00690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692257.1',
  'gamma carbonic anhydrase family protein',
  145606,
  146145,
  1,
  'KQR59_RS00695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lolB',
  'lipoprotein insertase outer membrane proteinLolB',
  146096,
  146740,
  1,
  'KQR59_RS00700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ispE',
  '4-(cytidine5''-diphospho)-2-C-methyl-D-erythritol kinase',
  146728,
  147555,
  1,
  'KQR59_RS00705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  147575,
  147649,
  1,
  'KQR59_RS00710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692259.1',
  'M14 family metallopeptidase',
  147799,
  148713,
  1,
  'KQR59_RS00715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004286706.1',
  'YggT family protein',
  148727,
  149296,
  1,
  'KQR59_RS00720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004286705.1',
  'ABC transporter ATP-binding protein',
  149290,
  150072,
  -1,
  'KQR59_RS00725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692260.1',
  'ABC transporter permease subunit',
  150101,
  151825,
  -1,
  'KQR59_RS00730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692261.1',
  'ComEC/Rec2 family competence protein',
  152571,
  154586,
  1,
  'KQR59_RS00735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263573.1',
  '1-acylglycerol-3-phosphate O-acyltransferase,YihG family',
  154680,
  155573,
  1,
  'KQR59_RS00740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421668.1',
  'intracellular proliferation membrane proteinRipA',
  155758,
  156294,
  -1,
  'KQR59_RS00745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369091.1',
  'L-threonylcarbamoyladenylate synthase',
  156387,
  156929,
  -1,
  'KQR59_RS00750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsA',
  '30S ribosomal protein S1',
  157054,
  158724,
  -1,
  'KQR59_RS00755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tadA',
  'tRNA adenosine(34) deaminase TadA',
  158874,
  159335,
  1,
  'KQR59_RS00760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369093.1',
  'D-alanine--D-alanine ligase',
  159342,
  160235,
  1,
  'KQR59_RS00765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369094.1',
  'cell division protein FtsQ/DivIB',
  160229,
  160912,
  1,
  'KQR59_RS00770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ftsA',
  'cell division protein FtsA',
  161014,
  162276,
  1,
  'KQR59_RS00775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ftsZ',
  'cell division protein FtsZ',
  162315,
  163451,
  1,
  'KQR59_RS00780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxC',
  'UDP-3-O-acyl-N-acetylglucosamine deacetylase',
  163666,
  164523,
  1,
  'KQR59_RS00785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692262.1',
  'acid phosphatase',
  164631,
  165380,
  1,
  'KQR59_RS00790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaX',
  'DNA polymerase III subunit gamma/tau',
  165385,
  167237,
  -1,
  'KQR59_RS00795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'prfB',
  'peptide chain release factor 2',
  167396,
  168485,
  1,
  'KQR59_RS00800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lysS',
  'lysine--tRNA ligase',
  168595,
  170277,
  1,
  'KQR59_RS00805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692265.1',
  'nuclear transport factor 2 family protein',
  170281,
  170673,
  1,
  'KQR59_RS00810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921953.1',
  'TIGR00645 family protein',
  170697,
  171239,
  -1,
  'KQR59_RS00815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glsA',
  'glutaminase A',
  171386,
  172930,
  -1,
  'KQR59_RS00820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369099.1',
  'glutamine synthetase beta-graspdomain-containing protein',
  173007,
  174044,
  -1,
  'KQR59_RS00825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'holA',
  'DNA polymerase III subunit delta',
  174156,
  175133,
  -1,
  'KQR59_RS00830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921957.1',
  'lipocalin family protein',
  175218,
  175736,
  1,
  'KQR59_RS00835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692267.1',
  'aromatic amino acid transport family protein',
  175837,
  177105,
  1,
  'KQR59_RS00840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purH',
  'bifunctionalphosphoribosylaminoimidazolecarboxamideformyltransferase/IMP cyclohydrolase',
  177173,
  178720,
  -1,
  'KQR59_RS00845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369103.1',
  'adenylosuccinate synthase',
  178898,
  180184,
  1,
  'KQR59_RS00850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hpt',
  'hypoxanthine phosphoribosyltransferase',
  180187,
  180729,
  1,
  'KQR59_RS00855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692269.1',
  'dienelactone hydrolase family protein',
  181052,
  181774,
  -1,
  'KQR59_RS00860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369106.1',
  'metal ABC transporter permease',
  181861,
  182724,
  -1,
  'KQR59_RS00865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369107.1',
  'metal ABC transporter ATP-binding protein',
  182645,
  183322,
  -1,
  'KQR59_RS00870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692270.1',
  'metal ABC transporter solute-binding protein,Zn/Mn family',
  183324,
  184244,
  -1,
  'KQR59_RS00875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692271.1',
  'MFS transporter',
  184317,
  185540,
  -1,
  'KQR59_RS00880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013921967.1',
  'hypothetical protein',
  185677,
  186138,
  -1,
  'KQR59_RS00885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'wrbA',
  'NAD(P)H:quinone oxidoreductase',
  186150,
  186740,
  -1,
  'KQR59_RS00890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465694.1',
  'YihY family inner membrane protein',
  186753,
  187949,
  1,
  'KQR59_RS00895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  187969,
  188541,
  1,
  'KQR59_RS00900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'priA',
  'replication restart helicase PriA',
  188541,
  190697,
  1,
  'KQR59_RS00905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692274.1',
  'transporter substrate-binding domain-containingprotein',
  190710,
  191456,
  -1,
  'KQR59_RS00910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_030003323.1',
  'hypothetical protein',
  191539,
  191628,
  -1,
  'KQR59_RS00915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cydB',
  'cytochrome d ubiquinol oxidase subunit II',
  191641,
  192837,
  -1,
  'KQR59_RS00920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692275.1',
  'cytochrome ubiquinol oxidase subunit I',
  192848,
  194602,
  -1,
  'KQR59_RS00925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxD',
  'UDP-3-O-(3-hydroxymyristoyl)glucosamineN-acyltransferase',
  194990,
  196033,
  -1,
  'KQR59_RS00930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692276.1',
  'radical SAM protein',
  196108,
  196803,
  -1,
  'KQR59_RS00935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pdxY',
  'pyridoxal kinase',
  196803,
  197654,
  -1,
  'KQR59_RS00940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692277.1',
  'DUF3568 family protein',
  197658,
  198089,
  -1,
  'KQR59_RS00945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692278.1',
  'AAA family ATPase',
  198235,
  199191,
  1,
  'KQR59_RS00950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692279.1',
  'DUF58 domain-containing protein',
  199204,
  200115,
  1,
  'KQR59_RS00955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692280.1',
  'DUF4381 domain-containing protein',
  200105,
  200581,
  1,
  'KQR59_RS00960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692281.1',
  'vWA domain-containing protein',
  200578,
  201579,
  1,
  'KQR59_RS00965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692282.1',
  'vWA domain-containing protein',
  201581,
  202579,
  1,
  'KQR59_RS00970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692283.1',
  'tetratricopeptide repeat protein',
  202570,
  203373,
  1,
  'KQR59_RS00975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692284.1',
  'BatD family protein',
  203363,
  204985,
  1,
  'KQR59_RS00980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692285.1',
  'transporter suffix domain-containing protein',
  204995,
  205477,
  1,
  'KQR59_RS00985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692286.1',
  'hypothetical protein',
  205508,
  205948,
  1,
  'KQR59_RS00990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280060.1',
  'DNA polymerase III subunit chi',
  206045,
  206482,
  1,
  'KQR59_RS00995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS00995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692287.1',
  'valine--tRNA ligase',
  206623,
  209382,
  1,
  'KQR59_RS01000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692288.1',
  'phosphoenolpyruvate carboxylase',
  209430,
  211964,
  -1,
  'KQR59_RS01005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280054.1',
  'hypothetical protein',
  212191,
  212523,
  1,
  'KQR59_RS01010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692289.1',
  'DUF4336 domain-containing protein',
  212528,
  213220,
  1,
  'KQR59_RS01015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004286641.1',
  'NUDIX hydrolase',
  213225,
  213611,
  1,
  'KQR59_RS01020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'proB',
  'glutamate 5-kinase',
  213733,
  214863,
  1,
  'KQR59_RS01025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692291.1',
  'glutamate-5-semialdehyde dehydrogenase',
  214864,
  216114,
  1,
  'KQR59_RS01030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692292.1',
  'alpha-hydroxy acid oxidase',
  216117,
  217265,
  -1,
  'KQR59_RS01035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nfsB',
  'oxygen-insensitive NAD(P)H nitroreductase',
  217324,
  217977,
  -1,
  'KQR59_RS01040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421713.1',
  'hypothetical protein',
  218076,
  218768,
  -1,
  'KQR59_RS01045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fumC',
  'class II fumarate hydratase',
  218923,
  220314,
  1,
  'KQR59_RS01050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gltX',
  'glutamate--tRNA ligase',
  220423,
  221832,
  1,
  'KQR59_RS01055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  221926,
  222001,
  1,
  'KQR59_RS01060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'epsC',
  'serine O-acetyltransferase EpsC',
  222077,
  222595,
  -1,
  'KQR59_RS01065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cysK',
  'cysteine synthase A',
  222711,
  223646,
  1,
  'KQR59_RS01070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692297.1',
  'dihydrofolate reductase',
  223643,
  224140,
  -1,
  'KQR59_RS01075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsB',
  '30S ribosomal protein S2',
  224376,
  225095,
  1,
  'KQR59_RS01080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tsf',
  'translation elongation factor Ts',
  225117,
  225986,
  1,
  'KQR59_RS01085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pyrH',
  'UMP kinase',
  225990,
  226739,
  1,
  'KQR59_RS01090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'frr',
  'ribosome recycling factor',
  226765,
  227322,
  1,
  'KQR59_RS01095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uppS',
  'polyprenyl diphosphate synthase',
  227408,
  228145,
  1,
  'KQR59_RS01100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692300.1',
  'phosphatidate cytidylyltransferase',
  228142,
  228936,
  1,
  'KQR59_RS01105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dut',
  'dUTP diphosphatase',
  228947,
  229393,
  1,
  'KQR59_RS01110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pgsA',
  'CDP-diacylglycerol--glycerol-3-phosphate3-phosphatidyltransferase',
  229397,
  229993,
  1,
  'KQR59_RS01115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsL',
  '30S ribosomal protein S12',
  230127,
  230501,
  1,
  'KQR59_RS01120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsG',
  '30S ribosomal protein S7',
  230540,
  231013,
  1,
  'KQR59_RS01125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fusA',
  'elongation factor G',
  231028,
  233145,
  1,
  'KQR59_RS01130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsJ',
  '30S ribosomal protein S10',
  233164,
  233481,
  1,
  'KQR59_RS01135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplC',
  '50S ribosomal protein L3',
  233585,
  234217,
  1,
  'KQR59_RS01140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplD',
  '50S ribosomal protein L4',
  234250,
  234873,
  1,
  'KQR59_RS01145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplW',
  '50S ribosomal protein L23',
  234870,
  235169,
  1,
  'KQR59_RS01150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplB',
  '50S ribosomal protein L2',
  235190,
  236014,
  1,
  'KQR59_RS01155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsS',
  '30S ribosomal protein S19',
  236029,
  236307,
  1,
  'KQR59_RS01160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplV',
  '50S ribosomal protein L22',
  236322,
  236657,
  1,
  'KQR59_RS01165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsC',
  '30S ribosomal protein S3',
  236672,
  237340,
  1,
  'KQR59_RS01170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplP',
  '50S ribosomal protein L16',
  237340,
  237753,
  1,
  'KQR59_RS01175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmC',
  '50S ribosomal protein L29',
  237753,
  237953,
  1,
  'KQR59_RS01180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsQ',
  '30S ribosomal protein S17',
  237965,
  238216,
  1,
  'KQR59_RS01185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplN',
  '50S ribosomal protein L14',
  238307,
  238675,
  1,
  'KQR59_RS01190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplX',
  '50S ribosomal protein L24',
  238699,
  239016,
  1,
  'KQR59_RS01195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplE',
  '50S ribosomal protein L5',
  239029,
  239568,
  1,
  'KQR59_RS01200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsN',
  '30S ribosomal protein S14',
  239587,
  239892,
  1,
  'KQR59_RS01205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsH',
  '30S ribosomal protein S8',
  239908,
  240306,
  1,
  'KQR59_RS01210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplF',
  '50S ribosomal protein L6',
  240326,
  240862,
  1,
  'KQR59_RS01215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplR',
  '50S ribosomal protein L18',
  240885,
  241238,
  1,
  'KQR59_RS01220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsE',
  '30S ribosomal protein S5',
  241266,
  241766,
  1,
  'KQR59_RS01225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmD',
  '50S ribosomal protein L30',
  241773,
  241958,
  1,
  'KQR59_RS01230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplO',
  '50S ribosomal protein L15',
  241965,
  242396,
  1,
  'KQR59_RS01235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secY',
  'preprotein translocase subunit SecY',
  242407,
  243732,
  1,
  'KQR59_RS01240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmJ',
  '50S ribosomal protein L36',
  243757,
  243870,
  1,
  'KQR59_RS01245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsM',
  '30S ribosomal protein S13',
  243986,
  244342,
  1,
  'KQR59_RS01250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsK',
  '30S ribosomal protein S11',
  244381,
  244770,
  1,
  'KQR59_RS01255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsD',
  '30S ribosomal protein S4',
  244792,
  245412,
  1,
  'KQR59_RS01260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421730.1',
  'DNA-directed RNA polymerase subunit alpha',
  245470,
  246441,
  1,
  'KQR59_RS01265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplQ',
  '50S ribosomal protein L17',
  246486,
  246923,
  1,
  'KQR59_RS01270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421731.1',
  'ion transporter',
  247045,
  247725,
  1,
  'KQR59_RS01275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'htpG',
  'molecular chaperone HtpG',
  247843,
  249729,
  1,
  'KQR59_RS01280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'argF',
  'ornithine carbamoyltransferase',
  249785,
  250693,
  -1,
  'KQR59_RS01285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'argB',
  'acetylglutamate kinase',
  250690,
  251496,
  -1,
  'KQR59_RS01290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'argJ',
  'bifunctional glutamateN-acetyltransferase/amino-acid acetyltransferase ArgJ',
  251493,
  252683,
  -1,
  'KQR59_RS01295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'argC',
  'N-acetyl-gamma-glutamyl-phosphate reductase',
  252698,
  253765,
  -1,
  'KQR59_RS01300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rocD',
  'ornithine--oxo-acid transaminase',
  253868,
  255052,
  1,
  'KQR59_RS01305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922047.1',
  'arginine repressor',
  255041,
  255496,
  -1,
  'KQR59_RS01310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'argH',
  'argininosuccinate lyase',
  255619,
  256812,
  -1,
  'KQR59_RS01315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692306.1',
  'argininosuccinate synthase',
  256817,
  258073,
  -1,
  'KQR59_RS01320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yfcC',
  'putative basic amino acid antiporter YfcC',
  258183,
  259694,
  -1,
  'KQR59_RS01325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pyrG',
  'CTP synthase',
  259854,
  261494,
  1,
  'KQR59_RS01330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ndk',
  'nucleoside-diphosphate kinase',
  261566,
  261988,
  1,
  'KQR59_RS01335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'accD',
  'acetyl-CoA carboxylase, carboxyltransferasesubunit beta',
  262028,
  262930,
  1,
  'KQR59_RS01340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692308.1',
  'bifunctional folylpolyglutamatesynthase/dihydrofolate synthase',
  262944,
  264128,
  1,
  'KQR59_RS01345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tsaE',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexATPase subunit type 1 TsaE',
  264103,
  264513,
  1,
  'KQR59_RS01350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369159.1',
  'tetratricopeptide repeat protein',
  264597,
  265799,
  1,
  'KQR59_RS01355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murJ',
  'murein biosynthesis integral membrane proteinMurJ',
  265830,
  267374,
  1,
  'KQR59_RS01360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gshA',
  'glutamate--cysteine ligase',
  267417,
  268922,
  1,
  'KQR59_RS01365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmE',
  '50S ribosomal protein L31',
  269020,
  269235,
  -1,
  'KQR59_RS01370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464919.1',
  'ferredoxin--NADP reductase',
  269355,
  270083,
  -1,
  'KQR59_RS01375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369162.1',
  'hypothetical protein',
  270270,
  270665,
  1,
  'KQR59_RS01380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692312.1',
  'YybH family protein',
  270674,
  271123,
  1,
  'KQR59_RS01385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421753.1',
  'SPFH domain-containing protein',
  271151,
  272041,
  1,
  'KQR59_RS01390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_263478288.1',
  'hypothetical protein',
  272148,
  272276,
  1,
  'KQR59_RS09540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692313.1',
  'hypothetical protein',
  272304,
  273536,
  1,
  'KQR59_RS01395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369165.1',
  'LysR family transcriptional regulator',
  273559,
  274410,
  -1,
  'KQR59_RS01400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_088820812.1',
  'carboxymuconolactone decarboxylase familyprotein',
  274518,
  275162,
  1,
  'KQR59_RS01405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692314.1',
  'multidrug effflux MFS transporter',
  275188,
  276381,
  1,
  'KQR59_RS01410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  276426,
  276502,
  -1,
  'KQR59_RS01415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463562.1',
  'ProQ/FINO family protein',
  276678,
  277376,
  1,
  'KQR59_RS01420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263885.1',
  'FTL_1709 family lipoprotein',
  277482,
  277961,
  1,
  'KQR59_RS01425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149377251.1',
  'potassium transporter TrkG',
  277964,
  279418,
  -1,
  'KQR59_RS01430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692315.1',
  'CBU_0585 family protein',
  279532,
  279732,
  1,
  'KQR59_RS01435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692316.1',
  'DUF6056 family protein',
  279858,
  281174,
  1,
  'KQR59_RS01440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692317.1',
  'hypothetical protein',
  281196,
  281453,
  1,
  'KQR59_RS01445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lolA',
  'outer membrane lipoprotein periplasmic chaperoneLolA',
  281459,
  282076,
  -1,
  'KQR59_RS01450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692318.1',
  'DNA translocase FtsK',
  282077,
  284539,
  -1,
  'KQR59_RS01455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxF',
  'lipid A 4''-phosphatase LpxF',
  284661,
  285335,
  1,
  'KQR59_RS01460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692320.1',
  'amino acid permease',
  285580,
  287034,
  1,
  'KQR59_RS01465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463568.1',
  'alpha/beta hydrolase',
  287045,
  287683,
  1,
  'KQR59_RS01470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glpX',
  'class II fructose-bisphosphatase',
  287705,
  288691,
  1,
  'KQR59_RS01475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'putP',
  'sodium/proline symporter PutP',
  288834,
  290300,
  1,
  'KQR59_RS01480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421764.1',
  'glycosyltransferase family 2 protein',
  290365,
  292044,
  1,
  'KQR59_RS01485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421765.1',
  'hemolysin family protein',
  292055,
  293338,
  1,
  'KQR59_RS01490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692322.1',
  'type II secretion system protein',
  293428,
  293778,
  1,
  'KQR59_RS01495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692323.1',
  'PilW family protein',
  293762,
  294670,
  1,
  'KQR59_RS01500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692324.1',
  'hypothetical protein',
  294667,
  296073,
  1,
  'KQR59_RS01505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572857.1',
  'hypothetical protein',
  296074,
  296706,
  1,
  'KQR59_RS01510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149369179.1',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein',
  296790,
  297515,
  1,
  'KQR59_RS09465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692325.1',
  'type IV pilus modification PilV family protein',
  297527,
  298447,
  1,
  'KQR59_RS01525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692326.1',
  'hypothetical protein',
  298457,
  300535,
  1,
  'KQR59_RS01530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cysS',
  'cysteine--tRNA ligase',
  300613,
  301992,
  1,
  'KQR59_RS01535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'prmB',
  '50S ribosomal protein L3 N(5)-glutaminemethyltransferase',
  301996,
  302940,
  1,
  'KQR59_RS01540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692329.1',
  'MFS transporter',
  302996,
  304186,
  1,
  'KQR59_RS01545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692330.1',
  'GNAT family N-acetyltransferase',
  304198,
  304689,
  1,
  'KQR59_RS01550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692331.1',
  'chitinase',
  304697,
  306550,
  -1,
  'KQR59_RS01555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'alr',
  'alanine racemase',
  306848,
  307903,
  -1,
  'KQR59_RS01560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692333.1',
  'APC family permease',
  307919,
  309283,
  1,
  'KQR59_RS01565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  'DUF4282 domain-containing protein',
  309285,
  309573,
  -1,
  'KQR59_RS01570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421778.1',
  'hypothetical protein',
  309602,
  310306,
  -1,
  'KQR59_RS01575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367812.1',
  'APC family permease',
  310410,
  311912,
  -1,
  'KQR59_RS01580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692334.1',
  'hypothetical protein',
  312300,
  313043,
  -1,
  'KQR59_RS01585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ubiG',
  'bifunctional 2-polyprenyl-6-hydroxyphenolmethylase/3-demethylubiquinol 3-O-methyltransferase UbiG',
  313046,
  313741,
  -1,
  'KQR59_RS01590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692336.1',
  'MlaA family lipoprotein',
  313888,
  314988,
  1,
  'KQR59_RS01595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692337.1',
  'agmatine deiminase family protein',
  314999,
  315979,
  -1,
  'KQR59_RS01600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922127.1',
  'BolA/IbaG family iron-sulfur metabolism protein',
  316069,
  316305,
  -1,
  'KQR59_RS01605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692338.1',
  'STAS domain-containing protein',
  316323,
  316616,
  -1,
  'KQR59_RS01610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692339.1',
  'MlaC/ttg2D family ABC transportersubstrate-binding protein',
  316613,
  317278,
  -1,
  'KQR59_RS01615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mlaD',
  'outer membrane lipid asymmetry maintenanceprotein MlaD',
  317355,
  317885,
  -1,
  'KQR59_RS01620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922131.1',
  'MlaE family lipid ABC transporter permeasesubunit',
  317885,
  318649,
  -1,
  'KQR59_RS01625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692340.1',
  'ABC transporter ATP-binding protein',
  318653,
  319447,
  -1,
  'KQR59_RS01630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'minE',
  'cell division topological specificity factorMinE',
  319462,
  319734,
  -1,
  'KQR59_RS01635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'minD',
  'septum site-determining protein MinD',
  319737,
  320561,
  -1,
  'KQR59_RS01640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'minC',
  'septum site-determining protein MinC',
  320592,
  321278,
  -1,
  'KQR59_RS01645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmG',
  '50S ribosomal protein L33',
  321314,
  321469,
  -1,
  'KQR59_RS01650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmB',
  '50S ribosomal protein L28',
  321500,
  321736,
  -1,
  'KQR59_RS01655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lptM',
  'LPS translocon maturation chaperone LptM',
  321873,
  322199,
  -1,
  'KQR59_RS01660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692342.1',
  'ATP-dependent DNA helicase RecG',
  322332,
  324371,
  1,
  'KQR59_RS01665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692343.1',
  'hypothetical protein',
  324377,
  324571,
  1,
  'KQR59_RS01670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464954.1',
  'fumarate hydratase',
  324696,
  326210,
  1,
  'KQR59_RS01675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_035735044.1',
  'hypothetical protein',
  326438,
  326686,
  1,
  'KQR59_RS01680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692344.1',
  'VOC family protein',
  326726,
  327112,
  -1,
  'KQR59_RS01685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692345.1',
  'NUDIX hydrolase N-terminal domain-containingprotein',
  327225,
  327830,
  1,
  'KQR59_RS01690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572859.1',
  'MarC family protein',
  327895,
  328536,
  1,
  'KQR59_RS01695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922145.1',
  'arsenate reductase family protein',
  328555,
  328908,
  1,
  'KQR59_RS01700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922146.1',
  'hypothetical protein',
  328932,
  329267,
  -1,
  'KQR59_RS01705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692346.1',
  'NCS2 family permease',
  329423,
  330736,
  -1,
  'KQR59_RS01710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692347.1',
  'bifunctional aspartate transaminase/aspartate4-decarboxylase',
  330808,
  332388,
  -1,
  'KQR59_RS01715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aspT',
  'aspartate-alanine antiporter',
  332401,
  334116,
  -1,
  'KQR59_RS01720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dprA',
  'DNA-processing protein DprA',
  334190,
  335290,
  -1,
  'KQR59_RS01725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692349.1',
  'OmpA family protein',
  335290,
  336546,
  -1,
  'KQR59_RS01730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fkpB',
  'FKBP-type peptidyl-prolyl cis-trans isomerase',
  336729,
  337193,
  1,
  'KQR59_RS01735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ispH',
  '4-hydroxy-3-methylbut-2-enyl diphosphatereductase',
  337174,
  338130,
  1,
  'KQR59_RS01740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aroH',
  'chorismate mutase',
  338141,
  338503,
  1,
  'KQR59_RS01745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922155.1',
  'CDP-alcohol phosphatidyltransferase familyprotein',
  338517,
  339356,
  1,
  'KQR59_RS01750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421801.1',
  'hypothetical protein',
  339361,
  339585,
  -1,
  'KQR59_RS01755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tolQ',
  'protein TolQ',
  339740,
  340447,
  1,
  'KQR59_RS01760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tolR',
  'protein TolR',
  340463,
  340903,
  1,
  'KQR59_RS01765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tolA',
  'cell envelope integrity protein TolA',
  340890,
  341807,
  1,
  'KQR59_RS01770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_187985992.1',
  'beta-propeller domain-containing protein',
  341819,
  343123,
  1,
  'KQR59_RS01775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922161.1',
  'hypothetical protein',
  343133,
  343378,
  1,
  'KQR59_RS01780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922162.1',
  'OmpA family protein',
  343394,
  344023,
  1,
  'KQR59_RS01785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rimO',
  '30S ribosomal protein S12 methylthiotransferaseRimO',
  344126,
  345445,
  1,
  'KQR59_RS01790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692355.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  345547,
  346269,
  1,
  'KQR59_RS01795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692356.1',
  'TIGR03643 family protein',
  346292,
  346522,
  1,
  'KQR59_RS01800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692357.1',
  'FAD-binding domain-containing protein',
  346503,
  348002,
  1,
  'KQR59_RS01805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692358.1',
  'cryptochrome/photolyase family protein',
  348002,
  349531,
  1,
  'KQR59_RS01810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004286486.1',
  'DUF2256 domain-containing protein',
  349528,
  349665,
  1,
  'KQR59_RS01815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_200149258.1',
  'bile acid:sodium symporter family protein',
  349802,
  350722,
  1,
  'KQR59_RS01820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463614.1',
  'helix-turn-helix transcriptional regulator',
  350771,
  351394,
  1,
  'KQR59_RS01825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367842.1',
  'sulfite exporter TauE/SafE family protein',
  351411,
  352169,
  1,
  'KQR59_RS01830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  352213,
  352302,
  1,
  'KQR59_RS01835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421815.1',
  'DUF3574 domain-containing protein',
  352304,
  352717,
  -1,
  'KQR59_RS01840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692359.1',
  'DUF423 domain-containing protein',
  352714,
  353109,
  -1,
  'KQR59_RS01845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692360.1',
  'thiol-disulfide oxidoreductase DCC familyprotein',
  353127,
  353486,
  -1,
  'KQR59_RS01850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ubiA',
  '4-hydroxybenzoate octaprenyltransferase',
  353501,
  354358,
  -1,
  'KQR59_RS01855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463619.1',
  'chorismate--pyruvate lyase family protein',
  354348,
  354863,
  -1,
  'KQR59_RS01860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rph',
  'ribonuclease PH',
  354961,
  355668,
  1,
  'KQR59_RS01865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922178.1',
  'hypothetical protein',
  355703,
  356026,
  -1,
  'KQR59_RS01870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692363.1',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein',
  356143,
  357078,
  -1,
  'KQR59_RS01875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'htpX',
  'zinc metalloprotease HtpX',
  357169,
  358239,
  -1,
  'KQR59_RS01880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692365.1',
  'LemA family protein',
  358241,
  358816,
  -1,
  'KQR59_RS01885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692366.1',
  'LysR substrate-binding domain-containingprotein',
  358898,
  359785,
  -1,
  'KQR59_RS01890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692367.1',
  'FAD-dependent oxidoreductase',
  359921,
  360976,
  1,
  'KQR59_RS01895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692368.1',
  'heavy metal translocating P-type ATPase',
  360978,
  363137,
  -1,
  'KQR59_RS01900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465303.1',
  'ArsR/SmtB family transcription factor',
  363134,
  363499,
  -1,
  'KQR59_RS01905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692369.1',
  'C39 family peptidase',
  363641,
  364291,
  1,
  'KQR59_RS01910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_281417445.1',
  'hypothetical protein',
  364298,
  364429,
  -1,
  'KQR59_RS09545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692370.1',
  'glucosyltransferase domain-containing protein',
  364617,
  366131,
  -1,
  'KQR59_RS01915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692371.1',
  'NAD(P)H-dependent glycerol-3-phosphatedehydrogenase',
  366223,
  367221,
  1,
  'KQR59_RS01920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_044525650.1',
  'CvpA family protein',
  367218,
  367757,
  -1,
  'KQR59_RS01925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'radA',
  'DNA repair protein RadA',
  367761,
  369131,
  -1,
  'KQR59_RS01930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421830.1',
  'PilZ domain-containing protein',
  369140,
  369895,
  -1,
  'KQR59_RS01935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263593.1',
  'DedA family protein',
  369892,
  370491,
  -1,
  'KQR59_RS01940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aroC',
  'chorismate synthase',
  370494,
  371552,
  -1,
  'KQR59_RS01945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421833.1',
  'PQ-loop domain-containing transporter',
  371704,
  372336,
  -1,
  'KQR59_RS01950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692373.1',
  'PQ-loop repeat-containing protein',
  372436,
  373053,
  -1,
  'KQR59_RS01955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'msrB',
  'peptide-methionine (R)-S-oxide reductase MsrB',
  373140,
  373640,
  -1,
  'KQR59_RS01960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692375.1',
  'superoxide dismutase family protein',
  373785,
  374342,
  1,
  'KQR59_RS01965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367866.1',
  'sterol desaturase family protein',
  374346,
  375137,
  1,
  'KQR59_RS01970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692376.1',
  'amino acid permease',
  375112,
  376506,
  -1,
  'KQR59_RS01975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421838.1',
  'phosphomannose isomerase type II C-terminalcupin domain',
  376819,
  377181,
  1,
  'KQR59_RS01980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692377.1',
  'S-(hydroxymethyl)glutathione dehydrogenase/classIII alcohol dehydrogenase',
  377270,
  378382,
  1,
  'KQR59_RS01985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421840.1',
  'pyridoxal phosphate-dependent aminotransferase',
  378588,
  379778,
  -1,
  'KQR59_RS01990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_179951684.1',
  'PepSY domain-containing protein',
  379879,
  380034,
  -1,
  'KQR59_RS01995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS01995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recN',
  'DNA repair protein RecN',
  380162,
  381811,
  1,
  'KQR59_RS02000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692379.1',
  'pilin',
  382279,
  383508,
  -1,
  'KQR59_RS02005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692380.1',
  'pilin',
  383806,
  384252,
  -1,
  'KQR59_RS02010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692381.1',
  'pilin',
  384379,
  384861,
  -1,
  'KQR59_RS02015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxE',
  'lipid A 1-phosphatase LpxE',
  385184,
  385915,
  1,
  'KQR59_RS02020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'folD',
  'bifunctional methylenetetrahydrofolatedehydrogenase/methenyltetrahydrofolate cyclohydrolaseFolD',
  386045,
  386893,
  1,
  'KQR59_RS02025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purM',
  'phosphoribosylformylglycinamidine cyclo-ligase',
  386974,
  388017,
  1,
  'KQR59_RS02030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692384.1',
  'phosphoribosylaminoimidazolesuccinocarboxamidesynthase',
  388017,
  390326,
  1,
  'KQR59_RS02035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purN',
  'phosphoribosylglycinamide formyltransferase',
  390329,
  390913,
  1,
  'KQR59_RS02040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purE',
  '5-(carboxyamino)imidazole ribonucleotide mutase',
  391018,
  391509,
  1,
  'KQR59_RS02045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692386.1',
  '5-(carboxyamino)imidazole ribonucleotidesynthase',
  391511,
  392608,
  1,
  'KQR59_RS02050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692387.1',
  'YraN family protein',
  392605,
  392958,
  -1,
  'KQR59_RS02055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692388.1',
  'M3 family metallopeptidase',
  393051,
  395057,
  -1,
  'KQR59_RS02060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922216.1',
  'Mth938-like domain-containing protein',
  395147,
  395518,
  1,
  'KQR59_RS02065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpnA',
  'outer member lipoprotein TUL4/LpnA',
  395595,
  396035,
  1,
  'KQR59_RS02070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692389.1',
  'hypothetical protein',
  396162,
  396641,
  1,
  'KQR59_RS02075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367883.1',
  'hypothetical protein',
  396740,
  397255,
  1,
  'KQR59_RS02080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpnB',
  'TUL4 family outer member lipoprotein LpnB',
  397276,
  397746,
  1,
  'KQR59_RS02085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572898.1',
  'O-antigen ligase family protein',
  397893,
  399251,
  1,
  'KQR59_RS02090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'topA',
  'type I DNA topoisomerase',
  399387,
  401684,
  -1,
  'KQR59_RS02095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421859.1',
  'AAA family ATPase',
  401883,
  402521,
  1,
  'KQR59_RS02100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692391.1',
  'ParB/RepB/Spo0J family partition protein',
  402521,
  403435,
  1,
  'KQR59_RS02105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922225.1',
  'glutamine amidotransferase-related protein',
  403448,
  404155,
  1,
  'KQR59_RS02110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922226.1',
  'SGNH/GDSL hydrolase family protein',
  404158,
  405039,
  1,
  'KQR59_RS02115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692392.1',
  'AraC family transcriptional regulator',
  405090,
  405884,
  1,
  'KQR59_RS02120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692393.1',
  'MFS transporter',
  405881,
  407080,
  -1,
  'KQR59_RS02125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421864.1',
  'RlmE family RNA methyltransferase',
  407197,
  407817,
  -1,
  'KQR59_RS02130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263596.1',
  'hypothetical protein',
  407972,
  408439,
  1,
  'KQR59_RS02135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lspA',
  'signal peptidase II',
  408434,
  408916,
  -1,
  'KQR59_RS02140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ileS',
  'isoleucine--tRNA ligase',
  408903,
  411710,
  -1,
  'KQR59_RS02145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ribF',
  'bifunctional riboflavin kinase/FAD synthetase',
  411807,
  412727,
  -1,
  'KQR59_RS02150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692880.1',
  'NAD-dependent malic enzyme',
  412877,
  414691,
  1,
  'KQR59_RS02155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_425513939.1',
  'DUF3573 domain-containing protein',
  414837,
  416501,
  1,
  'KQR59_RS02160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922237.1',
  'DUF3573 domain-containing protein',
  416515,
  417945,
  1,
  'KQR59_RS02165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'der',
  'ribosome biogenesis GTPase Der',
  418025,
  419422,
  1,
  'KQR59_RS02170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_191092417.1',
  'UDP-N-acetylglucosamine1-carboxyvinyltransferase',
  419391,
  420695,
  1,
  'KQR59_RS02175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murB',
  'UDP-N-acetylmuramate dehydrogenase',
  420703,
  421551,
  1,
  'KQR59_RS02180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692398.1',
  'hypothetical protein',
  421629,
  422522,
  1,
  'KQR59_RS02185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692399.1',
  'methyltransferase domain-containing protein',
  422533,
  423297,
  -1,
  'KQR59_RS02190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692400.1',
  'ComF family protein',
  423322,
  423975,
  1,
  'KQR59_RS02195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_263478290.1',
  'hypothetical protein',
  424232,
  424363,
  1,
  'KQR59_RS09550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421877.1',
  'histidine triad nucleotide-binding protein',
  424367,
  424705,
  -1,
  'KQR59_RS02200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ubiB',
  'ubiquinone biosynthesis regulatory proteinkinase UbiB',
  424706,
  426361,
  -1,
  'KQR59_RS02205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692402.1',
  'ubiquinone biosynthesis accessory factor UbiJ',
  426354,
  426941,
  -1,
  'KQR59_RS02210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ubiE',
  'bifunctional demethylmenaquinonemethyltransferase/2-methoxy-6-polyprenyl-1,4-benzoquinolmethylase UbiE',
  426943,
  427695,
  -1,
  'KQR59_RS02215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glk',
  'glucokinase',
  427791,
  428813,
  1,
  'KQR59_RS02220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922249.1',
  'hypothetical protein',
  428816,
  429061,
  -1,
  'KQR59_RS02225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421882.1',
  'septation protein A',
  429134,
  429664,
  -1,
  'KQR59_RS02230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692404.1',
  'L-threonylcarbamoyladenylate synthase',
  429724,
  430338,
  1,
  'KQR59_RS02235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692405.1',
  'YigZ family protein',
  430382,
  430984,
  1,
  'KQR59_RS02240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692406.1',
  'MFS transporter',
  430981,
  432201,
  -1,
  'KQR59_RS02245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'metG',
  'methionine--tRNA ligase',
  432217,
  434250,
  -1,
  'KQR59_RS02250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  434426,
  434517,
  1,
  'KQR59_RS02255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  434546,
  434621,
  1,
  'KQR59_RS02260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  435564,
  437097,
  1,
  'KQR59_RS02265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  437194,
  437270,
  1,
  'KQR59_RS02270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  437278,
  437353,
  1,
  'KQR59_RS02275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  437404,
  440290,
  1,
  'KQR59_RS02280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rrf',
  '—',
  440347,
  440461,
  1,
  'KQR59_RS02285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692408.1',
  'hypothetical protein',
  440592,
  440810,
  -1,
  'KQR59_RS02290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_394367474.1',
  'ligand-gated ion channel',
  440878,
  441873,
  -1,
  'KQR59_RS02295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692410.1',
  'site-2 protease family protein',
  442042,
  442698,
  -1,
  'KQR59_RS02300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_179951654.1',
  'hypothetical protein',
  443015,
  443188,
  1,
  'KQR59_RS02305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fevR',
  'transcriptional regulator FevR',
  443407,
  443742,
  1,
  'KQR59_RS02310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'asd',
  'archaetidylserine decarboxylase',
  443715,
  444560,
  -1,
  'KQR59_RS02315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263841.1',
  'hypothetical protein',
  444655,
  445641,
  1,
  'KQR59_RS02320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692412.1',
  'bifunctional nicotinamide-nucleotideadenylyltransferase/Nudix hydroxylase',
  445652,
  446689,
  1,
  'KQR59_RS02325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glmU',
  'bifunctional UDP-N-acetylglucosaminediphosphorylase/glucosamine-1-phosphateN-acetyltransferase GlmU',
  446711,
  448075,
  1,
  'KQR59_RS02330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glmS',
  'glutamine--fructose-6-phosphate transaminase(isomerizing)',
  448096,
  449934,
  1,
  'KQR59_RS02335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367911.1',
  'GNAT family N-acetyltransferase',
  449992,
  450504,
  1,
  'KQR59_RS02340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  450501,
  450698,
  -1,
  'KQR59_RS02345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004286368.1',
  'cold-shock protein',
  450698,
  450901,
  -1,
  'KQR59_RS02350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367912.1',
  'MazG nucleotide pyrophosphohydrolasedomain-containing protein',
  451139,
  451468,
  -1,
  'KQR59_RS02355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420987.1',
  'ketol-acid reductoisomerase',
  451501,
  452970,
  -1,
  'KQR59_RS02360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ilvY',
  'HTH-type transcriptional activator IlvY',
  453093,
  453974,
  1,
  'KQR59_RS02365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'map',
  'type I methionyl aminopeptidase',
  454086,
  454856,
  1,
  'KQR59_RS02370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692415.1',
  'hypothetical protein',
  454858,
  455709,
  1,
  'KQR59_RS02375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'parC',
  'DNA topoisomerase IV subunit A',
  455807,
  458026,
  1,
  'KQR59_RS02380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692417.1',
  '5''-methylthioadenosine/adenosylhomocysteinenucleosidase',
  458023,
  458712,
  1,
  'KQR59_RS02385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572864.1',
  'hypothetical protein',
  458717,
  458857,
  1,
  'KQR59_RS09475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572866.1',
  'transglycosylase SLT domain-containing protein',
  458858,
  460702,
  1,
  'KQR59_RS02390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_425513940.1',
  'lytic transglycosylase domain-containingprotein',
  460778,
  462754,
  1,
  'KQR59_RS02395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692419.1',
  'MFS transporter',
  462819,
  464003,
  1,
  'KQR59_RS02400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923599.1',
  'outer membrane protein',
  464275,
  464940,
  -1,
  'KQR59_RS02405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572868.1',
  'mechanosensitive ion channel family protein',
  464970,
  466958,
  -1,
  'KQR59_RS02410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaE',
  'DNA polymerase III subunit alpha',
  467246,
  470725,
  1,
  'KQR59_RS02415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692422.1',
  'GIY-YIG nuclease family protein',
  470779,
  471063,
  1,
  'KQR59_RS02420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367926.1',
  'DUF4230 domain-containing protein',
  471367,
  471942,
  1,
  'KQR59_RS02425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692423.1',
  'hypothetical protein',
  472304,
  472990,
  1,
  'KQR59_RS02430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692424.1',
  'aromatic amino acid transport family protein',
  473052,
  474200,
  -1,
  'KQR59_RS02435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367929.1',
  'acyltransferase family protein',
  474482,
  476458,
  1,
  'KQR59_RS02440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692425.1',
  'peptide deformylase',
  476482,
  477087,
  1,
  'KQR59_RS02445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rrf',
  '—',
  477161,
  477275,
  1,
  'KQR59_RS02450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150466000.1',
  'lipoprotein-releasing ABC transporter permeasesubunit',
  477779,
  479041,
  1,
  'KQR59_RS02455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lolD',
  'lipoprotein-releasing ABC transporterATP-binding protein LolD',
  479034,
  479729,
  1,
  'KQR59_RS02460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692426.1',
  'lysine decarboxylase LdcC',
  479825,
  481960,
  1,
  'KQR59_RS02465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gcvT',
  'glycine cleavage system aminomethyltransferaseGcvT',
  482048,
  483124,
  1,
  'KQR59_RS02470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gcvH',
  'glycine cleavage system protein GcvH',
  483176,
  483559,
  1,
  'KQR59_RS02475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gcvPA',
  'aminomethyl-transferring glycine dehydrogenasesubunit GcvPA',
  483628,
  484995,
  1,
  'KQR59_RS02480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gcvPB',
  'aminomethyl-transferring glycine dehydrogenasesubunit GcvPB',
  485001,
  486446,
  1,
  'KQR59_RS02485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692430.1',
  'CPBP family intramembrane glutamicendopeptidase',
  486597,
  487367,
  1,
  'KQR59_RS02490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692431.1',
  'SGNH/GDSL hydrolase family protein',
  487433,
  488911,
  1,
  'KQR59_RS02495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692432.1',
  'O-acetylhomoserineaminocarboxypropyltransferase/cysteine synthase familyprotein',
  489148,
  490458,
  1,
  'KQR59_RS02500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692433.1',
  'homoserineO-acetyltransferase/O-succinyltransferase family protein',
  490430,
  491302,
  1,
  'KQR59_RS02505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692434.1',
  'shikimate dehydrogenase family protein',
  491308,
  492150,
  -1,
  'KQR59_RS02510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pulA',
  'type I pullulanase',
  492160,
  495372,
  -1,
  'KQR59_RS02515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glgB',
  '1,4-alpha-glucan branching protein GlgB',
  495436,
  497358,
  -1,
  'KQR59_RS02520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692437.1',
  'alpha-D-glucose phosphate-specificphosphoglucomutase',
  497645,
  499279,
  1,
  'KQR59_RS02525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glgC',
  'glucose-1-phosphate adenylyltransferase',
  499316,
  500587,
  1,
  'KQR59_RS02530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glgA',
  'glycogen synthase GlgA',
  500597,
  502054,
  1,
  'KQR59_RS02535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glgP',
  'glycogen/starch/alpha-glucan familyphosphorylase',
  502178,
  504445,
  1,
  'KQR59_RS02540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'malQ',
  '4-alpha-glucanotransferase',
  504661,
  506085,
  1,
  'KQR59_RS02545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692441.1',
  'hypothetical protein',
  506169,
  506618,
  1,
  'KQR59_RS02550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692442.1',
  'hypothetical protein',
  506831,
  507190,
  1,
  'KQR59_RS02555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923568.1',
  'GNAT family N-acetyltransferase',
  507435,
  508016,
  1,
  'KQR59_RS02560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glyQ',
  'glycine--tRNA ligase subunit alpha',
  508120,
  509010,
  1,
  'KQR59_RS02565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692443.1',
  'UDP-N-acetylmuramoyl-L-alanyl-D-glutamate--2,6-diaminopimelate ligase',
  509221,
  510744,
  1,
  'KQR59_RS02570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692444.1',
  'HD domain-containing protein',
  510870,
  511460,
  1,
  'KQR59_RS02575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692445.1',
  'UDP-N-acetylmuramoyl-tripeptide--D-alanyl-D-alanine ligase',
  511589,
  512947,
  1,
  'KQR59_RS02580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692446.1',
  'hypothetical protein',
  512956,
  513774,
  1,
  'KQR59_RS02585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'asd',
  'aspartate-semialdehyde dehydrogenase',
  513823,
  514923,
  -1,
  'KQR59_RS02590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thrA',
  'bifunctional aspartate kinase/homoserinedehydrogenase I',
  515017,
  517437,
  1,
  'KQR59_RS02595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692449.1',
  'homoserine kinase',
  517440,
  518393,
  1,
  'KQR59_RS02600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thrC',
  'threonine synthase',
  518406,
  519689,
  1,
  'KQR59_RS02605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463733.1',
  'UDP-2,3-diacylglucosamine diphosphatase',
  519723,
  520445,
  -1,
  'KQR59_RS02610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pyrE',
  'orotate phosphoribosyltransferase',
  520435,
  521061,
  -1,
  'KQR59_RS02615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mpl',
  'UDP-N-acetylmuramate:L-alanyl-gamma-D-glutamyl-meso-diaminopimelate ligase',
  521222,
  522592,
  1,
  'KQR59_RS02620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rlmB',
  '23S rRNA(guanosine(2251)-2''-O)-methyltransferase RlmB',
  522589,
  523329,
  1,
  'KQR59_RS02625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923554.1',
  'FUSC family protein',
  523420,
  524463,
  1,
  'KQR59_RS02630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923553.1',
  'MFS transporter',
  524552,
  525778,
  1,
  'KQR59_RS02635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692454.1',
  'ATP-binding cassette domain-containing protein',
  525812,
  527653,
  1,
  'KQR59_RS02640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692455.1',
  'peptide MFS transporter',
  527756,
  529183,
  1,
  'KQR59_RS02645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692456.1',
  'glutamine--tRNA ligase/YqeY domain fusionprotein',
  529211,
  530872,
  -1,
  'KQR59_RS02650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692457.1',
  'phosphoenolpyruvate carboxykinase (ATP)',
  531020,
  532606,
  1,
  'KQR59_RS02655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mraY',
  'phospho-N-acetylmuramoyl-pentapeptide-transferase',
  532681,
  533778,
  1,
  'KQR59_RS02660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murD',
  'UDP-N-acetylmuramoyl-L-alanine--D-glutamateligase',
  533778,
  535022,
  1,
  'KQR59_RS02665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ftsW',
  'putative lipid II flippase FtsW',
  535040,
  536248,
  1,
  'KQR59_RS02670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923545.1',
  'oxidative damage protection protein',
  536289,
  536552,
  -1,
  'KQR59_RS02675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263830.1',
  'TusE/DsrC/DsvC family sulfur relay protein',
  536572,
  536886,
  -1,
  'KQR59_RS02680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sspA',
  'transcriptional regulator SspA',
  536976,
  537605,
  1,
  'KQR59_RS02685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sohB',
  'protease SohB',
  537618,
  538634,
  1,
  'KQR59_RS02690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692462.1',
  'DNA polymerase III delta subunit-relatedprotein',
  538642,
  539550,
  1,
  'KQR59_RS02695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yhbY',
  'ribosome assembly RNA-binding protein YhbY',
  539561,
  539839,
  1,
  'KQR59_RS02700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421044.1',
  'FTN_0109 family protein',
  539955,
  540644,
  1,
  'KQR59_RS02705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trmL',
  'tRNA(uridine(34)/cytosine(34)/5-carboxymethylaminomethyluridine(34)-2''-O)-methyltransferase TrmL',
  540647,
  541114,
  1,
  'KQR59_RS02710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367970.1',
  'oligopeptide:H+ symporter',
  541188,
  542636,
  -1,
  'KQR59_RS02715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'argS',
  'arginine--tRNA ligase',
  542718,
  544463,
  -1,
  'KQR59_RS02720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692465.1',
  'LPS-assembly protein LptD',
  544596,
  547214,
  1,
  'KQR59_RS02725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692466.1',
  'SurA N-terminal domain-containing protein',
  547214,
  548626,
  1,
  'KQR59_RS02730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsmA',
  '16S rRNA(adenine(1518)-N(6)/adenine(1519)-N(6))-dimethyltransferase RsmA',
  548628,
  549416,
  1,
  'KQR59_RS02735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692468.1',
  'symmetrical bis(5''-nucleosyl)-tetraphosphatase',
  549429,
  550256,
  1,
  'KQR59_RS02740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aroQ',
  'type II 3-dehydroquinate dehydratase',
  550258,
  550695,
  1,
  'KQR59_RS02745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'accB',
  'acetyl-CoA carboxylase biotin carboxyl carrierprotein',
  550700,
  551170,
  1,
  'KQR59_RS02750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'accC',
  'acetyl-CoA carboxylase biotin carboxylasesubunit',
  551236,
  552591,
  1,
  'KQR59_RS02755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692470.1',
  'helix-turn-helix domain-containing protein',
  552683,
  553348,
  1,
  'KQR59_RS02760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421054.1',
  'mechanosensitive ion channel family protein',
  553372,
  554493,
  1,
  'KQR59_RS02765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'epmA',
  'EF-P lysine aminoacylase EpmA',
  554522,
  555445,
  -1,
  'KQR59_RS02770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692472.1',
  'biotin--[acetyl-CoA-carboxylase] ligase',
  555442,
  556224,
  -1,
  'KQR59_RS02775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recJ',
  'single-stranded-DNA-specific exonuclease RecJ',
  556221,
  557963,
  -1,
  'KQR59_RS02780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421058.1',
  'AI-2E family transporter',
  557957,
  559063,
  -1,
  'KQR59_RS02785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gadC',
  'glutamate transporter GadC',
  559155,
  560564,
  -1,
  'KQR59_RS02790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692474.1',
  'polyamine ABC transporter substrate-bindingprotein',
  560649,
  561839,
  1,
  'KQR59_RS02795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692475.1',
  'CPBP family intramembrane glutamicendopeptidase',
  561849,
  562646,
  -1,
  'KQR59_RS02800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsgA',
  'ribosome small subunit-dependent GTPase A',
  562703,
  563587,
  -1,
  'KQR59_RS02805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149367985.1',
  'DUF2147 domain-containing protein',
  563755,
  564462,
  1,
  'KQR59_RS02810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_343213195.1',
  'hypothetical protein',
  564561,
  565217,
  1,
  'KQR59_RS02815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_343213198.1',
  'DUF2147 domain-containing protein',
  565326,
  565937,
  1,
  'KQR59_RS02820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mutL',
  'DNA mismatch repair endonuclease MutL',
  565950,
  567755,
  1,
  'KQR59_RS02825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692478.1',
  'NADPH-dependent FMN reductase',
  567889,
  568434,
  1,
  'KQR59_RS02830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trxB',
  'thioredoxin-disulfide reductase',
  568437,
  569387,
  -1,
  'KQR59_RS02835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692480.1',
  'HAD-IA family hydrolase',
  569498,
  570175,
  -1,
  'KQR59_RS02840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465043.1',
  'LysR family transcriptional regulator',
  570232,
  571158,
  -1,
  'KQR59_RS02845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692481.1',
  'MFS transporter',
  571269,
  572435,
  1,
  'KQR59_RS02850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692482.1',
  'copper homeostasis protein CutC',
  572450,
  573172,
  -1,
  'KQR59_RS02855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692483.1',
  'DUF1543 domain-containing protein',
  573342,
  573845,
  1,
  'KQR59_RS02860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692484.1',
  'glycosylasparaginase',
  574054,
  574974,
  -1,
  'KQR59_RS02865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692485.1',
  'peptide MFS transporter',
  574977,
  576422,
  -1,
  'KQR59_RS02870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421074.1',
  'GFA family protein',
  576603,
  577007,
  1,
  'KQR59_RS02875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465050.1',
  'AI-2E family transporter',
  577017,
  578036,
  -1,
  'KQR59_RS02880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_211490824.1',
  'SDR family oxidoreductase',
  578198,
  578893,
  -1,
  'KQR59_RS02885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_224728140.1',
  'hypothetical protein',
  578919,
  579359,
  -1,
  'KQR59_RS09480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sucD',
  'succinate--CoA ligase subunit alpha',
  579474,
  580346,
  -1,
  'KQR59_RS02895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sucC',
  'ADP-forming succinate--CoA ligase subunit beta',
  580378,
  581541,
  -1,
  'KQR59_RS02900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692486.1',
  'TIGR03546 family protein',
  581884,
  583806,
  1,
  'KQR59_RS02905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692487.1',
  'hypothetical protein',
  583943,
  584770,
  -1,
  'KQR59_RS02910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692488.1',
  'hypothetical protein',
  584840,
  585202,
  1,
  'KQR59_RS02915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692490.1',
  'hypothetical protein',
  585174,
  586250,
  1,
  'KQR59_RS02920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dusA',
  'tRNA dihydrouridine(20/20a) synthase DusA',
  586257,
  587231,
  -1,
  'KQR59_RS02925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'chaC',
  'gamma-glutamylcyclotransferase ChaC',
  587269,
  588069,
  -1,
  'KQR59_RS02930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gyrB',
  'DNA topoisomerase (ATP-hydrolyzing) subunit B',
  588247,
  590658,
  1,
  'KQR59_RS02935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pdxS',
  'pyridoxal 5''-phosphate synthase lyase subunitPdxS',
  590782,
  591645,
  1,
  'KQR59_RS02940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pdxT',
  'pyridoxal 5''-phosphate synthase glutaminasesubunit PdxT',
  591649,
  592188,
  1,
  'KQR59_RS02945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mutM',
  'bifunctional DNA-formamidopyrimidineglycosylase/DNA-(apurinic or apyrimidinic site) lyase',
  592191,
  593015,
  -1,
  'KQR59_RS02950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'migR',
  'iglABCD operon regulator MigR',
  593108,
  595207,
  1,
  'KQR59_RS02955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsmH',
  '16S rRNA (cytosine(1402)-N(4))-methyltransferaseRsmH',
  595213,
  596130,
  1,
  'KQR59_RS02960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ftsL',
  'cell division protein FtsL',
  596127,
  596477,
  1,
  'KQR59_RS02965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692502.1',
  'peptidoglycan D,D-transpeptidase FtsI familyprotein',
  596470,
  598161,
  1,
  'KQR59_RS02970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsO',
  '30S ribosomal protein S15',
  598270,
  598536,
  1,
  'KQR59_RS02975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pnp',
  'polyribonucleotide nucleotidyltransferase',
  598595,
  600676,
  1,
  'KQR59_RS02980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'erpA',
  'iron-sulfur cluster insertion protein ErpA',
  600681,
  601031,
  1,
  'KQR59_RS02985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'kdsA',
  '3-deoxy-8-phosphooctulonate synthase',
  601073,
  601900,
  1,
  'KQR59_RS02990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'udk',
  'uridine kinase',
  601912,
  602577,
  1,
  'KQR59_RS02995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS02995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpoZ',
  'DNA-directed RNA polymerase subunit omega',
  602570,
  602788,
  1,
  'KQR59_RS03000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  602847,
  602922,
  1,
  'KQR59_RS03005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149377228.1',
  'hypothetical protein',
  603046,
  603609,
  1,
  'KQR59_RS03010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rlmD',
  '23S rRNA (uracil(1939)-C(5))-methyltransferaseRlmD',
  603677,
  605026,
  1,
  'KQR59_RS03015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692504.1',
  'ROK family protein',
  605029,
  605994,
  1,
  'KQR59_RS03020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692505.1',
  'ROK family protein',
  605994,
  606941,
  1,
  'KQR59_RS03025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  606962,
  607723,
  1,
  'KQR59_RS03030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923475.1',
  'MFS transporter',
  607822,
  609048,
  1,
  'KQR59_RS03035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'eno',
  'phosphopyruvate hydratase',
  609151,
  610518,
  1,
  'KQR59_RS03040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923473.1',
  'FtsB family cell division protein',
  610526,
  610816,
  1,
  'KQR59_RS03045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ispD',
  '2-C-methyl-D-erythritol 4-phosphatecytidylyltransferase',
  610806,
  611498,
  1,
  'KQR59_RS03050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692508.1',
  'amino acid permease',
  611503,
  612765,
  -1,
  'KQR59_RS03055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tdh',
  'L-threonine 3-dehydrogenase',
  612766,
  613821,
  -1,
  'KQR59_RS03060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692512.1',
  'glycine C-acetyltransferase',
  613839,
  615032,
  -1,
  'KQR59_RS03065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692514.1',
  'glycosyl hydrolase family 18 protein',
  615510,
  618182,
  1,
  'KQR59_RS03070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'upp',
  'uracil phosphoribosyltransferase',
  618353,
  618982,
  1,
  'KQR59_RS03075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purU',
  'formyltetrahydrofolate deformylase',
  619069,
  619902,
  1,
  'KQR59_RS03080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692518.1',
  'glycosyl hydrolase family 18 protein',
  620012,
  622402,
  -1,
  'KQR59_RS09555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692520.1',
  'MATE family efflux transporter',
  622728,
  624026,
  1,
  'KQR59_RS03090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692522.1',
  'tautomerase family protein',
  624027,
  624371,
  1,
  'KQR59_RS03095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692524.1',
  'MFS transporter',
  624439,
  625659,
  1,
  'KQR59_RS03100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dgt',
  'dGTP triphosphohydrolase',
  625643,
  626965,
  -1,
  'KQR59_RS03105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'katG',
  'catalase/peroxidase HPI',
  627066,
  629285,
  -1,
  'KQR59_RS03110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368027.1',
  'SDR family oxidoreductase',
  629490,
  630236,
  -1,
  'KQR59_RS03115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dacB',
  'D-alanyl-D-alaninecarboxypeptidase/D-alanyl-D-alanine endopeptidase',
  630270,
  631655,
  -1,
  'KQR59_RS03120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368029.1',
  'MFS transporter',
  631670,
  632986,
  -1,
  'KQR59_RS03125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_425513941.1',
  'glycerophosphodiester phosphodiesterase',
  633091,
  634125,
  -1,
  'KQR59_RS03130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692530.1',
  'HlyD family secretion protein',
  634264,
  635235,
  1,
  'KQR59_RS03135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692531.1',
  'ABC transporter ATP-binding protein',
  635232,
  636164,
  1,
  'KQR59_RS03140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_035735326.1',
  'ABC transporter permease',
  636161,
  637279,
  1,
  'KQR59_RS03145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692532.1',
  'SulP family inorganic anion transporter',
  637376,
  638920,
  1,
  'KQR59_RS03150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692534.1',
  'RidA family protein',
  638920,
  639300,
  1,
  'KQR59_RS03155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692536.1',
  'MAPEG family protein',
  639323,
  639847,
  -1,
  'KQR59_RS03160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dctA',
  'C4-dicarboxylate transporter DctA',
  639988,
  641238,
  1,
  'KQR59_RS03165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692540.1',
  'NAD(P)H-dependent flavin oxidoreductase',
  641239,
  642267,
  1,
  'KQR59_RS03170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cydC',
  'heme ABC transporter ATP-bindingprotein/permease CydC',
  642257,
  643906,
  -1,
  'KQR59_RS03175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cydD',
  'heme ABC transporter permease/ATP-bindingprotein CydD',
  643903,
  645684,
  -1,
  'KQR59_RS03180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421129.1',
  'hypothetical protein',
  645837,
  646109,
  1,
  'KQR59_RS03185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421130.1',
  'hypothetical protein',
  646154,
  646567,
  1,
  'KQR59_RS03190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923437.1',
  'hypothetical protein',
  646588,
  646791,
  1,
  'KQR59_RS03195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692545.1',
  'lipopolysaccharide biosynthesis protein',
  646800,
  648059,
  -1,
  'KQR59_RS03200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463818.1',
  'ROK family protein',
  648145,
  649041,
  -1,
  'KQR59_RS03205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692547.1',
  'nuclear transport factor 2 family protein',
  649216,
  649578,
  -1,
  'KQR59_RS03210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'serS',
  'serine--tRNA ligase',
  649583,
  650863,
  -1,
  'KQR59_RS03215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gpmI',
  '2,3-bisphosphoglycerate-independentphosphoglycerate mutase',
  650878,
  652416,
  -1,
  'KQR59_RS03220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692551.1',
  'FAD-binding and (Fe-S)-binding domain-containingprotein',
  652630,
  655659,
  1,
  'KQR59_RS03225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  655686,
  655761,
  1,
  'KQR59_RS03230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  655799,
  655874,
  1,
  'KQR59_RS03235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692553.1',
  'peptide MFS transporter',
  655987,
  657411,
  1,
  'KQR59_RS03240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cdd',
  'cytidine deaminase',
  657413,
  657814,
  -1,
  'KQR59_RS03245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'udp',
  'uridine phosphorylase',
  657831,
  658634,
  -1,
  'KQR59_RS03250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_187986016.1',
  'MiaE family protein',
  658744,
  659355,
  1,
  'KQR59_RS03255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692557.1',
  'trimeric intracellular cation channel familyprotein',
  659375,
  660025,
  -1,
  'KQR59_RS03260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692559.1',
  'APC family permease',
  660060,
  661622,
  -1,
  'KQR59_RS03265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mmsA',
  'CoA-acylating methylmalonate-semialdehydedehydrogenase',
  661900,
  663357,
  1,
  'KQR59_RS03270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692561.1',
  'aminotransferase class III-fold pyridoxalphosphate-dependent enzyme',
  663418,
  664746,
  1,
  'KQR59_RS03275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923420.1',
  'LysR family transcriptional regulator',
  664748,
  665743,
  -1,
  'KQR59_RS03280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsmD',
  '16S rRNA (guanine(966)-N(2))-methyltransferaseRsmD',
  665825,
  666379,
  -1,
  'KQR59_RS03285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692565.1',
  'M16 family metallopeptidase',
  666380,
  667603,
  -1,
  'KQR59_RS03290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692567.1',
  'M16 family metallopeptidase',
  667609,
  668862,
  -1,
  'KQR59_RS03295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lptG',
  'LPS export ABC transporter permease LptG',
  668871,
  669929,
  -1,
  'KQR59_RS03300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lptF',
  'LPS export ABC transporter permease LptF',
  669930,
  671012,
  -1,
  'KQR59_RS03305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465105.1',
  'leucyl aminopeptidase',
  671176,
  672615,
  1,
  'KQR59_RS03310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'guaB',
  'IMP dehydrogenase',
  672710,
  674170,
  1,
  'KQR59_RS03315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465106.1',
  'thiamine diphosphokinase',
  674234,
  674887,
  1,
  'KQR59_RS03320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pgi',
  'glucose-6-phosphate isomerase',
  674874,
  676496,
  1,
  'KQR59_RS03325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465108.1',
  'type II secretion system protein',
  676496,
  677080,
  1,
  'KQR59_RS03330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'greA',
  'transcription elongation factor GreA',
  677115,
  677597,
  1,
  'KQR59_RS03335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uvrA',
  'excinuclease ABC subunit UvrA',
  677633,
  680458,
  1,
  'KQR59_RS03340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ftsH',
  'ATP-dependent zinc metalloprotease FtsH',
  680569,
  682518,
  1,
  'KQR59_RS03345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'deoD',
  'purine-nucleoside phosphorylase',
  682704,
  683426,
  1,
  'KQR59_RS03350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692571.1',
  'hypothetical protein',
  683435,
  683878,
  -1,
  'KQR59_RS03355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692573.1',
  'LPP20 family lipoprotein',
  683882,
  684925,
  -1,
  'KQR59_RS03360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secA',
  'preprotein translocase subunit SecA',
  685056,
  687776,
  1,
  'KQR59_RS03365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692577.1',
  'DNA-3-methyladenine glycosylase I',
  687793,
  688365,
  1,
  'KQR59_RS03370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplU',
  '50S ribosomal protein L21',
  688592,
  688906,
  1,
  'KQR59_RS03375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmA',
  '50S ribosomal protein L27',
  688937,
  689191,
  1,
  'KQR59_RS03380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692579.1',
  'LysE family translocator',
  689315,
  689911,
  1,
  'KQR59_RS03385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368064.1',
  'ABC transporter permease',
  689916,
  690719,
  -1,
  'KQR59_RS03390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923396.1',
  'ABC transporter permease',
  690732,
  691613,
  -1,
  'KQR59_RS03395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692581.1',
  'ABC transporter ATP-binding protein',
  691613,
  692734,
  -1,
  'KQR59_RS03400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692583.1',
  'carotenoid oxygenase family protein',
  692914,
  694314,
  1,
  'KQR59_RS03405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692585.1',
  'HAD-IB family phosphatase',
  694321,
  694971,
  1,
  'KQR59_RS03410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692587.1',
  'DUF475 domain-containing protein',
  694957,
  695982,
  -1,
  'KQR59_RS03415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368068.1',
  'DUF3301 domain-containing protein',
  696061,
  696471,
  1,
  'KQR59_RS03420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421477.1',
  'glutathione S-transferase family protein',
  696471,
  697178,
  1,
  'KQR59_RS03425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692589.1',
  'peptide MFS transporter',
  697308,
  698801,
  1,
  'KQR59_RS03430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'alr',
  'alanine racemase',
  698814,
  699911,
  1,
  'KQR59_RS03435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421167.1',
  'APC family permease',
  699991,
  701601,
  1,
  'KQR59_RS03440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pheA',
  'prephenate dehydratase',
  701670,
  702512,
  1,
  'KQR59_RS03445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692594.1',
  'bifunctional metallophosphatase/5''-nucleotidase',
  702524,
  704089,
  1,
  'KQR59_RS03450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421169.1',
  'M48 family metallopeptidase',
  704093,
  704761,
  1,
  'KQR59_RS03455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421170.1',
  'L-serine ammonia-lyase',
  704815,
  706188,
  1,
  'KQR59_RS03460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692596.1',
  'aminotransferase class V-fold PLP-dependentenzyme',
  706292,
  707515,
  1,
  'KQR59_RS03465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368075.1',
  'HesB/IscA family protein',
  707544,
  707897,
  1,
  'KQR59_RS03470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sufT',
  'putative Fe-S cluster assembly protein SufT',
  707911,
  708462,
  1,
  'KQR59_RS03475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'coaD',
  'pantetheine-phosphate adenylyltransferase',
  708470,
  708958,
  1,
  'KQR59_RS03480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923375.1',
  'YfhL family 4Fe-4S dicluster ferredoxin',
  708960,
  709205,
  1,
  'KQR59_RS03485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421174.1',
  'OmpA family protein',
  709306,
  710478,
  1,
  'KQR59_RS03490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692600.1',
  'type II secretion system F family protein',
  710910,
  712142,
  -1,
  'KQR59_RS03495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pilB',
  'type IV-A pilus assembly ATPase PilB',
  712153,
  713931,
  -1,
  'KQR59_RS03500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692602.1',
  'glycerophosphodiester phosphodiesterase familyprotein',
  714090,
  714842,
  1,
  'KQR59_RS03505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692604.1',
  'competence/damage-inducible protein A',
  714825,
  715577,
  -1,
  'KQR59_RS03510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cphA',
  'cyanophycin synthetase',
  715702,
  718524,
  1,
  'KQR59_RS03515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692608.1',
  'Mur ligase family protein',
  718556,
  720241,
  1,
  'KQR59_RS03520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ispF',
  '2-C-methyl-D-erythritol 2,4-cyclodiphosphatesynthase',
  720246,
  720725,
  -1,
  'KQR59_RS03525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692610.1',
  'rhodanese-like domain-containing protein',
  720737,
  721489,
  -1,
  'KQR59_RS03530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692611.1',
  'amino acid permease',
  721561,
  722772,
  -1,
  'KQR59_RS03535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692612.1',
  'MetQ/NlpA family ABC transportersubstrate-binding protein',
  722854,
  724326,
  -1,
  'KQR59_RS03540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421184.1',
  'methionine ABC transporter ATP-binding protein',
  724304,
  725356,
  -1,
  'KQR59_RS03545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'plsY',
  'glycerol-3-phosphate 1-O-acyltransferase PlsY',
  725343,
  725957,
  -1,
  'KQR59_RS03550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tgt',
  'tRNA guanosine(34) transglycosylase Tgt',
  726112,
  727218,
  1,
  'KQR59_RS03555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692613.1',
  'LysR family transcriptional regulator',
  727260,
  728132,
  -1,
  'KQR59_RS03560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692614.1',
  'DMT family transporter',
  728236,
  729108,
  1,
  'KQR59_RS03565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465229.1',
  'cysteine hydrolase family protein',
  729123,
  729716,
  1,
  'KQR59_RS03570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_083817032.1',
  'hypothetical protein',
  729781,
  729984,
  1,
  'KQR59_RS03575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692615.1',
  'MFS transporter',
  730709,
  731932,
  1,
  'KQR59_RS03580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692617.1',
  'glycoside hydrolase family 15 protein',
  731943,
  733391,
  1,
  'KQR59_RS03585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yajC',
  'preprotein translocase subunit YajC',
  733524,
  733880,
  1,
  'KQR59_RS03590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secD',
  'protein translocase subunit SecD',
  733939,
  735876,
  1,
  'KQR59_RS03595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secF',
  'protein translocase subunit SecF',
  735895,
  736836,
  1,
  'KQR59_RS03600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923352.1',
  'SH3 domain-containing protein',
  736908,
  737396,
  1,
  'KQR59_RS03605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpoH',
  'RNA polymerase sigma factor RpoH',
  737424,
  738302,
  1,
  'KQR59_RS03610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aroA',
  '3-phosphoshikimate 1-carboxyvinyltransferase',
  738391,
  739671,
  1,
  'KQR59_RS03615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692625.1',
  'class I SAM-dependent methyltransferase',
  739671,
  740270,
  1,
  'KQR59_RS03620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rnhA',
  'ribonuclease HI',
  740245,
  740703,
  1,
  'KQR59_RS03625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ansA',
  'asparaginase',
  740706,
  741737,
  1,
  'KQR59_RS03630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923346.1',
  'carbonic anhydrase',
  741826,
  742530,
  1,
  'KQR59_RS03635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hsdR',
  'EcoAI/FtnUII family type I restriction enzmesubunit R',
  742603,
  744951,
  1,
  'KQR59_RS03640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572876.1',
  'restriction endonuclease subunit S',
  745352,
  746530,
  1,
  'KQR59_RS03645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692632.1',
  'transposase',
  746736,
  747350,
  1,
  'KQR59_RS03650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692633.1',
  'type I restriction-modification system subunitM',
  747331,
  748776,
  1,
  'KQR59_RS03655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692634.1',
  'DUF6790 family protein',
  748771,
  749235,
  -1,
  'KQR59_RS03660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tig',
  'trigger factor',
  749387,
  750703,
  1,
  'KQR59_RS03665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'clpP',
  'ATP-dependent Clp endopeptidase proteolyticsubunit ClpP',
  750729,
  751334,
  1,
  'KQR59_RS03670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'clpX',
  'ATP-dependent Clp protease ATP-binding subunitClpX',
  751359,
  752612,
  1,
  'KQR59_RS03675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lon',
  'endopeptidase La',
  752638,
  754962,
  1,
  'KQR59_RS03680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287553.1',
  'non-specific DNA-binding protein Hbs',
  755048,
  755320,
  1,
  'KQR59_RS03685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692636.1',
  'SurA N-terminal domain-containing protein',
  755432,
  756865,
  1,
  'KQR59_RS03690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'miaA',
  'tRNA (adenosine(37)-N6)-dimethylallyltransferaseMiaA',
  756866,
  757792,
  1,
  'KQR59_RS03695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hfq',
  'RNA chaperone Hfq',
  757897,
  758226,
  1,
  'KQR59_RS03700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hflX',
  'GTPase HflX',
  758279,
  759586,
  1,
  'KQR59_RS03705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692644.1',
  'FAD-binding domain',
  759596,
  760774,
  -1,
  'KQR59_RS03710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hflK',
  'FtsH protease activity modulator HflK',
  760967,
  762034,
  1,
  'KQR59_RS03715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hflC',
  'protease modulator HflC',
  762036,
  762962,
  1,
  'KQR59_RS03720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692649.1',
  'low molecular weightprotein-tyrosine-phosphatase',
  762965,
  763450,
  1,
  'KQR59_RS03725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yihA',
  'ribosome biogenesis GTP-binding proteinYihA/YsxC',
  763447,
  764040,
  1,
  'KQR59_RS03730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thrC',
  'threonine synthase',
  764182,
  765978,
  1,
  'KQR59_RS09575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ilvD',
  'dihydroxy-acid dehydratase',
  766000,
  767682,
  1,
  'KQR59_RS03740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ilvB',
  'biosynthetic-type acetolactate synthase largesubunit',
  767831,
  769528,
  1,
  'KQR59_RS03745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923328.1',
  'acetolactate synthase small subunit',
  769533,
  769850,
  1,
  'KQR59_RS03750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mfd',
  'transcription-repair coupling factor',
  770394,
  773816,
  -1,
  'KQR59_RS03755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692655.1',
  'Bax inhibitor-1/YccA family protein',
  773863,
  774549,
  -1,
  'KQR59_RS03760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368112.1',
  'hypothetical protein',
  774664,
  775923,
  -1,
  'KQR59_RS03765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421218.1',
  'DUF1841 family protein',
  775923,
  776354,
  -1,
  'KQR59_RS03770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nth',
  'endonuclease III',
  776351,
  776989,
  -1,
  'KQR59_RS03775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692659.1',
  'RnfABCDGE type electron transport complexsubunit B',
  776982,
  777611,
  -1,
  'KQR59_RS03780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'grxB',
  'glutaredoxin 2',
  777613,
  778257,
  -1,
  'KQR59_RS03785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692661.1',
  'patatin-like phospholipase family protein',
  778378,
  779556,
  -1,
  'KQR59_RS03790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421224.1',
  'peptide MFS transporter',
  779776,
  781248,
  1,
  'KQR59_RS03795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923318.1',
  'ferritin',
  781252,
  781755,
  -1,
  'KQR59_RS03800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lipA',
  'lipoyl synthase',
  781959,
  782942,
  1,
  'KQR59_RS03805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'elbB',
  'isoprenoid biosynthesis glyoxalase ElbB',
  782968,
  783627,
  1,
  'KQR59_RS03810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421227.1',
  'YebC/PmpR family DNA-binding transcriptionalregulator',
  783646,
  784392,
  1,
  'KQR59_RS03815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ruvC',
  'crossover junction endodeoxyribonuclease RuvC',
  784517,
  785032,
  1,
  'KQR59_RS03820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692662.1',
  'MerR family DNA-binding transcriptionalregulator',
  785098,
  785268,
  1,
  'KQR59_RS03825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692663.1',
  'MFS transporter',
  785550,
  786743,
  1,
  'KQR59_RS03830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ruvA',
  'Holliday junction branch migration protein RuvA',
  786754,
  787407,
  1,
  'KQR59_RS03835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692665.1',
  'DNA recombination protein RmuC',
  787423,
  788841,
  1,
  'KQR59_RS03840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692667.1',
  'cytochrome b/b6 domain-containing protein',
  788847,
  789428,
  1,
  'KQR59_RS03845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263787.1',
  'helix-turn-helix transcriptional regulator',
  789431,
  789727,
  -1,
  'KQR59_RS03850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421234.1',
  'metal-independent carbonic anhydrase familyprotein',
  789758,
  790219,
  -1,
  'KQR59_RS03855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692669.1',
  'cation:proton antiporter',
  790478,
  791647,
  1,
  'KQR59_RS03860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465701.1',
  'mechanosensitive ion channel domain-containingprotein',
  791631,
  792464,
  -1,
  'KQR59_RS03865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692671.1',
  'MFS transporter',
  792662,
  793942,
  1,
  'KQR59_RS03870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465702.1',
  'MFS transporter',
  793950,
  795233,
  -1,
  'KQR59_RS03875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923302.1',
  'succinylglutamate desuccinylase/aspartoacylasefamily protein',
  795226,
  796233,
  -1,
  'KQR59_RS03880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368125.1',
  'ribose-phosphate pyrophosphokinase',
  796437,
  797405,
  1,
  'KQR59_RS03885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplY',
  '50S ribosomal protein L25',
  797505,
  797795,
  1,
  'KQR59_RS03890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692673.1',
  'HlyC/CorC family transporter',
  797894,
  799153,
  1,
  'KQR59_RS03895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923298.1',
  'hypothetical protein',
  799169,
  799447,
  -1,
  'KQR59_RS03900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ychF',
  'redox-regulated ATPase YchF',
  799464,
  800555,
  -1,
  'KQR59_RS03905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pth',
  'aminoacyl-tRNA hydrolase',
  800575,
  801150,
  -1,
  'KQR59_RS03910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bla',
  'class A beta-lactamase',
  801143,
  802027,
  -1,
  'KQR59_RS03915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692677.1',
  'DsbC family protein',
  802036,
  802881,
  -1,
  'KQR59_RS03920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421242.1',
  'prepilin peptidase',
  802891,
  803739,
  -1,
  'KQR59_RS03925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sthA',
  'Si-specific NAD(P)(+) transhydrogenase',
  803742,
  805142,
  -1,
  'KQR59_RS03930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_224728164.1',
  'ion channel',
  805238,
  806398,
  -1,
  'KQR59_RS03935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692679.1',
  'peptide MFS transporter',
  806478,
  807929,
  -1,
  'KQR59_RS03940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hslU',
  'ATP-dependent protease ATPase subunit HslU',
  808019,
  809386,
  -1,
  'KQR59_RS03945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hslV',
  'ATP-dependent protease subunit HslV',
  809394,
  809945,
  -1,
  'KQR59_RS03950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421245.1',
  'hypothetical protein',
  810133,
  810882,
  1,
  'KQR59_RS03955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692683.1',
  'lipoate--protein ligase family protein',
  810886,
  811788,
  -1,
  'KQR59_RS03960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tyrS',
  'tyrosine--tRNA ligase',
  811902,
  813092,
  1,
  'KQR59_RS03965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923284.1',
  'hypothetical protein',
  813106,
  813270,
  1,
  'KQR59_RS03970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421247.1',
  'Hsp15 family ribosome-associated heat shockprotein',
  813302,
  813670,
  -1,
  'KQR59_RS03975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692685.1',
  'DUF2797 domain-containing protein',
  813783,
  814598,
  1,
  'KQR59_RS03980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692687.1',
  'NAD(P)-binding domain-containing protein',
  814602,
  815876,
  1,
  'KQR59_RS03985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692689.1',
  'FUSC family protein',
  815873,
  817564,
  -1,
  'KQR59_RS03990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923279.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  817561,
  818418,
  -1,
  'KQR59_RS03995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS03995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923278.1',
  'hypothetical protein',
  818420,
  818617,
  -1,
  'KQR59_RS04000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263776.1',
  'IclR family transcriptional regulator',
  818807,
  819538,
  1,
  'KQR59_RS04005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'epmB',
  'EF-P beta-lysylation protein EpmB',
  819636,
  820622,
  1,
  'KQR59_RS04010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923275.1',
  'cold-shock protein',
  820692,
  820895,
  -1,
  'KQR59_RS04015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421479.1',
  'hypothetical protein',
  821097,
  821426,
  -1,
  'KQR59_RS04020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  821673,
  821873,
  1,
  'KQR59_RS04025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692693.1',
  'tyrosine-type recombinase/integrase',
  822226,
  823521,
  1,
  'KQR59_RS04030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692695.1',
  'helix-turn-helix transcriptional regulator',
  823701,
  823931,
  1,
  'KQR59_RS04035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692697.1',
  'AAA family ATPase',
  823921,
  825117,
  1,
  'KQR59_RS04040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692698.1',
  'type IV secretion system DNA-bindingdomain-containing protein',
  825352,
  827352,
  1,
  'KQR59_RS04045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692700.1',
  'TriL protein',
  827352,
  828074,
  1,
  'KQR59_RS04050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692702.1',
  'type II toxin-antitoxin system RelE/ParE familytoxin',
  828135,
  828467,
  1,
  'KQR59_RS04055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692704.1',
  'helix-turn-helix domain-containing protein',
  828464,
  828757,
  1,
  'KQR59_RS04060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692706.1',
  'LexA family protein',
  828870,
  829514,
  -1,
  'KQR59_RS04065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692708.1',
  'DNA polymerase IV',
  829667,
  830902,
  1,
  'KQR59_RS04070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692710.1',
  'virulence RhuM family protein/type IItoxin-antitoxin system death-on-curing family toxin',
  831116,
  832087,
  1,
  'KQR59_RS04075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692712.1',
  'antirestriction protein ArdA',
  832546,
  833052,
  1,
  'KQR59_RS04080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692714.1',
  'type I restriction-modification system subunitM',
  833181,
  834761,
  1,
  'KQR59_RS04085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692716.1',
  'restriction endonuclease subunit S',
  834745,
  835986,
  1,
  'KQR59_RS04090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692718.1',
  'AAA family ATPase',
  835986,
  838538,
  1,
  'KQR59_RS04095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692720.1',
  'type I restriction endonuclease subunit R',
  838538,
  841678,
  1,
  'KQR59_RS04100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692722.1',
  'hypothetical protein',
  841689,
  843125,
  1,
  'KQR59_RS04105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572901.1',
  'AlpA family phage regulatory protein',
  843322,
  843384,
  1,
  'KQR59_RS04110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  844235,
  844322,
  -1,
  'KQR59_RS04120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692726.1',
  'HXXEE domain-containing protein',
  844467,
  845036,
  1,
  'KQR59_RS04125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923271.1',
  'cation diffusion facilitator family transporter',
  845133,
  846272,
  1,
  'KQR59_RS04130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'galU',
  'UTP--glucose-1-phosphate uridylyltransferaseGalU',
  846288,
  847151,
  1,
  'KQR59_RS04135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'acs',
  'acetate--CoA ligase',
  847263,
  849206,
  1,
  'KQR59_RS04140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692728.1',
  'DMT family transporter',
  849217,
  850128,
  1,
  'KQR59_RS04145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692730.1',
  'pilin',
  850298,
  850660,
  1,
  'KQR59_RS04150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692732.1',
  'hypothetical protein',
  850678,
  851379,
  1,
  'KQR59_RS04155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368142.1',
  'hypothetical protein',
  851372,
  851581,
  -1,
  'KQR59_RS04160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421259.1',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein',
  851792,
  852154,
  1,
  'KQR59_RS04165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421260.1',
  'hypothetical protein',
  852178,
  852798,
  1,
  'KQR59_RS04170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465823.1',
  'lysozyme inhibitor LprI family protein',
  852814,
  853104,
  -1,
  'KQR59_RS04175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recF',
  'DNA replication/repair protein RecF',
  853116,
  854165,
  -1,
  'KQR59_RS04180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692736.1',
  'TatD family hydrolase',
  854169,
  854915,
  -1,
  'KQR59_RS04185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glyS',
  'glycine--tRNA ligase subunit beta',
  855037,
  857124,
  1,
  'KQR59_RS04190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692740.1',
  'DUF2237 family protein',
  857194,
  857568,
  1,
  'KQR59_RS04195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421266.1',
  'HAD family hydrolase',
  857629,
  858288,
  -1,
  'KQR59_RS04200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421267.1',
  'multidrug effflux MFS transporter',
  858384,
  859583,
  -1,
  'KQR59_RS04205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692741.1',
  'ribonuclease D',
  859612,
  860706,
  -1,
  'KQR59_RS04210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421269.1',
  'DUF4336 domain-containing protein',
  860703,
  861404,
  -1,
  'KQR59_RS04215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uvrC',
  'excinuclease ABC subunit UvrC',
  861486,
  863324,
  1,
  'KQR59_RS04220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692892.1',
  'phosphatase PAP2 family protein',
  863393,
  864019,
  1,
  'KQR59_RS04225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692743.1',
  'tRNA(5-methylaminomethyl-2-thiouridylate)-methyltransferase',
  864118,
  865164,
  1,
  'KQR59_RS04230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_042518577.1',
  'sulfurtransferase TusA family protein',
  865164,
  865382,
  1,
  'KQR59_RS04235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923253.1',
  'Trm112 family protein',
  865382,
  865570,
  1,
  'KQR59_RS04240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'kdsB',
  '3-deoxy-manno-octulosonate cytidylyltransferase',
  865563,
  866315,
  1,
  'KQR59_RS04245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692745.1',
  'HIT domain-containing protein',
  866308,
  866703,
  1,
  'KQR59_RS04250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368159.1',
  'hypothetical protein',
  866817,
  867794,
  1,
  'KQR59_RS04255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421276.1',
  'outer membrane beta-barrel protein',
  867813,
  868484,
  -1,
  'KQR59_RS04260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'galK',
  'galactokinase',
  868504,
  869667,
  -1,
  'KQR59_RS04265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692749.1',
  'UDP-glucose--hexose-1-phosphateuridylyltransferase',
  869670,
  870695,
  -1,
  'KQR59_RS04270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692751.1',
  'sugar porter family MFS transporter',
  870786,
  872168,
  1,
  'KQR59_RS04275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692753.1',
  'sugar porter family MFS transporter',
  872204,
  873598,
  1,
  'KQR59_RS04280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923244.1',
  'peptidylprolyl isomerase',
  873693,
  873971,
  1,
  'KQR59_RS04285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421280.1',
  'DEAD/DEAH box helicase',
  874037,
  875755,
  1,
  'KQR59_RS04290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421281.1',
  'hypothetical protein',
  875770,
  876210,
  -1,
  'KQR59_RS04295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421282.1',
  'MarR family winged helix-turn-helixtranscriptional regulator',
  876297,
  876728,
  1,
  'KQR59_RS04300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gmk',
  'guanylate kinase',
  876894,
  877466,
  1,
  'KQR59_RS04305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nadA',
  'quinolinate synthase NadA',
  877486,
  878511,
  1,
  'KQR59_RS04310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nadC',
  'carboxylating nicotinate-nucleotidediphosphorylase',
  878521,
  879384,
  1,
  'KQR59_RS04315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nadB',
  'L-aspartate oxidase',
  879387,
  880877,
  1,
  'KQR59_RS04320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692758.1',
  'hypothetical protein',
  880874,
  881503,
  -1,
  'KQR59_RS04325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421288.1',
  'chorismate mutase',
  881597,
  881938,
  1,
  'KQR59_RS04330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421480.1',
  'glutathione peroxidase',
  881970,
  882440,
  1,
  'KQR59_RS04335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572879.1',
  'DUF819 family protein',
  882549,
  883655,
  1,
  'KQR59_RS04340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692762.1',
  'dipeptide epimerase',
  883652,
  884722,
  1,
  'KQR59_RS04345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692764.1',
  'alpha/beta fold hydrolase',
  884738,
  885391,
  1,
  'KQR59_RS04350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421292.1',
  'hypothetical protein',
  885403,
  885591,
  -1,
  'KQR59_RS04355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692766.1',
  'hypothetical protein',
  885804,
  886178,
  1,
  'KQR59_RS04360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692768.1',
  'NAD(P)H-hydrate dehydratase',
  886266,
  887726,
  1,
  'KQR59_RS04365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572881.1',
  'dienelactone hydrolase family protein',
  887707,
  888438,
  -1,
  'KQR59_RS04370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692772.1',
  'ApeL family LolA-like protein',
  888508,
  889083,
  -1,
  'KQR59_RS04375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572883.1',
  'radical SAM protein',
  889499,
  889945,
  1,
  'KQR59_RS09505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572885.1',
  'SPASM domain-containing protein',
  889942,
  890580,
  1,
  'KQR59_RS09510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692774.1',
  'linear amide C-N hydrolase',
  890620,
  891735,
  -1,
  'KQR59_RS04385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692777.1',
  'glutaredoxin domain-containing protein',
  891814,
  892065,
  1,
  'KQR59_RS04390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421300.1',
  'acyl-CoA thioesterase',
  892062,
  892511,
  1,
  'KQR59_RS04395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150463979.1',
  'hypothetical protein',
  892527,
  892880,
  -1,
  'KQR59_RS04400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692779.1',
  'TrmH family RNA methyltransferase',
  892908,
  893666,
  -1,
  'KQR59_RS04405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692781.1',
  'BCCT family transporter',
  893805,
  895751,
  1,
  'KQR59_RS04410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_343213199.1',
  'TspO/MBR family protein',
  895744,
  896151,
  -1,
  'KQR59_RS04415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692784.1',
  'bifunctional methionine sulfoxide reductase B/Aprotein',
  896351,
  897205,
  1,
  'KQR59_RS04420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923217.1',
  'multidrug effflux MFS transporter',
  897202,
  898410,
  -1,
  'KQR59_RS04425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692786.1',
  'DsbA family protein',
  898524,
  899666,
  -1,
  'KQR59_RS04430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368185.1',
  'FKBP-type peptidyl-prolyl cis-trans isomeraseN-terminal domain-containing protein',
  899685,
  899975,
  -1,
  'KQR59_RS04435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'queG',
  'tRNA epoxyqueuosine(34) reductase QueG',
  900041,
  901147,
  -1,
  'KQR59_RS04440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsfS',
  'ribosome silencing factor',
  901150,
  901485,
  -1,
  'KQR59_RS04445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923212.1',
  'hypothetical protein',
  901590,
  901925,
  1,
  'KQR59_RS04450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692790.1',
  'ATP-dependent helicase',
  901940,
  903997,
  1,
  'KQR59_RS04455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923210.1',
  'hypothetical protein',
  903994,
  904437,
  -1,
  'KQR59_RS04460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'alaS',
  'alanine--tRNA ligase',
  904600,
  907197,
  1,
  'KQR59_RS04465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692794.1',
  'TolC family protein',
  907207,
  908589,
  1,
  'KQR59_RS04470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692796.1',
  'M17 family metallopeptidase',
  908592,
  909971,
  1,
  'KQR59_RS04475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tal',
  'transaldolase',
  910061,
  911026,
  1,
  'KQR59_RS04480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421315.1',
  'hypothetical protein',
  911040,
  911525,
  1,
  'KQR59_RS04485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ygfZ',
  'CAF17-like 4Fe-4S cluster assembly/insertionprotein YgfZ',
  911604,
  912350,
  1,
  'KQR59_RS04490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692802.1',
  'UvrD-helicase domain-containing protein',
  912344,
  914359,
  1,
  'KQR59_RS04495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692805.1',
  'phytochelatin synthase family protein',
  914361,
  915101,
  -1,
  'KQR59_RS04500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692807.1',
  'CvfB family protein',
  915290,
  916120,
  1,
  'KQR59_RS04505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsF',
  '30S ribosomal protein S6',
  916255,
  916590,
  1,
  'KQR59_RS04510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsR',
  '30S ribosomal protein S18',
  916606,
  916824,
  1,
  'KQR59_RS04515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplI',
  '50S ribosomal protein L9',
  916843,
  917298,
  1,
  'KQR59_RS04520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaB',
  'replicative DNA helicase',
  917389,
  918783,
  1,
  'KQR59_RS04525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rlmN',
  'dual-specificity RNA methyltransferase RlmN',
  918810,
  919922,
  1,
  'KQR59_RS04530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368197.1',
  'CDC27 family protein',
  919912,
  920802,
  1,
  'KQR59_RS04535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rluB',
  '23S rRNA pseudouridine(2605) synthase RluB',
  920795,
  921610,
  1,
  'KQR59_RS04540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692809.1',
  'chloroquine resistance protein',
  921610,
  922023,
  1,
  'KQR59_RS04545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692811.1',
  'GNAT family N-acetyltransferase',
  922004,
  922450,
  1,
  'KQR59_RS04550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692813.1',
  'PQ-loop domain-containing transporter',
  922636,
  923277,
  1,
  'KQR59_RS04555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692815.1',
  'hypothetical protein',
  923343,
  923780,
  1,
  'KQR59_RS04560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692817.1',
  'polyprenyl synthetase family protein',
  923870,
  924847,
  1,
  'KQR59_RS04565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692819.1',
  'FKBP-type peptidyl-prolyl cis-trans isomerase',
  924851,
  925660,
  -1,
  'KQR59_RS04570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ttcA',
  'tRNA 2-thiocytidine(32) synthetase TtcA',
  925674,
  926474,
  -1,
  'KQR59_RS04575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421329.1',
  'acyl-CoA thioesterase',
  926461,
  926883,
  -1,
  'KQR59_RS04580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421330.1',
  'transglycosylase SLT domain-containing protein',
  926893,
  927504,
  -1,
  'KQR59_RS04585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dacB',
  'D-alanyl-D-alaninecarboxypeptidase/D-alanyl-D-alanine endopeptidase',
  927504,
  928907,
  -1,
  'KQR59_RS04590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  929158,
  929355,
  1,
  'KQR59_RS04595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368207.1',
  'GatB/YqeY domain-containing protein',
  929418,
  929864,
  1,
  'KQR59_RS04600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaG',
  'DNA primase',
  929883,
  931703,
  1,
  'KQR59_RS04605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpoD',
  'RNA polymerase sigma factor RpoD',
  931728,
  933461,
  1,
  'KQR59_RS04610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692823.1',
  'DUF3568 family protein',
  933552,
  933947,
  1,
  'KQR59_RS04615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lipB',
  'lipoyl(octanoyl) transferase LipB',
  933968,
  934585,
  -1,
  'KQR59_RS04620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923177.1',
  'HP0495 family protein',
  934599,
  934883,
  -1,
  'KQR59_RS04625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692827.1',
  'D-alanyl-D-alanine carboxypeptidase familyprotein',
  934906,
  936240,
  -1,
  'KQR59_RS04630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ppa',
  'inorganic diphosphatase',
  936398,
  936919,
  1,
  'KQR59_RS04635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_425513937.1',
  'KdsC family phosphatase',
  937006,
  937545,
  1,
  'KQR59_RS04640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lptC',
  'LPS export ABC transporter periplasmic proteinLptC',
  937554,
  938186,
  1,
  'KQR59_RS04645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368215.1',
  'LptA/OstA family protein',
  938173,
  939048,
  1,
  'KQR59_RS04650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lptB',
  'LPS export ABC transporter ATP-binding protein',
  939069,
  939800,
  1,
  'KQR59_RS04655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692830.1',
  'fumarylacetoacetate hydrolase family protein',
  939830,
  940426,
  1,
  'KQR59_RS04660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692832.1',
  'alpha/beta hydrolase fold domain-containingprotein',
  940434,
  942266,
  1,
  'KQR59_RS04665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'truA',
  'tRNA pseudouridine(38-40) synthase TruA',
  942269,
  943045,
  1,
  'KQR59_RS04670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'guaA',
  'glutamine-hydrolyzing GMP synthase',
  943179,
  944729,
  1,
  'KQR59_RS04675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dxs',
  '1-deoxy-D-xylulose-5-phosphate synthase',
  944812,
  946668,
  1,
  'KQR59_RS04680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692836.1',
  'arylesterase',
  946772,
  947395,
  1,
  'KQR59_RS04685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_179951665.1',
  'CBS domain-containing protein',
  947408,
  947998,
  -1,
  'KQR59_RS04690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ruvB',
  'Holliday junction branch migration DNA helicaseRuvB',
  948212,
  949258,
  1,
  'KQR59_RS04695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572888.1',
  'glucosaminidase domain-containing protein',
  949274,
  950029,
  -1,
  'KQR59_RS04700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368222.1',
  'helix-turn-helix domain-containing protein',
  950116,
  950319,
  -1,
  'KQR59_RS04705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692838.1',
  'DUF2975 domain-containing protein',
  950330,
  950866,
  -1,
  'KQR59_RS04710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692839.1',
  'retroviral-like aspartic protease familyprotein',
  950995,
  951936,
  1,
  'KQR59_RS04715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692840.1',
  'hypothetical protein',
  951956,
  953410,
  -1,
  'KQR59_RS04720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692841.1',
  'MFS transporter',
  953676,
  954944,
  -1,
  'KQR59_RS04725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368226.1',
  'inositol oxygenase family protein',
  955013,
  955990,
  -1,
  'KQR59_RS04730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692843.1',
  'sugar porter family MFS transporter',
  956005,
  957396,
  -1,
  'KQR59_RS04735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uxaC',
  'glucuronate isomerase',
  957401,
  958816,
  -1,
  'KQR59_RS04740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'eda',
  'bifunctional 4-hydroxy-2-oxoglutaratealdolase/2-dehydro-3-deoxy-phosphogluconate aldolase',
  958828,
  959376,
  -1,
  'KQR59_RS04745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692849.1',
  'sugar kinase',
  959363,
  960328,
  -1,
  'KQR59_RS04750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uxuA',
  'mannonate dehydratase',
  960315,
  961505,
  -1,
  'KQR59_RS04755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692853.1',
  'mannitol dehydrogenase family protein',
  961507,
  962979,
  -1,
  'KQR59_RS04760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692855.1',
  'glycoside hydrolase family 31 protein',
  962972,
  965302,
  -1,
  'KQR59_RS04765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572890.1',
  'MFS transporter',
  965314,
  966879,
  -1,
  'KQR59_RS04770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421361.1',
  'peptide MFS transporter',
  966983,
  968458,
  1,
  'KQR59_RS04775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692857.1',
  'DMT family transporter',
  968482,
  969375,
  1,
  'KQR59_RS04780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pheS',
  'phenylalanine--tRNA ligase subunit alpha',
  969461,
  970474,
  1,
  'KQR59_RS04785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pheT',
  'phenylalanine--tRNA ligase subunit beta',
  970497,
  972866,
  1,
  'KQR59_RS04790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691665.1',
  'sulfite exporter TauE/SafE family protein',
  972915,
  973727,
  1,
  'KQR59_RS04795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691666.1',
  'fumarylacetoacetate hydrolase family protein',
  973728,
  974597,
  -1,
  'KQR59_RS04800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923137.1',
  'Fur family transcriptional regulator',
  974694,
  975122,
  -1,
  'KQR59_RS04805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691667.1',
  'GTP-binding protein',
  975259,
  976476,
  1,
  'KQR59_RS04810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691668.1',
  'ZIP family metal transporter',
  976479,
  977225,
  1,
  'KQR59_RS04815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691669.1',
  'HAD family hydrolase',
  977247,
  978233,
  -1,
  'KQR59_RS04820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cls',
  'cardiolipin synthase',
  978383,
  979813,
  -1,
  'KQR59_RS04825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cls',
  'cardiolipin synthase',
  979879,
  981309,
  -1,
  'KQR59_RS04830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691672.1',
  'MFS transporter',
  981363,
  982598,
  -1,
  'KQR59_RS04835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368247.1',
  'Mrp/NBP35 family ATP-binding protein',
  982662,
  983522,
  1,
  'KQR59_RS04840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dcd',
  'dCTP deaminase',
  983539,
  984105,
  1,
  'KQR59_RS04845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691673.1',
  'hypothetical protein',
  984122,
  984589,
  -1,
  'KQR59_RS04850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691674.1',
  'mechanosensitive ion channel family protein',
  984775,
  985974,
  -1,
  'KQR59_RS04855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691675.1',
  'LPS-assembly lipoprotein LptE',
  985997,
  986548,
  -1,
  'KQR59_RS04860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'leuS',
  'leucine--tRNA ligase',
  986558,
  988999,
  -1,
  'KQR59_RS04865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ruvX',
  'Holliday junction resolvase RuvX',
  989146,
  989556,
  -1,
  'KQR59_RS04870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923124.1',
  'YqgE/AlgH family protein',
  989556,
  990137,
  -1,
  'KQR59_RS04875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691677.1',
  '(deoxy)nucleoside triphosphatepyrophosphohydrolase',
  990174,
  990584,
  1,
  'KQR59_RS04880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572798.1',
  'hypothetical protein',
  990695,
  991129,
  -1,
  'KQR59_RS04885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691678.1',
  'PAS domain-containing protein',
  991164,
  992144,
  -1,
  'KQR59_RS04890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691679.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  992145,
  993380,
  -1,
  'KQR59_RS04895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691680.1',
  'DUF3293 domain-containing protein',
  993562,
  993981,
  -1,
  'KQR59_RS04900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trxA',
  'thioredoxin',
  993974,
  994300,
  -1,
  'KQR59_RS04905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691681.1',
  'hypothetical protein',
  994302,
  994988,
  -1,
  'KQR59_RS04910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sufD',
  'Fe-S cluster assembly protein SufD',
  995080,
  996225,
  -1,
  'KQR59_RS04915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sufC',
  'Fe-S cluster assembly ATPase SufC',
  996238,
  996987,
  -1,
  'KQR59_RS04920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sufB',
  'Fe-S cluster assembly protein SufB',
  997022,
  998467,
  -1,
  'KQR59_RS04925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923114.1',
  'SUF system Fe-S cluster assembly regulator',
  998471,
  998881,
  -1,
  'KQR59_RS04930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trkA',
  'Trk system potassium transporter TrkA',
  999034,
  1000407,
  1,
  'KQR59_RS04935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691684.1',
  'APC family permease',
  1000475,
  1001893,
  1,
  'KQR59_RS04940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691685.1',
  'LysO family transporter',
  1001893,
  1002819,
  1,
  'KQR59_RS04945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'infA',
  'translation initiation factor IF-1',
  1002861,
  1003079,
  -1,
  'KQR59_RS04950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691686.1',
  'sulfite exporter TauE/SafE family protein',
  1003233,
  1004078,
  1,
  'KQR59_RS04955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923109.1',
  'DUF1634 domain-containing protein',
  1004075,
  1004341,
  1,
  'KQR59_RS04960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ffh',
  'signal recognition particle protein',
  1004422,
  1005798,
  1,
  'KQR59_RS04965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368261.1',
  '3-deoxy-7-phosphoheptulonate synthase',
  1005826,
  1006938,
  1,
  'KQR59_RS04970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691687.1',
  'Bor/Iss family lipoprotein',
  1006957,
  1007277,
  1,
  'KQR59_RS04975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368263.1',
  'Bor/Iss family lipoprotein',
  1007283,
  1007573,
  1,
  'KQR59_RS04980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_281417391.1',
  'hypothetical protein',
  1007682,
  1007816,
  1,
  'KQR59_RS09560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692901.1',
  'type 1 glutamine amidotransferasedomain-containing protein',
  1007837,
  1008502,
  -1,
  'KQR59_RS04985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691688.1',
  'NAD(P)H-dependent oxidoreductase',
  1008527,
  1009111,
  -1,
  'KQR59_RS04990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691689.1',
  'M14 family zinc carboxypeptidase',
  1009130,
  1010230,
  -1,
  'KQR59_RS04995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS04995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691690.1',
  'exodeoxyribonuclease III',
  1010400,
  1011188,
  1,
  'KQR59_RS05000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421400.1',
  'SDR family oxidoreductase',
  1011209,
  1011916,
  1,
  'KQR59_RS05005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691691.1',
  'P-loop nucleotide/nucleoside kinase familyprotein',
  1011919,
  1012422,
  1,
  'KQR59_RS05010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691692.1',
  '2''-5'' RNA ligase family protein',
  1012422,
  1013141,
  1,
  'KQR59_RS05015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gorA',
  'glutathione-disulfide reductase',
  1013177,
  1014535,
  1,
  'KQR59_RS05020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368270.1',
  'YbjQ family protein',
  1014545,
  1014865,
  1,
  'KQR59_RS05025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691694.1',
  'oligopeptide:H+ symporter',
  1015014,
  1016549,
  1,
  'KQR59_RS05030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692903.1',
  'DEAD/DEAH box helicase',
  1016550,
  1017887,
  -1,
  'KQR59_RS05035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'folE',
  'GTP cyclohydrolase I FolE',
  1018019,
  1018639,
  1,
  'KQR59_RS05040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691696.1',
  'YdcF family protein',
  1018647,
  1019345,
  1,
  'KQR59_RS05045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691697.1',
  'antibiotic biosynthesis monooxygenase familyprotein',
  1019432,
  1019851,
  1,
  'KQR59_RS05050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691698.1',
  'nitrilase-related carbon-nitrogen hydrolase',
  1019903,
  1020832,
  1,
  'KQR59_RS05055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691699.1',
  'aldo/keto reductase',
  1020903,
  1021967,
  1,
  'KQR59_RS05060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691700.1',
  'aldo/keto reductase',
  1022042,
  1023115,
  1,
  'KQR59_RS05065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691701.1',
  'MFS transporter',
  1023185,
  1024345,
  1,
  'KQR59_RS05070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465483.1',
  'anthranilate synthase component II',
  1024346,
  1024900,
  -1,
  'KQR59_RS05075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691702.1',
  'bifunctional chorismate-binding protein/class IVaminotransferase',
  1024902,
  1026665,
  -1,
  'KQR59_RS05080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691703.1',
  'class I adenylate-forming enzyme family protein',
  1026658,
  1028028,
  -1,
  'KQR59_RS05085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287809.1',
  'dihydroneopterin aldolase',
  1028109,
  1028462,
  1,
  'KQR59_RS05090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'folP',
  'dihydropteroate synthase',
  1028464,
  1029729,
  1,
  'KQR59_RS05095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bioJ',
  'pimeloyl-ACP methyl ester esterase BioJ',
  1029742,
  1030662,
  1,
  'KQR59_RS05100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_044526149.1',
  'PaaI family thioesterase',
  1030679,
  1031179,
  1,
  'KQR59_RS05105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bioA',
  'adenosylmethionine--8-amino-7-oxononanoatetransaminase',
  1031181,
  1032467,
  -1,
  'KQR59_RS05110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bioB',
  'biotin synthase BioB',
  1032558,
  1033499,
  1,
  'KQR59_RS05115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691707.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  1033493,
  1034611,
  1,
  'KQR59_RS05120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_035735853.1',
  'methyltransferase domain-containing protein',
  1034598,
  1035332,
  1,
  'KQR59_RS05125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bioD',
  'dethiobiotin synthase',
  1035336,
  1036016,
  1,
  'KQR59_RS05130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691709.1',
  'biotin--[acetyl-CoA-carboxylase] ligase',
  1035959,
  1036921,
  -1,
  'KQR59_RS05135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287819.1',
  'ROK family protein',
  1036945,
  1037829,
  -1,
  'KQR59_RS05140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691710.1',
  'sugar MFS transporter',
  1037836,
  1039092,
  -1,
  'KQR59_RS05145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012281083.1',
  'acetoacetate decarboxylase',
  1039361,
  1040101,
  1,
  'KQR59_RS05150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421428.1',
  '3-hydroxybutyrate dehydrogenase',
  1040123,
  1040905,
  1,
  'KQR59_RS05155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691711.1',
  'glycoside hydrolase family 3 protein',
  1040967,
  1042634,
  1,
  'KQR59_RS05160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hmpA',
  'NO-inducible flavohemoprotein',
  1042639,
  1043814,
  -1,
  'KQR59_RS05165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691713.1',
  'Rrf2 family transcriptional regulator',
  1043920,
  1044342,
  1,
  'KQR59_RS05170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691714.1',
  'phospholipid carrier-dependentglycosyltransferase',
  1044352,
  1046049,
  -1,
  'KQR59_RS05175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemL',
  'glutamate-1-semialdehyde 2,1-aminomutase',
  1046059,
  1047360,
  -1,
  'KQR59_RS05180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gshB',
  'glutathione synthase',
  1047350,
  1048324,
  -1,
  'KQR59_RS05185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fmt',
  'methionyl-tRNA formyltransferase',
  1048328,
  1049266,
  -1,
  'KQR59_RS05190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fvfA',
  'Francisella virulence factor A',
  1049269,
  1049661,
  -1,
  'KQR59_RS05195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fvfA',
  'Francisella virulence factor A',
  1049664,
  1050062,
  -1,
  'KQR59_RS05200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691718.1',
  'ArsR/SmtB family transcription factor',
  1050218,
  1050550,
  1,
  'KQR59_RS05205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'arsB',
  'ACR3 family arsenite efflux transporter',
  1050561,
  1051589,
  1,
  'KQR59_RS05210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691720.1',
  'DMT family transporter',
  1051641,
  1051970,
  1,
  'KQR59_RS05215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rlmKL',
  'bifunctional 23S rRNA(guanine(2069)-N(7))-methyltransferase RlmK/23S rRNA(guanine(2445)-N(2))-methyltransferase RlmL',
  1051982,
  1054138,
  -1,
  'KQR59_RS05220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1054257,
  1054333,
  1,
  'KQR59_RS05225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691722.1',
  'type I restriction endonuclease subunit R',
  1055069,
  1058089,
  -1,
  'KQR59_RS05230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691723.1',
  'hypothetical protein',
  1058229,
  1058771,
  -1,
  'KQR59_RS05235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691724.1',
  'DUF3800 domain-containing protein',
  1058772,
  1059482,
  -1,
  'KQR59_RS05240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691725.1',
  'anti-phage dCTP deaminase',
  1059503,
  1061311,
  -1,
  'KQR59_RS05245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691726.1',
  'restriction endonuclease subunit S',
  1061304,
  1062647,
  -1,
  'KQR59_RS05250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691727.1',
  'type I restriction-modification system subunitM',
  1062869,
  1065250,
  -1,
  'KQR59_RS05255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691728.1',
  'antirestriction protein ArdA',
  1065364,
  1065870,
  -1,
  'KQR59_RS05260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691729.1',
  'TriL protein',
  1066420,
  1067142,
  -1,
  'KQR59_RS05265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691730.1',
  'type IV secretion system DNA-bindingdomain-containing protein',
  1067139,
  1069139,
  -1,
  'KQR59_RS05270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691731.1',
  'hypothetical protein',
  1069165,
  1069443,
  -1,
  'KQR59_RS05275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691732.1',
  'helix-turn-helix domain-containing protein',
  1069446,
  1070087,
  -1,
  'KQR59_RS05280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691733.1',
  'hypothetical protein',
  1070286,
  1071233,
  -1,
  'KQR59_RS05285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691734.1',
  'site-specific integrase',
  1071283,
  1072410,
  -1,
  'KQR59_RS05290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287836.1',
  'hypothetical protein',
  1072619,
  1072876,
  -1,
  'KQR59_RS05295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rdgC',
  'recombination-associated protein RdgC',
  1072879,
  1073745,
  -1,
  'KQR59_RS05300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691736.1',
  'hypothetical protein',
  1073817,
  1074326,
  -1,
  'KQR59_RS05305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trhO',
  'oxygen-dependent tRNA uridine(34) hydroxylaseTrhO',
  1074415,
  1075407,
  1,
  'KQR59_RS05310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemF',
  'oxygen-dependent coproporphyrinogen oxidase',
  1075537,
  1076463,
  1,
  'KQR59_RS05315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'serC',
  '3-phosphoserine/phosphohydroxythreoninetransaminase',
  1076546,
  1077598,
  1,
  'KQR59_RS05320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cmk',
  '(d)CMP kinase',
  1077585,
  1078253,
  1,
  'KQR59_RS05325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422109.1',
  'cupin domain-containing protein',
  1078240,
  1078554,
  -1,
  'KQR59_RS05330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691741.1',
  'amidohydrolase family protein',
  1078661,
  1080271,
  1,
  'KQR59_RS05335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691742.1',
  'catalase',
  1080279,
  1081712,
  -1,
  'KQR59_RS05340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691743.1',
  'short chain dehydrogenase',
  1081874,
  1082488,
  -1,
  'KQR59_RS05345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287651.1',
  'peroxiredoxin',
  1082507,
  1083031,
  -1,
  'KQR59_RS05350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'oxyR',
  'oxidative stress transcriptional regulator OxyR',
  1083132,
  1084004,
  1,
  'KQR59_RS05355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691745.1',
  'DUF1338 domain-containing protein',
  1084006,
  1084803,
  -1,
  'KQR59_RS05360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'amaB',
  'L-piperidine-6-carboxylate dehydrogenase',
  1084807,
  1086303,
  -1,
  'KQR59_RS05365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691747.1',
  'saccharopine dehydrogenase family protein',
  1086317,
  1087432,
  -1,
  'KQR59_RS05370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422101.1',
  'COG3014 family protein',
  1087604,
  1089019,
  -1,
  'KQR59_RS05375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691748.1',
  'M15 family metallopeptidase',
  1089016,
  1089480,
  -1,
  'KQR59_RS05380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaQ',
  'DNA polymerase III subunit epsilon',
  1089474,
  1090166,
  -1,
  'KQR59_RS05385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691750.1',
  'hypothetical protein',
  1090214,
  1091716,
  -1,
  'KQR59_RS05390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422099.1',
  'hypothetical protein',
  1091721,
  1091942,
  -1,
  'KQR59_RS05395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691751.1',
  'zinc ribbon domain-containing protein YjdM',
  1091944,
  1092276,
  -1,
  'KQR59_RS05400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422098.1',
  'hypothetical protein',
  1092380,
  1093756,
  -1,
  'KQR59_RS05405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923032.1',
  'peroxiredoxin',
  1093808,
  1094407,
  -1,
  'KQR59_RS05410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422097.1',
  'HAD family hydrolase',
  1094547,
  1095131,
  1,
  'KQR59_RS05415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692905.1',
  'alpha/beta hydrolase family protein',
  1095154,
  1096650,
  1,
  'KQR59_RS05420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691752.1',
  'tRNA threonylcarbamoyladenosine dehydratase',
  1096655,
  1097401,
  1,
  'KQR59_RS05425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691753.1',
  'transglycosylase SLT domain-containing protein',
  1097479,
  1098060,
  1,
  'KQR59_RS05430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'coq7',
  '2-polyprenyl-3-methyl-6-methoxy-1,4-benzoquinonemonooxygenase',
  1098057,
  1098692,
  -1,
  'KQR59_RS05435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691754.1',
  'MFS transporter',
  1098708,
  1099220,
  -1,
  'KQR59_RS05440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mdh',
  'malate dehydrogenase',
  1099370,
  1100329,
  1,
  'KQR59_RS05445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422091.1',
  'ribonucleoside-diphosphate reductase subunitalpha',
  1100548,
  1102320,
  1,
  'KQR59_RS05450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263737.1',
  'glutaredoxin',
  1102324,
  1102584,
  1,
  'KQR59_RS05455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422090.1',
  'ribonucleotide-diphosphate reductase subunitbeta',
  1102591,
  1103823,
  1,
  'KQR59_RS05460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691755.1',
  'serine hydrolase',
  1103947,
  1105101,
  1,
  'KQR59_RS05465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691756.1',
  'MFS transporter',
  1105098,
  1106438,
  1,
  'KQR59_RS05470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691757.1',
  'hypothetical protein',
  1106526,
  1107488,
  1,
  'KQR59_RS05475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691758.1',
  'ABC-F family ATP-binding cassettedomain-containing protein',
  1107548,
  1109446,
  -1,
  'KQR59_RS05480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691759.1',
  'MFS transporter',
  1109523,
  1110314,
  -1,
  'KQR59_RS05485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464319.1',
  'DJ-1/PfpI family protein',
  1110436,
  1111038,
  1,
  'KQR59_RS05490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691760.1',
  'hypothetical protein',
  1111039,
  1112004,
  -1,
  'KQR59_RS05495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dinB',
  'DNA polymerase IV',
  1112091,
  1113140,
  1,
  'KQR59_RS05500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dusB',
  'tRNA dihydrouridine synthase DusB',
  1113132,
  1114109,
  -1,
  'KQR59_RS05505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'prmA',
  '50S ribosomal protein L11 methyltransferase',
  1114099,
  1114944,
  -1,
  'KQR59_RS05510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368374.1',
  'DUF2062 domain-containing protein',
  1115086,
  1115583,
  -1,
  'KQR59_RS05515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923010.1',
  'hypothetical protein',
  1115627,
  1115881,
  -1,
  'KQR59_RS05520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemH',
  'ferrochelatase',
  1116019,
  1117020,
  1,
  'KQR59_RS05525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691764.1',
  'cryptochrome/photolyase family protein',
  1117005,
  1118399,
  1,
  'KQR59_RS05530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'eno',
  'phosphopyruvate hydratase',
  1118483,
  1119757,
  1,
  'KQR59_RS05535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691766.1',
  'aldose epimerase family protein',
  1119779,
  1120777,
  -1,
  'KQR59_RS05540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'coaBC',
  'bifunctional phosphopantothenoylcysteinedecarboxylase/phosphopantothenate--cysteine ligase CoaBC',
  1120758,
  1121933,
  -1,
  'KQR59_RS05545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691767.1',
  'MFS transporter',
  1121946,
  1123130,
  -1,
  'KQR59_RS05550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422073.1',
  'APC family permease',
  1123205,
  1124713,
  -1,
  'KQR59_RS05555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'putA',
  'bifunctional proline dehydrogenase/L-glutamategamma-semialdehyde dehydrogenase PutA',
  1124868,
  1128932,
  -1,
  'KQR59_RS05560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422071.1',
  'FAD assembly factor SdhE',
  1128950,
  1129234,
  -1,
  'KQR59_RS05565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923000.1',
  'hypothetical protein',
  1129451,
  1129834,
  1,
  'KQR59_RS05570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263936.1',
  'hypothetical protein',
  1129897,
  1130121,
  -1,
  'KQR59_RS05575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aroB',
  '3-dehydroquinate synthase',
  1130175,
  1131260,
  -1,
  'KQR59_RS05580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aroK',
  'shikimate kinase AroK',
  1131257,
  1131787,
  -1,
  'KQR59_RS05585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691770.1',
  'type IV pilus secretin PilQ',
  1131913,
  1133667,
  -1,
  'KQR59_RS05590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368385.1',
  'pilus assembly protein PilP',
  1133677,
  1134267,
  -1,
  'KQR59_RS05595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368386.1',
  'type IV pilus inner membrane component PilO',
  1134273,
  1134872,
  -1,
  'KQR59_RS05600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691771.1',
  'PilN domain-containing protein',
  1134866,
  1135429,
  -1,
  'KQR59_RS05605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691772.1',
  'type IV pili',
  1135432,
  1136436,
  -1,
  'KQR59_RS05610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'adk',
  'adenylate kinase',
  1136565,
  1137215,
  1,
  'KQR59_RS05615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691774.1',
  'FAD-binding and (Fe-S)-binding domain-containingprotein',
  1137220,
  1139943,
  -1,
  'KQR59_RS05620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691775.1',
  'hypothetical protein',
  1140005,
  1140421,
  -1,
  'KQR59_RS05625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'era',
  'GTPase Era',
  1140434,
  1141327,
  -1,
  'KQR59_RS05630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691776.1',
  'hypothetical protein',
  1141500,
  1141829,
  1,
  'KQR59_RS05635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dsbD',
  'protein-disulfide reductase DsbD',
  1141916,
  1143790,
  1,
  'KQR59_RS05640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464987.1',
  'pyridoxal phosphate-dependent aminotransferase',
  1143942,
  1145129,
  -1,
  'KQR59_RS05645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691778.1',
  'class II glutamine amidotransferase',
  1145139,
  1145945,
  -1,
  'KQR59_RS05650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tsaB',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexdimerization subunit type 1 TsaB',
  1145950,
  1146588,
  -1,
  'KQR59_RS05655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ylqF',
  'ribosome biogenesis GTPase YlqF',
  1146753,
  1147622,
  1,
  'KQR59_RS05660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691781.1',
  'SEL1-like repeat protein',
  1147690,
  1149435,
  1,
  'KQR59_RS05665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922981.1',
  'thymidine kinase',
  1149449,
  1150042,
  -1,
  'KQR59_RS05670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922980.1',
  'HAD family acid phosphatase',
  1150058,
  1150801,
  -1,
  'KQR59_RS05675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691782.1',
  'O-methyltransferase',
  1150812,
  1151444,
  -1,
  'KQR59_RS05680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'miaB',
  'tRNA (N6-isopentenyladenosine(37)-C2)-methylthiotransferase MiaB',
  1151630,
  1152958,
  1,
  'KQR59_RS05685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691783.1',
  'PhoH family protein',
  1152962,
  1153945,
  1,
  'KQR59_RS05690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ybeY',
  'rRNA maturation RNase YbeY',
  1153938,
  1154429,
  1,
  'KQR59_RS05695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922975.1',
  'CorC family transporter',
  1154416,
  1155258,
  1,
  'KQR59_RS05700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lnt',
  'apolipoprotein N-acyltransferase',
  1155258,
  1156751,
  1,
  'KQR59_RS05705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bla',
  'class A beta-lactamase',
  1156907,
  1157776,
  1,
  'KQR59_RS05710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691786.1',
  'DNA/RNA non-specific endonuclease',
  1157767,
  1158819,
  -1,
  'KQR59_RS05715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691787.1',
  'aminopeptidase P family protein',
  1158905,
  1160692,
  -1,
  'KQR59_RS05720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pgeF',
  'peptidoglycan editing factor PgeF',
  1160719,
  1161426,
  -1,
  'KQR59_RS05725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ispG',
  'flavodoxin-dependent(E)-4-hydroxy-3-methylbut-2-enyl-diphosphate synthase',
  1161441,
  1162646,
  -1,
  'KQR59_RS05730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691790.1',
  'Nif3-like dinuclear metal center hexamericprotein',
  1162744,
  1163490,
  1,
  'KQR59_RS05735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  'family 20 glycosylhydrolase',
  1163743,
  1165944,
  -1,
  'KQR59_RS05740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422041.1',
  'sugar porter family MFS transporter',
  1166060,
  1167436,
  -1,
  'KQR59_RS05745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422040.1',
  'SIS domain-containing protein',
  1167478,
  1168509,
  -1,
  'KQR59_RS05750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691792.1',
  'dicarboxylate/amino acid:cation symporter',
  1168707,
  1169978,
  1,
  'KQR59_RS05755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691793.1',
  'protein adenylyltransferase SelO',
  1169983,
  1171374,
  -1,
  'KQR59_RS05760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691794.1',
  'PIN domain-containing protein',
  1171484,
  1172101,
  1,
  'KQR59_RS05765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012279604.1',
  'rubredoxin',
  1172189,
  1172359,
  1,
  'KQR59_RS05770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691795.1',
  '1-aminocyclopropane-1-carboxylate deaminase',
  1172368,
  1173240,
  1,
  'KQR59_RS05775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692906.1',
  'hypothetical protein',
  1173245,
  1174801,
  -1,
  'KQR59_RS05780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'typA',
  'translational GTPase TypA',
  1174996,
  1176813,
  1,
  'KQR59_RS05785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691797.1',
  'SDR family oxidoreductase',
  1176917,
  1177729,
  1,
  'KQR59_RS05790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691798.1',
  'alcohol dehydrogenase catalyticdomain-containing protein',
  1177748,
  1178734,
  1,
  'KQR59_RS05795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ggt',
  'gamma-glutamyltransferase',
  1178731,
  1180452,
  -1,
  'KQR59_RS05800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691800.1',
  'MlaA family lipoprotein',
  1180595,
  1181512,
  -1,
  'KQR59_RS05805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mnmC1',
  'FAD-dependent5-carboxymethylaminomethyl-2-thiouridine(34)oxidoreductase MnmC1',
  1181589,
  1182797,
  -1,
  'KQR59_RS05810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691802.1',
  'RnfH family protein',
  1182787,
  1183092,
  -1,
  'KQR59_RS05815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922948.1',
  'type II toxin-antitoxin system RatA familytoxin',
  1183092,
  1183523,
  -1,
  'KQR59_RS05820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'smpB',
  'SsrA-binding protein SmpB',
  1183598,
  1184071,
  1,
  'KQR59_RS05825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ttcA',
  'tRNA 2-thiocytidine(32) synthetase TtcA',
  1184073,
  1184843,
  1,
  'KQR59_RS05830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691804.1',
  'ribonuclease T2 family protein',
  1185167,
  1186171,
  -1,
  'KQR59_RS05835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisIE',
  'bifunctional phosphoribosyl-AMPcyclohydrolase/phosphoribosyl-ATP diphosphatase HisIE',
  1186212,
  1186835,
  -1,
  'KQR59_RS05840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisF',
  'imidazole glycerol phosphate synthase subunitHisF',
  1186844,
  1187617,
  -1,
  'KQR59_RS05845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisA',
  '1-(5-phosphoribosyl)-5-[(5-phosphoribosylamino)methylideneamino]imidazole-4-carboxamide isomerase',
  1187611,
  1188336,
  -1,
  'KQR59_RS05850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisH',
  'imidazole glycerol phosphate synthase subunitHisH',
  1188337,
  1188933,
  -1,
  'KQR59_RS05855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisB',
  'bifunctionalhistidinol-phosphatase/imidazoleglycerol-phosphatedehydratase HisB',
  1188930,
  1190006,
  -1,
  'KQR59_RS05860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisC',
  'histidinol-phosphate transaminase',
  1189993,
  1191078,
  -1,
  'KQR59_RS05865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisD',
  'histidinol dehydrogenase',
  1191083,
  1192381,
  -1,
  'KQR59_RS05870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisG',
  'ATP phosphoribosyltransferase',
  1192391,
  1193281,
  -1,
  'KQR59_RS05875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922936.1',
  'YerC/YecD family TrpR-related protein',
  1193283,
  1193579,
  -1,
  'KQR59_RS05880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691811.1',
  'MFS transporter',
  1193709,
  1194980,
  -1,
  'KQR59_RS05885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572808.1',
  'ElyC/SanA/YdcF family protein',
  1195088,
  1196146,
  1,
  'KQR59_RS05890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691812.1',
  'YdcF family protein',
  1196219,
  1197292,
  1,
  'KQR59_RS05895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'xseB',
  'exodeoxyribonuclease VII small subunit',
  1197289,
  1197492,
  -1,
  'KQR59_RS05900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'xseA',
  'exodeoxyribonuclease VII large subunit',
  1197476,
  1198861,
  -1,
  'KQR59_RS05905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572810.1',
  'hypothetical protein',
  1198962,
  1200185,
  -1,
  'KQR59_RS05910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691815.1',
  'GNAT family N-acetyltransferase',
  1200391,
  1200927,
  1,
  'KQR59_RS05915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691816.1',
  'class II glutamine amidotransferase',
  1200936,
  1202687,
  -1,
  'KQR59_RS05920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_232215367.1',
  'alpha-E domain-containing protein',
  1202710,
  1203630,
  -1,
  'KQR59_RS05925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422014.1',
  'circularly permuted type 2 ATP-grasp protein',
  1203690,
  1205147,
  -1,
  'KQR59_RS05930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422013.1',
  'hypothetical protein',
  1205314,
  1206501,
  -1,
  'KQR59_RS05935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422012.1',
  'hypothetical protein',
  1206591,
  1207778,
  -1,
  'KQR59_RS05940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146422011.1',
  'MFS transporter',
  1207892,
  1209139,
  -1,
  'KQR59_RS05945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922922.1',
  'MFS transporter',
  1209152,
  1210429,
  -1,
  'KQR59_RS05950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691817.1',
  'HesA/MoeB/ThiF family protein',
  1210519,
  1211274,
  -1,
  'KQR59_RS05955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thiD',
  'bifunctional hydroxymethylpyrimidinekinase/phosphomethylpyrimidine kinase',
  1211275,
  1212732,
  -1,
  'KQR59_RS05960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691819.1',
  'thiazole synthase',
  1212744,
  1213523,
  -1,
  'KQR59_RS05965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thiS',
  'sulfur carrier protein ThiS',
  1213527,
  1213727,
  -1,
  'KQR59_RS05970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691820.1',
  'FAD-dependent oxidoreductase',
  1213730,
  1214782,
  -1,
  'KQR59_RS05975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thiC',
  'phosphomethylpyrimidine synthase ThiC',
  1214775,
  1216553,
  -1,
  'KQR59_RS05980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murI',
  'glutamate racemase',
  1216806,
  1217603,
  -1,
  'KQR59_RS05985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922914.1',
  'nuclease-related domain-containing protein',
  1217603,
  1218400,
  -1,
  'KQR59_RS05990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uvrB',
  'excinuclease ABC subunit UvrB',
  1218433,
  1220445,
  -1,
  'KQR59_RS05995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS05995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691824.1',
  'hypothetical protein',
  1220524,
  1220958,
  -1,
  'KQR59_RS06000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691825.1',
  'exodeoxyribonuclease I',
  1221055,
  1222503,
  -1,
  'KQR59_RS06005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421999.1',
  'SDR family oxidoreductase',
  1222654,
  1223376,
  -1,
  'KQR59_RS06010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691826.1',
  'LysR family transcriptional regulator',
  1223492,
  1224400,
  1,
  'KQR59_RS06015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421997.1',
  'FUSC family protein',
  1224402,
  1225295,
  -1,
  'KQR59_RS06020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465595.1',
  'hypothetical protein',
  1225282,
  1226361,
  -1,
  'KQR59_RS06025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mnmG',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis enzyme MnmG',
  1226503,
  1228386,
  1,
  'KQR59_RS06030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691828.1',
  'hypothetical protein',
  1228398,
  1228787,
  1,
  'KQR59_RS06035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691829.1',
  'hypothetical protein',
  1228807,
  1230177,
  1,
  'KQR59_RS06040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpiA',
  'ribose-5-phosphate isomerase RpiA',
  1230179,
  1230853,
  1,
  'KQR59_RS06045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922901.1',
  'hypothetical protein',
  1230900,
  1231703,
  1,
  'KQR59_RS06050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691831.1',
  'TVP38/TMEM64 family protein',
  1231726,
  1232427,
  -1,
  'KQR59_RS06055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplT',
  '50S ribosomal protein L20',
  1232466,
  1232822,
  -1,
  'KQR59_RS06060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmI',
  '50S ribosomal protein L35',
  1232858,
  1233055,
  -1,
  'KQR59_RS06065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'infC',
  'translation initiation factor IF-3',
  1233097,
  1233633,
  -1,
  'KQR59_RS06070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'thrS',
  'threonine--tRNA ligase',
  1233640,
  1235547,
  -1,
  'KQR59_RS06075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691833.1',
  'lytic polysaccharide monooxygenase',
  1235988,
  1237775,
  1,
  'KQR59_RS06080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263714.1',
  'hypothetical protein',
  1237829,
  1238125,
  -1,
  'KQR59_RS06085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gcvH',
  'glycine cleavage system protein GcvH',
  1238115,
  1238495,
  -1,
  'KQR59_RS06090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murG',
  'undecaprenyldiphospho-muramoylpentapeptidebeta-N-acetylglucosaminyltransferase',
  1238601,
  1239716,
  1,
  'KQR59_RS06095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421985.1',
  'YbaB/EbfC family nucleoid-associated protein',
  1239726,
  1240061,
  1,
  'KQR59_RS06100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recR',
  'recombination mediator RecR',
  1240061,
  1240663,
  1,
  'KQR59_RS06105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691835.1',
  'RelA/SpoT family protein',
  1240671,
  1242785,
  -1,
  'KQR59_RS06110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pgsW',
  'poly-gamma-glutamate system protein',
  1242856,
  1244058,
  -1,
  'KQR59_RS06115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pgsC',
  'poly-gamma-glutamate biosynthesis protein PgsC',
  1244060,
  1244524,
  -1,
  'KQR59_RS06120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pgsB',
  'poly-gamma-glutamate synthase PgsB',
  1244550,
  1245758,
  -1,
  'KQR59_RS06125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464406.1',
  'MFS transporter',
  1245850,
  1247106,
  -1,
  'KQR59_RS06130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1247227,
  1247309,
  -1,
  'KQR59_RS06135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1247317,
  1247392,
  -1,
  'KQR59_RS06140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1247421,
  1247497,
  -1,
  'KQR59_RS06145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1247507,
  1247583,
  -1,
  'KQR59_RS06150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1247599,
  1247674,
  -1,
  'KQR59_RS06155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691837.1',
  'isoaspartyl peptidase/L-asparaginase',
  1247734,
  1248594,
  -1,
  'KQR59_RS06160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421981.1',
  'cyanophycinase',
  1248729,
  1249547,
  -1,
  'KQR59_RS06165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368466.1',
  'carbohydrate kinase family protein',
  1249752,
  1250858,
  1,
  'KQR59_RS06170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691838.1',
  'pyrimidine 5''-nucleotidase',
  1251070,
  1251732,
  -1,
  'KQR59_RS06175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691839.1',
  'glycosyltransferase family 4 protein',
  1251751,
  1252764,
  -1,
  'KQR59_RS06180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421977.1',
  'glycosyltransferase',
  1252783,
  1253847,
  -1,
  'KQR59_RS06185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421976.1',
  'nucleotide sugar dehydrogenase',
  1253858,
  1255021,
  -1,
  'KQR59_RS06190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421975.1',
  'glycosyltransferase family 2 protein',
  1255018,
  1255938,
  -1,
  'KQR59_RS06195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691840.1',
  'glycosyltransferase family 2 protein',
  1255946,
  1256911,
  -1,
  'KQR59_RS06200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691841.1',
  'glycosyltransferase family 2 protein',
  1256912,
  1257706,
  -1,
  'KQR59_RS06205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691842.1',
  'CatB-related O-acetyltransferase',
  1257736,
  1258395,
  -1,
  'KQR59_RS09595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421971.1',
  'motility associated factor glycosyltransferasefamily protein',
  1258392,
  1259267,
  -1,
  'KQR59_RS06215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421970.1',
  'acylneuraminate cytidylyltransferase',
  1259311,
  1260459,
  -1,
  'KQR59_RS06220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421969.1',
  'N-acetylneuraminate synthase family protein',
  1260466,
  1261347,
  -1,
  'KQR59_RS06225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691843.1',
  'ABC transporter ATP-binding protein',
  1261362,
  1263065,
  -1,
  'KQR59_RS06230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421967.1',
  'glycosyltransferase family 4 protein',
  1263062,
  1264180,
  -1,
  'KQR59_RS06235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'galE',
  'UDP-glucose 4-epimerase GalE',
  1264184,
  1265203,
  -1,
  'KQR59_RS06240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691845.1',
  'sugar transferase',
  1265196,
  1266590,
  -1,
  'KQR59_RS06245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpe',
  'ribulose-phosphate 3-epimerase',
  1266571,
  1267239,
  -1,
  'KQR59_RS06250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691847.1',
  'KpsF/GutQ family sugar-phosphate isomerase',
  1267374,
  1268336,
  1,
  'KQR59_RS06255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287493.1',
  'HvfX family Cu-binding RiPP maturation protein',
  1268339,
  1268926,
  -1,
  'KQR59_RS06260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691848.1',
  'HvfC/BufC family peptide modification chaperone',
  1268937,
  1269635,
  -1,
  'KQR59_RS06265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691849.1',
  'MbnB/TglH/ChrH family RiPP precursormodification enzyme',
  1269632,
  1270444,
  -1,
  'KQR59_RS06270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368490.1',
  'hypothetical protein',
  1270441,
  1270779,
  -1,
  'KQR59_RS06275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691850.1',
  'MBL fold metallo-hydrolase',
  1270791,
  1271753,
  -1,
  'KQR59_RS06280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922865.1',
  'enoyl-ACP reductase FabI',
  1271903,
  1272685,
  -1,
  'KQR59_RS06285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922864.1',
  'LOG family protein',
  1272837,
  1273550,
  1,
  'KQR59_RS06290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691851.1',
  'hypothetical protein',
  1273562,
  1273807,
  1,
  'KQR59_RS06295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691852.1',
  'class I SAM-dependent methyltransferase',
  1273816,
  1274577,
  1,
  'KQR59_RS06300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922861.1',
  'hypothetical protein',
  1274578,
  1275150,
  -1,
  'KQR59_RS06305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gloA',
  'lactoylglutathione lyase',
  1275150,
  1275527,
  -1,
  'KQR59_RS06310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464432.1',
  'queuosine precursor transporter',
  1275642,
  1276355,
  1,
  'KQR59_RS06315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691853.1',
  'sulfite exporter TauE/SafE family protein',
  1276342,
  1277160,
  -1,
  'KQR59_RS06320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691854.1',
  'hypothetical protein',
  1277231,
  1277896,
  -1,
  'KQR59_RS06325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691855.1',
  'hypothetical protein',
  1277899,
  1278615,
  -1,
  'KQR59_RS06330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922854.1',
  'Cof-type HAD-IIB family hydrolase',
  1278678,
  1279463,
  -1,
  'KQR59_RS06335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691856.1',
  'hypothetical protein',
  1279577,
  1279780,
  -1,
  'KQR59_RS06340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'queA',
  'tRNA preQ1(34) S-adenosylmethionineribosyltransferase-isomerase QueA',
  1279800,
  1280816,
  -1,
  'KQR59_RS06345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691858.1',
  'DEAD/DEAH box helicase',
  1280948,
  1282036,
  1,
  'KQR59_RS06350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691859.1',
  'acid phosphatase',
  1282236,
  1282937,
  1,
  'KQR59_RS06355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691860.1',
  'FAD-dependent oxidoreductase',
  1282940,
  1284121,
  -1,
  'KQR59_RS06360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691861.1',
  'FAD-dependent monooxygenase',
  1284111,
  1285322,
  -1,
  'KQR59_RS06365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691862.1',
  'UPF0149 family protein',
  1285331,
  1285867,
  -1,
  'KQR59_RS06370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ssrS',
  '—',
  1286093,
  1286287,
  1,
  'KQR59_RS06375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922846.1',
  '5-formyltetrahydrofolate cyclo-ligase',
  1286307,
  1286855,
  1,
  'KQR59_RS06380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368504.1',
  'BolA/IbaG family iron-sulfur metabolism protein',
  1286859,
  1287125,
  1,
  'KQR59_RS06385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421946.1',
  'VTT domain-containing protein',
  1287130,
  1287756,
  1,
  'KQR59_RS06390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263707.1',
  'VTT domain-containing protein',
  1287813,
  1288463,
  1,
  'KQR59_RS06395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recO',
  'DNA repair protein RecO',
  1288473,
  1289174,
  -1,
  'KQR59_RS06400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368506.1',
  'hypothetical protein',
  1289158,
  1289487,
  -1,
  'KQR59_RS06405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691864.1',
  'cysteine desulfurase family protein',
  1289480,
  1290655,
  -1,
  'KQR59_RS06410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691865.1',
  'Rne/Rng family ribonuclease',
  1290908,
  1293583,
  1,
  'KQR59_RS06415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lgt',
  'prolipoprotein diacylglyceryl transferase',
  1293605,
  1294411,
  1,
  'KQR59_RS06420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421941.1',
  'thymidylate synthase',
  1294396,
  1295220,
  1,
  'KQR59_RS06425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'serA',
  'phosphoglycerate dehydrogenase',
  1295233,
  1296468,
  1,
  'KQR59_RS06430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tilS',
  'tRNA lysidine(34) synthetase TilS',
  1296469,
  1297668,
  1,
  'KQR59_RS06435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421938.1',
  'peptide MFS transporter',
  1297674,
  1299113,
  -1,
  'KQR59_RS06440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691868.1',
  'linear amide C-N hydrolase',
  1299286,
  1300449,
  1,
  'KQR59_RS06445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368513.1',
  'glycosyltransferase family 4 protein',
  1300463,
  1301521,
  -1,
  'KQR59_RS06450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691869.1',
  'hypothetical protein',
  1301708,
  1302790,
  1,
  'KQR59_RS06455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691870.1',
  'glycosyltransferase family 32 protein',
  1302787,
  1303797,
  -1,
  'KQR59_RS06460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691871.1',
  'hypothetical protein',
  1303925,
  1305265,
  -1,
  'KQR59_RS06465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yjgA',
  'ribosome biogenesis factor YjgA',
  1305361,
  1305906,
  -1,
  'KQR59_RS06470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glyA',
  'serine hydroxymethyltransferase',
  1306009,
  1307262,
  1,
  'KQR59_RS06475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691874.1',
  'FAD-dependent oxidoreductase',
  1307619,
  1309415,
  -1,
  'KQR59_RS06480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922825.1',
  'outer membrane protein assembly factor BamD',
  1309516,
  1310340,
  -1,
  'KQR59_RS06485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rluD',
  '23S rRNA pseudouridine(1911/1915/1917) synthaseRluD',
  1310429,
  1311421,
  1,
  'KQR59_RS06490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_425513925.1',
  'glucosaminidase domain-containing protein',
  1311393,
  1312220,
  1,
  'KQR59_RS06495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691877.1',
  'MlaE family ABC transporter permease',
  1312294,
  1313391,
  1,
  'KQR59_RS06500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421928.1',
  'ABC transporter ATP-binding protein',
  1313401,
  1314162,
  1,
  'KQR59_RS06505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922820.1',
  'MlaD family protein',
  1314172,
  1314903,
  1,
  'KQR59_RS06510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368519.1',
  'hypothetical protein',
  1314908,
  1315609,
  1,
  'KQR59_RS06515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922818.1',
  'DUF445 domain-containing protein',
  1315599,
  1316285,
  -1,
  'KQR59_RS06520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368520.1',
  '16S rRNA (uracil(1498)-N(3))-methyltransferase',
  1316355,
  1317080,
  1,
  'KQR59_RS06525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465888.1',
  'oligopeptide:H+ symporter',
  1317169,
  1318650,
  1,
  'KQR59_RS06530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465887.1',
  'long-chain-fatty-acid--CoA ligase',
  1318763,
  1320454,
  1,
  'KQR59_RS06535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368522.1',
  'AraC family transcriptional regulator',
  1320464,
  1321285,
  -1,
  'KQR59_RS06540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464466.1',
  'MDR family MFS transporter',
  1321428,
  1322960,
  1,
  'KQR59_RS06545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922812.1',
  'HlyD family secretion protein',
  1322984,
  1324024,
  1,
  'KQR59_RS06550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464467.1',
  'TolC family protein',
  1324036,
  1325508,
  1,
  'KQR59_RS06555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nadE',
  'NAD(+) synthase',
  1325607,
  1326356,
  1,
  'KQR59_RS06560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691878.1',
  'hypothetical protein',
  1326437,
  1326856,
  1,
  'KQR59_RS06565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaJ',
  'molecular chaperone DnaJ',
  1326946,
  1328070,
  -1,
  'KQR59_RS06570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dnaK',
  'molecular chaperone DnaK',
  1328160,
  1330088,
  -1,
  'KQR59_RS06575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'grpE',
  'nucleotide exchange factor GrpE',
  1330184,
  1330759,
  -1,
  'KQR59_RS06580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mltA',
  'murein transglycosylase A',
  1330864,
  1332015,
  1,
  'KQR59_RS06585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691882.1',
  'NAD(P)-binding protein',
  1332008,
  1333195,
  1,
  'KQR59_RS06590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691883.1',
  'AAA family ATPase',
  1333231,
  1334400,
  1,
  'KQR59_RS06595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplM',
  '50S ribosomal protein L13',
  1334567,
  1334995,
  1,
  'KQR59_RS06600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsI',
  '30S ribosomal protein S9',
  1335011,
  1335400,
  1,
  'KQR59_RS06605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mglA',
  'transcriptional regulator MglA',
  1335461,
  1336078,
  1,
  'KQR59_RS06610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mglB',
  'transcriptional regulator MglB',
  1336080,
  1336487,
  1,
  'KQR59_RS06615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572813.1',
  'metal-dependent hydrolase family protein',
  1336522,
  1337760,
  -1,
  'KQR59_RS06620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691884.1',
  'MarR family winged helix-turn-helixtranscriptional regulator',
  1337781,
  1338284,
  -1,
  'KQR59_RS06625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691885.1',
  'PAS domain-containing protein',
  1338345,
  1338737,
  1,
  'KQR59_RS06630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691886.1',
  'FUSC family protein',
  1338743,
  1339744,
  1,
  'KQR59_RS06635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691887.1',
  'sodium:solute symporter family transporter',
  1339739,
  1340998,
  -1,
  'KQR59_RS06640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rnhB',
  'ribonuclease HII',
  1340999,
  1341556,
  -1,
  'KQR59_RS06645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368535.1',
  'RNA methyltransferase',
  1341553,
  1342302,
  -1,
  'KQR59_RS06650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922790.1',
  'PTS sugar transporter subunit IIA',
  1342295,
  1342750,
  -1,
  'KQR59_RS06655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hpf',
  'ribosome hibernation-promoting factor, HPF/YfiAfamily',
  1342782,
  1343090,
  -1,
  'KQR59_RS06660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691889.1',
  'hypothetical protein',
  1343210,
  1343458,
  1,
  'KQR59_RS06665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mnmE',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis GTPase MnmE',
  1343461,
  1344813,
  1,
  'KQR59_RS06670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368537.1',
  'hypothetical protein',
  1344831,
  1345022,
  -1,
  'KQR59_RS06675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691891.1',
  'LysR family transcriptional regulator',
  1345023,
  1345907,
  -1,
  'KQR59_RS06680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368539.1',
  'bile salt hydrolase',
  1346039,
  1347088,
  1,
  'KQR59_RS06685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691892.1',
  'hypothetical protein',
  1347277,
  1347447,
  1,
  'KQR59_RS06690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691893.1',
  'PLP-dependent cysteine synthase family protein',
  1347511,
  1348434,
  1,
  'KQR59_RS06695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_223144625.1',
  'DUF5993 family protein',
  1348514,
  1348672,
  1,
  'KQR59_RS09515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922781.1',
  'disulfide bond formation protein B',
  1348688,
  1349260,
  1,
  'KQR59_RS06700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691894.1',
  'hypothetical protein',
  1349386,
  1349622,
  1,
  'KQR59_RS06705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rrf',
  '—',
  1349887,
  1350001,
  -1,
  'KQR59_RS06710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1350058,
  1352944,
  -1,
  'KQR59_RS06715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1352995,
  1353070,
  -1,
  'KQR59_RS06720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1353078,
  1353154,
  -1,
  'KQR59_RS06725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1353251,
  1354784,
  -1,
  'KQR59_RS06730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691895.1',
  'pathogenicity determinant protein PdpA1',
  1355171,
  1357633,
  1,
  'KQR59_RS06735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691896.1',
  'hypothetical protein',
  1357637,
  1360909,
  1,
  'KQR59_RS06740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'iglE',
  'type VI secretion system lipoprotein IglE',
  1360899,
  1361276,
  1,
  'KQR59_RS06745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tssI',
  'type VI secretion system tip protein TssI/VgrG',
  1361291,
  1361785,
  1,
  'KQR59_RS06750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691897.1',
  'hypothetical protein',
  1361791,
  1363503,
  1,
  'KQR59_RS06755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'iglG',
  'type VI secretion system PAAR-like protein IglG',
  1363503,
  1364024,
  1,
  'KQR59_RS06760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'iglH',
  'type VI secretion system baseplate subunitTssF/IglH',
  1364037,
  1365464,
  1,
  'KQR59_RS06765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922771.1',
  'DotU family type IV/VI secretion system protein',
  1365479,
  1366099,
  1,
  'KQR59_RS06770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691899.1',
  'type VI secretion system protein IglI familyprotein',
  1366115,
  1367308,
  1,
  'KQR59_RS06775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'iglJ',
  'type VI secretion system baseplate protein IglJ',
  1367322,
  1368041,
  1,
  'KQR59_RS06780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tssK',
  'type VI secretion system baseplate subunit TssK',
  1368053,
  1369249,
  -1,
  'KQR59_RS06785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'iglC',
  'type VI secretion system tube protein IglC',
  1369270,
  1369899,
  -1,
  'KQR59_RS06790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tssC',
  'type VI secretion system contractile sheathlarge subunit',
  1369917,
  1371437,
  -1,
  'KQR59_RS06795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tssB',
  'type VI secretion system contractile sheathsmall subunit',
  1371450,
  1372013,
  -1,
  'KQR59_RS06800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691903.1',
  'Pathogenicity determinant protein D',
  1372097,
  1375834,
  -1,
  'KQR59_RS06805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'anmK',
  'anhydro-N-acetylmuramic acid kinase AnmK',
  1375915,
  1377060,
  -1,
  'KQR59_RS06810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572816.1',
  'MFS transporter',
  1377314,
  1378444,
  1,
  'KQR59_RS06815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691906.1',
  'trehalase family glycosidase',
  1378447,
  1379904,
  1,
  'KQR59_RS06820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fba',
  'class II fructose-bisphosphate aldolase',
  1380011,
  1381075,
  -1,
  'KQR59_RS06825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pyk',
  'pyruvate kinase',
  1381086,
  1382522,
  -1,
  'KQR59_RS06830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691907.1',
  'phosphoglycerate kinase',
  1382538,
  1383716,
  -1,
  'KQR59_RS06835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gap',
  'type I glyceraldehyde-3-phosphate dehydrogenase',
  1383736,
  1384737,
  -1,
  'KQR59_RS06840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tkt',
  'transketolase',
  1384774,
  1386765,
  -1,
  'KQR59_RS06845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368560.1',
  'YceD family protein',
  1386896,
  1387399,
  1,
  'KQR59_RS06850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpmF',
  '50S ribosomal protein L32',
  1387445,
  1387627,
  1,
  'KQR59_RS06855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'plsX',
  'phosphate acyltransferase PlsX',
  1387733,
  1388779,
  1,
  'KQR59_RS06860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420611.1',
  'beta-ketoacyl-ACP synthase III',
  1388884,
  1389855,
  1,
  'KQR59_RS06865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fabD',
  'ACP S-malonyltransferase',
  1389899,
  1390819,
  1,
  'KQR59_RS06870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fabG',
  '3-oxoacyl-ACP reductase FabG',
  1390833,
  1391576,
  1,
  'KQR59_RS06875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'acpP',
  'acyl carrier protein',
  1391675,
  1391917,
  1,
  'KQR59_RS06880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fabF',
  'beta-ketoacyl-ACP synthase II',
  1391993,
  1393252,
  1,
  'KQR59_RS06885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420615.1',
  'YciI family protein',
  1393324,
  1393608,
  1,
  'KQR59_RS06890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mnmC2',
  'tRNA(5-methylaminomethyl-2-thiouridine)(34)-methyltransferaseMnmC2',
  1393598,
  1394281,
  -1,
  'KQR59_RS06895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tsgA',
  'MFS transporter TsgA',
  1394396,
  1395595,
  1,
  'KQR59_RS06900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691911.1',
  'YeiH family protein',
  1395716,
  1396768,
  1,
  'KQR59_RS06905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368567.1',
  'inositol monophosphatase family protein',
  1396854,
  1397642,
  1,
  'KQR59_RS06910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rsmB',
  '16S rRNA (cytosine(967)-C(5))-methyltransferaseRsmB',
  1397642,
  1398919,
  1,
  'KQR59_RS06915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368569.1',
  'GNAT family N-acetyltransferase',
  1398900,
  1399388,
  -1,
  'KQR59_RS06920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922741.1',
  'YiiX/YebB-like N1pC/P60 family cysteinehydrolase',
  1399476,
  1400015,
  -1,
  'KQR59_RS06925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691913.1',
  'GNAT family N-acetyltransferase',
  1400020,
  1400454,
  -1,
  'KQR59_RS06930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ligA',
  'NAD-dependent DNA ligase LigA',
  1400455,
  1402491,
  -1,
  'KQR59_RS06935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'panG',
  '2-dehydropantoate 2-reductase PanG',
  1402785,
  1403501,
  1,
  'KQR59_RS06940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'panB',
  '3-methyl-2-oxobutanoatehydroxymethyltransferase',
  1403503,
  1404300,
  1,
  'KQR59_RS06945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'panC',
  'pantoate--beta-alanine ligase',
  1404287,
  1405072,
  1,
  'KQR59_RS06950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'panD',
  'aspartate 1-decarboxylase',
  1405066,
  1405401,
  1,
  'KQR59_RS06955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691917.1',
  'type III pantothenate kinase',
  1405405,
  1406175,
  1,
  'KQR59_RS06960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recD',
  'exodeoxyribonuclease V subunit alpha',
  1406187,
  1407938,
  -1,
  'KQR59_RS06965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recB',
  'exodeoxyribonuclease V subunit beta',
  1407931,
  1411536,
  -1,
  'KQR59_RS06970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691920.1',
  'choloylglycine hydrolase family protein',
  1411636,
  1412775,
  -1,
  'KQR59_RS06975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420630.1',
  'FUSC family protein',
  1412878,
  1413402,
  -1,
  'KQR59_RS06980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'recC',
  'exodeoxyribonuclease V subunit gamma',
  1413389,
  1416559,
  -1,
  'KQR59_RS06985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691922.1',
  'FMN-binding glutamate synthase family protein',
  1416638,
  1418224,
  -1,
  'KQR59_RS06990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691923.1',
  'DMT family transporter',
  1418401,
  1419264,
  1,
  'KQR59_RS06995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS06995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368583.1',
  'normocyte binding protein 2b',
  1419268,
  1419645,
  -1,
  'KQR59_RS07000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691924.1',
  'LexA family protein',
  1419813,
  1420466,
  1,
  'KQR59_RS07005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420635.1',
  'acid phosphatase',
  1420803,
  1421486,
  1,
  'KQR59_RS07010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1421582,
  1421670,
  -1,
  'KQR59_RS07015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1421677,
  1421750,
  -1,
  'KQR59_RS07020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1421768,
  1421842,
  -1,
  'KQR59_RS07025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691925.1',
  'aq_1923 C-terminal domain',
  1421921,
  1423555,
  -1,
  'KQR59_RS07030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691926.1',
  'SPOR domain-containing protein',
  1423847,
  1424572,
  1,
  'KQR59_RS07035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691927.1',
  'MBL fold metallo-hydrolase',
  1424575,
  1425333,
  -1,
  'KQR59_RS07040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280679.1',
  'heme biosynthesis protein HemY',
  1425347,
  1426504,
  -1,
  'KQR59_RS07045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691928.1',
  'hypothetical protein',
  1426501,
  1427586,
  -1,
  'KQR59_RS07050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691929.1',
  'uroporphyrinogen-III synthase',
  1427546,
  1428304,
  -1,
  'KQR59_RS07055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691930.1',
  'SufE family protein',
  1428305,
  1428721,
  -1,
  'KQR59_RS07060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1428880,
  1428955,
  1,
  'KQR59_RS07065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691931.1',
  'disulfide bond formation protein B',
  1429357,
  1429893,
  1,
  'KQR59_RS07070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691932.1',
  'proline--tRNA ligase',
  1430131,
  1431828,
  1,
  'KQR59_RS07075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691933.1',
  'DUF6056 family protein',
  1431820,
  1433133,
  -1,
  'KQR59_RS07080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691934.1',
  'acyltransferase family protein',
  1433293,
  1435275,
  1,
  'KQR59_RS07085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691935.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  1435375,
  1436508,
  1,
  'KQR59_RS07090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691936.1',
  'DUF3568 family protein',
  1436536,
  1436955,
  -1,
  'KQR59_RS07095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150466040.1',
  'amidohydrolase',
  1437117,
  1437887,
  1,
  'KQR59_RS07100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nusB',
  'transcription antitermination factor NusB',
  1437871,
  1438296,
  -1,
  'KQR59_RS07105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150466038.1',
  'hypothetical protein',
  1438483,
  1438884,
  1,
  'KQR59_RS07110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150466037.1',
  'hypothetical protein',
  1438901,
  1439413,
  1,
  'KQR59_RS07115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150466036.1',
  'YcgN family cysteine cluster protein',
  1439492,
  1439938,
  1,
  'KQR59_RS07120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150466035.1',
  '2OG-Fe(II) oxygenase',
  1439989,
  1440597,
  1,
  'KQR59_RS07125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_224728176.1',
  'DUF6056 family protein',
  1440717,
  1442036,
  1,
  'KQR59_RS07130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368599.1',
  'sulfite exporter TauE/SafE family protein',
  1442033,
  1442782,
  -1,
  'KQR59_RS07135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280662.1',
  'MBL fold metallo-hydrolase',
  1442784,
  1443473,
  -1,
  'KQR59_RS07140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691937.1',
  'FAD-dependent oxidoreductase',
  1443500,
  1445200,
  -1,
  'KQR59_RS07145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922693.1',
  'rhodanese-like domain-containing protein',
  1445234,
  1445752,
  -1,
  'KQR59_RS07150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263685.1',
  'ArsR/SmtB family transcription factor',
  1445820,
  1446125,
  -1,
  'KQR59_RS07155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691938.1',
  'MFS transporter',
  1446217,
  1447494,
  -1,
  'KQR59_RS07160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'guaD',
  'guanine deaminase',
  1447621,
  1448934,
  -1,
  'KQR59_RS07165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nagA',
  'N-acetylglucosamine-6-phosphate deacetylase',
  1449125,
  1450270,
  -1,
  'KQR59_RS07170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691940.1',
  'GNAT family N-acetyltransferase',
  1450347,
  1450862,
  -1,
  'KQR59_RS07175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691941.1',
  'hypothetical protein',
  1450866,
  1451582,
  -1,
  'KQR59_RS07180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trmB',
  'tRNA (guanosine(46)-N7)-methyltransferase TrmB',
  1451592,
  1452281,
  -1,
  'KQR59_RS07185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420677.1',
  'LysE family translocator',
  1452351,
  1452986,
  1,
  'KQR59_RS07190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263912.1',
  'NAD(+)/NADH kinase',
  1452983,
  1453873,
  -1,
  'KQR59_RS07195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691943.1',
  'glycosyltransferase family 2 protein',
  1454056,
  1455000,
  1,
  'KQR59_RS07200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922682.1',
  'ABC transporter permease',
  1455008,
  1455787,
  -1,
  'KQR59_RS07205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691944.1',
  'ABC transporter ATP-binding protein',
  1455796,
  1456719,
  -1,
  'KQR59_RS07210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572819.1',
  'TSUP family transporter',
  1456817,
  1457593,
  -1,
  'KQR59_RS07215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572821.1',
  'cupin domain-containing protein',
  1457600,
  1457926,
  -1,
  'KQR59_RS09520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368611.1',
  'mechanosensitive ion channel family protein',
  1457980,
  1460283,
  -1,
  'KQR59_RS07220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691945.1',
  'TatD family hydrolase',
  1460353,
  1461120,
  -1,
  'KQR59_RS07225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420685.1',
  'TDT family transporter',
  1461447,
  1462559,
  1,
  'KQR59_RS07230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691946.1',
  'MFS transporter',
  1462565,
  1463965,
  -1,
  'KQR59_RS07235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1464043,
  1464129,
  -1,
  'KQR59_RS07240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464518.1',
  'DNA-directed RNA polymerase subunit alpha',
  1464149,
  1465105,
  -1,
  'KQR59_RS07245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691947.1',
  'AAA family ATPase',
  1465193,
  1466431,
  -1,
  'KQR59_RS07250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691948.1',
  'Ppx/GppA phosphatase family protein',
  1466476,
  1467402,
  -1,
  'KQR59_RS07255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trxA',
  'thioredoxin',
  1467600,
  1467923,
  1,
  'KQR59_RS07260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rho',
  'transcription termination factor Rho',
  1467964,
  1469226,
  1,
  'KQR59_RS07265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691949.1',
  'phosphomannomutase',
  1469317,
  1470801,
  -1,
  'KQR59_RS07270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_042517684.1',
  'glycosyltransferase family 2 protein',
  1470838,
  1471608,
  -1,
  'KQR59_RS07275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691950.1',
  'glycosyltransferase family 4 protein',
  1471613,
  1472764,
  -1,
  'KQR59_RS07280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691951.1',
  'glycosyltransferase',
  1472761,
  1473786,
  -1,
  'KQR59_RS07285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691952.1',
  'glycosyltransferase family 2 protein',
  1473848,
  1474597,
  -1,
  'KQR59_RS07290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464511.1',
  'glycosyltransferase',
  1474617,
  1475501,
  -1,
  'KQR59_RS07295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922641.1',
  'ABC transporter ATP-binding protein',
  1475529,
  1476773,
  -1,
  'KQR59_RS07300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922640.1',
  'ABC transporter permease',
  1476773,
  1477588,
  -1,
  'KQR59_RS07305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_187985968.1',
  'acyltransferase family protein',
  1477656,
  1479653,
  -1,
  'KQR59_RS07310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368624.1',
  'glycosyltransferase family 2 protein',
  1479737,
  1480819,
  -1,
  'KQR59_RS07315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691953.1',
  'Rossmann-fold NAD(P)-binding domain-containingprotein',
  1480900,
  1481604,
  -1,
  'KQR59_RS07320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572823.1',
  'rhamnan synthesis F family protein',
  1481598,
  1483892,
  -1,
  'KQR59_RS07325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572825.1',
  'rhamnan synthesis F family protein',
  1483934,
  1486219,
  -1,
  'KQR59_RS07330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368627.1',
  'acyltransferase family protein',
  1486284,
  1487330,
  -1,
  'KQR59_RS07335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922632.1',
  'acyltransferase',
  1487419,
  1487880,
  -1,
  'KQR59_RS07340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922631.1',
  'sugar 3,4-ketoisomerase',
  1487873,
  1488280,
  -1,
  'KQR59_RS07345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922630.1',
  'SMR family transporter',
  1488284,
  1488664,
  -1,
  'KQR59_RS07350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922629.1',
  'WbqC family protein',
  1488658,
  1489353,
  -1,
  'KQR59_RS07355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368628.1',
  'glycoside hydrolase family protein',
  1489354,
  1490280,
  -1,
  'KQR59_RS07360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368629.1',
  'acetyltransferase',
  1490285,
  1490947,
  -1,
  'KQR59_RS07365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922626.1',
  'glycosyltransferase family 2 protein',
  1490967,
  1491887,
  -1,
  'KQR59_RS07370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368630.1',
  'DegT/DnrJ/EryC1/StrS family aminotransferase',
  1492190,
  1493308,
  1,
  'KQR59_RS07375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691954.1',
  'glycosyltransferase family 2 protein',
  1493313,
  1494284,
  1,
  'KQR59_RS07380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691955.1',
  'GtrA family protein',
  1494274,
  1494648,
  1,
  'KQR59_RS07385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691956.1',
  'glucosyltransferase domain-containing protein',
  1494664,
  1496511,
  1,
  'KQR59_RS07390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149377175.1',
  'YfhO family protein',
  1496544,
  1498175,
  -1,
  'KQR59_RS07395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rffA',
  'dTDP-4-amino-4,6-dideoxygalactose transaminase',
  1498576,
  1499712,
  -1,
  'KQR59_RS07400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691957.1',
  'hypothetical protein',
  1499743,
  1501449,
  -1,
  'KQR59_RS07405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922618.1',
  'glycosyltransferase',
  1501609,
  1502658,
  -1,
  'KQR59_RS07410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368636.1',
  'acyltransferase',
  1502676,
  1503254,
  -1,
  'KQR59_RS07415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691958.1',
  'DegT/DnrJ/EryC1/StrS family aminotransferase',
  1503251,
  1504327,
  -1,
  'KQR59_RS07420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rfbB',
  'dTDP-glucose 4,6-dehydratase',
  1504324,
  1505322,
  -1,
  'KQR59_RS07425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rfbD',
  'dTDP-4-dehydrorhamnose reductase',
  1505324,
  1506202,
  -1,
  'KQR59_RS07430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rfbC',
  'dTDP-4-dehydrorhamnose 3,5-epimerase',
  1506288,
  1506860,
  -1,
  'KQR59_RS07435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rfbA',
  'glucose-1-phosphate thymidylyltransferase RfbA',
  1506857,
  1507747,
  -1,
  'KQR59_RS07440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691960.1',
  'GDP-L-fucose synthase family protein',
  1507879,
  1508928,
  -1,
  'KQR59_RS07445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gmd',
  'GDP-mannose 4,6-dehydratase',
  1508942,
  1510081,
  -1,
  'KQR59_RS07450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368644.1',
  'mannose-1-phosphateguanylyltransferase/mannose-6-phosphate isomerase',
  1510110,
  1511483,
  -1,
  'KQR59_RS07455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368645.1',
  'NAD-dependent epimerase/dehydratase familyprotein',
  1511584,
  1512369,
  -1,
  'KQR59_RS07460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368646.1',
  'sugar transferase',
  1512372,
  1512989,
  -1,
  'KQR59_RS07465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691961.1',
  'polysaccharide biosynthesis protein',
  1512996,
  1514738,
  -1,
  'KQR59_RS07470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hrpA',
  'ATP-dependent RNA helicase HrpA',
  1514788,
  1518588,
  -1,
  'KQR59_RS07475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922604.1',
  'hypothetical protein',
  1518590,
  1518766,
  -1,
  'KQR59_RS07480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691963.1',
  'NADP-dependent isocitrate dehydrogenase',
  1518842,
  1521058,
  -1,
  'KQR59_RS07485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691964.1',
  'arsenate reductase family protein',
  1521109,
  1521456,
  -1,
  'KQR59_RS07490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691965.1',
  'long-chain-fatty-acid--CoA ligase',
  1521673,
  1523367,
  1,
  'KQR59_RS07495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691966.1',
  'acyl-CoA dehydrogenase',
  1523398,
  1525638,
  1,
  'KQR59_RS07500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691967.1',
  'acyl-CoA-binding protein',
  1525711,
  1528404,
  1,
  'KQR59_RS07505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691968.1',
  'acetyl-CoA C-acyltransferase',
  1528417,
  1529604,
  1,
  'KQR59_RS07510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691969.1',
  'PaaI family thioesterase',
  1529665,
  1530153,
  1,
  'KQR59_RS07515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691970.1',
  'MFS transporter',
  1530146,
  1531426,
  -1,
  'KQR59_RS07520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922595.1',
  'HP1242/YdcH family protein',
  1531583,
  1531810,
  -1,
  'KQR59_RS07525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691971.1',
  'nicotinate phosphoribosyltransferase',
  1531899,
  1533311,
  -1,
  'KQR59_RS07530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691972.1',
  'arginase',
  1533369,
  1534238,
  -1,
  'KQR59_RS07535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691973.1',
  'ornithine cyclodeaminase',
  1534254,
  1535270,
  -1,
  'KQR59_RS07540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691974.1',
  'COG3014 family protein',
  1535463,
  1536854,
  -1,
  'KQR59_RS07545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691975.1',
  'LpoB-related protein',
  1536856,
  1537836,
  -1,
  'KQR59_RS07550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922589.1',
  'DUF6844 domain-containing protein',
  1537846,
  1539270,
  -1,
  'KQR59_RS07555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpoB',
  'penicillin-binding protein activator LpoB',
  1539337,
  1539942,
  -1,
  'KQR59_RS07560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572828.1',
  'class I SAM-dependent methyltransferase',
  1540026,
  1540556,
  -1,
  'KQR59_RS07565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922586.1',
  'hypothetical protein',
  1540689,
  1541090,
  -1,
  'KQR59_RS07570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691977.1',
  'SH3 domain-containing protein',
  1541219,
  1541752,
  -1,
  'KQR59_RS07575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bfpR',
  'two-component system response regulator BfpR',
  1541897,
  1542586,
  1,
  'KQR59_RS07580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691978.1',
  'sensor histidine kinase',
  1542570,
  1543607,
  1,
  'KQR59_RS07585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691979.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1543685,
  1544938,
  1,
  'KQR59_RS07590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691980.1',
  'DUF1365 domain-containing protein',
  1544932,
  1545714,
  1,
  'KQR59_RS07595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691981.1',
  'SAM-dependent methyltransferase',
  1545855,
  1547018,
  1,
  'KQR59_RS07600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691982.1',
  'chalcone isomerase family protein',
  1547011,
  1547529,
  1,
  'KQR59_RS07605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_035736742.1',
  'DUF3833 domain-containing protein',
  1547526,
  1548068,
  1,
  'KQR59_RS07610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287238.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  1548071,
  1548814,
  1,
  'KQR59_RS07615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691983.1',
  'acyl-CoA desaturase',
  1548828,
  1549658,
  1,
  'KQR59_RS07620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rnr',
  'ribonuclease R',
  1549681,
  1551972,
  -1,
  'KQR59_RS07625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'truB',
  'tRNA pseudouridine(55) synthase TruB',
  1551965,
  1552873,
  -1,
  'KQR59_RS07630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rnc',
  'ribonuclease III',
  1552860,
  1553552,
  -1,
  'KQR59_RS07635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lepB',
  'signal peptidase I',
  1553557,
  1554420,
  -1,
  'KQR59_RS07640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'qseB',
  'response regulator QseB',
  1554425,
  1555111,
  -1,
  'KQR59_RS07645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'proC',
  'pyrroline-5-carboxylate reductase',
  1555247,
  1556068,
  -1,
  'KQR59_RS07650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rdgB',
  'RdgB/HAM1 family non-canonical purine NTPpyrophosphatase',
  1556174,
  1556752,
  1,
  'KQR59_RS07655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'waaA',
  'lipid IV(A) 3-deoxy-D-manno-octulosonic acidtransferase',
  1556862,
  1558157,
  1,
  'KQR59_RS07660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691988.1',
  'polyprenyl synthetase family protein',
  1558154,
  1559035,
  1,
  'KQR59_RS07665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922566.1',
  'CDP-alcohol phosphatidyltransferase familyprotein',
  1559096,
  1559854,
  1,
  'KQR59_RS07670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ppk2',
  'polyphosphate kinase 2',
  1559923,
  1560732,
  1,
  'KQR59_RS07675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1560801,
  1560877,
  1,
  'KQR59_RS07680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922565.1',
  'cell division protein ZipA C-terminalFtsZ-binding domain-containing protein',
  1561057,
  1561641,
  -1,
  'KQR59_RS07685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxB',
  'lipid-A-disaccharide synthase',
  1561701,
  1562843,
  -1,
  'KQR59_RS07690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxA',
  'acyl-ACP--UDP-N-acetylglucosamineO-acyltransferase',
  1562843,
  1563622,
  -1,
  'KQR59_RS07695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fabZ',
  '3-hydroxyacyl-ACP dehydratase FabZ',
  1563625,
  1564116,
  -1,
  'KQR59_RS07700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxD',
  'UDP-3-O-(3-hydroxymyristoyl)glucosamineN-acyltransferase',
  1564126,
  1565142,
  -1,
  'KQR59_RS07705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420764.1',
  'OmpH/Skp family outer membrane protein',
  1565162,
  1565662,
  -1,
  'KQR59_RS07710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bamA',
  'outer membrane protein assembly factor BamA',
  1565785,
  1568163,
  -1,
  'KQR59_RS07715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dxr',
  '1-deoxy-D-xylulose-5-phosphate reductoisomerase',
  1568169,
  1569323,
  -1,
  'KQR59_RS07720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gyrA',
  'DNA gyrase subunit A',
  1569330,
  1571918,
  -1,
  'KQR59_RS07725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691993.1',
  'chitin-binding protein',
  1572176,
  1573831,
  1,
  'KQR59_RS07730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691994.1',
  'copper chaperone PCu(A)C',
  1573973,
  1574416,
  1,
  'KQR59_RS07735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ung',
  'uracil-DNA glycosylase',
  1574425,
  1575081,
  -1,
  'KQR59_RS07740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpdA',
  'dihydrolipoyl dehydrogenase',
  1575177,
  1576589,
  -1,
  'KQR59_RS07745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aceF',
  'pyruvate dehydrogenase complexdihydrolipoyllysine-residue acetyltransferase',
  1576605,
  1578479,
  -1,
  'KQR59_RS07750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'aceE',
  'pyruvate dehydrogenase (acetyl-transferring),homodimeric type',
  1578494,
  1581172,
  -1,
  'KQR59_RS07755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216691998.1',
  'class I SAM-dependent methyltransferase',
  1581367,
  1582503,
  -1,
  'KQR59_RS07760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'coaE',
  'dephospho-CoA kinase',
  1582638,
  1583252,
  1,
  'KQR59_RS07765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1583284,
  1583360,
  1,
  'KQR59_RS07770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1583370,
  1583444,
  1,
  'KQR59_RS07775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572833.1',
  'glycoside hydrolase family 18 protein',
  1583686,
  1585080,
  1,
  'KQR59_RS07780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trpS',
  'tryptophan--tRNA ligase',
  1585228,
  1586232,
  1,
  'KQR59_RS07785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420775.1',
  'hypothetical protein',
  1586235,
  1586960,
  1,
  'KQR59_RS07790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922504.1',
  'cation:proton antiporter',
  1586970,
  1588277,
  1,
  'KQR59_RS07795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692000.1',
  'hypothetical protein',
  1588313,
  1588711,
  -1,
  'KQR59_RS07800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'murQ',
  'N-acetylmuramic acid 6-phosphate etherase',
  1588713,
  1589597,
  -1,
  'KQR59_RS07805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692002.1',
  'hypothetical protein',
  1589594,
  1591531,
  -1,
  'KQR59_RS07810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368695.1',
  'PilW family protein',
  1591540,
  1592553,
  -1,
  'KQR59_RS07815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368696.1',
  'type IV pilus modification PilV family protein',
  1592534,
  1593037,
  -1,
  'KQR59_RS07820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368697.1',
  'acetyl-CoA carboxylase carboxyltransferasesubunit alpha',
  1593067,
  1594014,
  -1,
  'KQR59_RS07825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'mutS',
  'DNA mismatch repair protein MutS',
  1594184,
  1596727,
  1,
  'KQR59_RS07830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secB',
  'protein-export chaperone SecB',
  1596799,
  1597248,
  1,
  'KQR59_RS07835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922495.1',
  'amino acid permease',
  1597263,
  1598480,
  1,
  'KQR59_RS07840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'xerA',
  'site-specific tyrosine recombinase/integronintegrase',
  1598488,
  1599372,
  1,
  'KQR59_RS07845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692004.1',
  'class I SAM-dependent methyltransferase',
  1599369,
  1600091,
  1,
  'KQR59_RS07850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420785.1',
  'hypothetical protein',
  1600097,
  1600711,
  -1,
  'KQR59_RS07855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692005.1',
  'DUF4124 domain-containing protein',
  1600794,
  1601372,
  1,
  'KQR59_RS07860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922490.1',
  'DUF4124 domain-containing protein',
  1601449,
  1602090,
  1,
  'KQR59_RS07865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692006.1',
  'RelA/SpoT family protein',
  1602112,
  1604043,
  -1,
  'KQR59_RS07870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rnpB',
  '—',
  1604067,
  1604405,
  -1,
  'KQR59_RS07875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922488.1',
  'hypothetical protein',
  1604412,
  1604774,
  -1,
  'KQR59_RS07880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420971.1',
  'amino acid permease',
  1604806,
  1606002,
  -1,
  'KQR59_RS07885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692007.1',
  'glycoside hydrolase family 19 protein',
  1606234,
  1608072,
  1,
  'KQR59_RS07890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692008.1',
  'DMT family transporter',
  1608291,
  1609169,
  1,
  'KQR59_RS07895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692009.1',
  'DnaJ C-terminal domain-containing protein',
  1609166,
  1610098,
  -1,
  'KQR59_RS07900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692010.1',
  'membrane lipoprotein',
  1610257,
  1610649,
  -1,
  'KQR59_RS07905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004287132.1',
  'hypothetical protein',
  1610666,
  1611052,
  -1,
  'KQR59_RS07910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692011.1',
  'CDP-alcohol phosphatidyltransferase familyprotein',
  1611052,
  1611648,
  -1,
  'KQR59_RS07915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692012.1',
  'dihydrolipoyl dehydrogenase family protein',
  1611645,
  1613057,
  -1,
  'KQR59_RS07920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_044526812.1',
  'TVP38/TMEM64 family protein',
  1613060,
  1613752,
  -1,
  'KQR59_RS07925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692013.1',
  'methylated-DNA--[protein]-cysteineS-methyltransferase',
  1613796,
  1614350,
  1,
  'KQR59_RS07930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692014.1',
  'APC family permease',
  1614384,
  1615787,
  -1,
  'KQR59_RS07935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lysA',
  'diaminopimelate decarboxylase',
  1615802,
  1616986,
  -1,
  'KQR59_RS07940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692016.1',
  'L,D-transpeptidase family protein',
  1617000,
  1617680,
  -1,
  'KQR59_RS07945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gdhA',
  'NADP-specific glutamate dehydrogenase',
  1618179,
  1619528,
  1,
  'KQR59_RS07950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692017.1',
  'MFS transporter',
  1619679,
  1620824,
  1,
  'KQR59_RS07955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692018.1',
  'BaiN/RdsA family NAD(P)/FAD-dependentoxidoreductase',
  1620831,
  1622015,
  1,
  'KQR59_RS07960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368715.1',
  'FTL_1293 family small RNA FtrC-regulatedprotein',
  1622070,
  1622549,
  1,
  'KQR59_RS07965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922470.1',
  'hypothetical protein',
  1622559,
  1622756,
  1,
  'KQR59_RS07970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692019.1',
  'S8 family serine peptidase',
  1622778,
  1624289,
  -1,
  'KQR59_RS07975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692020.1',
  'membrane dipeptidase',
  1624841,
  1625812,
  -1,
  'KQR59_RS07980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692021.1',
  'SDR family NAD(P)-dependent oxidoreductase',
  1625962,
  1626780,
  1,
  'KQR59_RS07985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692022.1',
  'APC family permease',
  1626784,
  1628133,
  -1,
  'KQR59_RS07990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'groL',
  'chaperonin GroEL',
  1628325,
  1629962,
  -1,
  'KQR59_RS07995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS07995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922465.1',
  'co-chaperone GroES',
  1630001,
  1630288,
  -1,
  'KQR59_RS08000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692023.1',
  'alpha/beta fold hydrolase',
  1630480,
  1631367,
  1,
  'KQR59_RS08005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692024.1',
  'PACE efflux transporter',
  1631408,
  1631842,
  1,
  'KQR59_RS08010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1631848,
  1631923,
  1,
  'KQR59_RS08015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263635.1',
  'FeoA domain-containing protein',
  1632143,
  1632373,
  1,
  'KQR59_RS08020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'feoB',
  'Fe(2+) transporter permease subunit FeoB',
  1632370,
  1634607,
  1,
  'KQR59_RS08025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692026.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1634727,
  1635962,
  1,
  'KQR59_RS08030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464793.1',
  'excinuclease',
  1635970,
  1636407,
  -1,
  'KQR59_RS08035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692027.1',
  'beta-ketoacyl-ACP synthase',
  1636484,
  1637701,
  -1,
  'KQR59_RS08040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fabG',
  '3-oxoacyl-ACP reductase FabG',
  1637701,
  1638426,
  -1,
  'KQR59_RS08045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464796.1',
  'hotdog family protein',
  1638430,
  1638897,
  -1,
  'KQR59_RS08050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464797.1',
  'beta-ketoacyl-ACP synthase',
  1638898,
  1640079,
  -1,
  'KQR59_RS08055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368792.1',
  'beta-ketoacyl synthase chain length factor',
  1640248,
  1640964,
  1,
  'KQR59_RS08060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692028.1',
  'lysophospholipid acyltransferase family protein',
  1640967,
  1641743,
  1,
  'KQR59_RS08065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922452.1',
  'ApeE family acyl carrier protein',
  1641761,
  1642009,
  1,
  'KQR59_RS08070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280472.1',
  'acyl carrier protein',
  1642020,
  1642274,
  1,
  'KQR59_RS08075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368794.1',
  'COG4648 family protein',
  1642286,
  1642852,
  1,
  'KQR59_RS08080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692029.1',
  'AMP-binding protein',
  1642836,
  1644149,
  1,
  'KQR59_RS08085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692030.1',
  'ApeI family dehydratase',
  1644228,
  1644569,
  1,
  'KQR59_RS08090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692031.1',
  'glycosyltransferase family 2 protein',
  1644562,
  1645311,
  1,
  'KQR59_RS08095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572835.1',
  'lysophospholipid acyltransferase family protein',
  1645308,
  1646231,
  1,
  'KQR59_RS08100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692032.1',
  'acyl-CoA thioesterase',
  1646236,
  1646664,
  1,
  'KQR59_RS08105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692033.1',
  'ApeL family LolA-like protein',
  1646661,
  1647245,
  1,
  'KQR59_RS08110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692034.1',
  'ApeM family transporter',
  1647251,
  1649593,
  1,
  'KQR59_RS08115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692035.1',
  'ApeN family LolB-like membrane protein',
  1649583,
  1650167,
  1,
  'KQR59_RS08120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692036.1',
  'DUF6056 family protein',
  1650185,
  1651483,
  -1,
  'KQR59_RS08125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ffs',
  '—',
  1651566,
  1651662,
  -1,
  'KQR59_RS08130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'yaaA',
  'peroxide stress protein YaaA',
  1651776,
  1652540,
  1,
  'KQR59_RS08135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rlmH',
  '23S rRNA(pseudouridine(1915)-N(3))-methyltransferase RlmH',
  1652544,
  1653011,
  1,
  'KQR59_RS08140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'prmC',
  'peptide chain release factor N(5)-glutaminemethyltransferase',
  1653002,
  1653859,
  -1,
  'KQR59_RS08145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'prfA',
  'peptide chain release factor 1',
  1653852,
  1654937,
  -1,
  'KQR59_RS08150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420829.1',
  'glutamyl-tRNA reductase',
  1654938,
  1656182,
  -1,
  'KQR59_RS08155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420830.1',
  'YfgM family protein',
  1656368,
  1657006,
  1,
  'KQR59_RS08160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692040.1',
  'outer membrane protein assembly factor BamB',
  1657009,
  1658574,
  1,
  'KQR59_RS08165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420832.1',
  'multidrug effflux MFS transporter',
  1658574,
  1659755,
  1,
  'KQR59_RS08170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'parE',
  'DNA topoisomerase IV subunit B',
  1659854,
  1661737,
  1,
  'KQR59_RS08175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692042.1',
  'L-cysteine desulfidase family protein',
  1661748,
  1663052,
  -1,
  'KQR59_RS08180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ampD',
  '1,6-anhydro-N-acetylmuramyl-L-alanine amidaseAmpD',
  1663045,
  1663596,
  -1,
  'KQR59_RS08185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692043.1',
  'phosphatase PAP2 family protein',
  1663670,
  1664308,
  1,
  'KQR59_RS08190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922429.1',
  'RNA pyrophosphohydrolase',
  1664309,
  1664776,
  -1,
  'KQR59_RS08195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692044.1',
  'non-ribosomal peptide synthetase',
  1664900,
  1667896,
  1,
  'KQR59_RS08200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692045.1',
  'SDR family oxidoreductase',
  1667877,
  1668596,
  1,
  'KQR59_RS08205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692046.1',
  'DMT family transporter',
  1668686,
  1669570,
  1,
  'KQR59_RS08210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692047.1',
  'HAD family acid phosphatase',
  1669567,
  1670151,
  -1,
  'KQR59_RS08215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692048.1',
  '2OG-Fe(II) oxygenase family protein',
  1670160,
  1671005,
  -1,
  'KQR59_RS08220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572838.1',
  'PGPGW domain-containing protein',
  1671126,
  1671311,
  -1,
  'KQR59_RS09525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'xerD',
  'site-specific tyrosine recombinase XerD',
  1671466,
  1672344,
  -1,
  'KQR59_RS08230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplS',
  '50S ribosomal protein L19',
  1672363,
  1672710,
  -1,
  'KQR59_RS08235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trmD',
  'tRNA (guanosine(37)-N1)-methyltransferase TrmD',
  1672700,
  1673467,
  -1,
  'KQR59_RS08240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rimM',
  'ribosome maturation factor RimM',
  1673700,
  1674209,
  -1,
  'KQR59_RS08245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpsP',
  '30S ribosomal protein S16',
  1674240,
  1674488,
  -1,
  'KQR59_RS08250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'metK',
  'methionine adenosyltransferase',
  1674774,
  1675934,
  1,
  'KQR59_RS08255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464824.1',
  'acyl-CoA desaturase',
  1676658,
  1677824,
  -1,
  'KQR59_RS08260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tsaD',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complextransferase subunit TsaD',
  1677940,
  1678950,
  -1,
  'KQR59_RS08265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922415.1',
  'lipopolysaccharide assembly protein LapAdomain-containing protein',
  1678950,
  1679195,
  -1,
  'KQR59_RS08270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpoC',
  'DNA-directed RNA polymerase subunit beta''',
  1679336,
  1683589,
  -1,
  'KQR59_RS08275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rpoB',
  'DNA-directed RNA polymerase subunit beta',
  1683652,
  1687728,
  -1,
  'KQR59_RS08280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplL',
  '50S ribosomal protein L7/L12',
  1687881,
  1688258,
  -1,
  'KQR59_RS08285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplJ',
  '50S ribosomal protein L10',
  1688321,
  1688839,
  -1,
  'KQR59_RS08290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplA',
  '50S ribosomal protein L1',
  1689011,
  1689706,
  -1,
  'KQR59_RS08295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rplK',
  '50S ribosomal protein L11',
  1689706,
  1690143,
  -1,
  'KQR59_RS08300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nusG',
  'transcription termination/antiterminationprotein NusG',
  1690216,
  1690749,
  -1,
  'KQR59_RS08305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secE',
  'preprotein translocase subunit SecE',
  1690765,
  1691193,
  -1,
  'KQR59_RS08310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1691332,
  1691407,
  -1,
  'KQR59_RS08315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tuf',
  'elongation factor Tu',
  1691429,
  1692613,
  -1,
  'KQR59_RS08320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1692658,
  1692733,
  -1,
  'KQR59_RS08325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1692766,
  1692839,
  -1,
  'KQR59_RS08330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1692841,
  1692925,
  -1,
  'KQR59_RS08335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692055.1',
  'ATP-dependent DNA helicase',
  1693081,
  1694496,
  -1,
  'KQR59_RS08340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420852.1',
  'mechanosensitive ion channel family protein',
  1694496,
  1694996,
  -1,
  'KQR59_RS08345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420853.1',
  'hypothetical protein',
  1694981,
  1695691,
  -1,
  'KQR59_RS08350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420854.1',
  'MIP/aquaporin family protein',
  1695696,
  1696460,
  -1,
  'KQR59_RS08355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692056.1',
  'glycerol-3-phosphate dehydrogenase/oxidase',
  1696470,
  1698002,
  -1,
  'KQR59_RS08360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glpK',
  'glycerol kinase GlpK',
  1698074,
  1699573,
  -1,
  'KQR59_RS08365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692057.1',
  'MFS transporter',
  1699620,
  1700843,
  -1,
  'KQR59_RS08370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922398.1',
  'hypothetical protein',
  1700965,
  1701576,
  -1,
  'KQR59_RS08375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420858.1',
  'MFS transporter',
  1701709,
  1702905,
  1,
  'KQR59_RS08380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420859.1',
  'UvrD-helicase domain-containing protein',
  1702895,
  1705123,
  -1,
  'KQR59_RS08385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ftsY',
  'signal recognition particle-docking proteinFtsY',
  1705208,
  1706209,
  -1,
  'KQR59_RS08390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692058.1',
  'LysM peptidoglycan-binding domain-containingprotein',
  1706246,
  1707547,
  -1,
  'KQR59_RS08395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922393.1',
  'peptide chain release factor 3',
  1707625,
  1709202,
  -1,
  'KQR59_RS08400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tmk',
  'dTMP kinase',
  1709266,
  1709880,
  -1,
  'KQR59_RS08405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922391.1',
  'NupC/NupG family nucleoside CNT transporter',
  1709887,
  1711092,
  -1,
  'KQR59_RS08410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420973.1',
  'NupC/NupG family nucleoside CNT transporter',
  1711103,
  1712305,
  -1,
  'KQR59_RS08415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'deoC',
  'deoxyribose-phosphate aldolase',
  1712295,
  1713050,
  -1,
  'KQR59_RS08420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922388.1',
  'phosphopentomutase',
  1713013,
  1714257,
  -1,
  'KQR59_RS08425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420866.1',
  'type III pantothenate kinase',
  1714263,
  1715039,
  -1,
  'KQR59_RS08430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'polA',
  'DNA polymerase I',
  1715061,
  1717751,
  -1,
  'KQR59_RS08435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lpxK',
  'tetraacyldisaccharide 4''-kinase',
  1717868,
  1718836,
  -1,
  'KQR59_RS08440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'msbA',
  'lipid A export permease/ATP-binding proteinMsbA',
  1718842,
  1720671,
  -1,
  'KQR59_RS08445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692062.1',
  'CCA tRNA nucleotidyltransferase',
  1720770,
  1721876,
  1,
  'KQR59_RS08450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246145958.1',
  'disulfide bond formation protein B',
  1721987,
  1722409,
  1,
  'KQR59_RS08455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922381.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1722422,
  1723795,
  1,
  'KQR59_RS08460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692063.1',
  'efflux RND transporter permease subunit',
  1723795,
  1726911,
  1,
  'KQR59_RS08465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_041263619.1',
  'MFS transporter',
  1726996,
  1728276,
  1,
  'KQR59_RS08470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692064.1',
  'YbgA family protein',
  1728292,
  1729236,
  -1,
  'KQR59_RS08475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692065.1',
  'ATP-grasp domain-containing protein',
  1729302,
  1730582,
  -1,
  'KQR59_RS08480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368846.1',
  'hypothetical protein',
  1730586,
  1731539,
  -1,
  'KQR59_RS08485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464158.1',
  'sensor histidine kinase',
  1731652,
  1733076,
  1,
  'KQR59_RS08490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692066.1',
  'TIGR01777 family oxidoreductase',
  1733073,
  1733954,
  -1,
  'KQR59_RS08495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420879.1',
  'cytochrome ubiquinol oxidase subunit I',
  1734174,
  1735550,
  1,
  'KQR59_RS08500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692067.1',
  'cytochrome d ubiquinol oxidase subunit II',
  1735553,
  1736512,
  1,
  'KQR59_RS08505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692068.1',
  'DUF3429 domain-containing protein',
  1736523,
  1736969,
  1,
  'KQR59_RS08510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420882.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1736966,
  1737946,
  1,
  'KQR59_RS08515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420883.1',
  'type IV pilus twitching motility protein PilT',
  1737983,
  1739011,
  -1,
  'KQR59_RS08520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'acnA',
  'aconitate hydratase AcnA',
  1739102,
  1741906,
  -1,
  'KQR59_RS08525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420885.1',
  'Dyp-type peroxidase',
  1742011,
  1742889,
  -1,
  'KQR59_RS08530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420886.1',
  'GtrA family protein',
  1742960,
  1743337,
  1,
  'KQR59_RS08535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemW',
  'radical SAM family heme chaperone HemW',
  1743339,
  1744481,
  1,
  'KQR59_RS08540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692070.1',
  'PepSY domain-containing protein',
  1744478,
  1744927,
  -1,
  'KQR59_RS08545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692071.1',
  'LysR family transcriptional regulatordomain-containing protein',
  1745006,
  1745959,
  -1,
  'KQR59_RS08550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1746431,
  1746516,
  -1,
  'KQR59_RS08555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'secG',
  'preprotein translocase subunit SecG',
  1746526,
  1746873,
  -1,
  'KQR59_RS08560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'tpiA',
  'triose-phosphate isomerase',
  1746861,
  1747622,
  -1,
  'KQR59_RS08565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'glmM',
  'phosphoglucosamine mutase',
  1747625,
  1748956,
  -1,
  'KQR59_RS08570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464170.1',
  'adenine phosphoribosyltransferase',
  1748966,
  1749493,
  -1,
  'KQR59_RS08575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'odhB',
  '2-oxoglutarate dehydrogenase complexdihydrolipoyllysine-residue succinyltransferase',
  1749533,
  1751005,
  -1,
  'KQR59_RS08580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692074.1',
  '2-oxoglutarate dehydrogenase E1 component',
  1751033,
  1753837,
  -1,
  'KQR59_RS08585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922345.1',
  'succinate dehydrogenase iron-sulfur subunit',
  1753867,
  1754568,
  -1,
  'KQR59_RS08590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sdhA',
  'succinate dehydrogenase flavoprotein subunit',
  1754587,
  1756380,
  -1,
  'KQR59_RS08595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sdhD',
  'succinate dehydrogenase, hydrophobic membraneanchor protein',
  1756393,
  1756761,
  -1,
  'KQR59_RS08600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'sdhC',
  'succinate dehydrogenase, cytochrome b556subunit',
  1756737,
  1757117,
  -1,
  'KQR59_RS08605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922341.1',
  'citrate synthase',
  1757462,
  1758721,
  1,
  'KQR59_RS08610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692075.1',
  'AmpG family muropeptide MFS transporter',
  1758810,
  1760183,
  1,
  'KQR59_RS08615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922339.1',
  'hypothetical protein',
  1760190,
  1760381,
  -1,
  'KQR59_RS08620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922338.1',
  'superoxide dismutase',
  1760392,
  1760970,
  -1,
  'KQR59_RS08625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'grxD',
  'Grx4 family monothiol glutaredoxin',
  1761107,
  1761433,
  1,
  'KQR59_RS08630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692076.1',
  'glycosyl hydrolase family 18 protein',
  1761434,
  1764283,
  -1,
  'KQR59_RS08635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922335.1',
  'F0F1 ATP synthase subunit epsilon',
  1764455,
  1764892,
  -1,
  'KQR59_RS08640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'atpD',
  'F0F1 ATP synthase subunit beta',
  1764905,
  1766281,
  -1,
  'KQR59_RS08645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922333.1',
  'F0F1 ATP synthase subunit gamma',
  1766291,
  1767187,
  -1,
  'KQR59_RS08650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'atpA',
  'F0F1 ATP synthase subunit alpha',
  1767202,
  1768743,
  -1,
  'KQR59_RS08655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464179.1',
  'F0F1 ATP synthase subunit delta',
  1768762,
  1769286,
  -1,
  'KQR59_RS08660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922330.1',
  'F0F1 ATP synthase subunit B',
  1769311,
  1769781,
  -1,
  'KQR59_RS08665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922329.1',
  'F0F1 ATP synthase subunit B',
  1769828,
  1770133,
  -1,
  'KQR59_RS08670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'atpB',
  'F0F1 ATP synthase subunit A',
  1770182,
  1770973,
  -1,
  'KQR59_RS08675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368867.1',
  'ATP synthase subunit I',
  1771031,
  1771402,
  -1,
  'KQR59_RS09585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922326.1',
  'MFS transporter',
  1771545,
  1772849,
  1,
  'KQR59_RS08685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922325.1',
  'RluA family pseudouridine synthase',
  1772858,
  1773781,
  -1,
  'KQR59_RS08690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'zapE',
  'cell division protein ZapE',
  1773774,
  1774841,
  -1,
  'KQR59_RS08695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420909.1',
  'MFS transporter',
  1774841,
  1776139,
  -1,
  'KQR59_RS08700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hisS',
  'histidine--tRNA ligase',
  1776136,
  1777410,
  -1,
  'KQR59_RS08705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rbfA',
  '30S ribosome-binding factor RbfA',
  1777418,
  1777849,
  -1,
  'KQR59_RS08710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'infB',
  'translation initiation factor IF-2',
  1777852,
  1780374,
  -1,
  'KQR59_RS08715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nusA',
  'transcription termination factor NusA',
  1780410,
  1781879,
  -1,
  'KQR59_RS08720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rimP',
  'ribosome maturation factor RimP',
  1781895,
  1782347,
  -1,
  'KQR59_RS08725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1782423,
  1782499,
  -1,
  'KQR59_RS08730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemE',
  'uroporphyrinogen decarboxylase',
  1782562,
  1783596,
  -1,
  'KQR59_RS08735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692081.1',
  'YifB family Mg chelatase-like AAA ATPase',
  1783631,
  1785139,
  -1,
  'KQR59_RS08740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280351.1',
  'accessory factor UbiK family protein',
  1785141,
  1785335,
  -1,
  'KQR59_RS08745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692082.1',
  'NADH-quinone oxidoreductase subunit N',
  1785411,
  1786862,
  -1,
  'KQR59_RS08750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_004286963.1',
  'complex I subunit 4 family protein',
  1786878,
  1788467,
  -1,
  'KQR59_RS08755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nuoL',
  'NADH-quinone oxidoreductase subunit L',
  1788488,
  1790497,
  -1,
  'KQR59_RS08760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nuoK',
  'NADH-quinone oxidoreductase subunit NuoK',
  1790507,
  1790824,
  -1,
  'KQR59_RS08765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922313.1',
  'NADH-quinone oxidoreductase subunit J',
  1790817,
  1791422,
  -1,
  'KQR59_RS08770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nuoI',
  'NADH-quinone oxidoreductase subunit NuoI',
  1791427,
  1791915,
  -1,
  'KQR59_RS08775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nuoH',
  'NADH-quinone oxidoreductase subunit NuoH',
  1791929,
  1792939,
  -1,
  'KQR59_RS08780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nuoG',
  'NADH-quinone oxidoreductase subunit NuoG',
  1792941,
  1795307,
  -1,
  'KQR59_RS08785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nuoF',
  'NADH-quinone oxidoreductase subunit NuoF',
  1795325,
  1796599,
  -1,
  'KQR59_RS08790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692087.1',
  'NADH-quinone oxidoreductase subunit NuoE familyprotein',
  1796606,
  1797094,
  -1,
  'KQR59_RS08795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922308.1',
  'NADH-quinone oxidoreductase subunit D',
  1797104,
  1798357,
  -1,
  'KQR59_RS08800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_187985979.1',
  'NADH-quinone oxidoreductase subunit C',
  1798376,
  1799023,
  -1,
  'KQR59_RS08805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_003017394.1',
  'NuoB/complex I 20 kDa subunit family protein',
  1799026,
  1799502,
  -1,
  'KQR59_RS08810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ndhC',
  'NADH-quinone oxidoreductase subunit A',
  1799493,
  1799891,
  -1,
  'KQR59_RS08815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420975.1',
  'Fur family transcriptional regulator',
  1800281,
  1800721,
  1,
  'KQR59_RS08820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368894.1',
  'aspartate kinase',
  1800718,
  1802037,
  -1,
  'KQR59_RS08825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692089.1',
  'diaminobutyrate--2-oxoglutarate transaminasefamily protein',
  1802120,
  1803454,
  1,
  'KQR59_RS08830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692090.1',
  'pyridoxal phosphate-dependent decarboxylasefamily protein',
  1803451,
  1804962,
  1,
  'KQR59_RS08835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692091.1',
  'IucA/IucC family protein',
  1804959,
  1806668,
  1,
  'KQR59_RS08840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692092.1',
  'lysine N(6)-hydroxylase/L-ornithineN(5)-oxygenase family protein',
  1806665,
  1807981,
  1,
  'KQR59_RS08845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692093.1',
  'GNAT family N-acetyltransferase',
  1808001,
  1810322,
  1,
  'KQR59_RS08850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_044526980.1',
  'hypothetical protein',
  1810319,
  1810708,
  1,
  'KQR59_RS08855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692094.1',
  'MFS transporter',
  1810705,
  1811916,
  1,
  'KQR59_RS08860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fslE',
  'rhizoferrin import outer membrane protein FslE',
  1812014,
  1813516,
  1,
  'KQR59_RS08865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692096.1',
  'SGNH/GDSL hydrolase family protein',
  1813574,
  1815043,
  1,
  'KQR59_RS08870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692097.1',
  'hypothetical protein',
  1815053,
  1815460,
  -1,
  'KQR59_RS08875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gatB',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatB',
  1815475,
  1816896,
  -1,
  'KQR59_RS08880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gatA',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatA',
  1816899,
  1818344,
  -1,
  'KQR59_RS08885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gatC',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatC',
  1818353,
  1818634,
  -1,
  'KQR59_RS08890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922289.1',
  'HlyD family secretion protein',
  1818716,
  1819786,
  -1,
  'KQR59_RS08895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420936.1',
  'ATP-binding cassette domain-containing protein',
  1819797,
  1821341,
  -1,
  'KQR59_RS08900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purB',
  'adenylosuccinate lyase',
  1821504,
  1822802,
  -1,
  'KQR59_RS08905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420938.1',
  'hypothetical protein',
  1823097,
  1823732,
  1,
  'KQR59_RS08910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692101.1',
  'hypothetical protein',
  1823738,
  1824511,
  1,
  'KQR59_RS08915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013922284.1',
  'CBU_0592 family membrane protein',
  1824547,
  1824795,
  -1,
  'KQR59_RS08920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692102.1',
  'aldose 1-epimerase family protein',
  1824933,
  1825793,
  -1,
  'KQR59_RS08925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_200148961.1',
  'hypothetical protein',
  1825964,
  1826593,
  -1,
  'KQR59_RS08930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purL',
  'phosphoribosylformylglycinamidine synthase',
  1826855,
  1830727,
  -1,
  'KQR59_RS08935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purF',
  'amidophosphoribosyltransferase',
  1830727,
  1832217,
  -1,
  'KQR59_RS08940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'gad',
  'glutamate decarboxylase',
  1832314,
  1833654,
  -1,
  'KQR59_RS08945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692105.1',
  '4''-phosphopantetheinyl transferase familyprotein',
  1833665,
  1834309,
  -1,
  'KQR59_RS08950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420946.1',
  'TolC family protein',
  1834318,
  1835847,
  -1,
  'KQR59_RS08955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692106.1',
  'protein-L-isoaspartate O-methyltransferasefamily protein',
  1835854,
  1836474,
  -1,
  'KQR59_RS08960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692107.1',
  'LysR family transcriptional regulator',
  1836583,
  1837431,
  -1,
  'KQR59_RS08965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692108.1',
  'nuclear transport factor 2 family protein',
  1837556,
  1837963,
  1,
  'KQR59_RS08970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368909.1',
  'MFS transporter',
  1838053,
  1839240,
  1,
  'KQR59_RS08975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trhP',
  'prephenate-dependent tRNA uridine(34)hydroxylase TrhP',
  1839439,
  1840758,
  1,
  'KQR59_RS08980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692110.1',
  'hypothetical protein',
  1840809,
  1841483,
  -1,
  'KQR59_RS08985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465737.1',
  'multidrug effflux MFS transporter',
  1841938,
  1843122,
  -1,
  'KQR59_RS08990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nhaD',
  'sodium:proton antiporter NhaD',
  1843294,
  1844721,
  1,
  'KQR59_RS08995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS08995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692111.1',
  'ABC transporter ATP-binding protein/permease',
  1844711,
  1846381,
  -1,
  'KQR59_RS09000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146420952.1',
  'APC family permease',
  1846385,
  1848259,
  -1,
  'KQR59_RS09005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'cgtA',
  'Obg family GTPase CgtA',
  1848267,
  1849271,
  -1,
  'KQR59_RS09010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465734.1',
  'amino acid permease',
  1849347,
  1850543,
  -1,
  'KQR59_RS09015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692113.1',
  'DUF6314 family protein',
  1850675,
  1851121,
  1,
  'KQR59_RS09020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692114.1',
  'response regulator transcription factor',
  1851118,
  1851804,
  -1,
  'KQR59_RS09025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692115.1',
  'ATP-binding protein',
  1851815,
  1854511,
  -1,
  'KQR59_RS09030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_200148164.1',
  'potassium-transporting ATPase subunit C',
  1854564,
  1855139,
  -1,
  'KQR59_RS09035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'kdpB',
  'potassium-transporting ATPase subunit KdpB',
  1855156,
  1857195,
  -1,
  'KQR59_RS09040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'kdpA',
  'potassium-transporting ATPase subunit KdpA',
  1857208,
  1858926,
  -1,
  'KQR59_RS09045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692118.1',
  'winged helix-turn-helix transcriptionalregulator',
  1859148,
  1859537,
  -1,
  'KQR59_RS09050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692119.1',
  'FMN-dependent NADH-azoreductase',
  1859618,
  1860205,
  1,
  'KQR59_RS09055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692120.1',
  'nuclear transport factor 2 family protein',
  1860223,
  1860729,
  1,
  'KQR59_RS09060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'uhpT',
  'hexose-6-phosphate:phosphate antiporter UhpT',
  1860742,
  1862136,
  -1,
  'KQR59_RS09065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rrf',
  '—',
  1862302,
  1862416,
  -1,
  'KQR59_RS09070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1862473,
  1865359,
  -1,
  'KQR59_RS09075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1865410,
  1865485,
  -1,
  'KQR59_RS09080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1865493,
  1865569,
  -1,
  'KQR59_RS09085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1865666,
  1867199,
  -1,
  'KQR59_RS09090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692122.1',
  'pyridoxal phosphate-dependent aminotransferase',
  1867513,
  1868703,
  -1,
  'KQR59_RS09095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692123.1',
  'PLP-dependent decarboxylase',
  1868722,
  1869933,
  -1,
  'KQR59_RS09100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465810.1',
  '2,3,4,5-tetrahydropyridine-2,6-dicarboxylateN-succinyltransferase',
  1869936,
  1870685,
  -1,
  'KQR59_RS09105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'dapA',
  '4-hydroxy-tetrahydrodipicolinate synthase',
  1870706,
  1871593,
  -1,
  'KQR59_RS09110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150464715.1',
  '4-hydroxy-tetrahydrodipicolinate reductase',
  1871584,
  1872255,
  -1,
  'KQR59_RS09115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'lysC',
  'lysine-sensitive aspartokinase 3',
  1872267,
  1873625,
  -1,
  'KQR59_RS09120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368933.1',
  'HXXEE domain-containing protein',
  1874029,
  1874493,
  1,
  'KQR59_RS09125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pip',
  'prolyl aminopeptidase',
  1874497,
  1875435,
  -1,
  'KQR59_RS09130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692126.1',
  'TatD family hydrolase',
  1875512,
  1876258,
  -1,
  'KQR59_RS09135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1876259,
  1876816,
  -1,
  'KQR59_RS09140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421497.1',
  'DUF3568 family protein',
  1877005,
  1877397,
  1,
  'KQR59_RS09145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692127.1',
  'DUF3568 domain-containing protein',
  1877415,
  1877825,
  1,
  'KQR59_RS09150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465803.1',
  'DUF3568 family protein',
  1877828,
  1878226,
  1,
  'KQR59_RS09155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'clcA',
  'H(+)/Cl(-) exchange transporter ClcA',
  1878328,
  1879722,
  1,
  'KQR59_RS09160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692128.1',
  'carboxypeptidase M32',
  1879658,
  1881160,
  1,
  'KQR59_RS09165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692129.1',
  'aspartoacylase',
  1881167,
  1882036,
  -1,
  'KQR59_RS09170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trpB',
  'tryptophan synthase subunit beta',
  1882186,
  1883376,
  1,
  'KQR59_RS09175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trpA',
  'tryptophan synthase subunit alpha',
  1883379,
  1884188,
  1,
  'KQR59_RS09180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1884185,
  1884901,
  -1,
  'KQR59_RS09185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692133.1',
  'SGNH/GDSL hydrolase family protein',
  1884993,
  1886129,
  -1,
  'KQR59_RS09190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'clpB',
  'ATP-dependent chaperone ClpB',
  1886321,
  1888900,
  1,
  'KQR59_RS09195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692134.1',
  'glycosyl hydrolase family 18 protein',
  1889054,
  1891231,
  1,
  'KQR59_RS09200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692135.1',
  'LysM peptidoglycan-binding domain-containingprotein',
  1891468,
  1892451,
  1,
  'KQR59_RS09205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'purT',
  'formate-dependent phosphoribosylglycinamideformyltransferase',
  1892543,
  1893706,
  1,
  'KQR59_RS09210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692137.1',
  'class I SAM-dependent methyltransferase',
  1893710,
  1894369,
  -1,
  'KQR59_RS09215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421512.1',
  'Frag1/DRAM/Sfk1 family protein',
  1894456,
  1895097,
  -1,
  'KQR59_RS09220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'fdxA',
  'ferredoxin FdxA',
  1895319,
  1895642,
  1,
  'KQR59_RS09225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421513.1',
  'lysophospholipid acyltransferase family protein',
  1895802,
  1896554,
  1,
  'KQR59_RS09230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421514.1',
  'lysophospholipid acyltransferase family protein',
  1896570,
  1897310,
  1,
  'KQR59_RS09235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923686.1',
  'endonuclease/exonuclease/phosphatase familyprotein',
  1897319,
  1898038,
  -1,
  'KQR59_RS09240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'nhaA',
  'Na+/H+ antiporter NhaA',
  1898102,
  1899250,
  -1,
  'KQR59_RS09245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692921.1',
  'Rieske 2Fe-2S domain-containing protein',
  1899344,
  1900240,
  1,
  'KQR59_RS09250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_191092373.1',
  'cytochrome b',
  1900300,
  1900815,
  1,
  'KQR59_RS09255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692139.1',
  'MFS transporter',
  1900845,
  1902107,
  1,
  'KQR59_RS09260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hypA',
  'hydrogenase maturation nickel metallochaperoneHypA',
  1902244,
  1902582,
  1,
  'KQR59_RS09265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hypB',
  'hydrogenase nickel incorporation protein HypB',
  1902593,
  1903300,
  1,
  'KQR59_RS09270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_281417424.1',
  'TIR domain-containing protein',
  1903331,
  1904182,
  1,
  'KQR59_RS09565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'bcp',
  'thioredoxin-dependent thiol peroxidase',
  1904218,
  1904697,
  1,
  'KQR59_RS09280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hypF',
  'carbamoyltransferase HypF',
  1904921,
  1907176,
  1,
  'KQR59_RS09285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692144.1',
  'HypC/HybG/HupF family hydrogenase formationchaperone',
  1907178,
  1907393,
  1,
  'KQR59_RS09290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hypD',
  'hydrogenase formation protein HypD',
  1907407,
  1908498,
  1,
  'KQR59_RS09295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hypE',
  'hydrogenase expression/formation protein HypE',
  1908500,
  1909525,
  1,
  'KQR59_RS09300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692147.1',
  '4Fe-4S dicluster domain-containing protein',
  1909536,
  1910636,
  1,
  'KQR59_RS09305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692148.1',
  'FAD/NAD(P)-binding protein',
  1910639,
  1911490,
  1,
  'KQR59_RS09310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_150465420.1',
  'NADH-quinone oxidoreductase subunit B familyprotein',
  1911493,
  1912299,
  1,
  'KQR59_RS09315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692149.1',
  'Ni/Fe hydrogenase subunit alpha',
  1912302,
  1913597,
  1,
  'KQR59_RS09320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692150.1',
  'HoxN/HupN/NixA family nickel/cobalt transporter',
  1913721,
  1914650,
  1,
  'KQR59_RS09325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_146421528.1',
  'hydrogenase maturation protease',
  1914714,
  1915178,
  1,
  'KQR59_RS09330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'hemB',
  'porphobilinogen synthase',
  1915221,
  1916240,
  -1,
  'KQR59_RS09335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692152.1',
  'hypothetical protein',
  1916521,
  1916913,
  -1,
  'KQR59_RS09340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'ettA',
  'energy-dependent translational throttle proteinEttA',
  1917002,
  1918681,
  -1,
  'KQR59_RS09345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692153.1',
  'MFS transporter',
  1918891,
  1920111,
  1,
  'KQR59_RS09350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_149368972.1',
  'hypothetical protein',
  1920127,
  1920339,
  -1,
  'KQR59_RS09355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692154.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1920484,
  1921770,
  1,
  'KQR59_RS09360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692155.1',
  'MBL fold metallo-hydrolase',
  1921751,
  1922710,
  1,
  'KQR59_RS09365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692156.1',
  'LysE/ArgO family amino acid transporter',
  1922720,
  1923331,
  -1,
  'KQR59_RS09370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692157.1',
  'ArgP/LysG family DNA-binding transcriptionalregulator',
  1923437,
  1924360,
  1,
  'KQR59_RS09375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692158.1',
  'multidrug effflux MFS transporter',
  1924374,
  1925612,
  -1,
  'KQR59_RS09380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692159.1',
  'TetR/AcrR family transcriptional regulator',
  1925727,
  1926329,
  1,
  'KQR59_RS09385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692160.1',
  'GRP family sugar transporter',
  1926338,
  1927342,
  -1,
  'KQR59_RS09390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'rbsK',
  'ribokinase',
  1927359,
  1928279,
  -1,
  'KQR59_RS09395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'pepN',
  'aminopeptidase N',
  1928397,
  1930973,
  -1,
  'KQR59_RS09400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trpCF',
  'bifunctional indole-3-glycerol-phosphatesynthase TrpC/phosphoribosylanthranilate isomerase TrpF',
  1931097,
  1932458,
  -1,
  'KQR59_RS09405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_012280261.1',
  'GyrI-like domain-containing protein',
  1932551,
  1932964,
  -1,
  'KQR59_RS09410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'msrA',
  'peptide-methionine (S)-S-oxide reductase MsrA',
  1932969,
  1933664,
  -1,
  'KQR59_RS09415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_246572842.1',
  'hypothetical protein',
  1933661,
  1935016,
  -1,
  'KQR59_RS09420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trpD',
  'anthranilate phosphoribosyltransferase',
  1935006,
  1936016,
  -1,
  'KQR59_RS09425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_088821800.1',
  'aminodeoxychorismate/anthranilate synthasecomponent II',
  1936013,
  1936591,
  -1,
  'KQR59_RS09430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_216692166.1',
  'anthranilate synthase component 1',
  1936595,
  1938139,
  -1,
  'KQR59_RS09435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'trpR',
  'trp operon repressor',
  1938140,
  1938427,
  -1,
  'KQR59_RS09440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1938662,
  1938739,
  -1,
  'KQR59_RS09445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  '—',
  '—',
  1938747,
  1938822,
  -1,
  'KQR59_RS09450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  'WP_013923729.1',
  'Rne/Rng family ribonuclease',
  1938884,
  1940380,
  -1,
  'KQR59_RS09455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1) AND locus_tag='KQR59_RS09455'
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
  '2599927',
  'species',
  'Francisella salimarina',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='262' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='2599927'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'species'),
  name = COALESCE(NULLIF(name,''), 'Francisella salimarina'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='262' LIMIT 1))
WHERE taxonomy_id='2599927';

UPDATE core_genome
SET taxonomy_id = (
  SELECT id FROM core_taxonomy WHERE taxonomy_id='2599927' LIMIT 1
)
WHERE genome_accession='NZ_CP076680.1';

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'EMSA', 'EMSA', NULL, 'ECO:0001807'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0001807'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'Motif-discovery', 'Motif-discovery', NULL, 'ECO:0005558'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005558'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'Site directed mutagenesis', 'Site directed mutagenesis', NULL, 'ECO:0005667'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005667'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'Comparative genomics search', 'Comparative genomics search', NULL, 'ECO:0005622'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005622'
);

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'GTGAAATAATACTTCAC',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  829583,
  829599,
  1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
    AND start=829583 AND end=829599 AND strand=1
    AND _seq='GTGAAATAATACTTCAC'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
        ORDER BY site_id DESC LIMIT 1),
   'GTGAAATAATACTTCAC',
   0,
   'motif_associated',
   'REP',
   'N/A');

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005622'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005622'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005622'
          LIMIT 1)
  );

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04065' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04065' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829583 AND end=829599 AND strand=1
          AND _seq='GTGAAATAATACTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04070' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'inferred',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04070' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'GTGAAGTAAAACTACAC',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1),
  829632,
  829648,
  1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
    AND start=829632 AND end=829648 AND strand=1
    AND _seq='GTGAAGTAAAACTACAC'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
        ORDER BY site_id DESC LIMIT 1),
   'GTGAAGTAAAACTACAC',
   0,
   'motif_associated',
   'REP',
   'N/A');

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1), (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005622'
          LIMIT 1)
WHERE (SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005622'
          LIMIT 1) IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM core_curation_siteinstance_experimental_techniques
    WHERE curation_siteinstance_id=(SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0005622'
          LIMIT 1)
  );

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04065' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'inferred',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04065' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
          AND start=829632 AND end=829648 AND strand=1
          AND _seq='GTGAAGTAAAACTACAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04070' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='KQR59_RS04070' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP076680.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

COMMIT;