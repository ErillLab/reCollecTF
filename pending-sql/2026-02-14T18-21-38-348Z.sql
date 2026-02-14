PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvM',
  'acetolactate synthase II subunit IlvM',
  3952201,
  3952464,
  1,
  'b3769',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3769'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvE',
  'branched-chain-amino-acid aminotransferase',
  3952484,
  3953413,
  1,
  'b3770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3770'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvD',
  'dihydroxy-acid dehydratase',
  3953478,
  3955328,
  1,
  'b3771',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3771'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvA',
  'threonine deaminase',
  3955331,
  3956875,
  1,
  'b3772',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3772'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvY',
  'DNA-binding transcriptional dual regulator IlvY',
  3956927,
  3957820,
  -1,
  'b3773',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3773'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ilvC',
  'ketol-acid reductoisomerase (NADP(+))',
  3957970,
  3959445,
  1,
  'b3774',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3774'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppiC',
  'peptidyl-prolyl cis-trans isomerase C',
  3959532,
  3959813,
  -1,
  'b3775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3775'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yifN',
  '—',
  3960012,
  3960460,
  -1,
  'b3777',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3777'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rep',
  'ATP-dependent DNA helicase Rep',
  3960677,
  3962698,
  1,
  'b3778',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3778'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gpp',
  'guanosine-5''-triphosphate,3''-diphosphatephosphatase',
  3962745,
  3964229,
  -1,
  'b3779',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3779'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhlB',
  'ATP-dependent RNA helicase RhlB',
  3964365,
  3965630,
  -1,
  'b3780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3780'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trxA',
  'thioredoxin 1',
  3965761,
  3966090,
  1,
  'b3781',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3781'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhoL',
  'rho operon leader peptide',
  3966231,
  3966332,
  1,
  'b3782',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3782'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rho',
  'transcription termination factor Rho',
  3966417,
  3967676,
  1,
  'b3783',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3783'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wecA',
  'UDP-N-acetylglucosamine--undecaprenyl-phosphateN-acetylglucosaminephosphotransferase',
  3967916,
  3969019,
  1,
  'b3784',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3784'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzzE',
  'enterobacterial common antigen polysaccharideco-polymerase',
  3969031,
  3970077,
  1,
  'b3785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3785'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wecB',
  'UDP-N-acetylglucosamine 2-epimerase',
  3970133,
  3971263,
  1,
  'b3786',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3786'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wecC',
  'UDP-N-acetyl-D-mannosamine dehydrogenase',
  3971260,
  3972522,
  1,
  'b3787',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3787'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rffG',
  'dTDP-glucose 4,6-dehydratase 2',
  3972522,
  3973589,
  1,
  'b3788',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3788'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rffH',
  'glucose-1-phosphate thymidylyltransferase 2',
  3973608,
  3974489,
  1,
  'b3789',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3789'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rffC',
  'dTDP-4-amino-4,6-dideoxy-D-galactoseacyltransferase',
  3974467,
  3975141,
  1,
  'b3790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3790'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wecE',
  'dTDP-4-dehydro-6-deoxy-D-glucose transaminase',
  3975146,
  3976276,
  1,
  'b3791',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3791'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzxE',
  'lipid IIIECA flippase',
  3976278,
  3977528,
  1,
  'b3792',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3792'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wecF',
  'TDP-N-acetylfucosamine:lipid IIN-acetylfucosaminyltransferase',
  3977525,
  3978604,
  1,
  'b4481',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4481'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzyE',
  'enterobacterial common antigen polymerase',
  3978601,
  3979953,
  1,
  'b3793',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3793'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rffM',
  'UDP-N-acetyl-D-mannosaminuronic acidtransferase',
  3979956,
  3980696,
  1,
  'b3794',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3794'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thrP',
  'threonine/serine:H(+) symporter ThrP',
  3980887,
  3982272,
  1,
  'b3795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3795'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argX',
  '—',
  3982375,
  3982451,
  1,
  'b3796',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3796'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisR',
  '—',
  3982509,
  3982585,
  1,
  'b3797',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3797'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuT',
  '—',
  3982606,
  3982692,
  1,
  'b3798',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3798'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proM',
  '—',
  3982735,
  3982811,
  1,
  'b3799',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3799'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aslB',
  'putative anaerobic sulfatase maturation enzymeAslB',
  3982958,
  3984193,
  1,
  'b3800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3800'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aslA',
  'putative sulfatase AslA',
  3984352,
  3986007,
  -1,
  'b3801',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3801'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glmZ',
  '—',
  3986432,
  3986603,
  1,
  'b4456',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4456'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemY',
  'protein HemY',
  3986686,
  3987882,
  -1,
  'b3802',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3802'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemX',
  'PF04375 family protein HemX',
  3987885,
  3989066,
  -1,
  'b3803',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3803'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemD',
  'uroporphyrinogen-III synthase',
  3989088,
  3989828,
  -1,
  'b3804',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3804'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemC',
  'hydroxymethylbilane synthase',
  3989825,
  3990766,
  -1,
  'b3805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3805'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cyaA',
  'adenylate cyclase',
  3991153,
  3993699,
  1,
  'b3806',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3806'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cyaY',
  'frataxin CyaY',
  3993739,
  3994059,
  -1,
  'b3807',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3807'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yzcX',
  'protein YzcX',
  3993850,
  3994335,
  1,
  'b3808',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3808'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lptM',
  'LptD oxidative maturation-associatedlipoprotein',
  3994522,
  3994725,
  1,
  'b4558',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4558'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dapF',
  'diaminopimelate epimerase',
  3994762,
  3995586,
  1,
  'b3809',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3809'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigA',
  'DUF484 domain-containing protein YigA',
  3995583,
  3996290,
  1,
  'b3810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3810'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xerC',
  'site-specific tyrosine recombinase',
  3996287,
  3997183,
  1,
  'b3811',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3811'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigB',
  '5-amino-6-(5-phospho-D-ribitylamino)uracilphosphatase',
  3997183,
  3997899,
  1,
  'b3812',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3812'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uvrD',
  'DNA helicase II',
  3997983,
  4000145,
  1,
  'b3813',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3813'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigE',
  'DUF2233 domain-containing protein YigE',
  4000292,
  4001056,
  -1,
  'b4482',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4482'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysgD',
  'protein YsgD',
  4001218,
  4001274,
  1,
  'b4799',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4799'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'corA',
  'Ni(2(+))/Co(2(+))/Mg(2(+)) transporter',
  4001426,
  4002376,
  1,
  'b3816',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3816'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigF',
  'DUF2628 domain-containing protein YigF',
  4002419,
  4002799,
  -1,
  'b3817',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3817'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigG',
  'inner membrane protein YigG',
  4002813,
  4003193,
  -1,
  'b3818',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3818'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rarD',
  'putative transporter RarD',
  4003288,
  4004178,
  -1,
  'b3819',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3819'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigI',
  'acyl-CoA thioesterase YigI',
  4004230,
  4004697,
  -1,
  'b3820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3820'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pldA',
  'outer membrane phospholipase A',
  4004862,
  4005731,
  1,
  'b3821',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3821'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recQ',
  'ATP-dependent DNA helicase RecQ',
  4005864,
  4007693,
  1,
  'b3822',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3822'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhtC',
  'L-threonine exporter',
  4007757,
  4008377,
  1,
  'b3823',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3823'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhtB',
  'L-homoserine/L-homoserine lactone/L-threonineexporter',
  4008439,
  4009059,
  -1,
  'b3824',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3824'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pldB',
  'lysophospholipase L2',
  4009170,
  4010192,
  1,
  'b3825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3825'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigL',
  'phosphosugar phosphatase YigL',
  4010200,
  4011000,
  1,
  'b3826',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3826'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bioP',
  'biotin transporter',
  4011076,
  4011975,
  1,
  'b3827',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3827'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metR',
  'DNA-binding transcriptional dual regulator MetR',
  4011863,
  4012816,
  -1,
  'b3828',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3828'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metE',
  'cobalamin-independent homocysteinetransmethylase',
  4013053,
  4015314,
  1,
  'b3829',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3829'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ysgA',
  'putative dienelactone hydrolase',
  4015354,
  4016169,
  -1,
  'b3830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3830'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'udp',
  'uridine phosphorylase',
  4016431,
  4017192,
  1,
  'b3831',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3831'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rmuC',
  'putative recombination limiting protein RmuC',
  4017333,
  4018760,
  1,
  'b3832',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3832'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiE',
  'bifunctional2-octaprenyl-6-methoxy-1,4-benzoquinol methylase anddemethylmenaquinone methyltransferase',
  4018855,
  4019610,
  1,
  'b3833',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3833'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiJ',
  'ubiquinone biosynthesis accessory factor UbiJ',
  4019624,
  4020229,
  1,
  'b3834',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3834'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'esrE',
  '—',
  4019978,
  4020229,
  1,
  'b4707',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4707'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiB',
  'ubiquinone biosynthesis protein UbiB',
  4020226,
  4021866,
  1,
  'b3835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3835'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tatA',
  'twin arginine protein translocation system -TatA protein',
  4021945,
  4022214,
  1,
  'b3836',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3836'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tatB',
  'twin arginine protein translocation system -TatB protein',
  4022218,
  4022733,
  1,
  'b3838',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3838'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tatC',
  'twin arginine protein translocation system -TatC protein',
  4022736,
  4023512,
  1,
  'b3839',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3839'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tatD',
  '3'' -> 5'' ssDNA/RNA exonuclease TatD',
  4023554,
  4024336,
  1,
  'b4483',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4483'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfaH',
  'transcription antiterminator RfaH',
  4024333,
  4024821,
  -1,
  'b3842',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3842'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiD',
  '3-octaprenyl-4-hydroxybenzoate decarboxylase',
  4024988,
  4026481,
  1,
  'b3843',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3843'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fre',
  'NAD(P)H-flavin reductase',
  4026527,
  4027228,
  1,
  'b3844',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3844'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadA',
  '3-ketoacyl-CoA thiolase',
  4027609,
  4028772,
  -1,
  'b3845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3845'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadB',
  'multifunctional enoyl-CoA hydratase,3-hydroxyacyl-CoA epimerase, Delta(3)-cis-Delta(2)-trans-enoyl-CoA isomerase, L-3-hydroxyacyl-CoAdehydrogenase',
  4028782,
  4030971,
  -1,
  'b3846',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3846'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pepQ',
  'Xaa-Pro dipeptidase',
  4031161,
  4032492,
  1,
  'b3847',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3847'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yigZ',
  'IMPACT family member YigZ',
  4032492,
  4033106,
  1,
  'b3848',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3848'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trkH',
  'K(+) transporter TrkH',
  4033145,
  4034596,
  1,
  'b3849',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3849'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemG',
  'protoporphyrinogen oxidase',
  4034608,
  4035153,
  1,
  'b3850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3850'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrsA',
  '—',
  4035531,
  4037072,
  1,
  'b3851',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3851'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ileT',
  '—',
  4037141,
  4037217,
  1,
  'b3852',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3852'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaT',
  '—',
  4037260,
  4037335,
  1,
  'b3853',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3853'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrlA',
  '—',
  4037519,
  4040423,
  1,
  'b3854',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3854'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfA',
  '—',
  4040517,
  4040636,
  1,
  'b3855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3855'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mobB',
  'molybdopterin-guanine dinucleotide biosynthesisadaptor protein',
  4040906,
  4041433,
  -1,
  'b3856',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3856'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mobA',
  'molybdenum cofactor guanylyltransferase',
  4041415,
  4041999,
  -1,
  'b3857',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3857'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihD',
  'DUF1040 domain-containing protein YihD',
  4042069,
  4042338,
  1,
  'b3858',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3858'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srkA',
  'stress response kinase A',
  4042415,
  4043401,
  1,
  'b3859',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3859'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsbA',
  'thiol:disulfide oxidoreductase DsbA',
  4043418,
  4044044,
  1,
  'b3860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3860'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihF',
  'DUF945 domain-containing protein YihF',
  4044199,
  4045629,
  1,
  'b3861',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3861'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihG',
  '1-acylglycerol-3-phosphate O-acyltransferaseYihG',
  4045670,
  4046602,
  -1,
  'b3862',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3862'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'polA',
  'DNA polymerase I',
  4046966,
  4049752,
  1,
  'b3863',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3863'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'spf',
  '—',
  4049899,
  4050009,
  1,
  'b3864',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3864'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'spfP',
  'dual-function small protein SpfP',
  4049917,
  4049964,
  1,
  'b4837',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4837'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihA',
  'GTP-binding protein YihA',
  4050133,
  4050765,
  -1,
  'b3865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3865'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csrC',
  '—',
  4051036,
  4051281,
  1,
  'b4457',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4457'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihI',
  'Der GTPase-activating protein YihI',
  4051347,
  4051856,
  1,
  'b3866',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3866'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemN',
  'coproporphyrinogen III dehydrogenase',
  4052045,
  4053418,
  1,
  'b3867',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3867'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yshB',
  'uncharacterized protein YshB',
  4053647,
  4053757,
  -1,
  'b4686',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4686'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glnG',
  'DNA-binding transcriptional dual regulator NtrC',
  4053869,
  4055278,
  -1,
  'b3868',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3868'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glnL',
  'protein histidine kinase NtrB',
  4055290,
  4056339,
  -1,
  'b3869',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3869'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glnZ',
  '—',
  4056428,
  4056621,
  -1,
  'b4836',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4836'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glnA',
  'glutamine synthetase',
  4056625,
  4058034,
  -1,
  'b3870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3870'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bipA',
  '50S ribosomal subunit assembly factor BipA',
  4058407,
  4060230,
  1,
  'b3871',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3871'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihL',
  'putative DNA-binding transcriptional regulatorYihL',
  4060447,
  4061157,
  1,
  'b3872',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3872'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihM',
  'putative TIM barrel domain-containing proteinYihM',
  4061165,
  4062145,
  1,
  'b3873',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3873'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihN',
  'putative transporter YihN',
  4062247,
  4063512,
  1,
  'b3874',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3874'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ompL',
  'putative outer membrane porin L',
  4063603,
  4064295,
  -1,
  'b3875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3875'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihO',
  'putative sulfoquinovose transporter',
  4064363,
  4065766,
  -1,
  'b3876',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3876'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihP',
  'putative 2,3-dihydroxypropane-1-sulfonate exportprotein',
  4065809,
  4067194,
  -1,
  'b3877',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3877'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihQ',
  'sulfoquinovosidase',
  4067240,
  4069276,
  -1,
  'b3878',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3878'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihR',
  'putative sulfoquinovose mutarotase YihR',
  4069475,
  4070401,
  -1,
  'b3879',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3879'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihS',
  'sulfoquinovose isomerase',
  4070515,
  4071756,
  -1,
  'b3880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3880'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihT',
  '6-deoxy-6-sulfofructose-1-phosphate aldolase',
  4071773,
  4072651,
  -1,
  'b3881',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3881'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihU',
  '3-sulfolactaldehyde reductase',
  4072675,
  4073571,
  -1,
  'b3882',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3882'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihV',
  '6-deoxy-6-sulfofructose kinase',
  4073739,
  4074635,
  1,
  'b3883',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3883'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csqR',
  'DNA-binding transcriptional dual regulator CsqR',
  4074669,
  4075454,
  1,
  'b3884',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3884'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihX',
  'alpha-D-glucose-1-phosphate phosphatase YihX',
  4075553,
  4076152,
  1,
  'b3885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3885'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yihY',
  'PF03631 family membrane protein YihY',
  4076146,
  4077018,
  1,
  'b3886',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3886'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dtd',
  'D-aminoacyl-tRNA deacylase',
  4077015,
  4077452,
  1,
  'b3887',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3887'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fabY',
  'putative fatty acid biosynthesis enzyme FabY',
  4077449,
  4078438,
  1,
  'b3888',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3888'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiE',
  'putative DNA-binding transcriptional regulatorYiiE',
  4079291,
  4079509,
  1,
  'b3889',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3889'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiF',
  'protein YiiF',
  4079751,
  4079969,
  1,
  'b3890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3890'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdhE',
  'formate dehydrogenase formation protein',
  4080299,
  4081228,
  -1,
  'b3891',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3891'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdoI',
  'formate dehydrogenase O subunit gamma',
  4081225,
  4081860,
  -1,
  'b3892',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3892'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdoH',
  'formate dehydrogenase O subunit beta',
  4081857,
  4082759,
  -1,
  'b3893',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3893'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdoG',
  'formate dehydrogenase O subunit alpha',
  4082772,
  4085822,
  -1,
  'b3894',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3894'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdhD',
  'sulfurtransferase for molybdenum cofactorsulfuration',
  4086016,
  4086849,
  1,
  'b3895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3895'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiG',
  'DUF3829 domain-containing lipoprotein YiiG',
  4087002,
  4088057,
  1,
  'b3896',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3896'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frvR',
  'putative DNA-binding transcriptional regulatorFrvR',
  4088107,
  4089855,
  -1,
  'b3897',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3897'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frvX',
  'peptidase M42 family protein FrvX',
  4089855,
  4090925,
  -1,
  'b3898',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3898'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frvB',
  'putative PTS enzyme IIBC component FrvB',
  4090915,
  4092366,
  -1,
  'b3899',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3899'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frvA',
  'putative PTS enzyme IIA component FrvA',
  4092377,
  4092823,
  -1,
  'b3900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3900'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaM',
  'L-rhamnose mutarotase',
  4093124,
  4093438,
  -1,
  'b3901',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3901'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaD',
  'rhamnulose-1-phosphate aldolase',
  4093448,
  4094272,
  -1,
  'b3902',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3902'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaA',
  'L-rhamnose isomerase',
  4094723,
  4095982,
  -1,
  'b3903',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3903'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaB',
  'rhamnulokinase',
  4095979,
  4097448,
  -1,
  'b3904',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3904'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaS',
  'DNA-binding transcriptional activator RhaS',
  4097736,
  4098572,
  1,
  'b3905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3905'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaR',
  'DNA-binding transcriptional activator RhaR',
  4098646,
  4099494,
  1,
  'b3906',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3906'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhaT',
  'rhamnose/lyxose:H(+) symporter',
  4099491,
  4100525,
  -1,
  'b3907',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3907'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sodA',
  'superoxide dismutase (Mn)',
  4100810,
  4101430,
  1,
  'b3908',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3908'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kdgT',
  '2-dehydro-3-deoxy-D-gluconate:H(+) symporter',
  4101690,
  4102673,
  1,
  'b3909',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3909'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiM',
  '6-hydroxyaminopurine reductase',
  4102822,
  4103496,
  1,
  'b3910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3910'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpxA',
  'sensor histidine kinase CpxA',
  4103602,
  4104975,
  -1,
  'b3911',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3911'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpxR',
  'DNA-binding transcriptional dual regulator CpxR',
  4104972,
  4105670,
  -1,
  'b3912',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3912'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpxP',
  'periplasmic protein CpxP',
  4105820,
  4106320,
  1,
  'b4484',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4484'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpxQ',
  '—',
  4106330,
  4106387,
  1,
  'b4716',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4716'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fieF',
  'Zn(2(+))/Fe(2(+))/Cd(2(+)) exporter',
  4106469,
  4107371,
  1,
  'b3915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3915'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pfkA',
  '6-phosphofructokinase 1',
  4107552,
  4108514,
  1,
  'b3916',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3916'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sbp',
  'sulfate/thiosulfate ABC transporter periplasmicbinding protein Sbp',
  4108834,
  4109823,
  1,
  'b3917',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3917'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cdh',
  'CDP-diacylglycerol diphosphatase',
  4109930,
  4110685,
  1,
  'b3918',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3918'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tpiA',
  'triose-phosphate isomerase',
  4110740,
  4111507,
  -1,
  'b3919',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3919'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiQ',
  'DUF1454 domain-containing protein YiiQ',
  4111615,
  4112214,
  -1,
  'b3920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3920'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiR',
  'DUF805 domain-containing protein YiiR',
  4112315,
  4112755,
  1,
  'b3921',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3921'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiS',
  'DUF406 domain-containing protein YiiS',
  4112967,
  4113266,
  1,
  'b3922',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3922'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uspD',
  'universal stress protein D',
  4113293,
  4113721,
  1,
  'b3923',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3923'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fpr',
  'flavodoxin/ferredoxin-NADP(+) reductase',
  4113726,
  4114472,
  -1,
  'b3924',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3924'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpX',
  'fructose-1,6-bisphosphatase 2',
  4114569,
  4115579,
  -1,
  'b3925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3925'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpK',
  'glycerol kinase',
  4115714,
  4117222,
  -1,
  'b3926',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3926'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpF',
  'glycerol facilitator',
  4117245,
  4118090,
  -1,
  'b3927',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3927'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zapB',
  'cell division factor ZapB',
  4118515,
  4118760,
  1,
  'b3928',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3928'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rraA',
  'ribonuclease E inhibitor protein A',
  4118845,
  4119330,
  -1,
  'b3929',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3929'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menA',
  '1,4-dihydroxy-2-naphthoateoctaprenyltransferase',
  4119423,
  4120349,
  -1,
  'b3930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3930'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hslU',
  'ATPase component of the HslVU protease',
  4120416,
  4121747,
  -1,
  'b3931',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3931'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hslV',
  'peptidase component of the HslVU protease',
  4121757,
  4122287,
  -1,
  'b3932',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3932'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsN',
  'cell division protein FtsN',
  4122380,
  4123339,
  -1,
  'b3933',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3933'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cytR',
  'CytR',
  4123431,
  4124456,
  -1,
  'b3934',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3934'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'priA',
  'primosomal protein N''',
  4124612,
  4126810,
  -1,
  'b3935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3935'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmE',
  '50S ribosomal subunit protein L31',
  4127013,
  4127225,
  1,
  'b3936',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3936'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yiiX',
  'putative lipid-binding hydrolase YiiX',
  4127286,
  4127894,
  -1,
  'b3937',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3937'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metJ',
  'DNA-binding transcriptional repressor MetJ',
  4128078,
  4128395,
  -1,
  'b3938',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3938'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metB',
  'O-succinylhomoserine(thiol)-lyase/O-succinylhomoserine lyase',
  4128672,
  4129832,
  1,
  'b3939',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3939'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metL',
  'fused aspartate kinase/homoserine dehydrogenase2',
  4129835,
  4132267,
  1,
  'b3940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3940'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metF',
  '5,10-methylenetetrahydrofolate reductase',
  4132616,
  4133506,
  1,
  'b3941',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3941'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'katG',
  'catalase/hydroperoxidase HPI',
  4133835,
  4136015,
  1,
  'b3942',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3942'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yijE',
  'cystine exporter',
  4136108,
  4137013,
  1,
  'b3943',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3943'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yijF',
  'DUF1287 domain-containing protein YijF',
  4137040,
  4137657,
  -1,
  'b3944',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3944'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gldA',
  'L-1,2-propanediol dehydrogenase/glyceroldehydrogenase',
  4137932,
  4139035,
  -1,
  'b3945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3945'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fsaB',
  'fructose-6-phosphate aldolase 2',
  4139046,
  4139708,
  -1,
  'b3946',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3946'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptsA',
  'putative PTS multiphosphoryl transfer proteinPtsA',
  4139720,
  4142221,
  -1,
  'b3947',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3947'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frwC',
  'putative PTS enzyme IIC component FrwC',
  4142530,
  4143609,
  1,
  'b3949',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3949'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frwB',
  'putative PTS enzyme IIB component FrwB',
  4143624,
  4143944,
  1,
  'b3950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3950'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pflD',
  'putative formate acetyltransferase 2',
  4143995,
  4146292,
  1,
  'b3951',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3951'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pflC',
  'putative pyruvate formate-lyase 2 activatingenzyme PflC',
  4146258,
  4147136,
  1,
  'b3952',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3952'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frwD',
  'putative PTS enzyme IIB component FrwD',
  4147138,
  4147479,
  1,
  'b3953',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3953'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yijO',
  'putative DNA-binding transcriptional regulatorYijO',
  4147466,
  4148317,
  -1,
  'b3954',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3954'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eptC',
  'phosphoethanolamine transferase EptC',
  4148532,
  4150265,
  -1,
  'b3955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3955'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppc',
  'phosphoenolpyruvate carboxylase',
  4150447,
  4153098,
  -1,
  'b3956',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3956'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argE',
  'acetylornithine deacetylase',
  4153696,
  4154847,
  -1,
  'b3957',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3957'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argC',
  'N-acetylglutamylphosphate reductase',
  4155001,
  4156005,
  1,
  'b3958',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3958'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argB',
  'acetylglutamate kinase',
  4156013,
  4156789,
  1,
  'b3959',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3959'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argH',
  'argininosuccinate lyase',
  4156850,
  4158223,
  1,
  'b3960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3960'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'oxyS',
  '—',
  4158278,
  4158394,
  -1,
  'b4458',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4458'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'oxyR',
  'DNA-binding transcriptional dual regulator OxyR',
  4158490,
  4159407,
  1,
  'b3961',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3961'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sthA',
  'soluble pyridine nucleotide transhydrogenase',
  4159390,
  4160790,
  -1,
  'b3962',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3962'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fabR',
  'DNA-binding transcriptional repressor FabR',
  4161067,
  4161771,
  1,
  'b3963',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3963'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yijD',
  'DUF1422 domain-containing inner membrane proteinYijD',
  4161771,
  4162130,
  1,
  'b3964',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3964'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trmA',
  'tRNA m(5)U54 methyltransferase',
  4162170,
  4163270,
  -1,
  'b3965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3965'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btuB',
  'cobalamin outer membrane transporter',
  4163639,
  4165483,
  1,
  'b3966',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3966'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'murI',
  'glutamate racemase',
  4165428,
  4166285,
  1,
  'b3967',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3967'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrsB',
  '—',
  4166659,
  4168200,
  1,
  'b3968',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3968'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltT',
  '—',
  4168372,
  4168447,
  1,
  'b3969',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3969'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrlB',
  '—',
  4168641,
  4171544,
  1,
  'b3970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3970'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfB',
  '—',
  4171637,
  4171756,
  1,
  'b3971',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3971'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'murB',
  'UDP-N-acetylenolpyruvoylglucosamine reductase',
  4172057,
  4173085,
  1,
  'b3972',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3972'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'birA',
  'DNA-binding transcriptionalrepressor/biotin-[acetyl-CoA-carboxylase] ligase BirA',
  4173082,
  4174047,
  1,
  'b3973',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3973'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'coaA',
  'pantothenate kinase',
  4174076,
  4175026,
  -1,
  'b3974',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3974'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thrU',
  '—',
  4175388,
  4175463,
  1,
  'b3976',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3976'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tyrU',
  '—',
  4175472,
  4175556,
  1,
  'b3977',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3977'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyT',
  '—',
  4175673,
  4175747,
  1,
  'b3978',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3978'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thrT',
  '—',
  4175754,
  4175829,
  1,
  'b3979',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3979'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tufB',
  'translation elongation factor Tu 2',
  4175944,
  4177128,
  1,
  'b3980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3980'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'secE',
  'Sec translocon subunit SecE',
  4177358,
  4177741,
  1,
  'b3981',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3981'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nusG',
  'transcription termination/antitermination factorNusG',
  4177743,
  4178288,
  1,
  'b3982',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3982'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplK',
  '50S ribosomal subunit protein L11',
  4178447,
  4178875,
  1,
  'b3983',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3983'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplA',
  '50S ribosomal subunit protein L1',
  4178879,
  4179583,
  1,
  'b3984',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3984'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplJ',
  '50S ribosomal subunit protein L10',
  4179996,
  4180493,
  1,
  'b3985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3985'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplL',
  '50S ribosomal subunit protein L12',
  4180560,
  4180925,
  1,
  'b3986',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3986'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoB',
  'RNA polymerase subunit beta',
  4181245,
  4185273,
  1,
  'b3987',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3987'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoC',
  'RNA polymerase subunit beta''',
  4185350,
  4189573,
  1,
  'b3988',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3988'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjaZ',
  'protein YjaZ',
  4189786,
  4190325,
  1,
  'b3989',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3989'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sroH',
  '—',
  4190327,
  4190487,
  -1,
  'b4691',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4691'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiH',
  '2-iminoacetate synthase',
  4190735,
  4191868,
  -1,
  'b3990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3990'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiG',
  '1-deoxy-D-xylulose 5-phosphate:thiolsulfurtransferase',
  4191865,
  4192635,
  -1,
  'b3991',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3991'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiS',
  'sulfur carrier protein ThiS',
  4192637,
  4192837,
  -1,
  'b4407',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4407'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiF',
  'sulfur carrier protein ThiS adenylyltransferase',
  4192821,
  4193576,
  -1,
  'b3992',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3992'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiE',
  'thiamine phosphate synthase',
  4193569,
  4194204,
  -1,
  'b3993',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3993'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiC',
  'phosphomethylpyrimidine synthase',
  4194204,
  4196099,
  -1,
  'b3994',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3994'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsd',
  'regulator of sigma D',
  4196332,
  4196808,
  -1,
  'b3995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3995'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudC',
  'RNA decapping hydrolase',
  4196903,
  4197676,
  1,
  'b3996',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3996'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemE',
  'uroporphyrinogen decarboxylase',
  4197716,
  4198780,
  1,
  'b3997',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3997'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nfi',
  'endonuclease V',
  4198790,
  4199461,
  1,
  'b3998',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3998'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjaG',
  'DUF416 domain-containing protein YjaG',
  4199504,
  4200094,
  1,
  'b3999',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3999'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hupA',
  'DNA-binding protein HU-alpha',
  4200281,
  4200553,
  1,
  'b4000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4000'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjaH',
  'DUF1481 domain-containing protein YjaH',
  4200566,
  4201261,
  1,
  'b4001',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4001'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zraP',
  'signaling pathway modulator ZraP',
  4201263,
  4201688,
  -1,
  'b4002',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4002'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zraS',
  'sensor histidine kinase ZraS',
  4201926,
  4203323,
  1,
  'b4003',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4003'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zraR',
  'DNA-binding transcriptional activator ZraR',
  4203320,
  4204645,
  1,
  'b4004',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4004'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purD',
  'phosphoribosylamine--glycine ligase',
  4204642,
  4205931,
  -1,
  'b4005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4005'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purH',
  'bifunctional AICAR transformylase/IMPcyclohydrolase',
  4205943,
  4207532,
  -1,
  'b4006',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4006'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrsE',
  '—',
  4208147,
  4209688,
  1,
  'b4007',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4007'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltV',
  '—',
  4209774,
  4209849,
  1,
  'b4008',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4008'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrlE',
  '—',
  4210043,
  4212946,
  1,
  'b4009',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4009'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfE',
  '—',
  4213040,
  4213159,
  1,
  'b4010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4010'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjaA',
  'stress response protein',
  4213234,
  4213617,
  1,
  'b4011',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4011'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjaB',
  'peptidyl-lysine N-acetyltransferase YjaB',
  4213680,
  4214123,
  -1,
  'b4012',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4012'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metA',
  'homoserine O-succinyltransferase',
  4214280,
  4215209,
  1,
  'b4013',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4013'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aceB',
  'malate synthase A',
  4215478,
  4217079,
  1,
  'b4014',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4014'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aceA',
  'isocitrate lyase',
  4217109,
  4218413,
  1,
  'b4015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4015'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aceK',
  'isocitrate dehydrogenase kinase/phosphatase',
  4218596,
  4220332,
  1,
  'b4016',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4016'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aceK-int',
  '—',
  4218879,
  4218963,
  1,
  'b4830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4830'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arpA',
  'ankyrin-like regulator',
  4220301,
  4222487,
  -1,
  'b4017',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4017'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iclR',
  'DNA-binding transcriptional repressor IclR',
  4222804,
  4223628,
  -1,
  'b4018',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4018'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metH',
  'cobalamin-dependent methionine synthase',
  4223828,
  4227511,
  1,
  'b4019',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4019'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbB',
  'putative inorganic phosphate export proteinYjbB',
  4227731,
  4229362,
  1,
  'b4020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4020'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pepE',
  'peptidase E',
  4229453,
  4230142,
  -1,
  'b4021',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4021'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rluF',
  '23S rRNA pseudouridine(2604) and tRNA(Tyr)pseudouridine(35) synthase',
  4230354,
  4231226,
  1,
  'b4022',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4022'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbD',
  'DUF3811 domain-containing protein YjbD',
  4231359,
  4231631,
  -1,
  'b4023',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4023'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysC',
  'aspartate kinase III',
  4231884,
  4233233,
  -1,
  'b4024',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4024'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pgi',
  'glucose-6-phosphate isomerase',
  4233758,
  4235407,
  1,
  'b4025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4025'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbE',
  'uncharacterized protein YjbE',
  4235906,
  4236148,
  1,
  'b4026',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4026'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbF',
  'lipoprotein YjbF',
  4236262,
  4236900,
  1,
  'b4027',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4027'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbG',
  'capsule biosynthesis GfcC family protein YjbG',
  4236897,
  4237634,
  1,
  'b4028',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4028'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbH',
  'putative lipoprotein YjbH',
  4237634,
  4239730,
  1,
  'b4029',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4029'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbT',
  'PF17089 family protein YjbT',
  4239777,
  4240055,
  -1,
  'b4620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4620'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'psiE',
  'putative phosphate starvation-inducible proteinPsiE',
  4240325,
  4240735,
  1,
  'b4030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4030'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xylE',
  'D-xylose:H(+) symporter',
  4240779,
  4242254,
  -1,
  'b4031',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4031'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malH',
  '—',
  4242531,
  4242633,
  -1,
  'b4807',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4807'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malG',
  'maltose ABC transporter membrane subunit MalG',
  4242626,
  4243516,
  -1,
  'b4032',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4032'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malF',
  'maltose ABC transporter membrane subunit MalF',
  4243531,
  4245075,
  -1,
  'b4033',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4033'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malE',
  'maltose ABC transporter periplasmic bindingprotein',
  4245229,
  4246419,
  -1,
  'b4034',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4034'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malK',
  'maltose ABC transporter ATP binding subunit',
  4246784,
  4247899,
  1,
  'b4035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4035'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lamB',
  'maltose outer membrane channel/phage lambdareceptor protein',
  4247971,
  4249311,
  1,
  'b4036',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4036'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malM',
  'maltose regulon periplasmic protein',
  4249554,
  4250474,
  1,
  'b4037',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4037'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbI',
  '—',
  4250703,
  4252283,
  1,
  'b4038',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4038'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiC',
  'chorismate lyase',
  4252506,
  4253003,
  1,
  'b4039',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4039'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiA',
  '4-hydroxybenzoate octaprenyltransferase',
  4253016,
  4253888,
  1,
  'b4040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4040'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'plsB',
  'glycerol-3-phosphate 1-O-acyltransferase',
  4254043,
  4256466,
  -1,
  'b4041',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4041'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgkA',
  'diacylglycerol kinase',
  4256637,
  4257005,
  1,
  'b4042',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4042'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lexA',
  'DNA-binding transcriptional repressor LexA',
  4257115,
  4257723,
  1,
  'b4043',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4043'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dinF',
  'DNA damage-inducible protein F',
  4257742,
  4259121,
  1,
  'b4044',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4044'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbJ',
  'putative stress response protein YjbJ',
  4259237,
  4259446,
  1,
  'b4045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4045'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zur',
  'DNA-binding transcriptional repressor Zur',
  4259488,
  4260003,
  -1,
  'b4046',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4046'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbL',
  'uncharacterized protein YjbL',
  4260321,
  4260575,
  1,
  'b4047',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4047'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbM',
  'DUF2713 domain-containing protein YjbM',
  4260599,
  4261306,
  1,
  'b4048',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4048'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dusA',
  'tRNA-dihydrouridine synthase A',
  4261669,
  4262706,
  1,
  'b4049',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4049'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspG',
  'phage shock protein G',
  4262840,
  4263082,
  1,
  'b4050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4050'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspH',
  '—',
  4263139,
  4263249,
  1,
  'b4758',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4758'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'qorA',
  'putative quinone oxidoreductase 1',
  4263248,
  4264231,
  -1,
  'b4051',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4051'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dnaB',
  'replicative DNA helicase',
  4264314,
  4265729,
  1,
  'b4052',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4052'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alr',
  'alanine racemase 1',
  4265782,
  4266861,
  1,
  'b4053',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4053'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tyrB',
  'tyrosine aminotransferase',
  4267114,
  4268307,
  1,
  'b4054',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4054'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbS',
  'uncharacterized protein YjbS',
  4268809,
  4269012,
  -1,
  'b4621',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4621'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aphA',
  'acid phosphatase/phosphotransferase',
  4269414,
  4270127,
  1,
  'b4055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4055'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbQ',
  'PF01894 family protein YjbQ',
  4270238,
  4270654,
  1,
  'b4056',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4056'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjbR',
  'PF04237 family protein YjbR',
  4270658,
  4271014,
  1,
  'b4057',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4057'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uvrA',
  'UvrABC excision nuclease subunit A',
  4271049,
  4273871,
  -1,
  'b4058',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4058'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ssb',
  'ssDNA-binding protein',
  4274125,
  4274661,
  1,
  'b4059',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4059'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjcB',
  'uncharacterized protein YjcB',
  4274760,
  4275041,
  -1,
  'b4060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4060'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeC',
  'cyclic di-GMP phosphodiesterase PdeC',
  4275471,
  4277057,
  1,
  'b4061',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4061'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'soxS',
  'DNA-binding transcriptional dual regulator SoxS',
  4277060,
  4277383,
  -1,
  'b4062',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4062'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'soxR',
  'DNA-binding transcriptional dual regulator SoxR',
  4277469,
  4277933,
  1,
  'b4063',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4063'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ryjA',
  '—',
  4277926,
  4278066,
  -1,
  'b4459',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4459'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ghxP',
  'guanine/hypoxanthine transporter GhxP',
  4278479,
  4279828,
  1,
  'b4064',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4064'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjcE',
  'putative transporter YjcE',
  4279980,
  4281629,
  1,
  'b4065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4065'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjcF',
  'pentapeptide repeat-containing protein YjcF',
  4281783,
  4283075,
  -1,
  'b4066',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4066'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'actP',
  'acetate/glycolate:cation symporter',
  4283253,
  4284902,
  -1,
  'b4067',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4067'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjcH',
  'DUF485 domain-containing inner membrane proteinYjcH',
  4284899,
  4285213,
  -1,
  'b4068',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4068'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acs',
  'acetyl-CoA synthetase (AMP-forming)',
  4285413,
  4287371,
  -1,
  'b4069',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4069'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytcB',
  'protein YtcB',
  4287611,
  4287667,
  1,
  'b4821',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4821'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfA',
  'cytochrome c552 nitrite reductase',
  4287764,
  4289200,
  1,
  'b4070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4070'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfB',
  'periplasmic nitrite reductase penta-heme c-typecytochrome',
  4289245,
  4289811,
  1,
  'b4071',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4071'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfC',
  'putative menaquinol-cytochrome c reductase4Fe-4S subunit',
  4289808,
  4290479,
  1,
  'b4072',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4072'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfD',
  'putative menaquinol-cytochrome c reductasesubunit NrfD',
  4290476,
  4291432,
  1,
  'b4073',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4073'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfE',
  'putative cytochrome c-type biogenesis proteinNrfE',
  4291512,
  4293170,
  1,
  'b4074',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4074'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfF',
  'putative formate-dependent nitrite reductasecomplex subunit NrfF',
  4293163,
  4293546,
  1,
  'b4075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4075'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrfG',
  'putative formate-dependent nitrite reductasecomplex subunit NrfG',
  4293543,
  4294139,
  1,
  'b4076',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4076'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltP',
  'glutamate/aspartate : H(+) symporter GltP',
  4294481,
  4295794,
  1,
  'b4077',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4077'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjcO',
  'Sel1 repeat-containing protein YjcO',
  4296436,
  4297125,
  -1,
  'b4078',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4078'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdhF',
  'formate dehydrogenase H',
  4297219,
  4299366,
  -1,
  'b4079',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4079'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtP',
  'putative multidrug efflux pump outer membranechannel',
  4299564,
  4301030,
  -1,
  'b4080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4080'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtO',
  'putative multidrug efflux pump subunit MdtO',
  4301027,
  4303078,
  -1,
  'b4081',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4081'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtN',
  'putative multidrug efflux pump membrane fusionprotein',
  4303078,
  4304109,
  -1,
  'b4082',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4082'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytcA',
  'putative lipoprotein YtcA',
  4304128,
  4304403,
  -1,
  'b4622',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4622'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjcS',
  'linear primary-alkylsulfatase',
  4304612,
  4306597,
  -1,
  'b4083',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4083'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alsK',
  'D-allose kinase',
  4306870,
  4307799,
  -1,
  'b4084',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4084'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alsE',
  'D-allulose-6-phosphate 3-epimerase',
  4307783,
  4308478,
  -1,
  'b4085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4085'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alsC',
  'D-allose ABC transporter membrane subunit',
  4308489,
  4309469,
  -1,
  'b4086',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4086'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alsA',
  'D-allose ABC transporter ATP binding subunit',
  4309448,
  4310980,
  -1,
  'b4087',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4087'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alsB',
  'D-allose ABC transporter periplasmic bindingprotein',
  4311107,
  4312042,
  -1,
  'b4088',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4088'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alsR',
  'DNA-binding transcriptional repressor AlsR',
  4312101,
  4312991,
  -1,
  'b4089',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4089'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpiB',
  'allose-6-phosphate isomerase/ribose-5-phosphateisomerase B',
  4313350,
  4313799,
  1,
  'b4090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4090'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdP',
  'protein YjdP',
  4313868,
  4314197,
  1,
  'b4487',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4487'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnP',
  '5-phospho-alpha-D-ribosyl 1,2-cyclic phosphatephosphodiesterase',
  4314344,
  4315102,
  -1,
  'b4092',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4092'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnO',
  'aminoalkylphosphonate N-acetyltransferase',
  4315104,
  4315538,
  -1,
  'b4093',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4093'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnN',
  'ribose 1,5-bisphosphate phosphokinase',
  4315525,
  4316082,
  -1,
  'b4094',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4094'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnM',
  'RPnTP hydrolase',
  4316082,
  4317218,
  -1,
  'b4095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4095'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnL',
  'carbon-phosphorus lyase ATP-binding proteinPhnL',
  4317215,
  4317895,
  -1,
  'b4096',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4096'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnK',
  'carbon-phosphorus lyase ATP-binding proteinPhnK',
  4318006,
  4318764,
  -1,
  'b4097',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4097'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnJ',
  'carbon-phosphorus lyase core complex subunitPhnJ',
  4318761,
  4319606,
  -1,
  'b4098',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4098'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnI',
  'carbon-phosphorus lyase core complex subunitPhnI',
  4319599,
  4320663,
  -1,
  'b4099',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4099'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnH',
  'carbon-phosphorus lyase core complex subunitPhnH',
  4320663,
  4321247,
  -1,
  'b4100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4100'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnG',
  'carbon-phosphorus lyase core complex subunitPhnG',
  4321244,
  4321696,
  -1,
  'b4101',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4101'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnF',
  'putative transcriptional regulator PhnF',
  4321697,
  4322422,
  -1,
  'b4102',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4102'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnE1',
  'phosphonate/phosphate ABC transporter membranesubunit PhnE1',
  4322443,
  4323281,
  -1,
  'b4583',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4583'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnD',
  'phosphonate/phosphate ABC transporterperiplasmic binding protein',
  4323336,
  4324352,
  -1,
  'b4105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4105'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'phnC',
  'phosphonate/phosphate ABC transporter ATPbinding subunit',
  4324377,
  4325165,
  -1,
  'b4106',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4106'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdN',
  'PF06983 family protein YjdN',
  4325298,
  4325741,
  -1,
  'b4107',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4107'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdM',
  'zinc ribbon domain-containing protein YjdM',
  4326399,
  4326734,
  -1,
  'b4108',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4108'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rdcA',
  'regulator of diguanylate cyclase RdcA',
  4327135,
  4329363,
  1,
  'b4109',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4109'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rdcB',
  'regulator of diguanylate cyclase RdcB',
  4329360,
  4330238,
  1,
  'b4110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4110'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proP',
  'osmolyte:H(+) symporter ProP',
  4330502,
  4332004,
  1,
  'b4111',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4111'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pmrR',
  'small regulatory membrane protein PmrR',
  4332116,
  4332205,
  1,
  'b4703',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4703'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'basS',
  'sensor histidine kinase BasS',
  4332181,
  4333272,
  -1,
  'b4112',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4112'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'basR',
  'DNA-binding transcriptional dual regulator BasR',
  4333282,
  4333950,
  -1,
  'b4113',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4113'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eptA',
  'phosphoethanolamine transferase EptA',
  4333947,
  4335590,
  -1,
  'b4114',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4114'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adiC',
  'arginine:agmatine antiporter',
  4335694,
  4337031,
  -1,
  'b4115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4115'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adiY',
  'DNA-binding transcriptional activator AdiY',
  4337168,
  4337929,
  -1,
  'b4116',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4116'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adiA',
  'arginine decarboxylase, degradative',
  4338254,
  4340521,
  -1,
  'b4117',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4117'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'melR',
  'DNA-binding transcriptional dual regulator MelR',
  4340720,
  4341628,
  -1,
  'b4118',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4118'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'melA',
  'alpha-galactosidase',
  4341911,
  4343266,
  1,
  'b4119',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4119'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'melB',
  'melibiose:H(+)/Na(+)/Li(+) symporter',
  4343369,
  4344790,
  1,
  'b4120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4120'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdF',
  'DUF2238 domain-containing inner membrane proteinYjdF',
  4344929,
  4345558,
  -1,
  'b4121',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4121'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fumB',
  'fumarase B',
  4345680,
  4347326,
  -1,
  'b4122',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4122'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcuB',
  'anaerobic C4-dicarboxylate transporter DcuB',
  4347404,
  4348744,
  -1,
  'b4123',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4123'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcuR',
  'DNA-binding transcriptional activator DcuR',
  4349315,
  4350034,
  -1,
  'b4124',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4124'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcuS',
  'sensor histidine kinase DcuS',
  4350031,
  4351662,
  -1,
  'b4125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4125'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdI',
  'PF06902 family protein YjdI',
  4351843,
  4352073,
  1,
  'b4126',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4126'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdJ',
  'putative N-acetyltransferase YjdJ',
  4352085,
  4352357,
  1,
  'b4127',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4127'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ghoS',
  'antitoxin of the GhoTS toxin-antitoxin system',
  4352584,
  4352880,
  1,
  'b4128',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4128'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ghoT',
  'toxin of the GhoTS toxin-antitoxin system',
  4352908,
  4353081,
  1,
  'b4559',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4559'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysU',
  'lysyl-tRNA synthetase',
  4353200,
  4354717,
  -1,
  'b4129',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4129'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dtpC',
  'dipeptide/tripeptide:H(+) symporter DtpC',
  4354954,
  4356411,
  -1,
  'b4130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4130'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cadA',
  'lysine decarboxylase 1',
  4356470,
  4358617,
  -1,
  'b4131',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4131'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cadB',
  'lysine:cadaverine antiporter',
  4358697,
  4360031,
  -1,
  'b4132',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4132'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cadC',
  'DNA-binding transcriptional activator CadC',
  4360396,
  4361934,
  -1,
  'b4133',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4133'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjdQ',
  '—',
  4362191,
  4362353,
  -1,
  'b4654',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4654'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheU',
  '—',
  4362551,
  4362626,
  -1,
  'b4134',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4134'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dicD',
  'DNA-binding transcriptional regulator DicD',
  4362733,
  4363308,
  -1,
  'b4135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4135'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsbD',
  'thiol-disulfide exchange protein DsbD',
  4363345,
  4365042,
  -1,
  'b4136',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4136'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cutA',
  'copper binding protein CutA',
  4365018,
  4365356,
  -1,
  'b4137',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4137'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcuA',
  'C4-dicarboxylate transporter DcuA',
  4365472,
  4366773,
  -1,
  'b4138',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4138'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aspX',
  '—',
  4366839,
  4366951,
  -1,
  'b4825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4825'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aspA',
  'aspartate ammonia-lyase',
  4366891,
  4368327,
  -1,
  'b4139',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4139'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fxsA',
  'protein FxsA',
  4368664,
  4369140,
  1,
  'b4140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4140'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeH',
  'L-methionine/branched chain amino acid exporter',
  4369156,
  4370412,
  -1,
  'b4141',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4141'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'groS',
  'cochaperonin GroES',
  4370688,
  4370981,
  1,
  'b4142',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4142'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'groL',
  'chaperonin GroEL',
  4371025,
  4372671,
  1,
  'b4143',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4143'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeI',
  'DUF4156 domain-containing lipoprotein YjeI',
  4372809,
  4373162,
  1,
  'b4144',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4144'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeJ',
  'protein YjeJ',
  4373365,
  4374234,
  -1,
  'b4145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4145'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'epmB',
  'lysine 2,3-aminomutase',
  4374629,
  4375657,
  -1,
  'b4146',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4146'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'efp',
  'protein chain elongation factor EF-P',
  4375699,
  4376265,
  1,
  'b4147',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4147'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ecnA',
  'entericidin A lipoprotein, antidote toentericidin B',
  4376317,
  4376442,
  1,
  'b4410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4410'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ecnB',
  'bacteriolytic entericidin B lipoprotein',
  4376553,
  4376699,
  1,
  'b4411',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4411'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gdx',
  'guanidinium exporter',
  4376875,
  4377192,
  1,
  'b4148',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4148'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'blc',
  'outer membrane lipocalin protein',
  4377189,
  4377722,
  -1,
  'b4149',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4149'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ampC',
  'beta-lactamase',
  4377811,
  4378944,
  -1,
  'b4150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4150'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frdD',
  'fumarate reductase membrane protein FrdD',
  4379007,
  4379366,
  -1,
  'b4151',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4151'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frdC',
  'fumarate reductase membrane protein FrdC',
  4379377,
  4379772,
  -1,
  'b4152',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4152'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frdB',
  'fumarate reductase [Fe-S] protein',
  4379783,
  4380517,
  -1,
  'b4153',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4153'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frdA',
  'fumarate reductase flavoprotein subunit',
  4380510,
  4382318,
  -1,
  'b4154',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4154'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'epmA',
  'EF-P-lysine lysyltransferase',
  4382643,
  4383620,
  1,
  'b4155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4155'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeM',
  'putative transporter YjeM',
  4383839,
  4385341,
  1,
  'b4156',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4156'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeN',
  'uncharacterized protein YjeN',
  4385393,
  4385707,
  1,
  'b4157',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4157'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeO',
  'DUF2645 domain-containing inner membrane proteinYjeO',
  4385704,
  4386018,
  1,
  'b4158',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4158'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mscM',
  'miniconductance mechanosensitive channel MscM',
  4386047,
  4389370,
  -1,
  'b4159',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4159'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'psd',
  'phosphatidylserine decarboxylase proenzyme',
  4389392,
  4390360,
  -1,
  'b4160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4160'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsgA',
  'ribosome small subunit-dependent GTPase A',
  4390457,
  4391509,
  -1,
  'b4161',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4161'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'orn',
  'oligoribonuclease',
  4391604,
  4392149,
  1,
  'b4162',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4162'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyV',
  '—',
  4392360,
  4392435,
  1,
  'b4163',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4163'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyX',
  '—',
  4392472,
  4392547,
  1,
  'b4164',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4164'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyY',
  '—',
  4392583,
  4392658,
  1,
  'b4165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4165'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeV',
  'uncharacterized protein YjeV',
  4392892,
  4392945,
  1,
  'b4670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4670'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'queG',
  'epoxyqueuosine reductase',
  4392928,
  4394067,
  -1,
  'b4166',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4166'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nnr',
  'NAD(P)HX epimerase/NAD(P)HX dehydratase',
  4394066,
  4395613,
  1,
  'b4167',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4167'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsaE',
  'N(6)-L-threonylcarbamoyladenine synthase, TsaEsubunit',
  4395585,
  4396046,
  1,
  'b4168',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4168'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'amiB',
  'N-acetylmuramoyl-L-alanine amidase B',
  4396065,
  4397402,
  1,
  'b4169',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4169'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mutL',
  'DNA mismatch repair protein MutL',
  4397412,
  4399259,
  1,
  'b4170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4170'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'miaA',
  'tRNA dimethylallyltransferase',
  4399252,
  4400202,
  1,
  'b4171',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4171'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hfq',
  'RNA-binding protein Hfq',
  4400288,
  4400596,
  1,
  'b4172',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4172'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hflX',
  'ribosome rescue factor HflX',
  4400672,
  4401952,
  1,
  'b4173',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4173'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hflK',
  'regulator of FtsH protease',
  4402038,
  4403297,
  1,
  'b4174',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4174'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hflC',
  'regulator of FtsH protease',
  4403300,
  4404304,
  1,
  'b4175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4175'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjeT',
  'DUF2065 domain-containing protein YjeT',
  4404386,
  4404583,
  1,
  'b4176',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4176'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purA',
  'adenylosuccinate synthetase',
  4404687,
  4405985,
  1,
  'b4177',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4177'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nsrR',
  'DNA-binding transcriptional regulator NsrR',
  4406190,
  4406615,
  1,
  'b4178',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4178'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnr',
  'RNase R',
  4406654,
  4409095,
  1,
  'b4179',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4179'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmB',
  '23S rRNA 2''-O-ribose G2251 methyltransferase',
  4409275,
  4410006,
  1,
  'b4180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4180'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfI',
  'DUF2170 domain-containing protein YjfI',
  4410133,
  4410534,
  1,
  'b4181',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4181'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfJ',
  'PspA family protein YjfJ',
  4410553,
  4411251,
  1,
  'b4182',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4182'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfK',
  'DUF2491 domain-containing protein YjfK',
  4411302,
  4411961,
  1,
  'b4183',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4183'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfL',
  'DUF350 domain-containing inner membrane proteinYjfL',
  4411979,
  4412377,
  1,
  'b4184',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4184'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfM',
  'DUF1190 domain-containing protein YjfM',
  4412387,
  4413025,
  1,
  'b4185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4185'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfC',
  'peptide--spermidine ligase YjfC',
  4413028,
  4414191,
  1,
  'b4186',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4186'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aidB',
  'isovaleryl-CoA dehydrogenase and DNA-bindingtranscriptional repressor',
  4414275,
  4415900,
  1,
  'b4187',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4187'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfN',
  'protease activator YjfN',
  4416017,
  4416292,
  -1,
  'b4188',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4188'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bsmA',
  'DUF1471 domain-containing putative lipoproteinBsmA',
  4416441,
  4416770,
  -1,
  'b4189',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4189'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfP',
  'carboxylesterase',
  4416952,
  4417701,
  1,
  'b4190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4190'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaR',
  'DNA-binding transcriptional repressor UlaR',
  4417698,
  4418453,
  -1,
  'b4191',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4191'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaG',
  'L-ascorbate-6-phosphate lactonase',
  4418561,
  4419625,
  -1,
  'b4192',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4192'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaA',
  'L-ascorbate specific PTS enzyme IIC component',
  4419980,
  4421377,
  1,
  'b4193',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4193'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaB',
  'L-ascorbate specific PTS enzyme IIB component',
  4421393,
  4421698,
  1,
  'b4194',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4194'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaC',
  'L-ascorbate specific PTS enzyme IIA component',
  4421708,
  4422172,
  1,
  'b4195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4195'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaD',
  '3-keto-L-gulonate-6-phosphate decarboxylaseUlaD',
  4422186,
  4422836,
  1,
  'b4196',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4196'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaE',
  'L-ribulose-5-phosphate 3-epimerase UlaE',
  4422846,
  4423700,
  1,
  'b4197',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4197'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ulaF',
  'L-ribulose-5-phosphate 4-epimerase UlaF',
  4423700,
  4424386,
  1,
  'b4198',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4198'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfY',
  'DUF1471 domain-containing protein YjfY',
  4424516,
  4424791,
  -1,
  'b4199',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4199'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsF',
  '30S ribosomal subunit protein S6',
  4425118,
  4425513,
  1,
  'b4200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4200'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'priB',
  'primosomal replication protein N',
  4425520,
  4425834,
  1,
  'b4201',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4201'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsR',
  '30S ribosomal subunit protein S18',
  4425839,
  4426066,
  1,
  'b4202',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4202'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplI',
  '50S ribosomal subunit protein L9',
  4426108,
  4426557,
  1,
  'b4203',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4203'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfZ',
  'DUF2686 domain-containing protein YjfZ',
  4426628,
  4427422,
  -1,
  'b4204',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4204'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfA',
  '—',
  4427694,
  4428095,
  1,
  'b4205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4205'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfB',
  'cell division protein YtfB',
  4428079,
  4428717,
  -1,
  'b4206',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4206'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fklB',
  'peptidyl-prolyl cis-trans isomerase FklB',
  4428935,
  4429555,
  1,
  'b4207',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4207'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cycA',
  'D-serine/alanine/glycine:H(+)symporter',
  4429864,
  4431276,
  1,
  'b4208',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4208'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfE',
  '[Fe-S] cluster repair protein YtfE',
  4431321,
  4431983,
  -1,
  'b4209',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4209'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfF',
  'inner membrane protein YtfF',
  4432091,
  4433056,
  -1,
  'b4210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4210'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'qorB',
  'NAD(P)H:quinone oxidoreductase',
  4433164,
  4434024,
  -1,
  'b4211',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4211'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfH',
  'putative transcriptional regulator YtfH',
  4434113,
  4434493,
  1,
  'b4212',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4212'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpdB',
  '2'',3''-cyclic-nucleotide2''-phosphodiesterase/3''-nucleotidase',
  4434622,
  4436565,
  -1,
  'b4213',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4213'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysQ',
  '3''(2''),5''-bisphosphate nucleotidase',
  4436755,
  4437495,
  1,
  'b4214',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4214'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfI',
  'protein YtfI',
  4437707,
  4438645,
  1,
  'b4215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4215'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfJ',
  'PF09695 family protein YtfJ',
  4438708,
  4439262,
  -1,
  'b4216',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4216'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfK',
  'stringent response modulator YtfK',
  4439587,
  4439793,
  1,
  'b4217',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4217'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paeA',
  'putative cadaverine/putrescine exporter',
  4439872,
  4441215,
  -1,
  'b4218',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4218'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'msrA',
  'methionine sulfoxide reductase A',
  4441538,
  4442176,
  -1,
  'b4219',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4219'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tamA',
  'translocation and assembly module subunit TamA',
  4442382,
  4444115,
  1,
  'b4220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4220'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tamB',
  'translocation and assembly module subunit TamB',
  4444112,
  4447891,
  1,
  'b4221',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4221'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfP',
  'gamma-glutamylamine cyclotransferase familyprotein YtfP',
  4447894,
  4448235,
  1,
  'b4222',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4222'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chpS',
  'ChpS antitoxin of the ChpB-ChpS toxin-antitoxinsystem',
  4448447,
  4448698,
  1,
  'b4224',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4224'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chpB',
  'endoribonuclease toxin ChpB',
  4448692,
  4449042,
  1,
  'b4225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4225'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppa',
  'inorganic pyrophosphatase',
  4449122,
  4449652,
  -1,
  'b4226',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4226'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfQ',
  'galactofuranose ABC transporter periplasmicbinding protein',
  4449962,
  4450918,
  1,
  'b4227',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4227'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfR',
  'galactofuranose ABC transporter putative ATPbinding subunit',
  4451058,
  4452560,
  1,
  'b4485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4485'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytfT',
  'galactofuranose ABC transporter putativemembrane subunit YtfT',
  4452571,
  4453596,
  1,
  'b4230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4230'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjfF',
  'galactofuranose ABC transporter putativemembrane subunit YjtF',
  4453583,
  4454578,
  1,
  'b4231',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4231'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fbp',
  'fructose-1,6-bisphosphatase 1',
  4454611,
  4455609,
  -1,
  'b4232',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4232'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mpl',
  'UDP-N-acetylmuramate--L-alanyl-gamma-D-glutamyl-meso-2,6-diaminoheptanedioate ligase',
  4455785,
  4457158,
  1,
  'b4233',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4233'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgA',
  'putative ribosome biogenesis factor YjgA',
  4457314,
  4457865,
  -1,
  'b4234',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4234'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tldE',
  'metalloprotease subunit TldE',
  4457959,
  4459311,
  1,
  'b4235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4235'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cybC',
  '—',
  4459488,
  4459855,
  1,
  'b4236',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4236'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdG',
  'anaerobic ribonucleoside-triphosphate reductaseactivating protein',
  4459900,
  4460364,
  -1,
  'b4237',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4237'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdD',
  'anaerobic ribonucleoside-triphosphate reductase',
  4460522,
  4462660,
  -1,
  'b4238',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4238'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'treC',
  'trehalose-6-phosphate hydrolase',
  4463054,
  4464709,
  -1,
  'b4239',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4239'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'treB',
  'trehalose-specific PTS enzyme IIBC component',
  4464759,
  4466180,
  -1,
  'b4240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4240'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'treR',
  'DNA-binding transcriptional repressor TreR',
  4466299,
  4467246,
  -1,
  'b4241',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4241'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mgtL',
  'leader peptide MgtL',
  4467431,
  4467484,
  1,
  'b4702',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4702'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mgtA',
  'Mg(2(+)) importing P-type ATPase',
  4467625,
  4470321,
  1,
  'b4242',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4242'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ridA',
  'enamine/imine deaminase, redox-regulatedchaperone',
  4470527,
  4470913,
  -1,
  'b4243',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4243'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrI',
  'aspartate carbamoyltransferase, PyrI subunit',
  4470986,
  4471447,
  -1,
  'b4244',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4244'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrB',
  'aspartate carbamoyltransferase catalyticsubunit',
  4471460,
  4472395,
  -1,
  'b4245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4245'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrL',
  'pyrBI operon leader peptide',
  4472399,
  4472533,
  -1,
  'b4246',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4246'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgH',
  'RutC family protein YjgH',
  4472814,
  4473209,
  -1,
  'b4248',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4248'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bdcA',
  'c-di-GMP-binding biofilm dispersal mediatorprotein',
  4473340,
  4474053,
  -1,
  'b4249',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4249'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bdcR',
  'putative transcriptional regulator BdcR',
  4474124,
  4474717,
  1,
  'b4251',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4251'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tabA',
  'DUF386 domain-containing toxin-antitoxin biofilmprotein TabA',
  4474862,
  4475314,
  1,
  'b4252',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4252'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgL',
  'protein YjgL',
  4475437,
  4477251,
  1,
  'b4253',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4253'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argI',
  'ornithine carbamoyltransferase ArgI',
  4477307,
  4478311,
  -1,
  'b4254',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4254'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rraB',
  'ribonuclease E inhibitor protein B',
  4478473,
  4478889,
  1,
  'b4255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4255'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgM',
  'putative N-acetyltransferase YjgM',
  4479034,
  4479537,
  -1,
  'b4256',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4256'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgN',
  'inner membrane protein YjgN',
  4479730,
  4480926,
  1,
  'b4257',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4257'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'valS',
  'valine--tRNA ligase',
  4480982,
  4483837,
  -1,
  'b4258',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4258'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'holC',
  'DNA polymerase III subunit chi',
  4483837,
  4484280,
  -1,
  'b4259',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4259'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pepA',
  'aminopeptidase A/I',
  4484440,
  4485951,
  -1,
  'b4260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4260'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytgB',
  'protein YtgB',
  4486043,
  4486099,
  1,
  'b4822',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4822'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytgA',
  'protein YtgA',
  4486105,
  4486155,
  1,
  'b4800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4800'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lptF',
  'lipopolysaccharide transport system proteinLptF',
  4486218,
  4487318,
  1,
  'b4261',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4261'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lptG',
  'lipopolysaccharide transport system proteinLptG',
  4487318,
  4488400,
  1,
  'b4262',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4262'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgR',
  'DUF853 domain-containing protein YjgR',
  4488561,
  4490063,
  -1,
  'b4263',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4263'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idnR',
  'DNA-binding transcriptional dual regulator IdnR',
  4490141,
  4491139,
  -1,
  'b4264',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4264'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idnT',
  'L-idonate/5-ketogluconate/gluconate transporter',
  4491206,
  4492525,
  -1,
  'b4265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4265'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idnO',
  '5-keto-D-gluconate 5-reductase',
  4492587,
  4493351,
  -1,
  'b4266',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4266'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idnD',
  'L-idonate 5-dehydrogenase',
  4493375,
  4494406,
  -1,
  'b4267',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4267'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idnK',
  'D-gluconate kinase, thermosensitive',
  4494623,
  4495186,
  1,
  'b4268',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4268'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ahr',
  'NADPH-dependent aldehyde reductase Ahr',
  4495190,
  4496209,
  -1,
  'b4269',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4269'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuX',
  '—',
  4496405,
  4496489,
  1,
  'b4270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4270'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intB',
  '—',
  4496750,
  4497940,
  1,
  'b4271',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4271'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insC6',
  'IS2 insertion element repressor InsA',
  4498272,
  4498637,
  1,
  'b4272',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4272'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insD6',
  'IS2 insertion element protein InsB',
  4498595,
  4499500,
  1,
  'b4273',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4273'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgX',
  '—',
  4499593,
  4500791,
  -1,
  'b4575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4575'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjgZ',
  'uncharacterized protein YjgZ',
  4501260,
  4501589,
  1,
  'b4277',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4277'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insG',
  'IS4 putative transposase',
  4502103,
  4503431,
  -1,
  'b4278',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4278'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanX',
  '2,7-anhydro-N-acetylneuraminate transporterNanX',
  4504058,
  4505275,
  1,
  'b4279',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4279'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanY',
  '2,7-anhydro-N-acetylneuraminate hydratase',
  4505287,
  4506405,
  1,
  'b4280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4280'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ythA',
  'uncharacterized protein YthA',
  4506448,
  4506573,
  1,
  'b4655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4655'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhD',
  '—',
  4506626,
  4506856,
  -1,
  'b4281',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4281'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhE',
  '—',
  4506861,
  4507109,
  1,
  'b4282',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4282'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insO',
  'KpLE2 phage-like element; IS911B regulatorfragment',
  4507197,
  4509793,
  1,
  'b4623',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4623'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insI3',
  'IS30 transposase',
  4507466,
  4508617,
  -1,
  'b4284',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4284'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insM',
  '—',
  4508684,
  4508942,
  -1,
  'b4561',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4561'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhV',
  '—',
  4509804,
  4510133,
  1,
  'b4286',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4286'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecE',
  'ferric citrate ABC transporter ATP bindingsubunit',
  4510690,
  4511457,
  -1,
  'b4287',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4287'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecD',
  'ferric citrate ABC transporter membrane subunitFecD',
  4511458,
  4512414,
  -1,
  'b4288',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4288'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecC',
  'ferric citrate ABC transporter membrane subunitFecC',
  4512411,
  4513409,
  -1,
  'b4289',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4289'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecB',
  'ferric citrate ABC transporter periplasmicbinding protein',
  4513406,
  4514308,
  -1,
  'b4290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4290'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecA',
  'ferric citrate outer membrane transporter',
  4514353,
  4516677,
  -1,
  'b4291',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4291'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecR',
  'ferric citrate regulator FecR',
  4516764,
  4517717,
  -1,
  'b4292',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4292'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fecI',
  'RNA polymerase sigma factor FecI',
  4517714,
  4518235,
  -1,
  'b4293',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4293'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ykiE',
  'protein YkiE',
  4518372,
  4518440,
  1,
  'b4801',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4801'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insA7',
  'IS1 repressor protein InsA',
  4518527,
  4518802,
  1,
  'b4294',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4294'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insB7',
  '—',
  4518721,
  4519224,
  1,
  'b4576',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4576'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhU',
  'putative DNA-binding transcriptional regulatorYjhU',
  4519338,
  4520324,
  -1,
  'b4295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4295'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhF',
  'putative transporter YjhF',
  4520671,
  4522020,
  -1,
  'b4296',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4296'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhG',
  'D-xylonate dehydratase',
  4522127,
  4524094,
  -1,
  'b4297',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4297'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhH',
  'putative 2-dehydro-3-deoxy-D-pentonate aldolase',
  4524105,
  4525010,
  -1,
  'b4298',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4298'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhI',
  'putative DNA-binding transcriptional regulatorYjhI',
  4525015,
  4525803,
  -1,
  'b4299',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4299'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcR',
  'putative DNA-binding transcriptional regulatorSgcR',
  4526106,
  4526888,
  -1,
  'b4300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4300'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcE',
  'putative epimerase SgcE',
  4526905,
  4527537,
  -1,
  'b4301',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4301'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcA',
  'putative PTS enzyme IIA component SgcA',
  4527549,
  4527980,
  -1,
  'b4302',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4302'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ryjB',
  '—',
  4527977,
  4528066,
  1,
  'b4624',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4624'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcQ',
  'putative nucleoside triphosphatase',
  4528111,
  4528917,
  -1,
  'b4303',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4303'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcC',
  'putative PTS enzyme IIC component SgcC',
  4528930,
  4530243,
  -1,
  'b4304',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4304'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcB',
  'putative PTS enzyme IIB component SgcB',
  4530255,
  4530533,
  -1,
  'b4565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4565'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sgcX',
  'putative endoglucanase with Zn-dependentexopeptidase domain',
  4530530,
  4531651,
  -1,
  'b4305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4305'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhY',
  '—',
  4532050,
  4532310,
  -1,
  'b4656',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4656'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhP',
  'putative methyltransferase YjhP',
  4532437,
  4533183,
  -1,
  'b4306',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4306'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhQ',
  'putative acetyltransferase TopAI antitoxin YjhQ',
  4533239,
  4533784,
  -1,
  'b4307',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4307'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'topAI',
  'toxin of the TopAI-YjhQ toxin-antitoxin system,TopA inhibitor',
  4533796,
  4534053,
  -1,
  'b4566',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4566'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhZ',
  '—',
  4534430,
  4534675,
  -1,
  'b4657',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4657'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjhR',
  '—',
  4535015,
  4536031,
  1,
  'b4308',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4308'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ythB',
  'protein YthB',
  4536597,
  4536695,
  1,
  'b4802',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4802'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanS',
  'N-acetyl-9-O-acetylneuraminate esterase',
  4536614,
  4537594,
  -1,
  'b4309',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4309'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanM',
  'N-acetylneuraminate mutarotase',
  4537659,
  4538765,
  -1,
  'b4310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4310'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nanC',
  'N-acetylneuraminate outer membrane channel',
  4538785,
  4539501,
  -1,
  'b4311',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4311'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimB',
  'Type 1 fimbriae regulatory protein FimB',
  4540957,
  4541559,
  1,
  'b4312',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4312'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimE',
  'regulator for fimA',
  4542037,
  4542633,
  1,
  'b4313',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4313'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimA',
  'type 1 fimbriae major subunit',
  4543115,
  4543663,
  1,
  'b4314',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4314'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimR2',
  '—',
  4543674,
  4543708,
  1,
  'b4838',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4838'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimI',
  'putative fimbrial protein FimI',
  4543728,
  4544267,
  1,
  'b4315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4315'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimC',
  'type 1 fimbriae periplasmic chaperone',
  4544304,
  4545029,
  1,
  'b4316',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4316'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimD',
  'type I fimbriae usher protein',
  4545096,
  4547732,
  1,
  'b4317',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4317'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimF',
  'type 1 fimbriae minor subunit FimF',
  4547742,
  4548272,
  1,
  'b4318',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4318'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimG',
  'type 1 fimbriae minor subunit FimG',
  4548285,
  4548788,
  1,
  'b4319',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4319'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fimH',
  'type 1 fimbriae D-mannose specific adhesin',
  4548808,
  4549710,
  1,
  'b4320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4320'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gntP',
  'fructuronate transporter',
  4549953,
  4551296,
  -1,
  'b4321',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4321'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uxuA',
  'D-mannonate dehydratase',
  4551636,
  4552820,
  1,
  'b4322',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4322'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uxuB',
  'D-mannonate oxidoreductase',
  4552901,
  4554361,
  1,
  'b4323',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4323'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uxuR',
  'DNA-binding transcriptional repressor UxuR',
  4554576,
  4555349,
  1,
  'b4324',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4324'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiC',
  'DUF2686 domain-containing protein YjiC',
  4555490,
  4556320,
  -1,
  'b4325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4325'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytiC',
  'protein YtiC',
  4556574,
  4556675,
  1,
  'b4720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4720'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytiD',
  'protein YtiD',
  4556654,
  4556797,
  1,
  'b4721',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4721'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idlP',
  'iraD leader peptide',
  4556913,
  4556996,
  1,
  'b4722',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4722'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iraD',
  'anti-adaptor protein IraD',
  4556993,
  4557385,
  1,
  'b4326',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4326'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypT',
  'DNA-binding transcriptional dual regulator HypT',
  4557378,
  4558289,
  -1,
  'b4327',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4327'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iadA',
  'isoaspartyl dipeptidase',
  4558354,
  4559526,
  -1,
  'b4328',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4328'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiG',
  'Gate family protein YjiG',
  4559539,
  4560000,
  -1,
  'b4329',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4329'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiH',
  'uncharacterized protein YjiH',
  4559997,
  4560680,
  -1,
  'b4330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4330'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kptA',
  'RNA 2''-phosphotransferase',
  4560930,
  4561484,
  1,
  'b4331',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4331'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiJ',
  'putative transporter YjiJ',
  4561497,
  4562675,
  -1,
  'b4332',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4332'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiK',
  'PF06977 family protein YjiK',
  4562743,
  4563603,
  -1,
  'b4333',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4333'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytiA',
  'uncharacterized protein YtiA',
  4563668,
  4563925,
  -1,
  'b4715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4715'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiL',
  'putative ATPase, activator of(R)-hydroxyglutaryl-CoA dehdratase',
  4563922,
  4564689,
  -1,
  'b4334',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4334'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiM',
  'putative dehydratase subunit',
  4564699,
  4565850,
  -1,
  'b4335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4335'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiN',
  'DUF445 domain-containing protein YjiN',
  4565966,
  4567246,
  -1,
  'b4336',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4336'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtM',
  'multidrug efflux pump/bile salt:H(+)antiporter/Na(+):H(+) antiporter/K(+):H(+) antiporter',
  4567287,
  4568519,
  -1,
  'b4337',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4337'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytiE',
  'protein YtiE',
  4568692,
  4568727,
  -1,
  'b4823',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4823'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpnD',
  '—',
  4568998,
  4569918,
  1,
  'b4584',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4584'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiR',
  'fused putative DNA-binding transcriptionalregulator/putative aminotransferase YjiR',
  4570162,
  4571574,
  -1,
  'b4340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4340'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiS',
  'DUF1127 domain-containing protein YjiS',
  4571751,
  4571915,
  1,
  'b4341',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4341'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiT',
  'putative uncharacterized protein YjiT',
  4572414,
  4573931,
  1,
  'b4342',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4342'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiV',
  '—',
  4574135,
  4576855,
  1,
  'b4486',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4486'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mcrC',
  'Type IV methyl-directed restriction enzymeEcoKMcrBC subunit',
  4576912,
  4577958,
  -1,
  'b4345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4345'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mcrB',
  'mcrB-S',
  4577958,
  4579337,
  -1,
  'b4346',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4346'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'symE',
  'nucleoid-associated protein SymE',
  4579499,
  4579840,
  -1,
  'b4347',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4347'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'symR',
  '—',
  4579835,
  4579911,
  1,
  'b4625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4625'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hsdS',
  'type I restriction enzyme EcoKI specificitysubunit',
  4580068,
  4581462,
  -1,
  'b4348',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4348'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hsdM',
  'type I restriction enzyme EcoKI methylasesubunit',
  4581459,
  4583048,
  -1,
  'b4349',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4349'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hsdR',
  'type I restriction enzyme EcoKI endonucleasesubunit',
  4583249,
  4586761,
  -1,
  'b4350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4350'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mrr',
  'Type IV methyl-directed restriction enzymeEcoKMrr',
  4586949,
  4587863,
  1,
  'b4351',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4351'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiA',
  'P-loop guanosine triphosphatase YjiA',
  4587909,
  4588865,
  -1,
  'b4352',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4352'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjiX',
  'PF04328 family protein YjiX',
  4588876,
  4589079,
  -1,
  'b4353',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4353'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btsT',
  'pyruvate:H(+) symporter',
  4589129,
  4591279,
  -1,
  'b4354',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4354'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsr',
  'methyl-accepting chemotaxis protein Tsr',
  4591657,
  4593312,
  1,
  'b4355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4355'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lgoT',
  'galactonate:H(+) symporter',
  4593361,
  4594722,
  -1,
  'b4356',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4356'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lgoR',
  'putative DNA-binding transcriptional regulatorLgoR',
  4594937,
  4595851,
  -1,
  'b4357',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4357'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lgoD',
  'L-galactonate oxidoreductase',
  4595990,
  4597012,
  1,
  'b4358',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4358'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'opgB',
  'phosphoglycerol transferase I',
  4597150,
  4599441,
  -1,
  'b4359',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4359'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjA',
  'DUF2501 domain-containing protein YjjA',
  4599695,
  4600189,
  -1,
  'b4360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4360'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dnaC',
  'DNA replication protein DnaC',
  4600238,
  4600975,
  -1,
  'b4361',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4361'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dnaT',
  'primosomal protein DnaT',
  4600978,
  4601517,
  -1,
  'b4362',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4362'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjB',
  'putative succinate exporter YjjB',
  4601624,
  4602097,
  -1,
  'b4363',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4363'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjP',
  'putative succinate exporter YjjP',
  4602088,
  4602858,
  -1,
  'b4364',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4364'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjQ',
  'DNA-binding transcriptional repressor YjjQ',
  4603477,
  4604202,
  1,
  'b4365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4365'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglJ',
  'DNA-binding transcriptional regulator BglJ',
  4604160,
  4604837,
  1,
  'b4366',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4366'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fhuF',
  'ferric-siderophore reductase FhuF',
  4604875,
  4605663,
  -1,
  'b4367',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4367'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjZ',
  'DUF1435 domain-containing protein YjjZ',
  4605804,
  4606040,
  1,
  'b4567',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4567'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuV',
  '—',
  4606079,
  4606165,
  -1,
  'b4368',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4368'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuP',
  '—',
  4606200,
  4606286,
  -1,
  'b4369',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4369'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuQ',
  '—',
  4606315,
  4606401,
  -1,
  'b4370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4370'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmC',
  '16S rRNA m(2)G1207 methyltransferase',
  4606669,
  4607700,
  -1,
  'b4371',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4371'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'holD',
  'DNA polymerase III subunit psi',
  4607803,
  4608216,
  1,
  'b4372',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4372'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rimI',
  'protein N-acetyltransferase RimI',
  4608185,
  4608631,
  1,
  'b4373',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4373'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjG',
  'pyrimidine 5''-nucleotidase YjjG',
  4608646,
  4609323,
  1,
  'b4374',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4374'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prfC',
  'peptide chain release factor RF3',
  4609414,
  4611003,
  1,
  'b4375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4375'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'osmY',
  'osmotically inducible protein Y',
  4611396,
  4612001,
  1,
  'b4376',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4376'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytjA',
  'DUF1328 domain-containing protein YtjA',
  4612128,
  4612289,
  1,
  'b4568',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4568'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjU',
  'putative patatin-like phospholipase YjjU',
  4612411,
  4613484,
  1,
  'b4377',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4377'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjV',
  'putative metal-dependent hydrolase YjjV',
  4613481,
  4614260,
  1,
  'b4378',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4378'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjW',
  'putative glycyl-radical enzyme activating enzymeYjjW',
  4614680,
  4615543,
  -1,
  'b4379',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4379'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjI',
  'DUF3029 domain-containing protein YjjI',
  4615515,
  4617065,
  -1,
  'b4380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4380'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'deoC',
  'deoxyribose-phosphate aldolase',
  4617323,
  4618102,
  1,
  'b4381',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4381'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'deoA',
  'thymidine phosphorylase',
  4618229,
  4619551,
  1,
  'b4382',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4382'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'deoB',
  'phosphopentomutase',
  4619603,
  4620826,
  1,
  'b4383',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4383'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'deoD',
  'purine nucleoside phosphorylase',
  4620883,
  4621602,
  1,
  'b4384',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4384'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hipH',
  'serine/threonine-protein kinase toxin HipH',
  4621769,
  4623100,
  1,
  'b4385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4385'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lplA',
  'lipoate--protein ligase A',
  4623101,
  4624117,
  -1,
  'b4386',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4386'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytjB',
  'putative inner membrane protein Smp',
  4624145,
  4624789,
  -1,
  'b4387',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4387'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'serB',
  'phosphoserine phosphatase',
  4624895,
  4625863,
  1,
  'b4388',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4388'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'radA',
  'DNA recombination protein',
  4625912,
  4627294,
  1,
  'b4389',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4389'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nadR',
  'DNA-binding transcriptional repressor/NMNadenylyltransferase NadR',
  4627315,
  4628547,
  1,
  'b4390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4390'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ettA',
  'energy-dependent translational throttle proteinEttA',
  4628855,
  4630522,
  -1,
  'b4391',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4391'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slt',
  'soluble lytic murein transglycosylase',
  4630733,
  4632670,
  1,
  'b4392',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4392'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpR',
  'DNA-binding transcriptional repressor TrpR',
  4632760,
  4633086,
  1,
  'b4393',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4393'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjX',
  'inosine/xanthosine triphosphatase',
  4633233,
  4633745,
  -1,
  'b4394',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4394'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytjC',
  'putative phosphatase',
  4633797,
  4634444,
  1,
  'b4395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4395'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rob',
  'DNA-binding transcriptional dual regulator Rob',
  4634441,
  4635310,
  -1,
  'b4396',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4396'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'creA',
  'PF05981 family protein CreA',
  4635521,
  4635994,
  1,
  'b4397',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4397'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'creB',
  'DNA-binding transcriptional regulator CreB',
  4636007,
  4636696,
  1,
  'b4398',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4398'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'creC',
  'sensory histidine kinase CreC',
  4636696,
  4638120,
  1,
  'b4399',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4399'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'creD',
  'putative inner membrane protein CreD',
  4638178,
  4639530,
  1,
  'b4400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4400'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arcA',
  'DNA-binding transcriptional dual regulator ArcA',
  4639590,
  4640306,
  -1,
  'b4401',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4401'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjjY',
  'uncharacterized protein YjjY',
  4640402,
  4640542,
  1,
  'b4402',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4402'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ytjE',
  'protein YtjE',
  4640718,
  4640771,
  1,
  'b4824',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4824'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yjtD',
  'putative tRNA/rRNA methyltransferase YjtD',
  4640942,
  4641628,
  1,
  'b4403',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4403'
);
INSERT INTO core_experimentaltechnique (name, description, preset_function, EO_term)
SELECT 'EMSA', 'EMSA', NULL, 'ECO:0001807'
WHERE NOT EXISTS (
  SELECT 1 FROM core_experimentaltechnique WHERE EO_term='ECO:0001807'
);
INSERT INTO core_siteinstance (_seq, genome_id, start, end, strand)
SELECT
  'AAGATTACATT',
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  4350540,
  4350550,
  -1
