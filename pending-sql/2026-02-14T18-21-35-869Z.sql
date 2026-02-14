PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dolP',
  'division and outer membrane stress-associatedlipid-binding lipoprotein',
  3296409,
  3296984,
  1,
  'b3150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3150'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraQ',
  'permease family protein YraQ',
  3297098,
  3298138,
  -1,
  'b3151',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3151'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraR',
  'putative nucleoside-diphosphate-sugar epimerase',
  3298211,
  3298846,
  -1,
  'b3152',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3152'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbO',
  'protein/nucleic acid deglycase 2',
  3298974,
  3299492,
  1,
  'b3153',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3153'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbP',
  'putative FMN binding protein YhbP',
  3299472,
  3299915,
  -1,
  'b3154',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3154'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbQ',
  'DNA damage response nuclease YhbQ',
  3299966,
  3300268,
  1,
  'b3155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3155'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbS',
  'putative N-acetyltransferase YhbS',
  3300255,
  3300758,
  -1,
  'b3156',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3156'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiT',
  'anaerobic ubiquinone biosynthesis accessoryfactor UbiT',
  3300752,
  3301276,
  -1,
  'b3157',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3157'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiU',
  'ubiquinone biosynthesis protein UbiU',
  3301485,
  3302480,
  1,
  'b3158',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3158'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiV',
  'ubiquinone biosynthesis protein UbiV',
  3302489,
  3303367,
  1,
  'b3159',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3159'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbW',
  'putative luciferase-like monooxygenase YhbW',
  3303448,
  3304455,
  1,
  'b3160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3160'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mtr',
  'tryptophan:H(+) symporter Mtr',
  3304573,
  3305817,
  -1,
  'b3161',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3161'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'deaD',
  'ATP-dependent RNA helicase DeaD',
  3305971,
  3307860,
  -1,
  'b3162',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3162'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrbN',
  'uncharacterized protein YrbN',
  3307853,
  3307933,
  -1,
  'b4685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4685'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nlpI',
  'lipoprotein NlpI',
  3308040,
  3308924,
  -1,
  'b3163',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3163'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pnp',
  'polynucleotide phosphorylase',
  3309033,
  3311168,
  -1,
  'b3164',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3164'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sraG',
  '—',
  3311183,
  3311398,
  1,
  'b4449',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4449'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsO',
  '30S ribosomal subunit protein S15',
  3311415,
  3311684,
  -1,
  'b3165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3165'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'truB',
  'tRNA pseudouridine(55) synthase',
  3311833,
  3312777,
  -1,
  'b3166',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3166'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbfA',
  '30S ribosome binding factor',
  3312777,
  3313178,
  -1,
  'b3167',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3167'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'infB',
  'translation initiation factor IF-2beta''',
  3313342,
  3316014,
  -1,
  'b3168',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3168'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nusA',
  'transcription termination/antiterminationprotein NusA',
  3316039,
  3317526,
  -1,
  'b3169',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3169'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rimP',
  'ribosome maturation factor RimP',
  3317554,
  3318006,
  -1,
  'b3170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3170'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metY',
  '—',
  3318213,
  3318289,
  -1,
  'b3171',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3171'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argG',
  'argininosuccinate synthetase',
  3318637,
  3319980,
  1,
  'b3172',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3172'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbX',
  'putative hydrolase YhbX',
  3319988,
  3321613,
  -1,
  'b3173',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3173'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuU',
  '—',
  3322072,
  3322158,
  -1,
  'b3174',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3174'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'secG',
  'Sec translocon subunit SecG',
  3322173,
  3322505,
  -1,
  'b3175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3175'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glmM',
  'phosphoglucosamine mutase',
  3322733,
  3324070,
  -1,
  'b3176',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3176'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'folP',
  'dihydropteroate synthase',
  3324063,
  3324911,
  -1,
  'b3177',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3177'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsH',
  'ATP-dependent zinc metalloprotease FtsH',
  3325001,
  3326935,
  -1,
  'b3178',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3178'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmE',
  '23S rRNA 2''-O-ribose U2552 methyltransferase',
  3327035,
  3327664,
  -1,
  'b3179',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3179'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbY',
  'ribosome assembly factor YhbY',
  3327790,
  3328083,
  1,
  'b3180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3180'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'greA',
  'transcription elongation factor GreA',
  3328239,
  3328715,
  -1,
  'b3181',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3181'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dacB',
  'peptidoglycan DD-endopeptidase DacB',
  3328963,
  3330396,
  1,
  'b3182',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3182'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'obgE',
  'GTPase ObgE',
  3330582,
  3331754,
  -1,
  'b3183',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3183'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhbE',
  'putative transporter YhbE',
  3331770,
  3332735,
  -1,
  'b3184',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3184'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmA',
  '50S ribosomal subunit protein L27',
  3332862,
  3333119,
  -1,
  'b3185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3185'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplU',
  '50S ribosomal subunit protein L21',
  3333140,
  3333451,
  -1,
  'b3186',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3186'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ispB',
  'all-trans-octaprenyl-diphosphate synthase',
  3333710,
  3334681,
  1,
  'b3187',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3187'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sfsB',
  'putative transcriptional regulator SfsB',
  3334909,
  3335187,
  1,
  'b3188',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3188'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'murA',
  'UDP-N-acetylglucosamine1-carboxyvinyltransferase',
  3335235,
  3336494,
  -1,
  'b3189',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3189'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibaG',
  'acid stress protein IbaG',
  3336549,
  3336803,
  -1,
  'b3190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3190'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlaB',
  'intermembrane phospholipid transport systemprotein MlaB',
  3336963,
  3337256,
  -1,
  'b3191',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3191'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlaC',
  'intermembrane phospholipid transport system -periplasmic binding protein',
  3337256,
  3337891,
  -1,
  'b3192',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3192'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlaD',
  'intermembrane phospholipid transport system,substrate binding protein MlaD',
  3337910,
  3338461,
  -1,
  'b3193',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3193'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlaE',
  'intermembrane phospholipid transport system,integral membrane subunit MlaE',
  3338466,
  3339248,
  -1,
  'b3194',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3194'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlaF',
  'intermembrane phospholipid transport system, ATPbinding subunit MlaF',
  3339256,
  3340065,
  -1,
  'b3195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3195'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrbG',
  'putative transport protein YrbG',
  3340275,
  3341252,
  1,
  'b3196',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3196'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kdsD',
  'D-arabinose 5-phosphate isomerase KdsD',
  3341266,
  3342252,
  1,
  'b3197',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3197'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kdsC',
  '3-deoxy-D-manno-octulosonate 8-phosphatephosphatase KdsC',
  3342273,
  3342839,
  1,
  'b3198',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3198'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lptC',
  'lipopolysaccharide transport system proteinLptC',
  3342836,
  3343411,
  1,
  'b3199',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3199'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lptA',
  'lipopolysaccharide transport system proteinLptA',
  3343380,
  3343937,
  1,
  'b3200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3200'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lptB',
  'lipopolysaccharide transport system ATP bindingprotein LptB',
  3343944,
  3344669,
  1,
  'b3201',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3201'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoN',
  'RNA polymerase sigma factor RpoN',
  3344717,
  3346150,
  1,
  'b3202',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3202'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hpf',
  'ribosome hibernation-promoting factor',
  3346173,
  3346460,
  1,
  'b3203',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3203'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptsN',
  'phosphotransferase system enzyme IIA(Ntr)',
  3346578,
  3347069,
  1,
  'b3204',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3204'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rapZ',
  'RNase adaptor protein RapZ',
  3347115,
  3347969,
  1,
  'b3205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3205'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'npr',
  'phosphorelay protein NPr',
  3347966,
  3348238,
  1,
  'b3206',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3206'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrbL',
  'protein kinase-like domain-containing proteinYrbL',
  3348452,
  3349084,
  1,
  'b3207',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3207'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mtgA',
  'peptidoglycan glycosyltransferase MtgA',
  3349081,
  3349809,
  -1,
  'b3208',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3208'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'elbB',
  'low activity glyoxalase ElbB',
  3349806,
  3350459,
  -1,
  'b3209',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3209'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arcZ',
  '—',
  3350577,
  3350697,
  1,
  'b4450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4450'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arcB',
  'sensor histidine kinase ArcB',
  3350689,
  3353025,
  -1,
  'b3210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3210'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcC',
  'radical SAM family oxidoreductase YhcC',
  3353121,
  3354050,
  -1,
  'b3211',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3211'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltB',
  'glutamate synthase subunit GltB',
  3354725,
  3359185,
  1,
  'b3212',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3212'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltD',
  'glutamate synthase subunit GltD',
  3359198,
  3360616,
  1,
  'b3213',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3213'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltF',
  'periplasmic protein GltF',
  3361176,
  3361940,
  1,
  'b3214',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3214'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcA',
  'putative fimbrial chaperone YhcA',
  3362112,
  3362786,
  1,
  'b3215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3215'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcD',
  'putative fimbrial usher protein YhcD',
  3362807,
  3365188,
  1,
  'b3216',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3216'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcE',
  'putative uncharacterized protein YhcE',
  3365185,
  3366929,
  1,
  'b4569',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4569'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH10',
  'IS5 transposase and trans-activator',
  3365702,
  3366682,
  -1,
  'b3218',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3218'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcF',
  'DUF1120 domain-containing protein YhcF',
  3366926,
  3367642,
  1,
  'b3219',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3219'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcG',
  'DUF1016 domain-containing protein YhcG',
  3367827,
  3368954,
  1,
  'b3220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3220'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanQ',
  'N-acetylneuraminate anomerase',
  3369014,
  3369478,
  -1,
  'b3221',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3221'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanK',
  'N-acetylmannosamine kinase',
  3369475,
  3370350,
  -1,
  'b3222',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3222'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanE',
  'putative N-acetylmannosamine-6-phosphate2-epimerase',
  3370347,
  3371036,
  -1,
  'b3223',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3223'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanT',
  'N-acetylneuraminate:H(+) symporter',
  3371084,
  3372574,
  -1,
  'b3224',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3224'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanA',
  'N-acetylneuraminate lyase',
  3372683,
  3373576,
  -1,
  'b3225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3225'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanR',
  'DNA-binding transcriptional dual regulator NanR',
  3373698,
  3374489,
  -1,
  'b3226',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3226'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcuD',
  'putative transporter DcuD',
  3374869,
  3376236,
  1,
  'b3227',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3227'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sspB',
  'ClpXP protease specificity-enhancing factor',
  3376279,
  3376776,
  -1,
  'b3228',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3228'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sspA',
  'stringent starvation protein A',
  3376782,
  3377420,
  -1,
  'b3229',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3229'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsI',
  '30S ribosomal subunit protein S9',
  3377815,
  3378207,
  -1,
  'b3230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3230'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplM',
  '50S ribosomal subunit protein L13',
  3378223,
  3378651,
  -1,
  'b3231',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3231'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zapE',
  'cell division protein ZapE',
  3378870,
  3379997,
  -1,
  'b3232',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3232'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcB',
  'inner membrane protein YhcB',
  3380191,
  3380589,
  1,
  'b3233',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3233'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'degQ',
  'periplasmic serine endoprotease',
  3380743,
  3382110,
  1,
  'b3234',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3234'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'degS',
  'serine endoprotease',
  3382200,
  3383267,
  1,
  'b3235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3235'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdh',
  'malate dehydrogenase',
  3383330,
  3384268,
  -1,
  'b3236',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3236'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argR',
  'DNA-binding transcriptional dual regulator ArgR',
  3384703,
  3385173,
  1,
  'b3237',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3237'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcN',
  'DUF1471 domain-containing stress-induced proteinYhcN',
  3385538,
  3385801,
  1,
  'b3238',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3238'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhcO',
  'putative barnase inhibitor',
  3385857,
  3386129,
  -1,
  'b3239',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3239'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aaeB',
  'aromatic carboxylic acid efflux pump subunitAaeB',
  3386221,
  3388188,
  -1,
  'b3240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3240'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aaeA',
  'aromatic carboxylic acid efflux pump membranefusion protein',
  3388194,
  3389126,
  -1,
  'b3241',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3241'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aaeX',
  'DUF1656 domain-containing protein AaeX',
  3389134,
  3389337,
  -1,
  'b3242',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3242'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aaeR',
  'DNA-binding transcriptional activator AaeR',
  3389520,
  3390449,
  1,
  'b3243',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3243'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tldD',
  'metalloprotease subunit TldD',
  3390583,
  3392028,
  -1,
  'b3244',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3244'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdP',
  'phospholipid transport factor YhdP',
  3392458,
  3396258,
  -1,
  'b4472',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4472'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rng',
  'RNase G',
  3396326,
  3397795,
  -1,
  'b3247',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3247'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdE',
  'nucleoside triphosphate pyrophosphatase YhdE',
  3397785,
  3398378,
  -1,
  'b3248',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3248'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mreD',
  'cell shape determining protein MreD',
  3398387,
  3398875,
  -1,
  'b3249',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3249'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mreC',
  'cell shape determining protein MreC',
  3398875,
  3399978,
  -1,
  'b3250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3250'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mreB',
  'dynamic cytoskeletal protein MreB',
  3400044,
  3401087,
  -1,
  'b3251',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3251'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csrD',
  'regulator of CsrB and CsrC decay',
  3401392,
  3403332,
  -1,
  'b3252',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3252'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdH',
  'acrylyl-CoA reductase',
  3403484,
  3404458,
  1,
  'b3253',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3253'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrdF',
  '—',
  3404495,
  3404637,
  1,
  'b4697',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4697'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrdE',
  '—',
  3404638,
  3405031,
  1,
  'b4646',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4646'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'accB',
  'biotin carboxyl carrier protein',
  3405436,
  3405906,
  1,
  'b3255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3255'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'accC',
  'biotin carboxylase',
  3405917,
  3407266,
  1,
  'b3256',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3256'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdT',
  'DUF997 domain-containing protein YhdT',
  3407375,
  3407617,
  1,
  'b3257',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3257'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'panF',
  'pantothenate:Na(+) symporter',
  3407607,
  3409058,
  1,
  'b3258',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3258'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prmA',
  'ribosomal protein L11 methyltransferase',
  3409070,
  3409951,
  1,
  'b3259',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3259'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dusB',
  'tRNA-dihydrouridine synthase B',
  3410280,
  3411245,
  1,
  'b3260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3260'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fis',
  'DNA-binding transcriptional dual regulator Fis',
  3411271,
  3411567,
  1,
  'b3261',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3261'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdJ',
  'DNA adenine methyltransferase',
  3411653,
  3412537,
  1,
  'b3262',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3262'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdU',
  'DUF2556 domain-containing protein YhdU',
  3412621,
  3412800,
  1,
  'b3263',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3263'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'envR',
  'DNA-binding transcriptional repressor EnvR',
  3412803,
  3413465,
  -1,
  'b3264',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3264'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acrE',
  'multidrug efflux pump membrane fusionlipoprotein AcrE',
  3413864,
  3415021,
  1,
  'b3265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3265'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acrF',
  'multidrug efflux pump RND permease AcrF',
  3415033,
  3418137,
  1,
  'b3266',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3266'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdV',
  'lipoprotein YhdV',
  3418390,
  3418611,
  1,
  'b3267',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3267'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdW',
  '—',
  3419042,
  3420066,
  1,
  'b3268',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3268'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdX',
  'putative ABC transporter membrane subunit YhdX',
  3420134,
  3421315,
  1,
  'b3269',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3269'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdY',
  'putative ABC transporter membrane subunit YhdY',
  3421325,
  3422428,
  1,
  'b3270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3270'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdZ',
  'putative ABC transporter ATP-binding subunitYhdZ',
  3422436,
  3423194,
  1,
  'b3271',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3271'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfF',
  '—',
  3423423,
  3423542,
  -1,
  'b3272',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3272'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thrV',
  '—',
  3423580,
  3423655,
  -1,
  'b3273',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3273'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfD',
  '—',
  3423668,
  3423787,
  -1,
  'b3274',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3274'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrlD',
  '—',
  3423880,
  3426783,
  -1,
  'b3275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3275'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaU',
  '—',
  3426958,
  3427033,
  -1,
  'b3276',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3276'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ileU',
  '—',
  3427076,
  3427152,
  -1,
  'b3277',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3277'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrsD',
  '—',
  3427221,
  3428762,
  -1,
  'b3278',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3278'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrdA',
  'hexapeptide repeat-containing protein YrdA',
  3429236,
  3429790,
  1,
  'b3279',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3279'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrdB',
  'DUF1488 domain-containing protein YrdB',
  3429766,
  3430023,
  -1,
  'b3280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3280'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroE',
  'shikimate dehydrogenase',
  3430020,
  3430838,
  -1,
  'b3281',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3281'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsaC',
  'L-threonylcarbamoyladenylate synthase',
  3430843,
  3431415,
  -1,
  'b3282',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3282'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrdD',
  'putative DNA topoisomerase',
  3431420,
  3431962,
  -1,
  'b3283',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3283'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'smg',
  'DUF494 domain-containing protein Smg',
  3431991,
  3432464,
  -1,
  'b3284',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3284'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'smf',
  'protein Smf',
  3432436,
  3433560,
  -1,
  'b4473',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4473'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'def',
  'peptide deformylase',
  3433690,
  3434199,
  1,
  'b3287',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3287'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fmt',
  '10-formyltetrahydrofolate:L-methionyl-tRNA(fMet)N-formyltransferase',
  3434214,
  3435161,
  1,
  'b3288',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3288'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmB',
  '16S rRNA m(5)C967 methyltransferase',
  3435207,
  3436496,
  1,
  'b3289',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3289'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trkA',
  'NAD-binding component of Trk potassiumtransporters',
  3436518,
  3437894,
  1,
  'b3290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3290'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mscL',
  'large conductance mechanosensitive channel',
  3438024,
  3438434,
  1,
  'b3291',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3291'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arfA',
  'alternative ribosome-rescue factor A',
  3438431,
  3438649,
  -1,
  'b4550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4550'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrdG',
  '—',
  3438431,
  3438484,
  -1,
  'b4846',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4846'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zntR',
  'DNA-binding transcriptional activator ZntR',
  3438705,
  3439130,
  -1,
  'b3292',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3292'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhdN',
  'DUF1992 domain-containing protein YhdN',
  3439141,
  3439509,
  -1,
  'b3293',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3293'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplQ',
  '50S ribosomal subunit protein L17',
  3439616,
  3439999,
  -1,
  'b3294',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3294'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoA',
  'RNA polymerase subunit alpha',
  3440040,
  3441029,
  -1,
  'b3295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3295'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsD',
  '30S ribosomal subunit protein S4',
  3441055,
  3441675,
  -1,
  'b3296',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3296'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsK',
  '30S ribosomal subunit protein S11',
  3441709,
  3442098,
  -1,
  'b3297',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3297'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsM',
  '30S ribosomal subunit protein S13',
  3442115,
  3442471,
  -1,
  'b3298',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3298'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmJ',
  '50S ribosomal subunit protein L36',
  3442618,
  3442734,
  -1,
  'b3299',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3299'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'secY',
  'Sec translocon subunit SecY',
  3442766,
  3444097,
  -1,
  'b3300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3300'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplO',
  '50S ribosomal subunit protein L15',
  3444105,
  3444539,
  -1,
  'b3301',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3301'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmD',
  '50S ribosomal subunit protein L30',
  3444543,
  3444722,
  -1,
  'b3302',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3302'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsE',
  '30S ribosomal subunit protein S5',
  3444726,
  3445229,
  -1,
  'b3303',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3303'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplR',
  '50S ribosomal subunit protein L18',
  3445244,
  3445597,
  -1,
  'b3304',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3304'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplF',
  '50S ribosomal subunit protein L6',
  3445607,
  3446140,
  -1,
  'b3305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3305'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsH',
  '30S ribosomal subunit protein S8',
  3446153,
  3446545,
  -1,
  'b3306',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3306'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsN',
  '30S ribosomal subunit protein S14',
  3446579,
  3446884,
  -1,
  'b3307',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3307'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplE',
  '50S ribosomal subunit protein L5',
  3446899,
  3447438,
  -1,
  'b3308',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3308'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplX',
  '50S ribosomal subunit protein L24',
  3447453,
  3447767,
  -1,
  'b3309',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3309'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplN',
  '50S ribosomal subunit protein L14',
  3447778,
  3448149,
  -1,
  'b3310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3310'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsQ',
  '30S ribosomal subunit protein S17',
  3448314,
  3448568,
  -1,
  'b3311',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3311'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmC',
  '50S ribosomal subunit protein L29',
  3448568,
  3448759,
  -1,
  'b3312',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3312'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplP',
  '50S ribosomal subunit protein L16',
  3448759,
  3449169,
  -1,
  'b3313',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3313'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsC',
  '30S ribosomal subunit protein S3',
  3449182,
  3449883,
  -1,
  'b3314',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3314'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplV',
  '50S ribosomal subunit protein L22',
  3449901,
  3450233,
  -1,
  'b3315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3315'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsS',
  '30S ribosomal subunit protein S19',
  3450248,
  3450526,
  -1,
  'b3316',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3316'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplB',
  '50S ribosomal subunit protein L2',
  3450543,
  3451364,
  -1,
  'b3317',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3317'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplW',
  '50S ribosomal subunit protein L23',
  3451382,
  3451684,
  -1,
  'b3318',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3318'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplD',
  '50S ribosomal subunit protein L4',
  3451681,
  3452286,
  -1,
  'b3319',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3319'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplC',
  '50S ribosomal subunit protein L3',
  3452297,
  3452926,
  -1,
  'b3320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3320'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsJ',
  '30S ribosomal subunit protein S10',
  3452959,
  3453270,
  -1,
  'b3321',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3321'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspB',
  'cryptic type II secretion system protein GspB',
  3453508,
  3453927,
  -1,
  'b3322',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3322'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspA',
  'cryptic type II secretion system protein GspA',
  3453929,
  3455398,
  -1,
  'b3323',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3323'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspC',
  'cryptic type II secretion system protein GspC',
  3455578,
  3456393,
  1,
  'b3324',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3324'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspD',
  'cryptic type II secretion system secretinGspDalpha',
  3456377,
  3458329,
  1,
  'b3325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3325'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspE',
  'cryptic type II secretion system ATPase GspE',
  3458339,
  3459820,
  1,
  'b3326',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3326'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspF',
  'cryptic type II secretion system protein GspF',
  3459817,
  3461013,
  1,
  'b3327',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3327'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspG',
  'cryptic type II secretion system majorpseudopilin GspG',
  3461023,
  3461460,
  1,
  'b3328',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3328'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspH',
  'cryptic type II secretion system minorpseudopilin GspH',
  3461468,
  3461977,
  1,
  'b3329',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3329'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspI',
  'cryptic type II secretion system minorpseudopilin GspI',
  3461974,
  3462351,
  1,
  'b3330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3330'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspJ',
  'cryptic type II secretion system minorpseudopilin GspJ',
  3462344,
  3462931,
  1,
  'b3331',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3331'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspK',
  'cryptic type II secretion system minorpseudopilin GspK',
  3462924,
  3463907,
  1,
  'b3332',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3332'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspL',
  'cryptic type II secretion system protein GspL',
  3463922,
  3465085,
  1,
  'b3333',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3333'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspM',
  'cryptic type II secretion system protein GspM',
  3465082,
  3465543,
  1,
  'b3334',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3334'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gspO',
  'cryptic type II secretion system prepilinpeptidase',
  3465543,
  3466220,
  1,
  'b3335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3335'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bfr',
  'bacterioferritin',
  3466249,
  3466725,
  -1,
  'b3336',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3336'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bfd',
  'bacterioferritin-associated ferredoxin',
  3466797,
  3466991,
  -1,
  'b3337',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3337'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chiA',
  'endochitinase',
  3467160,
  3469853,
  -1,
  'b3338',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3338'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tufA',
  'translation elongation factor Tu 1',
  3470145,
  3471329,
  -1,
  'b3339',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3339'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fusA',
  'elongation factor G',
  3471400,
  3473514,
  -1,
  'b3340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3340'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsG',
  '30S ribosomal subunit protein S7',
  3473542,
  3474081,
  -1,
  'b3341',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3341'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsL',
  '30S ribosomal subunit protein S12',
  3474178,
  3474552,
  -1,
  'b3342',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3342'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tusB',
  'sulfurtransferase complex subunit TusB',
  3474678,
  3474965,
  -1,
  'b3343',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3343'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tusC',
  'sulfurtransferase complex subunit TusC',
  3474973,
  3475332,
  -1,
  'b3344',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3344'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tusD',
  'sulfurtransferase complex subunit TusD',
  3475332,
  3475718,
  -1,
  'b3345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3345'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yheO',
  'DNA-binding transcriptional regulator YheO',
  3475718,
  3476440,
  -1,
  'b3346',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3346'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fkpA',
  'peptidyl-prolyl cis-trans isomerase/OMPchaperone FkpA',
  3476607,
  3477419,
  -1,
  'b3347',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3347'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slyX',
  'protein SlyX',
  3477640,
  3477858,
  1,
  'b3348',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3348'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slyD',
  'FKBP-type peptidyl-prolyl cis-trans isomeraseSlyD',
  3477907,
  3478497,
  -1,
  'b3349',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3349'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yheV',
  'DUF2387 domain-containing protein YheV',
  3478592,
  3478792,
  -1,
  'b4551',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4551'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kefB',
  'K(+) : H(+) antiporter KefB',
  3478802,
  3480607,
  -1,
  'b3350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3350'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kefG',
  'glutathione-regulated potassium-efflux systemancillary protein KefG',
  3480607,
  3481161,
  -1,
  'b3351',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3351'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yheS',
  'putative ATP-binding protein YheS',
  3481289,
  3483202,
  1,
  'b3352',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3352'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yheT',
  'putative hydrolase YheT',
  3483202,
  3484224,
  1,
  'b3353',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3353'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yheU',
  'PF06794 family protein YheU',
  3484218,
  3484436,
  1,
  'b3354',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3354'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prkB',
  'putative phosphoribulokinase',
  3484490,
  3485359,
  1,
  'b3355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3355'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfA',
  'OsmC family protein YhfA',
  3485414,
  3485818,
  -1,
  'b3356',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3356'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ascrp',
  '—',
  3485953,
  3486231,
  -1,
  'b4841',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4841'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'crp',
  'DNA-binding transcriptional dual regulator CRP',
  3486120,
  3486752,
  1,
  'b3357',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3357'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfK',
  'putative transporter YhfK',
  3486791,
  3488893,
  1,
  'b3358',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3358'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argD',
  'N-acetylornithineaminotransferase/N-succinyldiaminopimelateaminotransferase',
  3488960,
  3490180,
  -1,
  'b3359',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3359'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrfJ',
  'protein YrfJ',
  3490132,
  3490185,
  -1,
  'b4820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4820'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pabA',
  'aminodeoxychorismate synthase subunit 2',
  3490266,
  3490829,
  -1,
  'b3360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3360'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fic',
  'putative adenosine monophosphate--proteintransferase Fic',
  3490861,
  3491463,
  -1,
  'b3361',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3361'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfG',
  'DUF2559 domain-containing protein YhfG',
  3491453,
  3491620,
  -1,
  'b3362',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3362'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppiA',
  'peptidyl-prolyl cis-trans isomerase A',
  3491725,
  3492297,
  -1,
  'b3363',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3363'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsgA',
  'putative transporter TsgA',
  3492568,
  3493749,
  1,
  'b3364',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3364'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nirB',
  'nitrite reductase (NADH) large subunit',
  3494011,
  3496554,
  1,
  'b3365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3365'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nirD',
  'nitrite reductase (NADH) small subunit',
  3496551,
  3496877,
  1,
  'b3366',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3366'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nirC',
  'nitrite transporter NirC',
  3497003,
  3497809,
  1,
  'b3367',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3367'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysG',
  'siroheme synthase',
  3497828,
  3499201,
  1,
  'b3368',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3368'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfL',
  'DUF4223 domain-containing lipoprotein YhfL',
  3499448,
  3499615,
  1,
  'b3369',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3369'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frlA',
  'fructoselysine/psicoselysine transporter',
  3499910,
  3501247,
  1,
  'b3370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3370'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frlB',
  'fructoselysine 6-phosphate deglycase',
  3501268,
  3502290,
  1,
  'b3371',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3371'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frlC',
  'fructoselysine 3-epimerase',
  3502340,
  3503170,
  1,
  'b4474',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4474'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frlD',
  'fructoselysine 6-kinase',
  3503167,
  3503952,
  1,
  'b3374',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3374'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frlR',
  'DNA-binding transcriptional regulator FrlR',
  3504052,
  3504783,
  1,
  'b3375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3375'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfS',
  'putative aminotransferase YhfS',
  3504935,
  3506020,
  -1,
  'b3376',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3376'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfT',
  'uncharacterized protein YhfT',
  3506032,
  3507336,
  -1,
  'b3377',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3377'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfU',
  'DUF2620 domain-containing protein YhfU',
  3507348,
  3507701,
  -1,
  'b3378',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3378'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'php',
  'putative hydrolase',
  3507712,
  3508590,
  -1,
  'b3379',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3379'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfW',
  'putative mutase YhfW',
  3508587,
  3509813,
  -1,
  'b3380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3380'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfX',
  'putative PLP-binding protein YhfX',
  3509813,
  3510976,
  -1,
  'b3381',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3381'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfY',
  'PRD domain-containing protein YhfY',
  3511060,
  3511422,
  -1,
  'b3382',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3382'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhfZ',
  'putative DNA-binding transcriptional regulatorYhfZ',
  3511439,
  3512344,
  -1,
  'b3383',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3383'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpS',
  'tryptophan--tRNA ligase',
  3512634,
  3513638,
  -1,
  'b3384',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3384'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gph',
  'phosphoglycolate phosphatase',
  3513631,
  3514389,
  -1,
  'b3385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3385'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpe',
  'ribulose-phosphate 3-epimerase',
  3514382,
  3515059,
  -1,
  'b3386',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3386'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dam',
  'DNA adenine methyltransferase',
  3515077,
  3515913,
  -1,
  'b3387',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3387'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'damX',
  'cell division protein DamX',
  3516020,
  3517306,
  -1,
  'b3388',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3388'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroB',
  '3-dehydroquinate synthase',
  3517398,
  3518486,
  -1,
  'b3389',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3389'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroK',
  'shikimate kinase 1',
  3518543,
  3519064,
  -1,
  'b3390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3390'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hofQ',
  'DNA utilization protein HofQ',
  3519465,
  3520703,
  -1,
  'b3391',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3391'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hofP',
  'DNA utilization protein HofP',
  3520615,
  3521019,
  -1,
  'b3392',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3392'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hofO',
  'DNA utilization protein HofO',
  3521009,
  3521449,
  -1,
  'b3393',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3393'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hofN',
  'DNA utilization protein HofN',
  3521433,
  3521972,
  -1,
  'b3394',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3394'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hofM',
  'DNA utilization protein HofM',
  3521972,
  3522751,
  -1,
  'b3395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3395'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mrcA',
  'peptidoglycan glycosyltransferase/peptidoglycanDD-transpeptidase MrcA',
  3522871,
  3525423,
  1,
  'b3396',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3396'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudE',
  'ADP-sugar diphosphatase NudE',
  3525589,
  3526149,
  -1,
  'b3397',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3397'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'igaA',
  'inner membrane protein involved in phosphorelaysystem',
  3526469,
  3528604,
  1,
  'b3398',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3398'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrfG',
  'purine nucleotidase',
  3528669,
  3529337,
  1,
  'b3399',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3399'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hslR',
  'heat shock protein Hsp15',
  3529348,
  3529749,
  1,
  'b3400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3400'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hslO',
  'molecular chaperone Hsp33',
  3529774,
  3530652,
  1,
  'b3401',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3401'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhgE',
  'putative transport protein YhgE',
  3530715,
  3532439,
  -1,
  'b3402',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3402'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pck',
  'phosphoenolpyruvate carboxykinase (ATP)',
  3532818,
  3534440,
  1,
  'b3403',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3403'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'envZ',
  'sensor histidine kinase EnvZ',
  3534516,
  3535868,
  -1,
  'b3404',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3404'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ompR',
  'DNA-binding transcriptional dual regulator OmpR',
  3535865,
  3536584,
  -1,
  'b3405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3405'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asompR',
  '—',
  3536438,
  3536775,
  1,
  'b4842',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4842'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'greB',
  'transcription elongation factor GreB',
  3536812,
  3537288,
  1,
  'b3406',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3406'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhgF',
  'RNA-binding protein YhgF',
  3537385,
  3539706,
  1,
  'b3407',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3407'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'feoA',
  'Fe(2(+)) transport protein A',
  3540163,
  3540390,
  1,
  'b3408',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3408'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'feoB',
  'Fe(2(+)) transporter FeoB',
  3540407,
  3542728,
  1,
  'b3409',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3409'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'feoC',
  'Fe(2(+)) transport protein FeoC',
  3542728,
  3542964,
  1,
  'b3410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3410'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpnA',
  'recombination-promoting nuclease RpnA',
  3543167,
  3544045,
  1,
  'b3411',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3411'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bioH',
  'pimeloyl-acyl carrier protein methyl esteresterase',
  3544074,
  3544844,
  -1,
  'b3412',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3412'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhgH',
  'DNA utilization protein YhgH',
  3544882,
  3545565,
  1,
  'b3413',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3413'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nfuA',
  'iron-sulfur cluster carrier protein NfuA',
  3545624,
  3546199,
  1,
  'b3414',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3414'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gntT',
  'high-affinity gluconate transporter',
  3546559,
  3547875,
  1,
  'b3415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3415'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malQ',
  '4-alpha-glucanotransferase',
  3547986,
  3550070,
  -1,
  'b3416',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3416'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malP',
  'maltodextrin phosphorylase',
  3550080,
  3552473,
  -1,
  'b3417',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3417'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malT',
  'DNA-binding transcriptional activator MalT',
  3553085,
  3555790,
  1,
  'b3418',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3418'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rtcA',
  'RNA 3''-terminal phosphate cyclase',
  3555833,
  3556849,
  -1,
  'b4475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4475'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rtcB',
  'RNA-splicing ligase',
  3556853,
  3558079,
  -1,
  'b3421',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3421'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rtcR',
  'DNA-binding transcriptional activator RtcR',
  3558268,
  3559866,
  1,
  'b3422',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3422'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpR',
  '—',
  3559848,
  3560605,
  -1,
  'b3423',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3423'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpG',
  'rhomboid protease GlpG',
  3560622,
  3561452,
  -1,
  'b3424',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3424'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpE',
  'thiosulfate sulfurtransferase GlpE',
  3561497,
  3561823,
  -1,
  'b3425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3425'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpD',
  'aerobic glycerol 3-phosphate dehydrogenase',
  3562013,
  3563518,
  1,
  'b3426',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3426'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yzgL',
  'putative uncharacterized protein YzgL',
  3563724,
  3564005,
  -1,
  'b3427',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3427'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glgP',
  'glycogen phosphorylase',
  3564134,
  3566581,
  -1,
  'b3428',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3428'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glgA',
  'glycogen synthase',
  3566600,
  3568033,
  -1,
  'b3429',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3429'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glgC',
  'glucose-1-phosphate adenylyltransferase',
  3568033,
  3569328,
  -1,
  'b3430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3430'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glgX',
  'limit dextrin alpha-1,6-glucohydrolase',
  3569346,
  3571319,
  -1,
  'b3431',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3431'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glgB',
  '1,4-alpha-glucan branching enzyme',
  3571316,
  3573502,
  -1,
  'b3432',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3432'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhgO',
  'protein YhgO',
  3573660,
  3573701,
  -1,
  'b4788',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4788'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhgP',
  'protein YhgP',
  3573679,
  3573708,
  -1,
  'b4789',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4789'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asd',
  'aspartate-semialdehyde dehydrogenase',
  3573775,
  3574878,
  -1,
  'b3433',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3433'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhgN',
  'MarC family putative inner membrane proteinYhgN',
  3575071,
  3575664,
  1,
  'b3434',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3434'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gntU',
  'low-affinity gluconate transporter',
  3575721,
  3577061,
  -1,
  'b4476',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4476'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gntK',
  'D-gluconate kinase, thermostable',
  3577065,
  3577592,
  -1,
  'b3437',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3437'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gntR',
  'DNA-binding transcriptional repressor GntR',
  3577731,
  3578726,
  -1,
  'b3438',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3438'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhW',
  'quercetin 2,3-dioxygenase',
  3578950,
  3579645,
  -1,
  'b3439',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3439'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhX',
  'putative oxidoreductase YhhX',
  3579768,
  3580805,
  -1,
  'b3440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3440'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ryhB',
  '—',
  3580922,
  3581016,
  -1,
  'b4451',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4451'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhY',
  'N-acetyltransferase YhhY',
  3581138,
  3581626,
  1,
  'b3441',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3441'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhZ',
  'putative endonuclease YhhZ',
  3581863,
  3583041,
  1,
  'b3442',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3442'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrhA',
  'putative uncharacterized protein YrhA',
  3583038,
  3584309,
  1,
  'b3443',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3443'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insA6',
  'IS1 protein InsA',
  3583483,
  3583758,
  1,
  'b3444',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3444'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insB6',
  'IS1 protein InsB',
  3583677,
  3584180,
  1,
  'b3445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3445'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrhD',
  'uncharacterized protein YrhD',
  3584404,
  3584559,
  1,
  'b4612',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4612'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrhB',
  'putative heat shock chaperone',
  3584759,
  3585043,
  1,
  'b3446',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3446'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ggt',
  'glutathione hydrolase proenzyme',
  3585081,
  3586823,
  -1,
  'b3447',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3447'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhA',
  'DUF2756 domain-containing protein YhhA',
  3586943,
  3587383,
  1,
  'b3448',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3448'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ugpQ',
  'glycerophosphodiester phosphodiesterase UgpQ',
  3587370,
  3588113,
  -1,
  'b3449',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3449'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ugpC',
  'sn-glycerol 3-phosphate ABC transporter ATPbinding subunit',
  3588110,
  3589180,
  -1,
  'b3450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3450'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ugpE',
  'sn-glycerol 3-phosphate ABC transporter membranesubunit UgpE',
  3589182,
  3590027,
  -1,
  'b3451',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3451'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ugpA',
  'sn-glycerol 3-phosphate ABC transporter membranesubunit UgpA',
  3590024,
  3590911,
  -1,
  'b3452',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3452'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ugpB',
  'sn-glycerol 3-phosphate ABC transporterperiplasmic binding protein',
  3591009,
  3592325,
  -1,
  'b3453',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3453'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'livF',
  'branched chain amino acid/phenylalanine ABCtransporter ATP binding subunit LivF',
  3592724,
  3593437,
  -1,
  'b3454',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3454'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'livG',
  'branched chain amino acid/phenylalanine ABCtransporter ATP binding subunit LivG',
  3593439,
  3594206,
  -1,
  'b3455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3455'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'livM',
  'branched chain amino acid/phenylalanine ABCtransporter membrane subunit LivM',
  3594203,
  3595480,
  -1,
  'b3456',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3456'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'livH',
  'branched chain amino acid/phenylalanine ABCtransporter membrane subunit LivH',
  3595477,
  3596403,
  -1,
  'b3457',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3457'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'livK',
  'L-leucine/L-phenylalanine ABC transporterperiplasmic binding protein',
  3596451,
  3597560,
  -1,
  'b3458',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3458'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'panZ',
  'PanD maturation factor',
  3597984,
  3598367,
  1,
  'b3459',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3459'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'livJ',
  'branched chain amino acid/phenylalanine ABCtransporter periplasmic binding protein',
  3598555,
  3599658,
  -1,
  'b3460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3460'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoH',
  'RNA polymerase sigma factor RpoH',
  3599929,
  3600783,
  -1,
  'b3461',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3461'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsX',
  'cell division protein FtsX',
  3601028,
  3602086,
  -1,
  'b3462',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3462'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsE',
  'cell division protein FtsE',
  3602079,
  3602747,
  -1,
  'b3463',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3463'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsY',
  'signal recognition particle receptor',
  3602750,
  3604243,
  -1,
  'b3464',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3464'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmD',
  '16S rRNA m(2)G966 methyltransferase',
  3604393,
  3604989,
  1,
  'b3465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3465'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhL',
  'DUF1145 domain-containing protein YhhL',
  3604979,
  3605248,
  1,
  'b3466',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3466'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhM',
  'DUF2500 domain-containing protein YhhM',
  3605251,
  3605610,
  -1,
  'b3467',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3467'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhN',
  'PF07947 family protein YhhN',
  3605751,
  3606377,
  1,
  'b3468',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3468'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zntA',
  'Zn(2(+))/Cd(2(+))/Pb(2(+)) exporting P-typeATPase',
  3606451,
  3608649,
  1,
  'b3469',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3469'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tusA',
  'sulfur transfer protein TusA',
  3608751,
  3608996,
  -1,
  'b3470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3470'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhQ',
  'queuosine precursor transporter',
  3609217,
  3609882,
  1,
  'b3471',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3471'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcrB',
  'periplasmic bacteriophage sensitivity proteinDcrB',
  3609955,
  3610512,
  1,
  'b3472',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3472'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhS',
  'putative transporter YhhS',
  3610516,
  3611733,
  -1,
  'b3473',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3473'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhT',
  'putative transporter YhhT',
  3611865,
  3612914,
  1,
  'b3474',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3474'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acpT',
  'holo-[acyl carrier protein] synthase 2',
  3612969,
  3613556,
  1,
  'b3475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3475'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nikA',
  'Ni(2(+)) ABC transporter periplasmic bindingprotein',
  3613667,
  3615241,
  1,
  'b3476',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3476'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nikB',
  'Ni(2(+)) ABC transporter membrane subunit NikB',
  3615241,
  3616185,
  1,
  'b3477',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3477'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nikC',
  'Ni(2(+)) ABC transporter membrane subunit NikC',
  3616182,
  3617015,
  1,
  'b3478',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3478'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nikD',
  'Ni(2(+)) ABC transporter ATP binding subunitNikD',
  3617015,
  3617779,
  1,
  'b3479',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3479'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nikE',
  'Ni(2(+)) ABC transporter ATP binding subunitNikE',
  3617776,
  3618582,
  1,
  'b3480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3480'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nikR',
  'DNA-binding transcriptional repressor NikR',
  3618588,
  3618989,
  1,
  'b3481',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3481'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhsB',
  'rhs element protein RhsB',
  3619192,
  3623427,
  1,
  'b3482',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3482'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhH',
  'PF15631 family protein YhhH',
  3623399,
  3623782,
  1,
  'b3483',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3483'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yrhC',
  '—',
  3623887,
  3624132,
  1,
  'b4552',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4552'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhI',
  'putative transposase',
  3624378,
  3625514,
  1,
  'b3484',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3484'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhhJ',
  'ABC transporter family protein YhhJ',
  3625679,
  3626803,
  -1,
  'b3485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3485'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbbA',
  'ribosome-associated ATPase',
  3626803,
  3629538,
  -1,
  'b3486',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3486'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiI',
  'putative membrane fusion protein YhiI',
  3629535,
  3630602,
  -1,
  'b3487',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3487'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiY',
  'protein YhiY',
  3630665,
  3630778,
  -1,
  'b4790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4790'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiJ',
  'DUF4049 domain-containing protein YhiJ',
  3630968,
  3632590,
  -1,
  'b3488',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3488'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiL',
  '—',
  3632852,
  3634458,
  -1,
  'b4660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4660'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiM',
  'inner membrane protein YhiM',
  3634841,
  3635893,
  1,
  'b3491',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3491'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiN',
  'putative oxidoreductase YhiN',
  3636208,
  3637410,
  -1,
  'b3492',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3492'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pitA',
  'metal phosphate:H(+) symporter PitA',
  3637642,
  3639141,
  1,
  'b3493',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3493'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uspB',
  'universal stress protein B',
  3639385,
  3639720,
  -1,
  'b3494',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3494'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uspA',
  'universal stress protein A',
  3640111,
  3640545,
  1,
  'b3495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3495'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yriA',
  'protein YriA',
  3640612,
  3640686,
  -1,
  'b4791',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4791'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yriB',
  'protein YriB',
  3640643,
  3640696,
  -1,
  'b4792',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4792'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dtpB',
  'dipeptide/tripeptide:H(+) symporter DtpB',
  3640862,
  3642331,
  1,
  'b3496',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3496'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmJ',
  '16S rRNA m(2)G1516 methyltransferase',
  3642380,
  3643132,
  -1,
  'b3497',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3497'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prlC',
  'oligopeptidase A',
  3643140,
  3645182,
  -1,
  'b3498',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3498'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmJ',
  '23S rRNA m(6)A2030 methyltransferase',
  3645385,
  3646227,
  1,
  'b3499',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3499'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gor',
  'glutathione reductase (NADPH)',
  3646299,
  3647651,
  1,
  'b3500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3500'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dinQ',
  'membrane toxin DinQ',
  3647705,
  3647788,
  -1,
  'b4613',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4613'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agrA',
  '—',
  3648063,
  3648144,
  1,
  'b4712',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4712'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agrB',
  '—',
  3648294,
  3648375,
  1,
  'b4713',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4713'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arsR',
  'DNA-binding transcriptional repressor ArsR',
  3648528,
  3648881,
  1,
  'b3501',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3501'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arsB',
  'arsenite/antimonite:H(+) antiporter',
  3648935,
  3650224,
  1,
  'b3502',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3502'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arsC',
  'arsenate reductase',
  3650237,
  3650662,
  1,
  'b3503',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3503'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiS',
  'putative uncharacterized protein YhiS',
  3651291,
  3653713,
  1,
  'b3504',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3504'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH11',
  'IS5 transposase and trans-activator',
  3652182,
  3653162,
  -1,
  'b3505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3505'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slp',
  'starvation lipoprotein',
  3653961,
  3654527,
  1,
  'b3506',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3506'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dctR',
  'putative DNA-binding transcriptional regulatorDctR',
  3654683,
  3655213,
  1,
  'b3507',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3507'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhiD',
  'inner membrane protein YhiD',
  3655255,
  3655902,
  -1,
  'b3508',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3508'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hdeB',
  'periplasmic acid stress chaperone HdeB',
  3655966,
  3656292,
  -1,
  'b3509',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3509'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hdeA',
  'periplasmic acid stress chaperone HdeA',
  3656408,
  3656740,
  -1,
  'b3510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3510'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hdeD',
  'acid-resistance membrane protein',
  3656995,
  3657567,
  1,
  'b3511',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3511'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arrS',
  '—',
  3657985,
  3658054,
  -1,
  'b4704',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4704'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadE',
  'DNA-binding transcriptional activator GadE',
  3658366,
  3658893,
  1,
  'b3512',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3512'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadF',
  '—',
  3658992,
  3659082,
  1,
  'b4718',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4718'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtE',
  'multidrug efflux pump membrane fusion proteinMdtE',
  3659232,
  3660389,
  1,
  'b3513',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3513'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtF',
  'multidrug efflux pump RND permease MdtF',
  3660414,
  3663527,
  1,
  'b3514',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3514'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadW',
  'DNA-binding transcriptional dual regulator GadW',
  3663890,
  3664618,
  -1,
  'b3515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3515'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadY',
  '—',
  3664864,
  3664969,
  1,
  'b4452',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4452'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadX',
  'DNA-binding transcriptional dual regulator GadX',
  3664986,
  3665810,
  -1,
  'b3516',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3516'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadA',
  'glutamate decarboxylase A',
  3666180,
  3667580,
  -1,
  'b3517',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3517'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccp',
  'cytochrome c peroxidase',
  3667791,
  3669188,
  -1,
  'b3518',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3518'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'treF',
  'cytoplasmic trehalase',
  3669592,
  3671241,
  1,
  'b3519',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3519'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjB',
  'putative DNA-binding transcriptional regulatorYhjB',
  3671292,
  3671894,
  -1,
  'b3520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3520'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcdB',
  'putative DNA-binding transcriptional regulatorYhjC',
  3672414,
  3673313,
  1,
  'b3521',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3521'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjD',
  'putative transporter YhjD',
  3673362,
  3674375,
  1,
  'b3522',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3522'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjE',
  'putative transporter YhjE',
  3674786,
  3676108,
  1,
  'b3523',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3523'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjG',
  'AsmA family protein YhjG',
  3676290,
  3678350,
  -1,
  'b3524',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3524'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeH',
  'cyclic di-GMP phosphodiesterase PdeH',
  3678420,
  3679187,
  -1,
  'b3525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3525'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kdgK',
  '2-dehydro-3-deoxygluconokinase',
  3679419,
  3680348,
  1,
  'b3526',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3526'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjJ',
  'peptidase M16 family protein YhjJ',
  3680444,
  3681940,
  -1,
  'b3527',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3527'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dctA',
  'C4 dicarboxylate/orotate:H(+) symporter',
  3682161,
  3683447,
  -1,
  'b3528',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3528'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeK',
  'c-di-GMP phosphodiesterase PdeK',
  3683630,
  3685618,
  -1,
  'b3529',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3529'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsC',
  'cellulose synthase outer membrane channel',
  3685700,
  3689173,
  -1,
  'b3530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3530'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsZ',
  'endo-1,4-D-glucanase',
  3689155,
  3690261,
  -1,
  'b3531',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3531'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsB',
  'cellulose synthase periplasmic subunit',
  3690268,
  3692607,
  -1,
  'b3532',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3532'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsA',
  'cellulose synthase catalytic subunit',
  3692618,
  3695236,
  -1,
  'b3533',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3533'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsQ',
  '—',
  3695233,
  3695985,
  -1,
  'b3534',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3534'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjR',
  'PF10945 family protein YhjR',
  3695997,
  3696185,
  -1,
  'b3535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3535'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsE',
  'c-di-GMP-binding protein BcsE',
  3696458,
  3698029,
  1,
  'b3536',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3536'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsF',
  'putative cellulose biosynthesis protein BcsF',
  3698026,
  3698217,
  1,
  'b3537',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3537'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcsG',
  'cellulose phosphoethanolamine transferase',
  3698214,
  3699893,
  1,
  'b3538',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3538'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ldrD',
  'small toxic polypeptide LdrD',
  3699980,
  3700087,
  -1,
  'b4453',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4453'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rdlD',
  '—',
  3700136,
  3700199,
  1,
  'b4454',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4454'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjV',
  'putative transporter YhjV',
  3700563,
  3701834,
  1,
  'b3539',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3539'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dppF',
  'dipeptide ABC transporter ATP binding subunitDppF',
  3701864,
  3702868,
  -1,
  'b3540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3540'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dppD',
  'dipeptide ABC transporter ATP binding subunitDppD',
  3702865,
  3703848,
  -1,
  'b3541',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3541'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dppC',
  'dipeptide ABC transporter membrane subunit DppC',
  3703859,
  3704761,
  -1,
  'b3542',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3542'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dppB',
  'dipeptide ABC transporter membrane subunit DppB',
  3704771,
  3705790,
  -1,
  'b3543',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3543'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dppA',
  'dipeptide ABC transporter periplasmic bindingprotein',
  3706098,
  3707705,
  -1,
  'b3544',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3544'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proK',
  '—',
  3708616,
  3708692,
  -1,
  'b3545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3545'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eptB',
  'phosphoethanolamine transferase EptB',
  3708784,
  3710475,
  -1,
  'b3546',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3546'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjX',
  'putative transporter YhjX',
  3710799,
  3712007,
  -1,
  'b3547',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3547'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhjY',
  'putative outer membrane protein YhjY',
  3712236,
  3712934,
  -1,
  'b3548',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3548'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tag',
  '3-methyl-adenine DNA glycosylase I,constitutive',
  3713092,
  3713655,
  1,
  'b3549',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3549'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaC',
  'peptidyl-lysine N-acetyltransferase YiaC',
  3713652,
  3714092,
  1,
  'b3550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3550'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bisC',
  'biotin sulfoxide reductase',
  3714061,
  3716394,
  -1,
  'b3551',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3551'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaD',
  'PF13488 family lipoprotein YiaD',
  3716547,
  3717206,
  1,
  'b3552',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3552'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ghrB',
  'glyoxylate reductase',
  3717310,
  3718284,
  1,
  'b3553',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3553'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaF',
  'DUF3053 domain-containing protein YiaF',
  3718334,
  3719044,
  -1,
  'b3554',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3554'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaG',
  'putative DNA-binding transcriptional regulatorYiaG',
  3719478,
  3719768,
  1,
  'b3555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3555'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cspA',
  'cold shock protein CspA',
  3720049,
  3720261,
  1,
  'b3556',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3556'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysaE',
  'protein YsaE',
  3720400,
  3720471,
  1,
  'b4793',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4793'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mokA',
  '—',
  3720448,
  3720632,
  -1,
  'b4647',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4647'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hokA',
  'small toxic polypeptide',
  3720448,
  3720600,
  -1,
  'b4455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4455'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insJ',
  'insertion element IS150 protein InsA',
  3720680,
  3721201,
  1,
  'b3557',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3557'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insK',
  'IS150 conserved protein InsB',
  3721198,
  3722049,
  1,
  'b3558',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3558'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sokA',
  '—',
  3722077,
  3722111,
  1,
  'b4614',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4614'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyS',
  'glycine--tRNA ligase',
  3722328,
  3724397,
  -1,
  'b3559',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3559'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyQ',
  'glycine--tRNA ligase subunit alpha',
  3724407,
  3725318,
  -1,
  'b3560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3560'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysaB',
  'putative lipoprotein YsaB',
  3725413,
  3725712,
  -1,
  'b4553',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4553'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wecH',
  'O-acetyltransferase WecH',
  3725887,
  3726882,
  1,
  'b3561',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3561'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaA',
  'PF05360 family inner membrane protein YiaA',
  3726924,
  3727361,
  -1,
  'b3562',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3562'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaB',
  'PF05360 family inner membrane protein YiaB',
  3727407,
  3727748,
  -1,
  'b3563',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3563'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylB',
  'xylulokinase',
  3727917,
  3729371,
  -1,
  'b3564',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3564'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylZ',
  '—',
  3729386,
  3729545,
  -1,
  'b4834',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4834'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylA',
  'xylose isomerase',
  3729443,
  3730765,
  -1,
  'b3565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3565'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylF',
  'xylose ABC transporter periplasmic bindingprotein',
  3731131,
  3732123,
  1,
  'b3566',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3566'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylG',
  'xylose ABC transporter ATP binding subunit',
  3732201,
  3733742,
  1,
  'b3567',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3567'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylH',
  'xylose ABC transporter membrane subunit',
  3733720,
  3734901,
  1,
  'b3568',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3568'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylR',
  'DNA-binding transcriptional dual regulator XylR',
  3734979,
  3736157,
  1,
  'b3569',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3569'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bax',
  'putative glycoside hydrolase Bax',
  3736353,
  3737177,
  -1,
  'b3570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3570'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'baxL',
  'putative translational regulatory protein BaxL',
  3737177,
  3737203,
  -1,
  'b4794',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4794'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malS',
  'alpha-amylase',
  3737497,
  3739527,
  1,
  'b3571',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3571'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'avtA',
  'valine--pyruvate aminotransferase',
  3739705,
  3740958,
  1,
  'b3572',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3572'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysaA',
  'putative electron transport protein YsaA',
  3741109,
  3741582,
  -1,
  'b3573',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3573'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'plaR',
  'DNA-binding transcriptional repressor PlaR',
  3741684,
  3742532,
  -1,
  'b3574',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3574'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaK',
  '2,3-diketo-L-gulonate reductase',
  3742733,
  3743731,
  1,
  'b3575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3575'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaL',
  'DUF386 domain-containing protein YiaL',
  3743743,
  3744210,
  1,
  'b3576',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3576'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaM',
  '2,3-diketo-L-gulonate:Na(+) symporter - membranesubunit',
  3744328,
  3744801,
  1,
  'b3577',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3577'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaN',
  '2,3-diketo-L-gulonate:Na(+) symporter - membranesubunit',
  3744804,
  3746081,
  1,
  'b3578',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3578'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaO',
  '2,3-diketo-L-gulonate:Na(+) symporter -periplasmic binding protein',
  3746094,
  3747080,
  1,
  'b3579',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3579'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lyxK',
  'L-xylulose kinase',
  3747084,
  3748580,
  1,
  'b3580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3580'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgbH',
  '3-keto-L-gulonate-6-phosphate decarboxylaseSgbH',
  3748577,
  3749239,
  1,
  'b3581',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3581'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgbU',
  'putative L-xylulose 5-phosphate 3-epimerase',
  3749232,
  3750092,
  1,
  'b3582',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3582'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgbE',
  'L-ribulose-5-phosphate 4-epimerase SgbE',
  3750086,
  3750781,
  1,
  'b3583',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3583'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysaC',
  '—',
  3750813,
  3750914,
  -1,
  'b4648',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4648'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysaD',
  '—',
  3750918,
  3751109,
  1,
  'b4649',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4649'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaT',
  'outer membrane protein YiaT',
  3751128,
  3751868,
  -1,
  'b3584',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3584'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaU',
  'DNA-binding transcriptional activator YiaU',
  3751992,
  3752966,
  1,
  'b3585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3585'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaV',
  'putative membrane fusion protein YiaV',
  3752963,
  3754099,
  -1,
  'b3586',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3586'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaW',
  'DUF3302 domain-containing protein YiaW',
  3754105,
  3754428,
  -1,
  'b3587',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3587'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aldB',
  'aldehyde dehydrogenase B',
  3754973,
  3756511,
  -1,
  'b3588',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3588'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiaY',
  'L-threonine dehydrogenase',
  3756676,
  3757827,
  -1,
  'b3589',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3589'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'selB',
  'selenocysteyl-tRNA-specific translationelongation factor',
  3758017,
  3759861,
  -1,
  'b3590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3590'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'selA',
  'selenocysteine synthase',
  3759858,
  3761249,
  -1,
  'b3591',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3591'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibF',
  'glutathione transferase-like protein YibF',
  3761347,
  3761955,
  -1,
  'b3592',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3592'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhsA',
  'rhs element protein RhsA',
  3762183,
  3766316,
  1,
  'b3593',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3593'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibA',
  'putative lyase containing HEAT-repeat',
  3766337,
  3767179,
  1,
  'b3594',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3594'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibJ',
  '—',
  3767221,
  3767922,
  1,
  'b3595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3595'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibG',
  'tetratricopeptide-like domain-containing proteinYibG',
  3768177,
  3768638,
  1,
  'b3596',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3596'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibS',
  '—',
  3768639,
  3768890,
  1,
  'b4650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4650'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibW',
  '—',
  3768892,
  3769256,
  1,
  'b4651',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4651'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibV',
  'PF15596 family protein YibV',
  3769345,
  3769680,
  1,
  'b4615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4615'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibU',
  '—',
  3769948,
  3770146,
  1,
  'b4652',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4652'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibH',
  'inner membrane protein YibH',
  3770243,
  3771379,
  -1,
  'b3597',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3597'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibI',
  'DUF3302 domain-containing protein YibI',
  3771382,
  3771744,
  -1,
  'b3598',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3598'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mtlA',
  'mannitol-specific PTS enzyme IICBA component',
  3772281,
  3774194,
  1,
  'b3599',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3599'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mtlD',
  'mannitol-1-phosphate 5-dehydrogenase',
  3774424,
  3775572,
  1,
  'b3600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3600'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mtlR',
  'transcriptional repressor MtlR',
  3775572,
  3776159,
  1,
  'b3601',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3601'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibT',
  'protein YibT',
  3776171,
  3776380,
  -1,
  'b4554',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4554'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibL',
  'DUF2810 domain-containing protein YibL',
  3776665,
  3777027,
  1,
  'b3602',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3602'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lldP',
  'lactate/glycolate:H(+) symporter LldP',
  3777399,
  3779054,
  1,
  'b3603',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3603'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lldR',
  'DNA-binding transcriptional dual regulator LldR',
  3779054,
  3779830,
  1,
  'b3604',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3604'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lldD',
  'L-lactate dehydrogenase',
  3779827,
  3781017,
  1,
  'b3605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3605'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trmL',
  'tRNA (cytidine/uridine-2''-O)-ribosemethyltransferase',
  3781215,
  3781688,
  1,
  'b3606',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3606'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysE',
  'serine acetyltransferase',
  3781741,
  3782562,
  -1,
  'b3607',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3607'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gpsA',
  'glycerol-3-phosphate dehydrogenase',
  3782642,
  3783661,
  -1,
  'b3608',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3608'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'secB',
  'protein export chaperone SecB',
  3783661,
  3784128,
  -1,
  'b3609',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3609'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'grxC',
  'reduced glutaredoxin 3',
  3784191,
  3784442,
  -1,
  'b3610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3610'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibN',
  'putative sulfurtransferase YibN',
  3784584,
  3785015,
  -1,
  'b3611',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3611'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gpmM',
  '2,3-bisphosphoglycerate-independentphosphoglycerate mutase',
  3785260,
  3786804,
  1,
  'b3612',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3612'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'envC',
  'murein hydrolase activator EnvC',
  3786838,
  3788097,
  1,
  'b3613',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3613'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibQ',
  'divergent polysaccharide deacetylasedomain-containing protein YibQ',
  3788101,
  3789060,
  1,
  'b3614',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3614'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaH',
  'UDP-glucuronate:LPS(HepIII) glycosyltransferase',
  3789047,
  3790081,
  -1,
  'b3615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3615'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdh',
  'threonine dehydrogenase',
  3790320,
  3791345,
  -1,
  'b3616',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3616'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kbl',
  '2-amino-3-ketobutyrate CoA ligase',
  3791355,
  3792551,
  -1,
  'b3617',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3617'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'htrL',
  'protein HtrL',
  3792826,
  3793683,
  -1,
  'b3618',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3618'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfaD',
  'ADP-L-glycero-D-mannoheptose 6-epimerase',
  3793987,
  3794919,
  1,
  'b3619',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3619'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaF',
  'ADP-heptose--LPS heptosyltransferase 2',
  3794929,
  3795975,
  1,
  'b3620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3620'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaC',
  'ADP-heptose:LPS heptosyltransferase 1',
  3795979,
  3796938,
  1,
  'b3621',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3621'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaL',
  'O-antigen ligase',
  3796948,
  3798207,
  1,
  'b3622',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3622'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibX',
  'protein YibX-S',
  3797772,
  3798014,
  -1,
  'b4795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4795'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yibY',
  'protein YibY',
  3798039,
  3798149,
  -1,
  'b4796',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4796'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaU',
  'putative ADP-heptose:LPS heptosyltransferase 4',
  3798239,
  3799312,
  -1,
  'b3623',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3623'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaZ',
  'lipopolysaccharide core biosynthesis proteinWaaZ',
  3799345,
  3800196,
  -1,
  'b3624',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3624'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaY',
  'lipopolysaccharide core heptose (II) kinase',
  3800267,
  3800965,
  -1,
  'b3625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3625'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaJ',
  'UDP-glucose:(glucosyl)LPSalpha-1,2-glucosyltransferase',
  3800983,
  3801999,
  -1,
  'b3626',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3626'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaO',
  'UDP-D-glucose:(glucosyl)LPSalpha-1,3-glucosyltransferase',
  3802039,
  3803058,
  -1,
  'b3627',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3627'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaB',
  'UDP-D-galactose:(glucosyl)lipopolysaccharide-1,6-D-galactosyltransferase',
  3803058,
  3804137,
  -1,
  'b3628',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3628'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaS',
  'lipopolysaccharide core biosynthesis proteinWaaS',
  3804181,
  3805116,
  -1,
  'b3629',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3629'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaP',
  'lipopolysaccharide core heptose (I) kinase',
  3805153,
  3805950,
  -1,
  'b3630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3630'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaG',
  'lipopolysaccharide glucosyltransferase I',
  3805943,
  3807067,
  -1,
  'b3631',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3631'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaQ',
  'lipopolysaccharide core heptosyltransferase 3',
  3807064,
  3808098,
  -1,
  'b3632',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3632'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rirA',
  '—',
  3808166,
  3808238,
  -1,
  'b4760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4760'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'waaA',
  'KDO transferase',
  3808540,
  3809817,
  1,
  'b3633',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3633'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'coaD',
  'pantetheine-phosphate adenylyltransferase',
  3809825,
  3810304,
  1,
  'b3634',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3634'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mutM',
  'DNA-formamidopyrimidine glycosylase',
  3810343,
  3811152,
  -1,
  'b3635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3635'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmG',
  '50S ribosomal subunit protein L33',
  3811250,
  3811417,
  -1,
  'b3636',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3636'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmB',
  '50S ribosomal subunit protein L28',
  3811438,
  3811674,
  -1,
  'b3637',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3637'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicR',
  'RadC-like JAB domain-containing protein YicR',
  3811891,
  3812559,
  -1,
  'b3638',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3638'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dfp',
  'fused 4''-phosphopantothenoylcysteinedecarboxylase and phosphopantothenoylcysteine synthetase',
  3812731,
  3813951,
  1,
  'b3639',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3639'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dut',
  'dUTP diphosphatase',
  3813929,
  3814387,
  1,
  'b3640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3640'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slmA',
  'nucleoid occlusion factor SlmA',
  3814494,
  3815090,
  1,
  'b3641',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3641'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrE',
  'orotate phosphoribosyltransferase',
  3815127,
  3815768,
  -1,
  'b3642',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3642'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rph',
  'truncated RNase PH',
  3815863,
  3816549,
  -1,
  'b3643',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3643'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicC',
  'putative RNase adaptor protein YicC',
  3816676,
  3817539,
  1,
  'b3644',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3644'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dinD',
  'DNA damage-inducible protein D',
  3817760,
  3818584,
  1,
  'b3645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3645'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicG',
  'PF03458 family inner membrane protein YicG',
  3818874,
  3819491,
  1,
  'b3646',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3646'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ligB',
  'DNA ligase B',
  3819488,
  3821170,
  -1,
  'b3647',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3647'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gmk',
  'guanylate kinase',
  3821428,
  3822051,
  1,
  'b3648',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3648'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoZ',
  'RNA polymerase subunit omega',
  3822106,
  3822381,
  1,
  'b3649',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3649'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'spoT',
  'bifunctional (p)ppGpp synthase/hydrolase SpoT',
  3822400,
  3824508,
  1,
  'b3650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3650'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trmH',
  'tRNA (Gm18) 2''-O-methyltransferase',
  3824515,
  3825204,
  1,
  'b3651',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3651'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recG',
  'ATP-dependent DNA helicase RecG',
  3825210,
  3827291,
  1,
  'b3652',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3652'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltS',
  'glutamate:sodium symporter',
  3827460,
  3828665,
  -1,
  'b3653',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3653'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xanP',
  'xanthine:H(+) symporter XanP',
  3828945,
  3830336,
  1,
  'b3654',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3654'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicH',
  'AsmA family protein YicH',
  3830457,
  3832166,
  1,
  'b3655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3655'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicI',
  'alpha-D-xyloside xylohydrolase',
  3832219,
  3834537,
  -1,
  'b3656',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3656'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicJ',
  'putative xyloside transporter YicJ',
  3834547,
  3835929,
  -1,
  'b3657',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3657'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'selC',
  '—',
  3836222,
  3836316,
  1,
  'b3658',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3658'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicT',
  '—',
  3836425,
  3836556,
  1,
  'b4653',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4653'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'setC',
  'putative exporter SetC',
  3836953,
  3838137,
  1,
  'b3659',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3659'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicL',
  'putative transporter YicL',
  3838248,
  3839171,
  1,
  'b3660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3660'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicU',
  'protein YicU',
  3838642,
  3838701,
  -1,
  'b4797',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4797'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nlpA',
  'lipoprotein-28',
  3839175,
  3839993,
  -1,
  'b3661',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3661'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicS',
  'uncharacterized protein YicS',
  3840215,
  3840508,
  1,
  'b4555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4555'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nepI',
  'purine ribonucleoside exporter',
  3840549,
  3841739,
  -1,
  'b3662',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3662'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yicN',
  'DUF1198 domain-containing protein YicN',
  3841950,
  3842402,
  -1,
  'b3663',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3663'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adeQ',
  'adenine transporter',
  3842455,
  3843789,
  -1,
  'b3664',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3664'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adeD',
  'adenine deaminase',
  3843964,
  3845730,
  1,
  'b3665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3665'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uhpU',
  '—',
  3845730,
  3845995,
  -1,
  'b4829',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4829'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uhpT',
  'hexose-6-phosphate:phosphate antiporter',
  3845776,
  3847167,
  -1,
  'b3666',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3666'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uhpC',
  'inner membrane protein sensingglucose-6-phosphate',
  3847305,
  3848624,
  -1,
  'b3667',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3667'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uhpB',
  'sensor histidine kinase UhpB',
  3848634,
  3850136,
  -1,
  'b3668',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3668'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uhpA',
  'DNA-binding transcriptional activator UhpA',
  3850136,
  3850726,
  -1,
  'b3669',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3669'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvN',
  'acetohydroxy acid synthase I subunit IlvN',
  3850802,
  3851092,
  -1,
  'b3670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3670'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvB',
  'acetohydroxy acid synthase I subunit IlvB',
  3851096,
  3852784,
  -1,
  'b3671',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3671'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ivbL',
  'ilvBN operon leader peptide',
  3852890,
  3852988,
  -1,
  'b3672',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3672'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'istR',
  '—',
  3853118,
  3853257,
  -1,
  'b4616',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4616'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tisB',
  'membrane-depolarizing toxin TisB',
  3853553,
  3853642,
  1,
  'b4618',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4618'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysdE',
  'protein YsdE',
  3853766,
  3853840,
  -1,
  'b4798',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4798'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'emrD',
  'multidrug efflux pump EmrD',
  3853922,
  3855106,
  1,
  'b3673',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3673'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidF',
  'uncharacterized protein YidF',
  3855114,
  3855611,
  -1,
  'b3674',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3674'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidG',
  'inner membrane protein YidG',
  3855608,
  3855970,
  -1,
  'b3675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3675'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidH',
  'DUF202 domain-containing inner membrane proteinYidH',
  3855960,
  3856307,
  -1,
  'b3676',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3676'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidI',
  'putative inner membrane protein YidI',
  3856415,
  3856864,
  1,
  'b3677',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3677'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidJ',
  'putative sulfatase/phosphatase YidJ',
  3856911,
  3858404,
  -1,
  'b3678',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3678'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidK',
  'putative transporter YidK',
  3858401,
  3860116,
  -1,
  'b3679',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3679'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidL',
  'putative DNA-binding transcriptional regulatorYidL',
  3860283,
  3861176,
  1,
  'b3680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3680'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glvG',
  '—',
  3861173,
  3861987,
  -1,
  'b4556',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4556'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glvB',
  'putative PTS enzyme II component GlvB',
  3861987,
  3862472,
  -1,
  'b3682',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3682'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glvC',
  'putative PTS enzyme II component GlvC',
  3862497,
  3863603,
  -1,
  'b3683',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3683'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidP',
  'putative DNA-binding transcriptional regulatorYidP',
  3863899,
  3864615,
  1,
  'b3684',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3684'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidE',
  'putative transport protein YidE',
  3864612,
  3866273,
  -1,
  'b3685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3685'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibpB',
  'small heat shock protein IbpB',
  3866469,
  3866897,
  -1,
  'b3686',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3686'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibpA',
  'small heat shock protein IbpA',
  3867009,
  3867422,
  -1,
  'b3687',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3687'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidQ',
  'DUF1375 domain-containing putative lipoproteinYidQ',
  3867728,
  3868060,
  1,
  'b3688',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3688'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidR',
  'DUF3748 domain-containing galacturonatecatabolism protein YidR',
  3868062,
  3869309,
  -1,
  'b3689',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3689'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cbrA',
  'colicin M resistance protein',
  3869377,
  3870441,
  1,
  'b3690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3690'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgoT',
  'D-galactonate:H(+) symporter',
  3870438,
  3871730,
  -1,
  'b3691',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3691'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgoD',
  'D-galactonate dehydratase',
  3871850,
  3872998,
  -1,
  'b4478',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4478'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgoA',
  '2-dehydro-3-deoxy-6-phosphogalactonate aldolase',
  3872995,
  3873612,
  -1,
  'b4477',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4477'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgoK',
  '2-dehydro-3-deoxygalactonokinase',
  3873596,
  3874474,
  -1,
  'b3693',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3693'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgoR',
  'DNA-binding transcriptional regulator DgoR',
  3874471,
  3875160,
  -1,
  'b4479',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4479'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidX',
  'putative lipoprotein YidX',
  3875438,
  3876094,
  1,
  'b3696',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3696'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidA',
  'sugar phosphatase YidA',
  3876140,
  3876952,
  -1,
  'b3697',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3697'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidB',
  'DUF937 domain-containing protein YidB',
  3877067,
  3877465,
  -1,
  'b3698',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3698'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gyrB',
  'DNA gyrase subunit B',
  3877705,
  3880119,
  -1,
  'b3699',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3699'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recF',
  'recombination mediator protein RecF',
  3880148,
  3881221,
  -1,
  'b3700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3700'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dnaN',
  'beta sliding clamp',
  3881221,
  3882321,
  -1,
  'b3701',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3701'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dnaA',
  'chromosomal replication initiator protein DnaA',
  3882326,
  3883729,
  -1,
  'b3702',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3702'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysdD',
  'protein YsdD',
  3884026,
  3884106,
  1,
  'b4757',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4757'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmH',
  '50S ribosomal subunit protein L34',
  3884336,
  3884476,
  1,
  'b3703',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3703'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnpA',
  'RNase P protein component',
  3884493,
  3884852,
  1,
  'b3704',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3704'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidD',
  'membrane protein insertion efficiency factor',
  3884816,
  3885073,
  1,
  'b4557',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4557'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidC',
  'membrane protein insertase YidC',
  3885076,
  3886722,
  1,
  'b3705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3705'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mnmE',
  '5-carboxymethylaminomethyluridine-tRNA synthaseGTPase subunit',
  3886828,
  3888192,
  1,
  'b3706',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3706'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tnaC',
  'tnaAB operon leader peptide',
  3888435,
  3888509,
  1,
  'b3707',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3707'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tnaA',
  'tryptophanase',
  3888730,
  3890145,
  1,
  'b3708',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3708'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tnaB',
  'tryptophan:H(+) symporter TnaB',
  3890236,
  3891483,
  1,
  'b3709',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3709'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtL',
  'efflux pump MdtL',
  3891615,
  3892790,
  1,
  'b3710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3710'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yidZ',
  'DNA-binding transcriptional dual regulator YidZ',
  3892765,
  3893724,
  1,
  'b3711',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3711'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yieE',
  'putative phosphopantetheinyl transferase',
  3893881,
  3894630,
  1,
  'b3712',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3712'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yieF',
  'quinone reductase',
  3894652,
  3895218,
  1,
  'b3713',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3713'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adeP',
  'adenine:H(+) symporter',
  3895272,
  3896609,
  -1,
  'b3714',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3714'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yieH',
  '6-phosphogluconate phosphatase',
  3896774,
  3897439,
  1,
  'b3715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3715'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cbrB',
  'putative inner membrane protein',
  3897506,
  3897973,
  1,
  'b3716',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3716'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cbrC',
  'PF03691 family colicin E2 tolerance proteinCbrC',
  3898022,
  3898609,
  1,
  'b3717',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3717'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yieK',
  'putative glucosamine-6-phosphate deaminase YieK',
  3898671,
  3899393,
  -1,
  'b3718',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3718'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yieL',
  'putative hydrolase YieL',
  3899408,
  3900577,
  -1,
  'b3719',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3719'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglH',
  'cryptic carbohydrate-specific outer membraneporin',
  3900604,
  3902220,
  -1,
  'b3720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3720'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglB',
  'cryptic 6-phospho-beta-glucosidase B',
  3902289,
  3903701,
  -1,
  'b3721',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3721'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglF',
  'cryptic beta-glucoside specific PTS enzymeII/BglG kinase/BglG phosphatase',
  3903720,
  3905597,
  -1,
  'b3722',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3722'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglG',
  'transcriptional antiterminator BglG',
  3905731,
  3906567,
  -1,
  'b3723',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3723'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phoU',
  'negative regulator of the pho regulon',
  3906853,
  3907578,
  -1,
  'b3724',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3724'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pstB',
  'phosphate ABC transporter ATP binding subunit',
  3907593,
  3908366,
  -1,
  'b3725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3725'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pstA',
  'phosphate ABC transporter membrane subunit PstA',
  3908549,
  3909439,
  -1,
  'b3726',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3726'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pstC',
  'phosphate ABC transporter membrane subunit PstC',
  3909439,
  3910398,
  -1,
  'b3727',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3727'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pstS',
  'phosphate ABC transporter periplasmic bindingprotein',
  3910485,
  3911525,
  -1,
  'b3728',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3728'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glmS',
  'L-glutamine--D-fructose-6-phosphateaminotransferase',
  3911839,
  3913668,
  -1,
  'b3729',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3729'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glmU',
  'fused N-acetylglucosamine-1-phosphateuridyltransferase and glucosamine-1-phosphateacetyltransferase',
  3913830,
  3915200,
  -1,
  'b3730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3730'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpC',
  'ATP synthase F1 complex subunit epsilon',
  3915553,
  3915972,
  -1,
  'b3731',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3731'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpD',
  'ATP synthase F1 complex subunit beta',
  3915993,
  3917375,
  -1,
  'b3732',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3732'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpG',
  'ATP synthase F1 complex subunit gamma',
  3917402,
  3918265,
  -1,
  'b3733',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3733'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpA',
  'ATP synthase F1 complex subunit alpha',
  3918316,
  3919857,
  -1,
  'b3734',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3734'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpH',
  'ATP synthase F1 complex subunit delta',
  3919870,
  3920403,
  -1,
  'b3735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3735'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpF',
  'ATP synthase Fo complex subunit b',
  3920418,
  3920888,
  -1,
  'b3736',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3736'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpE',
  'ATP synthase Fo complex subunit c',
  3920950,
  3921189,
  -1,
  'b3737',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3737'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpB',
  'ATP synthase Fo complex subunit a',
  3921236,
  3922051,
  -1,
  'b3738',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3738'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atpI',
  'ATP synthase accessory factor AtpI',
  3922060,
  3922440,
  -1,
  'b3739',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3739'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmG',
  '16S rRNA m(7)G527 methyltransferase',
  3923057,
  3923680,
  -1,
  'b3740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3740'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mnmG',
  '5-carboxymethylaminomethyluridine-tRNA synthasesubunit MnmG',
  3923744,
  3925633,
  -1,
  'b3741',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3741'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mioC',
  'flavoprotein MioC',
  3926012,
  3926455,
  -1,
  'b3742',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3742'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asnC',
  'DNA-binding transcriptional dual regulator AsnC',
  3926545,
  3927003,
  -1,
  'b3743',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3743'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asnA',
  'asparagine synthetase A',
  3927155,
  3928147,
  1,
  'b3744',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3744'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'viaA',
  'protein ViaA',
  3928152,
  3929603,
  -1,
  'b3745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3745'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ravA',
  'regulatory ATPase RavA',
  3929597,
  3931093,
  -1,
  'b3746',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3746'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kup',
  'K(+):H(+) symporter Kup',
  3931316,
  3933184,
  1,
  'b3747',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3747'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsD',
  'D-ribose pyranase',
  3933351,
  3933770,
  1,
  'b3748',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3748'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsA',
  'ribose ABC transporter ATP binding subunit',
  3933778,
  3935283,
  1,
  'b3749',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3749'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsC',
  'ribose ABC transporter membrane subunit',
  3935288,
  3936253,
  1,
  'b3750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3750'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsB',
  'ribose ABC transporter periplasmic bindingprotein',
  3936278,
  3937168,
  1,
  'b3751',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3751'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsZ',
  '—',
  3937045,
  3937278,
  1,
  'b4804',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4804'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsK',
  'ribokinase',
  3937294,
  3938223,
  1,
  'b3752',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3752'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbsR',
  'DNA-binding transcriptional dual regulator RbsR',
  3938227,
  3939219,
  1,
  'b3753',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3753'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hsrA',
  'putative transporter HsrA',
  3939185,
  3940612,
  -1,
  'b3754',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3754'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yieP',
  'DNA-binding transcriptional dual regulator YieP',
  3940635,
  3941327,
  -1,
  'b3755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3755'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrsC',
  '—',
  3941808,
  3943349,
  1,
  'b3756',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3756'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltU',
  '—',
  3943435,
  3943510,
  1,
  'b3757',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3757'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrlC',
  '—',
  3943704,
  3946607,
  1,
  'b3758',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3758'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfC',
  '—',
  3946700,
  3946819,
  1,
  'b3759',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3759'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aspT',
  '—',
  3946872,
  3946948,
  1,
  'b3760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3760'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpT',
  '—',
  3946957,
  3947032,
  1,
  'b3761',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3761'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hdfR',
  'DNA-binding transcriptional dual regulator HdfR',
  3947128,
  3947967,
  -1,
  'b4480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4480'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'maoP',
  'macrodomain Ori protein',
  3948086,
  3948424,
  1,
  'b3764',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3764'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yifB',
  'putative magnesium chelatase YifB',
  3948449,
  3949969,
  -1,
  'b3765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3765'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvL',
  'ilvXGMEDA operon leader peptide',
  3950322,
  3950420,
  1,
  'b3766',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3766'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvX',
  'uncharacterized protein IlvX',
  3950507,
  3950557,
  1,
  'b4669',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4669'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvG',
  '—',
  3950560,
  3952204,
  1,
  'b4488',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4488'
);
COMMIT;