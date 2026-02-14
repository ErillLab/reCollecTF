PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppx',
  'exopolyphosphatase',
  2625115,
  2626656,
  1,
  'b2502',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2502'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeF',
  'cyclic di-GMP phosphodiesterase PdeF',
  2626695,
  2628938,
  -1,
  'b2503',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2503'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgG',
  'Ni/Co stress response protein YfgG',
  2629290,
  2629481,
  1,
  'b2504',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2504'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgH',
  'lipoprotein YfgH',
  2629792,
  2630310,
  1,
  'b2505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2505'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgI',
  'nalidixic acid resistance protein YfgI',
  2630326,
  2630865,
  1,
  'b2506',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2506'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'guaA',
  'GMP synthetase',
  2630958,
  2632535,
  -1,
  'b2507',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2507'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'guaB',
  'inosine 5''-monophosphate dehydrogenase',
  2632604,
  2634070,
  -1,
  'b2508',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2508'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xseA',
  'exodeoxyribonuclease VII subunit XseA',
  2634232,
  2635602,
  1,
  'b2509',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2509'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgJ',
  'zinc ribbon domain-containing protein YfgJ',
  2635599,
  2635814,
  -1,
  'b2510',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2510'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'der',
  '50S ribosomal subunit stability factor',
  2635884,
  2637356,
  -1,
  'b2511',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2511'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bamB',
  'outer membrane protein assembly factor BamB',
  2637474,
  2638652,
  -1,
  'b2512',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2512'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgM',
  'ancillary SecYEG translocon subunit',
  2638663,
  2639283,
  -1,
  'b2513',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2513'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisS',
  'histidine--tRNA ligase',
  2639301,
  2640575,
  -1,
  'b2514',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2514'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sroE',
  '—',
  2640595,
  2640686,
  -1,
  'b4761',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4761'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ispG',
  '(E)-4-hydroxy-3-methylbut-2-enyl-diphosphatesynthase (flavodoxin)',
  2640686,
  2641804,
  -1,
  'b2515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2515'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rodZ',
  'cytoskeleton protein RodZ',
  2641831,
  2642844,
  -1,
  'b2516',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2516'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmN',
  '23S rRNA m(2)A2503 methyltransferase/tRNAm(2)A37 methyltransferase',
  2643129,
  2644283,
  -1,
  'b2517',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2517'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ndk',
  'nucleoside diphosphate kinase',
  2644433,
  2644864,
  -1,
  'b2518',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2518'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pbpC',
  'peptidoglycan glycosyltransferase PbpC',
  2645013,
  2647325,
  -1,
  'b2519',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2519'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfhM',
  'alpha2-macroglobulin',
  2647326,
  2652287,
  -1,
  'b2520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2520'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sseA',
  '3-mercaptopyruvate sulfurtransferase',
  2652494,
  2653339,
  1,
  'b2521',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2521'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'timR',
  '—',
  2653356,
  2653455,
  -1,
  'b4811',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4811'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ryfA',
  '—',
  2653855,
  2654158,
  1,
  'b4440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4440'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'timP',
  'putative toxic protein TimP',
  2654001,
  2654126,
  1,
  'b4812',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4812'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sseB',
  'protein SseB',
  2654157,
  2654933,
  -1,
  'b2522',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2522'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pepB',
  'aminopeptidase B',
  2655075,
  2656358,
  -1,
  'b2523',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2523'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iscX',
  'accessory [Fe-S] cluster assembly protein IscX',
  2656536,
  2656736,
  -1,
  'b2524',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2524'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdx',
  'reduced ferredoxin',
  2656748,
  2657083,
  -1,
  'b2525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2525'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hscA',
  '[Fe-S] cluster biosynthesis chaperone HscA',
  2657085,
  2658935,
  -1,
  'b2526',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2526'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hscB',
  '[Fe-S] cluster biosynthesis co-chaperone HscB',
  2658952,
  2659467,
  -1,
  'b2527',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2527'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iscA',
  'iron-sulfur cluster insertion protein IscA',
  2659563,
  2659886,
  -1,
  'b2528',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2528'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iscU',
  'scaffold protein for [Fe-S] cluster assembly',
  2659903,
  2660289,
  -1,
  'b2529',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2529'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iscS',
  'cysteine desulfurase IscS',
  2660317,
  2661531,
  -1,
  'b2530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2530'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iscR',
  'DNA-binding transcriptional dual regulator IscR',
  2661643,
  2662131,
  -1,
  'b2531',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2531'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trmJ',
  'tRNA Cm32/Um32 methyltransferase',
  2662583,
  2663323,
  -1,
  'b2532',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2532'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'suhB',
  'Nus factor SuhB',
  2663442,
  2664245,
  1,
  'b2533',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2533'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfhR',
  'putative peptidase',
  2664390,
  2665244,
  1,
  'b2534',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2534'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csiE',
  'stationary phase-inducible protein CsiE',
  2665435,
  2666715,
  1,
  'b2535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2535'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaT',
  'putative 3-phenylpropionate transporter',
  2666707,
  2667846,
  -1,
  'b2536',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2536'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaR',
  'DNA-binding transcriptional dual regulator HcaR',
  2668006,
  2668896,
  -1,
  'b2537',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2537'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iroK',
  'protein IroK',
  2668006,
  2668071,
  -1,
  'b4706',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4706'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaE',
  'putative 3-phenylpropionate/cinnamatedioxygenase subunit alpha',
  2669032,
  2670393,
  1,
  'b2538',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2538'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaF',
  'putative 3-phenylpropionate/cinnamatedioxygenase subunit beta',
  2670390,
  2670908,
  1,
  'b2539',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2539'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaC',
  'putative 3-phenylpropionate/cinnamatedioxygenase ferredoxin subunit',
  2670908,
  2671228,
  1,
  'b2540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2540'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaB',
  '2,3-dihydroxy-2,3-dihydrophenylpropionatedehydrogenase',
  2671225,
  2672037,
  1,
  'b2541',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2541'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hcaD',
  'putative 3-phenylpropionate/cinnamatedioxygenase ferredoxin reductase subunit',
  2672047,
  2673249,
  1,
  'b2542',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2542'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphA',
  'putative inner membrane protein',
  2673346,
  2673768,
  1,
  'b2543',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2543'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphB',
  'putative aldose 1-epimerase YphB',
  2673816,
  2674688,
  -1,
  'b2544',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2544'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphC',
  'putative zinc-binding dehydrogenase YphC',
  2674700,
  2675761,
  -1,
  'b2545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2545'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphD',
  'putative ABC transporter membrane subunit YphD',
  2675827,
  2676825,
  -1,
  'b2546',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2546'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphE',
  'putative ABC transporter ATP-binding proteinYphE',
  2676850,
  2678361,
  -1,
  'b2547',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2547'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphF',
  'putative ABC transporter periplasmic bindingprotein YphF',
  2678384,
  2679367,
  -1,
  'b2548',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2548'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphG',
  'DUF5107 domain-containing protein YphG',
  2679464,
  2682745,
  -1,
  'b2549',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2549'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yphH',
  'putative DNA-binding transcriptional regulator,NAGC-like',
  2682863,
  2684056,
  1,
  'b2550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2550'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyA',
  'serine hydroxymethyltransferase',
  2684254,
  2685507,
  -1,
  'b2551',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2551'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hmp',
  'nitric oxide dioxygenase',
  2685835,
  2687025,
  1,
  'b2552',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2552'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glnB',
  'nitrogen regulatory protein PII-1',
  2687070,
  2687408,
  -1,
  'b2553',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2553'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glrR',
  'DNA-binding transcriptional activator GlrR',
  2687469,
  2688803,
  -1,
  'b2554',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2554'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'qseG',
  'outer membrane lipoprotein QseG',
  2688793,
  2689506,
  -1,
  'b2555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2555'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glrK',
  'histidine kinase GlrK',
  2689671,
  2691098,
  -1,
  'b2556',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2556'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glmY',
  '—',
  2691157,
  2691340,
  -1,
  'b4441',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4441'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purL',
  'phosphoribosylformylglycinamide synthetase',
  2691656,
  2695543,
  -1,
  'b2557',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2557'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mltF',
  'membrane-bound lytic murein transglycosylase F',
  2695801,
  2697357,
  1,
  'b2558',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2558'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tadA',
  'tRNA adenosine(34) deaminase',
  2697354,
  2697857,
  -1,
  'b2559',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2559'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pgpC',
  'phosphatidylglycerophosphatase C',
  2697915,
  2698550,
  -1,
  'b2560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2560'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfhH',
  'putative DNA-binding transcriptional regulatorYfhH',
  2698759,
  2699607,
  1,
  'b2561',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2561'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfhL',
  'putative 4Fe-4S cluster-containing protein YfhL',
  2699663,
  2699923,
  1,
  'b2562',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2562'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'shoB',
  'toxic peptide ShoB',
  2700117,
  2700197,
  -1,
  'b4687',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4687'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ohsC',
  '—',
  2700520,
  2700598,
  1,
  'b4608',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4608'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acpS',
  'holo-[acyl-carrier-protein] synthase',
  2700618,
  2700998,
  -1,
  'b2563',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2563'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdxJ',
  'pyridoxine 5''-phosphate synthase',
  2700998,
  2701729,
  -1,
  'b2564',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2564'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recO',
  'recombination mediator protein RecO',
  2701741,
  2702469,
  -1,
  'b2565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2565'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'era',
  '30S ribosomal subunit maturation GTPase Era',
  2702481,
  2703386,
  -1,
  'b2566',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2566'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnc',
  'RNase III',
  2703383,
  2704063,
  -1,
  'b2567',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2567'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lepB',
  'signal peptidase I',
  2704335,
  2705309,
  -1,
  'b2568',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2568'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lepA',
  '30S ribosomal subunit biogenesis factor LepA',
  2705325,
  2707124,
  -1,
  'b2569',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2569'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rseC',
  'regulatory protein RseC',
  2707322,
  2707801,
  -1,
  'b2570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2570'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rseB',
  'anti-sigma factor stabilizing protein RseB',
  2707798,
  2708754,
  -1,
  'b2571',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2571'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rseA',
  'anti-sigma-E factor RseA',
  2708754,
  2709404,
  -1,
  'b2572',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2572'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoE',
  'RNA polymerase sigma factor RpoE',
  2709437,
  2710012,
  -1,
  'b2573',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2573'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rseD',
  'rpoE leader peptide',
  2710009,
  2710164,
  -1,
  'b4725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4725'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nadB',
  'L-aspartate oxidase',
  2710420,
  2712042,
  1,
  'b2574',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2574'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiC',
  'tRNA m(6)A37 methyltransferase',
  2712027,
  2712764,
  -1,
  'b2575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2575'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srmB',
  'ATP-dependent RNA helicase SrmB',
  2712896,
  2714230,
  1,
  'b2576',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2576'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiE',
  'putative LysR-type DNA-binding transcriptionalregulator YfiE',
  2714439,
  2715320,
  -1,
  'b2577',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2577'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eamB',
  'cysteine/O-acetylserine exporter EamB',
  2715423,
  2716010,
  1,
  'b2578',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2578'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'grcA',
  'stress-induced alternate pyruvate formate-lyasesubunit',
  2716066,
  2716449,
  -1,
  'b2579',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2579'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ung',
  'uracil-DNA glycosylase',
  2716754,
  2717443,
  1,
  'b2580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2580'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiF',
  'putative methyltransferase YfiF',
  2717491,
  2718528,
  -1,
  'b2581',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2581'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trxC',
  'thioredoxin 2',
  2718735,
  2719154,
  1,
  'b2582',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2582'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tapT',
  'tRNA 3-amino-3-carboxypropyltransferase',
  2719223,
  2719921,
  1,
  'b2583',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2583'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'patZ',
  'peptidyl-lysine N-acetyltransferase',
  2719953,
  2722613,
  1,
  'b2584',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2584'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pssL',
  'protein PssL',
  2722702,
  2722743,
  1,
  'b4782',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4782'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pssA',
  'phosphatidylserine synthase',
  2722727,
  2724082,
  1,
  'b2585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2585'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiM',
  'DUF2279 domain-containing protein YfiM',
  2724128,
  2724451,
  1,
  'b2586',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2586'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kgtP',
  'alpha-ketoglutarate:H(+) symporter',
  2724448,
  2725746,
  -1,
  'b2587',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2587'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiS',
  'protein YfiS',
  2725925,
  2725987,
  1,
  'b4783',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4783'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrfG',
  '—',
  2726069,
  2726188,
  -1,
  'b2588',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2588'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrlG',
  '—',
  2726281,
  2729184,
  -1,
  'b2589',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2589'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltW',
  '—',
  2729369,
  2729444,
  -1,
  'b2590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2590'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrsG',
  '—',
  2729616,
  2731157,
  -1,
  'b2591',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2591'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'clpB',
  'ClpB80',
  2731600,
  2734173,
  -1,
  'b2592',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2592'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ryfD',
  '—',
  2734153,
  2734295,
  -1,
  'b4609',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4609'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiH',
  'purine nucleoside phosphorylase YfiH',
  2734303,
  2735034,
  -1,
  'b2593',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2593'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rluD',
  '23S rRNA pseudouridine(1911/1915/1917) synthase',
  2735031,
  2736011,
  -1,
  'b2594',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2594'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bamD',
  'outer membrane protein assembly factor BamD',
  2736146,
  2736883,
  1,
  'b2595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2595'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'raiA',
  'ribosome-associated inhibitor A',
  2737154,
  2737495,
  1,
  'b2597',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2597'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'raiZ',
  '—',
  2737381,
  2737542,
  1,
  'b4805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4805'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheL',
  'phe operon leader peptide',
  2737599,
  2737646,
  1,
  'b2598',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2598'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheA',
  'fused chorismate mutase/prephenate dehydratase',
  2737745,
  2738905,
  1,
  'b2599',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2599'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tyrA',
  'fused chorismate mutase/prephenatedehydrogenase',
  2738948,
  2740069,
  -1,
  'b2600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2600'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroF',
  '3-deoxy-7-phosphoheptulonate synthase,Tyr-sensitive',
  2740080,
  2741150,
  -1,
  'b2601',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2601'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiL',
  'DUF2799 domain-containing lipoprotein YfiL',
  2741360,
  2741725,
  1,
  'b2602',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2602'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiR',
  'DUF4154 domain-containing protein YfiR',
  2741875,
  2742393,
  1,
  'b2603',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2603'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcN',
  'diguanylate cyclase DgcN',
  2742383,
  2743609,
  1,
  'b2604',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2604'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfiB',
  'lipoprotein YfiB',
  2743625,
  2744107,
  1,
  'b2605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2605'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplS',
  '50S ribosomal subunit protein L19',
  2744183,
  2744530,
  -1,
  'b2606',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2606'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trmD',
  'tRNA m(1)G37 methyltransferase',
  2744572,
  2745339,
  -1,
  'b2607',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2607'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rimM',
  'ribosome maturation factor RimM',
  2745370,
  2745918,
  -1,
  'b2608',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2608'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsP',
  '30S ribosomal subunit protein S16',
  2745937,
  2746185,
  -1,
  'b2609',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2609'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ffh',
  'signal recognition particle protein component',
  2746434,
  2747795,
  -1,
  'b2610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2610'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjD',
  'cytochrome c assembly family protein',
  2747962,
  2748753,
  1,
  'b2611',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2611'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjD',
  'UPF0053 family inner membrane protein YfjD',
  2748774,
  2750060,
  1,
  'b4461',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4461'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'grpE',
  'nucleotide exchange factor GrpE',
  2750115,
  2750708,
  -1,
  'b2614',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2614'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nadK',
  'NAD kinase',
  2750831,
  2751709,
  1,
  'b2615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2615'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recN',
  'DNA repair protein RecN',
  2751795,
  2753456,
  1,
  'b2616',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2616'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bamE',
  'outer membrane protein assembly factor BamE',
  2753605,
  2753946,
  1,
  'b2617',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2617'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjF',
  'putative component of the Rsx system',
  2754008,
  2754298,
  -1,
  'b2618',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2618'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ratA',
  'ribosome association toxin RatA',
  2754288,
  2754764,
  -1,
  'b2619',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2619'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'smpB',
  'SsrA-binding protein',
  2754896,
  2755378,
  1,
  'b2620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2620'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ssrA',
  '—',
  2755593,
  2755955,
  1,
  'b2621',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2621'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intA',
  'integrase IntA',
  2756159,
  2757400,
  1,
  'b2622',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2622'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjH',
  'uncharacterized protein YfjH',
  2757644,
  2758600,
  -1,
  'b2623',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2623'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alpA',
  'DNA-binding transcriptional activator AlpA',
  2758644,
  2758856,
  1,
  'b2624',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2624'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjI',
  'DUF3987 domain-containing protein YfjI',
  2758985,
  2760394,
  1,
  'b2625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2625'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjJ',
  'protein YfjJ',
  2760547,
  2761173,
  1,
  'b2626',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2626'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'abpB',
  'putative helicase YfjK',
  2761351,
  2763540,
  -1,
  'b2627',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2627'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'abpA',
  'anti-bacteriophage protein',
  2763537,
  2765153,
  -1,
  'b2628',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2628'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjM',
  'protein YfjM',
  2765513,
  2765776,
  -1,
  'b2629',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2629'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnlA',
  'RNase LS, toxin of the RnlAB toxin-antitoxinsystem',
  2765918,
  2766991,
  1,
  'b2630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2630'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnlB',
  'antitoxin RnlB',
  2766984,
  2767355,
  1,
  'b2631',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2631'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjP',
  'putative GTP-binding protein YfjP',
  2767710,
  2768573,
  1,
  'b2632',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2632'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjQ',
  'DUF932 domain-containing protein YfjQ',
  2768665,
  2769486,
  1,
  'b2633',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2633'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjR',
  'putative DNA-binding transcriptional regulatorYfjR',
  2769703,
  2770404,
  1,
  'b2634',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2634'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjK',
  'uncharacterized protein YpjK',
  2770445,
  2770681,
  1,
  'b2635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2635'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjS',
  'inner membrane lipoprotein YfjS',
  2770681,
  2771124,
  1,
  'b2636',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2636'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjT',
  'uncharacterized protein YfjT',
  2771148,
  2771615,
  1,
  'b2637',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2637'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjU',
  'putative arsenate reductase-like protein YfjU',
  2771840,
  2772154,
  -1,
  'b2638',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2638'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjV',
  '—',
  2772167,
  2773182,
  -1,
  'b2641',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2641'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjW',
  'uncharacterized protein YfjW',
  2773318,
  2775021,
  1,
  'b2642',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2642'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjI',
  '—',
  2775545,
  2775816,
  1,
  'b4644',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4644'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lfgA',
  'putative antirestriction protein',
  2775919,
  2776377,
  1,
  'b2643',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2643'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lfgB',
  'CP4-57 prophage protease',
  2776386,
  2776868,
  1,
  'b2644',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2644'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjJ',
  'DUF987 domain-containing protein YpjJ',
  2776877,
  2777077,
  1,
  'b4548',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4548'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfjZ',
  'putative antitoxin of the YpjF-YfjZtoxin-antitoxin system',
  2777115,
  2777432,
  1,
  'b2645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2645'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjF',
  'toxin of the YpjF-YfjZ toxin-antitoxin system',
  2777453,
  2777782,
  1,
  'b2646',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2646'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'psaA',
  '—',
  2777972,
  2777985,
  1,
  'b4645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4645'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjA',
  'adhesin-like autotransporter YpjA',
  2778146,
  2782726,
  -1,
  'b2647',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2647'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pinH',
  '—',
  2783065,
  2783304,
  -1,
  'b2648',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2648'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjB',
  'DUF5508 domain-containing protein YpjB',
  2783638,
  2784429,
  -1,
  'b2649',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2649'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypjC',
  'DUF5507 domain-containing protein YpjC',
  2784529,
  2785011,
  -1,
  'b2650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2650'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ileY',
  '—',
  2785762,
  2785837,
  -1,
  'b2652',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2652'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaQ',
  '—',
  2786397,
  2788649,
  1,
  'b4462',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4462'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glaH',
  'glutarate dioxygenase GlaH',
  2788985,
  2789962,
  1,
  'b2659',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2659'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lhgD',
  'L-2-hydroxyglutarate dehydrogenase',
  2789982,
  2791250,
  1,
  'b2660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2660'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gabD',
  'succinate-semialdehyde dehydrogenase (NADP(+))GabD',
  2791273,
  2792721,
  1,
  'b2661',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2661'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gabT',
  '4-aminobutyrate aminotransferase GabT',
  2792735,
  2794015,
  1,
  'b2662',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2662'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gabP',
  '4-aminobutanoate:H(+) symporter',
  2794253,
  2795653,
  1,
  'b2663',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2663'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glaR',
  'DNA-binding transcriptional repressor GlaR',
  2795674,
  2796336,
  1,
  'b2664',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2664'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kbp',
  'K(+) binding protein',
  2796337,
  2796786,
  -1,
  'b2665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2665'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqaE',
  'Pmp3 family protein YqaE',
  2796870,
  2797028,
  -1,
  'b2666',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2666'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaV',
  'putative DNA-binding transcriptional regulatorYgaV',
  2797211,
  2797510,
  1,
  'b2667',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2667'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaP',
  'thiosulfate sulfurtransferase YgaP',
  2797520,
  2798044,
  1,
  'b2668',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2668'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'stpA',
  'DNA-binding transcriptional repressor StpA withRNA chaperone activity',
  2798091,
  2798495,
  -1,
  'b2669',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2669'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaE',
  'L-alanine exporter',
  2799164,
  2799613,
  1,
  'b2670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2670'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaC',
  'DUF2002 domain-containing protein YgaC',
  2799650,
  2799994,
  -1,
  'b2671',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2671'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaM',
  'tail-anchored inner membrane protein YgaM',
  2800146,
  2800475,
  1,
  'b2672',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2672'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdH',
  'glutaredoxin-like protein NrdH',
  2800723,
  2800968,
  1,
  'b2673',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2673'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdI',
  'dimanganese-tyrosyl radical cofactor maintenanceflavodoxin NrdI',
  2800965,
  2801375,
  1,
  'b2674',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2674'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdE',
  'ribonucleoside-diphosphate reductase 2 subunitalpha',
  2801348,
  2803492,
  1,
  'b2675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2675'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdF',
  'ribonucleoside-diphosphate reductase 2 subunitbeta',
  2803502,
  2804461,
  1,
  'b2676',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2676'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proV',
  'glycine betaine ABC transporter ATP bindingsubunit ProV',
  2804815,
  2806017,
  1,
  'b2677',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2677'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proW',
  'glycine betaine ABC transporter membrane subunitProW',
  2806010,
  2807074,
  1,
  'b2678',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2678'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proX',
  'glycine betaine ABC transporter periplasmicbinding protein ProX',
  2807132,
  2808124,
  1,
  'b2679',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2679'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaY',
  '—',
  2808316,
  2809493,
  1,
  'b2681',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2681'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaZ',
  'L-valine exporter, YgaZ component',
  2809617,
  2810354,
  1,
  'b2682',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2682'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygaH',
  'L-valine exporter, YgaH component',
  2810344,
  2810679,
  1,
  'b2683',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2683'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mprA',
  'DNA-binding transcriptional regulator MprA',
  2810770,
  2811300,
  1,
  'b2684',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2684'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'emrA',
  'multidrug efflux pump membrane fusion proteinEmrA',
  2811427,
  2812599,
  1,
  'b2685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2685'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'emrB',
  'multidrug efflux pump membrane subunit EmrB',
  2812616,
  2814154,
  1,
  'b2686',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2686'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'luxS',
  'S-ribosylhomocysteine lyase',
  2814218,
  2814733,
  -1,
  'b2687',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2687'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'micA',
  '—',
  2814802,
  2814874,
  1,
  'b4442',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4442'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gshA',
  'glutamate--cysteine ligase',
  2814883,
  2816439,
  -1,
  'b2688',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2688'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqaA',
  'DedA family protein YqaA',
  2816512,
  2816940,
  -1,
  'b2689',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2689'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqaB',
  'fructose-1-phosphate phosphatase YqaB',
  2816937,
  2817503,
  -1,
  'b2690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2690'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argQ',
  '—',
  2817784,
  2817860,
  -1,
  'b2691',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2691'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argZ',
  '—',
  2818059,
  2818135,
  -1,
  'b2692',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2692'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argY',
  '—',
  2818198,
  2818274,
  -1,
  'b2693',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2693'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argV',
  '—',
  2818473,
  2818549,
  -1,
  'b2694',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2694'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'serV',
  '—',
  2818553,
  2818645,
  -1,
  'b2695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2695'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csrA',
  'carbon storage regulator',
  2818961,
  2819146,
  -1,
  'b2696',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2696'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaS',
  'alanine--tRNA ligase/DNA-binding transcriptionalrepressor',
  2819381,
  2822011,
  -1,
  'b2697',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2697'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recX',
  'RecA inhibitor RecX',
  2822139,
  2822639,
  -1,
  'b2698',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2698'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recA',
  'DNA recombination/repair protein RecA',
  2822708,
  2823769,
  -1,
  'b2699',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2699'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pncC',
  'NMN aminohydrolase',
  2823849,
  2824346,
  -1,
  'b2700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2700'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mltB',
  'membrane-bound lytic murein transglycosylase B',
  2824491,
  2825576,
  -1,
  'b2701',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2701'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srlA',
  'sorbitol-specific PTS enzyme IIC2 component',
  2825832,
  2826395,
  1,
  'b2702',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2702'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srlE',
  'sorbitol-specific PTS enzyme IIBC1 component',
  2826392,
  2827351,
  1,
  'b2703',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2703'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srlB',
  'sorbitol-specific PTS enzyme IIA component',
  2827362,
  2827733,
  1,
  'b2704',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2704'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srlD',
  'sorbitol-6-phosphate 2-dehydrogenase',
  2827737,
  2828516,
  1,
  'b2705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2705'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gutM',
  'DNA-binding transcriptional activator GutM',
  2828621,
  2828980,
  1,
  'b2706',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2706'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srlR',
  'DNA-binding transcriptional repressor SrlR',
  2829047,
  2829820,
  1,
  'b2707',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2707'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gutQ',
  'D-arabinose 5-phosphate isomerase GutQ',
  2829813,
  2830778,
  1,
  'b2708',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2708'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'norR',
  'DNA-binding transcriptional dual regulator NorR',
  2830775,
  2832289,
  -1,
  'b2709',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2709'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'norV',
  'anaerobic nitric oxide reductaseflavorubredoxin',
  2832476,
  2833915,
  1,
  'b2710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2710'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'norW',
  'NADH:flavorubredoxin reductase',
  2833912,
  2835045,
  1,
  'b2711',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2711'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypF',
  'carbamoyl--[HypE] ligase',
  2835173,
  2837425,
  -1,
  'b2712',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2712'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hydN',
  'putative electron transport protein HydN',
  2837578,
  2838105,
  -1,
  'b2713',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2713'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ascG',
  'DNA-binding transcriptional repressor AscG',
  2838254,
  2839264,
  -1,
  'b2714',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2714'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ascF',
  'cryptic beta-glucoside specific PTS enzyme IIBCcomponent',
  2839524,
  2840981,
  1,
  'b2715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2715'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ascB',
  'cryptic 6-phospho-beta-glucosidase AscB',
  2840990,
  2842414,
  1,
  'b2716',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2716'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycI',
  'hydrogenase 3 maturation protease',
  2842573,
  2843043,
  -1,
  'b2717',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2717'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycH',
  'formate hydrogenlyase assembly protein',
  2843036,
  2843446,
  -1,
  'b2718',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2718'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycG',
  'hydrogenase 3 [Fe-S] protein HycG',
  2843443,
  2844210,
  -1,
  'b2719',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2719'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycF',
  'hydrogenase 3 [Fe-S] protein HycF',
  2844210,
  2844752,
  -1,
  'b2720',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2720'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycE',
  'hydrogenase 3 large subunit',
  2844762,
  2846471,
  -1,
  'b2721',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2721'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycD',
  'hydrogenase 3 membrane subunit HycD',
  2846489,
  2847412,
  -1,
  'b2722',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2722'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycC',
  'hydrogenase 3 membrane subunit HycC',
  2847415,
  2849241,
  -1,
  'b2723',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2723'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycB',
  'hydrogenase 3 [Fe-S] protein HycB',
  2849238,
  2849849,
  -1,
  'b2724',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2724'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hycA',
  'regulator of the transcriptional regulator FhlA',
  2849974,
  2850435,
  -1,
  'b2725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2725'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypA',
  'hydrogenase 3 Ni(2(+)) incorporation proteinHypA',
  2850647,
  2850997,
  1,
  'b2726',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2726'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypB',
  'hydrogenase isoenzymes Ni(2(+)) incorporationprotein HypB',
  2851001,
  2851873,
  1,
  'b2727',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2727'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypC',
  'hydrogenase maturation factor HypC',
  2851864,
  2852136,
  1,
  'b2728',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2728'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypD',
  'Fe-(CN)2CO cofactor assembly scaffold proteinHypD',
  2852136,
  2853257,
  1,
  'b2729',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2729'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hypE',
  'carbamoyl dehydratase HypE',
  2853254,
  2854264,
  1,
  'b2730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2730'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fhlA',
  'DNA-binding transcriptional activator FhlA',
  2854338,
  2856416,
  1,
  'b2731',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2731'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbA',
  'protein YgbA',
  2856453,
  2856806,
  -1,
  'b2732',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2732'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mutS',
  'DNA mismatch repair protein MutS',
  2857093,
  2859654,
  1,
  'b2733',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2733'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pphB',
  'phosphoprotein phosphatase 2',
  2859760,
  2860416,
  1,
  'b2734',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2734'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbI',
  'DNA-binding transcriptional repressor YgbI',
  2860467,
  2861234,
  -1,
  'b2735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2735'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbJ',
  'putative L-threonate dehydrogenase',
  2861430,
  2862338,
  1,
  'b2736',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2736'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbK',
  'putative 3-oxo-tetronate kinase YgbK',
  2862335,
  2863501,
  1,
  'b2737',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2737'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbL',
  'putative 3-oxo-tetronate 4-phosphatedecarboxylase YgbL',
  2863593,
  2864231,
  1,
  'b2738',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2738'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbM',
  'putative 2-oxo-tetronate isomerase YgbM',
  2864236,
  2865012,
  1,
  'b2739',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2739'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbN',
  'putative transporter YgbN',
  2865101,
  2866465,
  1,
  'b2740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2740'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoS',
  'RNA polymerase sigma factor RpoS',
  2866559,
  2867551,
  -1,
  'b2741',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2741'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nlpD',
  'murein hydrolase activator NlpD',
  2867614,
  2868753,
  -1,
  'b2742',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2742'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pcm',
  'protein-L-isoaspartate O-methyltransferase',
  2868893,
  2869519,
  -1,
  'b2743',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2743'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'umpG',
  'broad specificity 5''(3'')-nucleotidase andpolyphosphatase',
  2869513,
  2870274,
  -1,
  'b2744',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2744'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'truD',
  'tRNA pseudouridine(13) synthase',
  2870255,
  2871304,
  -1,
  'b2745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2745'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ispF',
  '2-C-methyl-D-erythritol 2,4-cyclodiphosphatesynthase',
  2871301,
  2871780,
  -1,
  'b2746',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2746'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ispD',
  '2-C-methyl-D-erythritol 4-phosphatecytidylyltransferase',
  2871780,
  2872490,
  -1,
  'b2747',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2747'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsB',
  'cell division protein FtsB',
  2872509,
  2872820,
  -1,
  'b2748',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2748'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygbE',
  'DUF3561 domain-containing inner membrane proteinYgbE',
  2873014,
  2873337,
  -1,
  'b2749',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2749'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysC',
  'adenylyl-sulfate kinase',
  2873387,
  2873992,
  -1,
  'b2750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2750'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysN',
  'sulfate adenylyltransferase subunit 1',
  2873992,
  2875419,
  -1,
  'b2751',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2751'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysD',
  'sulfate adenylyltransferase subunit 2',
  2875421,
  2876329,
  -1,
  'b2752',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2752'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'iap',
  'alkaline phosphatase isozyme conversion protein',
  2876581,
  2877618,
  1,
  'b2753',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2753'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cas2',
  'CRISPR-associated endoribonuclease Cas2',
  2878569,
  2878853,
  -1,
  'b2754',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2754'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cas1',
  'multifunctional nuclease Cas1',
  2878855,
  2879772,
  -1,
  'b2755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2755'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'casE',
  'pre-CRISPR RNA endonuclease',
  2879788,
  2880387,
  -1,
  'b2756',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2756'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'casD',
  'type I-E CRISPR system Cascade subunit CasD',
  2880374,
  2881048,
  -1,
  'b2757',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2757'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'casC',
  'type I-E CRISPR system Cascade subunit CasC',
  2881051,
  2882142,
  -1,
  'b2758',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2758'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'casB',
  'type I-E CRISPR system Cascade subunit CasB',
  2882155,
  2882637,
  -1,
  'b2759',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2759'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'casA',
  'type I-E CRISPR system Cascade subunit CasA',
  2882630,
  2884138,
  -1,
  'b2760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2760'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cas3',
  'CRISPR-associated endonuclease/helicase Cas3',
  2884553,
  2887219,
  -1,
  'b2761',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2761'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sokX',
  '—',
  2887353,
  2887411,
  1,
  'b4701',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4701'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysH',
  'phosphoadenosine phosphosulfate reductase',
  2887578,
  2888312,
  -1,
  'b2762',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2762'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysI',
  'sulfite reductase, hemoprotein subunit',
  2888387,
  2890099,
  -1,
  'b2763',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2763'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysJ',
  'sulfite reductase, flavoprotein subunit',
  2890099,
  2891898,
  -1,
  'b2764',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2764'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'queD',
  '6-carboxy-5,6,7,8-tetrahydropterin synthase',
  2892214,
  2892579,
  1,
  'b2765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2765'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcN',
  'putative oxidoreductase with FAD/NAD(P)-bindingdomain',
  2892657,
  2893928,
  1,
  'b2766',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2766'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcO',
  'putative 4Fe-4S cluster-containing protein',
  2893919,
  2894179,
  1,
  'b2767',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2767'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcP',
  'putative anti-terminator regulatory protein',
  2894196,
  2894771,
  1,
  'b2768',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2768'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcQ',
  'putative flavoprotein',
  2894919,
  2895779,
  -1,
  'b2769',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2769'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcR',
  'putative flavoprotein',
  2895776,
  2896555,
  -1,
  'b2770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2770'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcS',
  'putative transporter YgcS',
  2896533,
  2897870,
  -1,
  'b2771',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2771'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcU',
  'putative FAD-containing dehydrogenase',
  2897964,
  2899418,
  -1,
  'b4463',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4463'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcW',
  'putative deoxygluconate dehydrogenase',
  2899488,
  2900273,
  -1,
  'b2774',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2774'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqcE',
  'putative transport protein YqcE',
  2900592,
  2901869,
  1,
  'b2775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2775'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcE',
  'putative sugar kinase YgcE',
  2901896,
  2903374,
  1,
  'b2776',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2776'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'queE',
  'putative 7-carboxy-7-deazaguanine synthase QueE',
  2904747,
  2905418,
  -1,
  'b2777',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2777'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqcG',
  'cell envelope stress response protein YqcG',
  2905557,
  2905697,
  1,
  'b4682',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4682'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygcG',
  'TPM domain-containing protein YgcG',
  2905711,
  2906583,
  1,
  'b2778',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2778'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eno',
  'enolase',
  2906643,
  2907941,
  -1,
  'b2779',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2779'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrG',
  'CTP synthetase',
  2908029,
  2909666,
  -1,
  'b2780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2780'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mazG',
  'nucleoside triphosphate pyrophosphohydrolase',
  2909894,
  2910685,
  -1,
  'b2781',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2781'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mazF',
  'endoribonuclease toxin MazF',
  2910756,
  2911091,
  -1,
  'b2782',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2782'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ameF',
  '—',
  2911051,
  2911450,
  1,
  'b4844',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4844'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mazE',
  'antitoxin of the MazF-MazE toxin-antitoxinsystem MazE',
  2911091,
  2911339,
  -1,
  'b2783',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2783'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'relA',
  'GDP/GTP pyrophosphokinase',
  2911417,
  2913651,
  -1,
  'b2784',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2784'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmD',
  '23S rRNA m(5)U1939 methyltransferase',
  2913699,
  2915000,
  -1,
  'b2785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2785'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'barA',
  'sensor histidine kinase BarA',
  2915057,
  2917813,
  1,
  'b2786',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2786'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gudD',
  'D-glucarate dehydratase',
  2918045,
  2919385,
  -1,
  'b2787',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2787'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gudX',
  'glucarate dehydratase-related protein',
  2919406,
  2920746,
  -1,
  'b2788',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2788'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gudP',
  'galactarate/D-glucarate transporter GudP',
  2920748,
  2922100,
  -1,
  'b2789',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2789'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqcA',
  'putative flavodoxin YqcA',
  2922535,
  2922984,
  -1,
  'b2790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2790'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'truC',
  'tRNA pseudouridine(65) synthase',
  2923002,
  2923784,
  -1,
  'b2791',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2791'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqcC',
  'DUF446 domain-containing protein YqcC',
  2923784,
  2924113,
  -1,
  'b2792',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2792'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csrB',
  '—',
  2924156,
  2924524,
  -1,
  'b4408',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4408'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'syd',
  'SecY-interacting protein',
  2924735,
  2925280,
  -1,
  'b2793',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2793'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'queF',
  '7-cyano-7-deazaguanine reductase',
  2925348,
  2926196,
  1,
  'b2794',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2794'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppnN',
  'nucleotide 5''-monophosphate nucleosidase',
  2926308,
  2927672,
  1,
  'b2795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2795'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdaC',
  'L-serine:H(+) symporter',
  2928229,
  2929518,
  1,
  'b2796',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2796'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdaB',
  'L-serine deaminase II',
  2929576,
  2930943,
  1,
  'b2797',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2797'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdG',
  'flap endonuclease',
  2931055,
  2931810,
  1,
  'b2798',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2798'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucO',
  'L-1,2-propanediol oxidoreductase',
  2931865,
  2933013,
  -1,
  'b2799',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2799'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucA',
  'L-fuculose-phosphate aldolase',
  2933041,
  2933688,
  -1,
  'b2800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2800'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucP',
  'L-fucose:H(+) symporter',
  2934235,
  2935551,
  1,
  'b2801',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2801'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucI',
  'L-fucose isomerase',
  2935584,
  2937359,
  1,
  'b2802',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2802'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucK',
  'L-fuculokinase',
  2937468,
  2938886,
  1,
  'b2803',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2803'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucU',
  'L-fucose mutarotase',
  2938888,
  2939310,
  1,
  'b2804',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2804'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fucR',
  'DNA-binding transcriptional activator FucR',
  2939368,
  2940099,
  1,
  'b2805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2805'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmM',
  '23S rRNA 2''-O-ribose C2498 methyltransferase',
  2940143,
  2941243,
  -1,
  'b2806',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2806'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdD',
  'DUF423 domain-containing inner membrane proteinYgdD',
  2941236,
  2941631,
  -1,
  'b2807',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2807'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gcvA',
  'DNA-binding transcriptional dual regulator GcvA',
  2941650,
  2942567,
  -1,
  'b2808',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2808'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gcvB',
  '—',
  2942696,
  2942901,
  1,
  'b4443',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4443'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdI',
  'DUF903 domain-containing lipoprotein YgdI',
  2942918,
  2943145,
  -1,
  'b2809',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2809'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csdA',
  'cysteine sulfinate desulfinase',
  2943337,
  2944542,
  1,
  'b2810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2810'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'csdE',
  'sulfur acceptor protein CsdE',
  2944542,
  2944985,
  1,
  'b2811',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2811'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tcdA',
  'tRNA threonylcarbamoyladenosine dehydratase',
  2945036,
  2945842,
  -1,
  'b2812',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2812'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mltA',
  'membrane-bound lytic murein transglycosylase A',
  2946081,
  2947178,
  -1,
  'b2813',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2813'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metZ',
  '—',
  2947387,
  2947463,
  1,
  'b2814',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2814'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metW',
  '—',
  2947497,
  2947573,
  1,
  'b2815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2815'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metV',
  '—',
  2947607,
  2947683,
  1,
  'b2816',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2816'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'amiC',
  'N-acetylmuramoyl-L-alanine amidase C',
  2947757,
  2949010,
  -1,
  'b2817',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2817'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argA',
  'N-acetylglutamate synthase',
  2949242,
  2950573,
  1,
  'b2818',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2818'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recD',
  'exodeoxyribonuclease V subunit RecD',
  2950635,
  2952461,
  -1,
  'b2819',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2819'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recB',
  'exodeoxyribonuclease V subunit RecB',
  2952461,
  2956003,
  -1,
  'b2820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2820'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptrA',
  'protease 3',
  2955996,
  2958884,
  -1,
  'b2821',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2821'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recC',
  'exodeoxyribonuclease V subunit RecC',
  2959060,
  2962428,
  -1,
  'b2822',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2822'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppdC',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein PpdC',
  2962441,
  2962764,
  -1,
  'b2823',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2823'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdB',
  'DUF2509 domain-containing protein YgdB',
  2962749,
  2963156,
  -1,
  'b2824',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2824'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppdB',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein PpdB',
  2963153,
  2963716,
  -1,
  'b2825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2825'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppdA',
  'prepilin-type N-terminal cleavage/methylationdomain-containing protein PpdA',
  2963707,
  2964177,
  -1,
  'b2826',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2826'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thyA',
  'thymidylate synthase',
  2964361,
  2965155,
  -1,
  'b2827',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2827'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lgt',
  'phosphatidylglycerol--prolipoproteindiacylglyceryl transferase',
  2965162,
  2966037,
  -1,
  'b2828',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2828'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptsP',
  'phosphoenolpyruvate-protein phosphotransferasePtsP',
  2966188,
  2968434,
  -1,
  'b2829',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2829'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rppH',
  'RNA pyrophosphohydrolase',
  2968447,
  2968977,
  -1,
  'b2830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2830'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdT',
  'YgdT',
  2969330,
  2969476,
  -1,
  'b4610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4610'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mutH',
  'DNA mismatch repair protein MutH',
  2969662,
  2970351,
  1,
  'b2831',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2831'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdQ',
  'PF03741 family inner membrane protein YgdQ',
  2970420,
  2971133,
  1,
  'b2832',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2832'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygdR',
  'DUF903 domain-containing lipoprotein YgdR',
  2971271,
  2971489,
  1,
  'b2833',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2833'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tas',
  'putative NADP(H)-dependent aldo-keto reductaseTas',
  2971597,
  2972637,
  1,
  'b2834',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2834'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lplT',
  'lysophospholipid transporter',
  2972669,
  2973862,
  -1,
  'b2835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2835'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aas',
  'fused 2-acylglycerophospho-ethanolamineacyltransferase/acyl-acyl carrier protein synthetase',
  2973855,
  2976014,
  -1,
  'b2836',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2836'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'omrA',
  '—',
  2976102,
  2976189,
  -1,
  'b4444',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4444'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'omrB',
  '—',
  2976304,
  2976385,
  -1,
  'b4445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4445'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'galR',
  'DNA-binding transcriptional dual regulator GalR',
  2976599,
  2977630,
  1,
  'b2837',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2837'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysA',
  'diaminopimelate decarboxylase',
  2977637,
  2978899,
  -1,
  'b2838',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2838'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysR',
  'DNA-binding transcriptional dual regulator LysR',
  2979021,
  2979956,
  1,
  'b2839',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2839'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeA',
  'amino acid racemase YgeA',
  2979943,
  2980635,
  -1,
  'b2840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2840'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'araE',
  'arabinose:H(+) symporter',
  2980764,
  2982182,
  -1,
  'b2841',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2841'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kduD',
  '2-keto-3-deoxy-D-gluconate dehydrogenase',
  2982497,
  2983258,
  -1,
  'b2842',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2842'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kduI',
  '5-dehydro-4-deoxy-D-glucuronate isomerase',
  2983288,
  2984124,
  -1,
  'b2843',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2843'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeF',
  'putative acyltransferase',
  2984411,
  2985592,
  -1,
  'b2844',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2844'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeG',
  'putative transporter YqeG',
  2985847,
  2987076,
  1,
  'b2845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2845'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeH',
  'putative LuxR family transcriptional regulatorYqeH',
  2987536,
  2988168,
  1,
  'b2846',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2846'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeI',
  'putative transcriptional regulator YqeI',
  2988502,
  2989311,
  1,
  'b2847',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2847'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeJ',
  'protein YqeJ',
  2989304,
  2989786,
  1,
  'b2848',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2848'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeL',
  'uncharacterized protein YqeL',
  2989819,
  2989899,
  -1,
  'b4683',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4683'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeK',
  'protein YqeK',
  2989935,
  2990360,
  -1,
  'b2849',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2849'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeF',
  '—',
  2990554,
  2991043,
  1,
  'b2850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2850'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeG',
  'TPR repeat-containing putative chaperone YgeG',
  2991268,
  2991759,
  1,
  'b2851',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2851'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeH',
  'putative transcriptional regulator YgeH',
  2992094,
  2993470,
  1,
  'b2852',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2852'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeI',
  'protein YgeI',
  2993638,
  2993856,
  1,
  'b2853',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2853'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pbl',
  '—',
  2993939,
  2994441,
  1,
  'b2854',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2854'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeK',
  '—',
  2994460,
  2994903,
  -1,
  'b2855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2855'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeL',
  '—',
  2994937,
  2995092,
  -1,
  'b2856',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2856'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeN',
  '—',
  2995314,
  2996020,
  -1,
  'b2858',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2858'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeO',
  '—',
  2995962,
  2996360,
  -1,
  'b2859',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2859'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insD4',
  'IS2 insertion element protein InsB',
  2996372,
  2997277,
  -1,
  'b2860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2860'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insC4',
  'IS2 insertion element repressor InsA',
  2997235,
  2997600,
  -1,
  'b2861',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2861'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeP',
  '—',
  2997689,
  2997988,
  -1,
  'b2862',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2862'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeQ',
  'putative lipoprotein YgeQ',
  2998034,
  2998828,
  -1,
  'b2863',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2863'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyU',
  '—',
  2998984,
  2999057,
  -1,
  'b2864',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2864'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'actS',
  'amidase activator',
  2999136,
  2999891,
  -1,
  'b2865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2865'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xdhA',
  'putative xanthine dehydrogenasemolybdenum-binding subunit XdhA',
  3000345,
  3002603,
  1,
  'b2866',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2866'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xdhB',
  'putative xanthine dehydrogenase FAD-bindingsubunit XdhB',
  3002614,
  3003492,
  1,
  'b2867',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2867'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xdhC',
  'putative xanthine dehydrogenase [Fe-S]-bindingsubunit XdhC',
  3003489,
  3003968,
  1,
  'b2868',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2868'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeV',
  'putative sigma(54)-dependent transcriptionalregulator YgeV',
  3004008,
  3005786,
  -1,
  'b2869',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2869'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeW',
  'putative carbamoyltransferase YgeW',
  3006262,
  3007452,
  1,
  'b2870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2870'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeX',
  '2,3-diaminopropionate ammonia-lyase',
  3007510,
  3008706,
  1,
  'b2871',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2871'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygeY',
  'putative peptidase YgeY',
  3008764,
  3009975,
  1,
  'b2872',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2872'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyuA',
  'phenylhydantoinase',
  3010028,
  3011413,
  1,
  'b2873',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2873'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeA',
  'putative amino acid kinase YqeA',
  3011461,
  3012393,
  1,
  'b2874',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2874'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeB',
  'XdhC-CoxI family protein YqeB',
  3012614,
  3014239,
  -1,
  'b2875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2875'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqeC',
  'uncharacterized protein YqeC',
  3014287,
  3015057,
  -1,
  'b2876',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2876'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mocA',
  'molybdenum cofactor cytidylyltransferase',
  3015160,
  3015738,
  1,
  'b2877',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2877'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfK',
  'putative oxidoreductase, Fe-S subunit',
  3016060,
  3019158,
  1,
  'b2878',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2878'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ssnA',
  'putative aminohydrolase SsnA',
  3019161,
  3020489,
  1,
  'b2879',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2879'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfM',
  'putative oxidoreductase',
  3020540,
  3021319,
  1,
  'b2880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2880'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xdhD',
  'fused putative xanthine/hypoxanthine oxidase:molybdopterin-binding subunit and Fe-S binding subunit',
  3021316,
  3024186,
  1,
  'b2881',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2881'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xanQ',
  'xanthine:H(+) symporter XanQ',
  3024351,
  3025751,
  1,
  'b2882',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2882'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'guaD',
  'guanine deaminase',
  3025766,
  3027085,
  1,
  'b2883',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2883'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ghxQ',
  'guanine/hypoxanthine transporter GhxQ',
  3027121,
  3028488,
  1,
  'b4464',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4464'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfS',
  'putative electron transport protein YgfS',
  3028524,
  3029012,
  -1,
  'b2886',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2886'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfT',
  'putative oxidoreductase YgfT',
  3029012,
  3030931,
  -1,
  'b2887',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2887'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uacT',
  'urate:H(+) symporter',
  3031367,
  3032815,
  1,
  'b2888',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2888'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqfG',
  'uncharacterized protein YqfG',
  3032817,
  3032942,
  1,
  'b4684',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4684'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqfH',
  'protein YqfH',
  3032939,
  3033010,
  -1,
  'b4753',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4753'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'idi',
  'isopentenyl-diphosphate Delta-isomerase',
  3033065,
  3033613,
  1,
  'b2889',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2889'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysS',
  'lysine--tRNA ligase',
  3033657,
  3035174,
  -1,
  'b2890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2890'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prfB',
  'peptide chain release factor RF2',
  3035184,
  3036282,
  -1,
  'b2891',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2891'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recJ',
  'ssDNA-specific exonuclease RecJ',
  3036373,
  3038106,
  -1,
  'b2892',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2892'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsbC',
  'protein disulfide isomerase DsbC',
  3038112,
  3038822,
  -1,
  'b2893',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2893'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xerD',
  'site-specific recombinase',
  3038847,
  3039743,
  -1,
  'b2894',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2894'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fldB',
  'flavodoxin 2',
  3039855,
  3040376,
  1,
  'b2895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2895'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfX',
  'protein YgfX',
  3040416,
  3040823,
  -1,
  'b2896',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2896'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdhE',
  'FAD assembly factor',
  3040804,
  3041070,
  -1,
  'b2897',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2897'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfZ',
  'folate-binding protein YgfZ',
  3041313,
  3042293,
  1,
  'b2898',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2898'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trhA',
  'transmembrane homeostasis protein A',
  3042489,
  3043148,
  -1,
  'b2899',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2899'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqfB',
  'N(4)-acetylcytidine amidohydrolase',
  3043312,
  3043623,
  -1,
  'b2900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2900'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglA',
  '6-phospho-beta-glucosidase A',
  3043662,
  3045101,
  1,
  'b2901',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2901'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfF',
  'putative oxidoreductase YgfF',
  3045158,
  3045901,
  -1,
  'b2902',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2902'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gcvP',
  'glycine decarboxylase',
  3046168,
  3049041,
  -1,
  'b2903',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2903'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gcvH',
  'glycine cleavage system H protein',
  3049160,
  3049549,
  -1,
  'b2904',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2904'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gcvT',
  'aminomethyltransferase',
  3049573,
  3050667,
  -1,
  'b2905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2905'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqfI',
  'protein YqfI',
  3050958,
  3051041,
  1,
  'b4754',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4754'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiI',
  '2-octaprenylphenol 6-hydroxylase',
  3051115,
  3052317,
  -1,
  'b2906',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2906'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiH',
  '2-octaprenyl-6-methoxyphenol 4-hydroxylase',
  3052340,
  3053518,
  -1,
  'b2907',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2907'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pepP',
  'Xaa-Pro aminopeptidase',
  3053515,
  3054840,
  -1,
  'b2908',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2908'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygfB',
  'PF03695 family protein YgfB',
  3054866,
  3055444,
  -1,
  'b2909',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2909'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zapA',
  'cell division protein ZapA',
  3055612,
  3055941,
  1,
  'b2910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2910'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ssrS',
  '—',
  3055983,
  3056165,
  1,
  'b2911',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2911'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fau',
  '5-formyltetrahydrofolate cyclo-ligase',
  3056241,
  3056789,
  1,
  'b2912',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2912'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sibC',
  '—',
  3056851,
  3056991,
  1,
  'b4446',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4446'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibsC',
  'toxic peptide IbsC',
  3056890,
  3056949,
  -1,
  'b4665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4665'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'serA',
  'phosphoglycerate dehydrogenase',
  3057178,
  3058410,
  -1,
  'b2913',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2913'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpiA',
  'ribose-5-phosphate isomerase A',
  3058666,
  3059325,
  -1,
  'b2914',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2914'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqfE',
  '—',
  3059381,
  3059611,
  -1,
  'b2915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2915'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argP',
  'DNA-binding transcriptional dual regulator ArgP',
  3059753,
  3060646,
  1,
  'b2916',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2916'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'scpA',
  'methylmalonyl-CoA mutase',
  3060850,
  3062994,
  1,
  'b2917',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2917'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argK',
  'methylmalonyl-CoA mutase-interacting GTPaseYgfD',
  3062987,
  3063982,
  1,
  'b2918',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2918'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'scpB',
  'methylmalonyl-CoA decarboxylase',
  3063993,
  3064778,
  1,
  'b2919',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2919'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'scpC',
  'propionyl-CoA:succinate CoA transferase',
  3064802,
  3066280,
  1,
  'b2920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2920'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'srsR',
  'DNA-binding transcriptional activator YgfI',
  3066277,
  3067173,
  -1,
  'b2921',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2921'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggE',
  'DUF541 domain-containing protein YggE',
  3067340,
  3068080,
  -1,
  'b2922',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2922'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argO',
  'L-arginine exporter',
  3068173,
  3068808,
  -1,
  'b2923',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2923'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mscS',
  'small conductance mechanosensitive channel MscS',
  3068947,
  3069807,
  -1,
  'b2924',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2924'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fbaA',
  'fructose-bisphosphate aldolase class II',
  3070165,
  3071244,
  -1,
  'b2925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2925'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pgk',
  'phosphoglycerate kinase',
  3071459,
  3072622,
  -1,
  'b2926',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2926'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'epd',
  'D-erythrose-4-phosphate dehydrogenase',
  3072672,
  3073691,
  -1,
  'b2927',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2927'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggC',
  'P-loop NTPase domain-containing protein YggC',
  3073976,
  3074689,
  -1,
  'b2928',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2928'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fumE',
  'fumarase E',
  3074686,
  3075195,
  -1,
  'b2929',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2929'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggF',
  'fructose 1,6-bisphosphatase YggF',
  3075217,
  3076182,
  -1,
  'b2930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2930'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggP',
  'putative zinc-binding dehydrogenase YggP',
  3076179,
  3077456,
  -1,
  'b4465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4465'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cmtA',
  'mannitol-specific PTS enzyme IICB componentCmtA',
  3077471,
  3078859,
  -1,
  'b2933',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2933'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cmtB',
  'mannitol-specific PTS enzyme IIA component CmtB',
  3078887,
  3079330,
  -1,
  'b2934',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2934'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tktA',
  'transketolase 1',
  3079644,
  3081635,
  -1,
  'b2935',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2935'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'loiP',
  'metalloprotease LoiP',
  3081913,
  3082671,
  1,
  'b2936',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2936'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'speB',
  'agmatinase',
  3082877,
  3083797,
  -1,
  'b2937',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2937'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'speA',
  'biosynthetic arginine decarboxylase',
  3083935,
  3085911,
  -1,
  'b2938',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2938'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgB',
  'acid stress response protein YqgB',
  3085920,
  3086051,
  -1,
  'b2939',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2939'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgG',
  'protein YqgG',
  3086145,
  3086288,
  -1,
  'b4784',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4784'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgC',
  'protein YqgC',
  3086187,
  3086402,
  1,
  'b2940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2940'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgD',
  'DUF2684 domain-containing protein YqgD',
  3086399,
  3086650,
  -1,
  'b2941',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2941'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metK',
  'methionine adenosyltransferase',
  3086706,
  3087860,
  1,
  'b2942',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2942'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'galP',
  'galactose:H(+) symporter',
  3088284,
  3089678,
  1,
  'b2943',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2943'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggI',
  'protein YggI',
  3089755,
  3090252,
  1,
  'b2944',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2944'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'endA',
  'DNA-specific endonuclease I',
  3090347,
  3091054,
  1,
  'b2945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2945'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmE',
  '16S rRNA m(3)U1498 methyltransferase',
  3091134,
  3091865,
  1,
  'b2946',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2946'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gshB',
  'glutathione synthetase',
  3091878,
  3092828,
  1,
  'b2947',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2947'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgE',
  'DUF179 domain-containing protein YqgE',
  3092937,
  3093500,
  1,
  'b2948',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2948'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgF',
  'ribonuclease H-like domain-containing nuclease',
  3093500,
  3093916,
  1,
  'b2949',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2949'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggR',
  'Type II/IV secretion system family protein',
  3094100,
  3095080,
  -1,
  'b2950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2950'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggS',
  'PLP homeostasis protein',
  3095098,
  3095802,
  1,
  'b2951',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2951'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggT',
  'uncharacterized protein YggT',
  3095820,
  3096386,
  1,
  'b2952',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2952'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggU',
  'DUF167 domain-containing protein YggU',
  3096383,
  3096673,
  1,
  'b2953',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2953'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rdgB',
  'dITP/XTP pyrophosphatase',
  3096681,
  3097274,
  1,
  'b2954',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2954'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemW',
  'heme chaperone HemW',
  3097267,
  3098403,
  1,
  'b2955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2955'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggM',
  'DUF1202 domain-containing protein YggM',
  3098558,
  3099565,
  -1,
  'b2956',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2956'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ansB',
  'L-asparaginase 2',
  3099682,
  3100728,
  -1,
  'b2957',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2957'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggN',
  'DUF2884 domain-containing protein YggN',
  3100904,
  3101623,
  -1,
  'b2958',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2958'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggL',
  'putative ribosome assembly factor YggL',
  3101807,
  3102133,
  -1,
  'b2959',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2959'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trmB',
  'tRNA m(7)G46 methyltransferase',
  3102133,
  3102852,
  -1,
  'b2960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2960'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mutY',
  'adenine DNA glycosylase',
  3103013,
  3104065,
  1,
  'b2961',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2961'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yggX',
  'putative Fe(2(+))-trafficking protein',
  3104093,
  3104368,
  1,
  'b2962',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2962'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mltC',
  'membrane-bound lytic murein transglycosylase C',
  3104433,
  3105512,
  1,
  'b2963',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2963'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nupG',
  'nucleoside:H(+) symporter NupG',
  3105714,
  3106970,
  1,
  'b2964',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2964'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'speC',
  'constitutive ornithine decarboxylase',
  3107020,
  3109155,
  -1,
  'b2965',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2965'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgH',
  'protein YqgH',
  3109317,
  3109400,
  -1,
  'b4785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4785'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqgA',
  'DUF554 domain-containing protein YqgA',
  3109553,
  3110260,
  1,
  'b2966',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2966'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheV',
  '—',
  3110366,
  3110441,
  1,
  'b2967',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2967'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghD',
  'putative type II secretion system M-type proteinYghD',
  3110590,
  3111126,
  -1,
  'b2968',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2968'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghE',
  'putative type II secretion system L-type proteinYghE',
  3111128,
  3111988,
  -1,
  'b2969',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2969'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhJ',
  'protein YqhJ',
  3111266,
  3111325,
  1,
  'b4786',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4786'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghF',
  'putative type II secretion system C-type proteinYghF',
  3112054,
  3113049,
  -1,
  'b2970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2970'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghG',
  'outer membrane pilotin',
  3113067,
  3113477,
  -1,
  'b2971',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2971'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pppA',
  'prepilin peptidase',
  3113543,
  3114352,
  -1,
  'b2972',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2972'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghJ',
  'putative mayloidogenic protein',
  3114550,
  3119112,
  -1,
  'b4466',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4466'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcA',
  'glycolate/lactate:H(+) symporter GlcA',
  3119597,
  3121279,
  -1,
  'b2975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2975'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcB',
  'malate synthase G',
  3121634,
  3123805,
  -1,
  'b2976',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2976'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcG',
  'putative heme-binding protein GlcG',
  3123827,
  3124231,
  -1,
  'b2977',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2977'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcF',
  'glycolate dehydrogenase, [Fe-S] subunit',
  3124236,
  3125459,
  -1,
  'b4467',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4467'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcE',
  'glycolate dehydrogenase, predicted FAD-bindingsubunit',
  3125470,
  3126522,
  -1,
  'b4468',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4468'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcD',
  'glycolate dehydrogenase, predicted FAD-linkedsubunit',
  3126522,
  3128021,
  -1,
  'b2979',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2979'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glcC',
  'DNA-binding transcriptional dual regulator GlcC',
  3128272,
  3129036,
  1,
  'b2980',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2980'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghO',
  'putative DNA-binding transcriptional regulatorYghO',
  3129043,
  3130215,
  -1,
  'b2981',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2981'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH9',
  'IS5 transposase and trans-activator',
  3130214,
  3131194,
  1,
  'b2982',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2982'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghQ',
  'putative transport protein YghQ',
  3131341,
  3132408,
  -1,
  'b2983',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2983'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghR',
  'putative ATP-binding protein YghR',
  3132454,
  3133212,
  -1,
  'b2984',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2984'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghS',
  'putative ATP-binding protein YghS',
  3133244,
  3133957,
  -1,
  'b2985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2985'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghT',
  'putative ATP-binding protein YghT',
  3134131,
  3134823,
  1,
  'b2986',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2986'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pitB',
  'metal phosphate:H(+) symporter PitB',
  3134872,
  3136371,
  -1,
  'b2987',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2987'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gss',
  'fused glutathionylspermidineamidase/glutathionylspermidine synthetase',
  3136663,
  3138522,
  -1,
  'b2988',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2988'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghU',
  'disulfide reductase/organic hydroperoxidereductase',
  3138727,
  3139593,
  1,
  'b2989',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2989'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybG',
  'hydrogenase maturation factor HybG',
  3139716,
  3139964,
  -1,
  'b2990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2990'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybF',
  'hydrogenase maturation protein HybF',
  3139977,
  3140318,
  -1,
  'b2991',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2991'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybE',
  'hydrogenase 2-specific chaperone',
  3140311,
  3140799,
  -1,
  'b2992',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2992'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybD',
  'hydrogenase 2 maturation protease',
  3140792,
  3141286,
  -1,
  'b2993',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2993'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybC',
  'hydrogenase 2 large subunit',
  3141286,
  3142989,
  -1,
  'b2994',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2994'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybB',
  'hydrogenase 2 membrane subunit',
  3142986,
  3144164,
  -1,
  'b2995',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2995'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybA',
  'hydrogenase 2 [Fe-S] protein',
  3144154,
  3145140,
  -1,
  'b2996',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2996'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hybO',
  'hydrogenase 2 small subunit',
  3145143,
  3146261,
  -1,
  'b2997',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2997'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghW',
  'DUF2623 domain-containing protein YghW',
  3146450,
  3146737,
  -1,
  'b2998',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2998'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghX',
  '—',
  3146856,
  3147691,
  -1,
  'b4658',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4658'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhI',
  'protein YqhI',
  3147597,
  3147740,
  -1,
  'b4755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4755'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gpr',
  'L-glyceraldehyde 3-phosphate reductase',
  3147897,
  3148937,
  1,
  'b3001',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3001'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhA',
  'UPF0114 family protein YqhA',
  3148977,
  3149471,
  -1,
  'b3002',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3002'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghA',
  'NADP(+)-dependent aldehyde reductase',
  3149662,
  3150546,
  1,
  'b3003',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3003'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'exbD',
  'Ton complex subunit ExbD',
  3150818,
  3151243,
  -1,
  'b3005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3005'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'exbB',
  'Ton complex subunit ExbB',
  3151250,
  3151984,
  -1,
  'b3006',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3006'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metC',
  'cystathionine beta-lyase/L-cysteinedesulfhydrase/alanine racemase',
  3152236,
  3153423,
  1,
  'b3008',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3008'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yghB',
  'DedA family protein YghB',
  3153563,
  3154222,
  1,
  'b3009',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3009'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhC',
  'DNA-binding transcriptional activator YqhC',
  3154262,
  3155218,
  -1,
  'b3010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3010'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhD',
  'NADPH-dependent aldehyde reductase YqhD',
  3155355,
  3156518,
  1,
  'b3011',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3011'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dkgA',
  'methylglyoxal reductase DkgA',
  3156623,
  3157450,
  1,
  'b3012',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3012'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhG',
  'DUF3828 domain-containing protein YqhG',
  3157650,
  3158576,
  1,
  'b3013',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3013'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqhH',
  'lipoprotein YqhH',
  3158627,
  3158884,
  1,
  'b3014',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3014'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiQ',
  'radical SAM superfamily protein YgiQ',
  3158927,
  3161146,
  -1,
  'b4469',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4469'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftsP',
  'cell division protein FtsP',
  3161257,
  3162669,
  -1,
  'b3017',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3017'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'plsC',
  '1-acylglycerol-3-phosphate O-acyltransferasePlsC',
  3162744,
  3163481,
  -1,
  'b3018',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3018'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'parC',
  'DNA topoisomerase IV subunit A',
  3163715,
  3165973,
  -1,
  'b3019',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3019'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiS',
  'putative deoxycholate binding periplasmicprotein',
  3166111,
  3167718,
  -1,
  'b3020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3020'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mqsA',
  'antitoxin of the MqsRA TA system/DNA-bindingtranscriptional repressor MqsA',
  3167851,
  3168246,
  -1,
  'b3021',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3021'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mqsR',
  'mRNA interferase toxin MqsR',
  3168248,
  3168544,
  -1,
  'b3022',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3022'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiV',
  'DNA-binding transcriptional repressor YgiV',
  3168749,
  3169231,
  -1,
  'b3023',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3023'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiW',
  'BOF family protein YgiW',
  3169284,
  3169676,
  -1,
  'b3024',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3024'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'qseB',
  'DNA-binding transcriptional activator QseB',
  3169828,
  3170487,
  1,
  'b3025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3025'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'qseC',
  'sensor histidine kinase QseC',
  3170484,
  3171833,
  1,
  'b3026',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3026'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiZ',
  'DUF2645 domain-containing inner membrane proteinYgiZ',
  3171879,
  3172211,
  -1,
  'b3027',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3027'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdaB',
  'NADPH:quinone oxidoreductase MdaB',
  3172530,
  3173111,
  1,
  'b3028',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3028'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiN',
  'putative quinol monooxygenase YgiN',
  3173142,
  3173456,
  1,
  'b3029',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3029'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'parE',
  'DNA topoisomerase IV subunit B',
  3173504,
  3175396,
  -1,
  'b3030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3030'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiA',
  'esterase YqiA',
  3175425,
  3176006,
  -1,
  'b3031',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3031'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpdA',
  'cAMP phosphodiesterase',
  3176006,
  3176833,
  -1,
  'b3032',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3032'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiB',
  'DUF1249 domain-containing protein YqiB',
  3176858,
  3177280,
  -1,
  'b3033',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3033'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudF',
  'ADP-sugar pyrophosphatase',
  3177281,
  3177910,
  -1,
  'b3034',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3034'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tolC',
  'outer membrane channel TolC',
  3178115,
  3179596,
  1,
  'b3035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3035'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiB',
  'DUF1190 domain-containing protein YgiB',
  3179744,
  3180415,
  1,
  'b3037',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3037'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiC',
  'peptide--spermidine ligase YgiC',
  3180421,
  3181581,
  1,
  'b3038',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3038'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiD',
  '4,5-DOPA dioxygenase extradiol',
  3181619,
  3182434,
  -1,
  'b3039',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3039'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zupT',
  'divalent metal ion transporter ZupT',
  3182550,
  3183323,
  1,
  'b3040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3040'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiD',
  'protein YqiD',
  3183381,
  3183551,
  -1,
  'b4756',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4756'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ribB',
  '3,4-dihydroxy-2-butanone-4-phosphate synthase',
  3183813,
  3184466,
  -1,
  'b3041',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3041'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiK',
  'ubiquinone biosynthesis accessory factor UbiK',
  3184840,
  3185130,
  1,
  'b3042',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3042'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiL',
  'putative fimbrial protein YgiL',
  3185414,
  3185965,
  1,
  'b3043',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3043'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiG',
  'putative outer membrane usher protein YqiG',
  3186025,
  3189865,
  1,
  'b3046',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3046'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insC5',
  'IS2 insertion element repressor InsA',
  3186187,
  3186552,
  1,
  'b3044',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3044'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insD5',
  'IS2 insertion element protein InsB',
  3186510,
  3187415,
  1,
  'b3045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3045'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiH',
  'putative fimbrial chaperone YqiH',
  3189881,
  3190630,
  1,
  'b3047',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3047'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiI',
  'putative fimbrial protein YqiI',
  3190632,
  3191696,
  1,
  'b3048',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3048'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glgS',
  'surface composition regulator',
  3191739,
  3191939,
  -1,
  'b3049',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3049'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiJ',
  'DUF1449 domain-containing inner membrane proteinYqiJ',
  3192208,
  3192837,
  1,
  'b3050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3050'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiK',
  'flotillin family inner membrane protein YqiK',
  3192864,
  3194525,
  1,
  'b3051',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3051'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sibD',
  '—',
  3194721,
  3194865,
  -1,
  'b4447',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4447'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibsD',
  'putative toxic peptide IbsD',
  3194766,
  3194825,
  1,
  'b4664',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4664'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sibE',
  '—',
  3195097,
  3195240,
  -1,
  'b4611',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4611'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibsE',
  'toxic peptide IbsE',
  3195141,
  3195200,
  1,
  'b4666',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4666'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hldE',
  'fused heptose 7-phosphate kinase/heptose1-phosphate adenyltransferase',
  3195320,
  3196753,
  -1,
  'b3052',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3052'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glnE',
  'fused glutamine synthetase deadenylase/glutaminesynthetase adenylyltransferase',
  3196801,
  3199641,
  -1,
  'b3053',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3053'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiF',
  'inorganic triphosphatase',
  3199664,
  3200965,
  -1,
  'b3054',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3054'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygiM',
  'putative signal transduction protein (SH3domain)',
  3201207,
  3201827,
  1,
  'b3055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3055'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cca',
  'fused CCA tRNAnucleotidyltransferase/phosphohydrolase',
  3201891,
  3203129,
  1,
  'b3056',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3056'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bacA',
  'undecaprenyl pyrophosphate phosphatase',
  3203310,
  3204131,
  -1,
  'b3057',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3057'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'folB',
  'dihydroneopterin aldolase',
  3204221,
  3204589,
  -1,
  'b3058',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3058'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'plsY',
  'putative glycerol-3-phosphate acyltransferase',
  3204694,
  3205311,
  1,
  'b3059',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3059'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ttdR',
  'DNA-binding transcriptional activator Dan',
  3205324,
  3206256,
  -1,
  'b3060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3060'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ttdA',
  'L(+)-tartrate dehydratase subunit alpha',
  3206463,
  3207374,
  1,
  'b3061',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3061'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ttdB',
  'L(+)-tartrate dehydratase subunit beta',
  3207371,
  3207976,
  1,
  'b3062',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3062'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ttdT',
  'L-tartrate:succinate antiporter',
  3208024,
  3209487,
  1,
  'b3063',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3063'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsaD',
  'N(6)-L-threonylcarbamoyladenine synthase, TsaDsubunit',
  3209530,
  3210543,
  -1,
  'b3064',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3064'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpsU',
  '30S ribosomal subunit protein S21',
  3210781,
  3210996,
  1,
  'b3065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3065'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dnaG',
  'DNA primase',
  3211107,
  3212852,
  1,
  'b3066',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3066'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpoD',
  'RNA polymerase sigma factor RpoD',
  3213047,
  3214888,
  1,
  'b3067',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3067'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mug',
  'stationary phase mismatch/uracil DNAglycosylase',
  3214967,
  3215473,
  -1,
  'b3068',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3068'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ileX',
  '—',
  3215598,
  3215673,
  1,
  'b3069',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3069'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nfeF',
  'NADPH-dependent Fe(3(+))-chelate reductase',
  3215727,
  3216491,
  -1,
  'b3070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3070'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nfeR',
  'DNA-binding transcriptional repressor NfeR',
  3216779,
  3217402,
  1,
  'b3071',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3071'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aer',
  'aerotaxis receptor',
  3217556,
  3219076,
  -1,
  'b3072',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3072'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'patA',
  'putrescine aminotransferase',
  3219494,
  3220873,
  1,
  'b3073',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3073'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjH',
  'putative tRNA-binding protein YgjH',
  3220915,
  3221247,
  -1,
  'b3074',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3074'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ebgR',
  'DNA-binding transcriptional repressor EbgR',
  3221466,
  3222449,
  1,
  'b3075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3075'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ebgA',
  'evolved beta-D-galactosidase subunit alpha',
  3222633,
  3225725,
  1,
  'b3076',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3076'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ebgC',
  'DUF386 domain-containing evolvedbeta-D-galactosidase subunit beta',
  3225722,
  3226171,
  1,
  'b3077',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3077'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjI',
  'putative transporter YgjI',
  3226234,
  3227667,
  1,
  'b3078',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3078'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjJ',
  'protein YgjJ',
  3227801,
  3228871,
  1,
  'b3079',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3079'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjK',
  'glycoside hydrolase',
  3228888,
  3231239,
  1,
  'b3080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3080'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadH',
  '2,4-dienoyl-CoA reductase',
  3231665,
  3233683,
  1,
  'b3081',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3081'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'higA',
  'antitoxin/DNA-binding transcriptional repressorHigA',
  3233728,
  3234144,
  -1,
  'b3082',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3082'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'higB',
  'ribosome-dependent mRNA interferase toxin HigB',
  3234141,
  3234455,
  -1,
  'b3083',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3083'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmG',
  '23S rRNA m(2)G1835 methyltransferase',
  3234739,
  3235875,
  -1,
  'b3084',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3084'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjP',
  'putative metal-dependent hydrolase',
  3235960,
  3236463,
  1,
  'b3085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3085'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjQ',
  'DUF218 domain-containing protein YgjQ',
  3236540,
  3237232,
  1,
  'b3086',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3086'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjR',
  'putative oxidoreductase YgjR',
  3237311,
  3238297,
  1,
  'b3087',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3087'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alx',
  'Mn(2(+)) exporter Alx',
  3238580,
  3239545,
  1,
  'b3088',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3088'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sstT',
  'serine/threonine:Na(+) symporter',
  3239944,
  3241188,
  1,
  'b3089',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3089'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ygjV',
  'inner membrane protein YgjV',
  3241193,
  3241744,
  -1,
  'b3090',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3090'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uxaA',
  'D-altronate dehydratase',
  3241827,
  3243314,
  -1,
  'b3091',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3091'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uxaC',
  'D-glucoronate/D-galacturonate isomerase',
  3243329,
  3244741,
  -1,
  'b3092',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3092'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'exuT',
  'hexuronate transporter',
  3245224,
  3246522,
  1,
  'b3093',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3093'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'exuR',
  'DNA-binding transcriptional repressor ExuR',
  3246652,
  3247428,
  1,
  'b3094',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3094'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqiM',
  'protein YqiM',
  3247668,
  3247751,
  1,
  'b4787',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4787'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjA',
  'DedA family protein YqjA',
  3247773,
  3248435,
  1,
  'b3095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3095'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mzrA',
  'modulator protein MzrA',
  3248439,
  3248822,
  1,
  'b3096',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3096'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjC',
  'DUF1090 domain-containing protein YqjC',
  3248969,
  3249337,
  1,
  'b3097',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3097'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjD',
  'ribosome- and membrane-associated DUF883domain-containing protein YqjD',
  3249375,
  3249680,
  1,
  'b3098',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3098'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjE',
  'inner membrane protein YqjE',
  3249683,
  3250087,
  1,
  'b3099',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3099'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjK',
  'PF13997 family protein YqjK',
  3250077,
  3250376,
  1,
  'b3100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3100'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjF',
  'DoxX family protein',
  3250562,
  3250954,
  1,
  'b3101',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3101'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yqjG',
  'glutathionyl-hydroquinone reductase YqjG',
  3251024,
  3252010,
  1,
  'b3102',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3102'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaH',
  'putative inner membrane protein',
  3252304,
  3252669,
  1,
  'b3103',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3103'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaI',
  'putative inner membrane protein',
  3252911,
  3253267,
  1,
  'b3104',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3104'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaJ',
  'DNA-binding transcriptional activator YhaJ',
  3253318,
  3254214,
  -1,
  'b3105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3105'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaK',
  'bicupin-related protein',
  3254319,
  3255020,
  1,
  'b3106',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3106'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaL',
  'uncharacterized protein YhaL',
  3255043,
  3255207,
  1,
  'b3107',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3107'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cyuA',
  'L-cysteine desulfidase',
  3255341,
  3256651,
  -1,
  'b4470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4470'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cyuP',
  'L-cysteine importer',
  3256679,
  3258010,
  -1,
  'b3110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3110'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcG',
  'L-serine deaminase III',
  3258285,
  3259649,
  -1,
  'b4471',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4471'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcF',
  'putative enamine/imine deaminase',
  3259721,
  3260110,
  -1,
  'b3113',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3113'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcE',
  '2-oxobutanoate formate-lyase/pyruvateformate-lyase 4',
  3260124,
  3262418,
  -1,
  'b3114',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3114'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcD',
  'propionate kinase',
  3262452,
  3263660,
  -1,
  'b3115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3115'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcC',
  'threonine/serine:H(+) symporter TdcC',
  3263686,
  3265017,
  -1,
  'b3116',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3116'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcB',
  'catabolic threonine dehydratase',
  3265039,
  3266028,
  -1,
  'b3117',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3117'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcA',
  'DNA-binding transcriptional activator TdcA',
  3266127,
  3267065,
  -1,
  'b3118',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3118'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tdcR',
  'DNA-binding transcriptional activator TdcR',
  3267380,
  3267598,
  1,
  'b3119',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3119'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaB',
  'protein YhaB',
  3267854,
  3268393,
  1,
  'b3120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3120'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaC',
  'uncharacterized protein YhaC',
  3268415,
  3269602,
  1,
  'b3121',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3121'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnpB',
  '—',
  3270216,
  3270592,
  -1,
  'b3123',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3123'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'garK',
  'glycerate 2-kinase 1',
  3270625,
  3271770,
  -1,
  'b3124',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3124'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'garR',
  'tartronate semialdehyde reductase',
  3271867,
  3272751,
  -1,
  'b3125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3125'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'garL',
  'alpha-dehydro-beta-deoxy-D-glucarate aldolase',
  3272787,
  3273557,
  -1,
  'b3126',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3126'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'garP',
  'galactarate/D-glucarate transporter GarP',
  3273573,
  3274907,
  -1,
  'b3127',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3127'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'garD',
  'galactarate dehydratase',
  3275282,
  3276853,
  1,
  'b3128',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3128'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prlF',
  'antitoxin PrlF',
  3277002,
  3277337,
  1,
  'b3129',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3129'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yhaV',
  'ribosome-dependent mRNA interferase toxin YhaV',
  3277337,
  3277801,
  1,
  'b3130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3130'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaR',
  'DNA-binding transcriptional repressor AgaR',
  3277856,
  3278665,
  -1,
  'b3131',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3131'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kbaZ',
  'putative tagatose-1,6-bisphosphate aldolase 1chaperone',
  3278914,
  3280194,
  1,
  'b3132',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3132'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaV',
  'N-acetyl-D-galactosamine specific PTS enzyme IIBcomponent',
  3280217,
  3280690,
  1,
  'b3133',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3133'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaW',
  '—',
  3280701,
  3281102,
  1,
  'b3134',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3134'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaA',
  '—',
  3281122,
  3281625,
  1,
  'b3135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3135'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaS',
  'putative galactosamine-6-phosphatedeaminase/isomerase',
  3281976,
  3283130,
  1,
  'b3136',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3136'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kbaY',
  'tagatose-1,6-bisphosphate aldolase 1',
  3283143,
  3284003,
  1,
  'b3137',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3137'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaB',
  'cryptic galactosamine-specific PTS enzyme IIBcomponent',
  3284170,
  3284646,
  1,
  'b3138',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3138'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaC',
  'cryptic galactosamine-specific PTS enzyme IICcomponent',
  3284685,
  3285488,
  1,
  'b3139',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3139'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaD',
  'cryptic galactosamine-specific PTS enzyme IIDcomponent',
  3285478,
  3286269,
  1,
  'b3140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3140'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'agaI',
  'putative deaminase AgaI',
  3286270,
  3287025,
  1,
  'b3141',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3141'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraH',
  'putative fimbrial protein YraH',
  3287426,
  3288010,
  1,
  'b3142',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3142'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraI',
  'putative fimbrial chaperone YraI',
  3288090,
  3288785,
  1,
  'b3143',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3143'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraJ',
  'putative fimbrial usher protein YraJ',
  3288814,
  3291330,
  1,
  'b3144',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3144'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraK',
  'putative fimbrial adhesin YraK',
  3291341,
  3292432,
  1,
  'b3145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3145'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmI',
  '16S rRNA 2''-O-ribose C1402 methyltransferase',
  3292475,
  3293335,
  -1,
  'b3146',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3146'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lpoA',
  'outer membrane lipoprotein - activator of MrcAactivity',
  3293400,
  3295436,
  1,
  'b3147',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3147'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yraN',
  'PF02021 family protein YraN',
  3295394,
  3295789,
  1,
  'b3148',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3148'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'diaA',
  'DnaA initiator-associating protein DiaA',
  3295809,
  3296399,
  1,
  'b3149',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b3149'
);
COMMIT;