WHERE NOT EXISTS (
  SELECT 1 FROM core_siteinstance
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
    AND start=4350540 AND end=4350550 AND strand=-1
    AND _seq='AAGATTACATT'
);
INSERT INTO core_curation_siteinstance
  (curation_id, site_instance_id, annotated_seq, quantitative_value, site_type, TF_function, TF_type)
VALUES
  ((SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1),
   (SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
          AND start=4350540 AND end=4350550 AND strand=-1
          AND _seq='AAGATTACATT'
        ORDER BY site_id DESC LIMIT 1),
   'AAGATTACATT',
   0,
   'variable',
   'activator',
   'monomer');
INSERT INTO core_curation_siteinstance_experimental_techniques
  (curation_siteinstance_id, experimentaltechnique_id)
SELECT (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
          AND start=4350540 AND end=4350550 AND strand=-1
          AND _seq='AAGATTACATT'
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
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
          AND start=4350540 AND end=4350550 AND strand=-1
          AND _seq='AAGATTACATT'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1)
      AND experimentaltechnique_id=(SELECT technique_id
          FROM core_experimentaltechnique
          WHERE EO_term='ECO:0001807'
          LIMIT 1)
  );
INSERT INTO core_regulation (curation_site_instance_id, gene_id, evidence_type, meta_site_id)
SELECT
  (SELECT id FROM core_curation_siteinstance
        WHERE curation_id=(SELECT curation_id FROM core_curation WHERE publication_id=(SELECT publication_id FROM core_publication WHERE pmid='37907733' LIMIT 1) ORDER BY curation_id DESC LIMIT 1)
          AND site_instance_id=(SELECT site_id FROM core_siteinstance
        WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
          AND start=4350540 AND end=4350550 AND strand=-1
          AND _seq='AAGATTACATT'
        ORDER BY site_id DESC LIMIT 1)
        ORDER BY id DESC LIMIT 1),
  (SELECT gene_id FROM core_gene
            WHERE locus_tag='b4125' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1),
  'exp_verified',
  NULL
WHERE (SELECT gene_id FROM core_gene
            WHERE locus_tag='b4125' AND genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1)
            ORDER BY gene_id DESC LIMIT 1) IS NOT NULL;
COMMIT;