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
  'Francisella philomiragia'
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
  reported_species = CASE WHEN reported_species IS NULL OR reported_species='' THEN 'Francisella philomiragia' ELSE reported_species END,
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
  ('Francisella philomiragia', 'Francisella philomiragia', NULL,
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
  'NZ_CP063139.1',
  'Francisella philomiragia',
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM core_genome WHERE genome_accession='NZ_CP063139.1'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491138.1',
  'PDDEXK nuclease domain-containing protein',
  2202,
  3230,
  -1,
  'IMS64_RS09520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09520'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_244972931.1',
  'restriction endonuclease subunit S',
  3336,
  4469,
  -1,
  'IMS64_RS09525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09525'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491139.1',
  'RNA/DNA-binding domain-containing protein',
  4462,
  5838,
  -1,
  'IMS64_RS09530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09530'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491140.1',
  'type I restriction-modification system subunitM',
  5841,
  7790,
  -1,
  'IMS64_RS09535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09535'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491141.1',
  'ParA family protein',
  8052,
  9008,
  1,
  'IMS64_RS09540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09540'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491142.1',
  'ParB/RepB/Spo0J family partition protein',
  9001,
  9864,
  1,
  'IMS64_RS09545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09545'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491143.1',
  'EexN family lipoprotein',
  10029,
  10799,
  1,
  'IMS64_RS09550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09550'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491144.1',
  'hypothetical protein',
  11081,
  11329,
  -1,
  'IMS64_RS09555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09555'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491145.1',
  'hypothetical protein',
  11334,
  11546,
  -1,
  'IMS64_RS09560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09560'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491146.1',
  'HNH endonuclease domain-containing protein',
  11615,
  12667,
  1,
  'IMS64_RS09565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09565'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491147.1',
  'class I SAM-dependent methyltransferase',
  12671,
  13264,
  1,
  'IMS64_RS09570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09570'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491148.1',
  'Y-family DNA polymerase',
  13452,
  14687,
  -1,
  'IMS64_RS09575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09575'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491149.1',
  'LexA family protein',
  14839,
  15483,
  1,
  'IMS64_RS09580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09580'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491150.1',
  'HEPN domain-containing protein',
  15526,
  16197,
  -1,
  'IMS64_RS09585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09585'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491151.1',
  'hypothetical protein',
  16236,
  16424,
  -1,
  'IMS64_RS09590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09590'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491152.1',
  'hypothetical protein',
  16549,
  16722,
  1,
  'IMS64_RS09595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09595'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491153.1',
  'hypothetical protein',
  16747,
  17034,
  -1,
  'IMS64_RS09600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09600'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'tnpA',
  'IS200/IS605 family transposase',
  17361,
  17810,
  1,
  'IMS64_RS09605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09605'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491155.1',
  'RNA-guided endonuclease InsQ/TnpB familyprotein',
  17794,
  18897,
  1,
  'IMS64_RS09610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09610'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491156.1',
  'hypothetical protein',
  18843,
  19763,
  -1,
  'IMS64_RS09615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09615'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491157.1',
  'hypothetical protein',
  19805,
  20389,
  -1,
  'IMS64_RS09620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09620'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491158.1',
  'nuclease-related domain-containing protein',
  20389,
  21870,
  -1,
  'IMS64_RS09625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09625'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491159.1',
  'hypothetical protein',
  21975,
  22466,
  -1,
  'IMS64_RS09630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09630'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491160.1',
  'M48 family metalloprotease',
  22643,
  23512,
  1,
  'IMS64_RS09635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09635'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491161.1',
  'hypothetical protein',
  23537,
  23911,
  -1,
  'IMS64_RS09640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09640'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491162.1',
  'PIN domain-containing protein',
  23930,
  24637,
  -1,
  'IMS64_RS09645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09645'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491163.1',
  'NYN domain-containing protein',
  24781,
  26004,
  1,
  'IMS64_RS09650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09650'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491164.1',
  'hypothetical protein',
  26034,
  26201,
  1,
  'IMS64_RS09655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09655'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491112.1',
  'hypothetical protein',
  26573,
  26782,
  -1,
  'IMS64_RS09660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09660'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491113.1',
  'hypothetical protein',
  26956,
  27180,
  -1,
  'IMS64_RS09665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09665'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491114.1',
  'hypothetical protein',
  27922,
  28170,
  -1,
  'IMS64_RS09670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09670'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491115.1',
  'hypothetical protein',
  28367,
  29050,
  -1,
  'IMS64_RS09675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09675'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491116.1',
  'hypothetical protein',
  29127,
  29789,
  -1,
  'IMS64_RS09680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09680'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491117.1',
  'hypothetical protein',
  29798,
  30145,
  -1,
  'IMS64_RS09685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09685'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491118.1',
  'single-stranded DNA-binding protein',
  30149,
  30613,
  -1,
  'IMS64_RS09690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09690'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491119.1',
  'hypothetical protein',
  30761,
  31372,
  1,
  'IMS64_RS09695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09695'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491120.1',
  'hypothetical protein',
  31373,
  32200,
  1,
  'IMS64_RS09700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09700'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491121.1',
  'hypothetical protein',
  32302,
  32589,
  1,
  'IMS64_RS09705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09705'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_430886732.1',
  'IS256 family transposase',
  32790,
  33986,
  1,
  'IMS64_RS09710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09710'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491123.1',
  'hypothetical protein',
  34147,
  34326,
  -1,
  'IMS64_RS09715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09715'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491124.1',
  'hypothetical protein',
  34397,
  36577,
  -1,
  'IMS64_RS09720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09720'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491125.1',
  'hypothetical protein',
  36577,
  39897,
  -1,
  'IMS64_RS09725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09725'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491126.1',
  'hypothetical protein',
  40018,
  40743,
  1,
  'IMS64_RS09730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09730'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491127.1',
  'hypothetical protein',
  40740,
  40997,
  -1,
  'IMS64_RS09735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09735'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491128.1',
  'AAA family ATPase',
  41150,
  44440,
  -1,
  'IMS64_RS09740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09740'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491129.1',
  'hypothetical protein',
  44798,
  45124,
  1,
  'IMS64_RS09745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09745'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_244972930.1',
  'type II toxin-antitoxin system HipA familytoxin',
  45114,
  46355,
  -1,
  'IMS64_RS09750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09750'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491131.1',
  'helix-turn-helix transcriptional regulator',
  46348,
  46629,
  -1,
  'IMS64_RS09755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09755'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491132.1',
  'Fic family protein',
  46959,
  47708,
  1,
  'IMS64_RS09760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09760'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491133.1',
  'recombinase family protein',
  47701,
  48258,
  1,
  'IMS64_RS09765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09765'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491134.1',
  'Fic family protein',
  48284,
  48961,
  -1,
  'IMS64_RS09770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09770'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491135.1',
  'Fic family protein',
  49187,
  50257,
  -1,
  'IMS64_RS09775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09775'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491136.1',
  'replication initiation protein',
  50436,
  51830,
  -1,
  'IMS64_RS09780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09780'
);

INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  'WP_211491137.1',
  'type I restriction endonuclease subunit R',
  52137,
  53063,
  -1,
  'IMS64_RS09515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1) AND locus_tag='IMS64_RS09515'
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
  '28110',
  'species',
  'Francisella philomiragia',
  (SELECT id FROM core_taxonomy WHERE taxonomy_id='262' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM core_taxonomy WHERE taxonomy_id='28110'
);

UPDATE core_taxonomy
SET
  rank = COALESCE(NULLIF(rank,''), 'species'),
  name = COALESCE(NULLIF(name,''), 'Francisella philomiragia'),
  parent_id = COALESCE(parent_id, (SELECT id FROM core_taxonomy WHERE taxonomy_id='262' LIMIT 1))
WHERE taxonomy_id='28110';

UPDATE core_genome
SET taxonomy_id = (
  SELECT id FROM core_taxonomy WHERE taxonomy_id='28110' LIMIT 1
)
WHERE genome_accession='NZ_CP063139.1';

INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'Motif-discovery', 'Motif-discovery', NULL, 'ECO:0005558'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005558'
);

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
SELECT 'Comparative genomics search', 'Comparative genomics search', NULL, 'ECO:0005622'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0005622'
);

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'GTGTAGTATAATTTCAC',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  14704,
  14720,
  1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
    AND start=14704 AND end=14720 AND strand=1
    AND _seq='GTGTAGTATAATTTCAC'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
        ORDER BY site_id DESC LIMIT 1),
   'GTGTAGTATAATTTCAC',
   0,
   'motif_associated',
   'REP',
   'N/A');

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09575' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09575' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14704 AND end=14720 AND strand=1
          AND _seq='GTGTAGTATAATTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09580' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'inferred',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09580' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'GTGAAGTATTATTTCAC',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1),
  14753,
  14769,
  1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
    AND start=14753 AND end=14769 AND strand=1
    AND _seq='GTGAAGTATTATTTCAC'
);

INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
        ORDER BY site_id DESC LIMIT 1),
   'GTGAAGTATTATTTCAC',
   0,
   'motif_associated',
   'REP',
   'N/A');

INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
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
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09575' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'inferred',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09575' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='42099580' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
          AND start=14753 AND end=14769 AND strand=1
          AND _seq='GTGAAGTATTATTTCAC'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09580' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='IMS64_RS09580' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NZ_CP063139.1' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;

COMMIT;