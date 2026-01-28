PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

INSERT INTO core_publication
  (pmid, doi, title, authors, journal, pub_date,
   publication_type, reported_TF, reported_species,
   contains_promoter_data, contains_expression_data,
   curation_complete, submission_notes)
SELECT
  '37907733',
  '10.1038/s41396-023-01548-0',
  'Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.',
  'deCarvalho T, Mascolo E, Caruso SM, López-Pérez J, Weston-Hafer K, Shaffer C, Erill I',
  'The ISME journal',
  '2023 Dec',
  'ARTICLE',
  'DosR',
  '',
  0,
  0,
  1,
  'Revision reason: No comparable TF protein sequence in NCBI
prueba'
WHERE NOT EXISTS (
  SELECT 1 FROM core_publication WHERE pmid='37907733'
);

UPDATE core_publication
SET
  title = CASE WHEN title IS NULL OR title='' THEN 'Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.' ELSE title END,
  authors = CASE WHEN authors IS NULL OR authors='' THEN 'deCarvalho T, Mascolo E, Caruso SM, López-Pérez J, Weston-Hafer K, Shaffer C, Erill I' ELSE authors END,
  journal = CASE WHEN journal IS NULL OR journal='' THEN 'The ISME journal' ELSE journal END,
  pub_date = CASE WHEN pub_date IS NULL OR pub_date='' THEN '2023 Dec' ELSE pub_date END,
  reported_TF = CASE WHEN reported_TF IS NULL OR reported_TF='' THEN 'DosR' ELSE reported_TF END,
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN '' ELSE reported_species END,
  contains_promoter_data = 0,
  contains_expression_data = 0,
  curation_complete = 1,
  submission_notes = CASE
    WHEN submission_notes IS NULL OR submission_notes=''
    THEN 'Revision reason: No comparable TF protein sequence in NCBI
prueba'
    ELSE submission_notes
  END
WHERE pmid='37907733';

INSERT INTO core_tf (name, family_id, description)
SELECT 'DosR', 2, 'prueba'
WHERE NOT EXISTS (SELECT 1 FROM core_tf WHERE lower(name)=lower('DosR'));

UPDATE core_tf
SET family_id = COALESCE(family_id, 2)
WHERE lower(name)=lower('DosR');

INSERT INTO core_tfinstance (refseq_accession, uniprot_accession, TF_id)
SELECT
  '[object Object]',
  '[object Object]',
  (SELECT tf_id FROM core_tf WHERE lower(name)=lower('DosR') LIMIT 1)
WHERE NOT EXISTS (SELECT 1 FROM core_tfinstance WHERE uniprot_accession='[object Object]');

UPDATE core_tfinstance
SET TF_id = COALESCE(TF_id, (SELECT tf_id FROM core_tf WHERE lower(name)=lower('DosR') LIMIT 1)),
    refseq_accession = CASE
      WHEN refseq_accession IS NULL OR refseq_accession='' THEN '[object Object]'
      ELSE refseq_accession
    END
WHERE uniprot_accession='[object Object]';

INSERT INTO core_curation
  (TF_species, site_species, experimental_process, forms_complex,
   complex_notes, notes, last_modified, curator_id, publication_id, created, validated_by_id)
VALUES
  ('', '', '',
   0, '', 'Revision reason: No comparable TF protein sequence in NCBI
prueba',
   datetime('now'), (SELECT curator_id FROM core_curator ORDER BY curator_id LIMIT 1), (SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1), datetime('now'), NULL);

INSERT INTO core_curation_TF_instances (curation_id, tfinstance_id)
SELECT (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1), (SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='[object Object]' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_curation_TF_instances
  WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1) AND tfinstance_id=(SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='[object Object]' LIMIT 1)
);

