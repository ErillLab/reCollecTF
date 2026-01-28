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
wqqwqw',
  1,
  'AcaCD',
  'Synechocystis sp. PCC 6803'
WHERE NOT EXISTS (SELECT 1 FROM core_publication WHERE pmid='37907733');

UPDATE core_publication
SET
  authors = CASE WHEN authors IS NULL OR authors='' THEN 'deCarvalho T, Mascolo E, Caruso SM, López-Pérez J, Weston-Hafer K, Shaffer C, Erill I' ELSE authors END,
  title = CASE WHEN title IS NULL OR title='' THEN 'Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.' ELSE title END,
  journal = CASE WHEN journal IS NULL OR journal='' THEN 'The ISME journal' ELSE journal END,
  publication_date = CASE WHEN publication_date IS NULL OR publication_date='' THEN '2023 Dec' ELSE publication_date END,
  url = CASE WHEN url IS NULL OR url='' THEN 'https://doi.org/10.1038/s41396-023-01548-0' ELSE url END,
  reported_TF = CASE WHEN reported_TF IS NULL OR reported_TF='' THEN 'AcaCD' ELSE reported_TF END,
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN 'Synechocystis sp. PCC 6803' ELSE reported_species END,
  contains_promoter_data = 0,
  contains_expression_data = 0,
  curation_complete = 1,
  submission_notes = CASE
    WHEN submission_notes IS NULL OR submission_notes='' THEN 'Revision reason: No comparable TF protein sequence in NCBI
wqqwqw'
    ELSE submission_notes
  END
WHERE pmid='37907733';

INSERT INTO core_tf (name, family_id, description)
SELECT 'AcaCD', 57, 'AcaCD encoded by the IncC conjugative plasmid pVCR94 of Vibrio cholerae O1 El Tor F1939'
WHERE NOT EXISTS (SELECT 1 FROM core_tf WHERE lower(name)=lower('AcaCD'));

UPDATE core_tf
SET
  family_id = COALESCE(family_id, 57),
  description = COALESCE(NULLIF(description,''), 'AcaCD encoded by the IncC conjugative plasmid pVCR94 of Vibrio cholerae O1 El Tor F1939')
WHERE lower(name)=lower('AcaCD');

INSERT INTO core_tfinstance (refseq_accession, uniprot_accession, description, TF_id, notes)
SELECT
  'WP_002843095',
  'Q0PBE2',
  'transcriptional regulator CmeR [Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819].',
  (SELECT TF_id FROM core_tf WHERE lower(name)=lower('AcaCD') LIMIT 1),
  ''
WHERE NOT EXISTS (SELECT 1 FROM core_tfinstance WHERE uniprot_accession='Q0PBE2');

UPDATE core_tfinstance
SET
  TF_id = COALESCE(TF_id, (SELECT TF_id FROM core_tf WHERE lower(name)=lower('AcaCD') LIMIT 1)),
  refseq_accession = COALESCE(NULLIF(refseq_accession,''), 'WP_002843095'),
  description = COALESCE(NULLIF(description,''), 'transcriptional regulator CmeR [Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819].'),
  notes = COALESCE(notes, '')
WHERE uniprot_accession='Q0PBE2';

INSERT INTO core_curation
  (TF_species, site_species, experimental_process, forms_complex,
   complex_notes, notes, last_modified, curator_id, publication_id, created, validated_by_id, confidence)
VALUES
  ('Synechocystis sp. PCC 6803', 'Synechocystis sp. PCC 6803', NULL,
   0, NULL, 'Revision reason: No comparable TF protein sequence in NCBI
wqqwqw',
   datetime('now'), (SELECT curator_id FROM core_curator ORDER BY curator_id LIMIT 1), (SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1), datetime('now'), NULL, 0);

INSERT INTO core_curation_TF_instances (curation_id, tfinstance_id)
SELECT (SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1), (SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='Q0PBE2' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_curation_TF_instances
  WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1) AND tfinstance_id=(SELECT TF_instance_id FROM core_tfinstance WHERE uniprot_accession='Q0PBE2' LIMIT 1)
);

INSERT INTO core_genome (genome_accession, organism)
SELECT 'NC_000911.1', 'Synechocystis sp. PCC 6803'
WHERE NOT EXISTS (SELECT 1 FROM core_genome WHERE genome_accession='NC_000911.1');

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'ChIP-chip', 'ChIP-chip', NULL, 'ECO:0006007'
WHERE NOT EXISTS (SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0006007');

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT 'AAGATTACATT', (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000911.1' LIMIT 1), 1660120, 1660130, -1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000911.1' LIMIT 1)
    AND start=1660120 AND end=1660130 AND strand=-1
    AND _seq='AAGATTACATT'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000911.1' LIMIT 1)
          AND start=1660120 AND end=1660130 AND strand=-1
          AND _seq='AAGATTACATT'
        ORDER BY site_id DESC LIMIT 1),
   'AAGATTACATT',
   0,
   'variable',
   'activator',
   'monomer');

COMMIT;