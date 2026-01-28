PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

INSERT INTO core_publication
  (publication_type, pmid, authors, title, journal, publication_date, url,
   contains_promoter_data, contains_expression_data, submission_notes, curation_complete,
   reported_TF, reported_species)
SELECT
  'ARTICLE',
  '37907733',
  'deCarvalho T, Mascolo E, Caruso SM, López-Pérez J, Weston-Hafer K, Shaffer C, Erill I',
  'Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.',
  'The ISME journal',
  '2023 Dec',
  'https://doi.org/10.1038/s41396-023-01548-0',
  0,
  0,
  'Revision reason: No comparable TF protein sequence in NCBI
prueba8',
  1,
  'LexA',
  'Helicobacter pylori J99'
WHERE NOT EXISTS (
  SELECT 1 FROM core_publication WHERE pmid='37907733'
);

UPDATE core_publication
SET
  authors = CASE WHEN authors IS NULL OR authors='' THEN 'deCarvalho T, Mascolo E, Caruso SM, López-Pérez J, Weston-Hafer K, Shaffer C, Erill I' ELSE authors END,
  title = CASE WHEN title IS NULL OR title='' THEN 'Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.' ELSE title END,
  journal = CASE WHEN journal IS NULL OR journal='' THEN 'The ISME journal' ELSE journal END,
  publication_date = CASE WHEN publication_date IS NULL OR publication_date='' THEN '2023 Dec' ELSE publication_date END,
  url = CASE WHEN url IS NULL OR url='' THEN 'https://doi.org/10.1038/s41396-023-01548-0' ELSE url END,
  reported_TF = CASE WHEN reported_TF IS NULL OR reported_TF='' THEN 'LexA' ELSE reported_TF END,
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN 'Helicobacter pylori J99' ELSE reported_species END,
  contains_promoter_data = 0,
  contains_expression_data = 0,
  curation_complete = 1,
  submission_notes = CASE
    WHEN submission_notes IS NULL OR submission_notes='' THEN 'Revision reason: No comparable TF protein sequence in NCBI
prueba8'
    ELSE submission_notes
  END
WHERE pmid='37907733';

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

INSERT INTO core_tfinstance (refseq_accession, uniprot_accession, description, TF_id, notes)
SELECT
  'WP_002857553',
  'Q0PBF4',
  'two-component regulator CosR [Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819].',
  (SELECT TF_id FROM core_tf WHERE lower(name)=lower('LexA') LIMIT 1),
  ''
WHERE NOT EXISTS (
  SELECT 1 FROM core_tfinstance WHERE uniprot_accession='Q0PBF4'
);

UPDATE core_tfinstance
SET
  TF_id = COALESCE(TF_id, (SELECT TF_id FROM core_tf WHERE lower(name)=lower('LexA') LIMIT 1)),
  refseq_accession = COALESCE(NULLIF(refseq_accession,''), 'WP_002857553'),
  description = COALESCE(NULLIF(description,''), 'two-component regulator CosR [Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819].'),
  notes = COALESCE(notes, '')
WHERE uniprot_accession='Q0PBF4';

INSERT INTO core_curation
  (TF_species, site_species, experimental_process, forms_complex,
   complex_notes, notes, last_modified, curator_id, publication_id, created, validated_by_id)
VALUES
  ('Helicobacter pylori J99', 'Helicobacter pylori J99', NULL,
   0, NULL, 'Revision reason: No comparable TF protein sequence in NCBI
prueba8',
   datetime('now'), (SELECT curator_id FROM core_curator ORDER BY curator_id LIMIT 1), (SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1), datetime('now'), NULL);

INSERT INTO core_curation_confidence (curation_id, confidence)
SELECT (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1), 0
WHERE EXISTS (SELECT 1 FROM sqlite_master WHERE type='table' AND name='core_curation_confidence')
  AND NOT EXISTS (SELECT 1 FROM core_curation_confidence WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1));

INSERT INTO core_curation_TF_instances (curation_id, tfinstance_id)
SELECT (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1), (SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='Q0PBF4' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_curation_TF_instances
  WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1) AND tfinstance_id=(SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='Q0PBF4' LIMIT 1)
);