INSERT INTO core_genome (organism_name, genome_accession)
SELECT '', 'NC_000915.1'
WHERE NOT EXISTS (SELECT 1 FROM core_genome WHERE genome_accession='NC_000915.1');

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00005',
  'nusB',
  'transcription antitermination factor NusB',
  217,
  633,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00010',
  'ribH',
  '6,7-dimethyl-8-ribityllumazine synthase',
  635,
  1105,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00015',
  'kdsA',
  '3-deoxy-8-phosphooctulonate synthase',
  1115,
  1945,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00020',
  'WP_000642977.1',
  'carbonic anhydrase',
  1932,
  2597,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00025',
  'pyrF',
  'orotidine-5''-phosphate decarboxylase',
  2719,
  3402,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00030',
  'panC',
  'pantoate--beta-alanine ligase',
  3403,
  4233,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00035',
  '—',
  '',
  4247,
  4322,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00040',
  '—',
  '',
  4385,
  4461,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00045',
  '—',
  '',
  4502,
  4577,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00050',
  '—',
  '',
  4619,
  4693,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00055',
  '—',
  '',
  4704,
  4779,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00060',
  'hopZ',
  'Hop family adhesin HopZ',
  5241,
  7265,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00065',
  'groL',
  'chaperonin GroEL',
  7603,
  9243,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00070',
  'groES',
  'co-chaperone GroES',
  9268,
  9624,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00075',
  'dnaG',
  'DNA primase',
  9911,
  11590,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00080',
  'WP_000721203.1',
  'MnmA/TRMU family protein',
  11587,
  12639,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00085',
  'WP_001154906.1',
  'DUF5718 family protein',
  12728,
  13555,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00090',
  'WP_001272690.1',
  'TrbC/VirB2 family protein',
  13702,
  13983,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00095',
  'WP_000584956.1',
  'hypothetical protein',
  13983,
  14246,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00100',
  'WP_000890508.1',
  'VirB4 family type IV secretion/conjugal transferATPase',
  14248,
  16611,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00105',
  'ffs',
  '',
  16661,
  16758,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00110',
  'WP_015056018.1',
  'COG3014 family protein',
  16932,
  18272,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00115',
  'cheV1',
  'chemotaxis protein CheV1',
  18380,
  19345,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00120',
  'nspC',
  'carboxynorspermidine decarboxylase',
  19342,
  20559,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00125',
  'lpxE',
  'lipid A 1-phosphatase LpxE',
  20569,
  21102,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00130',
  'eptA',
  'phosphoethanolamine--lipid A transferase EptA',
  21152,
  22717,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00135',
  'labA',
  'Hop family adhesin LabA',
  23324,
  25459,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00140',
  'WP_000476392.1',
  'hypothetical protein',
  25870,
  26013,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00145',
  'WP_000117507.1',
  'citrate synthase',
  26078,
  27358,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00150',
  'icd',
  'isocitrate dehydrogenase (NADP(+))',
  27557,
  28834,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00155',
  'WP_001862535.1',
  'DUF1523 family protein',
  28907,
  29434,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00160',
  'bioD',
  'dethiobiotin synthase',
  29411,
  30067,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00165',
  'WP_000926158.1',
  'hypothetical protein',
  30071,
  31852,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00170',
  'WP_001023005.1',
  'universal stress protein',
  31961,
  32374,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00175',
  'WP_000784920.1',
  'ATP-dependent Clp protease adaptor ClpS',
  32405,
  32680,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00180',
  'WP_001051514.1',
  'AAA family ATPase',
  32680,
  34905,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00185',
  'panD',
  'aspartate 1-decarboxylase',
  34895,
  35248,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00190',
  'WP_000347915.1',
  'YbaB/EbfC family nucleoid-associated protein',
  35251,
  35544,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00195',
  'WP_000468475.1',
  'PDZ domain-containing protein',
  35544,
  36548,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00200',
  'WP_000786660.1',
  'type IV secretion system protein',
  36556,
  37611,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07970',
  '—',
  'comB7 lipoprotein',
  37627,
  37741,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00210',
  'WP_000660509.1',
  'VirB8 family type IV secretion system protein',
  37738,
  38475,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00215',
  '—',
  'TrbG/VirB9 family P-type conjugative transferprotein',
  38475,
  39453,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00220',
  '—',
  'DNA type IV secretion system protein ComB10',
  39446,
  40581,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00225',
  'WP_000694809.1',
  'mannose-1-phosphateguanylyltransferase/mannose-6-phosphate isomerase',
  40651,
  42063,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00230',
  'gmd',
  'GDP-mannose 4,6-dehydratase',
  42105,
  43250,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00235',
  'WP_001002442.1',
  'GDP-L-fucose synthase family protein',
  43243,
  44175,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07975',
  '—',
  'hypothetical protein',
  44575,
  44891,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00240',
  'hypE',
  'hydrogenase expression/formation protein HypE',
  45041,
  46039,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00245',
  'hypF',
  'carbamoyltransferase HypF',
  46042,
  48294,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00250',
  'WP_000827275.1',
  'agmatine deiminase family protein',
  48291,
  49283,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00255',
  'WP_000614886.1',
  'DNA-methyltransferase',
  49335,
  50033,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00260',
  'WP_001106909.1',
  'DNA cytosine methyltransferase',
  50030,
  51097,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00265',
  '—',
  'HNH endonuclease',
  51094,
  52264,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00270',
  'WP_000664224.1',
  'hypothetical protein',
  52459,
  53718,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00275',
  'WP_000895775.1',
  'adenine/cytosine DNA methyltransferase',
  53715,
  56186,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00280',
  'putP',
  'sodium/proline symporter PutP',
  56224,
  57714,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00285',
  'WP_001169304.1',
  'bifunctional proline dehydrogenase/L-glutamategamma-semialdehyde dehydrogenase',
  57741,
  61298,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00290',
  'WP_000849034.1',
  'hypothetical protein',
  61619,
  61828,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00295',
  'WP_080474202.1',
  'hypothetical protein',
  62133,
  63143,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00300',
  'WP_000536434.1',
  'coiled-coil domain-containing protein',
  63145,
  63999,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00305',
  'WP_000258489.1',
  'Hsp70 family protein',
  64016,
  66457,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00310',
  'WP_000988444.1',
  'hypothetical protein',
  66454,
  67023,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00315',
  'WP_000092102.1',
  'hypothetical protein',
  67039,
  67299,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00320',
  'WP_000852747.1',
  'HNH endonuclease',
  67310,
  68800,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00325',
  'WP_000447902.1',
  'SMI1/KNR4 family protein',
  68770,
  69189,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00330',
  'WP_000491247.1',
  'hypothetical protein',
  69191,
  69544,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00335',
  'WP_000567893.1',
  'FtsK/SpoIIIE domain-containing protein',
  69537,
  71963,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00340',
  'WP_001099471.1',
  'urease accessory protein UreD',
  72021,
  72818,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00345',
  'ureG',
  'urease accessory protein UreG',
  72818,
  73417,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00350',
  'WP_000357404.1',
  'urease accessory protein UreF',
  73446,
  74210,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00355',
  'ureE',
  'urease accessory protein UreE',
  74233,
  74745,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00360',
  'ureI',
  'acid-activated urea channel protein UreI',
  74747,
  75334,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00365',
  'ureB',
  'urease subunit beta',
  75527,
  77236,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00370',
  'ureA',
  'urease subunit alpha',
  77240,
  77956,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00375',
  '—',
  '',
  78206,
  78281,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00380',
  'lspA',
  'signal peptidase II',
  78302,
  78775,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00385',
  'glmM',
  'phosphoglucosamine mutase',
  78769,
  80106,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00390',
  'rpsT',
  '30S ribosomal protein S20',
  80196,
  80465,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00395',
  'prfA',
  'peptide chain release factor 1',
  80589,
  81647,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00400',
  'WP_000755201.1',
  'membrane protein',
  82058,
  82315,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00405',
  'WP_000748046.1',
  'outer membrane beta-barrel protein',
  82326,
  84113,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00410',
  'WP_000644179.1',
  'hypothetical protein',
  84359,
  86140,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00415',
  'tlpC',
  'methyl-accepting chemotaxis protein TlpC',
  86656,
  88677,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00420',
  'rpsI',
  '30S ribosomal protein S9',
  88833,
  89222,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00425',
  'rplM',
  '50S ribosomal protein L13',
  89219,
  89644,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00430',
  'WP_001168427.1',
  'DUF5408 family protein',
  89957,
  90145,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00435',
  'WP_000061441.1',
  'FAD-dependent oxidoreductase',
  90152,
  91504,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00440',
  'WP_001268661.1',
  'SH3 domain-containing C40 family peptidase',
  91558,
  92931,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00445',
  'rpoD',
  'RNA polymerase sigma factor RpoD',
  92952,
  94994,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00450',
  'mtnN',
  '5''-methylthioadenosine/adenosylhomocysteinenucleosidase',
  95191,
  95886,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00455',
  'fabD',
  'ACP S-malonyltransferase',
  95897,
  96826,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00460',
  '—',
  '',
  96959,
  97050,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00465',
  'WP_000788527.1',
  'type II restriction endonuclease',
  97256,
  98089,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00470',
  'WP_000233875.1',
  'DNA-methyltransferase',
  98083,
  98916,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00475',
  'futC1',
  'alpha-(1,2)-fucosyltransferase FutC1',
  98936,
  99376,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00480',
  'WP_000874844.1',
  'O-fucosyltransferase family protein',
  99373,
  99840,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00485',
  'WP_001125803.1',
  'hypothetical protein',
  99939,
  100469,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00490',
  'WP_000846779.1',
  'D-2-hydroxyacid dehydrogenase',
  100542,
  101486,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00495',
  'WP_000725112.1',
  'hypothetical protein',
  101643,
  102356,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00500',
  'thrC',
  'threonine synthase',
  102461,
  103921,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00505',
  'tlpA',
  'methyl-accepting chemotaxis protein TlpA',
  104125,
  106152,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00510',
  'WP_000905219.1',
  'epoxyqueuosine reductase QueH',
  106152,
  107258,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00515',
  'WP_000853678.1',
  'outer membrane beta-barrel protein',
  107471,
  108232,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00520',
  'WP_000922020.1',
  'glycosyltransferase family 2 protein',
  108215,
  108994,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00525',
  'tlpB',
  'methyl-accepting chemotaxis protein TlpB',
  109025,
  110722,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00530',
  'WP_000737638.1',
  'bifunctional metallophosphatase/5''-nucleotidase',
  110928,
  112673,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00535',
  'WP_000856671.1',
  'S-ribosylhomocysteine lyase',
  112828,
  113295,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00540',
  'WP_001242837.1',
  'cystathionine gamma-synthase',
  113333,
  114475,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00545',
  'WP_042964654.1',
  'O-acetylserine-dependent cystathioninebeta-synthase',
  114500,
  115417,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00550',
  '—',
  'hypothetical protein',
  115531,
  116113,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00555',
  'dnaK',
  'molecular chaperone DnaK',
  116362,
  118224,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00560',
  'grpE',
  'nucleotide exchange factor GrpE',
  118254,
  118823,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00565',
  'WP_000234019.1',
  'HrcA family transcriptional regulator',
  118823,
  119653,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00570',
  'WP_001862506.1',
  'class II aldolase and adducin N-terminaldomain-containing protein',
  120037,
  120675,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00575',
  'WP_000154738.1',
  'hypothetical protein',
  120696,
  120992,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00580',
  'WP_001862505.1',
  'motility associated factor glycosyltransferasefamily protein',
  121002,
  122885,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00585',
  'WP_000010001.1',
  'flagellin B',
  122948,
  124492,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00590',
  'topA',
  'type I DNA topoisomerase',
  124658,
  126868,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00595',
  'WP_001040794.1',
  'radical SAM protein',
  126861,
  127787,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00600',
  'WP_000446641.1',
  'DUF874 family protein',
  127931,
  129118,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00605',
  'WP_001144146.1',
  'DUF874 family protein',
  129383,
  130768,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00610',
  'WP_000446639.1',
  'DUF874 family protein',
  131053,
  132249,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00615',
  'ppsA',
  'pyruvate, water dikinase',
  132346,
  134784,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00620',
  'thrS',
  'threonine--tRNA ligase',
  135142,
  136980,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00625',
  'infC',
  'translation initiation factor IF-3',
  136977,
  137588,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00630',
  'rpmI',
  '50S ribosomal protein L35',
  137569,
  137763,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00635',
  'rplT',
  '50S ribosomal protein L20',
  137857,
  138207,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00640',
  'WP_000750174.1',
  'outer membrane protein',
  138407,
  139267,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00645',
  'WP_000731991.1',
  'DUF1104 domain-containing protein',
  139617,
  140042,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00650',
  'WP_000821582.1',
  'hypothetical protein',
  140453,
  141313,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00655',
  'WP_000135967.1',
  'L-serine ammonia-lyase',
  142227,
  143594,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00660',
  'WP_000046401.1',
  'HAAAP family serine/threonine permease',
  143594,
  144835,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00665',
  'WP_000072772.1',
  'class II 3-deoxy-7-phosphoheptulonate synthase',
  145016,
  146365,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07980',
  'WP_001222899.1',
  'hypothetical protein',
  146444,
  146578,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00670',
  'WP_000412947.1',
  'peroxiredoxin',
  146813,
  147271,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00675',
  'WP_000032040.1',
  'LutC/YkgG family protein',
  147281,
  147916,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00680',
  'WP_000417304.1',
  'LutB/LldF family L-lactate oxidation iron-sulfurprotein',
  147909,
  149354,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00685',
  'WP_000867263.1',
  '(Fe-S)-binding protein',
  149383,
  150111,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00690',
  'WP_000398080.1',
  'L-lactate permease',
  150342,
  151991,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00695',
  'WP_000889036.1',
  'L-lactate permease',
  152048,
  153703,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00700',
  'WP_010875444.1',
  'adenine-specific DNA glycosylase',
  153727,
  154713,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00705',
  '—',
  'DASS family sodium-coupled anion symporter',
  154714,
  156164,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00710',
  'ccoN',
  'cytochrome-c oxidase, cbb3-type subunit I',
  156334,
  157800,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00715',
  'ccoO',
  'cytochrome-c oxidase, cbb3-type subunit II',
  157813,
  158511,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00720',
  'WP_001862885.1',
  'cytochrome c oxidase, cbb3-type, CcoQ subunit',
  158522,
  158740,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00725',
  'ccoP',
  'cytochrome-c oxidase, cbb3-type subunit III',
  158742,
  159619,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00730',
  'WP_000670506.1',
  'DUF4006 family protein',
  159630,
  159836,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00735',
  'WP_001221992.1',
  'hypothetical protein',
  159937,
  160521,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00740',
  'WP_000660370.1',
  'hypothetical protein',
  160534,
  161124,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00745',
  'WP_000506345.1',
  'hypothetical protein',
  161202,
  161969,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00750',
  'WP_000626212.1',
  'menaquinone biosynthesis family protein',
  161966,
  162829,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00755',
  'recA',
  'recombinase RecA',
  162928,
  163971,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00760',
  'eno',
  'phosphopyruvate hydratase',
  163983,
  165263,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00765',
  'WP_000146222.1',
  'hypothetical protein',
  165256,
  165531,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00770',
  'WP_001862880.1',
  'AMIN domain-containing protein',
  165549,
  166145,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00775',
  'WP_001164290.1',
  'shikimate kinase',
  166150,
  166638,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00780',
  'WP_000952264.1',
  'PDC sensor domain-containing protein',
  166660,
  167616,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00785',
  'rfaJ',
  'HP0159 family lipopolysaccharide1,6-glucosyltransferase',
  167613,
  168731,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00790',
  'hcpD',
  'Sel1-like repeat protein HcpD',
  168882,
  169802,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00795',
  'WP_000532084.1',
  'YebC/PmpR family DNA-binding transcriptionalregulator',
  170704,
  171426,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00800',
  'hemB',
  'porphobilinogen synthase',
  171427,
  172398,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07985',
  'WP_229311986.1',
  'ArsS family sensor histidine kinase',
  172470,
  173270,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07990',
  'WP_010875449.1',
  'acid-sensing histidine kinase ArsS',
  173231,
  173752,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00810',
  'arsR',
  'acid response regulator transcription factorArsR',
  173778,
  174455,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00815',
  'WP_001862871.1',
  'CiaD-like domain-containing protein',
  174691,
  175152,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00820',
  'WP_001127819.1',
  'tetratricopeptide repeat protein',
  175143,
  175406,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00825',
  'WP_001077422.1',
  'peptidase U32 family protein',
  175453,
  176721,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00830',
  'cheZ',
  'protein phosphatase CheZ',
  176724,
  177485,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00835',
  'prfB',
  'peptide chain release factor 2',
  177560,
  178651,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00840',
  'WP_000622860.1',
  'molybdopterin molybdotransferase MoeA',
  178712,
  179887,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00845',
  'fliR',
  'flagellar biosynthetic protein FliR',
  179897,
  180664,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00850',
  'WP_000244494.1',
  'EI24 domain-containing protein',
  180658,
  181386,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07995',
  'WP_000458035.1',
  'hypothetical protein',
  181499,
  181717,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00855',
  'cbf2',
  'peptidylprolyl isomerase CBF2',
  181865,
  182764,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00860',
  'WP_000960471.1',
  'class II fructose-bisphosphate aldolase',
  182781,
  183704,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00865',
  'efp',
  'elongation factor P',
  183726,
  184289,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00870',
  'pseI',
  'pseudaminic acid synthase',
  184798,
  185820,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00875',
  'WP_000588225.1',
  'ABC transporter ATP-binding protein',
  185824,
  186465,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00880',
  'WP_001237964.1',
  'apolipoprotein N-acyltransferase',
  186462,
  187739,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00885',
  'WP_001106332.1',
  'CvpA family protein',
  187970,
  188671,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00890',
  'lysS',
  'lysine--tRNA ligase',
  188681,
  190186,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00895',
  'WP_000323092.1',
  'serine hydroxymethyltransferase',
  190186,
  191436,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00900',
  'WP_000138087.1',
  'DUF1882 domain-containing protein',
  191447,
  191989,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00905',
  'WP_001290538.1',
  'hypothetical protein',
  192011,
  192814,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00910',
  '—',
  'DUF262 domain-containing protein',
  193210,
  194738,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00920',
  'WP_000890458.1',
  'TIGR00645 family protein',
  195057,
  195590,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00925',
  'clsC',
  'cardiolipin synthase ClsC',
  195596,
  197104,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00930',
  'WP_001282439.1',
  'fumarate reductase iron-sulfur subunit',
  197126,
  197863,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00935',
  'WP_000706021.1',
  'fumarate reductase flavoprotein subunit',
  197856,
  200000,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00940',
  'WP_001183634.1',
  'fumarate reductase cytochrome b subunit',
  200010,
  200777,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00945',
  'WP_000160988.1',
  'triose-phosphate isomerase',
  200992,
  201696,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00950',
  'fabI',
  'enoyl-ACP reductase FabI',
  201706,
  202533,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00955',
  'lpxD',
  'UDP-3-O-(3-hydroxymyristoyl)glucosamineN-acyltransferase',
  202543,
  203553,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00960',
  'metK',
  'methionine adenosyltransferase',
  203618,
  204775,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00965',
  'ndk',
  'nucleoside-diphosphate kinase',
  204842,
  205255,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00970',
  'WP_001159178.1',
  'hypothetical protein',
  205281,
  205637,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00975',
  'rpmF',
  '50S ribosomal protein L32',
  205653,
  205799,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00980',
  'plsX',
  'phosphate acyltransferase PlsX',
  205877,
  206890,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00985',
  'WP_000397786.1',
  'ketoacyl-ACP synthase III',
  206915,
  207910,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00990',
  '—',
  'hypothetical protein',
  207932,
  208233,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS00995',
  'WP_000488124.1',
  'hypothetical protein',
  208298,
  208486,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS00995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01000',
  'WP_000473912.1',
  'hypothetical protein',
  208866,
  209249,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01005',
  'WP_229311987.1',
  'ATP-dependent nuclease',
  209265,
  211766,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01010',
  '—',
  'AAA family ATPase',
  211815,
  212176,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01015',
  'WP_000249737.1',
  'Mrp/NBP35 family ATP-binding protein',
  212141,
  213379,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01020',
  'WP_015056028.1',
  'glycosyltransferase family 8 protein',
  213393,
  214445,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08000',
  'WP_001155912.1',
  'glycosyltransferase family 8 protein',
  214472,
  214591,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01025',
  'hofA',
  'outer membrane beta-barrel protein HofA',
  214745,
  216097,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01030',
  'htpG',
  'molecular chaperone HtpG',
  216201,
  218066,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01035',
  'hcpA',
  'Sel1-like repeat protein HcpA',
  218266,
  219018,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01040',
  'dapE',
  'succinyl-diaminopimelate desuccinylase',
  219098,
  220249,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01045',
  'mnmG',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis enzyme MnmG',
  220259,
  222124,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01050',
  'WP_000427574.1',
  'SLC13 family permease',
  222220,
  223878,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01055',
  'WP_000656886.1',
  'phosphatidate cytidylyltransferase',
  223891,
  224691,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01060',
  'dxr',
  '1-deoxy-D-xylulose-5-phosphate reductoisomerase',
  224692,
  225798,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01065',
  'WP_000523434.1',
  'hypothetical protein',
  225849,
  226991,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01070',
  'WP_000846523.1',
  'YbhB/YbcL family Raf kinase inhibitor-likeprotein',
  227007,
  227558,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01075',
  'WP_001862831.1',
  'helix-turn-helix domain-containing protein',
  227704,
  228165,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01080',
  'WP_000941691.1',
  'NifS family cysteine desulfurase',
  228339,
  229502,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01085',
  'WP_001051995.1',
  'iron-sulfur cluster assembly scaffold proteinNifU',
  229524,
  230504,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01090',
  'WP_000415831.1',
  'ribbon-helix-helix domain-containing protein',
  230651,
  230872,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01095',
  'radA',
  'DNA repair protein RadA',
  230997,
  232343,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01100',
  'msrB',
  'peptide-methionine (R)-S-oxide reductase MsrB',
  232467,
  233546,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01105',
  'WP_000393024.1',
  'sulfite exporter TauE/SafE family protein',
  233929,
  234762,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01110',
  'hopM',
  'Hop family outer membrane protein HopM/HopN',
  234973,
  237048,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01115',
  'WP_001863018.1',
  'SulP family inorganic anion transporter',
  237312,
  238469,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01120',
  '—',
  '',
  238504,
  238578,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01125',
  'hopA',
  'porin HopA',
  238708,
  240159,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01130',
  'kdsB',
  '3-deoxy-manno-octulosonate cytidylyltransferase',
  240354,
  241085,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01135',
  'dsbK',
  'protein disulfide-isomerase DsbK',
  241193,
  241990,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01140',
  'WP_000743516.1',
  'UPF0323 family lipoprotein',
  242006,
  242653,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01145',
  'WP_001197179.1',
  'glutathionylspermidine synthase family protein',
  242677,
  243849,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01150',
  'WP_001275574.1',
  'hypothetical protein',
  243849,
  244379,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01155',
  'hcpE',
  'Sel1-like repeat protein HcpE',
  245098,
  246165,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01160',
  'WP_001235932.1',
  'c-type cytochrome',
  246258,
  246629,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01165',
  'hemC',
  'hydroxymethylbilane synthase',
  246629,
  247549,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01170',
  'proS',
  'proline--tRNA ligase',
  247560,
  249293,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01175',
  'hemA',
  'glutamyl-tRNA reductase',
  249297,
  250646,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01180',
  'WP_001156669.1',
  'polyprenyl synthetase family protein',
  250646,
  251569,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01185',
  'WP_001004080.1',
  'hypothetical protein',
  251579,
  251974,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01190',
  'WP_001206044.1',
  'DUF2018 family protein',
  251967,
  252251,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01195',
  'dps',
  'DNA starvation/stationary phase protectionprotein',
  252272,
  252706,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01200',
  'flgS',
  'acid survival sensor histidine kinase',
  252912,
  254057,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01205',
  'WP_000609401.1',
  'hypothetical protein',
  254054,
  254371,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01210',
  'WP_000832067.1',
  'flagellar basal body P-ring protein FlgI',
  254368,
  255396,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01215',
  'WP_000422563.1',
  'DEAD/DEAH box helicase',
  255585,
  257063,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01220',
  'WP_001121076.1',
  'prohibitin family protein',
  257084,
  258172,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01225',
  'WP_000157404.1',
  'DUF2393 domain-containing protein',
  258179,
  258718,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01230',
  'WP_000889818.1',
  'nickel ABC transporter ATP-binding protein NikE',
  258801,
  260351,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01235',
  'WP_000116877.1',
  'ABC transporter permease',
  260361,
  261383,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01240',
  '—',
  '',
  261485,
  261560,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01245',
  'hopF',
  'Hop family outer membrane protein HopF',
  261719,
  263182,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01250',
  'hopG',
  'Hop family outer membrane protein HopG',
  263195,
  264609,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01255',
  'purA',
  'adenylosuccinate synthase',
  264709,
  265944,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01260',
  'WP_000712783.1',
  'flagellar export protein FliJ',
  265941,
  266369,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01265',
  'WP_001226637.1',
  'MotE family protein',
  266362,
  267021,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01270',
  'rseP',
  'RIP metalloprotease RseP',
  267021,
  268067,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01275',
  'xseA',
  'exodeoxyribonuclease VII large subunit',
  268080,
  269342,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01280',
  'WP_025444699.1',
  'DNA methyltransferase',
  269378,
  270514,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01285',
  'WP_001160132.1',
  'hypothetical protein',
  270525,
  270923,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01290',
  '—',
  'BsaWI family type II restriction enzyme',
  271111,
  271798,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01295',
  'WP_000806072.1',
  'DNA-methyltransferase',
  271795,
  272553,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01300',
  'WP_001048043.1',
  'ATP-dependent Clp protease ATP-binding subunit',
  272626,
  275196,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01305',
  'WP_001863037.1',
  'cytochrome c biogenesis protein CcdA',
  275253,
  275972,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01310',
  'WP_000924910.1',
  'amidohydrolase family protein',
  275982,
  277118,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01315',
  'mqnF',
  'aminofutalosine deaminase family hydrolase',
  277103,
  278332,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01320',
  'WP_000780038.1',
  'nuclease',
  278393,
  278635,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01325',
  'miaB',
  'tRNA (N6-isopentenyladenosine(37)-C2)-methylthiotransferase MiaB',
  278645,
  279958,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01330',
  'WP_000053541.1',
  'lysophospholipid acyltransferase family protein',
  279998,
  280651,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01335',
  'WP_000911905.1',
  'hypothetical protein',
  280644,
  281627,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01340',
  'WP_001212813.1',
  'hypothetical protein',
  281617,
  282150,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01345',
  'WP_001863038.1',
  'hypothetical protein',
  282147,
  282686,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01350',
  'WP_001150530.1',
  'YkgJ family cysteine cluster protein',
  282703,
  283101,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01355',
  'WP_001025475.1',
  'tetratricopeptide repeat protein',
  283138,
  284430,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01360',
  'WP_001155742.1',
  'beta/alpha barrel domain-containing protein',
  284418,
  284975,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01365',
  'WP_000055463.1',
  'YfhL family 4Fe-4S dicluster ferredoxin',
  285032,
  285286,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01370',
  'WP_001074267.1',
  'Ppx/GppA family phosphatase',
  285296,
  286750,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01375',
  'waaC',
  'lipopolysaccharide heptosyltransferase I',
  286747,
  287769,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01380',
  'WP_000221211.1',
  'lipid A biosynthesis lauroyl acyltransferase',
  287766,
  288752,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01385',
  'tgt',
  'tRNA guanosine(34) transglycosylase Tgt',
  288852,
  289967,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01390',
  'WP_000717255.1',
  'COG3400 family protein',
  290024,
  291460,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01395',
  'aroB',
  '3-dehydroquinate synthase',
  291465,
  292496,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01400',
  'WP_001218141.1',
  'mechanosensitive ion channel family protein',
  292487,
  294058,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01405',
  'mtaB',
  'tRNA(N(6)-L-threonylcarbamoyladenosine(37)-C(2))-methylthiotransferase MtaB',
  294055,
  295311,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01410',
  'WP_001116713.1',
  'AAA family ATPase',
  295298,
  296950,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01415',
  'bioV',
  'pimelyl-ACP methyl ester esterase BioV',
  296953,
  297471,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01420',
  'WP_000713359.1',
  'DUF4149 domain-containing protein',
  297484,
  297957,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01425',
  'imaA',
  'immunomodulatory autotransporter protein ImaA',
  298024,
  306705,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01430',
  'lysA',
  'diaminopimelate decarboxylase',
  306753,
  307970,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01435',
  'WP_001171376.1',
  'chorismate mutase',
  307975,
  308265,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01440',
  'WP_000461887.1',
  'DUF2156 domain-containing protein',
  308278,
  309150,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01445',
  'WP_001863046.1',
  'bifunctional chorismate-binding protein/class IVaminotransferase',
  309151,
  310830,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01450',
  'WP_001215729.1',
  'aliphatic amidase',
  311023,
  312042,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01455',
  'flgL',
  'flagellar hook-associated protein FlgL',
  312145,
  314631,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01460',
  'rplU',
  '50S ribosomal protein L21',
  314873,
  315187,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01465',
  'rpmA',
  '50S ribosomal protein L27',
  315202,
  315468,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01470',
  'WP_001066780.1',
  'ABC transporter substrate-binding protein',
  315585,
  317234,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01475',
  'WP_000947999.1',
  'ABC transporter permease',
  317245,
  318249,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01480',
  'WP_000443358.1',
  'ABC transporter permease',
  318249,
  319106,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01485',
  'WP_000599885.1',
  'ABC transporter ATP-binding protein',
  319118,
  319981,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01490',
  'WP_000770472.1',
  'ABC transporter ATP-binding protein',
  319978,
  320784,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01495',
  'obgE',
  'GTPase ObgE',
  320804,
  321886,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01500',
  'WP_000819954.1',
  'alginate lyase family protein',
  321928,
  322917,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01505',
  'WP_000738964.1',
  'YceI family protein',
  323161,
  323715,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01510',
  'hemL',
  'glutamate-1-semialdehyde 2,1-aminomutase',
  323725,
  325017,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01515',
  'WP_000743087.1',
  'AtpZ/AtpI family protein',
  325023,
  325286,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01520',
  'WP_000336506.1',
  'hypothetical protein',
  325302,
  325706,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01525',
  'WP_000850703.1',
  'carbon-nitrogen hydrolase family protein',
  325790,
  326668,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01530',
  'WP_001040419.1',
  'polysaccharide deacetylase family protein',
  326681,
  327562,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01535',
  'WP_000337920.1',
  'hypothetical protein',
  327608,
  327976,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01540',
  'WP_001124369.1',
  'CobW family GTP-binding protein',
  327976,
  328941,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01545',
  'WP_001263616.1',
  'YbfB/YjiJ family MFS transporter',
  328947,
  330092,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01550',
  'vapD',
  'endoribonuclease VapD',
  330588,
  330872,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01555',
  'WP_001134066.1',
  'type II toxin-antitoxin system HP0895 familyantitoxin',
  330853,
  331245,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01560',
  'WP_000716253.1',
  'SabA family sialic acid-binding adhesin',
  331854,
  334091,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01565',
  'WP_000934548.1',
  'HugZ family heme oxygenase',
  334388,
  335143,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01570',
  'argS',
  'arginine--tRNA ligase',
  335204,
  336829,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01575',
  'tatA',
  'twin-arginine translocase TatA/TatE familysubunit',
  336832,
  337071,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01580',
  'gmk',
  'guanylate kinase',
  337143,
  337763,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01585',
  'chePep',
  'chemotaxis regulatory protein ChePep',
  337756,
  339273,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01590',
  'WP_000932524.1',
  'phospholipase D-like domain-containing protein',
  339415,
  339957,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01595',
  'WP_001862902.1',
  'outer membrane protein',
  339965,
  340702,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01600',
  'flgH',
  'flagellar basal body L-ring protein FlgH',
  340832,
  341545,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01605',
  'WP_001201399.1',
  'bifunctionalUDP-2,4-diacetamido-2,4,6-trideoxy-beta-L-altropyranosehydrolase/pseudaminic acid cytidylyltransferase',
  341563,
  343116,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01610',
  'pseH',
  'UDP-4-amino-4,6-dideoxy-N-acetyl-beta-L-altrosamine N-acetyltransferase',
  343113,
  343655,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01615',
  'WP_000833936.1',
  'tetraacyldisaccharide 4''-kinase',
  343588,
  344526,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01620',
  'WP_001168317.1',
  'NAD+ synthase',
  344523,
  345305,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01625',
  '—',
  '',
  345390,
  345466,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01630',
  'ilvC',
  'ketol-acid reductoisomerase',
  345554,
  346546,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01635',
  'minD',
  'septum site-determining protein MinD',
  346571,
  347377,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01640',
  'minE',
  'cell division topological specificity factorMinE',
  347374,
  347607,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01645',
  'dprA',
  'DNA-processing protein DprA',
  347619,
  348419,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01650',
  'ruvX',
  'Holliday junction resolvase RuvX',
  348416,
  348820,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08005',
  'WP_010875464.1',
  'hypothetical protein',
  349106,
  349294,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01655',
  'WP_001862988.1',
  'tetratricopeptide repeat protein',
  349236,
  349652,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01660',
  'WP_000699933.1',
  'hypothetical protein',
  349779,
  350084,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01665',
  'WP_000032376.1',
  'hypothetical protein',
  350068,
  350634,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01670',
  'WP_000599140.1',
  'glycoside hydrolase family protein',
  350665,
  351042,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01675',
  'WP_001862993.1',
  'hypothetical protein',
  351030,
  351296,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01680',
  'WP_000393582.1',
  'DUF1294 domain-containing protein',
  351602,
  351988,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01685',
  '—',
  'hypothetical protein',
  351988,
  352774,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01690',
  'WP_001862999.1',
  'hypothetical protein',
  352764,
  353099,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01695',
  'WP_010875469.1',
  'hypothetical protein',
  353219,
  354001,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01700',
  'WP_001117124.1',
  'RluA family pseudouridine synthase',
  353995,
  354891,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01705',
  'recJ',
  'single-stranded-DNA-specific exonuclease RecJ',
  354891,
  356441,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01710',
  'pyrG',
  'glutamine hydrolyzing CTP synthase',
  356450,
  358066,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01715',
  'WP_000829924.1',
  'phosphatase PAP2 family protein',
  358326,
  358994,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01720',
  'fliF',
  'flagellar basal-body MS-ring/collar proteinFliF',
  359038,
  360741,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01725',
  'fliG',
  'flagellar motor switch protein FliG',
  360759,
  361790,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01730',
  'fliH',
  'flagellar assembly protein FliH',
  361777,
  362553,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01735',
  'dxs',
  '1-deoxy-D-xylulose-5-phosphate synthase',
  362556,
  364406,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01740',
  'lepA',
  'translation elongation factor 4',
  364421,
  366211,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01745',
  'WP_001052085.1',
  'protein NO VEIN domain-containing protein',
  366226,
  366984,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01750',
  'WP_000940198.1',
  'SDR family oxidoreductase',
  367133,
  367885,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01755',
  'WP_000735668.1',
  'hypothetical protein',
  367903,
  369438,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01760',
  '—',
  '',
  369879,
  369954,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01765',
  '—',
  '',
  369969,
  370045,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01770',
  'galE',
  'UDP-glucose 4-epimerase GalE',
  370160,
  371194,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01775',
  'truA',
  'tRNA pseudouridine(38-40) synthase TruA',
  371188,
  371916,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01780',
  'WP_000589921.1',
  'LptF/LptG family permease',
  371917,
  372954,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01785',
  'pcm',
  'protein-L-isoaspartate O-methyltransferase',
  372965,
  373594,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01790',
  'WP_000453999.1',
  'ribonucleotide-diphosphate reductase subunitbeta',
  373604,
  374629,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01795',
  '—',
  '',
  374829,
  374913,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01800',
  'pseC',
  'UDP-4-amino-4,6-dideoxy-N-acetyl-beta-L-altrosamine transaminase',
  374950,
  376077,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01805',
  'WP_000036594.1',
  'hypothetical protein',
  376074,
  376682,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01810',
  '—',
  'restriction endonuclease',
  376775,
  377322,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01815',
  '—',
  'SAM-dependent methyltransferase',
  377322,
  378165,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01820',
  'WP_015056041.1',
  'acetyl-CoA carboxylase biotin carboxylasesubunit',
  378258,
  379625,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01825',
  'accB',
  'acetyl-CoA carboxylase biotin carboxyl carrierprotein',
  379640,
  380110,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01830',
  'dcd',
  'dCTP deaminase',
  380240,
  380806,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01835',
  'WP_000943660.1',
  'porin family protein',
  380965,
  383067,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01840',
  'WP_001213204.1',
  '16S rRNA (uracil(1498)-N(3))-methyltransferase',
  383091,
  383771,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01845',
  'WP_000892087.1',
  'hypothetical protein',
  383772,
  384203,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01850',
  'hemH',
  'ferrochelatase',
  384259,
  385263,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01855',
  'WP_000492204.1',
  'SoxW family protein',
  385340,
  386005,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01860',
  'ccsA',
  'cytochrome c biogenesis protein',
  386015,
  388825,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01865',
  'WP_000487428.1',
  'glycosyltransferase family 10 domain-containingprotein',
  388835,
  390112,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01870',
  'gdhA',
  'NADP-specific glutamate dehydrogenase',
  390125,
  391471,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01875',
  'WP_000176078.1',
  'peptide chain release factor N(5)-glutaminemethyltransferase',
  391537,
  392367,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01880',
  'WP_000884428.1',
  'M48 family metallopeptidase',
  392364,
  393587,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01885',
  'WP_001120630.1',
  'hypothetical protein',
  393770,
  394294,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01890',
  'WP_001171324.1',
  'SPOR domain-containing protein',
  394337,
  395089,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01895',
  'WP_001191188.1',
  'hypothetical protein',
  395292,
  395519,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01900',
  'WP_000051172.1',
  'hypothetical protein',
  395532,
  395768,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01905',
  'WP_000499252.1',
  'primosomal protein N''',
  395753,
  397612,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01910',
  'cmoA',
  'carboxy-S-adenosyl-L-methionine synthase CmoA',
  397646,
  398377,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01915',
  'sodB',
  'superoxide dismutase [Fe]',
  398432,
  399073,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01915'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01920',
  'tpx',
  'thiol peroxidase',
  399297,
  399797,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01925',
  'cheW',
  'chemotaxis protein CheW',
  400052,
  400549,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01930',
  'cheAY2',
  'chemotaxis histidine kinase/response regulatorCheAY2',
  400546,
  402957,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01935',
  'cheV3',
  'chemotaxis protein CheV3',
  403014,
  403949,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01940',
  'WP_000894935.1',
  'UDP-2,3-diacylglucosamine diphosphatase',
  403953,
  404711,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01945',
  'WP_000888213.1',
  'YggS family pyridoxal phosphate-dependentenzyme',
  404713,
  405381,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01950',
  'WP_001204347.1',
  'menaquinone biosynthesis decarboxylase',
  405404,
  407254,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01955',
  'serA',
  'phosphoglycerate dehydrogenase',
  407264,
  408838,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01960',
  'WP_001211134.1',
  'hypothetical protein',
  408854,
  409402,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01965',
  'WP_000034006.1',
  '30S ribosomal protein S1',
  409431,
  411101,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01970',
  'WP_000403575.1',
  '4-hydroxy-3-methylbut-2-enyl diphosphatereductase',
  411222,
  412046,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01975',
  'aroA',
  '3-phosphoshikimate 1-carboxyvinyltransferase',
  412036,
  413325,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01980',
  'pheT',
  'phenylalanine--tRNA ligase subunit beta',
  413341,
  415635,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01985',
  'pheS',
  'phenylalanine--tRNA ligase subunit alpha',
  415635,
  416621,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01990',
  'WP_001100349.1',
  'histidine triad nucleotide-binding protein',
  416702,
  417016,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS01995',
  'WP_001147634.1',
  'aminotransferase class V-fold PLP-dependentenzyme',
  417035,
  418357,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS01995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02000',
  'WP_000352085.1',
  'DUF3972 domain-containing protein',
  418383,
  418973,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02005',
  'WP_000028305.1',
  'molybdopterin guanine dinucleotide-containingS/N-oxide reductase',
  419077,
  421467,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02010',
  'WP_001020278.1',
  'hypothetical protein',
  421633,
  422121,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02015',
  'guaA',
  'glutamine-hydrolyzing GMP synthase',
  422132,
  423658,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02020',
  'hpaA2',
  'HpaA2 protein',
  423743,
  424492,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02025',
  '—',
  '',
  424676,
  424753,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02030',
  '—',
  '',
  424819,
  424895,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02035',
  '—',
  '',
  424953,
  425029,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02040',
  '—',
  '',
  425052,
  425128,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02045',
  '—',
  'transposase',
  425510,
  426838,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02050',
  'tnpA',
  'IS200/IS605 family transposase',
  426876,
  427292,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02055',
  'WP_230372412.1',
  'mechanosensitive ion channel family protein',
  427738,
  429558,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02060',
  'cfaS',
  'cyclopropane fatty acid synthase',
  429561,
  430730,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02065',
  'metG',
  'methionine--tRNA ligase',
  430899,
  432851,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02070',
  'WP_001236552.1',
  'hypothetical protein',
  432852,
  433859,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02075',
  'cmoB',
  'tRNA 5-methoxyuridine(34)/uridine 5-oxyaceticacid(34) synthase CmoB',
  433863,
  434648,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02080',
  'WP_001158310.1',
  'hotdog domain-containing protein',
  434665,
  435093,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02085',
  'WP_000237280.1',
  'glycosyltransferase family 4 protein',
  435098,
  436267,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02090',
  'speA',
  'arginine decarboxylase',
  436282,
  438129,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02095',
  'WP_000506796.1',
  'hypothetical protein',
  438242,
  439168,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02100',
  'WP_000923350.1',
  'hypothetical protein',
  439284,
  441143,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02105',
  'WP_001124691.1',
  'single-stranded-DNA-specific exonuclease RecJ',
  441185,
  442438,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02110',
  'WP_001062391.1',
  'DUF262 domain-containing protein',
  442479,
  444212,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02115',
  'WP_010875477.1',
  'hypothetical protein',
  444265,
  444600,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02120',
  '—',
  '',
  445337,
  448223,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02125',
  'rrf',
  '',
  448459,
  448576,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02130',
  'WP_230372414.1',
  'vWA domain-containing protein',
  449207,
  449707,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02135',
  'WP_001863366.1',
  'hypothetical protein',
  449881,
  450123,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02140',
  'WP_001863367.1',
  'protein phosphatase 2C domain-containingprotein',
  450127,
  450813,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02145',
  'WP_000418129.1',
  'protein kinase',
  450804,
  451694,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02150',
  'WP_230372078.1',
  'serine/threonine protein kinase',
  451779,
  452165,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08010',
  'WP_001863368.1',
  'hypothetical protein',
  452159,
  453328,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08015',
  'WP_010875482.1',
  'AAA domain-containing protein',
  453399,
  453974,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08020',
  'WP_230372413.1',
  'hypothetical protein',
  453982,
  454323,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02160',
  'tnpA',
  'IS200/IS605 family transposase',
  454330,
  454776,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02165',
  'WP_000930565.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  454828,
  456111,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02170',
  'WP_000044730.1',
  'VirB8 family type IV secretion system protein',
  456080,
  457180,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02175',
  'WP_000655392.1',
  'type IA DNA topoisomerase',
  457297,
  459330,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02180',
  'WP_229311984.1',
  'VirB4 family type IV secretion/conjugal transferATPase',
  459333,
  461702,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02185',
  'WP_001173702.1',
  'hypothetical protein',
  461749,
  462015,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02190',
  'WP_000850076.1',
  'hypothetical protein',
  462016,
  462318,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02195',
  'WP_000323332.1',
  'toprim domain-containing protein',
  462315,
  463838,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02200',
  '—',
  'hypothetical protein',
  463845,
  464139,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02205',
  'WP_001158055.1',
  'hypothetical protein',
  464158,
  464937,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02210',
  'WP_001862501.1',
  'DEAD/DEAH box helicase family protein',
  464982,
  466127,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02215',
  'WP_000691910.1',
  'hypothetical protein',
  466124,
  466510,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02220',
  'WP_000394021.1',
  'hypothetical protein',
  466757,
  468175,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08025',
  'WP_001862499.1',
  'hypothetical protein',
  468172,
  468306,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02225',
  'WP_000599839.1',
  'hypothetical protein',
  468417,
  468701,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02230',
  'WP_000543323.1',
  'McrB family protein',
  468756,
  470333,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02235',
  'WP_000362588.1',
  'DUF2357 domain-containing protein',
  470340,
  473405,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02240',
  'WP_001862498.1',
  'AAA family ATPase',
  473398,
  474066,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02245',
  '—',
  'integrase',
  474044,
  474830,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02250',
  'WP_000189081.1',
  'hypothetical protein',
  474833,
  475063,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02255',
  '—',
  'hypothetical protein',
  475056,
  475534,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02260',
  '—',
  'TrbC/VirB2 family protein',
  475531,
  475814,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02265',
  'WP_001177716.1',
  'hypothetical protein',
  475826,
  476089,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02270',
  'WP_001168532.1',
  'hypothetical protein',
  476101,
  476337,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02275',
  'WP_000893960.1',
  'VirB4 family type IV secretion/conjugal transferATPase',
  476337,
  478913,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08030',
  'WP_000789926.1',
  'hypothetical protein',
  478910,
  479050,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02280',
  '—',
  'hypothetical protein',
  479043,
  479519,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02285',
  'WP_000005927.1',
  'restriction endonuclease subunit S',
  480062,
  481159,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02290',
  '—',
  'class I SAM-dependent DNA methyltransferase',
  481152,
  482782,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02295',
  'WP_001146659.1',
  'type I restriction endonuclease',
  482775,
  485942,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02300',
  'WP_001116307.1',
  'motility associated factor glycosyltransferasefamily protein',
  485990,
  487885,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02305',
  'WP_000402681.1',
  'TerB family tellurite resistance protein',
  487910,
  488677,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02310',
  'WP_001861281.1',
  'hypothetical protein',
  488687,
  489001,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02315',
  'WP_000114695.1',
  'DUF5644 domain-containing protein',
  489003,
  490490,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02320',
  'WP_001188605.1',
  'hypothetical protein',
  490502,
  490990,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02325',
  'WP_000662799.1',
  'M3 family oligoendopeptidase',
  490975,
  492711,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02330',
  'WP_000431914.1',
  'cation:proton antiporter',
  492809,
  494059,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08035',
  '—',
  'hypothetical protein',
  494212,
  494395,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02335',
  'WP_000595790.1',
  'outer membrane beta-barrel protein',
  494379,
  494939,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02340',
  'modA',
  'molybdate ABC transporter substrate-bindingprotein',
  495165,
  495905,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02345',
  'modB',
  'molybdate ABC transporter permease subunit',
  495927,
  496601,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02350',
  'WP_000588404.1',
  'ATP-binding cassette domain-containing protein',
  496598,
  497395,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02355',
  'gltX',
  'glutamate--tRNA ligase',
  497510,
  498901,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02360',
  'hopJ',
  'Hop family outer membrane protein HopJ/HopK',
  499019,
  500122,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02365',
  'WP_001139725.1',
  'class I SAM-dependent methyltransferase',
  500131,
  501768,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02370',
  'WP_000557801.1',
  'glycosyltransferase family 9 protein',
  501734,
  502582,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02375',
  'typA',
  'translational GTPase TypA',
  502628,
  504427,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02380',
  '—',
  'DNA adenine methylase',
  504443,
  505371,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02385',
  '—',
  'GIY-YIG nuclease family protein',
  505374,
  505997,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02390',
  '—',
  'DNA cytosine methyltransferase',
  506088,
  507134,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02395',
  'WP_000482941.1',
  'hypothetical protein',
  507136,
  507888,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02400',
  'WP_000719571.1',
  'catalase family peroxidase',
  508122,
  509066,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02405',
  'hofC',
  'outer membrane beta-barrel protein HofC',
  509352,
  510938,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02410',
  'hofD',
  'outer membrane beta-barrel protein HofD',
  510965,
  512407,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02415',
  'WP_000775280.1',
  'DUF3519 domain-containing protein',
  512806,
  515679,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02420',
  '—',
  'hypothetical protein',
  515693,
  516618,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02425',
  'WP_000461981.1',
  'potassium channel family protein',
  517000,
  518136,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02430',
  'rpmB',
  '50S ribosomal protein L28',
  518285,
  518473,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02435',
  'WP_000442290.1',
  'HpaA family protein',
  518573,
  519409,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02440',
  'mraY',
  'phospho-N-acetylmuramoyl-pentapeptide-transferase',
  519534,
  520595,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02445',
  'murD',
  'UDP-N-acetylmuramoyl-L-alanine--D-glutamateligase',
  520597,
  521865,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02450',
  'WP_001138777.1',
  'HP0495 family protein',
  521862,
  522122,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02455',
  'ybgC',
  'acyl-CoA thioesterase YbgC',
  522112,
  522513,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02460',
  'WP_000526632.1',
  'sodium-dependent transporter',
  522742,
  524070,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02465',
  'WP_000514571.1',
  'sodium-dependent transporter',
  524081,
  525409,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02470',
  'WP_000836138.1',
  'phospholipase A',
  525424,
  526491,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02475',
  'dnaN',
  'DNA polymerase III subunit beta',
  526549,
  527673,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02480',
  'gyrB',
  'DNA topoisomerase (ATP-hydrolyzing) subunit B',
  527686,
  530007,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02485',
  '—',
  'adenine methyltransferase',
  530053,
  531046,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02490',
  '—',
  'R.Pab1 family restriction endonuclease',
  531033,
  531787,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02495',
  'csd1',
  'peptidoglycan DD-metalloendopeptidase Csd3',
  531991,
  533202,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02500',
  'WP_000119978.1',
  'NUDIX domain-containing protein',
  533202,
  533840,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02505',
  'pgbA',
  'plasminogen-binding protein PgbA',
  533851,
  535209,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02510',
  'glcD',
  'glycolate oxidase subunit GlcD',
  535211,
  536590,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02515',
  'dapB',
  '4-hydroxy-tetrahydrodipicolinate reductase',
  536612,
  537376,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02520',
  'WP_000849509.1',
  'hypothetical protein',
  537802,
  537918,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02525',
  'glnA',
  'type I glutamate--ammonia ligase',
  538237,
  539682,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02530',
  '—',
  'DUF262 domain-containing protein',
  539820,
  541949,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02535',
  'rplI',
  '50S ribosomal protein L9',
  542013,
  542462,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02540',
  'hslV',
  'ATP-dependent protease subunit HslV',
  542466,
  543008,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02545',
  'hslU',
  'HslU--HslV peptidase ATPase subunit',
  543008,
  544339,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02550',
  'era',
  'GTPase Era',
  544339,
  545244,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02555',
  'csd6',
  'cell shape-determining L,D-carboxypeptidaseCsd6',
  545241,
  546233,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02560',
  'WP_000471692.1',
  'HP0519 family Sel1-like repeat protein',
  546322,
  547152,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02565',
  'cag1',
  'cag pathogenicity island protein Cag1',
  547328,
  547675,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07870',
  '—',
  'cag pathogenicity island protein',
  547774,
  548141,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02570',
  'cag3',
  'type IV secretion system outer membrane capsubunit Cag3',
  548134,
  549579,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02575',
  'cag4',
  'VirB1 family T4SS lytic transglycosylase Cag4',
  549589,
  550098,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02580',
  'cag5',
  'VirD4 family type IV secretion system ATPaseCag5',
  550217,
  552463,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02585',
  'virB11',
  'cag pathogenicity island type IV secretionsystem ATPase VirB11',
  552472,
  553464,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02590',
  'cagZ',
  'cag pathogenicity island translocation proteinCagZ',
  553469,
  554068,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02595',
  'cagY',
  'type IV secretion system apparatus protein CagY',
  554206,
  559989,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02600',
  'cagX',
  'type IV secretion system apparatus protein CagX',
  560004,
  561572,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02605',
  'cagW',
  'cag pathogenicity island VirB6 family T4SSprotein CagW',
  561625,
  563232,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02610',
  'cagV',
  'cag pathogenicity island type IV secretionsystem protein CagV',
  563237,
  563995,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02615',
  'cagU',
  'cag pathogenicity island translocation proteinCagU',
  564381,
  565037,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02620',
  'cagT',
  'type IV secretion system apparatus protein CagT',
  565073,
  565915,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02625',
  'cagS',
  'cag pathogenicity island protein CagS',
  566126,
  566716,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02630',
  'cagQ',
  'cag pathogenicity island type IV secretionsystem protein CagQ',
  567142,
  567522,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08040',
  'WP_000466848.1',
  'hypothetical protein',
  567459,
  567644,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02635',
  'cagP',
  'cag pathogenicity island protein CagP',
  567955,
  568299,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02640',
  'cagM',
  'type IV secretion system apparatus protein CagM',
  568723,
  569853,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02645',
  'cagN',
  'cag pathogenicity island type IV secretionsystem protein CagN',
  569868,
  570788,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02650',
  'cagL',
  'cag pathogenicity island VirB5 familyT4SS-associated adhesin CagL',
  570870,
  571583,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02655',
  'cagI',
  'cag pathogenicity island type IV secretionsystem translocation protein CagI',
  571580,
  572725,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02660',
  'WP_042960802.1',
  'hypothetical protein',
  572736,
  573680,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08045',
  'WP_000562355.1',
  'hypothetical protein',
  573667,
  573867,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02665',
  'cagG',
  'cag pathogenicity island type IV secretionsystem translocation protein CagG',
  573864,
  574292,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02670',
  'cagF',
  'type IV secretion system chaperone CagF',
  574347,
  575153,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02675',
  'cagE',
  'cag pathogenicity island type IV secretionsystem ATPase CagE',
  575155,
  578106,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02680',
  'cagD',
  'cag pathogenicity island type IV secretionsystem protein CagD',
  578115,
  578738,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02685',
  'cagC',
  'cag pathogenicity island type IV secretionsystem protein CagC',
  578740,
  579087,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02690',
  'cagB',
  'cag pathogenicity island protein B',
  579231,
  579458,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02695',
  'cagA',
  'type IV secretion system oncogenic effectorCagA',
  579921,
  583481,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08050',
  'WP_229311988.1',
  'AAA domain-containing protein',
  583541,
  583876,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08055',
  'WP_001111702.1',
  'DEAD/DEAH box helicase',
  583883,
  584437,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02705',
  'murI',
  'glutamate racemase',
  584583,
  585350,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02710',
  'rho',
  'transcription termination factor Rho',
  585388,
  586704,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02715',
  'rpmE',
  '50S ribosomal protein L31',
  586968,
  587171,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02720',
  'rsmI',
  '16S rRNA(cytidine(1402)-2''-O)-methyltransferase',
  587196,
  588059,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02725',
  'rlmB',
  '23S rRNA(guanosine(2251)-2''-O)-methyltransferase RlmB',
  588072,
  588755,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02730',
  'WP_000437280.1',
  'hypothetical protein',
  588768,
  589733,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02735',
  'WP_000792823.1',
  'hypothetical protein',
  589730,
  590551,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02740',
  'WP_000256112.1',
  'hypothetical protein',
  590624,
  591061,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02745',
  'accA',
  'acetyl-CoA carboxylase carboxyl transferasesubunit alpha',
  591530,
  592468,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02750',
  'WP_001252848.1',
  'beta-ketoacyl-ACP synthase II',
  592491,
  593729,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02755',
  'acpP',
  'acyl carrier protein',
  594037,
  594273,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02760',
  'fabG',
  '3-oxoacyl-ACP reductase FabG',
  594504,
  595247,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02765',
  'rpsU',
  '30S ribosomal protein S21',
  595289,
  595501,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02770',
  'WP_000996951.1',
  'hypothetical protein',
  595602,
  596852,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02775',
  'WP_000418864.1',
  'ribbon-helix-helix domain-containing protein',
  597025,
  597270,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02780',
  'WP_001148303.1',
  'YkgB family protein',
  597293,
  597940,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02785',
  'dapF',
  'diaminopimelate epimerase',
  598047,
  598868,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02790',
  'WP_000647330.1',
  'AI-2E family transporter',
  598984,
  600030,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02795',
  'WP_000188605.1',
  'radical SAM/SPASM domain-containing protein',
  600177,
  601049,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02800',
  'ychF',
  'redox-regulated ATPase YchF',
  601079,
  602179,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02805',
  'WP_000912892.1',
  'leucyl aminopeptidase',
  602181,
  603671,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02810',
  'WP_000393406.1',
  'DedA family protein',
  603719,
  604297,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02815',
  'apt',
  'adenine phosphoribosyltransferase',
  604312,
  604851,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02820',
  'WP_000495094.1',
  'hypothetical protein',
  604909,
  605241,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02825',
  'rpiB',
  'ribose 5-phosphate isomerase B',
  605293,
  605748,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02830',
  'WP_001159394.1',
  'site-2 protease family protein',
  605769,
  606467,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02835',
  'lepB',
  'signal peptidase I',
  606476,
  607348,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02840',
  'folD',
  'bifunctional methylenetetrahydrofolatedehydrogenase/methenyltetrahydrofolate cyclohydrolaseFolD',
  607348,
  608220,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02845',
  'WP_000839094.1',
  'LTA synthase family protein',
  608300,
  610336,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02850',
  'WP_000909119.1',
  '3-deoxy-d-manno-octulosonic acid hydrolasesubunit 1',
  610342,
  610896,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02855',
  'WP_000433759.1',
  '3-deoxy-d-manno-octulosonic acid hydrolasesubunit 2',
  610903,
  612021,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02860',
  'pyrC',
  'dihydroorotase',
  611997,
  613016,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02865',
  'WP_001114818.1',
  'energy transducer TonB',
  613020,
  613994,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02870',
  'WP_010875498.1',
  'hypothetical protein',
  613978,
  614859,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02875',
  'fliN',
  'flagellar motor switch protein FliN',
  614856,
  615227,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02880',
  'nth',
  'endonuclease III',
  615309,
  615959,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02885',
  'WP_000174130.1',
  'FeoA family protein',
  615962,
  616192,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02890',
  'WP_001042337.1',
  'YhdP family protein',
  616194,
  619127,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02895',
  'mltG',
  'endolytic transglycosylase MltG',
  619045,
  620034,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02900',
  'WP_001096894.1',
  '4Fe-4S dicluster domain-containing protein',
  620219,
  620560,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02905',
  'WP_001206856.1',
  '2-oxoglutarate synthase subunit alpha',
  620560,
  621687,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02910',
  'WP_000885323.1',
  '2-oxoglutarate ferredoxin oxidoreductase subunitbeta',
  621689,
  622510,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02915',
  'WP_000388051.1',
  '2-oxoacid:acceptor oxidoreductase familyprotein',
  622510,
  623070,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02915'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02920',
  'WP_000575711.1',
  'type III restriction-modification systemendonuclease',
  623230,
  626172,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02925',
  '—',
  'site-specific DNA-methyltransferase',
  626169,
  628042,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07875',
  'WP_000394806.1',
  'hypothetical protein',
  628139,
  628303,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02930',
  'WP_000356995.1',
  'disulfide bond formation protein B',
  628313,
  629785,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02935',
  'rnpB',
  '',
  629821,
  630135,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02940',
  'WP_000890837.1',
  'tumor necrosis factor alpha-inducing protein',
  630259,
  630837,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02945',
  'WP_000913670.1',
  'penicillin-binding protein 1A',
  630840,
  632819,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02950',
  'WP_000491853.1',
  'aminotransferase class I/II-fold pyridoxalphosphate-dependent enzyme',
  632820,
  633941,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02955',
  'tlpD',
  'chemotaxis chemoreceptor TlpD',
  633964,
  635265,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02960',
  'WP_010875501.1',
  'ATP-binding cassette domain-containing protein',
  635337,
  637118,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02965',
  'WP_000885496.1',
  'flagellin A',
  637282,
  638814,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02970',
  'WP_000887243.1',
  '3-methyladenine DNA glycosylase',
  638932,
  639588,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02975',
  'WP_000577404.1',
  'hypothetical protein',
  639585,
  640202,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02980',
  'hemE',
  'uroporphyrinogen decarboxylase',
  640271,
  641290,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02985',
  'hefA',
  'efflux RND transporter outer membrane subunitHefA',
  641299,
  642732,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02990',
  'hefB',
  'efflux RND transporter periplasmic adaptorsubunit HefB',
  642743,
  643447,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS02995',
  'hefC',
  'efflux RND transporter permease subunit HefC',
  643460,
  646546,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS02995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03000',
  'WP_000716806.1',
  'outer membrane beta-barrel protein',
  646543,
  647112,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03005',
  '—',
  'vacuolating cytotoxin domain-containing protein',
  647257,
  656818,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03010',
  '—',
  'ABC transporter permease',
  656878,
  657634,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03015',
  'WP_000625017.1',
  'ATP-binding cassette domain-containing protein',
  657634,
  658335,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03020',
  'WP_000399940.1',
  'ribbon-helix-helix domain-containing protein',
  658630,
  658962,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03025',
  'ligA',
  'NAD-dependent DNA ligase LigA',
  659069,
  661039,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03030',
  'WP_000251148.1',
  'chemotaxis protein',
  661117,
  662058,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03035',
  'aspS',
  'aspartate--tRNA ligase',
  662093,
  663826,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03040',
  'WP_000811238.1',
  'adenylate kinase',
  663843,
  664418,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08060',
  '—',
  'glycosyltransferase family 25 protein',
  664443,
  665695,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03055',
  'ppa',
  'inorganic diphosphatase',
  665747,
  666268,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03060',
  'WP_000981767.1',
  'endonuclease MutS2',
  666410,
  668659,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03065',
  'WP_000501484.1',
  'hypothetical protein',
  668659,
  669021,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03070',
  'murC',
  'UDP-N-acetylmuramate--L-alanine ligase',
  669021,
  670370,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03075',
  'WP_000142409.1',
  'succinyldiaminopimelate transaminase',
  670363,
  671490,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03080',
  'ispG',
  'flavodoxin-dependent(E)-4-hydroxy-3-methylbut-2-enyl-diphosphate synthase',
  671610,
  672689,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03085',
  'WP_000608576.1',
  '2,3,4,5-tetrahydropyridine-2,6-carboxylateN-succinyltransferase',
  672692,
  673897,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03090',
  'WP_010875508.1',
  'hypothetical protein',
  673909,
  674241,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03095',
  'WP_010875509.1',
  'HP0628 family Sel1-like repeat protein',
  674290,
  674967,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03100',
  'WP_000387635.1',
  'DUF262 domain-containing protein',
  675124,
  677169,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03105',
  'WP_000756697.1',
  'NAD(P)H-dependent oxidoreductase',
  677214,
  677798,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03110',
  'WP_000499027.1',
  'hydrogenase 1 small subunit',
  677958,
  679112,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03115',
  'WP_000038087.1',
  'nickel-dependent hydrogenase large subunit',
  679122,
  680858,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03120',
  'cybH',
  'Ni/Fe-hydrogenase, b-type cytochrome subunit',
  680871,
  681545,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03125',
  'hydD',
  'hydrogenase biosynthesis protein HydD',
  681542,
  682078,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03130',
  'hydE',
  'hydrogenase biosynthesis protein HydE',
  682080,
  683618,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03135',
  '—',
  'hypothetical protein',
  683623,
  684017,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03140',
  'WP_000554116.1',
  'hypothetical protein',
  684146,
  684598,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03145',
  'oipA',
  'outer inflammatory protein OipA',
  684774,
  685691,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03150',
  'queC',
  '7-cyano-7-deazaguanine synthase QueC',
  685734,
  686414,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03155',
  'WP_000462295.1',
  'CCA tRNA nucleotidyltransferase',
  686477,
  687685,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03160',
  'WP_010875511.1',
  'hypothetical protein',
  687699,
  687926,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03165',
  'frxA',
  'NAD(P)H-dependent flavin oxidoreductase FrxA',
  687928,
  688581,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03170',
  'gltX',
  'glutamate--tRNA ligase',
  688746,
  690065,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03175',
  'WP_000577921.1',
  'YggT family protein',
  690062,
  690355,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03180',
  'WP_001210646.1',
  'lytic transglycosylase domain-containingprotein',
  690364,
  692046,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03185',
  'galU',
  'UTP--glucose-1-phosphate uridylyltransferaseGalU',
  692043,
  692864,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03190',
  'WP_000527526.1',
  'hypothetical protein',
  692876,
  693283,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03195',
  'murA',
  'UDP-N-acetylglucosamine1-carboxyvinyltransferase',
  693286,
  694554,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03200',
  'aspA',
  'aspartate ammonia-lyase',
  694612,
  696018,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03205',
  'WP_010875512.1',
  'uracil-DNA glycosylase family protein',
  696063,
  696653,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03210',
  'WP_000487430.1',
  'glycosyltransferase family 10 domain-containingprotein',
  696662,
  698092,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03215',
  'serB',
  'phosphoserine phosphatase SerB',
  698132,
  698755,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03220',
  'WP_000949202.1',
  'ferritin',
  698770,
  699273,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03225',
  'mqnE',
  'aminofutalosine synthase MqnE',
  699570,
  700652,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03230',
  'bamA',
  'outer membrane protein assembly factor BamA',
  700735,
  703485,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03235',
  'WP_001862639.1',
  'dehypoxanthine futalosine cyclase',
  703487,
  704548,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03240',
  'WP_000714010.1',
  'M16 family metallopeptidase',
  704554,
  705852,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03245',
  'gatB',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatB',
  705852,
  707276,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03250',
  'WP_001225999.1',
  'SurA N-terminal domain-containing protein',
  707276,
  708520,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03255',
  'WP_001163504.1',
  'hypothetical protein',
  708530,
  709546,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03260',
  'rnhA',
  'ribonuclease HI',
  709533,
  710019,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03265',
  'rnc',
  'ribonuclease III',
  709976,
  710695,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03270',
  'aroC',
  'chorismate synthase',
  710692,
  711789,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03275',
  'WP_000413462.1',
  'DUF2603 domain-containing protein',
  711827,
  712342,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03280',
  'hemN',
  'oxygen-independent coproporphyrinogen IIIoxidase',
  712342,
  713715,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03285',
  'WP_001004848.1',
  '(Fe-S)-binding protein',
  713712,
  715013,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03290',
  '—',
  'DEAD/DEAH box helicase',
  715089,
  719860,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03295',
  'WP_000633152.1',
  'hypothetical protein',
  719857,
  721206,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03300',
  'WP_000715041.1',
  'outer membrane protein',
  721328,
  722140,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03305',
  'WP_000967300.1',
  'pyridoxal phosphate-dependent aminotransferase',
  722299,
  723471,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03310',
  '—',
  'hypothetical protein',
  723553,
  725491,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03315',
  'xerH',
  'tyrosine recombinase XerH',
  725498,
  726586,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03320',
  'WP_001862580.1',
  'methylated-DNA--[protein]-cysteineS-methyltransferase',
  726648,
  727154,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03325',
  'WP_000355989.1',
  'sulfite exporter TauE/SafE family protein',
  727158,
  727925,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03330',
  '—',
  'Gfo/Idh/MocA family oxidoreductase',
  728039,
  728987,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03335',
  'WP_000633984.1',
  'ribonucleoside-diphosphate reductase subunitalpha',
  729049,
  731415,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03340',
  'WP_000381669.1',
  'hypothetical protein',
  731587,
  732093,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03345',
  'WP_000016162.1',
  'hypothetical protein',
  732133,
  732453,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03350',
  'glmU',
  'bifunctional UDP-N-acetylglucosaminediphosphorylase/glucosamine-1-phosphateN-acetyltransferase GlmU',
  732667,
  733968,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03355',
  'fliP',
  'flagellar type III secretion system pore proteinFliP',
  734056,
  734803,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03360',
  'WP_000822057.1',
  'TonB-dependent receptor family protein',
  734843,
  737146,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03365',
  'feoB',
  'ferrous iron transport protein B',
  737394,
  739322,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03370',
  '—',
  '3''-5'' exonuclease',
  739466,
  740277,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03375',
  'WP_001006979.1',
  'acetyl-CoA C-acetyltransferase',
  740559,
  741734,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03380',
  'WP_001045154.1',
  'CoA transferase subunit A',
  741745,
  742443,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03385',
  'WP_001206261.1',
  'succinyl-CoA--3-ketoacid CoA transferase subunitB',
  742440,
  743063,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03390',
  'WP_000479410.1',
  'TIGR00366 family protein',
  743083,
  744447,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03395',
  '—',
  'lipid A deacylase LpxR family protein',
  744677,
  745570,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03400',
  'WP_000650637.1',
  'hydantoinase/oxoprolinase family protein',
  745801,
  747942,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03405',
  'WP_001285084.1',
  'hydantoinase B/oxoprolinase family protein',
  747954,
  750251,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03410',
  'WP_001862402.1',
  'acetone carboxylase subunit gamma',
  750268,
  750768,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03415',
  'WP_000162004.1',
  'hypothetical protein',
  751085,
  752113,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03420',
  'WP_001279026.1',
  'diacylglycerol kinase',
  752106,
  752492,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03425',
  'gyrA',
  'DNA topoisomerase (ATP-hydrolyzing) subunit A',
  752512,
  754995,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03430',
  'WP_001863432.1',
  'hypothetical protein',
  754995,
  755468,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03435',
  'flgR',
  'transcriptional activator FlgR',
  755465,
  756610,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03440',
  'uvrA',
  'excinuclease ABC subunit UvrA',
  757282,
  760107,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03445',
  'hopE',
  'Hop family outer membrane protein HopE',
  760272,
  761093,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03450',
  'rsmH',
  '16S rRNA (cytosine(1402)-N(4))-methyltransferaseRsmH',
  761272,
  762198,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03455',
  'WP_001022706.1',
  'hypothetical protein',
  762219,
  762563,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03460',
  'WP_001232624.1',
  'SAM hydrolase/SAM-dependent halogenase familyprotein',
  762809,
  763711,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03465',
  'WP_001228436.1',
  'porin family protein',
  763982,
  765964,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03470',
  'WP_000270639.1',
  'HD domain-containing protein',
  766154,
  767374,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03475',
  '—',
  'Fic family protein',
  767374,
  768077,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03480',
  'WP_000996418.1',
  'RNA polymerase factor sigma-54',
  768089,
  769333,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03485',
  'lptB',
  'LPS export ABC transporter ATP-binding protein',
  769336,
  770058,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03490',
  'tsaE',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complexATPase subunit type 1 TsaE',
  770071,
  770472,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03495',
  'WP_001197484.1',
  'DNA polymerase III subunit gamma/tau',
  770469,
  772205,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03500',
  'WP_000498401.1',
  'LysE family transporter',
  772274,
  772906,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03505',
  '—',
  'DUF1104 domain-containing protein',
  773177,
  773597,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03510',
  'WP_000709617.1',
  'sialic acid-binding protein',
  773625,
  774083,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03515',
  'WP_000542818.1',
  'Hop family adhesin SabA/HopD',
  774452,
  776341,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03520',
  'WP_042960807.1',
  'type II asparaginase',
  776481,
  777527,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03525',
  'WP_000227192.1',
  'anaerobic C4-dicarboxylate transporter',
  777602,
  778933,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03530',
  'sabA',
  'Hop family adhesin SabA/HopD',
  779008,
  780924,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03535',
  'WP_000532530.1',
  'outer membrane beta-barrel protein',
  781184,
  782101,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03540',
  'WP_000346174.1',
  'tRNA dihydrouridine synthase',
  782071,
  783057,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03545',
  'tilS',
  'tRNA lysidine(34) synthetase TilS',
  783151,
  784167,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03550',
  'WP_001016095.1',
  'HP0729 family protein',
  784203,
  785270,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03555',
  'WP_230372313.1',
  'radical SAM protein',
  785279,
  785572,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03560',
  'WP_000787447.1',
  'LeoA/HP0731 family dynamin-like GTPase',
  785676,
  787397,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03565',
  '—',
  '50S ribosome-binding GTPase',
  787387,
  789257,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08065',
  'WP_268864901.1',
  'hypothetical protein',
  789268,
  789399,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03570',
  'rimO',
  '30S ribosomal protein S12 methylthiotransferaseRimO',
  789377,
  790696,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03575',
  'WP_000559456.1',
  'phosphoribosyltransferase',
  790698,
  791159,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03580',
  'WP_000924085.1',
  'pyridoxal-phosphate-dependent aminotransferasefamily protein',
  791168,
  792277,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03585',
  'WP_000357337.1',
  'phosphatidylglycerophosphatase A family protein',
  792424,
  792900,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03590',
  'WP_000393659.1',
  'D-alanine--D-alanine ligase',
  792978,
  794021,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03595',
  'estV',
  'lipase EstV',
  794021,
  794746,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03600',
  'murF',
  'Mur ligase family protein',
  794733,
  796214,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03605',
  'WP_001164436.1',
  'HIT family protein',
  796224,
  796709,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03610',
  'WP_000647423.1',
  'ribose-phosphate pyrophosphokinase',
  796774,
  797730,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03615',
  '—',
  '',
  797753,
  797829,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03620',
  'WP_010875539.1',
  'FtsW/RodA/SpoVE family cell cycle protein',
  797791,
  798936,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03625',
  'WP_000453658.1',
  'YcjF family protein',
  798959,
  799543,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03630',
  'WP_000429692.1',
  'GTPase',
  799717,
  800178,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03635',
  'WP_001174316.1',
  'RluA family pseudouridine synthase',
  800330,
  801313,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03640',
  'WP_000731297.1',
  'fibronectin type III domain-containing protein',
  801276,
  802523,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03645',
  'trmB',
  'tRNA (guanosine(46)-N7)-methyltransferase TrmB',
  802534,
  803715,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03650',
  'WP_000111062.1',
  'ABC transporter ATP-binding protein',
  803712,
  804383,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03655',
  'WP_001094195.1',
  'cell division FtsX domain-containing protein',
  804370,
  805176,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03660',
  'WP_000277334.1',
  'murein hydrolase activator EnvC family protein',
  805169,
  806371,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03665',
  'WP_000245963.1',
  'FlaG family protein',
  806464,
  806823,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03670',
  'fliD',
  'flagellar filament capping protein FliD',
  806840,
  808896,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03675',
  'fliS',
  'flagellar export chaperone FliS',
  808936,
  809316,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03680',
  'WP_001087914.1',
  '5-formyltetrahydrofolate cyclo-ligase',
  809303,
  809542,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03685',
  'WP_001294069.1',
  'tRNA threonylcarbamoyladenosine dehydratase',
  809596,
  810267,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07880',
  'WP_000656201.1',
  'hypothetical protein',
  810269,
  810415,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03690',
  'WP_000562739.1',
  'carbon-nitrogen hydrolase',
  810419,
  811297,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03695',
  'WP_000892547.1',
  'Na+/H+ antiporter family protein',
  811424,
  812737,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03700',
  'WP_241033027.1',
  'MATE family efflux transporter',
  812737,
  814053,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03705',
  'rny',
  'ribonuclease Y',
  814054,
  815567,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03710',
  'WP_080012166.1',
  '5-formyltetrahydrofolate cyclo-ligase',
  815545,
  816219,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03715',
  'WP_001220425.1',
  'hypothetical protein',
  816317,
  816874,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03720',
  'ftsY',
  'signal recognition particle-docking proteinFtsY',
  816883,
  817764,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08070',
  'WP_229311989.1',
  'YkgJ family cysteine cluster protein',
  817773,
  818141,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03725',
  '—',
  'YkgJ family cysteine cluster protein',
  818148,
  818924,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03730',
  'WP_000392451.1',
  'hypothetical protein',
  819070,
  819378,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03735',
  'WP_000892392.1',
  'hypothetical protein',
  819389,
  820213,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03740',
  'moaA',
  'GTP 3'',8-cyclase MoaA',
  820477,
  821406,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03745',
  'mobA',
  'molybdenum cofactor guanylyltransferase MobA',
  821530,
  822135,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03750',
  'flhB',
  'flagellar biosynthesis protein FlhB',
  822128,
  823204,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03755',
  'WP_001012473.1',
  'hypothetical protein',
  823277,
  824014,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03760',
  'WP_000961130.1',
  'N-acetylmuramoyl-L-alanine amidase familyprotein',
  824033,
  825355,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03765',
  'fabX',
  'decanoate oxidase/trans-2-decenoyl-[acyl-carrierprotein] isomerase FabX',
  825362,
  826453,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03770',
  'tyrS',
  'tyrosine--tRNA ligase',
  826470,
  827678,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03775',
  'WP_001002218.1',
  'RelA/SpoT family protein',
  827702,
  830029,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03780',
  'WP_000712202.1',
  'DNA-directed RNA polymerase subunit omega',
  830016,
  830240,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03785',
  'pyrH',
  'UMP kinase',
  830282,
  831004,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03790',
  'WP_001210707.1',
  'MqnA/MqnD/SBP family protein',
  831112,
  831795,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03795',
  'acnB',
  'bifunctional aconitate hydratase2/2-methylisocitrate dehydratase',
  831926,
  834484,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03800',
  'WP_000725309.1',
  'hypothetical protein',
  834565,
  834831,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03805',
  'WP_001145994.1',
  'DDE transposase',
  835102,
  836391,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03810',
  'hofE',
  'outer membrane beta-barrel protein HofE',
  836485,
  837852,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03815',
  '—',
  'hypothetical protein',
  837859,
  838385,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03820',
  'ssrA',
  '',
  838427,
  838812,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03825',
  'lolA',
  'LolA-like outer membrane lipoprotein chaperone',
  838878,
  839432,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03830',
  'secA',
  'preprotein translocase subunit SecA',
  839580,
  842177,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03835',
  'WP_001133691.1',
  'ABC transporter permease',
  842167,
  843399,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03840',
  'hofF',
  'outer membrane beta-barrel protein HofF',
  843679,
  845178,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07885',
  'WP_001105655.1',
  'hypothetical protein',
  845257,
  845403,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03845',
  'WP_000548846.1',
  'restriction endonuclease subunit S',
  845540,
  846835,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03850',
  'WP_001158808.1',
  'heavy metal translocating P-type ATPase',
  846877,
  848937,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03855',
  'WP_000611139.1',
  'YifB family Mg chelatase-like AAA ATPase',
  848962,
  850482,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03860',
  'def',
  'peptide deformylase',
  850488,
  851012,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03865',
  'clpP',
  'ATP-dependent Clp endopeptidase proteolyticsubunit ClpP',
  851017,
  851604,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03870',
  'tig',
  'trigger factor',
  851625,
  852980,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03875',
  'WP_001037790.1',
  'outer membrane protein',
  853092,
  853928,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03880',
  'hpaA',
  'flagellar sheath lipoprotein HpaA',
  853957,
  854739,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03885',
  'moaC',
  'cyclic pyranopterin monophosphate synthase MoaC',
  854858,
  855334,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03890',
  'mog',
  'molybdopterin adenylyltransferase',
  855343,
  855873,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03895',
  'WP_000912676.1',
  'molybdopterin synthase catalytic subunit',
  855886,
  856323,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03900',
  'WP_000230572.1',
  'MoaD/ThiS family protein',
  856324,
  856545,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03905',
  'ribA',
  'GTP cyclohydrolase II',
  856621,
  857199,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03910',
  'WP_229311991.1',
  'DUF3943 domain-containing protein',
  857288,
  858064,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03915',
  'WP_000601458.1',
  'bifunctional 3,4-dihydroxy-2-butanone4-phosphate synthase/GTP cyclohydrolase II',
  858216,
  859250,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03915'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03920',
  'WP_001263320.1',
  'glycosyltransferase family 25 protein',
  859421,
  860275,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03925',
  'WP_000883304.1',
  'M48 family metallopeptidase',
  860357,
  860977,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03930',
  '—',
  'TonB-dependent receptor family protein',
  860980,
  863357,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03935',
  'acpS',
  'holo-ACP synthase',
  863551,
  863910,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03940',
  'fliL',
  'flagellar basal body-associated protein FliL',
  863917,
  864468,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03945',
  'rsmD',
  '16S rRNA (guanine(966)-N(2))-methyltransferaseRsmD',
  864477,
  865079,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03950',
  'WP_000688953.1',
  'hypothetical protein',
  865058,
  865384,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03955',
  'WP_001256047.1',
  'class I SAM-dependent methyltransferase',
  865837,
  866847,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03960',
  'WP_000404680.1',
  'MBL fold metallo-hydrolase',
  866980,
  867597,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03965',
  'WP_000952609.1',
  'HesA/MoeB/ThiF family protein',
  867598,
  868365,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03970',
  'motA',
  'flagellar motor stator protein MotA',
  868381,
  869154,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03975',
  'motB',
  'flagellar motor protein MotB',
  869157,
  869930,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03980',
  'WP_001875392.1',
  'hypothetical protein',
  869936,
  870373,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03985',
  'WP_000901317.1',
  'ergothioneine transport permease/ergothioneinebinding protein EgtU',
  870442,
  872103,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03990',
  'WP_000659451.1',
  'ergothioneine transport ATP-binding proteinEgtV',
  872107,
  872757,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS03995',
  'WP_000468790.1',
  'hypothetical protein',
  872760,
  872939,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS03995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04000',
  'WP_000437145.1',
  'hypothetical protein',
  872931,
  873392,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04005',
  'uvrC',
  'excinuclease ABC subunit UvrC',
  873393,
  875177,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04010',
  'WP_000746824.1',
  'homoserine dehydrogenase',
  875188,
  876453,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04015',
  'WP_001211699.1',
  'YraN family protein',
  876454,
  876798,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04020',
  'trxA',
  'thioredoxin',
  876887,
  877207,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04025',
  'trxB',
  'thioredoxin-disulfide reductase',
  877212,
  878147,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04030',
  'WP_001262061.1',
  'glycosyltransferase family 25 protein',
  878363,
  879184,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04035',
  'WP_001244602.1',
  'RNA-binding protein',
  879390,
  879638,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04040',
  'WP_000401225.1',
  'F0F1 ATP synthase subunit A',
  879963,
  880643,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04045',
  'guaB',
  'IMP dehydrogenase',
  880765,
  882210,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04050',
  'gatA',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatA',
  882220,
  883581,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04055',
  'coaE',
  'dephospho-CoA kinase',
  883640,
  884230,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04060',
  'WP_000265099.1',
  'spermidine synthase',
  884232,
  885020,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04065',
  'WP_000480363.1',
  'hypothetical protein',
  885112,
  885990,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04070',
  'der',
  'ribosome biogenesis GTPase Der',
  886067,
  887443,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04075',
  'WP_001029082.1',
  'HU family DNA-binding protein',
  887585,
  887869,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04080',
  '—',
  '',
  887942,
  888018,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04085',
  '—',
  'hypothetical protein',
  888477,
  889081,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04090',
  'WP_001268701.1',
  'HP0838 family lipoprotein',
  889101,
  889718,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04095',
  'WP_000787980.1',
  'OmpP1/FadL family transporter',
  889715,
  891478,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04100',
  'pseB',
  'UDP-N-acetylglucosamine 4,6-dehydratase(inverting)',
  891500,
  892483,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04105',
  'coaBC',
  'bifunctional phosphopantothenoylcysteinedecarboxylase/phosphopantothenate--cysteine ligase CoaBC',
  892480,
  893757,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04110',
  'WP_000888450.1',
  'hypothetical protein',
  893757,
  894494,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04115',
  'thiE',
  'thiamine phosphate synthase',
  894519,
  895178,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04120',
  'thiD',
  'bifunctional hydroxymethylpyrimidinekinase/phosphomethylpyrimidine kinase',
  895171,
  895980,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04125',
  'thiM',
  'hydroxyethylthiazole kinase',
  895977,
  896756,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04130',
  '—',
  'type I restriction endonuclease subunit R',
  896843,
  899835,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04135',
  'WP_229311992.1',
  'restriction endonuclease subunit S',
  899837,
  900838,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08075',
  'WP_001863405.1',
  'hypothetical protein',
  900835,
  901125,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04140',
  'WP_010875553.1',
  'type I restriction-modification system subunitM',
  901118,
  902701,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04150',
  'WP_000230797.1',
  'phosphatase PAP2 family protein',
  902875,
  903558,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04155',
  'WP_000804194.1',
  'COG2958 family protein',
  903788,
  904729,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04160',
  'WP_000942070.1',
  'ABC-F family ATP-binding cassettedomain-containing protein',
  904726,
  906327,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04165',
  'WP_000862222.1',
  'GMP reductase',
  906525,
  907502,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04170',
  'patA',
  'MBOAT family peptidoglycan O-acetyltransferasePatA',
  907687,
  909231,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04175',
  'WP_000397925.1',
  'hypothetical protein',
  909241,
  910335,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04180',
  'gmhA',
  'D-sedoheptulose 7-phosphate isomerase',
  910338,
  910916,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04185',
  'rfaE1',
  'D-glycero-beta-D-manno-heptose-7-phosphatekinase',
  910909,
  912294,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04190',
  'rfaD',
  'ADP-glyceromanno-heptose 6-epimerase',
  912291,
  913283,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04195',
  'gmhB',
  'D-glycero-beta-D-manno-heptose 1,7-bisphosphate7-phosphatase',
  913292,
  913813,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04200',
  'WP_001178201.1',
  'sulfite exporter TauE/SafE family protein',
  913803,
  914543,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04205',
  'WP_001111589.1',
  'type III pantothenate kinase',
  914534,
  915205,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04210',
  'pgbB',
  'plasminogen-binding protein PgbB',
  915210,
  916838,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04215',
  'WP_000023053.1',
  'tetratricopeptide repeat protein',
  916843,
  917499,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04220',
  'dut',
  'dUTP diphosphatase',
  917496,
  917933,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04225',
  'greA',
  'transcription elongation factor GreA',
  917923,
  918417,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04230',
  'lpxB',
  'lipid-A-disaccharide synthase',
  918458,
  919540,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04235',
  'mua',
  'nickel-binding protein Mua',
  919540,
  920001,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04240',
  'hypA',
  'hydrogenase/urease nickel incorporation proteinHypA',
  920005,
  920358,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04245',
  'flgE',
  'flagellar hook protein FlgE',
  920417,
  922573,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04250',
  'cdh',
  'CDP-diacylglycerol diphosphatase',
  922781,
  923598,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04255',
  'WP_001153384.1',
  'zinc ribbon domain-containing protein YjdM',
  923867,
  924196,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04260',
  'WP_001206520.1',
  'hypothetical protein',
  924251,
  924466,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04265',
  'WP_000829005.1',
  'twin-arginine translocation signaldomain-containing protein',
  924551,
  925426,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04270',
  'WP_000247370.1',
  'catalase',
  925571,
  927088,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04275',
  'WP_000479960.1',
  'TonB-dependent receptor',
  927411,
  929786,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04280',
  'ruvC',
  'crossover junction endodeoxyribonuclease RuvC',
  929787,
  930260,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04285',
  '—',
  'NYN domain-containing protein',
  930391,
  931123,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04290',
  'WP_230372314.1',
  'hypothetical protein',
  931603,
  931992,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08080',
  '—',
  'hypothetical protein',
  932279,
  932783,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04305',
  'ruvA',
  'Holliday junction branch migration protein RuvA',
  932818,
  933369,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04310',
  'WP_000051272.1',
  'FapA family protein',
  933395,
  935239,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04315',
  'murJ',
  'murein biosynthesis integral membrane proteinMurJ',
  935332,
  936792,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04320',
  'cysS',
  'cysteine--tRNA ligase',
  936793,
  938190,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04325',
  'vacA',
  'autotransporter vacuolating cytotoxin VacA',
  938415,
  942287,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04330',
  'WP_000242349.1',
  'ABC transporter ATP-binding protein',
  942347,
  943114,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04335',
  'WP_000921458.1',
  'FecCD family ABC transporter permease',
  943114,
  944094,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04340',
  'WP_000504124.1',
  'SDR family oxidoreductase',
  944087,
  944935,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04345',
  'WP_001135603.1',
  'acyl-CoA thioesterase',
  945075,
  945599,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04350',
  'WP_000955518.1',
  'HP0892 family type II toxin-antitoxin systemmRNA interferase toxin',
  945691,
  945963,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04355',
  'WP_001134157.1',
  'type II toxin-antitoxin system antitoxin',
  945977,
  946264,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04360',
  'WP_000916169.1',
  'HP0894 family type II toxin-antitoxin systemmRNA interferase toxin',
  946345,
  946611,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04365',
  'WP_001134075.1',
  'type II toxin-antitoxin system HP0895 familyantitoxin',
  946592,
  946969,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04370',
  'babB',
  'Hop family adhesin BabB',
  947580,
  949706,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04375',
  '—',
  '',
  949897,
  949973,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04380',
  '—',
  '',
  949992,
  950066,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08085',
  'WP_010875559.1',
  'helicase DnaB modulator',
  950022,
  950648,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04390',
  'hypD',
  'hydrogenase formation protein HypD',
  950740,
  951852,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04395',
  'WP_000335443.1',
  'HypC/HybG/HupF family hydrogenase formationchaperone',
  951858,
  952091,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04400',
  'hypB',
  'hydrogenase nickel incorporation protein HypB',
  952091,
  952819,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08090',
  'WP_000973857.1',
  'hypothetical protein',
  952928,
  953053,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04405',
  'WP_000454259.1',
  'cupin domain-containing protein',
  953064,
  953363,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04410',
  '—',
  'acetate kinase',
  953461,
  954661,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08095',
  'pta',
  'phosphate acetyltransferase',
  954679,
  956225,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04425',
  'WP_001139893.1',
  'flagellar hook-length control protein FliK',
  956485,
  958068,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04430',
  'flgD',
  'flagellar hook assembly protein FlgD',
  958119,
  959024,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04435',
  'WP_001000225.1',
  'flagellar hook protein FlgE',
  959021,
  960838,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04440',
  'WP_000613266.1',
  'hypothetical protein',
  960890,
  961495,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04445',
  'WP_000427118.1',
  'Eco57I restriction-modification methylasedomain-containing protein',
  961476,
  962627,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04450',
  'WP_000894570.1',
  'ATP-dependent helicase',
  962631,
  964658,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04455',
  'alpA',
  'Hop family adhesin AlpA',
  965177,
  966724,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04460',
  'alpB',
  'Hop family adhesin AlpB',
  966746,
  968335,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04465',
  'hofG',
  'outer membrane beta-barrel protein HofG',
  969238,
  970782,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04470',
  '—',
  'TonB-dependent receptor',
  971028,
  973465,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04475',
  'WP_001229996.1',
  'hypothetical protein',
  973725,
  974156,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04480',
  'carB',
  'carbamoyl-phosphate synthase large subunit',
  974161,
  977418,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04485',
  'WP_001240277.1',
  'Bax inhibitor-1/YccA family protein',
  977517,
  978209,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04490',
  'gap',
  'type I glyceraldehyde-3-phosphate dehydrogenase',
  978353,
  979351,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04495',
  'WP_000874574.1',
  'vacuolating cytotoxin domain-containing protein',
  979432,
  987021,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04500',
  'hopJ',
  'Hop family outer membrane protein HopJ/HopK',
  987073,
  988182,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04505',
  'WP_001115881.1',
  '2-hydroxymuconate tautomerase family protein',
  988242,
  988448,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04510',
  'recR',
  'recombination mediator RecR',
  988604,
  989185,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04515',
  'truD',
  'tRNA pseudouridine(13) synthase TruD',
  989182,
  990327,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04520',
  'htpX',
  'zinc metalloprotease HtpX',
  990314,
  991246,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04525',
  'folE',
  'GTP cyclohydrolase I FolE',
  991247,
  991789,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04530',
  'WP_000098051.1',
  'polyprenyl synthetase family protein',
  991805,
  992716,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04535',
  'surE',
  '5''/3''-nucleotidase SurE',
  992713,
  993516,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04540',
  '—',
  'hypothetical protein',
  993513,
  994171,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04545',
  'WP_000236875.1',
  '6-pyruvoyl trahydropterin synthase familyprotein',
  994173,
  994775,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04550',
  'WP_000775643.1',
  '7-carboxy-7-deazaguanine synthase QueE',
  994778,
  995533,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04555',
  'WP_000153370.1',
  'GNAT family N-acetyltransferase',
  995544,
  996029,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04560',
  '—',
  'outer membrane beta-barrel protein',
  996146,
  996360,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04565',
  'WP_042960818.1',
  'MFS transporter',
  996532,
  997914,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08100',
  '—',
  'DUF262 domain-containing protein',
  998170,
  999165,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08105',
  '—',
  'hypothetical protein',
  999398,
  999544,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04575',
  'WP_001862939.1',
  'amino acid ABC transporter permease',
  999607,
  1000320,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04580',
  'WP_000756473.1',
  'amino acid ABC transporter substrate-bindingprotein',
  1000304,
  1001074,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04585',
  'alr',
  'alanine racemase',
  1001142,
  1002275,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04590',
  'WP_000447623.1',
  'alanine/glycine:cation symporter family protein',
  1002282,
  1003634,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04595',
  'WP_000712480.1',
  'NAD(P)/FAD-dependent oxidoreductase',
  1003675,
  1004907,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04600',
  'WP_000665817.1',
  'RidA family protein',
  1004929,
  1005306,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04605',
  '—',
  '',
  1005696,
  1005770,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04610',
  'WP_001862951.1',
  'TRL-like family protein',
  1005802,
  1006101,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04615',
  '—',
  '',
  1006166,
  1006252,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04620',
  '—',
  '',
  1006326,
  1006400,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04625',
  '—',
  '',
  1006448,
  1006535,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04630',
  'WP_000524398.1',
  'Na+/H+ antiporter NhaC family protein',
  1006665,
  1008155,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04635',
  'WP_000953818.1',
  'hypothetical protein',
  1008470,
  1008832,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04640',
  'WP_001213490.1',
  'LapA family protein',
  1009199,
  1010212,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04645',
  'rlmH',
  '23S rRNA(pseudouridine(1915)-N(3))-methyltransferase RlmH',
  1010222,
  1010674,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04650',
  'accD',
  'acetyl-CoA carboxylase, carboxyltransferasesubunit beta',
  1010688,
  1011557,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04655',
  'recO',
  'recombination protein RecO',
  1011638,
  1012252,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04660',
  'WP_000669256.1',
  'CinA family protein',
  1012263,
  1012919,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04665',
  'WP_000476691.1',
  'hypothetical protein',
  1012922,
  1013488,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04670',
  'rdxA',
  'oxygen-insensitive NAD(P)H-dependentoxidoreductase RdxA',
  1013553,
  1014185,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04675',
  'lgt',
  'prolipoprotein diacylglyceryl transferase',
  1014182,
  1015036,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04680',
  'WP_000409617.1',
  'RluA family pseudouridine synthase',
  1015046,
  1015774,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04685',
  'waaA',
  'lipid IV(A) 3-deoxy-D-manno-octulosonic acidtransferase',
  1015786,
  1016967,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04690',
  'WP_001091835.1',
  'zinc ribbon domain-containing protein',
  1016968,
  1017732,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04695',
  'WP_001229797.1',
  'GTP cyclohydrolase I',
  1017742,
  1018473,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04700',
  'glyQ',
  'glycine--tRNA ligase subunit alpha',
  1018460,
  1019371,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04705',
  'WP_000401714.1',
  'NAD(P)H-dependent glycerol-3-phosphatedehydrogenase',
  1019385,
  1020323,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08110',
  'acpP',
  'acyl carrier protein',
  1020455,
  1020934,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04715',
  '—',
  'dynamin-like GTPase family protein',
  1020912,
  1022252,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04720',
  '—',
  'dynamin-like GTPase family protein',
  1022249,
  1024581,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04725',
  'WP_000244300.1',
  'dynamin-like GTPase family protein',
  1024578,
  1026224,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04730',
  'WP_000271456.1',
  'endoribonuclease VapD',
  1026448,
  1026735,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04735',
  '—',
  'DUF3240 family protein',
  1026805,
  1027086,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04740',
  'WP_015056073.1',
  'CusA/CzcA family heavy metal efflux RNDtransporter',
  1027102,
  1030161,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04745',
  'WP_000816822.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1030161,
  1031240,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04750',
  'WP_001212364.1',
  'TolC family protein',
  1031237,
  1032538,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04755',
  'glyS',
  'glycine--tRNA ligase subunit beta',
  1032528,
  1034633,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04760',
  'WP_000682021.1',
  'hypothetical protein',
  1034745,
  1035806,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04765',
  'gpmI',
  '2,3-bisphosphoglycerate-independentphosphoglycerate mutase',
  1035819,
  1037294,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04770',
  'gatC',
  'Asp-tRNA(Asn)/Glu-tRNA(Gln) amidotransferasesubunit GatC',
  1037309,
  1037590,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04775',
  'WP_001010809.1',
  'adenosylmethionine--8-amino-7-oxononanoatetransaminase',
  1037710,
  1039020,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04780',
  'WP_000574070.1',
  'peptidylprolyl isomerase',
  1039149,
  1040612,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04785',
  'ftsA',
  'cell division protein FtsA',
  1040613,
  1042106,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04790',
  'ftsZ',
  'cell division protein FtsZ',
  1042237,
  1043394,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04795',
  '—',
  'site-2 protease family protein',
  1044552,
  1044851,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04800',
  '—',
  'exodeoxyribonuclease VII large subunit',
  1044844,
  1045092,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04805',
  'WP_001101624.1',
  'hypothetical protein',
  1045596,
  1046204,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04810',
  'WP_001169565.1',
  'hypothetical protein',
  1046205,
  1046495,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04815',
  '—',
  'DNA adenine methylase',
  1046764,
  1046893,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04820',
  'WP_000343415.1',
  'small-conductance mechanosensitive channel MscS',
  1047054,
  1047878,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04825',
  'WP_000517562.1',
  'hypothetical protein',
  1048165,
  1048380,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04830',
  '—',
  'type II restriction endonuclease',
  1048531,
  1048653,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04835',
  'WP_010875575.1',
  'Card1-like endonuclease domain-containingprotein',
  1048714,
  1049427,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04840',
  'WP_164930552.1',
  'hypothetical protein',
  1049510,
  1049722,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08115',
  'WP_000886948.1',
  'hypothetical protein',
  1050812,
  1051045,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04850',
  'tnpA',
  'IS200/IS605 family transposase',
  1051052,
  1051498,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04855',
  'WP_000930564.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  1051550,
  1052833,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04860',
  '—',
  'hypothetical protein',
  1052849,
  1053595,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04865',
  'WP_229311981.1',
  'hypothetical protein',
  1053600,
  1054286,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04870',
  'WP_010875577.1',
  'hypothetical protein',
  1054376,
  1054615,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04875',
  'WP_000006537.1',
  'hypothetical protein',
  1054815,
  1055066,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04880',
  'WP_000009111.1',
  'nucleotidyl transferase AbiEii/AbiGii toxinfamily protein',
  1055038,
  1055841,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04885',
  'WP_001120382.1',
  'tyrosine-type recombinase/integrase',
  1056158,
  1057225,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04890',
  '—',
  'relaxase',
  1058373,
  1060229,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04895',
  'WP_000930565.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  1060324,
  1061607,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04900',
  'tnpA',
  'IS200/IS605 family transposase',
  1061659,
  1062105,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04905',
  'WP_010875579.1',
  'hypothetical protein',
  1062236,
  1062421,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04910',
  'WP_000587397.1',
  'ParA family protein',
  1062687,
  1063343,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04915',
  'WP_000394638.1',
  'hypothetical protein',
  1063428,
  1063712,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04915'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04920',
  'WP_000665511.1',
  'hypothetical protein',
  1063756,
  1064940,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04925',
  '—',
  'relaxase/mobilization nuclease domain-containingprotein',
  1064965,
  1066874,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04930',
  'WP_000065304.1',
  'hypothetical protein',
  1067156,
  1067470,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04935',
  '—',
  'YafQ family addiction module toxin',
  1067463,
  1067745,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04940',
  '—',
  'type IV secretory system conjugative DNAtransfer family protein',
  1068021,
  1068545,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04945',
  '—',
  'transposase',
  1068602,
  1069929,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04950',
  'tnpA',
  'IS200/IS605 family transposase',
  1069967,
  1070383,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04955',
  '—',
  'tyrosine-type recombinase/integrase',
  1070592,
  1071303,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08120',
  '—',
  'restriction endonuclease subunit S',
  1071593,
  1071754,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04960',
  '—',
  '',
  1072258,
  1072335,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04965',
  'WP_001078673.1',
  'RNA degradosome polyphosphate kinase',
  1072429,
  1074456,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04970',
  'WP_000967190.1',
  'quinone-dependent dihydroorotate dehydrogenase',
  1074493,
  1075548,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04975',
  'WP_000680224.1',
  'zinc protease PqqE',
  1075545,
  1076879,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04980',
  'dapA',
  '4-hydroxy-tetrahydrodipicolinate synthase',
  1076894,
  1077796,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04985',
  'WP_001014495.1',
  'enoyl-ACP reductase',
  1077793,
  1078581,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04990',
  'WP_001179563.1',
  'hypothetical protein',
  1078591,
  1079199,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS04995',
  'pgsA',
  'CDP-diacylglycerol--glycerol-3-phosphate3-phosphatidyltransferase',
  1079196,
  1079735,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS04995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05000',
  'WP_015056076.1',
  'amino acid permease',
  1079950,
  1081392,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05005',
  '—',
  'DegQ family serine endoprotease',
  1081437,
  1082868,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05010',
  'WP_000052931.1',
  'bifunctional 2-C-methyl-D-erythritol 4-phosphatecytidylyltransferase/2-C-methyl-D-erythritol2,4-cyclodiphosphate synthase',
  1082890,
  1084110,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05015',
  'WP_000697557.1',
  'OriC activity response regulator',
  1084132,
  1085028,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05020',
  'WP_000556224.1',
  '5''-3'' exonuclease',
  1085284,
  1086120,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05025',
  'WP_001199552.1',
  'hypothetical protein',
  1086215,
  1087465,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05030',
  'WP_000045822.1',
  'DnaJ family protein',
  1087633,
  1088499,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05035',
  'WP_000332994.1',
  'heat shock protein transcriptional repressorHspR',
  1088509,
  1088880,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05040',
  'WP_000060246.1',
  'replication-associated recombination protein A',
  1088877,
  1090052,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05045',
  'fur',
  'ferric iron uptake transcriptional regulator',
  1090212,
  1090664,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05050',
  'WP_001241701.1',
  'DUF2147 domain-containing protein',
  1090684,
  1091181,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05055',
  'WP_000964040.1',
  'YhcH/YjgK/YiaL family protein',
  1091178,
  1091714,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05060',
  'fliY',
  'flagellar motor switch protein FliY',
  1091743,
  1092606,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05065',
  'fliM',
  'flagellar motor switch protein FliM',
  1092610,
  1093674,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05070',
  'WP_000602430.1',
  'RNA polymerase sigma factor FliA',
  1093667,
  1094434,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05075',
  'WP_000868000.1',
  'hypothetical protein',
  1094412,
  1094726,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05080',
  'ylxH',
  'flagellum site-determining protein YlxH',
  1094733,
  1095617,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05085',
  'flhF',
  'flagellar biosynthesis protein FlhF',
  1095614,
  1096990,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05090',
  'folK',
  '2-amino-4-hydroxy-6-hydroxymethyldihydropteridine diphosphokinase',
  1096987,
  1097475,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05095',
  'WP_000677174.1',
  'aminopeptidase',
  1097475,
  1098548,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05100',
  'aroQ',
  'type II 3-dehydroquinate dehydratase',
  1098562,
  1099065,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05105',
  'WP_000910790.1',
  'O-antigen ligase family protein',
  1099194,
  1100483,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05110',
  'rpsO',
  '30S ribosomal protein S15',
  1100514,
  1100786,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05115',
  'flhA',
  'flagellar biosynthesis protein FlhA',
  1100927,
  1103128,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05120',
  'WP_001862796.1',
  '3'',5''-cyclic-nucleotide phosphodiesterase',
  1103159,
  1104202,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05125',
  'hsrA',
  'response regulator-like transcription factorHsrA',
  1104745,
  1105416,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05130',
  'WP_000908758.1',
  'metallophosphoesterase',
  1105773,
  1106885,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05135',
  'acs',
  'acetate--CoA ligase',
  1107083,
  1109071,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05140',
  'WP_000162267.1',
  'ribosome maturation factor RimP',
  1109179,
  1109619,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05145',
  'rbfA',
  '30S ribosome-binding factor RbfA',
  1109612,
  1109947,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05150',
  'infB',
  'translation initiation factor IF-2',
  1109947,
  1112781,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05155',
  'WP_001232504.1',
  'DUF448 domain-containing protein',
  1112778,
  1113032,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05160',
  'thrB',
  'homoserine kinase',
  1113019,
  1113900,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05165',
  'WP_000417907.1',
  'tRNA threonylcarbamoyladenosine biosynthesisprotein TsaB',
  1113954,
  1114427,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05170',
  'lpxC',
  'UDP-3-O-acyl-N-acetylglucosamine deacetylase',
  1114449,
  1115336,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05175',
  'minC',
  'septum site-determining protein MinC',
  1115333,
  1115920,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05180',
  'WP_000423121.1',
  'M23 family metallopeptidase',
  1115923,
  1117245,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05185',
  'WP_000911251.1',
  'outer membrane beta-barrel protein',
  1117255,
  1118199,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05190',
  'WP_001862786.1',
  'outer membrane beta-barrel protein',
  1118208,
  1119050,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05195',
  'WP_001862785.1',
  'hypothetical protein',
  1119040,
  1119762,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05200',
  'panB',
  '3-methyl-2-oxobutanoatehydroxymethyltransferase',
  1119911,
  1120723,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05205',
  'ruvB',
  'Holliday junction branch migration DNA helicaseRuvB',
  1120723,
  1121733,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05210',
  'tatB',
  'Sec-independent protein translocase proteinTatB',
  1121801,
  1122283,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05215',
  'tatC',
  'twin-arginine translocase subunit TatC',
  1122276,
  1123037,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05220',
  'queA',
  'tRNA preQ1(34) S-adenosylmethionineribosyltransferase-isomerase QueA',
  1123038,
  1124075,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05225',
  'rsmG',
  '16S rRNA (guanine(527)-N(7))-methyltransferaseRsmG',
  1124072,
  1124608,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05230',
  'WP_000944436.1',
  'PP0621 family protein',
  1124602,
  1124832,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05235',
  'WP_000906037.1',
  'hypothetical protein',
  1124835,
  1125242,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05240',
  '—',
  '',
  1125286,
  1125373,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05245',
  'WP_001879972.1',
  'outer membrane protein',
  1125375,
  1125947,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05250',
  'WP_000772151.1',
  'chemotaxis response regulator CheY',
  1126268,
  1126642,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05255',
  'prmA',
  '50S ribosomal protein L11 methyltransferase',
  1126655,
  1127644,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05260',
  'ftsH',
  'ATP-dependent zinc metalloprotease FtsH',
  1127653,
  1129551,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07955',
  'WP_000881891.1',
  'hypothetical protein',
  1129554,
  1129808,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05265',
  'pssA',
  'CDP-diacylglycerol--serineO-phosphatidyltransferase',
  1129798,
  1130511,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05270',
  'copA',
  'copper-translocating P-type ATPase CopA',
  1130508,
  1132745,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05275',
  'copP',
  'copper-binding metallochaperone CopP',
  1132746,
  1132946,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05280',
  '—',
  'hypothetical protein',
  1133091,
  1133911,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05285',
  'csd4',
  'DL-carboxypeptidase Csd4',
  1133935,
  1135251,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05290',
  'WP_000353458.1',
  'flagellar FLiS export co-chaperone',
  1135386,
  1135901,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05295',
  'WP_000780430.1',
  'HoxN/HupN/NixA family nickel/cobalt transporter',
  1135905,
  1136900,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05300',
  'WP_000763834.1',
  'DUF3226 domain-containing protein',
  1136958,
  1137644,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05305',
  'WP_000616490.1',
  'ATP/GTP phosphatase',
  1137673,
  1138785,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05310',
  'WP_000716775.1',
  'restriction endonuclease',
  1138896,
  1139465,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05315',
  'WP_000946689.1',
  'hypothetical protein',
  1139469,
  1140092,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05320',
  'WP_000764940.1',
  'ABC transporter ATP-binding protein',
  1140086,
  1141741,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05325',
  'hofB',
  'outer membrane beta-barrel protein HofB',
  1141833,
  1143272,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05330',
  'pyrB',
  'aspartate carbamoyltransferase',
  1143527,
  1144450,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05335',
  'WP_000523527.1',
  'hypothetical protein',
  1144517,
  1145032,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05340',
  'WP_001235220.1',
  'TlyA family rRNA(cytidine-2''-O)-methyltransferase',
  1145032,
  1145739,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05345',
  'WP_000931634.1',
  'bifunctional riboflavin kinase/FAD synthetase',
  1145705,
  1146547,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05350',
  'tkt',
  'transketolase',
  1146594,
  1148519,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05355',
  'addB',
  'ATP-dependent deoxyribonuclease AddB',
  1148516,
  1150852,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05360',
  'WP_000837260.1',
  'DNA translocase FtsK',
  1150849,
  1153416,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08125',
  'WP_080012144.1',
  'hypothetical protein',
  1153382,
  1153573,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05365',
  'WP_001069529.1',
  'MFS transporter',
  1153676,
  1154956,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05370',
  'WP_001179202.1',
  'flagellar hook-basal body protein',
  1155009,
  1155818,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05375',
  'WP_328287442.1',
  'hypothetical protein',
  1156525,
  1156755,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05380',
  'WP_000930565.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  1156724,
  1158007,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05385',
  'tnpA',
  'IS200/IS605 family transposase',
  1158059,
  1158505,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05390',
  'hcpC',
  'Sel1-like repeat protein HcpC',
  1158719,
  1159591,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05395',
  'WP_001152804.1',
  'bifunctional 4-hydroxy-2-oxoglutaratealdolase/2-dehydro-3-deoxy-phosphogluconate aldolase',
  1159661,
  1160287,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05400',
  'edd',
  'phosphogluconate dehydratase',
  1160306,
  1162132,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05405',
  'WP_000883625.1',
  'glucose-6-phosphate dehydrogenase',
  1162198,
  1163475,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05410',
  'pgl',
  '6-phosphogluconolactonase',
  1163486,
  1164169,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05415',
  'WP_001126886.1',
  'glucokinase',
  1164156,
  1165166,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05420',
  'WP_001265981.1',
  'NAD(P)-dependent alcohol dehydrogenase',
  1165328,
  1166374,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05425',
  'WP_000199741.1',
  'glycosyltransferase family 8 protein',
  1166386,
  1167681,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05430',
  'WP_000576584.1',
  'hypothetical protein',
  1167872,
  1169179,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05435',
  'WP_001863208.1',
  'outer membrane protein',
  1169186,
  1169848,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05440',
  'WP_000486467.1',
  'pyruvate flavodoxin oxidoreductase subunitgamma',
  1170138,
  1170698,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05445',
  'WP_000656174.1',
  '4Fe-4S dicluster-binding protein',
  1170714,
  1171106,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05450',
  'WP_001129867.1',
  '2-oxoacid:ferredoxin oxidoreductase subunitalpha',
  1171116,
  1172339,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05455',
  'WP_000238135.1',
  'thiamine pyrophosphate-dependent enzyme',
  1172352,
  1173296,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05460',
  'purB',
  'adenylosuccinate lyase',
  1173406,
  1174728,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05465',
  'WP_000816949.1',
  'outer membrane protein',
  1174794,
  1175627,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05470',
  'uvrB',
  'excinuclease ABC subunit UvrB',
  1175638,
  1177614,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05475',
  '—',
  'hypothetical protein',
  1177655,
  1178367,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05480',
  'WP_000775280.1',
  'DUF3519 domain-containing protein',
  1178384,
  1181257,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05485',
  'WP_000540113.1',
  'HP1117 family Sel1-like repeat protein',
  1181667,
  1182437,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05490',
  'ggt',
  'gamma-glutamyltransferase',
  1182706,
  1184409,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05495',
  'flgK',
  'flagellar hook-associated protein FlgK',
  1184620,
  1186440,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05500',
  'WP_000260859.1',
  'hypothetical protein',
  1186442,
  1186876,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05505',
  'WP_000512163.1',
  'DNA cytosine methyltransferase',
  1187005,
  1187961,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05510',
  'WP_001863090.1',
  'flagellar biosynthesis anti-sigma factor FlgM',
  1188105,
  1188308,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05515',
  'WP_001088955.1',
  'hypothetical protein',
  1188372,
  1188578,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05520',
  'WP_001179304.1',
  'FKBP-type peptidyl-prolyl cis-trans isomerase',
  1188610,
  1189167,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05525',
  'WP_000825110.1',
  'hypothetical protein',
  1189154,
  1190149,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05530',
  'WP_000831156.1',
  'outer membrane protein Omp18',
  1190157,
  1190696,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05535',
  'tolB',
  'Tol-Pal system protein TolB',
  1190763,
  1192016,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05540',
  '—',
  'energy transducer TonB',
  1192013,
  1192838,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05545',
  'WP_001105106.1',
  'ExbD/TolR family protein',
  1192857,
  1193258,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05550',
  'WP_000887310.1',
  'MotA/TolQ/ExbB proton channel family protein',
  1193311,
  1193880,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05555',
  'atpC',
  'ATP synthase F1 subunit epsilon',
  1193891,
  1194262,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05560',
  'atpD',
  'F0F1 ATP synthase subunit beta',
  1194273,
  1195673,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05565',
  'atpG',
  'ATP synthase F1 subunit gamma',
  1195705,
  1196610,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05570',
  'atpA',
  'F0F1 ATP synthase subunit alpha',
  1196625,
  1198136,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05575',
  'WP_001153275.1',
  'F0F1 ATP synthase subunit delta',
  1198157,
  1198699,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05580',
  'WP_000498446.1',
  'F0F1 ATP synthase subunit B',
  1198700,
  1199215,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05585',
  'WP_001027591.1',
  'FoF1 ATP synthase subunit B''',
  1199219,
  1199653,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05590',
  'WP_001107421.1',
  'ParB/RepB/Spo0J family partition protein',
  1199764,
  1200636,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05595',
  'soj',
  'chromosome partitioning ATPase Soj',
  1200639,
  1201430,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05600',
  'WP_001248203.1',
  'biotin--[acetyl-CoA-carboxylase] ligase',
  1201436,
  1202074,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05605',
  'fmt',
  'methionyl-tRNA formyltransferase',
  1202071,
  1202982,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05610',
  'WP_001087590.1',
  'ATP-binding protein',
  1203006,
  1205279,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05615',
  'WP_001157499.1',
  'DUF2130 domain-containing protein',
  1205325,
  1206626,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08130',
  'WP_010875597.1',
  'hypothetical protein',
  1206870,
  1207127,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08135',
  'WP_328287443.1',
  'hypothetical protein',
  1207118,
  1207270,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05625',
  '—',
  '',
  1207581,
  1209081,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05630',
  '—',
  'NYN domain-containing protein',
  1209831,
  1210618,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05635',
  'rplS',
  '50S ribosomal protein L19',
  1211231,
  1211587,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05640',
  'trmD',
  'tRNA (guanosine(37)-N1)-methyltransferase TrmD',
  1211609,
  1212298,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05645',
  'rimM',
  'ribosome maturation factor RimM',
  1212299,
  1212853,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05650',
  'WP_000545179.1',
  'KH domain-containing protein',
  1212854,
  1213201,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05655',
  'rpsP',
  '30S ribosomal protein S16',
  1213218,
  1213448,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05660',
  'ffh',
  'signal recognition particle protein',
  1213522,
  1214868,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05665',
  'valS',
  'valine--tRNA ligase',
  1214883,
  1217501,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05670',
  'fliW',
  'flagellar assembly protein FliW',
  1217638,
  1218045,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05675',
  'murG',
  'undecaprenyldiphospho-muramoylpentapeptidebeta-N-acetylglucosaminyltransferase',
  1218057,
  1219118,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05680',
  'hopI',
  'Hop family outer membrane protein HopI',
  1219226,
  1221316,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05685',
  'hopL',
  'Hop family outer membrane protein HopL',
  1221339,
  1225031,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05690',
  'proC',
  'pyrroline-5-carboxylate reductase',
  1225045,
  1225818,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05695',
  'WP_000549876.1',
  'protein adenylyltransferase Fic',
  1225846,
  1226379,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05700',
  'ybeY',
  'rRNA maturation RNase YbeY',
  1226470,
  1226892,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05705',
  'WP_000516078.1',
  'flavodoxin',
  1226947,
  1227441,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05710',
  'WP_001862669.1',
  'DedA family protein',
  1227531,
  1228112,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05715',
  'ccoS',
  'cbb3-type cytochrome oxidase assembly proteinCcoS',
  1228239,
  1228430,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05720',
  'WP_001071022.1',
  'NAD(P)-binding domain-containing protein',
  1228455,
  1229429,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05725',
  'WP_000944753.1',
  'HP1165 family MFS efflux transporter',
  1229436,
  1230596,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05730',
  'pgi',
  'glucose-6-phosphate isomerase',
  1230660,
  1232297,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05735',
  'hofH',
  'outer membrane beta-barrel protein HofH',
  1232603,
  1234018,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05740',
  'WP_162481330.1',
  'carbon starvation CstA family protein',
  1234296,
  1236389,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05745',
  'WP_001162494.1',
  'amino acid ABC transporter permease',
  1236572,
  1237225,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05750',
  'WP_000538549.1',
  'amino acid ABC transporter permease',
  1237227,
  1237898,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05755',
  'WP_000111351.1',
  'amino acid ABC transporter ATP-binding protein',
  1237900,
  1238646,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05760',
  'WP_000855958.1',
  'transporter substrate-binding domain-containingprotein',
  1238695,
  1239528,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05765',
  'WP_000120132.1',
  'hypothetical protein',
  1239650,
  1240201,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05770',
  'WP_001174195.1',
  'sugar MFS transporter',
  1240473,
  1241696,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05775',
  'WP_000505472.1',
  'NCS2 family permease',
  1241825,
  1243132,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05780',
  'hopQ',
  'Hop family adhesin HopQ',
  1243583,
  1245508,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05785',
  'deoD',
  'purine-nucleoside phosphorylase',
  1245964,
  1246665,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05790',
  'WP_001172180.1',
  'phosphopentomutase',
  1246662,
  1247903,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05795',
  'WP_000577889.1',
  'NupC/NupG family nucleoside CNT transporter',
  1247915,
  1249171,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05800',
  '—',
  '',
  1249277,
  1249354,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05805',
  'WP_000473297.1',
  'MFS transporter',
  1249488,
  1250819,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05810',
  'WP_000312855.1',
  'tRNA 2-thiocytidine(32) synthetase TtcA',
  1250838,
  1251599,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05815',
  'WP_000542869.1',
  'cation:proton antiporter',
  1251608,
  1252759,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05820',
  'WP_000905722.1',
  'HP1184 family multidrug efflux MATE transporter',
  1252785,
  1254164,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05825',
  'WP_000973595.1',
  'sugar transporter',
  1254325,
  1255500,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05830',
  '—',
  'carbonic anhydrase',
  1255772,
  1256515,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05835',
  'WP_000446635.1',
  'DUF874 family protein',
  1256746,
  1257903,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05840',
  '—',
  'DUF874 family protein',
  1258168,
  1259205,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05845',
  'asd',
  'aspartate-semialdehyde dehydrogenase',
  1259619,
  1260659,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05850',
  'hisS',
  'histidine--tRNA ligase',
  1260646,
  1261974,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05855',
  'waaF',
  'lipopolysaccharide heptosyltransferase II',
  1262036,
  1263085,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05860',
  'WP_000744184.1',
  'hypothetical protein',
  1263276,
  1263557,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05865',
  'WP_001187418.1',
  'aldo/keto reductase',
  1263775,
  1264764,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05870',
  'fusA',
  'elongation factor G',
  1265308,
  1267386,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05875',
  'rpsG',
  '30S ribosomal protein S7',
  1267398,
  1267865,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05880',
  'rpsL',
  '30S ribosomal protein S12',
  1267881,
  1268288,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05885',
  'WP_000037869.1',
  'DNA-directed RNA polymerase subunit beta/beta''',
  1268377,
  1277049,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05890',
  'rplL',
  '50S ribosomal protein L7/L12',
  1277273,
  1277650,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05895',
  'rplJ',
  '50S ribosomal protein L10',
  1277696,
  1278190,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05900',
  'rplA',
  '50S ribosomal protein L1',
  1278299,
  1279003,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05905',
  'rplK',
  '50S ribosomal protein L11',
  1279048,
  1279473,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05910',
  'nusG',
  'transcription termination/antiterminationprotein NusG',
  1279491,
  1280018,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05915',
  'secE',
  'preprotein translocase subunit SecE',
  1280048,
  1280227,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05915'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05920',
  '—',
  '',
  1280370,
  1280445,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05925',
  'rpmG',
  '50S ribosomal protein L33',
  1280485,
  1280643,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05930',
  'tuf',
  'elongation factor Tu',
  1280679,
  1281878,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05935',
  '—',
  '',
  1282005,
  1282079,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05940',
  '—',
  '',
  1282110,
  1282186,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05945',
  '—',
  '',
  1282202,
  1282286,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05950',
  '—',
  '',
  1282314,
  1282389,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05955',
  'WP_001074915.1',
  'ABC transporter ATP-binding protein/permease',
  1282579,
  1284315,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05960',
  'WP_001162995.1',
  'HAD family hydrolase',
  1284324,
  1284992,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05965',
  'WP_001106543.1',
  'DNA adenine methylase',
  1285193,
  1286182,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05970',
  '—',
  'HNH endonuclease',
  1286191,
  1286877,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05975',
  'cysE',
  'serine O-acetyltransferase',
  1286969,
  1287484,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08140',
  '—',
  'hypothetical protein',
  1287465,
  1287663,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05980',
  '—',
  '',
  1287787,
  1287873,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05985',
  '—',
  '',
  1287929,
  1288015,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05990',
  'WP_000669967.1',
  'F0F1 ATP synthase subunit C',
  1288088,
  1288405,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS05995',
  'WP_000345816.1',
  'polyribonucleotide nucleotidyltransferase',
  1288538,
  1290604,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS05995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06000',
  'WP_001862417.1',
  'phosphoribosyltransferase',
  1290607,
  1291311,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06005',
  '—',
  'LPS-assembly protein LptD',
  1291326,
  1293586,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06010',
  'WP_000556006.1',
  'RDD family protein',
  1293589,
  1294068,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06015',
  'purD',
  'phosphoribosylamine--glycine ligase',
  1294117,
  1295391,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06020',
  'WP_000959606.1',
  'ABC transporter ATP-binding protein',
  1295704,
  1296390,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06025',
  'WP_000370674.1',
  'di-trans,poly-cis-decaprenylcistransferase',
  1296384,
  1297088,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06030',
  'WP_015056088.1',
  'FAD-binding and (Fe-S)-binding domain-containingprotein',
  1297129,
  1299969,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06035',
  'WP_000888834.1',
  'rhodanese-like domain-containing protein',
  1300041,
  1300373,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06040',
  'WP_001862414.1',
  'uroporphyrinogen-III synthase',
  1300376,
  1301056,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06045',
  'crcB',
  'fluoride efflux transporter CrcB',
  1301104,
  1301496,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06050',
  'hemW',
  'radical SAM family heme chaperone HemW',
  1301547,
  1302584,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06055',
  'WP_000755879.1',
  'c-type cytochrome',
  1302679,
  1302969,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06060',
  'WP_000902563.1',
  'RNA pyrophosphohydrolase',
  1303120,
  1303587,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06060'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06065',
  'WP_000909679.1',
  'aspartate kinase',
  1303589,
  1304806,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06070',
  'WP_000788231.1',
  'HobA family DNA replication regulator',
  1304803,
  1305345,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06075',
  'WP_000798416.1',
  'DNA polymerase III subunit delta''',
  1305342,
  1305998,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06080',
  'folP',
  'dihydropteroate synthase',
  1305995,
  1307137,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06085',
  'WP_000301306.1',
  'hypothetical protein',
  1307232,
  1307693,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06090',
  'WP_001246343.1',
  'DMT family transporter',
  1308086,
  1308982,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06095',
  'WP_001177367.1',
  'glycosyltransferase family 39 protein',
  1308986,
  1310233,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06100',
  'WP_001237418.1',
  'DUF507 family protein',
  1310312,
  1310863,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06105',
  'carA',
  'glutamine-hydrolyzing carbamoyl-phosphatesynthase small subunit',
  1310863,
  1311990,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06110',
  'WP_000534771.1',
  'formamidase',
  1312156,
  1313160,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06115',
  'maf',
  'septum formation inhibitor Maf',
  1313614,
  1314186,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06120',
  'alaS',
  'alanine--tRNA ligase',
  1314188,
  1316731,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06120'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06125',
  'WP_000468330.1',
  'YdcH family protein',
  1316851,
  1317081,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06130',
  'babA',
  'Hop family adhesin BabA',
  1317838,
  1320039,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06135',
  'rpsR',
  '30S ribosomal protein S18',
  1320338,
  1320595,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06140',
  'WP_000482414.1',
  'single-stranded DNA-binding protein',
  1320618,
  1321157,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06145',
  'rpsF',
  '30S ribosomal protein S6',
  1321167,
  1321595,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06150',
  'WP_000285823.1',
  'DNA polymerase III subunit delta',
  1321749,
  1322771,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06155',
  'WP_001161318.1',
  'RNB domain-containing ribonuclease',
  1322761,
  1324695,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06160',
  'WP_000769617.1',
  'shikimate dehydrogenase',
  1324695,
  1325486,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06165',
  'WP_000846067.1',
  'SH3 domain-containing protein',
  1325494,
  1326072,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06170',
  'WP_000562619.1',
  'microcin C ABC transporter permease YejB',
  1326081,
  1327127,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06175',
  'WP_000231350.1',
  'extracellular solute-binding protein',
  1327124,
  1328908,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06180',
  'trpS',
  'tryptophan--tRNA ligase',
  1328909,
  1329889,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06185',
  'WP_000376795.1',
  'methyltransferase',
  1329960,
  1330682,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06190',
  'secG',
  'preprotein translocase subunit SecG',
  1330805,
  1331404,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06195',
  'frr',
  'ribosome recycling factor',
  1331404,
  1331961,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06200',
  'pyrE',
  'orotate phosphoribosyltransferase',
  1331965,
  1332570,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06205',
  'WP_000201774.1',
  'RDD family protein',
  1332560,
  1333024,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06210',
  '—',
  'NAD-dependent deacylase',
  1333021,
  1333711,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06215',
  'WP_001183543.1',
  'NAD(P)H-quinone oxidoreductase subunit 3',
  1333813,
  1334214,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06220',
  'WP_001183511.1',
  'NuoB/complex I 20 kDa subunit family protein',
  1334214,
  1334693,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06225',
  'WP_001862738.1',
  'NADH-quinone oxidoreductase subunit C',
  1334693,
  1335490,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06230',
  'nuoD',
  'NADH dehydrogenase (quinone) subunit D',
  1335492,
  1336721,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06235',
  'WP_000819168.1',
  'NADH-ubiquinone oxidoreductase subunit E familyprotein',
  1336718,
  1336948,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06240',
  'WP_000012749.1',
  'hypothetical protein',
  1336951,
  1337937,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06245',
  'WP_000632151.1',
  'NADH-quinone oxidoreductase subunit G',
  1337934,
  1340468,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06250',
  'nuoH',
  'NADH-quinone oxidoreductase subunit NuoH',
  1340465,
  1341454,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06255',
  'nuoI',
  'NADH-quinone oxidoreductase subunit NuoI',
  1341465,
  1342127,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06260',
  'WP_000464208.1',
  'NADH-quinone oxidoreductase subunit J',
  1342120,
  1342668,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06265',
  'nuoK',
  'NADH-quinone oxidoreductase subunit NuoK',
  1342665,
  1342967,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06270',
  'nuoL',
  'NADH-quinone oxidoreductase subunit L',
  1342970,
  1344808,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06275',
  'WP_001159928.1',
  'NADH-quinone oxidoreductase subunit M',
  1344812,
  1346350,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06280',
  'nuoN',
  'NADH-quinone oxidoreductase subunit NuoN',
  1346337,
  1347809,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06285',
  'WP_000266337.1',
  'DUF7494 domain-containing protein',
  1347799,
  1350204,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06290',
  'WP_000355104.1',
  'phosphomannomutase/phosphoglucomutase',
  1350206,
  1351585,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06295',
  'WP_000358197.1',
  'hypothetical protein',
  1351731,
  1352015,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06300',
  'trpA',
  'tryptophan synthase subunit alpha',
  1352363,
  1353151,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06305',
  'trpB',
  'tryptophan synthase subunit beta',
  1353148,
  1354329,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06310',
  'trpCF',
  'bifunctional indole-3-glycerol-phosphatesynthase TrpC/phosphoribosylanthranilate isomerase TrpF',
  1354331,
  1355689,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06315',
  'trpD',
  'anthranilate phosphoribosyltransferase',
  1355682,
  1356689,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06320',
  'WP_000688223.1',
  'aminodeoxychorismate/anthranilate synthasecomponent II',
  1356686,
  1357270,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06325',
  'trpE',
  'anthranilate synthase component I',
  1357267,
  1358769,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07965',
  '—',
  'type II restriction endonuclease',
  1358835,
  1358946,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06330',
  'WP_000838751.1',
  'glycosyltransferase family 9 protein',
  1358992,
  1360449,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06335',
  'WP_000345564.1',
  'glycosyltransferase family 9 protein',
  1360547,
  1361587,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06340',
  'WP_025444690.1',
  '5''-nucleotidase, lipoprotein e(P4) family',
  1361657,
  1362394,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06345',
  'WP_000709479.1',
  'YceI family protein',
  1362519,
  1363067,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06350',
  'tenA',
  'thiaminase II',
  1363131,
  1363784,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06355',
  'WP_064661277.1',
  'hypothetical protein',
  1364353,
  1364706,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06360',
  'WP_001101319.1',
  'hypothetical protein',
  1364730,
  1365215,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06365',
  'pnuC',
  'nicotinamide riboside transporter PnuC',
  1365401,
  1366063,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06370',
  'WP_001149282.1',
  'thiamine diphosphokinase',
  1366051,
  1366665,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06375',
  'rplQ',
  '50S ribosomal protein L17',
  1367372,
  1367722,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06380',
  'WP_000864547.1',
  'DNA-directed RNA polymerase subunit alpha',
  1367722,
  1368756,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06385',
  'rpsD',
  '30S ribosomal protein S4',
  1368768,
  1369394,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06390',
  'rpsK',
  '30S ribosomal protein S11',
  1369404,
  1369799,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06395',
  'rpsM',
  '30S ribosomal protein S13',
  1369822,
  1370184,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06400',
  'rpmJ',
  '50S ribosomal protein L36',
  1370188,
  1370301,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06405',
  'infA',
  'translation initiation factor IF-1',
  1370380,
  1370598,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06410',
  'map',
  'type I methionyl aminopeptidase',
  1370598,
  1371359,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06415',
  'secY',
  'preprotein translocase subunit SecY',
  1371359,
  1372621,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06420',
  'rplO',
  '50S ribosomal protein L15',
  1372664,
  1373065,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06425',
  'rpsE',
  '30S ribosomal protein S5',
  1373085,
  1373528,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06430',
  'rplR',
  '50S ribosomal protein L18',
  1373543,
  1373899,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06435',
  'rplF',
  '50S ribosomal protein L6',
  1373913,
  1374449,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06440',
  'rpsH',
  '30S ribosomal protein S8',
  1374460,
  1374855,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06445',
  'WP_001085694.1',
  'type Z 30S ribosomal protein S14',
  1374865,
  1375050,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06450',
  'rplE',
  '50S ribosomal protein L5',
  1375060,
  1375605,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06455',
  'WP_000834232.1',
  '50S ribosomal protein L24',
  1375618,
  1375839,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06460',
  'rplN',
  '50S ribosomal protein L14',
  1375839,
  1376207,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06465',
  'rpsQ',
  '30S ribosomal protein S17',
  1376210,
  1376470,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06470',
  'rpmC',
  '50S ribosomal protein L29',
  1376483,
  1376683,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06475',
  'rplP',
  '50S ribosomal protein L16',
  1376670,
  1377095,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06480',
  'rpsC',
  '30S ribosomal protein S3',
  1377098,
  1377802,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06485',
  'rplV',
  '50S ribosomal protein L22',
  1377806,
  1378174,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06490',
  'rpsS',
  '30S ribosomal protein S19',
  1378184,
  1378465,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06495',
  'rplB',
  '50S ribosomal protein L2',
  1378476,
  1379306,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06500',
  'WP_000763613.1',
  '50S ribosomal protein L23',
  1379323,
  1379604,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06505',
  'rplD',
  '50S ribosomal protein L4',
  1379608,
  1380255,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06510',
  'rplC',
  '50S ribosomal protein L3',
  1380290,
  1380865,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06515',
  'rpsJ',
  '30S ribosomal protein S10',
  1380902,
  1381216,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06520',
  'WP_001862713.1',
  'ATP-binding protein',
  1381426,
  1382514,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06525',
  'WP_000992725.1',
  'hypothetical protein',
  1382747,
  1383325,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06530',
  'WP_000172120.1',
  'ribonuclease HII',
  1383299,
  1383913,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06535',
  'WP_001067651.1',
  'hypothetical protein',
  1383944,
  1384195,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06540',
  'fumC',
  'class II fumarate hydratase',
  1384217,
  1385608,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06545',
  'crdA',
  'copper resistance determinant CrdA',
  1385783,
  1386160,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06550',
  'crdB',
  'copper resistance outer membrane protein CrdB',
  1386165,
  1387403,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06555',
  'WP_000822204.1',
  'efflux RND transporter periplasmic adaptorsubunit',
  1387400,
  1388416,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06560',
  'WP_000570460.1',
  'CusA/CzcA family heavy metal efflux RNDtransporter',
  1388417,
  1391524,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06565',
  'WP_000928535.1',
  'branched-chain amino acid transporter permease',
  1391527,
  1391874,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06570',
  'azlC',
  'azaleucine resistance protein AzlC',
  1391868,
  1392554,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06575',
  'dnaJ',
  'molecular chaperone DnaJ',
  1392565,
  1393674,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06580',
  'WP_001210151.1',
  'synaptonemal complex protein 1',
  1393799,
  1394947,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06585',
  'WP_000039550.1',
  'NYN domain-containing protein',
  1395156,
  1395830,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06590',
  'mnmA',
  'tRNA 2-thiouridine(34) synthase MnmA',
  1395894,
  1396922,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06595',
  'WP_001062440.1',
  'J domain-containing protein',
  1397061,
  1397822,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06600',
  'nadD',
  'nicotinate (nicotinamide) nucleotideadenylyltransferase',
  1397819,
  1398334,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06605',
  'nikR',
  'nickel-responsive transcriptional regulatorNikR',
  1398327,
  1398773,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06610',
  'exbB',
  'TonB-system energizer ExbB',
  1399099,
  1399536,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06615',
  'exbD',
  'TonB system transport protein ExbD',
  1399533,
  1399922,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06620',
  'WP_000703807.1',
  'energy transducer TonB family protein',
  1399888,
  1400745,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06625',
  'hopM',
  'Hop family outer membrane protein HopM/HopN',
  1400936,
  1403011,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06630',
  'WP_000395259.1',
  'TerC family protein',
  1403168,
  1403896,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06635',
  'corA',
  'magnesium/cobalt transporter CorA',
  1403903,
  1404859,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06640',
  'WP_000880064.1',
  'phosphoglycerate kinase',
  1404875,
  1406083,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06645',
  'gap',
  'type I glyceraldehyde-3-phosphate dehydrogenase',
  1406099,
  1407091,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06650',
  'ung',
  'uracil-DNA glycosylase',
  1407180,
  1407881,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06655',
  'WP_000841286.1',
  '1-acyl-sn-glycerol-3-phosphate acyltransferase',
  1407878,
  1408600,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06660',
  'WP_000506091.1',
  'SH3 domain-containing protein',
  1408587,
  1409750,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06665',
  'WP_001862586.1',
  'S41 family peptidase',
  1409757,
  1411121,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08145',
  '—',
  'DNA methyltransferase',
  1411231,
  1411356,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06670',
  'WP_000386427.1',
  'HpyAIV family type II restriction enzyme',
  1411346,
  1412218,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06675',
  'WP_000346779.1',
  'DNA-methyltransferase',
  1412218,
  1413297,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08150',
  'WP_042960860.1',
  'hypothetical protein',
  1413441,
  1413659,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08155',
  'WP_229311993.1',
  'type ISP restriction/modification enzyme',
  1413719,
  1414642,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06690',
  'WP_010875614.1',
  'type ISP restriction/modification enzyme',
  1414536,
  1417043,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06695',
  'nadC',
  'carboxylating nicotinate-nucleotidediphosphorylase',
  1417068,
  1417889,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06700',
  'nadA',
  'quinolinate synthase NadA',
  1417889,
  1418899,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06705',
  'WP_000226149.1',
  'phosphatidylserine decarboxylase',
  1418889,
  1419692,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06710',
  'WP_000953192.1',
  'DUF6115 domain-containing protein',
  1419686,
  1420192,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06715',
  'WP_001862592.1',
  'hypothetical protein',
  1420205,
  1420699,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06720',
  'mqnP',
  'menaquinone biosynthesis prenyltransferase MqnP',
  1420692,
  1421534,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06725',
  'WP_000653622.1',
  'ComEC/Rec2 family competence protein',
  1421605,
  1422918,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06730',
  'WP_000349722.1',
  'replicative DNA helicase',
  1422915,
  1424381,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06735',
  'WP_000954017.1',
  'NAD(P)H-hydrate dehydratase',
  1424392,
  1425792,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06740',
  'crdS',
  'copper-sensing histidine kinase CrdS',
  1425795,
  1426988,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06745',
  'crdR',
  'copper response regulator transcription factorCrdR',
  1426963,
  1427604,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06750',
  'WP_001125164.1',
  'type IIS restriction endonuclease subunit R',
  1427688,
  1428959,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06755',
  'WP_025444687.1',
  'site-specific DNA-methyltransferase',
  1428975,
  1429751,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06760',
  'WP_001024629.1',
  'DNA-methyltransferase',
  1429744,
  1430607,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08160',
  '—',
  'site-specific DNA-methyltransferase',
  1430856,
  1433284,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06770',
  'WP_001074841.1',
  'DEAD/DEAH box helicase family protein',
  1433295,
  1436201,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06775',
  'mreC',
  'rod shape-determining protein MreC',
  1436251,
  1436997,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06780',
  'WP_000577765.1',
  'rod shape-determining protein',
  1437001,
  1438044,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06785',
  'clpX',
  'ATP-dependent protease ATP-binding subunit ClpX',
  1438087,
  1439427,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06790',
  'lpxA',
  'acyl-ACP--UDP-N-acetylglucosamineO-acyltransferase',
  1439429,
  1440241,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06795',
  'fabZ',
  '3-hydroxyacyl-ACP dehydratase FabZ',
  1440245,
  1440724,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06800',
  'fliW',
  'flagellar assembly protein FliW',
  1440896,
  1441285,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06805',
  'WP_001237316.1',
  'outer membrane protein assembly factor BamD',
  1441694,
  1442356,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06810',
  'lon',
  'endopeptidase La',
  1442398,
  1444905,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06815',
  'WP_025444688.1',
  'prephenate dehydrogenase',
  1444914,
  1445741,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06820',
  'WP_162481328.1',
  'hypothetical protein',
  1445829,
  1446026,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06825',
  '—',
  'DNA/RNA non-specific endonuclease',
  1446085,
  1446480,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06830',
  '—',
  'restriction endonuclease subunit S',
  1446443,
  1446850,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08165',
  '—',
  'type II methylase',
  1446858,
  1446941,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06835',
  'WP_015056116.1',
  'hypothetical protein',
  1446953,
  1447156,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06840',
  'WP_000384644.1',
  'class 1 fructose-bisphosphatase',
  1447156,
  1448028,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06845',
  'rpe',
  'ribulose-phosphate 3-epimerase',
  1448099,
  1448752,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06850',
  'WP_001862622.1',
  '3''-5'' exonuclease',
  1448730,
  1449674,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06850'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06855',
  'WP_000588793.1',
  'hypothetical protein',
  1449862,
  1450062,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06855'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06860',
  'WP_001862625.1',
  'hypothetical protein',
  1450188,
  1450637,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06865',
  'WP_001862626.1',
  'hypothetical protein',
  1450639,
  1450962,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06865'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06870',
  'WP_001294251.1',
  'hypothetical protein',
  1451004,
  1451504,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06870'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06875',
  'WP_000539103.1',
  'hypothetical protein',
  1451757,
  1452053,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06875'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06880',
  'WP_000667832.1',
  'NFACT family protein',
  1452072,
  1453379,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06880'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06885',
  'WP_001204425.1',
  'DNA repair protein RecN',
  1453376,
  1454950,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06885'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06890',
  'WP_000655300.1',
  'NAD(+)/NADH kinase',
  1454965,
  1455819,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06890'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06895',
  'WP_000719289.1',
  'outer membrane protein',
  1456007,
  1456735,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06895'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06900',
  '—',
  'DUF262 domain-containing protein',
  1456746,
  1458467,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06900'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06905',
  'WP_000152122.1',
  'alanine dehydrogenase',
  1458582,
  1459724,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06910',
  'rocF',
  'arginase',
  1459926,
  1460894,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06915',
  'WP_015056095.1',
  'TonB-dependent receptor family protein',
  1461434,
  1463959,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06915'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06920',
  'WP_000995184.1',
  'YgjP family zinc-dependent metalloprotease',
  1464048,
  1464755,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06920'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06925',
  'WP_000845650.1',
  'type I restriction endonuclease subunit R',
  1464755,
  1467733,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06925'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06930',
  'WP_000985413.1',
  'type I restriction-modification system subunitM',
  1467803,
  1470256,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06930'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06935',
  '—',
  'restriction endonuclease subunit S',
  1470265,
  1470540,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06935'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06940',
  '—',
  'CAAX protease',
  1470534,
  1470952,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06940'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06945',
  'WP_001155649.1',
  'biotin synthase',
  1471119,
  1471967,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06945'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06950',
  'WP_001208606.1',
  'YihY/virulence factor BrkB family protein',
  1471967,
  1472845,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06950'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06955',
  'rrf',
  '',
  1473565,
  1473682,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06955'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06960',
  '—',
  '',
  1473918,
  1476805,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06960'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06965',
  'WP_010875477.1',
  'hypothetical protein',
  1477542,
  1477877,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06965'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06970',
  'WP_001062391.1',
  'DUF262 domain-containing protein',
  1477930,
  1479663,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06970'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06975',
  '—',
  'DHH family phosphoesterase',
  1479704,
  1480958,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06975'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06980',
  'WP_000923350.1',
  'hypothetical protein',
  1481000,
  1482859,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06980'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06985',
  'WP_000506796.1',
  'hypothetical protein',
  1482975,
  1483901,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06985'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06990',
  'queF',
  'preQ(1) synthase',
  1484029,
  1484475,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06990'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS06995',
  'rsfS',
  'ribosome silencing factor',
  1484535,
  1484876,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS06995'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07000',
  'miaA',
  'tRNA (adenosine(37)-N6)-dimethylallyltransferaseMiaA',
  1484884,
  1485777,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07000'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07005',
  'WP_000380989.1',
  'glycosyltransferase family 8 protein',
  1485782,
  1486885,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07005'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07010',
  'WP_000415499.1',
  'sulfatase-like hydrolase/transferase',
  1486895,
  1487731,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07010'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07015',
  'WP_025444706.1',
  'phosphoethanolamine transferase',
  1487713,
  1488564,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07015'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07020',
  'WP_000894903.1',
  'UDP-N-acetylmuramate dehydrogenase',
  1488625,
  1489404,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07020'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07025',
  'fliQ',
  'flagellar biosynthesis protein FliQ',
  1489408,
  1489674,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07025'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07030',
  'fliI',
  'flagellar protein export ATPase FliI',
  1489685,
  1490989,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07030'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07035',
  'WP_000854872.1',
  'CpaF/VirB11 family protein',
  1490990,
  1491904,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07035'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07040',
  'ileS',
  'isoleucine--tRNA ligase',
  1491921,
  1494683,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07040'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07045',
  'WP_001217155.1',
  'RNA-binding S4 domain-containing protein',
  1494708,
  1494962,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07045'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07050',
  'WP_000671766.1',
  'hypothetical protein',
  1495064,
  1495684,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07050'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07055',
  '—',
  'outer membrane beta-barrel protein',
  1495812,
  1496638,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07055'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08170',
  '—',
  'hypothetical protein',
  1496903,
  1497101,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07065',
  'rlmN',
  'dual-specificity RNA methyltransferase RlmN',
  1497367,
  1498440,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07065'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07070',
  'WP_001121932.1',
  'KpsF/GutQ family sugar-phosphate isomerase',
  1498437,
  1499426,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07070'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07075',
  'WP_000131629.1',
  'ribonuclease J',
  1499410,
  1501479,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07075'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07080',
  'rsmA',
  '16S rRNA(adenine(1518)-N(6)/adenine(1519)-N(6))-dimethyltransferase RsmA',
  1501517,
  1502332,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07080'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07085',
  'hpnL',
  'nickel-binding protein HpnL',
  1502586,
  1502804,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07085'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07090',
  'WP_000923196.1',
  'hypothetical protein',
  1503438,
  1506116,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07090'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07095',
  'purU',
  'formyltetrahydrofolate deformylase',
  1506117,
  1506998,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07095'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07100',
  'sppA',
  'signal peptide peptidase SppA',
  1507001,
  1507879,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07100'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07105',
  'WP_000752241.1',
  'hypothetical protein',
  1507950,
  1508198,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07105'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07110',
  'WP_001863131.1',
  'TIR domain-containing protein',
  1508462,
  1509151,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07110'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07115',
  'WP_000465600.1',
  'hypothetical protein',
  1509160,
  1510176,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07115'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08175',
  'WP_001863130.1',
  'hypothetical protein',
  1510188,
  1510433,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08180',
  'WP_229311983.1',
  'hypothetical protein',
  1510414,
  1510638,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07125',
  '—',
  '',
  1511135,
  1512634,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07125'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07130',
  'WP_000896371.1',
  'hypothetical protein',
  1513143,
  1513922,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07130'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07135',
  'WP_001863198.1',
  'peptidylprolyl isomerase',
  1514046,
  1514534,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07135'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07140',
  'WP_000906447.1',
  'carbon storage regulator',
  1514554,
  1514784,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07140'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07145',
  'WP_000150052.1',
  '4-(cytidine5''-diphospho)-2-C-methyl-D-erythritol kinase',
  1514781,
  1515587,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07145'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07150',
  'smpB',
  'SsrA-binding protein',
  1515584,
  1516042,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07150'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07155',
  'exbB',
  'TonB-system energizer ExbB',
  1516045,
  1516497,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07155'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07160',
  'WP_000755082.1',
  'ExbD/TolR family protein',
  1516508,
  1516909,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07160'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07165',
  'rpmH',
  '50S ribosomal protein L34',
  1516981,
  1517115,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07165'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07170',
  'rnpA',
  'ribonuclease P protein component',
  1517075,
  1517560,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07170'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07175',
  'yidD',
  'membrane protein insertion efficiency factorYidD',
  1517547,
  1517900,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07175'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07180',
  'yidC',
  'membrane protein insertase YidC',
  1517906,
  1519549,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07180'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07185',
  'WP_001178843.1',
  'Jag N-terminal domain-containing protein',
  1519549,
  1520343,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07190',
  'mnmE',
  'tRNA uridine-5-carboxymethylaminomethyl(34)synthesis GTPase MnmE',
  1520336,
  1521688,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07195',
  'WP_000915379.1',
  'outer membrane beta-barrel protein',
  1521892,
  1524132,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07200',
  'WP_000720409.1',
  'LPP20 family lipoprotein',
  1524949,
  1525860,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07200'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07205',
  'WP_001863192.1',
  'hypothetical protein',
  1525870,
  1526211,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07205'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07210',
  'WP_000795978.1',
  'LPP20 family lipoprotein',
  1526219,
  1526746,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07210'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07215',
  'lpoB',
  'penicillin-binding protein activator LpoB',
  1526770,
  1527402,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07215'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07220',
  'WP_001293258.1',
  'thioredoxin family protein',
  1527772,
  1528086,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07220'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07225',
  'WP_000398405.1',
  'pseudouridine synthase',
  1528141,
  1528929,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07225'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07230',
  'dnaE',
  'DNA polymerase III subunit alpha',
  1528911,
  1532546,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07230'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07235',
  'WP_000748319.1',
  'cytochrome-c peroxidase',
  1532694,
  1533746,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07235'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07240',
  'WP_000603368.1',
  'META domain-containing protein',
  1533923,
  1534510,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07240'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07245',
  'WP_001202825.1',
  'hypothetical protein',
  1534529,
  1535206,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07245'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07250',
  'WP_000439508.1',
  'MlaD family protein',
  1535209,
  1536024,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07250'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07255',
  'WP_000994578.1',
  'ABC transporter ATP-binding protein',
  1536009,
  1536794,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07255'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07260',
  'WP_000845765.1',
  'ABC transporter permease',
  1536794,
  1537927,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07260'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07265',
  'WP_000473425.1',
  'outer membrane protein',
  1538062,
  1538757,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07265'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07270',
  'ilvE',
  'branched-chain-amino-acid transaminase',
  1538762,
  1539784,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07270'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07275',
  'WP_000919897.1',
  'outer membrane protein',
  1539836,
  1540582,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07275'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07280',
  'polA',
  'DNA polymerase I',
  1540697,
  1543372,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07280'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07285',
  'WP_162481332.1',
  'restriction endonuclease subunit S',
  1543443,
  1544705,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07285'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07290',
  'WP_001045361.1',
  'VRR-NUC domain-containing protein',
  1544702,
  1546741,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07290'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07295',
  'WP_001203580.1',
  'ComF family protein',
  1546772,
  1547347,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07295'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07300',
  'tmk',
  'dTMP kinase',
  1547335,
  1547910,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07300'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07305',
  'coaD',
  'pantetheine-phosphate adenylyltransferase',
  1547912,
  1548385,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07305'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07310',
  'WP_000780126.1',
  'UbiX family flavin prenyltransferase',
  1548385,
  1548948,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07310'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07315',
  'flgA',
  'flagellar basal body P-ring formation chaperoneFlgA',
  1548958,
  1549614,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07315'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07320',
  'uvrD',
  'DNA helicase UvrD',
  1549611,
  1551659,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07320'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07325',
  'WP_000931070.1',
  'tetratricopeptide repeat protein',
  1551656,
  1554190,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07325'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07330',
  'serS',
  'serine--tRNA ligase',
  1554200,
  1555447,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07330'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07335',
  'WP_001262107.1',
  'carbon-nitrogen hydrolase family protein',
  1555448,
  1556245,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07335'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07340',
  'WP_001150347.1',
  'exodeoxyribonuclease VII small subunit',
  1556249,
  1556509,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07340'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07345',
  'ubiE',
  'bifunctional demethylmenaquinonemethyltransferase/2-methoxy-6-polyprenyl-1,4-benzoquinolmethylase UbiE',
  1556519,
  1557259,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07345'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07350',
  'hemJ',
  'protoporphyrinogen oxidase HemJ',
  1557286,
  1557732,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07350'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07355',
  'WP_000854221.1',
  'YigZ family protein',
  1557743,
  1558315,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07355'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07360',
  'WP_001008922.1',
  'ABC transporter permease',
  1558302,
  1559432,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07360'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07365',
  'WP_000489051.1',
  'ABC transporter permease',
  1559429,
  1560526,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07365'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07370',
  'WP_000071821.1',
  'HlyD family secretion protein',
  1560538,
  1561527,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07370'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07375',
  'WP_000753982.1',
  'TolC family protein',
  1561539,
  1563071,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07375'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07380',
  'WP_000533332.1',
  'hemolysin family protein',
  1563068,
  1564417,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07380'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07385',
  'WP_000403632.1',
  'inorganic phosphate transporter',
  1564521,
  1566122,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07385'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07390',
  'WP_000569296.1',
  'NifU family protein',
  1566261,
  1566530,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07390'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07395',
  'WP_001168588.1',
  'hypothetical protein',
  1566542,
  1567153,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07395'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07400',
  'WP_000768790.1',
  'UDP-N-acetylmuramoyl-L-alanyl-D-glutamate--2,6-diaminopimelate ligase',
  1567157,
  1568500,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07400'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07405',
  'tal',
  'transaldolase',
  1568504,
  1569454,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07405'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07410',
  'WP_000889331.1',
  '50S ribosomal protein L25/general stress proteinCtc',
  1569509,
  1570045,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07410'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07415',
  'pth',
  'aminoacyl-tRNA hydrolase',
  1570055,
  1570615,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07415'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07420',
  'WP_001236083.1',
  'LptF/LptG family permease',
  1570670,
  1571737,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07420'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07425',
  '—',
  'phospholipase D-like domain-containing protein',
  1571852,
  1572768,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07425'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08185',
  '—',
  'restriction endonuclease',
  1572827,
  1572937,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08185'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07430',
  'WP_029671489.1',
  'outer membrane protein',
  1573068,
  1574231,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07430'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07435',
  'WP_000338876.1',
  'CopD family copper resistance protein',
  1574413,
  1574850,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07435'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07440',
  'WP_000650233.1',
  'heavy metal translocating P-type ATPase',
  1574847,
  1577213,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07440'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07445',
  'WP_000375247.1',
  'tRNA1(Val) (adenine(37)-N6)-methyltransferase',
  1577239,
  1577955,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07445'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07450',
  'WP_001242020.1',
  'bifunctionaldiaminohydroxyphosphoribosylaminopyrimidinedeaminase/5-amino-6-(5-phosphoribosylamino)uracilreductase RibD',
  1577937,
  1578971,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07450'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07455',
  'gltS',
  'sodium/glutamate symporter',
  1578968,
  1580194,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07455'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07460',
  'WP_015056101.1',
  'saccharopine dehydrogenase family protein',
  1580280,
  1581479,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07460'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07465',
  'ccoG',
  'cytochrome c oxidase accessory protein CcoG',
  1581489,
  1582865,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07465'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07470',
  'plsY',
  'glycerol-3-phosphate 1-O-acyltransferase PlsY',
  1582971,
  1583633,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07470'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07475',
  'WP_000850887.1',
  'dihydroneopterin aldolase',
  1583630,
  1583983,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07475'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07480',
  'WP_000643733.1',
  'hypothetical protein',
  1583967,
  1584293,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07480'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07485',
  'WP_000945747.1',
  'TonB-dependent receptor',
  1584447,
  1587080,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07485'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07490',
  'WP_001051152.1',
  'aminotransferase class V-fold PLP-dependentenzyme',
  1587307,
  1588467,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07490'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07495',
  'nusA',
  'transcription termination factor NusA',
  1588569,
  1589756,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07495'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07500',
  'WP_000413023.1',
  'hypothetical protein',
  1590109,
  1590648,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07500'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07505',
  'WP_000384831.1',
  'type IIG restriction enzyme/methyltransferase',
  1590649,
  1594488,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07505'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07510',
  'WP_000617669.1',
  'DUF7149 domain-containing protein',
  1594490,
  1594777,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07510'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07515',
  '—',
  'hypothetical protein',
  1594908,
  1597062,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07515'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07520',
  'WP_000693702.1',
  'type III restriction-modification systemendonuclease',
  1597196,
  1600099,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07520'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08190',
  'WP_000990468.1',
  'site-specific DNA-methyltransferase',
  1600102,
  1600689,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08190'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07525',
  'WP_001179835.1',
  'site-specific DNA-methyltransferase',
  1600686,
  1602038,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07525'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07530',
  'recG',
  'ATP-dependent DNA helicase RecG',
  1602088,
  1603959,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07530'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07535',
  'WP_000837022.1',
  'lipoprotein',
  1604041,
  1604388,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07535'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07540',
  'WP_000765634.1',
  'outer membrane protein',
  1604392,
  1605027,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07540'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07545',
  'WP_000767556.1',
  'exodeoxyribonuclease III',
  1605024,
  1605776,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07545'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07550',
  '—',
  '',
  1605878,
  1605953,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07550'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07555',
  'WP_000749005.1',
  'hypothetical protein',
  1605956,
  1607395,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07555'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07560',
  'dnaA',
  'chromosomal replication initiator protein DnaA',
  1607624,
  1608997,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07560'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07565',
  'WP_000923009.1',
  'nucleoside phosphorylase-I family protein',
  1609150,
  1609692,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07565'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07570',
  'WP_000461837.1',
  'DUF2443 domain-containing protein',
  1609735,
  1609974,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07570'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07575',
  'glmS',
  'glutamine--fructose-6-phosphate transaminase(isomerizing)',
  1609975,
  1611768,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07575'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07580',
  'thyX',
  'FAD-dependent thymidylate synthase',
  1611791,
  1612417,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07580'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07905',
  'WP_000624117.1',
  'hypothetical protein',
  1612449,
  1612604,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07905'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07585',
  'WP_000930564.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  1613001,
  1614284,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07585'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07590',
  'tnpA',
  'IS200/IS605 family transposase',
  1614336,
  1614782,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07590'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07595',
  'WP_000506402.1',
  'hypothetical protein',
  1614849,
  1615037,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07595'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07600',
  '—',
  'type II restriction endonuclease',
  1615030,
  1615760,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07600'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07605',
  'WP_000657605.1',
  'cytochrome c1',
  1615878,
  1616735,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07605'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07610',
  'WP_000807891.1',
  'cytochrome b',
  1616732,
  1617970,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07610'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07615',
  'WP_000763654.1',
  'ubiquinol-cytochrome c reductase iron-sulfursubunit',
  1617981,
  1618484,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07615'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07620',
  'mfd',
  'transcription-repair coupling factor',
  1618609,
  1621608,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07620'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07625',
  'WP_025444684.1',
  'polymer-forming cytoskeletal protein',
  1621612,
  1621914,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07625'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07630',
  'csd3',
  'peptidoglycan DD-metalloendopeptidase Csd1',
  1621941,
  1622879,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07630'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07635',
  'WP_001136019.1',
  'M23B family cell shape-determiningDD-metalloendopeptidase Csd2',
  1622888,
  1623814,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07635'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07640',
  'WP_000798455.1',
  'bifunctional folylpolyglutamatesynthase/dihydrofolate synthase',
  1623814,
  1624998,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07640'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07645',
  'lptE',
  'LPS assembly lipoprotein LptE',
  1624988,
  1625500,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07645'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07650',
  'leuS',
  'leucine--tRNA ligase',
  1625497,
  1627917,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07650'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07655',
  'WP_000383778.1',
  'DUF6394 family protein',
  1627927,
  1628265,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07655'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07660',
  'secF',
  'protein translocase subunit SecF',
  1628275,
  1629246,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07660'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07665',
  'secD',
  'protein translocase subunit SecD',
  1629255,
  1630832,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07665'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07670',
  'yajC',
  'preprotein translocase subunit YajC',
  1630829,
  1631212,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07670'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07675',
  'nhaA',
  'sodium/proton antiporter NhaA',
  1631260,
  1632576,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07675'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07680',
  'WP_000380097.1',
  'RecB-like helicase',
  1632600,
  1635437,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07680'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07685',
  'rpsB',
  '30S ribosomal protein S2',
  1635686,
  1636480,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07685'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07690',
  'tsf',
  'translation elongation factor Ts',
  1636480,
  1637547,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07690'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07695',
  'WP_000370329.1',
  'peptidoglycan D,D-transpeptidase FtsI familyprotein',
  1637996,
  1639843,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07695'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07700',
  'WP_080012135.1',
  'transcriptional regulator',
  1639850,
  1639975,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07700'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07705',
  'fliE',
  'flagellar hook-basal body complex protein FliE',
  1639999,
  1640328,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07705'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07710',
  'flgC',
  'flagellar basal body rod protein FlgC',
  1640456,
  1640941,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07710'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07715',
  'flgB',
  'flagellar basal body rod protein FlgB',
  1640954,
  1641376,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07715'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07720',
  'WP_000205898.1',
  'FtsW/RodA/SpoVE family cell cycle protein',
  1641584,
  1642750,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07720'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07725',
  'WP_000961734.1',
  'ABC transporter substrate-binding protein',
  1642774,
  1643781,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07725'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07730',
  'WP_000961773.1',
  'ABC transporter substrate-binding protein',
  1643982,
  1644983,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07730'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07735',
  'WP_000961643.1',
  'peroxiredoxin',
  1645224,
  1645820,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07735'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07740',
  'WP_001862559.1',
  'MetQ/NlpA family ABC transportersubstrate-binding protein',
  1645960,
  1646775,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07740'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07745',
  'mrdA',
  'penicillin-binding protein 2',
  1647268,
  1649034,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07745'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07750',
  'WP_000949882.1',
  'hypothetical protein',
  1649015,
  1649458,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07750'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07755',
  'yihA',
  'ribosome biogenesis GTP-binding proteinYihA/YsxC',
  1649471,
  1650097,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07755'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07760',
  'lptA',
  'lipopolysaccharide transport periplasmic proteinLptA',
  1650094,
  1650645,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07760'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07765',
  'WP_000831002.1',
  'hypothetical protein',
  1650645,
  1651238,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07765'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07770',
  'WP_000593725.1',
  'KdsC family phosphatase',
  1651213,
  1651707,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07770'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07775',
  'WP_000521815.1',
  'septal ring lytic transglycosylase RlpA familyprotein',
  1651704,
  1652651,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07775'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07780',
  'WP_000044457.1',
  'lytic transglycosylase domain-containingprotein',
  1652651,
  1653769,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07780'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07785',
  'WP_000469349.1',
  'TatD family hydrolase',
  1653857,
  1654621,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07785'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07790',
  'ribE',
  'riboflavin synthase',
  1654696,
  1655316,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07790'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07795',
  'WP_001044050.1',
  'FlhB-like flagellar biosynthesis protein',
  1655317,
  1655589,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07795'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07800',
  'WP_000259757.1',
  'methionine ABC transporter ATP-binding protein',
  1655611,
  1656594,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07800'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07805',
  'WP_000625456.1',
  'methionine ABC transporter permease',
  1656596,
  1657243,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07805'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07810',
  'WP_001163406.1',
  'glycosyltransferase family 8 protein',
  1657275,
  1658393,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07810'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07815',
  'WP_000914282.1',
  'hypothetical protein',
  1658442,
  1658870,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07815'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07820',
  'lpxF',
  'lipid A 4''-phosphatase',
  1658880,
  1659476,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07820'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07825',
  'WP_010875640.1',
  'undecaprenylphosphate N-acetylglucosaminyltransferase WecA',
  1659473,
  1660483,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07825'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07830',
  'pdxJ',
  'pyridoxine 5''-phosphate synthase',
  1660610,
  1661398,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07830'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07835',
  'pdxA',
  '4-hydroxythreonine-4-phosphate dehydrogenase',
  1661400,
  1662323,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07835'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07840',
  'tsaD',
  'tRNA(adenosine(37)-N6)-threonylcarbamoyltransferase complextransferase subunit TsaD',
  1662388,
  1663410,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07840'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07845',
  'flgG',
  'flagellar basal-body rod protein FlgG',
  1663590,
  1664378,
  1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07845'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS08195',
  '—',
  'DUF3944 domain-containing protein',
  1664479,
  1665427,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS08195'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07910',
  'WP_000071328.1',
  'hypothetical protein',
  1665805,
  1665945,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07910'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07860',
  'WP_000323695.1',
  'YaaW family protein',
  1666029,
  1666790,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07860'
);

INSERT INTO core_gene (locus_tag, name, description, start, end, strand, gene_type, genome_id)
SELECT
  'HP_RS07865',
  '—',
  'DUF3944 domain-containing protein',
  1667057,
  1667800,
  -1,
  'CDS',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1) AND locus_tag='HP_RS07865'
);

INSERT INTO core_siteinstance (seq, genome_id, start, end, strand)
SELECT
  'AAGATTACATT',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1),
  305482,
  305492,
  1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
    AND start=305482 AND end=305492 AND strand=1
    AND seq='AAGATTACATT'
);

INSERT INTO core_curation_siteinstance
  (site_type, annotated_seq, quantitative_value, TF_type, TF_function, TF_instance_id, curation_id, site_instance_id)
VALUES
  ('variable',
   NULL,
   0,
   'monomer',
   'activator',
   (SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='[object Object]' LIMIT 1),
   (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000915.1' LIMIT 1)
          AND start=305482 AND end=305492 AND strand=1
          AND seq='AAGATTACATT'
        ORDER BY id DESC LIMIT 1));

COMMIT;