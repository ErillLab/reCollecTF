PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

INSERT OR IGNORE INTO core_curator (curator_type, username, email)
VALUES ('human', 'webcurator', 'webcurator@example.com');

WITH curator_row AS (
  SELECT curator_id FROM core_curator WHERE username='webcurator' LIMIT 1
)
SELECT curator_id FROM curator_row;

INSERT OR IGNORE INTO core_publication
(pmid, title, authors, journal, publication_date,
 curation_complete, requires_revision, contains_promoter_data, contains_expression_data,
 revision_reason, notes)
VALUES
(37907733,
 'Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.',
 'deCarvalho T, Mascolo E, Caruso SM, López-Pérez J, Weston-Hafer K, Shaffer C, Erill I',
 'The ISME journal',
 '2023 Dec',
 1,
 1,
 0,
 0,
 'No comparable TF protein sequence in NCBI',
 'pruebaaa'
);

SELECT publication_id FROM core_publication
WHERE
  (37907733 IS NOT NULL AND pmid = 37907733)
  OR
  (37907733 IS NULL AND title='Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.' AND journal='The ISME journal' AND publication_date='2023 Dec')
ORDER BY publication_id DESC
LIMIT 1;

INSERT OR IGNORE INTO core_tf (name, family_id, description)
VALUES ('FIS', 30, 'The eponymous member of the FIS family, the Factor for Inversion Stimulation was first identified in the Mu phage of Escherichia coli [PMID::3536909]. FIS is a small nucleotide-assocaited protein involved in multiple processes, such as chromosomal replication and structure. It is a global regulator that activates ribosomal-associated transcription in E. coli and it is known to self-regulate by means of 6 high affinity binding sites in its promoter region, which it binds as dimers. It is also involved in virulence regulation in Pasteurella multocida [PMID::20140235].');

UPDATE core_tf
SET
  family_id = COALESCE(family_id, 30),
  description = CASE
    WHEN description IS NULL OR description='' THEN 'The eponymous member of the FIS family, the Factor for Inversion Stimulation was first identified in the Mu phage of Escherichia coli [PMID::3536909]. FIS is a small nucleotide-assocaited protein involved in multiple processes, such as chromosomal replication and structure. It is a global regulator that activates ribosomal-associated transcription in E. coli and it is known to self-regulate by means of 6 high affinity binding sites in its promoter region, which it binds as dimers. It is also involved in virulence regulation in Pasteurella multocida [PMID::20140235].'
    ELSE description
  END
WHERE lower(name)=lower('FIS');

INSERT OR IGNORE INTO core_tfinstance (tf_id, uniprot_id, refseq_id, description, notes)
VALUES (
  (SELECT tf_id FROM core_tf WHERE lower(name)=lower('FIS') LIMIT 1),
  'UNKNOWN',
  'UNKNOWN',
  'pruebaaa',
  'pruebaaa'
);

INSERT INTO core_curation
(TF_species, site_species, experimental_process, forms_complex, complex_notes, notes, publication_id, curator_id)
VALUES
('Unknown',
 'Unknown',
 'manual',
 0,
 '',
 'pruebaaa',
 (
   SELECT publication_id FROM core_publication
   WHERE
     (37907733 IS NOT NULL AND pmid = 37907733)
     OR
     (37907733 IS NULL AND title='Simultaneous entry as an adaptation to virulence in a novel satellite-helper system infecting Streptomyces species.' AND journal='The ISME journal' AND publication_date='2023 Dec')
   ORDER BY publication_id DESC
   LIMIT 1
 ),
 (SELECT curator_id FROM core_curator WHERE username='webcurator' LIMIT 1)
);

SELECT curation_id FROM core_curation
ORDER BY curation_id DESC
LIMIT 1;

INSERT OR IGNORE INTO core_genome (genome_id, genome_accession, genome_dna_accession, genome_taxon_id, organism)
VALUES ('NC_000921.1', 'NC_000921.1', 'NC_000921.1', '', 'Unknown');

INSERT OR IGNORE INTO core_experimentaltechnique (name, category, EO_term, description)
VALUES ('Comparative genomics search', 'binding', 'ECO:0005622', '');

INSERT OR IGNORE INTO core_siteinstance (_seq, start, end, strand, genome_id)
VALUES ('AATGTAATCTT', 570670, 570680, -1, 'NC_000921.1');

INSERT INTO core_curation_siteinstance
(TF_type, TF_function, qval, creation_date, last_update, is_high_throughput, is_sig, significance_notes, site_instance_id, curation_id)
VALUES
('monomer',
 'activator',
 NULL,
 datetime('now'),
 datetime('now'),
 0,
 0,
 '',
 (SELECT site_instance_id FROM core_siteinstance
  WHERE genome_id='NC_000921.1' AND start=570670 AND end=570680 AND strand=-1 AND _seq='AATGTAATCTT'
  ORDER BY site_instance_id DESC
  LIMIT 1
 ),
 (SELECT curation_id FROM core_curation ORDER BY curation_id DESC LIMIT 1)
);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02700', 'NC_000921.1', 'WP_000188557.1', 'radical SAM/SPASM domain-containing protein', 563901, 564773, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02705', 'NC_000921.1', 'ychF', 'redox-regulated ATPase YchF', 564812, 565912, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02710', 'NC_000921.1', 'WP_000912895.1', 'leucyl aminopeptidase', 565914, 567404, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02715', 'NC_000921.1', 'WP_000393392.1', 'DedA family protein', 567452, 568030, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02720', 'NC_000921.1', 'apt', 'adenine phosphoribosyltransferase', 568045, 568584, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02725', 'NC_000921.1', 'WP_000495098.1', 'hypothetical protein', 568645, 568977, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02730', 'NC_000921.1', 'rpiB', 'ribose 5-phosphate isomerase B', 569028, 569483, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02735', 'NC_000921.1', 'WP_001159409.1', 'site-2 protease family protein', 569502, 570200, -1);

INSERT OR IGNORE INTO core_gene
(locus_tag, genome_id, name, description, start, end, strand)
VALUES
('JHP_RS02740', 'NC_000921.1', 'lepB', 'signal peptidase I', 570209, 571081, -1);

COMMIT;