INSERT INTO core_genome (genome_accession, organism)
SELECT 'NC_000921.1', 'Helicobacter pylori J99'
WHERE NOT EXISTS (
  SELECT 1 FROM core_genome WHERE genome_accession='NC_000921.1'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nusB',
  'transcription antitermination factor NusB',
  51,
  467,
  -1,
  'JHP_RS00005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ribH',
  '6,7-dimethyl-8-ribityllumazine synthase',
  469,
  939,
  -1,
  'JHP_RS00010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'kdsA',
  '3-deoxy-8-phosphooctulonate synthase',
  949,
  1779,
  -1,
  'JHP_RS00015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000387094.1',
  'carbonic anhydrase',
  1766,
  2431,
  -1,
  'JHP_RS00020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pyrF',
  'orotidine-5''-phosphate decarboxylase',
  2552,
  3235,
  1,
  'JHP_RS00025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'panC',
  'pantoate--beta-alanine ligase',
  3235,
  4065,
  1,
  'JHP_RS00030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  4079,
  4154,
  -1,
  'JHP_RS00035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  4214,
  4290,
  -1,
  'JHP_RS00040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  4341,
  4416,
  -1,
  'JHP_RS00045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  4454,
  4528,
  -1,
  'JHP_RS00050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  4541,
  4616,
  -1,
  'JHP_RS00055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopZ',
  'Hop family adhesin HopZ',
  5436,
  7443,
  -1,
  'JHP_RS00065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'groL',
  'chaperonin GroEL',
  7758,
  9398,
  -1,
  'JHP_RS00070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'groES',
  'co-chaperone GroES',
  9423,
  9779,
  -1,
  'JHP_RS00075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dnaG',
  'DNA primase',
  10067,
  11746,
  1,
  'JHP_RS00080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000809440.1',
  'MnmA/TRMU family protein',
  11743,
  12795,
  1,
  'JHP_RS00085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001154969.1',
  'DUF5718 family protein',
  12885,
  13712,
  1,
  'JHP_RS00090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001272691.1',
  'TrbC/VirB2 family protein',
  13859,
  14140,
  1,
  'JHP_RS00095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000584953.1',
  'hypothetical protein',
  14140,
  14403,
  1,
  'JHP_RS00100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000890516.1',
  'VirB4 family type IV secretion/conjugal transferATPase',
  14405,
  16768,
  1,
  'JHP_RS00105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ffs',
  '—',
  16803,
  16900,
  -1,
  'JHP_RS07875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001881006.1',
  'COG3014 family protein',
  17077,
  18417,
  1,
  'JHP_RS00110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cheV1',
  'chemotaxis protein CheV1',
  18524,
  19489,
  1,
  'JHP_RS00115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nspC',
  'carboxynorspermidine decarboxylase',
  19486,
  20703,
  1,
  'JHP_RS00120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpxE',
  'lipid A 1-phosphatase LpxE',
  20764,
  21300,
  -1,
  'JHP_RS00125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'eptA',
  'phosphoethanolamine--lipid A transferase EptA',
  21350,
  22921,
  -1,
  'JHP_RS00130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000726301.1',
  'Hop family adhesin SabA/HopD',
  23538,
  25610,
  -1,
  'JHP_RS00135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000117349.1',
  'citrate synthase',
  26315,
  27595,
  -1,
  'JHP_RS00140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'icd',
  'isocitrate dehydrogenase (NADP(+))',
  27796,
  29073,
  1,
  'JHP_RS00145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000589514.1',
  'DUF1523 family protein',
  29138,
  29665,
  1,
  'JHP_RS00150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'bioD',
  'dethiobiotin synthase',
  29642,
  30298,
  -1,
  'JHP_RS00155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000926200.1',
  'hypothetical protein',
  30302,
  31999,
  -1,
  'JHP_RS00160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001023005.1',
  'universal stress protein',
  32111,
  32524,
  1,
  'JHP_RS00165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000781796.1',
  'ATP-dependent Clp protease adaptor ClpS',
  32526,
  32798,
  1,
  'JHP_RS00170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000357196.1',
  'AAA family ATPase',
  32798,
  35026,
  1,
  'JHP_RS00175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'panD',
  'aspartate 1-decarboxylase',
  35016,
  35369,
  1,
  'JHP_RS00180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000347931.1',
  'YbaB/EbfC family nucleoid-associated protein',
  35372,
  35674,
  1,
  'JHP_RS00185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000468465.1',
  'PDZ domain-containing protein',
  35674,
  36678,
  1,
  'JHP_RS00190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000679725.1',
  'type IV secretion system protein',
  36686,
  37741,
  1,
  'JHP_RS00195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001217877.1',
  'hypothetical protein',
  37757,
  37870,
  1,
  'JHP_RS00200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000660577.1',
  'VirB8 family type IV secretion system protein',
  37867,
  38610,
  1,
  'JHP_RS00205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001878684.1',
  'TrbG/VirB9 family P-type conjugative transferprotein',
  38610,
  39596,
  1,
  'JHP_RS00210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001045766.1',
  'DNA type IV secretion system protein ComB10',
  39589,
  40719,
  1,
  'JHP_RS00215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000694964.1',
  'mannose-1-phosphateguanylyltransferase/mannose-6-phosphate isomerase',
  40789,
  42201,
  1,
  'JHP_RS00220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gmd',
  'GDP-mannose 4,6-dehydratase',
  42242,
  43387,
  1,
  'JHP_RS00225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001002487.1',
  'GDP-L-fucose synthase family protein',
  43380,
  44312,
  1,
  'JHP_RS00230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000466434.1',
  'hypothetical protein',
  44709,
  45005,
  -1,
  'JHP_RS08565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hypE',
  'hydrogenase expression/formation protein HypE',
  45190,
  46188,
  -1,
  'JHP_RS00240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hypF',
  'carbamoyltransferase HypF',
  46191,
  48443,
  -1,
  'JHP_RS00245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000827169.1',
  'agmatine deiminase family protein',
  48440,
  49432,
  -1,
  'JHP_RS00250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000614628.1',
  'DNA-methyltransferase',
  49491,
  50183,
  -1,
  'JHP_RS00255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882488.1',
  'DNA cytosine methyltransferase',
  50161,
  50718,
  -1,
  'JHP_RS00260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001180464.1',
  'site-specific DNA-methyltransferase',
  51152,
  52183,
  -1,
  'JHP_RS00265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001874436.1',
  'type II restriction endonuclease',
  52193,
  52975,
  -1,
  'JHP_RS00270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DNA cytosine methyltransferase',
  53110,
  53199,
  -1,
  'JHP_RS07890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DNA cytosine methyltransferase',
  53290,
  53361,
  -1,
  'JHP_RS08755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'putP',
  'sodium/proline symporter PutP',
  53403,
  54893,
  -1,
  'JHP_RS00275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001169408.1',
  'bifunctional proline dehydrogenase/L-glutamategamma-semialdehyde dehydrogenase',
  54920,
  58477,
  -1,
  'JHP_RS00280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000848997.1',
  'hypothetical protein',
  58798,
  59007,
  1,
  'JHP_RS00285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000467216.1',
  'hypothetical protein',
  59335,
  59997,
  1,
  'JHP_RS08850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_372237157.1',
  'hypothetical protein',
  60181,
  60489,
  1,
  'JHP_RS08855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000536945.1',
  'coiled-coil domain-containing protein',
  60490,
  61473,
  1,
  'JHP_RS00300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000237898.1',
  'hypothetical protein',
  61484,
  61915,
  1,
  'JHP_RS08860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_372237158.1',
  'hypothetical protein',
  61925,
  62092,
  1,
  'JHP_RS08865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  62096,
  63901,
  1,
  'JHP_RS00310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000988455.1',
  'hypothetical protein',
  63898,
  64467,
  1,
  'JHP_RS00315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000092092.1',
  'WXG100 family type VII secretion target',
  64483,
  64743,
  1,
  'JHP_RS00320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000852783.1',
  'HNH endonuclease',
  64754,
  66256,
  1,
  'JHP_RS00325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000375120.1',
  'SMI1/KNR4 family protein',
  66226,
  66645,
  1,
  'JHP_RS00330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000899119.1',
  'hypothetical protein',
  66647,
  67000,
  1,
  'JHP_RS00335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_160442686.1',
  'FtsK/SpoIIIE domain-containing protein',
  66969,
  69413,
  1,
  'JHP_RS00340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001099400.1',
  'urease accessory protein UreD',
  69487,
  70284,
  -1,
  'JHP_RS00345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ureG',
  'urease accessory protein UreG',
  70284,
  70883,
  -1,
  'JHP_RS00350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000357456.1',
  'urease accessory protein UreF',
  70912,
  71682,
  -1,
  'JHP_RS00355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ureE',
  'urease accessory protein UreE',
  71706,
  72218,
  -1,
  'JHP_RS00360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ureI',
  'acid-activated urea channel protein UreI',
  72220,
  72807,
  -1,
  'JHP_RS00365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ureB',
  'urease subunit beta',
  73031,
  74740,
  -1,
  'JHP_RS00370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ureA',
  'urease subunit alpha',
  74744,
  75460,
  -1,
  'JHP_RS00375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  75728,
  75803,
  -1,
  'JHP_RS00380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lspA',
  'signal peptidase II',
  75814,
  76305,
  -1,
  'JHP_RS00385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glmM',
  'phosphoglucosamine mutase',
  76299,
  77636,
  -1,
  'JHP_RS00390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsT',
  '30S ribosomal protein S20',
  77726,
  77995,
  1,
  'JHP_RS00395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'prfA',
  'peptide chain release factor 1',
  78114,
  79172,
  1,
  'JHP_RS00400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000719120.1',
  'outer membrane protein',
  79586,
  80353,
  1,
  'JHP_RS00410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000644282.1',
  'hypothetical protein',
  80604,
  82376,
  1,
  'JHP_RS00415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tlpC',
  'methyl-accepting chemotaxis protein TlpC',
  82800,
  84821,
  -1,
  'JHP_RS00420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsI',
  '30S ribosomal protein S9',
  84971,
  85360,
  -1,
  'JHP_RS00425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplM',
  '50S ribosomal protein L13',
  85357,
  85782,
  -1,
  'JHP_RS00430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001168427.1',
  'DUF5408 family protein',
  86134,
  86322,
  -1,
  'JHP_RS00435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000061443.1',
  'FAD-dependent oxidoreductase',
  86329,
  87681,
  -1,
  'JHP_RS00440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001268623.1',
  'C40 family peptidase',
  87735,
  89108,
  -1,
  'JHP_RS00445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpoD',
  'RNA polymerase sigma factor RpoD',
  89128,
  91200,
  -1,
  'JHP_RS00450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mtnN',
  '5''-methylthioadenosine/adenosylhomocysteinenucleosidase',
  91396,
  92091,
  -1,
  'JHP_RS00455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fabD',
  'ACP S-malonyltransferase',
  92102,
  93031,
  -1,
  'JHP_RS00460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  93161,
  93252,
  1,
  'JHP_RS00465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'type II restriction endonuclease',
  93458,
  94289,
  1,
  'JHP_RS08570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000582298.1',
  'DNA-methyltransferase',
  94286,
  95119,
  1,
  'JHP_RS00475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'futC1',
  'alpha-(1,2)-fucosyltransferase FutC1',
  95139,
  95579,
  -1,
  'JHP_RS00480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'alpha-1,2-fucosyltransferase',
  95576,
  96039,
  -1,
  'JHP_RS00485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001125829.1',
  'hypothetical protein',
  96135,
  96665,
  -1,
  'JHP_RS00490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000846787.1',
  'D-2-hydroxyacid dehydrogenase',
  96738,
  97682,
  1,
  'JHP_RS00495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001227136.1',
  'hypothetical protein',
  97806,
  98519,
  -1,
  'JHP_RS00500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thrC',
  'threonine synthase',
  98623,
  100083,
  -1,
  'JHP_RS00505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tlpA',
  'methyl-accepting chemotaxis protein TlpA',
  100277,
  102304,
  1,
  'JHP_RS00510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000905208.1',
  'epoxyqueuosine reductase QueH',
  102304,
  103410,
  1,
  'JHP_RS00515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000853709.1',
  'outer membrane beta-barrel protein',
  103627,
  104388,
  1,
  'JHP_RS00520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000922043.1',
  'glycosyltransferase family 2 protein',
  104371,
  105153,
  -1,
  'JHP_RS00525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tlpB',
  'methyl-accepting chemotaxis protein TlpB',
  105185,
  106882,
  -1,
  'JHP_RS00530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_307772107.1',
  'bifunctional metallophosphatase/5''-nucleotidase',
  107095,
  108807,
  -1,
  'JHP_RS00535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000783567.1',
  'S-ribosylhomocysteine lyase',
  108981,
  109439,
  -1,
  'JHP_RS00540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001242773.1',
  'cystathionine gamma-synthase',
  109477,
  110619,
  -1,
  'JHP_RS00545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000603993.1',
  'cysteine synthase family protein',
  110644,
  111561,
  -1,
  'JHP_RS00550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  111680,
  112251,
  1,
  'JHP_RS00555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dnaK',
  'molecular chaperone DnaK',
  112512,
  114374,
  -1,
  'JHP_RS00560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'grpE',
  'nucleotide exchange factor GrpE',
  114404,
  114979,
  -1,
  'JHP_RS00565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000919598.1',
  'HrcA family transcriptional regulator',
  114979,
  115779,
  -1,
  'JHP_RS00570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000933670.1',
  'class II aldolase and adducin N-terminaldomain-containing protein',
  116018,
  116656,
  1,
  'JHP_RS00575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000154731.1',
  'hypothetical protein',
  116694,
  116990,
  1,
  'JHP_RS00580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001028953.1',
  'motility associated factor glycosyltransferasefamily protein',
  117000,
  118883,
  -1,
  'JHP_RS00585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000010021.1',
  'flagellin B',
  118931,
  120475,
  -1,
  'JHP_RS00590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'topA',
  'type I DNA topoisomerase',
  120641,
  122851,
  1,
  'JHP_RS00595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001040769.1',
  'radical SAM protein',
  122844,
  123770,
  1,
  'JHP_RS00600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000446699.1',
  'DUF874 family protein',
  123915,
  125153,
  -1,
  'JHP_RS00605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ppsA',
  'pyruvate, water dikinase',
  125252,
  127690,
  -1,
  'JHP_RS00610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thrS',
  'threonine--tRNA ligase',
  128047,
  129885,
  1,
  'JHP_RS00620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'infC',
  'translation initiation factor IF-3',
  129882,
  130493,
  1,
  'JHP_RS00625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmI',
  '50S ribosomal protein L35',
  130474,
  130668,
  1,
  'JHP_RS00630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplT',
  '50S ribosomal protein L20',
  130763,
  131113,
  1,
  'JHP_RS00635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000750178.1',
  'outer membrane protein',
  131313,
  132173,
  1,
  'JHP_RS00640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000731705.1',
  'DUF1104 domain-containing protein',
  132653,
  133084,
  1,
  'JHP_RS00645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000821488.1',
  'hypothetical protein',
  133496,
  134353,
  1,
  'JHP_RS00650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000135987.1',
  'L-serine ammonia-lyase',
  134985,
  136352,
  -1,
  'JHP_RS00655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000046366.1',
  'serine/threonine transporter',
  136352,
  137593,
  -1,
  'JHP_RS00660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000072734.1',
  'class II 3-deoxy-7-phosphoheptulonate synthase',
  137774,
  139123,
  1,
  'JHP_RS00665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001222899.1',
  'hypothetical protein',
  139412,
  139546,
  1,
  'JHP_RS08720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000412964.1',
  'peroxiredoxin',
  139771,
  140229,
  -1,
  'JHP_RS00675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000032037.1',
  'LutC/YkgG family protein',
  140239,
  140874,
  -1,
  'JHP_RS00680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000417307.1',
  'LutB/LldF family L-lactate oxidation iron-sulfurprotein',
  140867,
  142312,
  -1,
  'JHP_RS00685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000867254.1',
  '(Fe-S)-binding protein',
  142341,
  143069,
  -1,
  'JHP_RS00690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000398024.1',
  'L-lactate permease',
  143291,
  144940,
  1,
  'JHP_RS00695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001288522.1',
  'L-lactate permease',
  144989,
  146644,
  1,
  'JHP_RS00700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000448996.1',
  'adenine-specific DNA glycosylase',
  146668,
  147654,
  -1,
  'JHP_RS00705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000595291.1',
  'DASS family sodium-coupled anion symporter',
  147655,
  149103,
  -1,
  'JHP_RS00710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ccoN',
  'cytochrome-c oxidase, cbb3-type subunit I',
  149273,
  150739,
  1,
  'JHP_RS00715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ccoO',
  'cytochrome-c oxidase, cbb3-type subunit II',
  150752,
  151450,
  1,
  'JHP_RS00720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001876875.1',
  'cytochrome c oxidase, cbb3-type, CcoQ subunit',
  151461,
  151679,
  1,
  'JHP_RS00725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ccoP',
  'cytochrome-c oxidase, cbb3-type subunit III',
  151681,
  152559,
  1,
  'JHP_RS00730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000670513.1',
  'DUF4006 family protein',
  152570,
  152776,
  1,
  'JHP_RS00735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000677515.1',
  'hypothetical protein',
  152877,
  153470,
  1,
  'JHP_RS00740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000660335.1',
  'hypothetical protein',
  153483,
  154064,
  1,
  'JHP_RS00745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000506368.1',
  'hypothetical protein',
  154676,
  155443,
  1,
  'JHP_RS00750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000626219.1',
  'menaquinone biosynthesis family protein',
  155440,
  156303,
  -1,
  'JHP_RS00755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'recA',
  'recombinase RecA',
  156402,
  157445,
  1,
  'JHP_RS00760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'eno',
  'phosphopyruvate hydratase',
  157457,
  158737,
  1,
  'JHP_RS00765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000146220.1',
  'hypothetical protein',
  158730,
  159005,
  1,
  'JHP_RS00770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001881045.1',
  'AMIN domain-containing protein',
  159022,
  159618,
  1,
  'JHP_RS00775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001164300.1',
  'shikimate kinase',
  159623,
  160111,
  1,
  'JHP_RS00780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000952319.1',
  'PDC sensor domain-containing protein',
  160133,
  161089,
  1,
  'JHP_RS00785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000028798.1',
  'HP0159 family lipopolysaccharide1,6-glucosyltransferase',
  161086,
  162219,
  -1,
  'JHP_RS00790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000597796.1',
  'tetratricopeptide repeat protein',
  162372,
  163289,
  1,
  'JHP_RS00795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_226928958.1',
  'hypothetical protein',
  163789,
  163944,
  1,
  'JHP_RS07925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000532137.1',
  'YebC/PmpR family DNA-binding transcriptionalregulator',
  163970,
  164692,
  -1,
  'JHP_RS00800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemB',
  'porphobilinogen synthase',
  164693,
  165664,
  -1,
  'JHP_RS00805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'arsS',
  'acid-sensing histidine kinase ArsS',
  165686,
  167014,
  -1,
  'JHP_RS00810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'arsR',
  'acid response regulator transcription factorArsR',
  167040,
  167717,
  -1,
  'JHP_RS00815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925872.1',
  'CiaD-like domain-containing protein',
  168125,
  168586,
  -1,
  'JHP_RS00820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001127789.1',
  'tetratricopeptide repeat protein',
  168577,
  168840,
  -1,
  'JHP_RS00825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001077418.1',
  'peptidase U32 family protein',
  168887,
  170155,
  -1,
  'JHP_RS00830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cheZ',
  'protein phosphatase CheZ',
  170158,
  170889,
  -1,
  'JHP_RS00835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'prfB',
  'peptide chain release factor 2',
  170959,
  172050,
  -1,
  'JHP_RS00840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000622849.1',
  'molybdopterin molybdotransferase MoeA',
  172111,
  173283,
  -1,
  'JHP_RS00845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliR',
  'flagellar biosynthetic protein FliR',
  173293,
  174060,
  -1,
  'JHP_RS00850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000242489.1',
  'EI24 domain-containing protein',
  174054,
  174782,
  -1,
  'JHP_RS00855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  174892,
  175105,
  -1,
  'JHP_RS08575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cbf2',
  'peptidylprolyl isomerase CBF2',
  175251,
  176150,
  1,
  'JHP_RS00860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000960453.1',
  'class II fructose-bisphosphate aldolase',
  176164,
  177087,
  1,
  'JHP_RS00865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'efp',
  'elongation factor P',
  177109,
  177672,
  1,
  'JHP_RS00870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  177937,
  178244,
  1,
  'JHP_RS08765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000870338.1',
  'McrB family protein',
  178219,
  179565,
  1,
  'JHP_RS00880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000482617.1',
  'LlaJI family restriction endonuclease',
  179558,
  180778,
  1,
  'JHP_RS00885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pseI',
  'pseudaminic acid synthase',
  180850,
  181872,
  -1,
  'JHP_RS00890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000588045.1',
  'ABC transporter ATP-binding protein',
  181875,
  182516,
  -1,
  'JHP_RS00895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001236995.1',
  'apolipoprotein N-acyltransferase',
  182513,
  183790,
  -1,
  'JHP_RS00900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001106271.1',
  'CvpA family protein',
  184026,
  184736,
  1,
  'JHP_RS00905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lysS',
  'lysine--tRNA ligase',
  184746,
  186251,
  1,
  'JHP_RS00910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000323050.1',
  'serine hydroxymethyltransferase',
  186251,
  187501,
  1,
  'JHP_RS00915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000138070.1',
  'DUF1882 domain-containing protein',
  187511,
  188053,
  1,
  'JHP_RS00920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001290554.1',
  'SPOR domain-containing protein',
  188075,
  188881,
  1,
  'JHP_RS00925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000858769.1',
  'DUF262 domain-containing protein',
  189273,
  190976,
  -1,
  'JHP_RS00930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000890449.1',
  'TIGR00645 family protein',
  191132,
  191665,
  1,
  'JHP_RS00935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'clsC',
  'cardiolipin synthase ClsC',
  191672,
  193180,
  -1,
  'JHP_RS00940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001282415.1',
  'fumarate reductase iron-sulfur subunit',
  193202,
  193939,
  -1,
  'JHP_RS00945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000705948.1',
  'fumarate reductase flavoprotein subunit',
  193932,
  196076,
  -1,
  'JHP_RS00950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001183641.1',
  'fumarate reductase cytochrome b subunit',
  196086,
  196853,
  -1,
  'JHP_RS00955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000161068.1',
  'triose-phosphate isomerase',
  197063,
  197767,
  1,
  'JHP_RS00960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fabI',
  'enoyl-ACP reductase FabI',
  197777,
  198604,
  1,
  'JHP_RS00965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpxD',
  'UDP-3-O-(3-hydroxymyristoyl)glucosamineN-acyltransferase',
  198614,
  199624,
  1,
  'JHP_RS00970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'metK',
  'methionine adenosyltransferase',
  199690,
  200847,
  1,
  'JHP_RS00975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ndk',
  'nucleoside-diphosphate kinase',
  200914,
  201327,
  1,
  'JHP_RS00980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001159167.1',
  'DUF177 domain-containing protein',
  201352,
  201708,
  1,
  'JHP_RS00985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmF',
  '50S ribosomal protein L32',
  201724,
  201870,
  1,
  'JHP_RS00990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'plsX',
  'phosphate acyltransferase PlsX',
  201948,
  202967,
  1,
  'JHP_RS00995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS00995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000397804.1',
  'ketoacyl-ACP synthase III',
  202991,
  203986,
  1,
  'JHP_RS01000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882495.1',
  'hypothetical protein',
  204010,
  204312,
  1,
  'JHP_RS01005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000473908.1',
  'hypothetical protein',
  205002,
  205385,
  -1,
  'JHP_RS01010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'ATP-binding protein',
  205463,
  208507,
  -1,
  'JHP_RS01015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000249745.1',
  'Mrp/NBP35 family ATP-binding protein',
  208472,
  209710,
  1,
  'JHP_RS01020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_235420997.1',
  'glycosyltransferase family 8 protein',
  209770,
  210816,
  -1,
  'JHP_RS01025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'glycosyltransferase family 8 protein',
  210803,
  210956,
  -1,
  'JHP_RS08580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001173697.1',
  'outer membrane family protein',
  211133,
  212455,
  1,
  'JHP_RS01035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'htpG',
  'molecular chaperone HtpG',
  212559,
  214424,
  1,
  'JHP_RS01040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hcpA',
  'Sel1-like repeat protein HcpA',
  214621,
  215373,
  -1,
  'JHP_RS01045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dapE',
  'succinyl-diaminopimelate desuccinylase',
  215821,
  216987,
  -1,
  'JHP_RS01050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mnmG',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis enzyme MnmG',
  216997,
  218862,
  -1,
  'JHP_RS01055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000427439.1',
  'SLC13 family permease',
  218958,
  220604,
  1,
  'JHP_RS01060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000656959.1',
  'phosphatidate cytidylyltransferase',
  220617,
  221417,
  1,
  'JHP_RS01065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dxr',
  '1-deoxy-D-xylulose-5-phosphate reductoisomerase',
  221418,
  222524,
  1,
  'JHP_RS01070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'beta-1,4-N-acetylgalactosamyltransferase',
  222822,
  223733,
  1,
  'JHP_RS07940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001933236.1',
  'YbhB/YbcL family Raf kinase inhibitor-likeprotein',
  223802,
  224428,
  -1,
  'JHP_RS01085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000445833.1',
  'helix-turn-helix domain-containing protein',
  224494,
  224958,
  1,
  'JHP_RS01090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000941654.1',
  'NifS family cysteine desulfurase',
  225126,
  226289,
  1,
  'JHP_RS01095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001051933.1',
  'iron-sulfur cluster assembly scaffold proteinNifU',
  226311,
  227291,
  1,
  'JHP_RS01100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000858670.1',
  'ribbon-helix-helix domain-containing protein',
  227455,
  227715,
  1,
  'JHP_RS01105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'radA',
  'DNA repair protein RadA',
  227794,
  229140,
  1,
  'JHP_RS01110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'msrB',
  'peptide-methionine (R)-S-oxide reductase MsrB',
  229264,
  230343,
  1,
  'JHP_RS01115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000392992.1',
  'sulfite exporter TauE/SafE family protein',
  230748,
  231581,
  -1,
  'JHP_RS01120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000694329.1',
  'Hop family adhesin SabA/HopD',
  231799,
  233889,
  -1,
  'JHP_RS01125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000890357.1',
  'SulP family inorganic anion transporter',
  234143,
  235300,
  1,
  'JHP_RS01130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  235335,
  235409,
  -1,
  'JHP_RS01135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopA',
  'porin HopA',
  235542,
  236993,
  -1,
  'JHP_RS01140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'kdsB',
  '3-deoxy-manno-octulosonate cytidylyltransferase',
  237187,
  237918,
  -1,
  'JHP_RS01145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dsbK',
  'protein disulfide-isomerase DsbK',
  238027,
  238824,
  1,
  'JHP_RS01150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000743539.1',
  'UPF0323 family lipoprotein',
  238840,
  239487,
  1,
  'JHP_RS01155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001197161.1',
  'glutathionylspermidine synthase family protein',
  239509,
  240681,
  1,
  'JHP_RS01160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000126233.1',
  'hypothetical protein',
  240681,
  241211,
  1,
  'JHP_RS01165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hcpE',
  'Sel1-like repeat protein HcpE',
  241987,
  243054,
  -1,
  'JHP_RS01170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001237838.1',
  'c-type cytochrome',
  243165,
  243536,
  -1,
  'JHP_RS01175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemC',
  'hydroxymethylbilane synthase',
  243536,
  244456,
  -1,
  'JHP_RS01180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'proS',
  'proline--tRNA ligase',
  244467,
  246197,
  -1,
  'JHP_RS01185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemA',
  'glutamyl-tRNA reductase',
  246201,
  247550,
  -1,
  'JHP_RS01190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001156730.1',
  'polyprenyl synthetase family protein',
  247550,
  248473,
  -1,
  'JHP_RS01195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001004130.1',
  'hypothetical protein',
  248483,
  248878,
  -1,
  'JHP_RS01200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001206060.1',
  'DUF2018 family protein',
  248871,
  249155,
  -1,
  'JHP_RS01205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dps',
  'DNA starvation/stationary phase protectionprotein',
  249176,
  249610,
  -1,
  'JHP_RS01210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgS',
  'acid survival sensor histidine kinase',
  249818,
  250963,
  -1,
  'JHP_RS01215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000609401.1',
  'hypothetical protein',
  250960,
  251277,
  -1,
  'JHP_RS01220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000832116.1',
  'flagellar basal body P-ring protein FlgI',
  251274,
  252302,
  -1,
  'JHP_RS01225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000422559.1',
  'DEAD/DEAH box helicase',
  252488,
  253963,
  1,
  'JHP_RS01230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001121063.1',
  'prohibitin family protein',
  253984,
  255072,
  1,
  'JHP_RS01235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000157461.1',
  'DUF2393 domain-containing protein',
  255079,
  255618,
  1,
  'JHP_RS01240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nikE',
  'nickel ABC transporter ATP-binding protein NikE',
  255701,
  257251,
  -1,
  'JHP_RS01245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000116521.1',
  'ABC transporter permease',
  257261,
  258283,
  -1,
  'JHP_RS01250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  258389,
  258464,
  -1,
  'JHP_RS01255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopF',
  'Hop family outer membrane protein HopF',
  258627,
  260066,
  1,
  'JHP_RS01260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopG',
  'Hop family outer membrane protein HopG',
  260079,
  261494,
  1,
  'JHP_RS01265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'purA',
  'adenylosuccinate synthase',
  261593,
  262828,
  1,
  'JHP_RS01270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000712850.1',
  'flagellar export protein FliJ',
  262825,
  263253,
  1,
  'JHP_RS01275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001226659.1',
  'MotE family protein',
  263246,
  263914,
  1,
  'JHP_RS01280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rseP',
  'RIP metalloprotease RseP',
  263911,
  264966,
  1,
  'JHP_RS01285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'xseA',
  'exodeoxyribonuclease VII large subunit',
  264979,
  266241,
  1,
  'JHP_RS01290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925910.1',
  'DNA methyltransferase',
  266260,
  267414,
  -1,
  'JHP_RS01295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882504.1',
  'hypothetical protein',
  267425,
  267883,
  -1,
  'JHP_RS01300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'BsaWI family type II restriction enzyme',
  267969,
  268659,
  1,
  'JHP_RS01305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000806055.1',
  'DNA-methyltransferase',
  268656,
  269414,
  1,
  'JHP_RS01315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001047947.1',
  'ATP-dependent Clp protease ATP-binding subunit',
  269487,
  272057,
  1,
  'JHP_RS01320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882506.1',
  'cytochrome c biogenesis protein CcdA',
  272114,
  272833,
  1,
  'JHP_RS01325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000924871.1',
  'amidohydrolase family protein',
  272843,
  273979,
  1,
  'JHP_RS01330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mqnF',
  'aminofutalosine deaminase family hydrolase',
  273964,
  275193,
  1,
  'JHP_RS01335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000780053.1',
  'nuclease',
  275440,
  275682,
  1,
  'JHP_RS01340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'miaB',
  'tRNA (N6-isopentenyladenosine(37)-C2)-methylthiotransferase MiaB',
  275692,
  277005,
  1,
  'JHP_RS01345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000053495.1',
  'lysophospholipid acyltransferase family protein',
  277039,
  277692,
  1,
  'JHP_RS01350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000911888.1',
  'hypothetical protein',
  277685,
  278668,
  1,
  'JHP_RS01355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882507.1',
  'hypothetical protein',
  278658,
  279191,
  1,
  'JHP_RS01360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000803094.1',
  'hypothetical protein',
  279188,
  279727,
  1,
  'JHP_RS01365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001204150.1',
  'YkgJ family cysteine cluster protein',
  279744,
  280142,
  1,
  'JHP_RS01370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001025839.1',
  'tetratricopeptide repeat protein',
  280179,
  281474,
  1,
  'JHP_RS01375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001155678.1',
  'beta/alpha barrel domain-containing protein',
  281462,
  282019,
  1,
  'JHP_RS01380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000055473.1',
  'YfhL family 4Fe-4S dicluster ferredoxin',
  282076,
  282330,
  1,
  'JHP_RS01385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001074237.1',
  'Ppx/GppA family phosphatase',
  282340,
  283794,
  1,
  'JHP_RS01390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'waaC',
  'lipopolysaccharide heptosyltransferase I',
  283791,
  284801,
  1,
  'JHP_RS01395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000221298.1',
  'lipid A biosynthesis lauroyl acyltransferase',
  284798,
  285784,
  1,
  'JHP_RS01400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tgt',
  'tRNA guanosine(34) transglycosylase Tgt',
  286040,
  287155,
  -1,
  'JHP_RS01405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000717222.1',
  'COG3400 family protein',
  287212,
  288648,
  1,
  'JHP_RS01410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'aroB',
  '3-dehydroquinate synthase',
  288653,
  289684,
  1,
  'JHP_RS01415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001218204.1',
  'mechanosensitive ion channel family protein',
  289675,
  291246,
  1,
  'JHP_RS01420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mtaB',
  'tRNA(N(6)-L-threonylcarbamoyladenosine(37)-C(2))-methylthiotransferase MtaB',
  291243,
  292499,
  1,
  'JHP_RS01425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001116649.1',
  'AAA family ATPase',
  292486,
  294138,
  1,
  'JHP_RS01430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'bioV',
  'pimelyl-ACP methyl ester esterase BioV',
  294141,
  294659,
  1,
  'JHP_RS01435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000713347.1',
  'DUF4149 domain-containing protein',
  294672,
  295145,
  1,
  'JHP_RS01440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000808594.1',
  'immunomodulatory autotransporter protein ImaA',
  295213,
  303921,
  1,
  'JHP_RS01445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lysA',
  'diaminopimelate decarboxylase',
  303969,
  305186,
  1,
  'JHP_RS01450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001171407.1',
  'chorismate mutase',
  305191,
  305493,
  1,
  'JHP_RS01455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000461311.1',
  'DUF2156 domain-containing protein',
  305506,
  306378,
  1,
  'JHP_RS01460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000576007.1',
  'bifunctional chorismate-binding protein/class IVaminotransferase',
  306379,
  308082,
  1,
  'JHP_RS01465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001215734.1',
  'aliphatic amidase',
  308210,
  309229,
  1,
  'JHP_RS01470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgL',
  'flagellar hook-associated protein FlgL',
  309554,
  312040,
  -1,
  'JHP_RS01475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplU',
  '50S ribosomal protein L21',
  312283,
  312597,
  1,
  'JHP_RS01480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmA',
  '50S ribosomal protein L27',
  312611,
  312877,
  1,
  'JHP_RS01485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001089555.1',
  'ABC transporter substrate-binding protein',
  312996,
  314636,
  1,
  'JHP_RS01490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000947989.1',
  'ABC transporter permease',
  314647,
  315651,
  1,
  'JHP_RS01495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'ABC transporter permease',
  315651,
  316504,
  1,
  'JHP_RS01500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000599865.1',
  'ABC transporter ATP-binding protein',
  316516,
  317379,
  1,
  'JHP_RS01505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000770471.1',
  'ABC transporter ATP-binding protein',
  317376,
  318182,
  1,
  'JHP_RS01510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'obgE',
  'GTPase ObgE',
  318202,
  319284,
  1,
  'JHP_RS01515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000819909.1',
  'alginate lyase family protein',
  319480,
  320475,
  1,
  'JHP_RS01520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000738943.1',
  'YceI family protein',
  320741,
  321295,
  1,
  'JHP_RS01525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemL',
  'glutamate-1-semialdehyde 2,1-aminomutase',
  321305,
  322597,
  1,
  'JHP_RS01530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000743087.1',
  'AtpZ/AtpI family protein',
  322602,
  322865,
  1,
  'JHP_RS01535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000336502.1',
  'hypothetical protein',
  322881,
  323285,
  1,
  'JHP_RS01540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000850721.1',
  'carbon-nitrogen hydrolase family protein',
  323369,
  324253,
  1,
  'JHP_RS01545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001040340.1',
  'polysaccharide deacetylase family protein',
  324266,
  325147,
  1,
  'JHP_RS01550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000337942.1',
  'hypothetical protein',
  325193,
  325561,
  1,
  'JHP_RS01555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001124320.1',
  'CobW family GTP-binding protein',
  325561,
  326526,
  1,
  'JHP_RS01560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001263607.1',
  'YbfB/YjiJ family MFS transporter',
  326532,
  327677,
  -1,
  'JHP_RS01565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000500913.1',
  'ABC transporter permease',
  327878,
  328633,
  -1,
  'JHP_RS01570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000624996.1',
  'ATP-binding cassette domain-containing protein',
  328633,
  329334,
  -1,
  'JHP_RS01575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000934559.1',
  'HugZ family heme oxygenase',
  329907,
  330662,
  -1,
  'JHP_RS01580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'argS',
  'arginine--tRNA ligase',
  330939,
  332564,
  -1,
  'JHP_RS01585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tatA',
  'twin-arginine translocase TatA/TatE familysubunit',
  332567,
  332806,
  -1,
  'JHP_RS01590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gmk',
  'guanylate kinase',
  332878,
  333498,
  -1,
  'JHP_RS01595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'chePep',
  'chemotaxis regulatory protein ChePep',
  333491,
  334996,
  -1,
  'JHP_RS01600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000932489.1',
  'phospholipase D-like domain-containing protein',
  335138,
  335680,
  1,
  'JHP_RS01605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001259606.1',
  'outer membrane protein',
  335688,
  336425,
  -1,
  'JHP_RS01610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgH',
  'flagellar basal body L-ring protein FlgH',
  336559,
  337272,
  1,
  'JHP_RS01615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pseF',
  'pseudaminic acid cytidylyltransferase',
  337296,
  337985,
  1,
  'JHP_RS08725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001144366.1',
  'hypothetical protein',
  337976,
  338848,
  1,
  'JHP_RS08730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pseH',
  'UDP-4-amino-4,6-dideoxy-N-acetyl-beta-L-altrosamine N-acetyltransferase',
  338845,
  339387,
  1,
  'JHP_RS01630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000833880.1',
  'tetraacyldisaccharide 4''-kinase',
  339320,
  340258,
  -1,
  'JHP_RS01635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001168315.1',
  'NAD+ synthase',
  340255,
  341037,
  -1,
  'JHP_RS01640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  341122,
  341198,
  1,
  'JHP_RS01645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ilvC',
  'ketol-acid reductoisomerase',
  341286,
  342278,
  1,
  'JHP_RS01650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'minD',
  'septum site-determining protein MinD',
  342303,
  343109,
  1,
  'JHP_RS01655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'minE',
  'cell division topological specificity factorMinE',
  343106,
  343339,
  1,
  'JHP_RS01660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dprA',
  'DNA-processing protein DprA',
  343351,
  344151,
  1,
  'JHP_RS01665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ruvX',
  'Holliday junction resolvase RuvX',
  344148,
  344552,
  1,
  'JHP_RS01670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000013350.1',
  'cysteine-rich Sel1 repeat protein',
  344778,
  345566,
  1,
  'JHP_RS01675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000699883.1',
  'hypothetical protein',
  345751,
  346089,
  1,
  'JHP_RS01680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001035884.1',
  'hypothetical protein',
  346073,
  346633,
  1,
  'JHP_RS01685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001117208.1',
  'RluA family pseudouridine synthase',
  346804,
  347685,
  -1,
  'JHP_RS01690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'recJ',
  'single-stranded-DNA-specific exonuclease RecJ',
  347685,
  349235,
  -1,
  'JHP_RS01695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pyrG',
  'glutamine hydrolyzing CTP synthase',
  349245,
  350861,
  -1,
  'JHP_RS01700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000829845.1',
  'phosphatase PAP2 family protein',
  351122,
  351784,
  1,
  'JHP_RS01705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliF',
  'flagellar basal-body MS-ring/collar proteinFliF',
  351828,
  353531,
  1,
  'JHP_RS01710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliG',
  'flagellar motor switch protein FliG',
  353548,
  354579,
  1,
  'JHP_RS01715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliH',
  'flagellar assembly protein FliH',
  354566,
  355342,
  1,
  'JHP_RS01720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dxs',
  '1-deoxy-D-xylulose-5-phosphate synthase',
  355345,
  357195,
  1,
  'JHP_RS01725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lepA',
  'translation elongation factor 4',
  357216,
  359006,
  1,
  'JHP_RS01730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000160426.1',
  'protein NO VEIN domain-containing protein',
  359021,
  359779,
  1,
  'JHP_RS01735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001011850.1',
  'hypothetical protein',
  359782,
  360018,
  1,
  'JHP_RS01740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  360050,
  360314,
  1,
  'JHP_RS07960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001179185.1',
  'flagellar hook-basal body protein',
  360338,
  361147,
  -1,
  'JHP_RS01745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001069407.1',
  'MFS transporter',
  361203,
  362516,
  -1,
  'JHP_RS01750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000837232.1',
  'DNA translocase FtsK',
  362902,
  365436,
  -1,
  'JHP_RS01755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001047390.1',
  'ATP-dependent deoxyribonuclease AddB',
  365433,
  367769,
  -1,
  'JHP_RS01760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tkt',
  'transketolase',
  367766,
  369691,
  -1,
  'JHP_RS01765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000931592.1',
  'bifunctional riboflavin kinase/FAD synthetase',
  369738,
  370580,
  -1,
  'JHP_RS01770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tlyA',
  '23S rRNA (cytidine-2''-O)-methyltransferase TlyA',
  370546,
  371253,
  -1,
  'JHP_RS01775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000523538.1',
  'hypothetical protein',
  371253,
  371768,
  -1,
  'JHP_RS01780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pyrB',
  'aspartate carbamoyltransferase',
  371835,
  372758,
  1,
  'JHP_RS01785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hofB',
  'outer membrane beta-barrel protein HofB',
  373015,
  374454,
  1,
  'JHP_RS01790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000765037.1',
  'ABC transporter ATP-binding protein',
  374545,
  376200,
  1,
  'JHP_RS01795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000946777.1',
  'hypothetical protein',
  376194,
  376817,
  1,
  'JHP_RS01800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000721767.1',
  'restriction endonuclease',
  376821,
  377390,
  1,
  'JHP_RS01805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000616532.1',
  'AAA family ATPase',
  377523,
  378668,
  1,
  'JHP_RS01810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF3226 domain-containing protein',
  378661,
  379357,
  1,
  'JHP_RS01820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000780409.1',
  'HoxN/HupN/NixA family nickel/cobalt transporter',
  379415,
  380410,
  1,
  'JHP_RS01825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000353441.1',
  'flagellar FLiS export co-chaperone',
  380414,
  380935,
  -1,
  'JHP_RS01830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'csd4',
  'DL-carboxypeptidase Csd4',
  381071,
  382387,
  1,
  'JHP_RS01835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000511463.1',
  'coiled-coil domain-containing protein',
  382409,
  383227,
  -1,
  'JHP_RS01840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'copP',
  'copper-binding metallochaperone CopP',
  383426,
  383626,
  -1,
  'JHP_RS01845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'copA',
  'copper-translocating P-type ATPase CopA',
  383627,
  385864,
  -1,
  'JHP_RS01850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pssA',
  'CDP-diacylglycerol--serineO-phosphatidyltransferase',
  385861,
  386574,
  -1,
  'JHP_RS01855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001255694.1',
  'hypothetical protein',
  386564,
  386824,
  -1,
  'JHP_RS01860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ftsH',
  'ATP-dependent zinc metalloprotease FtsH',
  386827,
  388725,
  -1,
  'JHP_RS01865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'prmA',
  '50S ribosomal protein L11 methyltransferase',
  388734,
  389711,
  -1,
  'JHP_RS01870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000772146.1',
  'chemotaxis response regulator CheY',
  389724,
  390098,
  -1,
  'JHP_RS01875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000348862.1',
  'outer membrane protein',
  390350,
  390994,
  1,
  'JHP_RS01880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  391010,
  391097,
  -1,
  'JHP_RS01885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000906048.1',
  'hypothetical protein',
  391140,
  391547,
  -1,
  'JHP_RS01890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000944402.1',
  'PP0621 family protein',
  391550,
  391792,
  -1,
  'JHP_RS01895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rsmG',
  '16S rRNA (guanine(527)-N(7))-methyltransferaseRsmG',
  391786,
  392322,
  -1,
  'JHP_RS01900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'queA',
  'tRNA preQ1(34) S-adenosylmethionineribosyltransferase-isomerase QueA',
  392319,
  393356,
  -1,
  'JHP_RS01905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tatC',
  'twin-arginine translocase subunit TatC',
  393357,
  394106,
  -1,
  'JHP_RS01910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tatB',
  'Sec-independent protein translocase proteinTatB',
  394099,
  394581,
  -1,
  'JHP_RS01915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ruvB',
  'Holliday junction branch migration DNA helicaseRuvB',
  394648,
  395658,
  -1,
  'JHP_RS08355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'panB',
  '3-methyl-2-oxobutanoatehydroxymethyltransferase',
  395659,
  396471,
  -1,
  'JHP_RS08360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000523326.1',
  'hypothetical protein',
  396622,
  397344,
  1,
  'JHP_RS01930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925877.1',
  'outer membrane beta-barrel protein',
  397334,
  398191,
  1,
  'JHP_RS01935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000770216.1',
  'outer membrane beta-barrel protein',
  398203,
  399144,
  1,
  'JHP_RS01940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000522721.1',
  'M23 family metallopeptidase',
  399154,
  400476,
  1,
  'JHP_RS01945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'minC',
  'septum site-determining protein MinC',
  400479,
  401063,
  1,
  'JHP_RS01950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpxC',
  'UDP-3-O-acyl-N-acetylglucosamine deacetylase',
  401060,
  401947,
  1,
  'JHP_RS01955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000417938.1',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexdimerization subunit type 1 TsaB',
  401969,
  402466,
  1,
  'JHP_RS01960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thrB',
  'homoserine kinase',
  402520,
  403401,
  1,
  'JHP_RS01965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001232524.1',
  'DUF448 domain-containing protein',
  403388,
  403642,
  1,
  'JHP_RS01970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'infB',
  'translation initiation factor IF-2',
  403639,
  406488,
  1,
  'JHP_RS01975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rbfA',
  '30S ribosome-binding factor RbfA',
  406488,
  406823,
  1,
  'JHP_RS01980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rimP',
  'ribosome maturation factor RimP',
  406816,
  407256,
  1,
  'JHP_RS01985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000908744.1',
  'metallophosphoesterase',
  407417,
  408529,
  1,
  'JHP_RS01990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hsrA',
  'response regulator-like transcription factorHsrA',
  408882,
  409553,
  1,
  'JHP_RS01995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS01995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882514.1',
  '3'',5''-cyclic-nucleotide phosphodiesterase',
  410346,
  411389,
  -1,
  'JHP_RS02000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flhA',
  'flagellar biosynthesis protein FlhA',
  411423,
  413624,
  -1,
  'JHP_RS02005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsO',
  '30S ribosomal protein S15',
  413760,
  414032,
  1,
  'JHP_RS02010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000910818.1',
  'O-antigen ligase family protein',
  414073,
  415377,
  1,
  'JHP_RS02015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'aroQ',
  'type II 3-dehydroquinate dehydratase',
  415490,
  416002,
  1,
  'JHP_RS02020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001214539.1',
  'aminopeptidase',
  416015,
  417088,
  1,
  'JHP_RS02025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'folK',
  '2-amino-4-hydroxy-6-hydroxymethyldihydropteridine diphosphokinase',
  417088,
  417576,
  1,
  'JHP_RS02030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flhF',
  'flagellar biosynthesis protein FlhF',
  417573,
  418940,
  1,
  'JHP_RS02035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ylxH',
  'flagellum site-determining protein YlxH',
  418937,
  419821,
  1,
  'JHP_RS02040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001265942.1',
  'hypothetical protein',
  419826,
  420140,
  1,
  'JHP_RS02045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000602348.1',
  'RNA polymerase sigma factor FliA',
  420118,
  420885,
  1,
  'JHP_RS02050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliM',
  'flagellar motor switch protein FliM',
  420878,
  421942,
  1,
  'JHP_RS02055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliY',
  'flagellar motor switch protein FliY',
  421946,
  422803,
  1,
  'JHP_RS02060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000963980.1',
  'YhcH/YjgK/YiaL family protein',
  422833,
  423369,
  1,
  'JHP_RS02065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000780230.1',
  'DUF2147 domain-containing protein',
  423366,
  423869,
  1,
  'JHP_RS02070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fur',
  'ferric iron uptake transcriptional regulator',
  423889,
  424341,
  -1,
  'JHP_RS02075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000060375.1',
  'replication-associated recombination protein A',
  424501,
  425676,
  -1,
  'JHP_RS02080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000272475.1',
  'heat shock protein transcriptional repressorHspR',
  425673,
  426044,
  -1,
  'JHP_RS02085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000045866.1',
  'DnaJ family protein',
  426054,
  426920,
  -1,
  'JHP_RS02090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001199520.1',
  'hypothetical protein',
  427088,
  428338,
  1,
  'JHP_RS02095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882518.1',
  '5''-3'' exonuclease',
  428582,
  429448,
  -1,
  'JHP_RS02100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000697594.1',
  'OriC activity response regulator',
  429669,
  430565,
  -1,
  'JHP_RS02105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000052911.1',
  'bifunctional 2-C-methyl-D-erythritol 4-phosphatecytidylyltransferase/2-C-methyl-D-erythritol2,4-cyclodiphosphate synthase',
  430587,
  431816,
  -1,
  'JHP_RS02110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000976590.1',
  'Do family serine endopeptidase',
  431838,
  433268,
  -1,
  'JHP_RS02115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000401050.1',
  'amino acid permease',
  433313,
  434740,
  -1,
  'JHP_RS02120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pgsA',
  'CDP-diacylglycerol--glycerol-3-phosphate3-phosphatidyltransferase',
  434936,
  435475,
  -1,
  'JHP_RS02125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000789450.1',
  'hypothetical protein',
  435472,
  436080,
  -1,
  'JHP_RS02130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001014514.1',
  'enoyl-ACP reductase',
  436090,
  436878,
  -1,
  'JHP_RS02135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dapA',
  '4-hydroxy-tetrahydrodipicolinate synthase',
  436875,
  437777,
  -1,
  'JHP_RS02140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'M16 family metallopeptidase',
  437791,
  439122,
  -1,
  'JHP_RS02145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000967238.1',
  'quinone-dependent dihydroorotate dehydrogenase',
  439119,
  440174,
  -1,
  'JHP_RS02150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001078656.1',
  'RNA degradosome polyphosphate kinase',
  440213,
  442240,
  -1,
  'JHP_RS02155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  442334,
  442411,
  -1,
  'JHP_RS02160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000005921.1',
  'restriction endonuclease subunit S',
  442888,
  444117,
  -1,
  'JHP_RS02165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001133370.1',
  'N-6 DNA methylase',
  444110,
  445741,
  -1,
  'JHP_RS02170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000458210.1',
  'DEAD/DEAH box helicase family protein',
  445734,
  447992,
  -1,
  'JHP_RS02175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001146208.1',
  'hypothetical protein',
  448048,
  448182,
  1,
  'JHP_RS08735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001146679.1',
  'type I restriction endonuclease',
  448166,
  448876,
  -1,
  'JHP_RS08590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001116221.1',
  'motility associated factor glycosyltransferasefamily protein',
  448924,
  450819,
  -1,
  'JHP_RS02180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000402743.1',
  'TerB family tellurite resistance protein',
  450844,
  451611,
  -1,
  'JHP_RS02185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001861281.1',
  'hypothetical protein',
  451621,
  451935,
  -1,
  'JHP_RS02190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000114674.1',
  'DUF5644 domain-containing protein',
  451937,
  453424,
  -1,
  'JHP_RS02195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001188587.1',
  'hypothetical protein',
  453436,
  453924,
  -1,
  'JHP_RS02200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000662836.1',
  'M3 family oligoendopeptidase',
  453909,
  455645,
  -1,
  'JHP_RS02205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000431961.1',
  'cation:proton antiporter',
  455743,
  456993,
  -1,
  'JHP_RS02210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993053.1',
  'hypothetical protein',
  457146,
  457328,
  -1,
  'JHP_RS08595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000595776.1',
  'outer membrane beta-barrel protein',
  457312,
  457872,
  -1,
  'JHP_RS02215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'modA',
  'molybdate ABC transporter substrate-bindingprotein',
  458097,
  458837,
  1,
  'JHP_RS02220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'modB',
  'molybdate ABC transporter permease subunit',
  458859,
  459533,
  1,
  'JHP_RS02225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000588410.1',
  'ATP-binding cassette domain-containing protein',
  459530,
  460327,
  1,
  'JHP_RS02230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gltX',
  'glutamate--tRNA ligase',
  460444,
  461835,
  -1,
  'JHP_RS02235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopJ',
  'Hop family outer membrane protein HopJ/HopK',
  461953,
  463068,
  1,
  'JHP_RS02240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001139758.1',
  'class I SAM-dependent methyltransferase',
  463077,
  464714,
  1,
  'JHP_RS02245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000557834.1',
  'glycosyltransferase family 9 protein',
  464680,
  465528,
  1,
  'JHP_RS02250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'typA',
  'translational GTPase TypA',
  465574,
  467373,
  1,
  'JHP_RS02255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000543200.1',
  'DNA adenine methylase',
  467389,
  468318,
  1,
  'JHP_RS02260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'GIY-YIG nuclease family protein',
  468321,
  468936,
  1,
  'JHP_RS02265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000278691.1',
  'DNA cytosine methyltransferase',
  469030,
  470085,
  1,
  'JHP_RS02270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'restriction endonuclease',
  470078,
  470830,
  1,
  'JHP_RS02275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000719610.1',
  'catalase family peroxidase',
  471069,
  472013,
  -1,
  'JHP_RS02280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hofC',
  'outer membrane beta-barrel protein HofC',
  472290,
  473876,
  1,
  'JHP_RS02285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hofD',
  'outer membrane beta-barrel protein HofD',
  473948,
  475345,
  1,
  'JHP_RS02290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925918.1',
  'hypothetical protein',
  475571,
  475771,
  -1,
  'JHP_RS08600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000786170.1',
  'DUF3519 domain-containing protein',
  475860,
  478598,
  1,
  'JHP_RS02300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001108985.1',
  'hypothetical protein',
  478667,
  479212,
  1,
  'JHP_RS02305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000461998.1',
  'potassium channel family protein',
  479452,
  480588,
  -1,
  'JHP_RS02310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmB',
  '50S ribosomal protein L28',
  480775,
  480963,
  -1,
  'JHP_RS02315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000501889.1',
  'HpaA family protein',
  481063,
  481911,
  -1,
  'JHP_RS02320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mraY',
  'phospho-N-acetylmuramoyl-pentapeptide-transferase',
  482029,
  483090,
  1,
  'JHP_RS02325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'murD',
  'UDP-N-acetylmuramoyl-L-alanine--D-glutamateligase',
  483092,
  484360,
  1,
  'JHP_RS02330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001138714.1',
  'HP0495 family protein',
  484357,
  484617,
  -1,
  'JHP_RS02335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ybgC',
  'acyl-CoA thioesterase YbgC',
  484607,
  485008,
  -1,
  'JHP_RS02340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000526608.1',
  'sodium-dependent transporter',
  485240,
  486568,
  1,
  'JHP_RS02345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000514536.1',
  'sodium-dependent transporter',
  486579,
  487907,
  1,
  'JHP_RS02350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000836124.1',
  'phospholipase A',
  487922,
  488989,
  1,
  'JHP_RS02355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dnaN',
  'DNA polymerase III subunit beta',
  489047,
  490171,
  1,
  'JHP_RS02360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gyrB',
  'DNA topoisomerase (ATP-hydrolyzing) subunit B',
  490184,
  492505,
  1,
  'JHP_RS02365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925920.1',
  'hypothetical protein',
  492551,
  493543,
  1,
  'JHP_RS02370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000052676.1',
  'R.Pab1 family restriction endonuclease',
  493530,
  494285,
  1,
  'JHP_RS02375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'csd3',
  'peptidoglycan DD-metalloendopeptidase Csd3',
  494500,
  495720,
  1,
  'JHP_RS02380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000120007.1',
  'hypothetical protein',
  495720,
  496358,
  1,
  'JHP_RS02385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000945055.1',
  'plasminogen-binding protein PgbA',
  496369,
  497721,
  1,
  'JHP_RS02390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glcD',
  'glycolate oxidase subunit GlcD',
  497726,
  499105,
  1,
  'JHP_RS02395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dapB',
  '4-hydroxy-tetrahydrodipicolinate reductase',
  499128,
  499892,
  1,
  'JHP_RS02400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'urease-enhancing factor',
  500310,
  500499,
  1,
  'JHP_RS02405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glnA',
  'type I glutamate--ammonia ligase',
  501230,
  502675,
  -1,
  'JHP_RS02410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000642596.1',
  'GmrSD restriction endonuclease domain-containingprotein',
  502813,
  504933,
  1,
  'JHP_RS02415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplI',
  '50S ribosomal protein L9',
  504996,
  505445,
  1,
  'JHP_RS02420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hslV',
  'ATP-dependent protease subunit HslV',
  505449,
  505991,
  1,
  'JHP_RS02425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hslU',
  'HslU--HslV peptidase ATPase subunit',
  505991,
  507322,
  1,
  'JHP_RS02430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'era',
  'GTPase Era',
  507322,
  508227,
  1,
  'JHP_RS02435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'csd6',
  'cell shape-determining L,D-carboxypeptidaseCsd6',
  508224,
  509216,
  1,
  'JHP_RS02440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000461114.1',
  'SEL1-like repeat protein',
  509304,
  510155,
  -1,
  'JHP_RS02445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000166494.1',
  'hypothetical protein',
  510270,
  510413,
  1,
  'JHP_RS08605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cag1',
  'cag pathogenicity island protein Cag1',
  510500,
  510847,
  1,
  'JHP_RS02455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_078257844.1',
  'cag pathogenicity island protein',
  510863,
  511021,
  1,
  'JHP_RS08780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000050545.1',
  'topoisomerase DNA-binding C4 zinc fingerdomain-containing protein',
  510990,
  511649,
  1,
  'JHP_RS02460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cag3',
  'type IV secretion system outer membrane capsubunit Cag3',
  511642,
  513087,
  1,
  'JHP_RS02465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cag4',
  'VirB1 family T4SS lytic transglycosylase Cag4',
  513097,
  513606,
  1,
  'JHP_RS02470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cag5',
  'VirD4 family type IV secretion system ATPaseCag5',
  514088,
  516334,
  -1,
  'JHP_RS02475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'virB11',
  'cag pathogenicity island type IV secretionsystem ATPase VirB11',
  516343,
  517335,
  -1,
  'JHP_RS02480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagZ',
  'cag pathogenicity island translocation proteinCagZ',
  517340,
  517939,
  -1,
  'JHP_RS02485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001001431.1',
  'CagY family CD-EC repeat-containing protein',
  518074,
  523533,
  -1,
  'JHP_RS02490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagX',
  'type IV secretion system apparatus protein CagX',
  523548,
  525116,
  -1,
  'JHP_RS02495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagW',
  'cag pathogenicity island VirB6 family T4SSprotein CagW',
  525169,
  526776,
  -1,
  'JHP_RS02500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagV',
  'cag pathogenicity island type IV secretionsystem protein CagV',
  526781,
  527539,
  -1,
  'JHP_RS02505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagU',
  'cag pathogenicity island translocation proteinCagU',
  527921,
  528577,
  1,
  'JHP_RS02510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagT',
  'type IV secretion system apparatus protein CagT',
  528613,
  529455,
  1,
  'JHP_RS02515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagS',
  'cag pathogenicity island protein CagS',
  529660,
  530259,
  -1,
  'JHP_RS02520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagQ',
  'cag pathogenicity island type IV secretionsystem protein CagQ',
  530698,
  531078,
  -1,
  'JHP_RS02525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000466847.1',
  'hypothetical protein',
  531015,
  531194,
  -1,
  'JHP_RS08610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagP',
  'cag pathogenicity island protein CagP',
  531505,
  531849,
  -1,
  'JHP_RS02535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagM',
  'type IV secretion system apparatus protein CagM',
  532464,
  533594,
  1,
  'JHP_RS02540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagN',
  'cag pathogenicity island type IV secretionsystem protein CagN',
  533609,
  534529,
  1,
  'JHP_RS02545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagL',
  'cag pathogenicity island VirB5 familyT4SS-associated adhesin CagL',
  534611,
  535324,
  -1,
  'JHP_RS02550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagI',
  'cag pathogenicity island type IV secretionsystem translocation protein CagI',
  535321,
  536466,
  -1,
  'JHP_RS02555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000125264.1',
  'hypothetical protein',
  536477,
  537421,
  -1,
  'JHP_RS02560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000562365.1',
  'hypothetical protein',
  537408,
  537617,
  1,
  'JHP_RS08615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagG',
  'cag pathogenicity island type IV secretionsystem translocation protein CagG',
  537606,
  538034,
  -1,
  'JHP_RS02570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagF',
  'type IV secretion system chaperone CagF',
  538089,
  538895,
  -1,
  'JHP_RS02575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagE',
  'cag pathogenicity island type IV secretionsystem ATPase CagE',
  538897,
  541848,
  -1,
  'JHP_RS02580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagD',
  'cag pathogenicity island type IV secretionsystem protein CagD',
  541857,
  542480,
  -1,
  'JHP_RS02585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagC',
  'cag pathogenicity island type IV secretionsystem protein CagC',
  542485,
  542832,
  -1,
  'JHP_RS02590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagB',
  'cag pathogenicity island protein B',
  542976,
  543203,
  -1,
  'JHP_RS02595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cagA',
  'type IV secretion system oncogenic effectorCagA',
  543605,
  547108,
  1,
  'JHP_RS02600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  547171,
  547275,
  -1,
  'JHP_RS08870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_234618163.1',
  'C-terminal helicase domain-containing protein',
  547401,
  547754,
  1,
  'JHP_RS02605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'murI',
  'glutamate racemase',
  547927,
  548694,
  -1,
  'JHP_RS02610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rho',
  'transcription termination factor Rho',
  548734,
  550050,
  -1,
  'JHP_RS02615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmE',
  '50S ribosomal protein L31',
  550315,
  550518,
  1,
  'JHP_RS02620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rsmI',
  '16S rRNA(cytidine(1402)-2''-O)-methyltransferase',
  550542,
  551411,
  1,
  'JHP_RS02625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rlmB',
  '23S rRNA(guanosine(2251)-2''-O)-methyltransferase RlmB',
  551425,
  552108,
  1,
  'JHP_RS02630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000437282.1',
  'hypothetical protein',
  552121,
  553086,
  1,
  'JHP_RS02635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001037166.1',
  'hypothetical protein',
  553083,
  553904,
  1,
  'JHP_RS02640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000234650.1',
  'hypothetical protein',
  553975,
  554412,
  -1,
  'JHP_RS02645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'accA',
  'acetyl-CoA carboxylase carboxyl transferasesubunit alpha',
  554894,
  555832,
  -1,
  'JHP_RS02650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882524.1',
  'beta-ketoacyl-ACP synthase II',
  555854,
  557092,
  -1,
  'JHP_RS02655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'acpP',
  'acyl carrier protein',
  557195,
  557431,
  -1,
  'JHP_RS02660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fabG',
  '3-oxoacyl-ACP reductase FabG',
  557662,
  558405,
  -1,
  'JHP_RS02665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsU',
  '30S ribosomal protein S21',
  558444,
  558656,
  -1,
  'JHP_RS02670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000996960.1',
  'hypothetical protein',
  558757,
  560007,
  -1,
  'JHP_RS02675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000418875.1',
  'ribbon-helix-helix domain-containing protein',
  560181,
  560426,
  1,
  'JHP_RS02680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001148305.1',
  'YkgB family protein',
  560450,
  561097,
  -1,
  'JHP_RS02685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dapF',
  'diaminopimelate epimerase',
  561210,
  562031,
  -1,
  'JHP_RS02690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000647394.1',
  'AI-2E family transporter',
  562146,
  563195,
  1,
  'JHP_RS02695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_257616920.1',
  'hypothetical protein',
  563183,
  563314,
  1,
  'JHP_RS08740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000188557.1',
  'radical SAM/SPASM domain-containing protein',
  563901,
  564773,
  -1,
  'JHP_RS02700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ychF',
  'redox-regulated ATPase YchF',
  564812,
  565912,
  -1,
  'JHP_RS02705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000912895.1',
  'leucyl aminopeptidase',
  565914,
  567404,
  -1,
  'JHP_RS02710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000393392.1',
  'DedA family protein',
  567452,
  568030,
  -1,
  'JHP_RS02715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'apt',
  'adenine phosphoribosyltransferase',
  568045,
  568584,
  -1,
  'JHP_RS02720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000495098.1',
  'hypothetical protein',
  568645,
  568977,
  -1,
  'JHP_RS02725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpiB',
  'ribose 5-phosphate isomerase B',
  569028,
  569483,
  -1,
  'JHP_RS02730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001159409.1',
  'site-2 protease family protein',
  569502,
  570200,
  -1,
  'JHP_RS02735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lepB',
  'signal peptidase I',
  570209,
  571081,
  -1,
  'JHP_RS02740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'folD',
  'bifunctional methylenetetrahydrofolatedehydrogenase/methenyltetrahydrofolate cyclohydrolaseFolD',
  571081,
  571953,
  -1,
  'JHP_RS02745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000803649.1',
  'LTA synthase family protein',
  572039,
  574075,
  -1,
  'JHP_RS02750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000470917.1',
  '3-deoxy-d-manno-octulosonic acid hydrolasesubunit 1',
  574084,
  574635,
  -1,
  'JHP_RS02755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000433754.1',
  '3-deoxy-d-manno-octulosonic acid hydrolasesubunit 2',
  574642,
  575760,
  -1,
  'JHP_RS02760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pyrC',
  'dihydroorotase',
  575736,
  576755,
  -1,
  'JHP_RS02765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001114784.1',
  'energy transducer TonB',
  576760,
  577713,
  -1,
  'JHP_RS02770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001237764.1',
  'hypothetical protein',
  577697,
  578578,
  -1,
  'JHP_RS02775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliN',
  'flagellar motor switch protein FliN',
  578575,
  578946,
  -1,
  'JHP_RS02780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nth',
  'endonuclease III',
  579028,
  579672,
  -1,
  'JHP_RS02785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000174108.1',
  'FeoA family protein',
  579669,
  579905,
  -1,
  'JHP_RS02790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882528.1',
  'DUF3971 domain-containing protein',
  579902,
  582838,
  -1,
  'JHP_RS02795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mltG',
  'endolytic transglycosylase MltG',
  582756,
  583745,
  1,
  'JHP_RS02800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001096850.1',
  '4Fe-4S dicluster domain-containing protein',
  583930,
  584271,
  1,
  'JHP_RS02805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001206850.1',
  '2-oxoglutarate synthase subunit alpha',
  584271,
  585398,
  1,
  'JHP_RS02810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000885333.1',
  '2-oxoglutarate ferredoxin oxidoreductase subunitbeta',
  585400,
  586221,
  1,
  'JHP_RS02815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000388018.1',
  '2-oxoacid:acceptor oxidoreductase familyprotein',
  586221,
  586775,
  1,
  'JHP_RS02820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001224732.1',
  'HAD-IA family hydrolase',
  586889,
  588664,
  1,
  'JHP_RS02825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000394803.1',
  'hypothetical protein',
  588823,
  588987,
  1,
  'JHP_RS08480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001031603.1',
  'disulfide bond formation protein B',
  588997,
  590469,
  1,
  'JHP_RS02835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rnpB',
  '—',
  590505,
  590820,
  1,
  'JHP_RS07860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_237410173.1',
  'tumor necrosis factor alpha-inducing protein',
  590998,
  591516,
  1,
  'JHP_RS02840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000913647.1',
  'penicillin-binding protein 1A',
  591519,
  593501,
  -1,
  'JHP_RS02845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000491878.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  593501,
  594622,
  -1,
  'JHP_RS02850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tlpD',
  'chemotaxis chemoreceptor TlpD',
  594645,
  595946,
  -1,
  'JHP_RS02855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882529.1',
  'ATP-binding cassette domain-containing protein',
  596018,
  597787,
  -1,
  'JHP_RS02860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000885496.1',
  'flagellin A',
  597954,
  599486,
  1,
  'JHP_RS02865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000887176.1',
  '3-methyladenine DNA glycosylase',
  599604,
  600260,
  1,
  'JHP_RS02870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000577388.1',
  'hypothetical protein',
  600257,
  600874,
  1,
  'JHP_RS02875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemE',
  'uroporphyrinogen decarboxylase',
  600943,
  601962,
  1,
  'JHP_RS02880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hefA',
  'efflux RND transporter outer membrane subunitHefA',
  601972,
  603405,
  1,
  'JHP_RS02885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hefB',
  'efflux RND transporter periplasmic adaptorsubunit HefB',
  603416,
  604120,
  1,
  'JHP_RS02890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hefC',
  'efflux RND transporter permease subunit HefC',
  604133,
  607219,
  1,
  'JHP_RS02895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000716812.1',
  'outer membrane beta-barrel protein',
  607216,
  607785,
  1,
  'JHP_RS02900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000222280.1',
  'vacuolating cytotoxin domain-containing protein',
  607948,
  617532,
  1,
  'JHP_RS02905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'ABC transporter substrate-binding protein',
  617586,
  617835,
  -1,
  'JHP_RS08620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'ATP-binding cassette domain-containing protein',
  617869,
  618068,
  -1,
  'JHP_RS08470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000399924.1',
  'hypothetical protein',
  618350,
  618682,
  -1,
  'JHP_RS02915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ligA',
  'NAD-dependent DNA ligase LigA',
  618855,
  620825,
  -1,
  'JHP_RS02920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000251153.1',
  'chemotaxis protein',
  620896,
  621837,
  1,
  'JHP_RS02925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'aspS',
  'aspartate--tRNA ligase',
  621872,
  623611,
  1,
  'JHP_RS02930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000811254.1',
  'adenylate kinase',
  623623,
  624198,
  1,
  'JHP_RS02935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000580752.1',
  'glycosyltransferase family 25 protein',
  624223,
  625221,
  1,
  'JHP_RS02940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000195572.1',
  'glycosyltransferase family 25 protein',
  625279,
  625845,
  1,
  'JHP_RS08530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_046655497.1',
  'glycosyltransferase family 25 protein',
  625823,
  626575,
  1,
  'JHP_RS08535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ppa',
  'inorganic diphosphatase',
  626631,
  627152,
  1,
  'JHP_RS02955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000981758.1',
  'endonuclease MutS2',
  627301,
  629550,
  -1,
  'JHP_RS02960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000537703.1',
  'hypothetical protein',
  629550,
  629912,
  -1,
  'JHP_RS02965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'murC',
  'UDP-N-acetylmuramate--L-alanine ligase',
  629912,
  631261,
  -1,
  'JHP_RS02970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000142375.1',
  'succinyldiaminopimelate transaminase',
  631254,
  632381,
  -1,
  'JHP_RS02975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ispG',
  'flavodoxin-dependent(E)-4-hydroxy-3-methylbut-2-enyl-diphosphate synthase',
  632534,
  633613,
  1,
  'JHP_RS02980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000981193.1',
  '2,3,4,5-tetrahydropyridine-2,6-carboxylateN-succinyltransferase',
  633616,
  634821,
  1,
  'JHP_RS02985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000914856.1',
  'tetratricopeptide repeat protein',
  634833,
  635891,
  1,
  'JHP_RS02990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000648462.1',
  'DUF262 domain-containing protein',
  636104,
  638155,
  1,
  'JHP_RS02995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS02995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000756642.1',
  'NAD(P)H-dependent oxidoreductase',
  638201,
  638785,
  -1,
  'JHP_RS03000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000499106.1',
  'hydrogenase 1 small subunit',
  638943,
  640097,
  1,
  'JHP_RS03005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000038113.1',
  'nickel-dependent hydrogenase large subunit',
  640107,
  641843,
  1,
  'JHP_RS03010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cybH',
  'Ni/Fe-hydrogenase, b-type cytochrome subunit',
  641856,
  642530,
  1,
  'JHP_RS03015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hydD',
  'hydrogenase biosynthesis protein HydD',
  642527,
  643063,
  1,
  'JHP_RS03020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000232307.1',
  'hydrogenase biosynthesis protein HydE',
  643065,
  644603,
  1,
  'JHP_RS03025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001223763.1',
  'hypothetical protein',
  644608,
  645021,
  -1,
  'JHP_RS03030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000554098.1',
  'hypothetical protein',
  645140,
  645592,
  -1,
  'JHP_RS03035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'oipA',
  'outer inflammatory protein OipA',
  645773,
  646696,
  1,
  'JHP_RS03040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'queC',
  '7-cyano-7-deazaguanine synthase QueC',
  646935,
  647612,
  -1,
  'JHP_RS03045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000462303.1',
  'CCA tRNA nucleotidyltransferase',
  647674,
  648882,
  1,
  'JHP_RS03050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000210367.1',
  'SRPBCC domain-containing protein',
  648903,
  649406,
  1,
  'JHP_RS08625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882533.1',
  'NAD(P)-dependent oxidoreductase',
  649421,
  650278,
  1,
  'JHP_RS03060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'frxA',
  'NAD(P)H-dependent flavin oxidoreductase FrxA',
  650280,
  650933,
  1,
  'JHP_RS03065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000501757.1',
  'hypothetical protein',
  650990,
  651196,
  -1,
  'JHP_RS08785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gltX',
  'glutamate--tRNA ligase',
  651258,
  652577,
  1,
  'JHP_RS03075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000577930.1',
  'YggT family protein',
  652574,
  652867,
  1,
  'JHP_RS03080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001210385.1',
  'lytic transglycosylase domain-containingprotein',
  652876,
  654558,
  1,
  'JHP_RS03085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'galU',
  'UTP--glucose-1-phosphate uridylyltransferaseGalU',
  654555,
  655376,
  1,
  'JHP_RS03090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000527541.1',
  'hypothetical protein',
  655388,
  655795,
  1,
  'JHP_RS03095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'murA',
  'UDP-N-acetylglucosamine1-carboxyvinyltransferase',
  655798,
  657066,
  1,
  'JHP_RS03100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'aspA',
  'aspartate ammonia-lyase',
  657124,
  658530,
  1,
  'JHP_RS03105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000440339.1',
  'uracil-DNA glycosylase family protein',
  658575,
  659165,
  1,
  'JHP_RS03110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000487543.1',
  'glycosyltransferase family 10 domain-containingprotein',
  659174,
  660538,
  -1,
  'JHP_RS03115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'serB',
  'phosphoserine phosphatase SerB',
  660576,
  661199,
  -1,
  'JHP_RS03120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000949190.1',
  'ferritin',
  661214,
  661717,
  -1,
  'JHP_RS03125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mqnE',
  'aminofutalosine synthase MqnE',
  662016,
  663098,
  1,
  'JHP_RS03130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'bamA',
  'outer membrane protein assembly factor BamA',
  663181,
  665901,
  1,
  'JHP_RS03135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001222315.1',
  'dehypoxanthine futalosine cyclase',
  665903,
  666964,
  1,
  'JHP_RS03140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000721967.1',
  'M16 family metallopeptidase',
  666970,
  668277,
  1,
  'JHP_RS03145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gatB',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatB',
  668277,
  669701,
  1,
  'JHP_RS03150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001225940.1',
  'SurA N-terminal domain-containing protein',
  669701,
  670942,
  1,
  'JHP_RS03155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001163574.1',
  'hypothetical protein',
  670952,
  671959,
  1,
  'JHP_RS03160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rnhA',
  'ribonuclease HI',
  671961,
  672429,
  1,
  'JHP_RS03165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rnc',
  'ribonuclease III',
  672404,
  673123,
  1,
  'JHP_RS03170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'aroC',
  'chorismate synthase',
  673120,
  674217,
  1,
  'JHP_RS03175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000413462.1',
  'DUF2603 domain-containing protein',
  674254,
  674769,
  1,
  'JHP_RS03180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemN',
  'oxygen-independent coproporphyrinogen IIIoxidase',
  674769,
  676142,
  1,
  'JHP_RS03185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001005081.1',
  '(Fe-S)-binding protein',
  676139,
  677440,
  1,
  'JHP_RS03190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'type ISP restriction/modification enzyme',
  677518,
  682375,
  1,
  'JHP_RS03195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000715025.1',
  'outer membrane protein',
  682624,
  683436,
  1,
  'JHP_RS03200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001147083.1',
  'pyridoxal phosphate-dependent aminotransferase',
  683596,
  684768,
  1,
  'JHP_RS03205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882539.1',
  'hypothetical protein',
  684935,
  685726,
  1,
  'JHP_RS03210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'xerH',
  'tyrosine recombinase XerH',
  685741,
  686811,
  1,
  'JHP_RS03215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000177380.1',
  'methylated-DNA--[protein]-cysteineS-methyltransferase',
  686875,
  687381,
  -1,
  'JHP_RS03220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000356035.1',
  'sulfite exporter TauE/SafE family protein',
  687381,
  688148,
  -1,
  'JHP_RS03225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000895559.1',
  'Gfo/Idh/MocA family protein',
  688273,
  689220,
  -1,
  'JHP_RS03230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000633948.1',
  'ribonucleoside-diphosphate reductase subunitalpha',
  689282,
  691648,
  -1,
  'JHP_RS03235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000381664.1',
  'hypothetical protein',
  691820,
  692326,
  -1,
  'JHP_RS03240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000016184.1',
  'hypothetical protein',
  692366,
  692686,
  -1,
  'JHP_RS03245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glmU',
  'bifunctional UDP-N-acetylglucosaminediphosphorylase/glucosamine-1-phosphateN-acetyltransferase GlmU',
  692908,
  694209,
  -1,
  'JHP_RS03250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliP',
  'flagellar type III secretion system pore proteinFliP',
  694306,
  695052,
  1,
  'JHP_RS03255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000822072.1',
  'TonB-dependent receptor family protein',
  695096,
  697399,
  -1,
  'JHP_RS03260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'feoB',
  'ferrous iron transport protein B',
  697655,
  699583,
  -1,
  'JHP_RS03265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000882686.1',
  '3''-5'' exonuclease',
  699722,
  700534,
  1,
  'JHP_RS03270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001121730.1',
  'DNA-methyltransferase',
  700587,
  701801,
  1,
  'JHP_RS03275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001010348.1',
  'CfrBI family restriction endonuclease',
  701804,
  702676,
  1,
  'JHP_RS03280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001876581.1',
  'acetone carboxylase subunit gamma',
  702854,
  703354,
  -1,
  'JHP_RS03285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001285109.1',
  'hydantoinase B/oxoprolinase family protein',
  703378,
  705675,
  -1,
  'JHP_RS03290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000650659.1',
  'hydantoinase/oxoprolinase family protein',
  705687,
  707825,
  -1,
  'JHP_RS03295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000465260.1',
  'lipid A deacylase LpxR family protein',
  708056,
  709066,
  -1,
  'JHP_RS03300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000479426.1',
  'TIGR00366 family protein',
  709195,
  710559,
  -1,
  'JHP_RS03305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001206229.1',
  '3-oxoacid CoA-transferase subunit B',
  710579,
  711202,
  -1,
  'JHP_RS03310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001045176.1',
  'CoA transferase subunit A',
  711199,
  711897,
  -1,
  'JHP_RS03315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001006942.1',
  'acetyl-CoA C-acetyltransferase',
  711908,
  713083,
  -1,
  'JHP_RS03320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_307772102.1',
  'hypothetical protein',
  713432,
  714376,
  1,
  'JHP_RS03325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001279229.1',
  'diacylglycerol kinase',
  714369,
  714755,
  1,
  'JHP_RS03330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gyrA',
  'DNA topoisomerase (ATP-hydrolyzing) subunit A',
  714771,
  717257,
  1,
  'JHP_RS03335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882542.1',
  'hypothetical protein',
  717257,
  717730,
  1,
  'JHP_RS03340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgR',
  'transcriptional activator FlgR',
  717727,
  718872,
  1,
  'JHP_RS03345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF3519 domain-containing protein',
  718977,
  719097,
  -1,
  'JHP_RS08875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'uvrA',
  'excinuclease ABC subunit UvrA',
  719545,
  722370,
  -1,
  'JHP_RS03350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopE',
  'Hop family outer membrane protein HopE',
  722535,
  723356,
  1,
  'JHP_RS03355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rsmH',
  '16S rRNA (cytosine(1402)-N(4))-methyltransferaseRsmH',
  723528,
  724454,
  1,
  'JHP_RS03360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001022687.1',
  'hypothetical protein',
  724475,
  724819,
  1,
  'JHP_RS03365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001232621.1',
  'SAM hydrolase/SAM-dependent halogenase familyprotein',
  725292,
  726194,
  1,
  'JHP_RS03375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001228435.1',
  'porin family protein',
  726428,
  728401,
  1,
  'JHP_RS03380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000270534.1',
  'HD domain-containing protein',
  728591,
  729811,
  1,
  'JHP_RS03385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001106865.1',
  'Fic family protein',
  729811,
  730515,
  1,
  'JHP_RS03390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000996390.1',
  'RNA polymerase factor sigma-54',
  730527,
  731771,
  -1,
  'JHP_RS03395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lptB',
  'LPS export ABC transporter ATP-binding protein',
  731774,
  732496,
  -1,
  'JHP_RS03400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tsaE',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexATPase subunit type 1 TsaE',
  732509,
  732910,
  -1,
  'JHP_RS03405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001197579.1',
  'DNA polymerase III subunit gamma/tau',
  732907,
  734655,
  -1,
  'JHP_RS03410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000498397.1',
  'LysE family transporter',
  734722,
  735354,
  -1,
  'JHP_RS03415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001254639.1',
  'DUF1104 domain-containing protein',
  735622,
  736044,
  1,
  'JHP_RS03420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000709583.1',
  'sialic acid-binding protein',
  736072,
  736530,
  1,
  'JHP_RS03425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000542811.1',
  'Hop family adhesin SabA/HopD',
  736895,
  738760,
  1,
  'JHP_RS03430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882544.1',
  'anaerobic C4-dicarboxylate transporter',
  738830,
  740161,
  -1,
  'JHP_RS03435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925880.1',
  'asparaginase',
  740237,
  741289,
  1,
  'JHP_RS03440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'sabA',
  'Hop family adhesin SabA/HopD',
  741428,
  743332,
  -1,
  'JHP_RS03445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000532479.1',
  'outer membrane beta-barrel protein',
  743602,
  744519,
  -1,
  'JHP_RS03450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000346155.1',
  'tRNA dihydrouridine synthase',
  744489,
  745475,
  -1,
  'JHP_RS03455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tilS',
  'tRNA lysidine(34) synthetase TilS',
  745569,
  746585,
  -1,
  'JHP_RS03460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001016049.1',
  'HP0729 family protein',
  746621,
  747688,
  -1,
  'JHP_RS03465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_226928970.1',
  'hypothetical protein',
  747697,
  747948,
  -1,
  'JHP_RS03470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000787451.1',
  'LeoA/HP0731 family dynamin-like GTPase',
  748118,
  749827,
  -1,
  'JHP_RS03475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000789791.1',
  'hypothetical protein',
  749817,
  750932,
  -1,
  'JHP_RS08880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925881.1',
  'GTPase',
  750989,
  751555,
  -1,
  'JHP_RS08885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rimO',
  '30S ribosomal protein S12 methylthiotransferaseRimO',
  751670,
  752989,
  -1,
  'JHP_RS03490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000559412.1',
  'phosphoribosyltransferase',
  752991,
  753452,
  -1,
  'JHP_RS03495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000924045.1',
  'pyridoxal-phosphate-dependent aminotransferasefamily protein',
  753461,
  754570,
  -1,
  'JHP_RS03500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001031816.1',
  'phosphatidylglycerophosphatase A family protein',
  754717,
  755193,
  1,
  'JHP_RS03505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882547.1',
  'D-alanine--D-alanine ligase',
  755270,
  756313,
  1,
  'JHP_RS03510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'estV',
  'lipase EstV',
  756314,
  757039,
  1,
  'JHP_RS03515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001191257.1',
  'Mur ligase family protein',
  757026,
  758507,
  1,
  'JHP_RS03520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001164427.1',
  'HIT family protein',
  758517,
  759002,
  1,
  'JHP_RS03525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000647440.1',
  'ribose-phosphate pyrophosphokinase',
  759067,
  760023,
  1,
  'JHP_RS03530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  760036,
  760112,
  -1,
  'JHP_RS03535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882548.1',
  'FtsW/RodA/SpoVE family cell cycle protein',
  760074,
  761219,
  -1,
  'JHP_RS08055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000269022.1',
  'YcjF family protein',
  761242,
  762063,
  -1,
  'JHP_RS03540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000400741.1',
  'GTPase',
  761990,
  762454,
  -1,
  'JHP_RS03545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001174338.1',
  'RluA family pseudouridine synthase',
  762588,
  763571,
  1,
  'JHP_RS03550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000731375.1',
  'fibronectin type III domain-containing protein',
  763534,
  764781,
  1,
  'JHP_RS03555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trmB',
  'tRNA (guanosine(46)-N7)-methyltransferase TrmB',
  764792,
  765994,
  1,
  'JHP_RS03560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000111100.1',
  'ABC transporter ATP-binding protein',
  765969,
  766640,
  1,
  'JHP_RS03565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001094134.1',
  'FtsX-like permease family protein',
  766627,
  767433,
  1,
  'JHP_RS03570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000277298.1',
  'murein hydrolase activator EnvC family protein',
  767426,
  768628,
  1,
  'JHP_RS03575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000245945.1',
  'FlaG family protein',
  768725,
  769084,
  1,
  'JHP_RS03580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliD',
  'flagellar filament capping protein FliD',
  769101,
  771158,
  1,
  'JHP_RS03585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliS',
  'flagellar export chaperone FliS',
  771200,
  771580,
  1,
  'JHP_RS03590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001087792.1',
  'hypothetical protein',
  771567,
  771806,
  1,
  'JHP_RS03595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001294102.1',
  'tRNA threonylcarbamoyladenosine dehydratase',
  771859,
  772566,
  1,
  'JHP_RS03600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000656207.1',
  'hypothetical protein',
  772532,
  772678,
  1,
  'JHP_RS08485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000617290.1',
  'carbon-nitrogen hydrolase',
  772682,
  773560,
  1,
  'JHP_RS03610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000892616.1',
  'Na+/H+ antiporter family protein',
  773687,
  775000,
  1,
  'JHP_RS03615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_244372573.1',
  'MATE family efflux transporter',
  775000,
  776316,
  1,
  'JHP_RS03620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rny',
  'ribonuclease Y',
  776317,
  777828,
  -1,
  'JHP_RS03625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993021.1',
  '5-formyltetrahydrofolate cyclo-ligase',
  777806,
  778474,
  -1,
  'JHP_RS03630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001220395.1',
  'hypothetical protein',
  778572,
  779129,
  1,
  'JHP_RS03635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ftsY',
  'signal recognition particle-docking proteinFtsY',
  779135,
  780016,
  1,
  'JHP_RS03640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925926.1',
  'YkgJ family cysteine cluster protein',
  780303,
  780623,
  -1,
  'JHP_RS03645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'sortase',
  780684,
  781686,
  -1,
  'JHP_RS03650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  782013,
  782674,
  -1,
  'JHP_RS03660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'moaA',
  'GTP 3'',8-cyclase MoaA',
  782926,
  783891,
  -1,
  'JHP_RS03665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mobA',
  'molybdenum cofactor guanylyltransferase MobA',
  783977,
  784606,
  1,
  'JHP_RS03670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flhB',
  'flagellar biosynthesis protein FlhB',
  784575,
  785651,
  1,
  'JHP_RS03675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001012421.1',
  'hypothetical protein',
  785746,
  786483,
  -1,
  'JHP_RS03680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000961114.1',
  'N-acetylmuramoyl-L-alanine amidase familyprotein',
  786502,
  787911,
  -1,
  'JHP_RS03685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fabX',
  'decanoate oxidase/trans-2-decenoyl-[acyl-carrierprotein] isomerase FabX',
  787918,
  789009,
  -1,
  'JHP_RS03690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tyrS',
  'tyrosine--tRNA ligase',
  789026,
  790234,
  -1,
  'JHP_RS03695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001002179.1',
  'RelA/SpoT family protein',
  790254,
  792584,
  -1,
  'JHP_RS03700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000712202.1',
  'DNA-directed RNA polymerase subunit omega',
  792571,
  792795,
  -1,
  'JHP_RS03705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pyrH',
  'UMP kinase',
  792837,
  793559,
  -1,
  'JHP_RS03710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001210702.1',
  'MqnA/MqnD/SBP family protein',
  793650,
  794333,
  -1,
  'JHP_RS03715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'acnB',
  'bifunctional aconitate hydratase2/2-methylisocitrate dehydratase',
  794464,
  797022,
  1,
  'JHP_RS03720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000725280.1',
  'hypothetical protein',
  797103,
  797369,
  1,
  'JHP_RS03725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_105874748.1',
  'hypothetical protein',
  797451,
  797636,
  1,
  'JHP_RS08630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001146048.1',
  'DDE transposase',
  797664,
  798953,
  1,
  'JHP_RS03735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882559.1',
  'outer membrane family protein',
  799047,
  800414,
  1,
  'JHP_RS03740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001168737.1',
  'hypothetical protein',
  800421,
  800948,
  -1,
  'JHP_RS03745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ssrA',
  '—',
  800992,
  801377,
  -1,
  'JHP_RS08065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lolA',
  'LolA-like outer membrane lipoprotein chaperone',
  801433,
  801987,
  -1,
  'JHP_RS03755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'secA',
  'preprotein translocase subunit SecA',
  802134,
  804731,
  1,
  'JHP_RS03760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001133777.1',
  'ABC transporter permease',
  804721,
  805953,
  1,
  'JHP_RS03765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hofF',
  'outer membrane beta-barrel protein HofF',
  806232,
  807731,
  1,
  'JHP_RS03770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001033117.1',
  'restriction endonuclease subunit S',
  807943,
  809307,
  -1,
  'JHP_RS03775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001158764.1',
  'heavy metal translocating P-type ATPase',
  809351,
  811411,
  -1,
  'JHP_RS03780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000611047.1',
  'YifB family Mg chelatase-like AAA ATPase',
  811436,
  812956,
  -1,
  'JHP_RS03785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'def',
  'peptide deformylase',
  812962,
  813486,
  -1,
  'JHP_RS03790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'clpP',
  'ATP-dependent Clp endopeptidase proteolyticsubunit ClpP',
  813491,
  814078,
  -1,
  'JHP_RS03795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tig',
  'trigger factor',
  814099,
  815454,
  -1,
  'JHP_RS03800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001037714.1',
  'outer membrane protein',
  815567,
  816403,
  -1,
  'JHP_RS03805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hpaA',
  'flagellar sheath lipoprotein HpaA',
  816425,
  817207,
  -1,
  'JHP_RS03810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'moaC',
  'cyclic pyranopterin monophosphate synthase MoaC',
  817326,
  817802,
  -1,
  'JHP_RS03815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mog',
  'molybdopterin adenylyltransferase',
  817811,
  818341,
  -1,
  'JHP_RS03820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000913141.1',
  'molybdenum cofactor biosynthesis protein MoaE',
  818354,
  818791,
  -1,
  'JHP_RS03825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000230583.1',
  'MoaD/ThiS family protein',
  818792,
  819013,
  -1,
  'JHP_RS03830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ribA',
  'GTP cyclohydrolase II',
  819062,
  819640,
  -1,
  'JHP_RS03835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_226928971.1',
  'DUF3943 domain-containing protein',
  819730,
  820476,
  -1,
  'JHP_RS03840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000603435.1',
  'bifunctional 3,4-dihydroxy-2-butanone4-phosphate synthase/GTP cyclohydrolase II',
  820656,
  821690,
  -1,
  'JHP_RS03845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001263265.1',
  'glycosyltransferase family 25 protein',
  821788,
  822633,
  -1,
  'JHP_RS03850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000886492.1',
  'M48 family metallopeptidase',
  822715,
  823335,
  1,
  'JHP_RS03855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001014888.1',
  'TonB-dependent receptor family protein',
  823346,
  825724,
  -1,
  'JHP_RS03860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'acpS',
  'holo-ACP synthase',
  825922,
  826281,
  -1,
  'JHP_RS03865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliL',
  'flagellar basal body-associated protein FliL',
  826288,
  826839,
  -1,
  'JHP_RS03870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rsmD',
  '16S rRNA (guanine(966)-N(2))-methyltransferaseRsmD',
  826848,
  827450,
  -1,
  'JHP_RS03875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000688970.1',
  'hypothetical protein',
  827429,
  827755,
  -1,
  'JHP_RS03880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_160442652.1',
  'SAM-dependent methyltransferase',
  828209,
  829243,
  -1,
  'JHP_RS03885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000404742.1',
  'MBL fold metallo-hydrolase',
  829352,
  829969,
  1,
  'JHP_RS03890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000952569.1',
  'HesA/MoeB/ThiF family protein',
  829970,
  830737,
  1,
  'JHP_RS03895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'motA',
  'flagellar motor stator protein MotA',
  830753,
  831526,
  1,
  'JHP_RS03900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'motB',
  'flagellar motor protein MotB',
  831529,
  832302,
  1,
  'JHP_RS03905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000802458.1',
  'hypothetical protein',
  832308,
  832745,
  1,
  'JHP_RS03910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'osmoprotection protein',
  832859,
  833209,
  1,
  'JHP_RS08385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000916528.1',
  'Hpy99I family type II restriction endonuclease',
  833221,
  833793,
  -1,
  'JHP_RS03915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000125523.1',
  'DNA-methyltransferase',
  833787,
  834605,
  -1,
  'JHP_RS03920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001133307.1',
  'ergothioneine transport permease/ergothioneinebinding protein EgtU',
  834901,
  836562,
  1,
  'JHP_RS03925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000659408.1',
  'ergothioneine transport ATP-binding proteinEgtV',
  836565,
  837215,
  1,
  'JHP_RS03930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001872805.1',
  'hypothetical protein',
  837219,
  837398,
  -1,
  'JHP_RS03935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000437154.1',
  'hypothetical protein',
  837390,
  837851,
  1,
  'JHP_RS03940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'uvrC',
  'excinuclease ABC subunit UvrC',
  837852,
  839636,
  1,
  'JHP_RS03945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000746834.1',
  'homoserine dehydrogenase',
  839646,
  840911,
  1,
  'JHP_RS03950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001211704.1',
  'YraN family protein',
  840912,
  841256,
  1,
  'JHP_RS03955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trxA',
  'thioredoxin',
  841348,
  841668,
  1,
  'JHP_RS03960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trxB',
  'thioredoxin-disulfide reductase',
  841674,
  842609,
  1,
  'JHP_RS03965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001263351.1',
  'glycosyltransferase family 25 protein',
  842976,
  843797,
  1,
  'JHP_RS03970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000790555.1',
  'RNA-binding protein',
  844007,
  844255,
  -1,
  'JHP_RS03975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000401209.1',
  'F0F1 ATP synthase subunit A',
  844583,
  845263,
  -1,
  'JHP_RS03980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'guaB',
  'IMP dehydrogenase',
  845385,
  846830,
  -1,
  'JHP_RS03985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gatA',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatA',
  846840,
  848201,
  -1,
  'JHP_RS03990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'coaE',
  'dephospho-CoA kinase',
  848260,
  848850,
  -1,
  'JHP_RS03995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS03995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000265148.1',
  'spermidine synthase',
  848852,
  849640,
  -1,
  'JHP_RS04000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000480346.1',
  'hypothetical protein',
  849733,
  850623,
  -1,
  'JHP_RS04005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'der',
  'ribosome biogenesis GTPase Der',
  850700,
  852088,
  1,
  'JHP_RS04010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001029103.1',
  'HU family DNA-binding protein',
  852229,
  852513,
  1,
  'JHP_RS04015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  852570,
  852646,
  1,
  'JHP_RS04020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001236612.1',
  'LPP20 family lipoprotein',
  853193,
  853798,
  1,
  'JHP_RS04025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001268717.1',
  'HP0838 family lipoprotein',
  853818,
  854435,
  1,
  'JHP_RS04030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000788051.1',
  'OmpP1/FadL family transporter',
  854432,
  856195,
  1,
  'JHP_RS04035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pseB',
  'UDP-N-acetylglucosamine 4,6-dehydratase(inverting)',
  856217,
  857200,
  1,
  'JHP_RS04040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'coaBC',
  'bifunctional phosphopantothenoylcysteinedecarboxylase/phosphopantothenate--cysteine ligase CoaBC',
  857197,
  858474,
  1,
  'JHP_RS04045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000888427.1',
  'hypothetical protein',
  858474,
  859211,
  1,
  'JHP_RS04050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thiE',
  'thiamine phosphate synthase',
  859321,
  859974,
  -1,
  'JHP_RS04055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thiD',
  'bifunctional hydroxymethylpyrimidinekinase/phosphomethylpyrimidine kinase',
  859967,
  860776,
  -1,
  'JHP_RS04060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thiM',
  'hydroxyethylthiazole kinase',
  860773,
  861552,
  -1,
  'JHP_RS04065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001105652.1',
  'HsdR family type I site-specificdeoxyribonuclease',
  861645,
  864665,
  -1,
  'JHP_RS04070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001033149.1',
  'restriction endonuclease subunit S',
  864828,
  865451,
  -1,
  'JHP_RS04075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000432253.1',
  'type I restriction-modification system subunitM',
  865462,
  867048,
  -1,
  'JHP_RS04080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993059.1',
  'type I restriction endonuclease subunit M',
  867015,
  867209,
  -1,
  'JHP_RS08790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000230864.1',
  'phosphatase PAP2 family protein',
  867227,
  867913,
  1,
  'JHP_RS04085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'HrgA protein',
  867937,
  868897,
  -1,
  'JHP_RS04090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000942177.1',
  'ABC-F family ATP-binding cassettedomain-containing protein',
  868894,
  870495,
  -1,
  'JHP_RS04095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000862247.1',
  'GMP reductase',
  870697,
  871674,
  1,
  'JHP_RS04100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gmhA',
  'D-sedoheptulose 7-phosphate isomerase',
  871698,
  872276,
  -1,
  'JHP_RS04105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rfaE1',
  'D-glycero-beta-D-manno-heptose-7-phosphatekinase',
  872269,
  873660,
  -1,
  'JHP_RS04110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rfaD',
  'ADP-glyceromanno-heptose 6-epimerase',
  873657,
  874646,
  -1,
  'JHP_RS04115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gmhB',
  'D-glycero-beta-D-manno-heptose 1,7-bisphosphate7-phosphatase',
  874656,
  875180,
  -1,
  'JHP_RS04120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001178250.1',
  'sulfite exporter TauE/SafE family protein',
  875167,
  875904,
  -1,
  'JHP_RS04125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001111534.1',
  'type III pantothenate kinase',
  875895,
  876566,
  -1,
  'JHP_RS04130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pgbB',
  'plasminogen-binding protein PgbB',
  876571,
  878196,
  -1,
  'JHP_RS04135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000023048.1',
  'hypothetical protein',
  878201,
  878857,
  -1,
  'JHP_RS04140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dut',
  'dUTP diphosphatase',
  878854,
  879291,
  -1,
  'JHP_RS04145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'greA',
  'transcription elongation factor GreA',
  879281,
  879775,
  -1,
  'JHP_RS04150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpxB',
  'lipid-A-disaccharide synthase',
  879816,
  880898,
  -1,
  'JHP_RS04155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mua',
  'nickel-binding protein Mua',
  880898,
  881359,
  -1,
  'JHP_RS04160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hypA',
  'hydrogenase/urease nickel incorporation proteinHypA',
  881366,
  881719,
  -1,
  'JHP_RS04165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgE',
  'flagellar hook protein FlgE',
  881778,
  883934,
  -1,
  'JHP_RS04170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cdh',
  'CDP-diacylglycerol diphosphatase',
  884143,
  884961,
  -1,
  'JHP_RS04175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001153433.1',
  'zinc ribbon domain-containing protein YjdM',
  885154,
  885483,
  1,
  'JHP_RS04180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001206523.1',
  'hypothetical protein',
  885541,
  885756,
  -1,
  'JHP_RS04185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000828898.1',
  'twin-arginine translocation signaldomain-containing protein',
  885841,
  886719,
  -1,
  'JHP_RS04190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000247320.1',
  'catalase',
  886867,
  888384,
  -1,
  'JHP_RS04195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000479919.1',
  'TonB-dependent receptor',
  888708,
  891083,
  1,
  'JHP_RS04200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ruvC',
  'crossover junction endodeoxyribonuclease RuvC',
  891084,
  891557,
  -1,
  'JHP_RS04205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000646774.1',
  'NYN domain-containing protein',
  891689,
  892420,
  1,
  'JHP_RS04210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_164473355.1',
  'hypothetical protein',
  893133,
  893306,
  -1,
  'JHP_RS08490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925884.1',
  'DUF3519 domain-containing protein',
  893499,
  893942,
  -1,
  'JHP_RS04215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF3519 domain-containing protein',
  893935,
  894340,
  -1,
  'JHP_RS08635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ruvA',
  'Holliday junction branch migration protein RuvA',
  894351,
  894902,
  -1,
  'JHP_RS04225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000051270.1',
  'hypothetical protein',
  894929,
  896773,
  -1,
  'JHP_RS04230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'murJ',
  'murein biosynthesis integral membrane proteinMurJ',
  896866,
  898326,
  1,
  'JHP_RS04235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cysS',
  'cysteine--tRNA ligase',
  898327,
  899724,
  1,
  'JHP_RS04240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000405515.1',
  'vacuolating cyotoxin family protein',
  900011,
  903877,
  1,
  'JHP_RS04245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000702825.1',
  'glycosyltransferase family 8 protein',
  903994,
  905115,
  -1,
  'JHP_RS04250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000242348.1',
  'ABC transporter ATP-binding protein',
  905179,
  905946,
  -1,
  'JHP_RS04255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000921464.1',
  'FecCD family ABC transporter permease',
  905946,
  906926,
  -1,
  'JHP_RS04260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000538063.1',
  'SDR family oxidoreductase',
  906919,
  907776,
  -1,
  'JHP_RS04265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001135603.1',
  'acyl-CoA thioesterase',
  907916,
  908440,
  1,
  'JHP_RS04270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000889627.1',
  'type II toxin-antitoxin system YafQ familytoxin',
  908515,
  908817,
  -1,
  'JHP_RS04275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000867414.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  908966,
  910294,
  -1,
  'JHP_RS04280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tnpA',
  'IS200/IS605-like element IS606 familytransposase',
  910322,
  910516,
  1,
  'JHP_RS08390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000917077.1',
  'hypothetical protein',
  910638,
  910844,
  -1,
  'JHP_RS04290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000820666.1',
  'hypothetical protein',
  910912,
  911058,
  -1,
  'JHP_RS08455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001134119.1',
  'hypothetical protein',
  911422,
  911673,
  -1,
  'JHP_RS04295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001880357.1',
  'HP0892 family type II toxin-antitoxin systemmRNA interferase toxin',
  911721,
  911993,
  -1,
  'JHP_RS04300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001134114.1',
  'type II toxin-antitoxin system antitoxin',
  912007,
  912294,
  -1,
  'JHP_RS04305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'babA',
  'Hop family adhesin BabA',
  912790,
  915024,
  -1,
  'JHP_RS04310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  915399,
  915475,
  -1,
  'JHP_RS04315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  915508,
  915582,
  -1,
  'JHP_RS04320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  915651,
  916171,
  1,
  'JHP_RS08890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  916333,
  916431,
  -1,
  'JHP_RS08895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hypD',
  'hydrogenase formation protein HypD',
  916398,
  917510,
  -1,
  'JHP_RS04330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000335461.1',
  'HypC/HybG/HupF family hydrogenase formationchaperone',
  917525,
  917761,
  -1,
  'JHP_RS04335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hypB',
  'hydrogenase nickel incorporation protein HypB',
  917761,
  918489,
  -1,
  'JHP_RS04340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000973849.1',
  'hypothetical protein',
  918602,
  918730,
  -1,
  'JHP_RS08745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001243100.1',
  'cupin domain-containing protein',
  918741,
  919040,
  -1,
  'JHP_RS04350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000404800.1',
  'acetate kinase',
  919040,
  920251,
  -1,
  'JHP_RS04355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pta',
  'phosphate acetyltransferase',
  920263,
  921822,
  -1,
  'JHP_RS04360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001139992.1',
  'flagellar hook-length control protein FliK',
  922003,
  923577,
  1,
  'JHP_RS04365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgD',
  'flagellar hook assembly protein FlgD',
  923628,
  924719,
  1,
  'JHP_RS04370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001000278.1',
  'flagellar hook protein FlgE',
  924716,
  926533,
  1,
  'JHP_RS04375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'restriction endonuclease',
  926585,
  927207,
  1,
  'JHP_RS04380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000427189.1',
  'Eco57I restriction-modification methylasedomain-containing protein',
  927176,
  928321,
  1,
  'JHP_RS04385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000894602.1',
  'ATP-dependent helicase',
  928330,
  930360,
  1,
  'JHP_RS04390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925885.1',
  'hypothetical protein',
  931215,
  931394,
  -1,
  'JHP_RS08650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'alpA',
  'Hop family adhesin AlpA',
  931524,
  933086,
  1,
  'JHP_RS04400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'alpB',
  'Hop family adhesin AlpB',
  933108,
  934691,
  1,
  'JHP_RS04405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hofG',
  'outer membrane beta-barrel protein HofG',
  935476,
  937020,
  -1,
  'JHP_RS04410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000998444.1',
  'TonB-dependent receptor domain-containingprotein',
  937358,
  939805,
  -1,
  'JHP_RS04420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001229954.1',
  'hypothetical protein',
  939981,
  940412,
  -1,
  'JHP_RS04425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'carB',
  'carbamoyl-phosphate synthase large subunit',
  940417,
  943674,
  -1,
  'JHP_RS04430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001240296.1',
  'Bax inhibitor-1/YccA family protein',
  943774,
  944466,
  -1,
  'JHP_RS04435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gap',
  'type I glyceraldehyde-3-phosphate dehydrogenase',
  944612,
  945610,
  1,
  'JHP_RS04440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000874591.1',
  'vacuolating cytotoxin domain-containing protein',
  945691,
  952890,
  1,
  'JHP_RS04445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopJ',
  'Hop family outer membrane protein HopJ/HopK',
  952943,
  954043,
  1,
  'JHP_RS04450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001115880.1',
  '2-hydroxymuconate tautomerase family protein',
  954113,
  954319,
  -1,
  'JHP_RS04455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'recR',
  'recombination mediator RecR',
  954488,
  955069,
  1,
  'JHP_RS04460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'truD',
  'tRNA pseudouridine(13) synthase TruD',
  955066,
  956211,
  1,
  'JHP_RS04465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'htpX',
  'zinc metalloprotease HtpX',
  956198,
  957130,
  1,
  'JHP_RS04470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'GTP cyclohydrolase I',
  957131,
  957325,
  1,
  'JHP_RS04475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'M48 family metalloprotease',
  957328,
  957597,
  1,
  'JHP_RS04480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'folE',
  'GTP cyclohydrolase I FolE',
  957598,
  958140,
  1,
  'JHP_RS04485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000070317.1',
  'polyprenyl synthetase family protein',
  958156,
  959067,
  1,
  'JHP_RS04490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'surE',
  '5''/3''-nucleotidase SurE',
  959064,
  959867,
  1,
  'JHP_RS04495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001034747.1',
  'hypothetical protein',
  959864,
  960523,
  1,
  'JHP_RS04500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000236788.1',
  '6-pyruvoyl trahydropterin synthase familyprotein',
  960525,
  961127,
  1,
  'JHP_RS04505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000775630.1',
  '7-carboxy-7-deazaguanine synthase QueE',
  961124,
  961879,
  1,
  'JHP_RS04510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000152840.1',
  'GNAT family N-acetyltransferase',
  961971,
  962456,
  1,
  'JHP_RS04515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001228434.1',
  'porin family protein',
  962682,
  964688,
  1,
  'JHP_RS04520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925887.1',
  'MFS transporter',
  965126,
  966508,
  -1,
  'JHP_RS04525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF262 domain-containing protein',
  966767,
  968473,
  -1,
  'JHP_RS08795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882575.1',
  'amino acid ABC transporter permease',
  968545,
  969258,
  -1,
  'JHP_RS04540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000723905.1',
  'amino acid ABC transporter substrate-bindingprotein',
  969242,
  970015,
  -1,
  'JHP_RS04545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'alr',
  'alanine racemase',
  970081,
  971214,
  -1,
  'JHP_RS04550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000447629.1',
  'alanine/glycine:cation symporter family protein',
  971221,
  972573,
  -1,
  'JHP_RS04555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000712569.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  972614,
  973846,
  -1,
  'JHP_RS04560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000665816.1',
  'RidA family protein',
  973869,
  974246,
  -1,
  'JHP_RS04565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  974561,
  974636,
  1,
  'JHP_RS04570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  974676,
  974762,
  1,
  'JHP_RS04575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  974816,
  974890,
  1,
  'JHP_RS04580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  974940,
  975027,
  1,
  'JHP_RS04585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001888873.1',
  'Na+/H+ antiporter NhaC family protein',
  975154,
  976635,
  1,
  'JHP_RS04590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000953795.1',
  'hypothetical protein',
  976960,
  977322,
  1,
  'JHP_RS04595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001213467.1',
  'LapA family protein',
  977734,
  978747,
  -1,
  'JHP_RS04600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rlmH',
  '23S rRNA(pseudouridine(1915)-N(3))-methyltransferase RlmH',
  978757,
  979209,
  -1,
  'JHP_RS04605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'accD',
  'acetyl-CoA carboxylase, carboxyltransferasesubunit beta',
  979223,
  980092,
  -1,
  'JHP_RS04610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'recO',
  'recombination protein RecO',
  980173,
  980787,
  1,
  'JHP_RS04615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000669179.1',
  'CinA family protein',
  980798,
  981454,
  1,
  'JHP_RS04620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000476721.1',
  'hypothetical protein',
  981457,
  982023,
  -1,
  'JHP_RS04625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rdxA',
  'oxygen-insensitive NAD(P)H-dependentoxidoreductase RdxA',
  982088,
  982720,
  -1,
  'JHP_RS04630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lgt',
  'prolipoprotein diacylglyceryl transferase',
  982720,
  983571,
  -1,
  'JHP_RS04635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000409675.1',
  'RluA family pseudouridine synthase',
  983580,
  984308,
  -1,
  'JHP_RS04640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'waaA',
  'lipid IV(A) 3-deoxy-D-manno-octulosonic acidtransferase',
  984326,
  985507,
  -1,
  'JHP_RS04645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001091806.1',
  'zinc ribbon domain-containing protein',
  985508,
  986311,
  -1,
  'JHP_RS04650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001229751.1',
  'GTP cyclohydrolase I',
  986321,
  987052,
  -1,
  'JHP_RS04655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glyQ',
  'glycine--tRNA ligase subunit alpha',
  987054,
  987950,
  -1,
  'JHP_RS04660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000401686.1',
  'NAD(P)H-dependent glycerol-3-phosphatedehydrogenase',
  987964,
  988902,
  -1,
  'JHP_RS04665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'dynamin family protein',
  989179,
  990907,
  -1,
  'JHP_RS04670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925888.1',
  'hypothetical protein',
  990904,
  991671,
  -1,
  'JHP_RS08900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000993641.1',
  'dynamin-like GTPase family protein',
  991704,
  993206,
  -1,
  'JHP_RS08475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'dynamin family protein',
  993206,
  994855,
  -1,
  'JHP_RS04685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000880326.1',
  'DUF3240 family protein',
  995162,
  995443,
  -1,
  'JHP_RS04690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000881243.1',
  'efflux RND transporter permease subunit',
  995459,
  998518,
  -1,
  'JHP_RS04695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000816799.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  998518,
  999597,
  -1,
  'JHP_RS04700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001212700.1',
  'TolC family protein',
  999594,
  1000889,
  -1,
  'JHP_RS04705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glyS',
  'glycine--tRNA ligase subunit beta',
  1000879,
  1002984,
  -1,
  'JHP_RS04710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_064782791.1',
  'hypothetical protein',
  1003092,
  1004189,
  1,
  'JHP_RS04715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gpmI',
  '2,3-bisphosphoglycerate-independentphosphoglycerate mutase',
  1004202,
  1005677,
  1,
  'JHP_RS04720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gatC',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatC',
  1005692,
  1005973,
  1,
  'JHP_RS04725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001010829.1',
  'adenosylmethionine--8-amino-7-oxononanoatetransaminase',
  1006070,
  1007389,
  -1,
  'JHP_RS04730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882581.1',
  'peptidylprolyl isomerase',
  1007519,
  1008982,
  1,
  'JHP_RS04735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ftsA',
  'cell division protein FtsA',
  1008998,
  1010479,
  1,
  'JHP_RS04740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ftsZ',
  'cell division protein FtsZ',
  1010607,
  1011764,
  1,
  'JHP_RS04745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1012034,
  1013325,
  -1,
  'JHP_RS04750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mscS',
  'small-conductance mechanosensitive channel MscS',
  1013672,
  1014496,
  -1,
  'JHP_RS04755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925932.1',
  'hypothetical protein',
  1014636,
  1014821,
  -1,
  'JHP_RS08540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'FtsK/SpoIIIE domain-containing protein',
  1014976,
  1016923,
  1,
  'JHP_RS08665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'type IA DNA topoisomerase',
  1016916,
  1018849,
  1,
  'JHP_RS04775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000416504.1',
  'VirB8 family type IV secretion system protein',
  1018979,
  1019965,
  1,
  'JHP_RS04785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'TrbG/VirB9 family P-type conjugative transferprotein',
  1019965,
  1021501,
  1,
  'JHP_RS08125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DNA type IV secretion system protein ComB10',
  1021498,
  1022058,
  1,
  'JHP_RS08130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1021986,
  1022549,
  -1,
  'JHP_RS04800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001061518.1',
  'ArdC-like ssDNA-binding domain-containingprotein',
  1022556,
  1023572,
  -1,
  'JHP_RS04805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_319014198.1',
  'hypothetical protein',
  1023876,
  1025174,
  1,
  'JHP_RS08800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000415289.1',
  'hypothetical protein',
  1025220,
  1026029,
  1,
  'JHP_RS08805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'SNF2-related protein',
  1026515,
  1032477,
  1,
  'JHP_RS08140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882591.1',
  'hypothetical protein',
  1032591,
  1032833,
  1,
  'JHP_RS04825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001066135.1',
  'type IA DNA topoisomerase',
  1032846,
  1034906,
  1,
  'JHP_RS04830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000965787.1',
  'hypothetical protein',
  1034961,
  1035431,
  1,
  'JHP_RS04835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000377489.1',
  'nucleotidyl transferase AbiEii/AbiGii toxinfamily protein',
  1035401,
  1036204,
  1,
  'JHP_RS04840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925934.1',
  'hypothetical protein',
  1036277,
  1036942,
  -1,
  'JHP_RS04845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1036920,
  1037296,
  -1,
  'JHP_RS08145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925890.1',
  'ParA family protein',
  1037343,
  1038011,
  -1,
  'JHP_RS04850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1038086,
  1038616,
  1,
  'JHP_RS04855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001008746.1',
  'type IV secretion system protein',
  1038613,
  1039878,
  1,
  'JHP_RS04860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925891.1',
  'hypothetical protein',
  1039875,
  1041140,
  1,
  'JHP_RS04865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000620293.1',
  'hypothetical protein',
  1041145,
  1042158,
  -1,
  'JHP_RS04870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ctkA',
  'serine/threonine-protein kinase CtkA',
  1042390,
  1043367,
  1,
  'JHP_RS04875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000545111.1',
  'tyrosine-type recombinase/integrase',
  1043684,
  1044679,
  -1,
  'JHP_RS04880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000886962.1',
  'relaxase/mobilization nuclease domain-containingprotein',
  1045778,
  1047811,
  1,
  'JHP_RS04890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1048966,
  1049874,
  1,
  'JHP_RS04895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'competence protein',
  1049913,
  1052133,
  1,
  'JHP_RS04900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000645652.1',
  'hypothetical protein',
  1052137,
  1053537,
  1,
  'JHP_RS04905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000477199.1',
  'hypothetical protein',
  1053588,
  1053866,
  1,
  'JHP_RS04910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000729955.1',
  'type IV secretion system protein',
  1053868,
  1055130,
  1,
  'JHP_RS04915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001153496.1',
  'hypothetical protein',
  1055202,
  1055885,
  1,
  'JHP_RS04920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001278353.1',
  'tyrosine-type recombinase/integrase',
  1055965,
  1057038,
  -1,
  'JHP_RS04925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rrf',
  '—',
  1057202,
  1057319,
  -1,
  'JHP_RS04935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1057558,
  1060444,
  -1,
  'JHP_RS04940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1061092,
  1061573,
  1,
  'JHP_RS08905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000057802.1',
  'hypothetical protein',
  1061542,
  1061982,
  1,
  'JHP_RS04950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF262 domain-containing protein',
  1062036,
  1063873,
  1,
  'JHP_RS08820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1064021,
  1064918,
  1,
  'JHP_RS04965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000906664.1',
  'type II toxin-antitoxin system HicB familyantitoxin',
  1065063,
  1065281,
  1,
  'JHP_RS04970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001114661.1',
  'type II toxin-antitoxin system HicA familytoxin',
  1065274,
  1065468,
  1,
  'JHP_RS04975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'speA',
  'arginine decarboxylase',
  1065542,
  1067389,
  -1,
  'JHP_RS04980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000237246.1',
  'glycosyltransferase family 4 protein',
  1067403,
  1068572,
  -1,
  'JHP_RS04985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001158301.1',
  'hotdog domain-containing protein',
  1068577,
  1069005,
  -1,
  'JHP_RS04990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cmoB',
  'tRNA 5-methoxyuridine(34)/uridine 5-oxyaceticacid(34) synthase CmoB',
  1069022,
  1069807,
  -1,
  'JHP_RS04995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS04995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001236493.1',
  'hypothetical protein',
  1069811,
  1070818,
  -1,
  'JHP_RS05000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'metG',
  'methionine--tRNA ligase',
  1070819,
  1072789,
  -1,
  'JHP_RS05005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cfaS',
  'cyclopropane fatty acid synthase',
  1072958,
  1074127,
  1,
  'JHP_RS05010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001238066.1',
  'mechanosensitive ion channel family protein',
  1074137,
  1076008,
  -1,
  'JHP_RS05015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1076698,
  1076774,
  -1,
  'JHP_RS05025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1076796,
  1076872,
  -1,
  'JHP_RS05030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1076932,
  1077008,
  -1,
  'JHP_RS05035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1077075,
  1077152,
  -1,
  'JHP_RS05040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hpaA2',
  'HpaA2 protein',
  1077336,
  1078085,
  -1,
  'JHP_RS05045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'guaA',
  'glutamine-hydrolyzing GMP synthase',
  1078169,
  1079695,
  -1,
  'JHP_RS05050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000110411.1',
  'hypothetical protein',
  1079692,
  1080186,
  -1,
  'JHP_RS05055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000028248.1',
  'molybdopterin guanine dinucleotide-containingS/N-oxide reductase',
  1080366,
  1082756,
  -1,
  'JHP_RS05060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000352062.1',
  'DUF3972 domain-containing protein',
  1082860,
  1083450,
  -1,
  'JHP_RS05065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001201081.1',
  'aminotransferase class V-fold PLP-dependentenzyme',
  1083476,
  1084798,
  -1,
  'JHP_RS05070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001100349.1',
  'histidine triad nucleotide-binding protein',
  1084817,
  1085131,
  -1,
  'JHP_RS05075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pheS',
  'phenylalanine--tRNA ligase subunit alpha',
  1085213,
  1086199,
  1,
  'JHP_RS05080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pheT',
  'phenylalanine--tRNA ligase subunit beta',
  1086199,
  1088493,
  1,
  'JHP_RS05085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'aroA',
  '3-phosphoshikimate 1-carboxyvinyltransferase',
  1088513,
  1089802,
  1,
  'JHP_RS05090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000403575.1',
  '4-hydroxy-3-methylbut-2-enyl diphosphatereductase',
  1089792,
  1090616,
  1,
  'JHP_RS05095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000034026.1',
  '30S ribosomal protein S1',
  1090738,
  1092396,
  1,
  'JHP_RS05100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001211170.1',
  'hypothetical protein',
  1092425,
  1092937,
  1,
  'JHP_RS05105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'serA',
  'phosphoglycerate dehydrogenase',
  1092953,
  1094527,
  1,
  'JHP_RS05110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001204352.1',
  'menaquinone biosynthesis decarboxylase',
  1094537,
  1096387,
  1,
  'JHP_RS05115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000888231.1',
  'YggS family pyridoxal phosphate-dependentenzyme',
  1096410,
  1097078,
  1,
  'JHP_RS05120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000894970.1',
  'UDP-2,3-diacylglucosamine diphosphatase',
  1097080,
  1097838,
  1,
  'JHP_RS05125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cheV3',
  'chemotaxis protein CheV3',
  1097840,
  1098778,
  1,
  'JHP_RS05130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cheAY2',
  'chemotaxis histidine kinase/response regulatorCheAY2',
  1098835,
  1101282,
  1,
  'JHP_RS05135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000070761.1',
  'chemotaxis protein CheW',
  1101279,
  1101776,
  1,
  'JHP_RS05140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tpx',
  'thiol peroxidase',
  1102036,
  1102536,
  -1,
  'JHP_RS05145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'sodB',
  'superoxide dismutase [Fe]',
  1102758,
  1103399,
  1,
  'JHP_RS05150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cmoA',
  'carboxy-S-adenosyl-L-methionine synthase CmoA',
  1103453,
  1104184,
  1,
  'JHP_RS05155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000499292.1',
  'primosomal protein N''',
  1104218,
  1106077,
  -1,
  'JHP_RS05160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000051172.1',
  'hypothetical protein',
  1106062,
  1106298,
  -1,
  'JHP_RS05165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'zapB',
  'cell division protein ZapB',
  1106311,
  1106538,
  -1,
  'JHP_RS05170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001172406.1',
  'SPOR domain-containing protein',
  1106739,
  1107485,
  1,
  'JHP_RS05175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001120756.1',
  'hypothetical protein',
  1107761,
  1108285,
  -1,
  'JHP_RS05180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000884470.1',
  'M48 family metallopeptidase',
  1108465,
  1109688,
  1,
  'JHP_RS05185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'prmC',
  'peptide chain release factor N(5)-glutaminemethyltransferase',
  1109685,
  1110515,
  1,
  'JHP_RS05190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gdhA',
  'NADP-specific glutamate dehydrogenase',
  1110582,
  1111928,
  1,
  'JHP_RS05195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'glycosyltransferase family 10 domain-containingprotein',
  1111942,
  1113251,
  -1,
  'JHP_RS05200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ccsA',
  'cytochrome c biogenesis protein',
  1113261,
  1116071,
  -1,
  'JHP_RS05205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000492223.1',
  'SoxW family protein',
  1116081,
  1116752,
  -1,
  'JHP_RS05210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemH',
  'ferrochelatase',
  1116826,
  1117833,
  -1,
  'JHP_RS05215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000892147.1',
  'hypothetical protein',
  1117889,
  1118320,
  1,
  'JHP_RS05220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001213128.1',
  '16S rRNA (uracil(1498)-N(3))-methyltransferase',
  1118321,
  1119001,
  1,
  'JHP_RS05225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000945291.1',
  'outer membrane beta-barrel protein',
  1119085,
  1121340,
  -1,
  'JHP_RS05230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dcd',
  'dCTP deaminase',
  1121509,
  1122075,
  -1,
  'JHP_RS05235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'accB',
  'acetyl-CoA carboxylase biotin carboxyl carrierprotein',
  1122205,
  1122690,
  1,
  'JHP_RS05240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001031226.1',
  'acetyl-CoA carboxylase biotin carboxylasesubunit',
  1122696,
  1124063,
  1,
  'JHP_RS05245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001193892.1',
  'hypothetical protein',
  1124156,
  1125118,
  1,
  'JHP_RS05250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000362726.1',
  'hypothetical protein',
  1125118,
  1125666,
  1,
  'JHP_RS05255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_160442678.1',
  'Laminin subunit alpha-2 precursor',
  1125748,
  1126365,
  1,
  'JHP_RS05260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pseC',
  'UDP-4-amino-4,6-dideoxy-N-acetyl-beta-L-altrosamine transaminase',
  1126362,
  1127498,
  1,
  'JHP_RS05265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1127524,
  1127608,
  -1,
  'JHP_RS05270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000453998.1',
  'ribonucleotide-diphosphate reductase subunitbeta',
  1127804,
  1128829,
  1,
  'JHP_RS05275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pcm',
  'protein-L-isoaspartate O-methyltransferase',
  1128839,
  1129468,
  1,
  'JHP_RS05280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000238634.1',
  'LptF/LptG family permease',
  1129490,
  1130527,
  1,
  'JHP_RS05285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'truA',
  'tRNA pseudouridine(38-40) synthase TruA',
  1130529,
  1131257,
  1,
  'JHP_RS05290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'galE',
  'UDP-glucose 4-epimerase GalE',
  1131251,
  1132285,
  -1,
  'JHP_RS05295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1132400,
  1132476,
  1,
  'JHP_RS05300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1132494,
  1132569,
  1,
  'JHP_RS05305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF3519 domain-containing protein',
  1132725,
  1133014,
  -1,
  'JHP_RS08180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000735740.1',
  'hypothetical protein',
  1133200,
  1134735,
  1,
  'JHP_RS05310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000940241.1',
  'SDR family oxidoreductase',
  1134753,
  1135505,
  1,
  'JHP_RS05315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hcpC',
  'Sel1-like repeat protein HcpC',
  1135716,
  1136588,
  -1,
  'JHP_RS05320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001152759.1',
  'bifunctional 4-hydroxy-2-oxoglutaratealdolase/2-dehydro-3-deoxy-phosphogluconate aldolase',
  1136658,
  1137284,
  -1,
  'JHP_RS05325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'edd',
  'phosphogluconate dehydratase',
  1137303,
  1139129,
  -1,
  'JHP_RS05330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000883530.1',
  'glucose-6-phosphate dehydrogenase',
  1139195,
  1140472,
  1,
  'JHP_RS05335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pgl',
  '6-phosphogluconolactonase',
  1140483,
  1141166,
  1,
  'JHP_RS05340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001126913.1',
  'glucokinase',
  1141153,
  1142163,
  1,
  'JHP_RS05345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001265775.1',
  'NAD(P)-dependent alcohol dehydrogenase',
  1142333,
  1143385,
  1,
  'JHP_RS05350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000199721.1',
  'glycosyltransferase',
  1143388,
  1144569,
  -1,
  'JHP_RS05355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000199722.1',
  'glycosyltransferase family 8 protein',
  1144709,
  1145905,
  -1,
  'JHP_RS05360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882603.1',
  'hypothetical protein',
  1146080,
  1147387,
  1,
  'JHP_RS05370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001044629.1',
  'outer membrane protein',
  1147394,
  1148056,
  -1,
  'JHP_RS05375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000486466.1',
  'pyruvate flavodoxin oxidoreductase subunitgamma',
  1148339,
  1148899,
  1,
  'JHP_RS05380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000656174.1',
  '4Fe-4S dicluster-binding protein',
  1148915,
  1149307,
  1,
  'JHP_RS05385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001129865.1',
  '2-oxoacid:ferredoxin oxidoreductase subunitalpha',
  1149317,
  1150540,
  1,
  'JHP_RS05390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000238176.1',
  'thiamine pyrophosphate-dependent enzyme',
  1150553,
  1151497,
  1,
  'JHP_RS05395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'purB',
  'adenylosuccinate lyase',
  1151605,
  1152927,
  1,
  'JHP_RS05400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000816847.1',
  'outer membrane protein',
  1153226,
  1154059,
  1,
  'JHP_RS05405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'uvrB',
  'excinuclease ABC subunit UvrB',
  1154084,
  1156060,
  -1,
  'JHP_RS05410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001108919.1',
  'hypothetical protein',
  1156109,
  1156912,
  -1,
  'JHP_RS05415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'RipA family octameric membrane protein',
  1156909,
  1157341,
  -1,
  'JHP_RS05420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000775275.1',
  'DUF3519 domain-containing protein',
  1157436,
  1160900,
  -1,
  'JHP_RS05425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000135942.1',
  'hypothetical protein',
  1160869,
  1161069,
  1,
  'JHP_RS05430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1161066,
  1161298,
  1,
  'JHP_RS08910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000540146.1',
  'HP1117 family Sel1-like repeat protein',
  1161319,
  1162089,
  -1,
  'JHP_RS05435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ggt',
  'gamma-glutamyltransferase',
  1162333,
  1164036,
  -1,
  'JHP_RS05440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgK',
  'flagellar hook-associated protein FlgK',
  1164224,
  1166044,
  -1,
  'JHP_RS05445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000260915.1',
  'hypothetical protein',
  1166046,
  1166480,
  -1,
  'JHP_RS05450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001059359.1',
  'PDDEXK family nuclease',
  1166559,
  1167311,
  -1,
  'JHP_RS05455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925939.1',
  'DNA cytosine methyltransferase',
  1167304,
  1168251,
  -1,
  'JHP_RS05460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001883407.1',
  'flagellar biosynthesis anti-sigma factor FlgM',
  1168412,
  1168615,
  -1,
  'JHP_RS05465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001088951.1',
  'hypothetical protein',
  1168684,
  1168890,
  -1,
  'JHP_RS05470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001179280.1',
  'FKBP-type peptidyl-prolyl cis-trans isomerase',
  1168925,
  1169482,
  -1,
  'JHP_RS05475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000825200.1',
  'tol-pal system YbgF family protein',
  1169469,
  1170464,
  -1,
  'JHP_RS05480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000831170.1',
  'outer membrane protein Omp18',
  1170472,
  1171011,
  -1,
  'JHP_RS05485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tolB',
  'Tol-Pal system protein TolB',
  1171078,
  1172331,
  -1,
  'JHP_RS05490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000045014.1',
  'energy transducer TonB',
  1172328,
  1173119,
  -1,
  'JHP_RS05495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001105112.1',
  'ExbD/TolR family protein',
  1173138,
  1173539,
  -1,
  'JHP_RS05500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000460425.1',
  'MotA/TolQ/ExbB proton channel family protein',
  1173591,
  1174160,
  -1,
  'JHP_RS05505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'atpC',
  'ATP synthase F1 subunit epsilon',
  1174171,
  1174542,
  -1,
  'JHP_RS05510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'atpD',
  'F0F1 ATP synthase subunit beta',
  1174553,
  1175953,
  -1,
  'JHP_RS05515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'atpG',
  'ATP synthase F1 subunit gamma',
  1175987,
  1176892,
  -1,
  'JHP_RS05520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'atpA',
  'F0F1 ATP synthase subunit alpha',
  1176907,
  1178418,
  -1,
  'JHP_RS05525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001153278.1',
  'F0F1 ATP synthase subunit delta',
  1178441,
  1178983,
  -1,
  'JHP_RS05530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000498443.1',
  'F0F1 ATP synthase subunit B',
  1178984,
  1179499,
  -1,
  'JHP_RS05535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001027633.1',
  'FoF1 ATP synthase subunit B''',
  1179503,
  1179937,
  -1,
  'JHP_RS05540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001107368.1',
  'ParB/RepB/Spo0J family partition protein',
  1180042,
  1180914,
  -1,
  'JHP_RS05545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'soj',
  'chromosome partitioning ATPase Soj',
  1180917,
  1181708,
  -1,
  'JHP_RS05550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000710488.1',
  'biotin--[acetyl-CoA-carboxylase] ligase',
  1181714,
  1182352,
  -1,
  'JHP_RS05555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fmt',
  'methionyl-tRNA formyltransferase',
  1182349,
  1183266,
  -1,
  'JHP_RS05560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000526984.1',
  'ATP-binding protein',
  1183290,
  1185554,
  -1,
  'JHP_RS05565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001157483.1',
  'DUF2130 domain-containing protein',
  1185604,
  1186905,
  -1,
  'JHP_RS05570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882606.1',
  'hypothetical protein',
  1187115,
  1187408,
  1,
  'JHP_RS05575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993031.1',
  'hypothetical protein',
  1187353,
  1187538,
  1,
  'JHP_RS08825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1188027,
  1189529,
  -1,
  'JHP_RS05585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001873570.1',
  'hypothetical protein',
  1189531,
  1189710,
  1,
  'JHP_RS08195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000520584.1',
  'NYN domain-containing protein',
  1190266,
  1191057,
  -1,
  'JHP_RS05595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplS',
  '50S ribosomal protein L19',
  1191976,
  1192332,
  -1,
  'JHP_RS05600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trmD',
  'tRNA (guanosine(37)-N1)-methyltransferase TrmD',
  1192354,
  1193043,
  -1,
  'JHP_RS05605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rimM',
  'ribosome maturation factor RimM',
  1193044,
  1193589,
  -1,
  'JHP_RS05610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001231954.1',
  'KH domain-containing protein',
  1193599,
  1193952,
  -1,
  'JHP_RS05615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsP',
  '30S ribosomal protein S16',
  1193969,
  1194199,
  -1,
  'JHP_RS05620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ffh',
  'signal recognition particle protein',
  1194273,
  1195619,
  -1,
  'JHP_RS05625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'valS',
  'valine--tRNA ligase',
  1195634,
  1198252,
  -1,
  'JHP_RS05630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliW',
  'flagellar assembly protein FliW',
  1198390,
  1198797,
  1,
  'JHP_RS05635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'murG',
  'undecaprenyldiphospho-muramoylpentapeptidebeta-N-acetylglucosaminyltransferase',
  1198809,
  1199870,
  1,
  'JHP_RS05640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopI',
  'Hop family outer membrane protein HopI',
  1199979,
  1202072,
  1,
  'JHP_RS05645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopL',
  'Hop family outer membrane protein HopL',
  1202095,
  1205808,
  1,
  'JHP_RS05650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'proC',
  'pyrroline-5-carboxylate reductase',
  1205822,
  1206595,
  1,
  'JHP_RS05655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fic',
  'protein adenylyltransferase Fic',
  1206622,
  1207149,
  1,
  'JHP_RS05660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ybeY',
  'rRNA maturation RNase YbeY',
  1207235,
  1207660,
  -1,
  'JHP_RS05665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000516049.1',
  'flavodoxin',
  1207715,
  1208209,
  -1,
  'JHP_RS05670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882608.1',
  'DedA family protein',
  1208301,
  1208882,
  -1,
  'JHP_RS05675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ccoS',
  'cbb3-type cytochrome oxidase assembly proteinCcoS',
  1209007,
  1209198,
  1,
  'JHP_RS05680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000371804.1',
  'NAD(P)-binding domain-containing protein',
  1209224,
  1210198,
  1,
  'JHP_RS05685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000944816.1',
  'HP1165 family MFS efflux transporter',
  1210206,
  1211366,
  -1,
  'JHP_RS05690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pgi',
  'glucose-6-phosphate isomerase',
  1211430,
  1213067,
  1,
  'JHP_RS05695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hofH',
  'outer membrane beta-barrel protein HofH',
  1213371,
  1214786,
  1,
  'JHP_RS05700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_171886532.1',
  'carbon starvation CstA family protein',
  1215246,
  1217339,
  -1,
  'JHP_RS05705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001162580.1',
  'amino acid ABC transporter permease',
  1217517,
  1218170,
  1,
  'JHP_RS05710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000538519.1',
  'amino acid ABC transporter permease',
  1218172,
  1218843,
  1,
  'JHP_RS05715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001274172.1',
  'amino acid ABC transporter ATP-binding protein',
  1218845,
  1219591,
  1,
  'JHP_RS05720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000855964.1',
  'transporter substrate-binding domain-containingprotein',
  1219640,
  1220473,
  1,
  'JHP_RS05725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001015406.1',
  'hypothetical protein',
  1220595,
  1221152,
  1,
  'JHP_RS05730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001173109.1',
  'sugar MFS transporter',
  1221423,
  1222646,
  -1,
  'JHP_RS05735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000505482.1',
  'NCS2 family permease',
  1222775,
  1224082,
  -1,
  'JHP_RS05740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000853577.1',
  'hypothetical protein',
  1224306,
  1224527,
  -1,
  'JHP_RS08915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hopQ',
  'Hop family adhesin HopQ',
  1224524,
  1226455,
  -1,
  'JHP_RS05750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001893730.1',
  'hypothetical protein',
  1226629,
  1226841,
  -1,
  'JHP_RS08830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'deoD',
  'purine-nucleoside phosphorylase',
  1226918,
  1227619,
  -1,
  'JHP_RS05755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001172175.1',
  'phosphopentomutase',
  1227616,
  1228857,
  -1,
  'JHP_RS05760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000577820.1',
  'NupC/NupG family nucleoside CNT transporter',
  1228869,
  1230125,
  -1,
  'JHP_RS05765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1230231,
  1230308,
  -1,
  'JHP_RS05770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_341871645.1',
  'MFS transporter',
  1230494,
  1231786,
  1,
  'JHP_RS05775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000312880.1',
  'tRNA 2-thiocytidine(32) synthetase TtcA',
  1231802,
  1232563,
  1,
  'JHP_RS05780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000542852.1',
  'cation:proton antiporter',
  1232568,
  1233719,
  -1,
  'JHP_RS05785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000914108.1',
  'HP1184 family multidrug efflux MATE transporter',
  1233745,
  1235124,
  -1,
  'JHP_RS05790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000973621.1',
  'sugar transporter',
  1235294,
  1236469,
  -1,
  'JHP_RS05795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882609.1',
  'carbonic anhydrase',
  1236741,
  1237484,
  1,
  'JHP_RS05800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882610.1',
  'DUF874 family protein',
  1237715,
  1238866,
  -1,
  'JHP_RS05805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'asd',
  'aspartate-semialdehyde dehydrogenase',
  1239301,
  1240341,
  -1,
  'JHP_RS05810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hisS',
  'histidine--tRNA ligase',
  1240328,
  1241656,
  -1,
  'JHP_RS05815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'waaF',
  'lipopolysaccharide heptosyltransferase II',
  1241718,
  1242767,
  1,
  'JHP_RS05820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000744175.1',
  'hypothetical protein',
  1242951,
  1243115,
  -1,
  'JHP_RS08495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fusA',
  'elongation factor G',
  1243658,
  1245736,
  -1,
  'JHP_RS05830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsG',
  '30S ribosomal protein S7',
  1245748,
  1246215,
  -1,
  'JHP_RS05835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsL',
  '30S ribosomal protein S12',
  1246231,
  1246638,
  -1,
  'JHP_RS05840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000037845.1',
  'DNA-directed RNA polymerase subunit beta/beta''',
  1246726,
  1255398,
  -1,
  'JHP_RS05845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplL',
  '50S ribosomal protein L7/L12',
  1255620,
  1255997,
  -1,
  'JHP_RS05850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplJ',
  '50S ribosomal protein L10',
  1256040,
  1256534,
  -1,
  'JHP_RS05855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplA',
  '50S ribosomal protein L1',
  1256643,
  1257347,
  -1,
  'JHP_RS05860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplK',
  '50S ribosomal protein L11',
  1257392,
  1257817,
  -1,
  'JHP_RS05865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nusG',
  'transcription termination/antiterminationprotein NusG',
  1257835,
  1258362,
  -1,
  'JHP_RS05870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'secE',
  'preprotein translocase subunit SecE',
  1258392,
  1258571,
  -1,
  'JHP_RS05875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1258703,
  1258778,
  -1,
  'JHP_RS05880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmG',
  '50S ribosomal protein L33',
  1258818,
  1258976,
  -1,
  'JHP_RS05885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tuf',
  'elongation factor Tu',
  1259023,
  1260222,
  -1,
  'JHP_RS05890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1260350,
  1260424,
  -1,
  'JHP_RS05895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1260455,
  1260531,
  -1,
  'JHP_RS05900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1260548,
  1260632,
  -1,
  'JHP_RS05905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1260660,
  1260735,
  -1,
  'JHP_RS05910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001074891.1',
  'ABC transporter ATP-binding protein/permease',
  1260926,
  1262662,
  1,
  'JHP_RS05915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05915'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001163012.1',
  'HAD family hydrolase',
  1262671,
  1263339,
  -1,
  'JHP_RS05920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001106467.1',
  'DNA adenine methylase',
  1263527,
  1264516,
  -1,
  'JHP_RS05925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'IceA2 protein',
  1264848,
  1265024,
  -1,
  'JHP_RS05930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'cysE',
  'serine O-acetyltransferase',
  1265253,
  1265768,
  -1,
  'JHP_RS05935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1266069,
  1266155,
  -1,
  'JHP_RS05940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1266209,
  1266295,
  -1,
  'JHP_RS05945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000669961.1',
  'F0F1 ATP synthase subunit C',
  1266365,
  1266682,
  -1,
  'JHP_RS05950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000345782.1',
  'polyribonucleotide nucleotidyltransferase',
  1266815,
  1268881,
  -1,
  'JHP_RS05955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001090676.1',
  'phosphoribosyltransferase',
  1268884,
  1269588,
  -1,
  'JHP_RS05960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925941.1',
  'LPS-assembly protein LptD',
  1269602,
  1271863,
  -1,
  'JHP_RS05965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001257445.1',
  'RDD family protein',
  1271865,
  1272344,
  -1,
  'JHP_RS05970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'purD',
  'phosphoribosylamine--glycine ligase',
  1272393,
  1273667,
  -1,
  'JHP_RS05975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000959634.1',
  'ABC transporter ATP-binding protein',
  1273981,
  1274667,
  -1,
  'JHP_RS05980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05980'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000378606.1',
  'di-trans,poly-cis-decaprenylcistransferase',
  1274661,
  1275365,
  -1,
  'JHP_RS05985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000392318.1',
  'FAD-binding and (Fe-S)-binding domain-containingprotein',
  1275405,
  1278245,
  -1,
  'JHP_RS05990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000888847.1',
  'rhodanese-like domain-containing protein',
  1278317,
  1278655,
  1,
  'JHP_RS05995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS05995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882611.1',
  'uroporphyrinogen-III synthase',
  1278658,
  1279329,
  1,
  'JHP_RS06000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'crcB',
  'fluoride efflux transporter CrcB',
  1279386,
  1279778,
  1,
  'JHP_RS06005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemW',
  'radical SAM family heme chaperone HemW',
  1279829,
  1280866,
  -1,
  'JHP_RS06010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000756037.1',
  'c-type cytochrome',
  1280962,
  1281252,
  1,
  'JHP_RS06015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000902607.1',
  'RNA pyrophosphohydrolase',
  1281413,
  1281886,
  1,
  'JHP_RS06020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000909636.1',
  'aspartate kinase',
  1281880,
  1283097,
  1,
  'JHP_RS06025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000788264.1',
  'HobA family DNA replication regulator',
  1283094,
  1283636,
  1,
  'JHP_RS06030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000798388.1',
  'DNA polymerase III subunit delta''',
  1283633,
  1284289,
  1,
  'JHP_RS06035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'folP',
  'dihydropteroate synthase',
  1284286,
  1285428,
  1,
  'JHP_RS06040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000301263.1',
  'hypothetical protein',
  1285523,
  1285984,
  -1,
  'JHP_RS06045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_046656390.1',
  'hypothetical protein',
  1286039,
  1286281,
  1,
  'JHP_RS08510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001246324.1',
  'DMT family transporter',
  1286335,
  1287231,
  1,
  'JHP_RS06055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001177304.1',
  'glycosyltransferase family 39 protein',
  1287235,
  1288482,
  1,
  'JHP_RS06060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06060'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001237439.1',
  'DUF507 family protein',
  1288561,
  1289112,
  1,
  'JHP_RS06065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'carA',
  'glutamine-hydrolyzing carbamoyl-phosphatesynthase small subunit',
  1289112,
  1290239,
  1,
  'JHP_RS06070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000534784.1',
  'formamidase',
  1290408,
  1291412,
  1,
  'JHP_RS06075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000255527.1',
  'hypothetical protein',
  1291492,
  1291749,
  -1,
  'JHP_RS06080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_226928966.1',
  'hypothetical protein',
  1291895,
  1292314,
  -1,
  'JHP_RS06085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'maf',
  'septum formation inhibitor Maf',
  1292482,
  1293054,
  -1,
  'JHP_RS06090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'alaS',
  'alanine--tRNA ligase',
  1293056,
  1295599,
  -1,
  'JHP_RS06095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000468326.1',
  'YdcH family protein',
  1295719,
  1295949,
  1,
  'JHP_RS06100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'babB',
  'Hop family adhesin BabB',
  1296915,
  1299026,
  -1,
  'JHP_RS06105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsR',
  '30S ribosomal protein S18',
  1299303,
  1299560,
  -1,
  'JHP_RS06110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000482467.1',
  'single-stranded DNA-binding protein',
  1299583,
  1300128,
  -1,
  'JHP_RS06115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsF',
  '30S ribosomal protein S6',
  1300143,
  1300571,
  -1,
  'JHP_RS06120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'holA',
  'DNA polymerase III subunit delta',
  1300700,
  1301722,
  -1,
  'JHP_RS06125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001161370.1',
  'RNB domain-containing ribonuclease',
  1301712,
  1303646,
  -1,
  'JHP_RS06130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000769596.1',
  'shikimate dehydrogenase',
  1303646,
  1304446,
  -1,
  'JHP_RS06135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_160442669.1',
  'SH3 domain-containing protein',
  1304454,
  1305101,
  -1,
  'JHP_RS06140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000562613.1',
  'microcin C ABC transporter permease YejB',
  1305122,
  1306168,
  -1,
  'JHP_RS06145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000231402.1',
  'extracellular solute-binding protein',
  1306165,
  1307952,
  -1,
  'JHP_RS06150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trpS',
  'tryptophan--tRNA ligase',
  1307953,
  1308933,
  -1,
  'JHP_RS06155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000376945.1',
  'methyltransferase domain-containing protein',
  1309005,
  1309742,
  -1,
  'JHP_RS06160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'secG',
  'preprotein translocase subunit SecG',
  1309875,
  1310471,
  1,
  'JHP_RS06165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'frr',
  'ribosome recycling factor',
  1310471,
  1311028,
  1,
  'JHP_RS06170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pyrE',
  'orotate phosphoribosyltransferase',
  1311032,
  1311637,
  1,
  'JHP_RS06175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000201684.1',
  'RDD family protein',
  1311627,
  1312085,
  1,
  'JHP_RS06180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000793991.1',
  'SIR2 family NAD-dependent protein deacylase',
  1312082,
  1312786,
  1,
  'JHP_RS06185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001183394.1',
  'NAD(P)H-quinone oxidoreductase subunit 3',
  1312879,
  1313280,
  1,
  'JHP_RS06190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001183503.1',
  'NuoB/complex I 20 kDa subunit family protein',
  1313280,
  1313759,
  1,
  'JHP_RS06195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001878524.1',
  'NADH-quinone oxidoreductase subunit C',
  1313759,
  1314556,
  1,
  'JHP_RS06200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nuoD',
  'NADH dehydrogenase (quinone) subunit D',
  1314558,
  1315787,
  1,
  'JHP_RS06205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000819164.1',
  'NADH-ubiquinone oxidoreductase subunit E familyprotein',
  1315784,
  1316014,
  1,
  'JHP_RS06210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000012706.1',
  'hypothetical protein',
  1316017,
  1317003,
  1,
  'JHP_RS06215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000632107.1',
  'NADH-quinone oxidoreductase subunit G',
  1317000,
  1319549,
  1,
  'JHP_RS06220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nuoH',
  'NADH-quinone oxidoreductase subunit NuoH',
  1319546,
  1320535,
  1,
  'JHP_RS06225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nuoI',
  'NADH-quinone oxidoreductase subunit NuoI',
  1320545,
  1321207,
  1,
  'JHP_RS06230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000464226.1',
  'NADH-quinone oxidoreductase subunit J',
  1321200,
  1321748,
  1,
  'JHP_RS06235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nuoK',
  'NADH-quinone oxidoreductase subunit NuoK',
  1321745,
  1322047,
  1,
  'JHP_RS06240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nuoL',
  'NADH-quinone oxidoreductase subunit L',
  1322050,
  1323888,
  1,
  'JHP_RS06245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001159984.1',
  'NADH-quinone oxidoreductase subunit M',
  1323892,
  1325430,
  1,
  'JHP_RS06250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nuoN',
  'NADH-quinone oxidoreductase subunit NuoN',
  1325417,
  1326895,
  1,
  'JHP_RS06255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000266329.1',
  'DUF7494 domain-containing protein',
  1326885,
  1329296,
  1,
  'JHP_RS06260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000355226.1',
  'phosphomannomutase/phosphoglucomutase',
  1329298,
  1330677,
  1,
  'JHP_RS06265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001095579.1',
  'hypothetical protein',
  1330858,
  1331229,
  1,
  'JHP_RS06270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trpA',
  'tryptophan synthase subunit alpha',
  1331406,
  1332194,
  -1,
  'JHP_RS06275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trpB',
  'tryptophan synthase subunit beta',
  1332191,
  1333372,
  -1,
  'JHP_RS06280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trpCF',
  'bifunctional indole-3-glycerol-phosphatesynthase TrpC/phosphoribosylanthranilate isomerase TrpF',
  1333374,
  1334732,
  -1,
  'JHP_RS06285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trpD',
  'anthranilate phosphoribosyltransferase',
  1334725,
  1335732,
  -1,
  'JHP_RS06290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000688236.1',
  'aminodeoxychorismate/anthranilate synthasecomponent II',
  1335729,
  1336313,
  -1,
  'JHP_RS06295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06295'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'trpE',
  'anthranilate synthase component I',
  1336310,
  1337812,
  -1,
  'JHP_RS06300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000348199.1',
  'glycosyltransferase family 9 protein',
  1338041,
  1339099,
  -1,
  'JHP_RS06305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882617.1',
  '5''-nucleotidase, lipoprotein e(P4) family',
  1339167,
  1339904,
  -1,
  'JHP_RS06310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000709848.1',
  'YceI family protein',
  1340027,
  1340575,
  1,
  'JHP_RS06315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tenA',
  'thiaminase II',
  1340639,
  1341292,
  -1,
  'JHP_RS06320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001935274.1',
  'hypothetical protein',
  1342003,
  1342356,
  1,
  'JHP_RS06325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001022191.1',
  'hypothetical protein',
  1342380,
  1342865,
  1,
  'JHP_RS06330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1343051,
  1343713,
  1,
  'JHP_RS06335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001149171.1',
  'thiamine diphosphokinase',
  1343701,
  1344315,
  1,
  'JHP_RS06340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplQ',
  '50S ribosomal protein L17',
  1345094,
  1345444,
  -1,
  'JHP_RS06345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000864517.1',
  'DNA-directed RNA polymerase subunit alpha',
  1345444,
  1346478,
  -1,
  'JHP_RS06350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsD',
  '30S ribosomal protein S4',
  1346490,
  1347116,
  -1,
  'JHP_RS06355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsK',
  '30S ribosomal protein S11',
  1347126,
  1347521,
  -1,
  'JHP_RS06360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsM',
  '30S ribosomal protein S13',
  1347544,
  1347906,
  -1,
  'JHP_RS06365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmJ',
  '50S ribosomal protein L36',
  1347910,
  1348023,
  -1,
  'JHP_RS06370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'infA',
  'translation initiation factor IF-1',
  1348102,
  1348320,
  -1,
  'JHP_RS06375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06375'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'map',
  'type I methionyl aminopeptidase',
  1348320,
  1349081,
  -1,
  'JHP_RS06380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06380'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'secY',
  'preprotein translocase subunit SecY',
  1349081,
  1350343,
  -1,
  'JHP_RS06385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplO',
  '50S ribosomal protein L15',
  1350378,
  1350779,
  -1,
  'JHP_RS06390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsE',
  '30S ribosomal protein S5',
  1350797,
  1351240,
  -1,
  'JHP_RS06395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06395'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplR',
  '50S ribosomal protein L18',
  1351255,
  1351611,
  -1,
  'JHP_RS06400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplF',
  '50S ribosomal protein L6',
  1351625,
  1352161,
  -1,
  'JHP_RS06405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsH',
  '30S ribosomal protein S8',
  1352173,
  1352568,
  -1,
  'JHP_RS06410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001085692.1',
  'type Z 30S ribosomal protein S14',
  1352578,
  1352763,
  -1,
  'JHP_RS06415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplE',
  '50S ribosomal protein L5',
  1352773,
  1353318,
  -1,
  'JHP_RS06420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplX',
  '50S ribosomal protein L24',
  1353332,
  1353553,
  -1,
  'JHP_RS06425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplN',
  '50S ribosomal protein L14',
  1353553,
  1353921,
  -1,
  'JHP_RS06430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsQ',
  '30S ribosomal protein S17',
  1353924,
  1354184,
  -1,
  'JHP_RS06435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmC',
  '50S ribosomal protein L29',
  1354198,
  1354398,
  -1,
  'JHP_RS06440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplP',
  '50S ribosomal protein L16',
  1354385,
  1354810,
  -1,
  'JHP_RS06445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsC',
  '30S ribosomal protein S3',
  1354813,
  1355517,
  -1,
  'JHP_RS06450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplV',
  '50S ribosomal protein L22',
  1355521,
  1355889,
  -1,
  'JHP_RS06455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsS',
  '30S ribosomal protein S19',
  1355899,
  1356180,
  -1,
  'JHP_RS06460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06460'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplB',
  '50S ribosomal protein L2',
  1356192,
  1357022,
  -1,
  'JHP_RS06465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06465'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000763613.1',
  '50S ribosomal protein L23',
  1357038,
  1357319,
  -1,
  'JHP_RS06470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06470'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplD',
  '50S ribosomal protein L4',
  1357323,
  1357970,
  -1,
  'JHP_RS06475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rplC',
  '50S ribosomal protein L3',
  1358005,
  1358580,
  -1,
  'JHP_RS06480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsJ',
  '30S ribosomal protein S10',
  1358617,
  1358931,
  -1,
  'JHP_RS06485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925894.1',
  'ATP-binding protein',
  1359142,
  1360227,
  1,
  'JHP_RS06490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000992768.1',
  'hypothetical protein',
  1360492,
  1361070,
  1,
  'JHP_RS06495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000172139.1',
  'ribonuclease HII',
  1361044,
  1361658,
  -1,
  'JHP_RS06500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925895.1',
  'hypothetical protein',
  1361689,
  1361937,
  -1,
  'JHP_RS06505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fumC',
  'class II fumarate hydratase',
  1361964,
  1363355,
  -1,
  'JHP_RS06510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'crdA',
  'copper resistance determinant CrdA',
  1363530,
  1363907,
  1,
  'JHP_RS06515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'crdB',
  'copper resistance outer membrane protein CrdB',
  1363912,
  1365150,
  1,
  'JHP_RS06520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000826066.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1365147,
  1366172,
  1,
  'JHP_RS06525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000570468.1',
  'efflux RND transporter permease subunit',
  1366173,
  1369280,
  1,
  'JHP_RS06530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000928589.1',
  'branched-chain amino acid transporter permease',
  1369261,
  1369617,
  -1,
  'JHP_RS06535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'azlC',
  'azaleucine resistance protein AzlC',
  1369611,
  1370297,
  -1,
  'JHP_RS06540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dnaJ',
  'molecular chaperone DnaJ',
  1370308,
  1371417,
  -1,
  'JHP_RS06545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001210134.1',
  'hypothetical protein',
  1371542,
  1372672,
  1,
  'JHP_RS06550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mnmA',
  'tRNA 2-thiouridine(34) synthase MnmA',
  1372714,
  1373742,
  -1,
  'JHP_RS06555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001062415.1',
  'J domain-containing protein',
  1373882,
  1374643,
  1,
  'JHP_RS06560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nadD',
  'nicotinate (nicotinamide) nucleotideadenylyltransferase',
  1374640,
  1375155,
  -1,
  'JHP_RS06565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nikR',
  'nickel-responsive transcriptional regulatorNikR',
  1375148,
  1375594,
  -1,
  'JHP_RS06570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'exbB',
  'TonB-system energizer ExbB',
  1375917,
  1376354,
  1,
  'JHP_RS06575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'exbD',
  'TonB system transport protein ExbD',
  1376351,
  1376740,
  1,
  'JHP_RS06580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000703806.1',
  'energy transducer TonB family protein',
  1376706,
  1377548,
  1,
  'JHP_RS06585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000694329.1',
  'Hop family adhesin SabA/HopD',
  1377733,
  1379823,
  1,
  'JHP_RS06590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000395227.1',
  'TerC family protein',
  1379941,
  1380669,
  -1,
  'JHP_RS06595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'corA',
  'magnesium/cobalt transporter CorA',
  1380676,
  1381632,
  -1,
  'JHP_RS06600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000879971.1',
  'phosphoglycerate kinase',
  1381648,
  1382856,
  -1,
  'JHP_RS06605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gap',
  'type I glyceraldehyde-3-phosphate dehydrogenase',
  1382871,
  1383863,
  -1,
  'JHP_RS06610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ung',
  'uracil-DNA glycosylase',
  1383952,
  1384653,
  -1,
  'JHP_RS06615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000841245.1',
  '1-acyl-sn-glycerol-3-phosphate acyltransferase',
  1384650,
  1385363,
  -1,
  'JHP_RS06620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000506018.1',
  'SH3 domain-containing protein',
  1385350,
  1386513,
  -1,
  'JHP_RS06625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925897.1',
  'S41 family peptidase',
  1386520,
  1387884,
  -1,
  'JHP_RS06630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DNA methyltransferase',
  1387994,
  1388119,
  -1,
  'JHP_RS08685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000386407.1',
  'HpyAIV family type II restriction enzyme',
  1388109,
  1388981,
  -1,
  'JHP_RS06635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000346733.1',
  'DNA-methyltransferase',
  1388981,
  1390060,
  -1,
  'JHP_RS06640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_146113107.1',
  'DNA methyltransferase',
  1390189,
  1390407,
  -1,
  'JHP_RS08690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_158295310.1',
  'type ISP restriction/modification enzyme',
  1390467,
  1391327,
  -1,
  'JHP_RS08695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925898.1',
  'N-6 DNA methylase',
  1391234,
  1393681,
  -1,
  'JHP_RS06650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nadC',
  'carboxylating nicotinate-nucleotidediphosphorylase',
  1393792,
  1394613,
  -1,
  'JHP_RS06655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nadA',
  'quinolinate synthase NadA',
  1394613,
  1395623,
  -1,
  'JHP_RS06660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000226231.1',
  'phosphatidylserine decarboxylase',
  1395613,
  1396416,
  -1,
  'JHP_RS06665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000953123.1',
  'DUF6115 domain-containing protein',
  1396410,
  1396916,
  -1,
  'JHP_RS06670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_046656151.1',
  'hypothetical protein',
  1396929,
  1397423,
  -1,
  'JHP_RS06675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mqnP',
  'menaquinone biosynthesis prenyltransferase MqnP',
  1397416,
  1398258,
  -1,
  'JHP_RS06680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000653637.1',
  'ComEC/Rec2 family competence protein',
  1398329,
  1399642,
  -1,
  'JHP_RS06685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000349702.1',
  'replicative DNA helicase',
  1399639,
  1401099,
  -1,
  'JHP_RS06690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000953985.1',
  'NAD(P)H-hydrate dehydratase',
  1401110,
  1402504,
  -1,
  'JHP_RS06695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'crdS',
  'copper-sensing histidine kinase CrdS',
  1402507,
  1403709,
  -1,
  'JHP_RS06700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'crdR',
  'copper response regulator transcription factorCrdR',
  1403675,
  1404316,
  -1,
  'JHP_RS06705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882624.1',
  'site-specific DNA-methyltransferase',
  1404425,
  1406374,
  1,
  'JHP_RS06710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DEAD/DEAH box helicase family protein',
  1406384,
  1409297,
  1,
  'JHP_RS06715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mreC',
  'rod shape-determining protein MreC',
  1409352,
  1410098,
  -1,
  'JHP_RS06720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000577748.1',
  'rod shape-determining protein',
  1410102,
  1411145,
  -1,
  'JHP_RS06725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'clpX',
  'ATP-dependent protease ATP-binding subunit ClpX',
  1411198,
  1412556,
  -1,
  'JHP_RS06730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpxA',
  'acyl-ACP--UDP-N-acetylglucosamineO-acyltransferase',
  1412558,
  1413370,
  -1,
  'JHP_RS06735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fabZ',
  '3-hydroxyacyl-ACP dehydratase FabZ',
  1413373,
  1413852,
  -1,
  'JHP_RS06740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001888369.1',
  'hypothetical protein',
  1413900,
  1414076,
  1,
  'JHP_RS08840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08840'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliW',
  'flagellar assembly protein FliW',
  1414034,
  1414423,
  -1,
  'JHP_RS06745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000034872.1',
  'hypothetical protein',
  1414641,
  1414835,
  1,
  'JHP_RS06750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001237325.1',
  'outer membrane protein assembly factor BamD',
  1414826,
  1415488,
  1,
  'JHP_RS06755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lon',
  'endopeptidase La',
  1415531,
  1418026,
  1,
  'JHP_RS06760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000643484.1',
  'prephenate dehydrogenase',
  1418035,
  1418862,
  1,
  'JHP_RS06765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000688826.1',
  'DNA/RNA non-specific endonuclease',
  1419313,
  1420176,
  -1,
  'JHP_RS06775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000921160.1',
  'site-specific DNA-methyltransferase',
  1420437,
  1422299,
  -1,
  'JHP_RS06780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993038.1',
  'DEAD/DEAH box helicase family protein',
  1422293,
  1424839,
  -1,
  'JHP_RS06785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001155616.1',
  'biotin synthase',
  1425041,
  1425889,
  1,
  'JHP_RS06795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001206556.1',
  'YihY/virulence factor BrkB family protein',
  1425889,
  1426767,
  1,
  'JHP_RS06800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rrf',
  '—',
  1427040,
  1427157,
  -1,
  'JHP_RS06810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1427396,
  1430282,
  -1,
  'JHP_RS06815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1430870,
  1431449,
  1,
  'JHP_RS08265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF262 domain-containing protein',
  1431394,
  1433125,
  1,
  'JHP_RS08700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DHH family protein',
  1433171,
  1434426,
  1,
  'JHP_RS06830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1434471,
  1436382,
  1,
  'JHP_RS06835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06835'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1436452,
  1437364,
  1,
  'JHP_RS08270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'queF',
  'preQ(1) synthase',
  1437494,
  1437940,
  -1,
  'JHP_RS06845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rsfS',
  'ribosome silencing factor',
  1437999,
  1438340,
  1,
  'JHP_RS06850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06850'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'miaA',
  'tRNA (adenosine(37)-N6)-dimethylallyltransferaseMiaA',
  1438348,
  1439244,
  1,
  'JHP_RS06855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06855'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000381007.1',
  'glycosyltransferase family 8 protein',
  1439245,
  1440348,
  1,
  'JHP_RS06860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06860'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925899.1',
  'phosphoethanolamine transferase',
  1440365,
  1441162,
  1,
  'JHP_RS06865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06865'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000490557.1',
  'phosphoethanolamine transferase',
  1441173,
  1442024,
  1,
  'JHP_RS06870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06870'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000894898.1',
  'UDP-N-acetylmuramate dehydrogenase',
  1442085,
  1442864,
  -1,
  'JHP_RS06875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06875'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliQ',
  'flagellar biosynthesis protein FliQ',
  1442868,
  1443134,
  -1,
  'JHP_RS06880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06880'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliI',
  'flagellar protein export ATPase FliI',
  1443145,
  1444449,
  -1,
  'JHP_RS06885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06885'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000449301.1',
  'CpaF/VirB11 family protein',
  1444450,
  1445364,
  -1,
  'JHP_RS06890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06890'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ileS',
  'isoleucine--tRNA ligase',
  1445381,
  1448143,
  -1,
  'JHP_RS06895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06895'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001217177.1',
  'RNA-binding S4 domain-containing protein',
  1448163,
  1448417,
  -1,
  'JHP_RS06900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06900'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000671874.1',
  'hypothetical protein',
  1448519,
  1449139,
  1,
  'JHP_RS06905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06905'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_226928963.1',
  'hypothetical protein',
  1449289,
  1449486,
  -1,
  'JHP_RS06910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06910'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'hypothetical protein',
  1449437,
  1449556,
  -1,
  'JHP_RS08920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000188070.1',
  'hypothetical protein',
  1449558,
  1449740,
  1,
  'JHP_RS08705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hpnL',
  'nickel-binding protein HpnL',
  1449828,
  1450061,
  -1,
  'JHP_RS06920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06920'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rsmA',
  '16S rRNA(adenine(1518)-N(6)/adenine(1519)-N(6))-dimethyltransferase RsmA',
  1450314,
  1451129,
  1,
  'JHP_RS06925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000131651.1',
  'ribonuclease J',
  1451180,
  1453258,
  1,
  'JHP_RS06930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001121965.1',
  'KpsF/GutQ family sugar-phosphate isomerase',
  1453242,
  1454231,
  1,
  'JHP_RS06935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06935'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rlmN',
  'dual-specificity RNA methyltransferase RlmN',
  1454228,
  1455301,
  1,
  'JHP_RS06940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06940'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000923192.1',
  'hypothetical protein',
  1456084,
  1458570,
  -1,
  'JHP_RS06945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06945'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'purU',
  'formyltetrahydrofolate deformylase',
  1458571,
  1459452,
  -1,
  'JHP_RS06950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06950'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'sppA',
  'signal peptide peptidase SppA',
  1459455,
  1460333,
  -1,
  'JHP_RS06955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06955'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000752272.1',
  'hypothetical protein',
  1460404,
  1460664,
  1,
  'JHP_RS06960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06960'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'TIR domain protein',
  1460871,
  1461561,
  1,
  'JHP_RS06965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06965'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000465595.1',
  'hypothetical protein',
  1461570,
  1462055,
  1,
  'JHP_RS06970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06970'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882640.1',
  'hypothetical protein',
  1462065,
  1462490,
  1,
  'JHP_RS06975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06975'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1463045,
  1464547,
  -1,
  'JHP_RS06985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06985'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001873570.1',
  'hypothetical protein',
  1464549,
  1464728,
  1,
  'JHP_RS08280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000752524.1',
  'hypothetical protein',
  1465043,
  1465822,
  -1,
  'JHP_RS06990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06990'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882641.1',
  'peptidylprolyl isomerase',
  1465946,
  1466434,
  1,
  'JHP_RS06995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS06995'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000906455.1',
  'carbon storage regulator',
  1466452,
  1466682,
  1,
  'JHP_RS07000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07000'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000150065.1',
  '4-(cytidine5''-diphospho)-2-C-methyl-D-erythritol kinase',
  1466679,
  1467503,
  1,
  'JHP_RS07005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07005'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'smpB',
  'SsrA-binding protein',
  1467481,
  1467939,
  1,
  'JHP_RS07010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07010'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'exbB',
  'TonB-system energizer ExbB',
  1467942,
  1468394,
  1,
  'JHP_RS07015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07015'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000755082.1',
  'ExbD/TolR family protein',
  1468405,
  1468806,
  1,
  'JHP_RS07020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07020'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpmH',
  '50S ribosomal protein L34',
  1468878,
  1469012,
  1,
  'JHP_RS07025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07025'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rnpA',
  'ribonuclease P protein component',
  1468972,
  1469457,
  1,
  'JHP_RS07030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07030'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'yidD',
  'membrane protein insertion efficiency factorYidD',
  1469444,
  1469800,
  1,
  'JHP_RS07035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07035'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'yidC',
  'membrane protein insertase YidC',
  1469806,
  1471455,
  1,
  'JHP_RS07040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07040'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001180754.1',
  'Jag N-terminal domain-containing protein',
  1471469,
  1472245,
  1,
  'JHP_RS07045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07045'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mnmE',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis GTPase MnmE',
  1472238,
  1473590,
  1,
  'JHP_RS07050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07050'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000915421.1',
  'outer membrane beta-barrel protein',
  1473792,
  1476026,
  1,
  'JHP_RS07055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07055'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_046656384.1',
  'hypothetical protein',
  1476043,
  1476246,
  -1,
  'JHP_RS08715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000720426.1',
  'LPP20 family lipoprotein',
  1476622,
  1477533,
  -1,
  'JHP_RS07065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07065'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000824822.1',
  'hypothetical protein',
  1477543,
  1477884,
  -1,
  'JHP_RS07070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07070'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000795978.1',
  'LPP20 family lipoprotein',
  1477892,
  1478419,
  -1,
  'JHP_RS07075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07075'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpoB',
  'penicillin-binding protein activator LpoB',
  1478443,
  1479075,
  -1,
  'JHP_RS07080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07080'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000895155.1',
  'thioredoxin family protein',
  1479434,
  1479748,
  -1,
  'JHP_RS07085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07085'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000398342.1',
  'pseudouridine synthase',
  1479804,
  1480592,
  -1,
  'JHP_RS07090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07090'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dnaE',
  'DNA polymerase III subunit alpha',
  1480574,
  1484209,
  -1,
  'JHP_RS07095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07095'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000751054.1',
  'cytochrome-c peroxidase',
  1484358,
  1485410,
  1,
  'JHP_RS07100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07100'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001053522.1',
  'META domain-containing protein',
  1485705,
  1486292,
  -1,
  'JHP_RS07105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07105'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001202812.1',
  'hypothetical protein',
  1486311,
  1486988,
  -1,
  'JHP_RS07110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07110'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000439506.1',
  'MlaD family protein',
  1486991,
  1487806,
  -1,
  'JHP_RS07115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07115'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000994581.1',
  'ABC transporter ATP-binding protein',
  1487791,
  1488576,
  -1,
  'JHP_RS07120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07120'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000845821.1',
  'ABC transporter permease',
  1488576,
  1489709,
  -1,
  'JHP_RS07125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07125'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000473453.1',
  'outer membrane protein',
  1489843,
  1490538,
  1,
  'JHP_RS07130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07130'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ilvE',
  'branched-chain-amino-acid transaminase',
  1490543,
  1491565,
  -1,
  'JHP_RS07135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07135'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000919659.1',
  'outer membrane protein',
  1491616,
  1492362,
  -1,
  'JHP_RS07140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07140'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'polA',
  'DNA polymerase I',
  1492476,
  1495169,
  -1,
  'JHP_RS07145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07145'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000580077.1',
  'restriction endonuclease subunit S',
  1495233,
  1496453,
  -1,
  'JHP_RS07150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07150'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001045380.1',
  'N-6 DNA methylase',
  1496450,
  1498486,
  -1,
  'JHP_RS07155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07155'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001203557.1',
  'ComF family protein',
  1498518,
  1499093,
  -1,
  'JHP_RS07160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07160'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tmk',
  'dTMP kinase',
  1499081,
  1499656,
  -1,
  'JHP_RS07165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07165'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'coaD',
  'pantetheine-phosphate adenylyltransferase',
  1499660,
  1500133,
  -1,
  'JHP_RS07170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07170'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000780089.1',
  'UbiX family flavin prenyltransferase',
  1500133,
  1500696,
  -1,
  'JHP_RS07175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07175'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgA',
  'flagellar basal body P-ring formation chaperoneFlgA',
  1500706,
  1501362,
  -1,
  'JHP_RS07180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07180'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'uvrD',
  'DNA helicase UvrD',
  1501359,
  1503404,
  -1,
  'JHP_RS07185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07185'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000931072.1',
  'tetratricopeptide repeat protein',
  1503404,
  1505929,
  -1,
  'JHP_RS07190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07190'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'serS',
  'serine--tRNA ligase',
  1505939,
  1507186,
  -1,
  'JHP_RS07195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07195'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001262091.1',
  'carbon-nitrogen hydrolase family protein',
  1507187,
  1507984,
  -1,
  'JHP_RS07200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07200'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001150271.1',
  'exodeoxyribonuclease VII small subunit',
  1507988,
  1508248,
  -1,
  'JHP_RS07205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07205'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ubiE',
  'bifunctional demethylmenaquinonemethyltransferase/2-methoxy-6-polyprenyl-1,4-benzoquinolmethylase UbiE',
  1508258,
  1508998,
  -1,
  'JHP_RS07210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07210'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'hemJ',
  'protoporphyrinogen oxidase HemJ',
  1509007,
  1509453,
  -1,
  'JHP_RS07215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07215'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000854102.1',
  'YigZ family protein',
  1509463,
  1510035,
  -1,
  'JHP_RS07220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07220'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001008903.1',
  'ABC transporter permease',
  1510022,
  1511152,
  -1,
  'JHP_RS07225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07225'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_160442661.1',
  'ABC transporter permease',
  1511149,
  1512237,
  -1,
  'JHP_RS07230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07230'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000071846.1',
  'HlyD family secretion protein',
  1512258,
  1513247,
  -1,
  'JHP_RS07235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07235'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000754014.1',
  'TolC family protein',
  1513259,
  1514791,
  -1,
  'JHP_RS07240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07240'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000533265.1',
  'hemolysin family protein',
  1514788,
  1516137,
  -1,
  'JHP_RS07245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07245'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000405913.1',
  'inorganic phosphate transporter',
  1516243,
  1517844,
  -1,
  'JHP_RS07250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07250'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000569296.1',
  'NifU family protein',
  1517985,
  1518254,
  1,
  'JHP_RS07255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07255'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001168630.1',
  'hypothetical protein',
  1518267,
  1518878,
  1,
  'JHP_RS07260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07260'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000768761.1',
  'UDP-N-acetylmuramoyl-L-alanyl-D-glutamate--2,6-diaminopimelate ligase',
  1518882,
  1520225,
  1,
  'JHP_RS07265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07265'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tal',
  'transaldolase',
  1520228,
  1521178,
  1,
  'JHP_RS07270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07270'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000889309.1',
  '50S ribosomal protein L25/general stress proteinCtc',
  1521233,
  1521769,
  1,
  'JHP_RS07275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07275'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pth',
  'aminoacyl-tRNA hydrolase',
  1521779,
  1522339,
  1,
  'JHP_RS07280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07280'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001236162.1',
  'LptF/LptG family permease',
  1522349,
  1523416,
  1,
  'JHP_RS07285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07285'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000100116.1',
  'phospholipase D-like domain-containing protein',
  1523537,
  1524457,
  1,
  'JHP_RS07290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07290'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000659710.1',
  'hypothetical protein',
  1524534,
  1524704,
  1,
  'JHP_RS08500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_162465341.1',
  'outer membrane protein',
  1524768,
  1525931,
  -1,
  'JHP_RS07300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000338914.1',
  'CopD family copper resistance protein',
  1526113,
  1526550,
  1,
  'JHP_RS07305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07305'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000650153.1',
  'heavy metal translocating P-type ATPase',
  1526547,
  1528913,
  -1,
  'JHP_RS07310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000375331.1',
  'tRNA1(Val) (adenine(37)-N6)-methyltransferase',
  1528923,
  1529639,
  -1,
  'JHP_RS07315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07315'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ribD',
  'bifunctionaldiaminohydroxyphosphoribosylaminopyrimidinedeaminase/5-amino-6-(5-phosphoribosylamino)uracilreductase RibD',
  1529621,
  1530655,
  -1,
  'JHP_RS07320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07320'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'gltS',
  'sodium/glutamate symporter',
  1530659,
  1531885,
  -1,
  'JHP_RS07325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07325'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000557646.1',
  'saccharopine dehydrogenase family protein',
  1531971,
  1533170,
  1,
  'JHP_RS07330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07330'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ccoG',
  'cytochrome c oxidase accessory protein CcoG',
  1533180,
  1534556,
  -1,
  'JHP_RS07335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07335'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'plsY',
  'glycerol-3-phosphate 1-O-acyltransferase PlsY',
  1534662,
  1535324,
  1,
  'JHP_RS07340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07340'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000850841.1',
  'FolB domain-containing protein',
  1535321,
  1535674,
  1,
  'JHP_RS07345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07345'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000802473.1',
  'hypothetical protein',
  1535658,
  1535984,
  1,
  'JHP_RS07350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07350'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000945791.1',
  'TonB-dependent receptor',
  1536153,
  1538792,
  1,
  'JHP_RS07355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07355'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001284248.1',
  'aminotransferase class V-fold PLP-dependentenzyme',
  1539018,
  1540190,
  1,
  'JHP_RS07360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07360'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nusA',
  'transcription termination factor NusA',
  1540286,
  1541473,
  1,
  'JHP_RS07365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07365'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001153499.1',
  'hypothetical protein',
  1541530,
  1542213,
  1,
  'JHP_RS07370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07370'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000986843.1',
  'class I SAM-dependent DNA methyltransferase',
  1543496,
  1547257,
  -1,
  'JHP_RS07385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07385'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000693720.1',
  'type III restriction-modification systemendonuclease',
  1547376,
  1550285,
  -1,
  'JHP_RS07390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07390'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_064800094.1',
  'site-specific DNA-methyltransferase',
  1550288,
  1550869,
  -1,
  'JHP_RS08845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08845'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001179846.1',
  'site-specific DNA-methyltransferase',
  1550874,
  1552214,
  -1,
  'JHP_RS07400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07400'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'recG',
  'ATP-dependent DNA helicase RecG',
  1552266,
  1554137,
  -1,
  'JHP_RS07405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07405'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000837074.1',
  'hypothetical protein',
  1554214,
  1554561,
  1,
  'JHP_RS07410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07410'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000668069.1',
  'outer membrane protein',
  1554565,
  1555200,
  1,
  'JHP_RS07415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07415'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000767522.1',
  'exodeoxyribonuclease III',
  1555197,
  1555949,
  -1,
  'JHP_RS07420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07420'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  '—',
  1556051,
  1556126,
  1,
  'JHP_RS07425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07425'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000748996.1',
  'hypothetical protein',
  1556129,
  1557568,
  -1,
  'JHP_RS07430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07430'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'dnaA',
  'chromosomal replication initiator protein DnaA',
  1557789,
  1559162,
  -1,
  'JHP_RS07435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07435'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000923012.1',
  'nucleoside phosphorylase-I family protein',
  1559315,
  1559857,
  1,
  'JHP_RS07440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07440'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000461837.1',
  'DUF2443 domain-containing protein',
  1559902,
  1560141,
  1,
  'JHP_RS07445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07445'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'glmS',
  'glutamine--fructose-6-phosphate transaminase(isomerizing)',
  1560142,
  1561935,
  1,
  'JHP_RS07450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07450'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'thyX',
  'FAD-dependent thymidylate synthase',
  1561959,
  1562585,
  1,
  'JHP_RS07455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07455'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993067.1',
  'cagY like domain protein',
  1562628,
  1562756,
  -1,
  'JHP_RS08300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08300'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_425277100.1',
  'restriction endonuclease subunit S',
  1562916,
  1563560,
  -1,
  'JHP_RS08925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08925'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'restriction endonuclease subunit S',
  1563540,
  1564787,
  -1,
  'JHP_RS08930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08930'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000985378.1',
  'type I restriction-modification system subunitM',
  1564787,
  1567234,
  -1,
  'JHP_RS07475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07475'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000846169.1',
  'type I restriction endonuclease subunit R',
  1567305,
  1570280,
  1,
  'JHP_RS07480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07480'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000995224.1',
  'YgjP family zinc-dependent metalloprotease',
  1570280,
  1570987,
  1,
  'JHP_RS07485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07485'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000549156.1',
  'TonB-dependent receptor family protein',
  1571081,
  1573606,
  -1,
  'JHP_RS07490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07490'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rocF',
  'arginase',
  1574136,
  1575104,
  -1,
  'JHP_RS07495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07495'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000152030.1',
  'alanine dehydrogenase',
  1575308,
  1576450,
  1,
  'JHP_RS07500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07500'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000551182.1',
  'NAD(P)-dependent alcohol dehydrogenase',
  1576698,
  1577795,
  1,
  'JHP_RS07505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07505'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF262 domain-containing protein',
  1577928,
  1579690,
  1,
  'JHP_RS07510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07510'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000713157.1',
  'outer membrane protein',
  1579701,
  1580429,
  -1,
  'JHP_RS07515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07515'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_171886548.1',
  'NAD(+)/NADH kinase',
  1580584,
  1581468,
  1,
  'JHP_RS07520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001204511.1',
  'DNA repair protein RecN',
  1581506,
  1583074,
  1,
  'JHP_RS07525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882650.1',
  'NFACT family protein',
  1583077,
  1584384,
  1,
  'JHP_RS07530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000539097.1',
  'hypothetical protein',
  1584403,
  1584699,
  1,
  'JHP_RS07535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000901594.1',
  'tetratricopeptide repeat protein',
  1584853,
  1585623,
  1,
  'JHP_RS07540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925903.1',
  '3''-5'' exonuclease',
  1585662,
  1586525,
  -1,
  'JHP_RS07545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpe',
  'ribulose-phosphate 3-epimerase',
  1586503,
  1587156,
  -1,
  'JHP_RS07550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000384963.1',
  'class 1 fructose-bisphosphatase',
  1587227,
  1588099,
  1,
  'JHP_RS07555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001885283.1',
  'hypothetical protein',
  1588099,
  1588302,
  1,
  'JHP_RS07560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'restriction endonuclease',
  1588369,
  1589350,
  1,
  'JHP_RS07565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'crdR',
  'copper response regulator transcription factorCrdR',
  1589437,
  1590078,
  1,
  'JHP_RS07570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tsf',
  'translation elongation factor Ts',
  1590257,
  1591324,
  -1,
  'JHP_RS07575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'rpsB',
  '30S ribosomal protein S2',
  1591324,
  1592118,
  -1,
  'JHP_RS07580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000380056.1',
  'RecB-like helicase',
  1592367,
  1595207,
  1,
  'JHP_RS07585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'nhaA',
  'sodium/proton antiporter NhaA',
  1595231,
  1596547,
  1,
  'JHP_RS07590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'yajC',
  'preprotein translocase subunit YajC',
  1596595,
  1596888,
  1,
  'JHP_RS07595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'secD',
  'protein translocase subunit SecD',
  1596889,
  1598469,
  1,
  'JHP_RS07600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'secF',
  'protein translocase subunit SecF',
  1598478,
  1599449,
  1,
  'JHP_RS07605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000383761.1',
  'DUF6394 family protein',
  1599459,
  1599797,
  1,
  'JHP_RS07610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'leuS',
  'leucine--tRNA ligase',
  1599807,
  1602227,
  1,
  'JHP_RS07615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lptE',
  'LPS assembly lipoprotein LptE',
  1602224,
  1602736,
  1,
  'JHP_RS07620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000797870.1',
  'bifunctional folylpolyglutamatesynthase/dihydrofolate synthase',
  1602726,
  1603895,
  1,
  'JHP_RS07625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'csd2',
  'M23B family cell shape-determiningDD-metalloendopeptidase Csd2',
  1603895,
  1604821,
  1,
  'JHP_RS07630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'csd1',
  'peptidoglycan DD-metalloendopeptidase Csd1',
  1604831,
  1605769,
  1,
  'JHP_RS07635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882652.1',
  'bactofilin family protein',
  1605688,
  1606098,
  1,
  'JHP_RS07640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mfd',
  'transcription-repair coupling factor',
  1606102,
  1609107,
  1,
  'JHP_RS07645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'petA',
  'ubiquinol-cytochrome c reductase iron-sulfursubunit',
  1609232,
  1609735,
  1,
  'JHP_RS07650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000818131.1',
  'cytochrome b',
  1609746,
  1610984,
  1,
  'JHP_RS07655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000657554.1',
  'cytochrome c1',
  1610981,
  1611838,
  1,
  'JHP_RS07660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001208219.1',
  'DUF3226 domain-containing protein',
  1612166,
  1612696,
  -1,
  'JHP_RS07670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000597738.1',
  'AAA family ATPase',
  1612696,
  1613799,
  -1,
  'JHP_RS07675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000369045.1',
  'peptidoglycan D,D-transpeptidase FtsI familyprotein',
  1614129,
  1615970,
  -1,
  'JHP_RS07680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_079993044.1',
  'transcriptional regulator',
  1615977,
  1616102,
  -1,
  'JHP_RS08310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS08310'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'fliE',
  'flagellar hook-basal body complex protein FliE',
  1616126,
  1616455,
  -1,
  'JHP_RS07685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgC',
  'flagellar basal body rod protein FlgC',
  1616583,
  1617068,
  -1,
  'JHP_RS07690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgB',
  'flagellar basal body rod protein FlgB',
  1617081,
  1617503,
  -1,
  'JHP_RS07695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000205902.1',
  'FtsW/RodA/SpoVE family cell cycle protein',
  1617708,
  1618874,
  1,
  'JHP_RS07700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000961735.1',
  'ABC transporter substrate-binding protein',
  1618897,
  1619904,
  -1,
  'JHP_RS07705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000903787.1',
  'ABC transporter substrate-binding protein',
  1620112,
  1621113,
  -1,
  'JHP_RS07710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000961648.1',
  'peroxiredoxin',
  1621351,
  1621947,
  1,
  'JHP_RS07715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001020046.1',
  'MetQ/NlpA family ABC transportersubstrate-binding protein',
  1622093,
  1622908,
  1,
  'JHP_RS07720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'mrdA',
  'penicillin-binding protein 2',
  1623355,
  1625121,
  -1,
  'JHP_RS07725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000949852.1',
  'hypothetical protein',
  1625102,
  1625545,
  -1,
  'JHP_RS07730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'yihA',
  'ribosome biogenesis GTP-binding proteinYihA/YsxC',
  1625555,
  1626181,
  -1,
  'JHP_RS07735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lptA',
  'lipopolysaccharide transport periplasmic proteinLptA',
  1626178,
  1626735,
  -1,
  'JHP_RS07740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000650305.1',
  'hypothetical protein',
  1626735,
  1627328,
  -1,
  'JHP_RS07745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000593719.1',
  'KdsC family phosphatase',
  1627303,
  1627797,
  -1,
  'JHP_RS07750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000539594.1',
  'septal ring lytic transglycosylase RlpA familyprotein',
  1627794,
  1628738,
  -1,
  'JHP_RS07755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001126227.1',
  'lytic transglycosylase domain-containingprotein',
  1628738,
  1629862,
  -1,
  'JHP_RS07760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000469303.1',
  'TatD family hydrolase',
  1629946,
  1630710,
  -1,
  'JHP_RS07765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'ribE',
  'riboflavin synthase',
  1630785,
  1631405,
  1,
  'JHP_RS07770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_001044047.1',
  'FlhB-like flagellar biosynthesis protein',
  1631406,
  1631678,
  1,
  'JHP_RS07775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000259823.1',
  'methionine ABC transporter ATP-binding protein',
  1631697,
  1632680,
  1,
  'JHP_RS07780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'metI',
  'methionine ABC transporter permease MetI',
  1632682,
  1633329,
  1,
  'JHP_RS07785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07785'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000914352.1',
  'hypothetical protein',
  1633520,
  1633942,
  -1,
  'JHP_RS07790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07790'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'lpxF',
  'lipid A 4''-phosphatase',
  1633952,
  1634548,
  -1,
  'JHP_RS07795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07795'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_010882653.1',
  'undecaprenylphosphate N-acetylglucosaminyltransferase WecA',
  1634548,
  1635555,
  -1,
  'JHP_RS07800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07800'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pdxJ',
  'pyridoxine 5''-phosphate synthase',
  1635691,
  1636479,
  1,
  'JHP_RS07805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07805'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'pdxA',
  '4-hydroxythreonine-4-phosphate dehydrogenase',
  1636481,
  1637404,
  1,
  'JHP_RS07810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07810'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'tsaD',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complextransferase subunit TsaD',
  1637754,
  1638776,
  1,
  'JHP_RS07815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07815'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'flgG',
  'flagellar basal-body rod protein FlgG',
  1639654,
  1640442,
  1,
  'JHP_RS07820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07820'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  '—',
  'DUF3944 domain-containing protein',
  1640541,
  1641479,
  -1,
  'JHP_RS07825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07825'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_000323694.1',
  'YaaW family protein',
  1642226,
  1642987,
  -1,
  'JHP_RS07830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07830'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  'WP_041925953.1',
  'hypothetical protein',
  1643353,
  1643550,
  -1,
  'JHP_RS07835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1) AND locus_tag='JHP_RS07835'
);

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'ChIP-Seq', 'ChIP-Seq', NULL, 'ECO:0006009'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0006009'
);

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'AAGATTACATT',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1),
  96464,
  96474,
  -1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1)
    AND start=96464 AND end=96474 AND strand=-1
    AND _seq='AAGATTACATT'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000921.1' LIMIT 1)
          AND start=96464 AND end=96474 AND strand=-1
          AND _seq='AAGATTACATT'
        ORDER BY site_id DESC LIMIT 1),
   'AAGATTACATT',
   0,
   'variable',
   'activator',
   'monomer');

COMMIT;