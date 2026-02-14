PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciB',
  'inner membrane protein YciB',
  1312351,
  1312890,
  -1,
  'b1254',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1254'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciC',
  'putative inner membrane protein',
  1312920,
  1313663,
  -1,
  'b1255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1255'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ompW',
  'outer membrane protein W',
  1314020,
  1314658,
  1,
  'b1256',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1256'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciE',
  'DUF892 domain-containing protein YciE',
  1314718,
  1315224,
  -1,
  'b1257',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1257'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciF',
  'DUF892 domain-containing protein YciF',
  1315270,
  1315770,
  -1,
  'b1258',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1258'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciG',
  'stress-induced bacterial acidophilic repeatmotifs-containing protein YciG',
  1315856,
  1316035,
  -1,
  'b1259',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1259'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpA',
  'tryptophan synthase subunit alpha',
  1316416,
  1317222,
  -1,
  'b1260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1260'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpB',
  'tryptophan synthase subunit beta',
  1317222,
  1318415,
  -1,
  'b1261',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1261'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpC',
  'fused indole-3-glycerol phosphatesynthase/phosphoribosylanthranilate isomerase',
  1318427,
  1319788,
  -1,
  'b1262',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1262'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpD',
  'anthranilate synthase subunit TrpD',
  1319789,
  1321384,
  -1,
  'b1263',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1263'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpE',
  'anthranilate synthase subunit TrpE',
  1321384,
  1322946,
  -1,
  'b1264',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1264'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trpL',
  'trp operon leader peptide',
  1323038,
  1323082,
  -1,
  'b1265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1265'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnm',
  'RNase AM',
  1323220,
  1324101,
  1,
  'b1266',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1266'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciO',
  'putative RNA-binding protein YciO',
  1324098,
  1324718,
  1,
  'b1267',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1267'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciQ',
  'DUF2207 domain-containing protein YciQ',
  1324746,
  1326641,
  1,
  'b1268',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1268'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rluB',
  '23S rRNA pseudouridine(2605) synthase',
  1326852,
  1327727,
  1,
  'b1269',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1269'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btuR',
  'cobinamide/cobalamin adenosyltransferase',
  1327767,
  1328357,
  -1,
  'b1270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1270'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciK',
  'putative oxidoreductase',
  1328354,
  1329112,
  -1,
  'b1271',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1271'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sohB',
  'S49 peptidase family protein',
  1329332,
  1330381,
  1,
  'b1272',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1272'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciN',
  'protein YciN',
  1330417,
  1330668,
  -1,
  'b1273',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1273'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'topA',
  'DNA topoisomerase I',
  1331048,
  1333645,
  1,
  'b1274',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1274'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysB',
  'DNA-binding transcriptional dual regulator CysB',
  1333855,
  1334829,
  1,
  'b1275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1275'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymiA',
  'uncharacterized protein YmiA',
  1335148,
  1335288,
  1,
  'b4522',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4522'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciX',
  'uncharacterized protein YciX',
  1335291,
  1335458,
  1,
  'b4523',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4523'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymiC',
  'protein YmiC',
  1335572,
  1335667,
  1,
  'b4741',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4741'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acnA',
  'aconitate hydratase 1',
  1335831,
  1338506,
  1,
  'b1276',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1276'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ribA',
  'GTP cyclohydrolase 2',
  1338570,
  1339160,
  -1,
  'b1277',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1277'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pgpB',
  'phosphatidylglycerophosphatase B',
  1339330,
  1340094,
  1,
  'b1278',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1278'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lapA',
  'lipopolysaccharide assembly protein A',
  1340243,
  1340551,
  1,
  'b1279',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1279'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lapB',
  'lipopolysaccharide assembly protein B',
  1340558,
  1341727,
  1,
  'b1280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1280'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrF',
  'orotidine-5''-phosphate decarboxylase',
  1341921,
  1342658,
  1,
  'b1281',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1281'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciH',
  'putative translation factor',
  1342658,
  1342984,
  1,
  'b1282',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1282'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'osmB',
  'osmotically-inducible lipoprotein OsmB',
  1343110,
  1343328,
  -1,
  'b1283',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1283'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciT',
  'DNA-binding transcriptional dual regulator YciT',
  1343597,
  1344346,
  -1,
  'b1284',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1284'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciZ',
  'UPF0509 family protein YciZ',
  1344436,
  1344609,
  -1,
  'b4596',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4596'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymiD',
  'protein YmiD',
  1344647,
  1344775,
  1,
  'b4772',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4772'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeR',
  'cyclic di-GMP phosphodiesterase PdeR',
  1344757,
  1346742,
  -1,
  'b1285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1285'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymiB',
  'putative protein YmiB',
  1346796,
  1346900,
  1,
  'b4672',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4672'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnb',
  'RNase II',
  1346978,
  1348912,
  -1,
  'b1286',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1286'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yciW',
  'putative peroxidase YciW',
  1348980,
  1350107,
  -1,
  'b1287',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1287'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fabI',
  'enoyl-[acyl-carrier-protein] reductase',
  1350251,
  1351039,
  -1,
  'b1288',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1288'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjD',
  'DUF559 domain-containing protein YcjD',
  1351407,
  1351760,
  -1,
  'b1289',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1289'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sapF',
  'putrescine ABC exporter ATP binding proteinSapF',
  1351828,
  1352634,
  -1,
  'b1290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1290'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sapD',
  'putrescine ABC exporter ATP binding proteinSapD',
  1352636,
  1353628,
  -1,
  'b1291',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1291'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sapC',
  'putrescine ABC exporter membrane protein SapC',
  1353628,
  1354518,
  -1,
  'b1292',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1292'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sapB',
  'putrescine ABC exporter membrane subunit SapB',
  1354505,
  1355470,
  -1,
  'b1293',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1293'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sapA',
  'putative periplasmic binding protein SapA',
  1355467,
  1357110,
  -1,
  'b1294',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1294'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymjA',
  'DUF2543 domain-containing protein YmjA',
  1357423,
  1357668,
  -1,
  'b1295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1295'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuP',
  'putrescine:H(+) symporter PuuP',
  1357802,
  1359187,
  -1,
  'b1296',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1296'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymjE',
  'protein YmjE',
  1359177,
  1359341,
  -1,
  'b4742',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4742'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuA',
  'glutamate-putrescine ligase',
  1359490,
  1360908,
  -1,
  'b1297',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1297'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuD',
  'gamma-glutamyl-gamma-aminobutyrate hydrolase',
  1361120,
  1361884,
  1,
  'b1298',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1298'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuR',
  'DNA-binding transcriptional repressor PuuR',
  1361911,
  1362468,
  1,
  'b1299',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1299'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuC',
  'gamma-glutamyl-gamma-aminobutyraldehydedehydrogenase',
  1362743,
  1364230,
  1,
  'b1300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1300'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuB',
  'gamma-glutamylputrescine oxidase',
  1364232,
  1365512,
  1,
  'b1301',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1301'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'puuE',
  '4-aminobutyrate aminotransferase PuuE',
  1365550,
  1366815,
  1,
  'b1302',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1302'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspF',
  'DNA-binding transcriptional dual regulator PspF',
  1366935,
  1367912,
  -1,
  'b1303',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1303'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspA',
  'phage shock protein A',
  1368079,
  1368747,
  1,
  'b1304',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1304'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspB',
  'phage shock protein B',
  1368801,
  1369025,
  1,
  'b1305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1305'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspC',
  'phage shock protein C',
  1369025,
  1369384,
  1,
  'b1306',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1306'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspD',
  'phage shock protein D',
  1369393,
  1369614,
  1,
  'b1307',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1307'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pspE',
  'thiosulfate sulfurtransferase PspE',
  1369689,
  1370003,
  1,
  'b1308',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1308'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjM',
  'glucosylglycerate phosphorylase',
  1370216,
  1371895,
  1,
  'b1309',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1309'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjN',
  'putative ABC transporter periplasmic bindingprotein YcjN',
  1371909,
  1373201,
  1,
  'b1310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1310'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjO',
  'putative ABC transporter membrane subunit YcjO',
  1373222,
  1374103,
  1,
  'b1311',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1311'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjP',
  'putative ABC transporter membrane subunit YcjP',
  1374090,
  1374932,
  1,
  'b1312',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1312'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjQ',
  'D-guloside 3-dehydrogenase',
  1374963,
  1376015,
  1,
  'b1313',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1313'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjR',
  '3-dehydro-D-guloside 4-epimerase',
  1376034,
  1376822,
  1,
  'b1314',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1314'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjS',
  'D-glucoside 3-dehydrogenase',
  1376832,
  1377887,
  1,
  'b1315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1315'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjT',
  'kojibiose phosphorylase',
  1377884,
  1380151,
  1,
  'b1316',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1316'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjU',
  'beta-phosphoglucomutase',
  1380148,
  1380807,
  1,
  'b1317',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1317'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjV',
  '—',
  1380821,
  1381789,
  1,
  'b1318',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1318'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymjB',
  '—',
  1381789,
  1381902,
  1,
  'b4524',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4524'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ompG',
  'outer membrane porin G',
  1381947,
  1382852,
  1,
  'b1319',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1319'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjW',
  'DNA-binding transcriptional repressor YcjW',
  1382963,
  1383961,
  -1,
  'b1320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1320'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjX',
  'DUF463 domain-containing protein YcjX',
  1384117,
  1385514,
  1,
  'b1321',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1321'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjF',
  'DUF697 domain-containing inner membrane proteinYcjF',
  1385511,
  1386572,
  1,
  'b1322',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1322'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tyrR',
  'DNA-binding transcriptional dual regulator TyrR',
  1386720,
  1388261,
  1,
  'b1323',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1323'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tpx',
  'lipid hydroperoxide peroxidase',
  1388305,
  1388811,
  -1,
  'b1324',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1324'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjG',
  'L-Ala-D/L-Glu epimerase',
  1388930,
  1389895,
  1,
  'b1325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1325'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mpaA',
  'murein tripeptide amidase A',
  1389870,
  1390598,
  -1,
  'b1326',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1326'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymjC',
  'putative uncharacterized protein YmjC',
  1390680,
  1390862,
  -1,
  'b4525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4525'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ymjD',
  'uncharacterized protein YmjD',
  1390868,
  1390933,
  -1,
  'b4673',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4673'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ycjY',
  'putative hydrolase YcjY',
  1390933,
  1391853,
  -1,
  'b1327',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1327'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pgrR',
  'DNA-binding transcriptional repressor PgrR',
  1391991,
  1392890,
  1,
  'b1328',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1328'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mppA',
  'murein tripeptide ABC transporter periplasmicbinding protein',
  1393227,
  1394840,
  1,
  'b1329',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1329'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaI',
  'small conductance mechanosensitive channel YnaI',
  1394891,
  1395922,
  -1,
  'b1330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1330'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH4',
  'IS5 transposase and trans-activator',
  1396112,
  1397092,
  1,
  'b1331',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1331'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaJ',
  'DUF2534 domain-containing protein YnaJ',
  1397365,
  1397622,
  1,
  'b1332',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1332'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uspE',
  'universal stress protein E',
  1397672,
  1398622,
  -1,
  'b1333',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1333'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fnr',
  'DNA-binding transcriptional dual regulator FNR',
  1398774,
  1399526,
  -1,
  'b1334',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1334'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ogt',
  'methylated-DNA--[protein]-cysteineS-methyltransferase',
  1399721,
  1400236,
  -1,
  'b1335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1335'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'abgT',
  'p-aminobenzoyl glutamate:H(+) symporter',
  1400247,
  1401773,
  -1,
  'b1336',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1336'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'abgB',
  'p-aminobenzoyl-glutamate hydrolase subunit B',
  1401810,
  1403255,
  -1,
  'b1337',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1337'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'abgA',
  'p-aminobenzoyl-glutamate hydrolase subunit A',
  1403255,
  1404565,
  -1,
  'b1338',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1338'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'abgR',
  'putative LysR-type DNA-binding transcriptionalregulator AbgR',
  1404741,
  1405649,
  1,
  'b1339',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1339'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mcaS',
  '—',
  1405658,
  1405751,
  -1,
  'b4426',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4426'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'smrA',
  'DNA endonuclease SmrA',
  1405979,
  1406542,
  1,
  'b1340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1340'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcM',
  'diguanylate cyclase DgcM',
  1406563,
  1407795,
  -1,
  'b1341',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1341'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaN',
  'protein YnaN',
  1407989,
  1408036,
  1,
  'b4773',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4773'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zntB',
  'Zn(2(+)):H(+) symporter',
  1408050,
  1409033,
  1,
  'b1342',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1342'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fnrS',
  '—',
  1409129,
  1409250,
  1,
  'b4699',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4699'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaL',
  'protein YnaL',
  1409308,
  1409481,
  1,
  'b4743',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4743'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dbpA',
  'ATP-dependent RNA helicase DbpA',
  1409511,
  1410884,
  1,
  'b1343',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1343'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ttcA',
  'tRNA cytosine(32) 2-sulfurtransferase TtcA',
  1411013,
  1411948,
  -1,
  'b1344',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1344'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intR',
  'putative integrase',
  1412000,
  1413235,
  -1,
  'b1345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1345'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xisR',
  'excisionase',
  1413237,
  1413452,
  -1,
  'b1346',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1346'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcbA',
  'double-strand break reduction protein',
  1413531,
  1413740,
  -1,
  'b1347',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1347'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ralA',
  '—',
  1413556,
  1413734,
  1,
  'b4714',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4714'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ralR',
  'endodeoxyribonuclease toxin RalR',
  1413733,
  1413927,
  -1,
  'b1348',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1348'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recT',
  'recombinase RecT',
  1413984,
  1414793,
  -1,
  'b1349',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1349'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'recE',
  'exonuclease VIII, ds DNA exonuclease, 5'' --> 3''specific',
  1414786,
  1417386,
  -1,
  'b1350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1350'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'racC',
  'protein RacC',
  1417488,
  1417763,
  -1,
  'b1351',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1351'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaE',
  'zinc-binding protein',
  1417838,
  1418008,
  -1,
  'b4526',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4526'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kilR',
  'inhibitor of FtsZ',
  1418008,
  1418229,
  -1,
  'b1352',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1352'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kilS',
  '—',
  1418405,
  1418502,
  -1,
  'b4833',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4833'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sieB',
  'phage superinfection exclusion protein',
  1418671,
  1419159,
  1,
  'b1353',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1353'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaF',
  'DUF1391 domain-containing protein YdaF',
  1419156,
  1419311,
  -1,
  'b4527',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4527'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaG',
  'uncharacterized protein YdaG',
  1419322,
  1419456,
  -1,
  'b1355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1355'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'racR',
  'DNA-binding transcriptional regulator RacR',
  1419765,
  1420241,
  -1,
  'b1356',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1356'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaS',
  'putative DNA-binding transcriptional regulatorYdaS',
  1420365,
  1420661,
  1,
  'b1357',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1357'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaT',
  'DNA binding transcriptional activator YdaT',
  1420684,
  1421106,
  1,
  'b1358',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1358'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaU',
  'DUF1376 domain-containing protein YdaU',
  1421119,
  1421976,
  1,
  'b1359',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1359'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaV',
  'putative ATP-binding protein YdaV',
  1421983,
  1422729,
  1,
  'b1360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1360'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaW',
  'putative uncharacterized protein YdaW',
  1422752,
  1423312,
  1,
  'b1361',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1361'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rzpR',
  '—',
  1423345,
  1423644,
  1,
  'b1362',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1362'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rzoR',
  'putative prophage outer membrane lipoproteinRzoR',
  1423400,
  1423585,
  1,
  'b4528',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4528'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trkG',
  'Na(+)-dependent K(+) transporter TrkG',
  1423782,
  1425239,
  1,
  'b1363',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1363'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaK',
  'ParB-like nuclease domain-containing proteinYnaK',
  1425377,
  1425640,
  1,
  'b1365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1365'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydaY',
  'putative uncharacterized protein YdaY',
  1425621,
  1425980,
  1,
  'b1366',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1366'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaA',
  'putative prophage tail length tape measuredomain-containing protein YnaA',
  1426454,
  1427482,
  1,
  'b1368',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1368'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lomR',
  'Rac prophage; protein LomR_1',
  1427389,
  1428984,
  1,
  'b4570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4570'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH5',
  'IS5 transposase and trans-activator',
  1427746,
  1428726,
  -1,
  'b1370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1370'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'stfR',
  'putative prophage side tail fiber protein StfR',
  1429049,
  1432411,
  1,
  'b1372',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1372'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tfaR',
  'putative tail fiber assembly protein TfaR',
  1432411,
  1432986,
  1,
  'b1373',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1373'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pinR',
  'putative site-specific recombinase',
  1433084,
  1433674,
  -1,
  'b1374',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1374'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaE',
  'uncharacterized protein YnaE',
  1433991,
  1434224,
  -1,
  'b1375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1375'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynaM',
  'protein YnaM',
  1434293,
  1434406,
  -1,
  'b4744',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4744'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ttcC',
  '—',
  1434958,
  1435008,
  -1,
  'b4638',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4638'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uspF',
  'universal stress protein F',
  1435185,
  1435619,
  -1,
  'b1376',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1376'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ompN',
  'outer membrane porin N',
  1435760,
  1436893,
  -1,
  'b1377',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1377'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'micC',
  '—',
  1437121,
  1437231,
  1,
  'b4427',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4427'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydbK',
  'putative pyruvate-flavodoxin oxidoreductase',
  1437260,
  1440784,
  -1,
  'b1378',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1378'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydbJ',
  'DUF333 domain-containing protein YdbJ',
  1441058,
  1441324,
  1,
  'b4529',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4529'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hslJ',
  'lipoprotein implicated in Novobiocin resistance',
  1441321,
  1441743,
  -1,
  'b1379',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1379'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ldhA',
  'D-lactate dehydrogenase',
  1441854,
  1442843,
  -1,
  'b1380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1380'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydbH',
  'putative intermembrane phospholipid transportprotein YdbH',
  1443051,
  1445690,
  1,
  'b1381',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1381'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynbE',
  'putative intermembrane phospholipid transportlipoprotein YnbE',
  1445687,
  1445872,
  1,
  'b1382',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1382'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydbL',
  'DUF1318 domain-containing protein YdbL',
  1445880,
  1446206,
  1,
  'b1383',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1383'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'feaR',
  'DNA-binding transcriptional activator FeaR',
  1446378,
  1447283,
  -1,
  'b1384',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1384'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'feaB',
  'phenylacetaldehyde dehydrogenase',
  1447519,
  1449018,
  1,
  'b1385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1385'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tynA',
  'copper-containing amine oxidase',
  1449076,
  1451349,
  -1,
  'b1386',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1386'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaZ',
  'fused 3-oxo-5,6-dehydrosuberyl-CoA semialdehydedehydrogenase and oxepin-CoA hydrolase',
  1451597,
  1453642,
  -1,
  'b1387',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1387'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaA',
  'phenylacetyl-CoA 1,2-epoxidase, monooxygenasesubunit',
  1453927,
  1454856,
  1,
  'b1388',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1388'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaB',
  'phenylacetyl-CoA 1,2-epoxidase subunit B',
  1454868,
  1455155,
  1,
  'b1389',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1389'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaC',
  'phenylacetyl-CoA 1,2-epoxidase, structuralsubunit',
  1455164,
  1455910,
  1,
  'b1390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1390'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaD',
  'phenylacetate degradation protein',
  1455925,
  1456422,
  1,
  'b1391',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1391'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaE',
  'phenylacetyl-CoA 1,2-epoxidase, reductasesubunit',
  1456430,
  1457500,
  1,
  'b1392',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1392'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaF',
  'putative 2,3-dehydroadipyl-CoA hydratase',
  1457497,
  1458264,
  1,
  'b1393',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1393'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaG',
  'putative ring 1,2-epoxyphenylacetyl-CoAisomerase (oxepin-CoA forming)',
  1458264,
  1459052,
  1,
  'b1394',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1394'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaH',
  '3-hydroxyadipyl-CoA dehydrogenase',
  1459054,
  1460481,
  1,
  'b1395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1395'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaI',
  'phenylacetyl-CoA thioesterase',
  1460471,
  1460893,
  1,
  'b1396',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1396'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaJ',
  'beta-ketoadipyl-CoA thiolase',
  1460893,
  1462098,
  1,
  'b1397',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1397'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaK',
  'phenylacetate-CoA ligase',
  1462125,
  1463438,
  1,
  'b1398',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1398'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaX',
  'DNA-binding transcriptional repressor PaaX',
  1463539,
  1464489,
  1,
  'b1399',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1399'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'paaY',
  '2-hydroxycyclohepta-1,4,6-triene-1-carboxyl-CoAthioesterase',
  1464471,
  1465061,
  1,
  'b1400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1400'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynbG',
  'uncharacterized protein YnbG',
  1465165,
  1465230,
  -1,
  'b4674',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4674'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydbA',
  'putative outer membrane protein, N-terminalfragment',
  1465392,
  1474013,
  1,
  'b4492',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4492'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insD2',
  'IS2 insertion element protein InsB',
  1467921,
  1468826,
  -1,
  'b1402',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1402'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insC2',
  'IS2 insertion element repressor InsA',
  1468784,
  1469149,
  -1,
  'b1403',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1403'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insI2',
  'IS30 transposase',
  1469358,
  1470509,
  1,
  'b1404',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1404'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdxI',
  'pyridoxal reductase',
  1474221,
  1475081,
  1,
  'b1406',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1406'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydbD',
  'DUF2773 domain-containing protein YdbD',
  1475144,
  1477450,
  1,
  'b1407',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1407'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynbA',
  'CDP-alcohol phosphatidyltransferasedomain-containing protein YnbA',
  1477621,
  1478226,
  1,
  'b1408',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1408'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynbB',
  'putative CDP-diglyceride synthase',
  1478226,
  1479122,
  1,
  'b1409',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1409'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynbC',
  'hydrolase/methyltransferase domain-containingprotein YnbC',
  1479138,
  1480895,
  1,
  'b1410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1410'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynbD',
  'phosphatase domain-containing protein YnbD',
  1480909,
  1482201,
  1,
  'b1411',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1411'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'azoR',
  'FMN dependent NADH:quinone oxidoreductase',
  1482255,
  1482860,
  -1,
  'b1412',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1412'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hrpA',
  'ATP-dependent 3''->5'' RNA helicase HrpA',
  1483061,
  1486963,
  1,
  'b1413',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1413'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcF',
  'DUF218 domain-containing protein YdcF',
  1487235,
  1488035,
  1,
  'b1414',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1414'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aldA',
  'aldehyde dehydrogenase A',
  1488232,
  1489671,
  1,
  'b1415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1415'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gapC',
  '—',
  1489713,
  1490713,
  -1,
  'b4493',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4493'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cybB',
  'superoxide oxidase',
  1490902,
  1491432,
  1,
  'b1418',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1418'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rydC',
  '—',
  1491442,
  1491506,
  -1,
  'b4597',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4597'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcA',
  'protein YdcA',
  1491677,
  1491850,
  1,
  'b1419',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1419'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncP',
  'protein YncP',
  1491876,
  1491944,
  1,
  'b4774',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4774'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hokB',
  'toxin HokB',
  1491922,
  1492071,
  -1,
  'b4428',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4428'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mokB',
  'putative regulatory protein MokB',
  1491962,
  1492129,
  -1,
  'b1420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1420'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sokB',
  '—',
  1492119,
  1492175,
  1,
  'b4429',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4429'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trg',
  'methyl-accepting chemotaxis protein Trg',
  1492470,
  1494110,
  1,
  'b1421',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1421'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcI',
  'DNA-binding transcriptional dual regulator YdcI',
  1494148,
  1495071,
  -1,
  'b1422',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1422'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcJ',
  'DUF1338 domain-containing protein YdcJ',
  1495288,
  1496631,
  1,
  'b1423',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1423'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'opgD',
  'glucans biosynthesis protein D',
  1496856,
  1498511,
  1,
  'b1424',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1424'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcH',
  'DUF465 domain-containing protein YdcH',
  1498651,
  1498875,
  1,
  'b1426',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1426'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rimL',
  'ribosomal-protein-L12-serineN-acetyltransferase',
  1498938,
  1499477,
  1,
  'b1427',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1427'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcK',
  'putative acyltransferase YdcK',
  1499469,
  1500449,
  -1,
  'b1428',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1428'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tehA',
  'tellurite resistance protein',
  1500573,
  1501565,
  1,
  'b1429',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1429'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tehB',
  'tellurite methyltransferase',
  1501562,
  1502155,
  1,
  'b1430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1430'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcL',
  'DUF3313 domain-containing lipoprotein YdcL',
  1502457,
  1503125,
  1,
  'b1431',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1431'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncK',
  '—',
  1503218,
  1503649,
  -1,
  'b4578',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4578'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insQ',
  'putative RNA-guided DNA endonuclease InsQ',
  1503657,
  1504865,
  1,
  'b1432',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1432'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcO',
  'putative transport protein YdcO',
  1504905,
  1506080,
  -1,
  'b1433',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1433'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sutR',
  'DNA-binding transcriptional dual regulator SutR',
  1506172,
  1506708,
  1,
  'b1434',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1434'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlhA',
  '23S rRNA 5-hydroxycytidine C2501 synthase',
  1506781,
  1508742,
  1,
  'b1435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1435'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncJ',
  'DUF2554 domain-containing protein YncJ',
  1508834,
  1509064,
  -1,
  'b1436',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1436'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hicA',
  'mRNA interferase toxin HicA',
  1509286,
  1509462,
  1,
  'b4532',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4532'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hicB',
  'antitoxin of the HicA-HicB toxin-antitoxinsystem/ DNA-binding transcriptional repressor HicB',
  1509508,
  1509924,
  1,
  'b1438',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1438'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcR',
  'fused putative DNA-binding transcriptionalregulator/putative aminotransferase YdcR',
  1510003,
  1511409,
  1,
  'b1439',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1439'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcS',
  'putative ABC transporter periplasmic bindingprotein/polyhydroxybutyrate synthase',
  1511654,
  1512799,
  1,
  'b1440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1440'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcT',
  'putative ABC transporter ATP-binding proteinYdcT',
  1512817,
  1513830,
  1,
  'b1441',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1441'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcU',
  'putative ABC transporter membrane subunit YdcU',
  1513831,
  1514772,
  1,
  'b1442',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1442'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcV',
  'putative ABC transporter membrane subunit YdcV',
  1514762,
  1515556,
  1,
  'b1443',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1443'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'patD',
  'gamma-aminobutyraldehyde dehydrogenase',
  1515578,
  1517002,
  1,
  'b1444',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1444'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncL',
  'uncharacterized protein YncL',
  1517099,
  1517194,
  -1,
  'b4598',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4598'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ortT',
  'orphan toxin OrtT',
  1517389,
  1517562,
  1,
  'b1445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1445'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcY',
  'DUF2526 domain-containing protein YdcY',
  1517648,
  1517881,
  1,
  'b1446',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1446'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcZ',
  'putative transport protein YdcZ',
  1517882,
  1518331,
  -1,
  'b1447',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1447'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mnaT',
  'L-amino acid N-acyltransferase',
  1518328,
  1518846,
  -1,
  'b1448',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1448'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'curA',
  'NADPH-dependent curcumin/dihydrocurcuminreductase',
  1519027,
  1520064,
  1,
  'b1449',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1449'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mcbR',
  'DNA-binding transcriptional dual regulator McbR',
  1520262,
  1520927,
  1,
  'b1450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1450'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pqqU',
  'pyrroloquinoline quinone outer membranetransporter',
  1520963,
  1523065,
  -1,
  'b1451',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1451'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncE',
  'PQQ-like domain-containing protein YncE',
  1523307,
  1524368,
  1,
  'b1452',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1452'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ansP',
  'L-asparagine transporter',
  1524481,
  1525980,
  -1,
  'b1453',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1453'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncG',
  'putative glutathione S-transferase YncG',
  1526247,
  1526864,
  1,
  'b1454',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1454'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncH',
  'DUF5445 domain-containing protein YncH',
  1526940,
  1527152,
  1,
  'b1455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1455'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhsE',
  '—',
  1527890,
  1529938,
  1,
  'b1456',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1456'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcD',
  'uncharacterized protein YdcD',
  1529922,
  1530404,
  1,
  'b1457',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1457'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncO',
  'protein YncO',
  1530319,
  1530504,
  -1,
  'b4745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4745'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yncI',
  '—',
  1530586,
  1531639,
  1,
  'b1459',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1459'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydcC',
  'H repeat-associated putative transposase YdcC',
  1531816,
  1532952,
  1,
  'b1460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1460'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pptA',
  'tautomerase PptA',
  1533052,
  1533285,
  1,
  'b1461',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1461'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddH',
  'flavin reductase-like protein YddH',
  1533282,
  1533851,
  -1,
  'b1462',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1462'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nhoA',
  'arylamine N-acetyltransferase',
  1534024,
  1534869,
  1,
  'b1463',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1463'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddE',
  'PF02567 family protein YddE',
  1534965,
  1535858,
  -1,
  'b1464',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1464'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narV',
  'nitrate reductase Z subunit gamma',
  1535937,
  1536617,
  -1,
  'b1465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1465'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narW',
  'NarW, putative private chaperone for NarZnitrate reductase subunit',
  1536614,
  1537309,
  -1,
  'b1466',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1466'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narY',
  'nitrate reductase Z subunit beta',
  1537309,
  1538853,
  -1,
  'b1467',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1467'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narZ',
  'nitrate reductase Z subunit alpha',
  1538850,
  1542590,
  -1,
  'b1468',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1468'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narU',
  'nitrate/nitrite transporter NarU',
  1542672,
  1544060,
  -1,
  'b1469',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1469'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddJ',
  '—',
  1544384,
  1544719,
  -1,
  'b1470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1470'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddK',
  'leucine-rich repeat domain-containing proteinYddK',
  1544758,
  1545714,
  -1,
  'b1471',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1471'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddL',
  'putative uncharacterized protein YddL',
  1545738,
  1546028,
  -1,
  'b1472',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1472'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddG',
  'amino acid exporter YddG',
  1546288,
  1547169,
  -1,
  'b1473',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1473'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdnG',
  'formate dehydrogenase N subunit alpha',
  1547401,
  1550448,
  1,
  'b1474',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1474'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdnH',
  'formate dehydrogenase N subunit beta',
  1550461,
  1551345,
  1,
  'b1475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1475'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fdnI',
  'formate dehydrogenase N subunit gamma',
  1551338,
  1551991,
  1,
  'b1476',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1476'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddM',
  'DNA-binding transcriptional regulator YddM',
  1552398,
  1552682,
  -1,
  'b1477',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1477'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'adhP',
  'ethanol dehydrogenase/alcohol dehydrogenase',
  1552828,
  1553838,
  -1,
  'b1478',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1478'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'maeA',
  'malate dehydrogenase(oxaloacetate-decarboxylating)',
  1553972,
  1555669,
  -1,
  'b1479',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1479'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sra',
  'ribosome-associated protein Sra',
  1555826,
  1555963,
  -1,
  'b1480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1480'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bdm',
  'biofilm-dependent modulation protein',
  1556065,
  1556280,
  -1,
  'b1481',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1481'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'osmC',
  'osmotically inducible peroxiredoxin OsmC',
  1556625,
  1557056,
  1,
  'b1482',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1482'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ddpF',
  'putative D,D-dipeptide ABC transporterATP-binding subunit DdpF',
  1557112,
  1558038,
  -1,
  'b1483',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1483'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ddpD',
  'putative D,D-dipeptide ABC transporterATP-binding subunit DdpD',
  1558031,
  1559017,
  -1,
  'b1484',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1484'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ddpC',
  'putative D,D-dipeptide ABC transporter membranesubunit DdpC',
  1559014,
  1559910,
  -1,
  'b1485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1485'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ddpB',
  'putative D,D-dipeptide ABC transporter membranesubunit DdpB',
  1559907,
  1560929,
  -1,
  'b1486',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1486'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ddpA',
  'putative D,D-dipeptide ABC transporterperiplasmic binding protein',
  1560931,
  1562481,
  -1,
  'b1487',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1487'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ddpX',
  'D-alanyl-D-alanine dipeptidase',
  1562495,
  1563076,
  -1,
  'b1488',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1488'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dosP',
  'oxygen-sensing c-di-GMP phosphodiesterase DosP',
  1563334,
  1565733,
  -1,
  'b1489',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1489'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dosC',
  'diguanylate cyclase DosC',
  1565758,
  1567140,
  -1,
  'b1490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1490'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddY',
  'protein YddY',
  1567178,
  1567219,
  -1,
  'b4746',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4746'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'digH',
  'divisome localized glycosyl hydrolase',
  1567504,
  1568823,
  -1,
  'b1491',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1491'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadC',
  'L-glutamate:4-aminobutyrate antiporter',
  1568954,
  1570489,
  -1,
  'b1492',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1492'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gadB',
  'glutamate decarboxylase B',
  1570645,
  1572045,
  -1,
  'b1493',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1493'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pqqL',
  'periplasmic metalloprotease',
  1572407,
  1575202,
  -1,
  'b1494',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1494'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddB',
  'putative TonB-dependent receptor YddB',
  1575247,
  1577619,
  -1,
  'b1495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1495'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yddA',
  'ABC transporter family protein YddA',
  1577657,
  1579342,
  -1,
  'b1496',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1496'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yneP',
  'protein YneP',
  1579545,
  1579667,
  1,
  'b4747',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4747'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeM',
  'putative anaerobic sulfatase maturation enzymeYdeM',
  1579633,
  1580790,
  -1,
  'b1497',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1497'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeN',
  'putative sulfatase YdeN',
  1580842,
  1582524,
  -1,
  'b1498',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1498'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeO',
  'DNA-binding transcriptional dual regulator YdeO',
  1582926,
  1583687,
  -1,
  'b1499',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1499'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'safA',
  'two-component system connector SafA',
  1583762,
  1583959,
  -1,
  'b1500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1500'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeP',
  'putative oxidoreductase YdeP',
  1584207,
  1586486,
  -1,
  'b1501',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1501'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeQ',
  'putative fimbrial adhesin protein YdeQ',
  1586820,
  1587734,
  -1,
  'b1502',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1502'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeR',
  'putative fimbrial protein YdeR',
  1587793,
  1588296,
  -1,
  'b1503',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1503'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeS',
  'putative fimbrial protein YdeS',
  1588309,
  1588839,
  -1,
  'b1504',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1504'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeT',
  'fimbrial usher domain-containing protein YdeT',
  1588853,
  1590001,
  -1,
  'b1505',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1505'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yneL',
  '—',
  1590334,
  1590536,
  -1,
  'b1506',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1506'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hipA',
  'serine/threonine-protein kinase toxin HipA',
  1590854,
  1592176,
  -1,
  'b1507',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1507'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hipB',
  'antitoxin/DNA-binding transcriptional repressorHipB',
  1592176,
  1592442,
  -1,
  'b1508',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1508'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yneO',
  '—',
  1592665,
  1598086,
  -1,
  'b4696',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4696'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrK',
  'autoinducer-2 kinase',
  1598617,
  1600209,
  -1,
  'b1511',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1511'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrR',
  'DNA-binding transcriptional repressor LsrR',
  1600288,
  1601241,
  -1,
  'b1512',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1512'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrA',
  'Autoinducer-2 ABC transporter ATP bindingsubunit',
  1601490,
  1603025,
  1,
  'b1513',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1513'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrC',
  'Autoinducer-2 ABC transporter membrane subunitLsrC',
  1603019,
  1604047,
  1,
  'b1514',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1514'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrD',
  'Autoinducer-2 ABC transporter membrane subunitLsrD',
  1604047,
  1605039,
  1,
  'b1515',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1515'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrB',
  'Autoinducer-2 ABC transporter periplasmicbinding protein',
  1605051,
  1606073,
  1,
  'b1516',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1516'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrF',
  '3-hydroxy-2,4-pentadione 5-phosphate thiolase',
  1606100,
  1606975,
  1,
  'b1517',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1517'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lsrG',
  '(4S)-4-hydroxy-5-phosphonooxypentane-2,3-dioneisomerase',
  1606999,
  1607289,
  1,
  'b1518',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1518'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tam',
  'trans-aconitate 2-methyltransferase',
  1607346,
  1608104,
  1,
  'b1519',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1519'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yneE',
  'PF01062 family inner membrane protein YneE',
  1608108,
  1609022,
  -1,
  'b1520',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1520'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uxaB',
  'tagaturonate reductase',
  1609229,
  1610680,
  -1,
  'b1521',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1521'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcF',
  'putative diguanylate cyclase DgcF',
  1610907,
  1611854,
  -1,
  'b1522',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1522'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yneG',
  'DUF4186 domain-containing protein YneG',
  1611966,
  1612325,
  -1,
  'b1523',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1523'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glsB',
  'glutaminase 2',
  1612325,
  1613251,
  -1,
  'b1524',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1524'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sad',
  'succinate semialdehyde dehydrogenase (NAD(P)(+))Sad',
  1613315,
  1614703,
  -1,
  'b1525',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1525'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptrR',
  'putrescine utilization regulator PtrR',
  1614804,
  1615685,
  1,
  'b1526',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1526'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yneK',
  'protein YneK',
  1615763,
  1616878,
  1,
  'b1527',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1527'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeA',
  'putative exporter YdeA',
  1617028,
  1618218,
  1,
  'b1528',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1528'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'marC',
  'inner membrane protein MarC',
  1618243,
  1618908,
  -1,
  'b1529',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1529'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'marR',
  'DNA-binding transcriptional repressor MarR',
  1619120,
  1619554,
  1,
  'b1530',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1530'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'marA',
  'DNA-binding transcriptional dual regulator MarA',
  1619574,
  1619957,
  1,
  'b1531',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1531'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'marB',
  'multiple antibiotic resistance protein MarB',
  1619989,
  1620207,
  1,
  'b1532',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1532'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eamA',
  'cysteine/O-acetylserine exporter EamA',
  1620238,
  1621137,
  -1,
  'b1533',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1533'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeE',
  'dipeptide exporter',
  1621332,
  1622519,
  1,
  'b1534',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1534'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mgtS',
  'small protein MgtS',
  1622646,
  1622741,
  1,
  'b4599',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4599'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mgtT',
  'protein MgtT',
  1622741,
  1622845,
  1,
  'b4775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4775'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mgrR',
  '—',
  1622817,
  1622914,
  -1,
  'b4698',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4698'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcZ',
  'diguanylate cyclase DgcZ',
  1622960,
  1623850,
  -1,
  'b1535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1535'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeI',
  'BOF family protein YdeI',
  1624105,
  1624497,
  -1,
  'b1536',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1536'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydeJ',
  'PF02464 family protein YdeJ',
  1624773,
  1625291,
  1,
  'b1537',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1537'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcp',
  'peptidyl-dipeptidase Dcp',
  1625335,
  1627380,
  -1,
  'b1538',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1538'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfG',
  '3-hydroxy acid dehydrogenase YdfG',
  1627517,
  1628263,
  1,
  'b1539',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1539'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rspR',
  'DNA-binding transcriptional repressor RspR',
  1628352,
  1629038,
  1,
  'b1540',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1540'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfZ',
  'putative selenoprotein YdfZ',
  1629215,
  1629418,
  1,
  'b1541',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1541'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfI',
  'putative oxidoreductase YdfI',
  1629453,
  1630913,
  -1,
  'b1542',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1542'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfJ',
  'putative transporter YdfJ',
  1631002,
  1632285,
  -1,
  'b1543',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1543'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfT',
  'protein YnfT',
  1632890,
  1633003,
  1,
  'b4748',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4748'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfK',
  'cold shock protein YdfK',
  1633072,
  1633305,
  1,
  'b1544',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1544'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pinQ',
  'putative recombinase PinQ',
  1633622,
  1634212,
  1,
  'b1545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1545'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tfaQ',
  'putative tail fiber assembly protein TfaQ',
  1634310,
  1634885,
  -1,
  'b1546',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1546'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'stfQ',
  'putative prophage side tail fiber protein StfQ',
  1634885,
  1635847,
  -1,
  'b1547',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1547'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nohA',
  'putative prophage DNA-packaging protein NohA',
  1635798,
  1636367,
  -1,
  'b1548',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1548'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfO',
  'DUF3950 domain-containing protein YnfO',
  1636756,
  1636989,
  1,
  'b4533',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4533'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfO',
  'DUF1398 domain-containing protein YdfO',
  1637047,
  1637457,
  1,
  'b1549',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1549'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gnsB',
  'protein GnsB',
  1637609,
  1637782,
  -1,
  'b1550',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1550'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfN',
  'protein YnfN',
  1637954,
  1638109,
  -1,
  'b1551',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1551'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfR',
  'protein YnfR',
  1638188,
  1638253,
  -1,
  'b4749',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4749'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfQ',
  'protein YnfQ',
  1638256,
  1638444,
  -1,
  'b4724',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4724'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cspI',
  'cold shock-like protein CspI',
  1638455,
  1638667,
  -1,
  'b1552',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1552'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rzpQ',
  'DUF2514 domain-containing protein RzpQ',
  1639030,
  1639527,
  -1,
  'b1553',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1553'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rzoQ',
  'putative lipoprotein RzoQ',
  1639080,
  1639334,
  -1,
  'b4689',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4689'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rrrQ',
  'putative lysozyme',
  1639524,
  1640057,
  -1,
  'b1554',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1554'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfR',
  'protein YdfR',
  1640054,
  1640365,
  -1,
  'b1555',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1555'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'essQ',
  'putative prophage lysis protein EssQ',
  1640370,
  1640585,
  -1,
  'b1556',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1556'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfU',
  'putative zinc-binding protein YnfU',
  1640805,
  1640975,
  1,
  'b4776',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4776'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cspB',
  'cold shock-like protein CspB',
  1641339,
  1641554,
  -1,
  'b1557',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1557'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cspF',
  'cold shock-like protein CspF',
  1641855,
  1642067,
  1,
  'b1558',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1558'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfS',
  'protein YnfS',
  1642122,
  1642211,
  1,
  'b4750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4750'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfT',
  'putative antitermination protein Q',
  1642489,
  1643241,
  -1,
  'b1559',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1559'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfU',
  'protein YdfU',
  1643255,
  1644304,
  -1,
  'b1560',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1560'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rem',
  'protein Rem',
  1644651,
  1644902,
  -1,
  'b1561',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1561'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hokD',
  'toxic protein HokD',
  1645119,
  1645274,
  -1,
  'b1562',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1562'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'relE',
  'mRNA interferase toxin RelE',
  1645346,
  1645633,
  -1,
  'b1563',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1563'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'relB',
  'antitoxin/DNA-binding transcriptional repressorRelB',
  1645633,
  1645872,
  -1,
  'b1564',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1564'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfV',
  'protein YdfV',
  1645897,
  1646202,
  1,
  'b1565',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1565'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flxA',
  'PF14282 family protein FlxA',
  1646405,
  1646737,
  1,
  'b1566',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1566'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfW',
  'protein YdfW',
  1647174,
  1647323,
  -1,
  'b1567',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1567'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfX',
  'protein YdfX',
  1647346,
  1647636,
  -1,
  'b1568',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1568'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dicC',
  'putative DNA-binding transcriptional regulatorDicC',
  1647620,
  1647850,
  -1,
  'b1569',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1569'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dicA',
  'DNA-binding transcriptional dual regulator DicA',
  1647934,
  1648341,
  1,
  'b1570',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1570'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfA',
  'DUF1391 domain-containing protein YdfA',
  1648508,
  1648663,
  1,
  'b1571',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1571'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfB',
  'uncharacterized protein YdfB',
  1648665,
  1648793,
  1,
  'b1572',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1572'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfC',
  'uncharacterized protein YdfC',
  1648823,
  1649041,
  1,
  'b1573',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1573'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dicF',
  '—',
  1649382,
  1649434,
  1,
  'b1574',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1574'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dicB',
  'cell division inhibition protein DicB',
  1649609,
  1649797,
  1,
  'b1575',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1575'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfD',
  'lysis protein',
  1649794,
  1649985,
  1,
  'b1576',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1576'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydfE',
  '—',
  1650078,
  1650998,
  1,
  'b1577',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1577'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insD7',
  '—',
  1650881,
  1651537,
  1,
  'b1578',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1578'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intQ',
  '—',
  1651512,
  1652708,
  1,
  'b1579',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1579'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfP',
  'protein YnfP',
  1652728,
  1652838,
  -1,
  'b4534',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4534'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rspB',
  'putative zinc-binding dehydrogenase RspB',
  1652896,
  1653915,
  -1,
  'b1580',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1580'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rspA',
  'mandelate racemase/muconate lactonizing enzymefamily protein RspA',
  1653927,
  1655141,
  -1,
  'b1581',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1581'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfA',
  'putative transporter YnfA',
  1655347,
  1655673,
  -1,
  'b1582',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1582'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfB',
  'DUF1283 domain-containing protein YnfB',
  1655808,
  1656149,
  1,
  'b1583',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1583'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'speG',
  'spermidine N-acetyltransferase',
  1656184,
  1656744,
  1,
  'b1584',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1584'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfC',
  'PF06788 family lipoprotein YnfC',
  1656747,
  1657457,
  -1,
  'b1585',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1585'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfD',
  'DUF1161 domain-containing protein YnfD',
  1657565,
  1657870,
  1,
  'b1586',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1586'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfE',
  'putative selenate reductase YnfE',
  1658069,
  1660495,
  1,
  'b1587',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1587'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfF',
  'putative selenate reductase YnfF',
  1660556,
  1662979,
  1,
  'b1588',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1588'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfG',
  'putative oxidoreductase YnfG',
  1662990,
  1663607,
  1,
  'b1589',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1589'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfH',
  'putative menaquinol dehydrogenase',
  1663609,
  1664463,
  1,
  'b1590',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1590'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dmsD',
  'redox enzyme maturation protein DmsD',
  1664506,
  1665120,
  1,
  'b1591',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1591'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'clcB',
  'putative chloride:H(+) antiporter ClcB',
  1665315,
  1666571,
  1,
  'b1592',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1592'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bidA',
  'dethiobiotin synthetase BidA',
  1666524,
  1667219,
  -1,
  'b1593',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1593'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlc',
  'DNA-binding transcriptional repressor Mlc',
  1667344,
  1668564,
  -1,
  'b1594',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1594'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfL',
  'putative DNA-binding transcriptional regulatorYnfL',
  1668699,
  1669592,
  -1,
  'b1595',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1595'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynfM',
  'putative transporter YnfM',
  1669699,
  1670952,
  1,
  'b1596',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1596'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asr',
  'periplasmic chaperone Asr',
  1671376,
  1671684,
  1,
  'b1597',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1597'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgU',
  'uncharacterized protein YdgU',
  1671777,
  1671860,
  1,
  'b4601',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4601'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgD',
  'putative serine protease YdgD',
  1671960,
  1672781,
  1,
  'b1598',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1598'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtI',
  'multidrug/spermidine efflux pump membranesubunit MdtI',
  1672820,
  1673149,
  -1,
  'b1599',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1599'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtJ',
  'multidrug/spermidine efflux pump membranesubunit MdtJ',
  1673136,
  1673501,
  -1,
  'b1600',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1600'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtU',
  'protein MdtU',
  1673608,
  1673709,
  -1,
  'b4777',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4777'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tqsA',
  'autoinducer 2 exporter',
  1673913,
  1674947,
  1,
  'b1601',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1601'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pntB',
  'pyridine nucleotide transhydrogenase subunitbeta',
  1674972,
  1676360,
  -1,
  'b1602',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1602'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pntA',
  'pyridine nucleotide transhydrogenase subunitalpha',
  1676371,
  1677903,
  -1,
  'b1603',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1603'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgH',
  'DUF1471 domain-containing protein YdgH',
  1678427,
  1679371,
  1,
  'b1604',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1604'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgI',
  'putative arginine:ornithine antiporter',
  1679557,
  1680939,
  1,
  'b1605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1605'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'folM',
  'dihydromonapterin reductase',
  1680976,
  1681698,
  1,
  'b1606',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1606'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgC',
  'GlpM family protein',
  1681695,
  1682030,
  -1,
  'b1607',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1607'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rstA',
  'DNA-binding transcriptional regulator RstA',
  1682159,
  1682878,
  1,
  'b1608',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1608'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rstB',
  'sensor histidine kinase RstB',
  1682882,
  1684183,
  1,
  'b1609',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1609'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tus',
  'DNA replication terminus site-binding protein',
  1684259,
  1685188,
  1,
  'b1610',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1610'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fumC',
  'fumarase C',
  1685185,
  1686588,
  -1,
  'b1611',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1611'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fumA',
  'fumarase A',
  1686731,
  1688377,
  -1,
  'b1612',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1612'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'manA',
  'mannose-6-phosphate isomerase',
  1688576,
  1689751,
  1,
  'b1613',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1613'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgA',
  'DUF945 domain-containing protein YdgA',
  1689852,
  1691360,
  1,
  'b1614',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1614'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uidC',
  'outer membrane porin family protein UidC',
  1691586,
  1692851,
  -1,
  'b1615',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1615'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uidB',
  'glucuronide:H(+) symporter',
  1692890,
  1694263,
  -1,
  'b1616',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1616'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uidA',
  'beta-glucuronidase',
  1694260,
  1696071,
  -1,
  'b1617',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1617'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uidR',
  'DNA-binding transcriptional repressor UidR',
  1696462,
  1697052,
  -1,
  'b1618',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1618'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hdhA',
  '7-alpha-hydroxysteroid dehydrogenase',
  1697273,
  1698040,
  -1,
  'b1619',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1619'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malI',
  'DNA-binding transcriptional repressor MalI',
  1698152,
  1699180,
  -1,
  'b1620',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1620'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malX',
  'PTS enzyme IIBC component MalX',
  1699355,
  1700947,
  1,
  'b1621',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1621'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'malY',
  'negative regulator of MalTactivity/cystathionine beta-lyase',
  1700957,
  1702129,
  1,
  'b1622',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1622'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'add',
  'adenosine deaminase',
  1702233,
  1703234,
  1,
  'b1623',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1623'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgJ',
  'putative oxidoreductase YdgJ',
  1703268,
  1704308,
  -1,
  'b1624',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1624'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'blr',
  'beta-lactam resistance protein',
  1704551,
  1704676,
  1,
  'b4409',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4409'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cnu',
  'H-NS- and StpA-binding protein',
  1704949,
  1705164,
  1,
  'b1625',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1625'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydgK',
  'DUF2569 domain-containing inner membrane proteinYdgK',
  1705250,
  1705690,
  1,
  'b1626',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1626'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsxA',
  'SoxR [2Fe-2S] reducing system protein RsxA',
  1705767,
  1706348,
  1,
  'b1627',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1627'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsxB',
  'SoxR [2Fe-2S] reducing system protein RsxB',
  1706348,
  1706926,
  1,
  'b1628',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1628'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsxC',
  'SoxR [2Fe-2S] reducing system protein RsxC',
  1706919,
  1709141,
  1,
  'b1629',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1629'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsxD',
  'SoxR [2Fe-2S] reducing system protein RsxD',
  1709142,
  1710200,
  1,
  'b1630',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1630'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsxG',
  'SoxR [2Fe-2S] reducing system flavoprotein RsxG',
  1710204,
  1710824,
  1,
  'b1631',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1631'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsxE',
  'SoxR [2Fe-2S] reducing system protein RsxE',
  1710828,
  1711523,
  1,
  'b1632',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1632'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nth',
  'endonuclease III',
  1711523,
  1712158,
  1,
  'b1633',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1633'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dtpA',
  'dipeptide/tripeptide:H(+) symporter DtpA',
  1712769,
  1714271,
  1,
  'b1634',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1634'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gstA',
  'glutathione S-transferase GstA',
  1714377,
  1714982,
  1,
  'b1635',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1635'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdxY',
  'pyridoxal kinase 2',
  1715026,
  1715889,
  -1,
  'b1636',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1636'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tyrS',
  'tyrosine--tRNA ligase',
  1715948,
  1717222,
  -1,
  'b1637',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1637'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdxH',
  'pyridoxine/pyridoxamine 5''-phosphate oxidase',
  1717351,
  1718007,
  -1,
  'b1638',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1638'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mliC',
  'inhibitor of c-type lysozyme, putativelipoprotein',
  1718066,
  1718395,
  -1,
  'b1639',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1639'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'anmK',
  'anhydro-N-acetylmuramic acid kinase',
  1718493,
  1719602,
  -1,
  'b1640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1640'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slyB',
  'outer membrane lipoprotein SlyB',
  1719876,
  1720343,
  1,
  'b1641',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1641'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'slyA',
  'DNA-binding transcriptional dual regulator SlyA',
  1720390,
  1720824,
  -1,
  'b1642',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1642'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhI',
  'DUF1656 domain-containing protein YdhI',
  1721025,
  1721261,
  1,
  'b1643',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1643'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhJ',
  'putative membrane fusion protein YdhJ',
  1721264,
  1722121,
  1,
  'b1644',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1644'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhK',
  'putative transporter YdhK',
  1722121,
  1724133,
  1,
  'b1645',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1645'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sodC',
  'superoxide dismutase (Cu-Zn)',
  1724134,
  1724655,
  -1,
  'b1646',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1646'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhF',
  'putative oxidoreductase YdhF',
  1724736,
  1725632,
  -1,
  'b1647',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1647'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhL',
  'DUF1289 domain-containing protein YdhL',
  1725681,
  1725920,
  -1,
  'b1648',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1648'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nemR',
  'DNA-binding transcriptional repressor NemR',
  1726023,
  1726622,
  1,
  'b1649',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1649'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nemA',
  'N-ethylmaleimide reductase',
  1726659,
  1727756,
  1,
  'b1650',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1650'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gloA',
  'lactoylglutathione lyase',
  1727837,
  1728244,
  1,
  'b1651',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1651'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnt',
  'ribonuclease T',
  1728347,
  1728994,
  1,
  'b1652',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1652'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lhr',
  'ATP-dependent helicase Lhr',
  1729087,
  1733703,
  1,
  'b1653',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1653'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'grxD',
  'glutaredoxin 4',
  1733754,
  1734101,
  -1,
  'b1654',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1654'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mepH',
  'peptidoglycan endopeptidase/peptidoglycanL,D-carboxypeptidase MepH',
  1734435,
  1735250,
  1,
  'b1655',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1655'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sodB',
  'superoxide dismutase (Fe)',
  1735378,
  1735959,
  1,
  'b1656',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1656'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhP',
  'putative transporter YdhP',
  1736121,
  1737290,
  -1,
  'b1657',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1657'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cydH',
  'cytochrome bd-I accessory subunit CydH',
  1737456,
  1737545,
  -1,
  'b4602',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4602'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purR',
  'DNA-binding transcriptional repressor PurR',
  1737844,
  1738869,
  1,
  'b1658',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1658'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'punR',
  'DNA-binding transcriptional activator PunR',
  1738866,
  1739798,
  -1,
  'b1659',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1659'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'punC',
  'purine nucleoside transporter PunC',
  1739911,
  1741122,
  1,
  'b1660',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1660'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cfa',
  'cyclopropane fatty acyl phospholipid synthase',
  1741413,
  1742561,
  1,
  'b1661',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1661'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ribC',
  'riboflavin synthase',
  1742601,
  1743242,
  -1,
  'b1662',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1662'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtK',
  'multidrug efflux pump MdtK',
  1743457,
  1744830,
  1,
  'b1663',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1663'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhQ',
  'putative adhesin-related protein YdhQ',
  1744871,
  1746127,
  -1,
  'b1664',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1664'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'valV',
  '—',
  1746435,
  1746511,
  1,
  'b1665',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1665'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'valW',
  '—',
  1746516,
  1746592,
  1,
  'b1666',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1666'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhR',
  'putative monooxygenase YdhR',
  1746700,
  1747005,
  1,
  'b1667',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1667'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhS',
  'FAD/NAD(P) binding domain-containing proteinYdhS',
  1747131,
  1748735,
  1,
  'b1668',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1668'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhT',
  'uncharacterized protein YdhT',
  1748747,
  1749559,
  -1,
  'b1669',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1669'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhU',
  'putative cytochrome YdhU',
  1749563,
  1750348,
  -1,
  'b1670',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1670'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhX',
  'putative 4Fe-4S ferredoxin-like protein YdhX',
  1750345,
  1751013,
  -1,
  'b1671',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1671'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhW',
  'uncharacterized protein YdhW',
  1751077,
  1751724,
  -1,
  'b1672',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1672'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhV',
  'putative oxidoreductase YdhV',
  1751728,
  1753830,
  -1,
  'b1673',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1673'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydhY',
  'putative 4Fe-4S ferredoxin-like protein YdhY',
  1753851,
  1754477,
  -1,
  'b1674',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1674'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fumD',
  'fumarase D',
  1754932,
  1755141,
  -1,
  'b1675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1675'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynhH',
  'protein YnhH',
  1755496,
  1755690,
  1,
  'b4817',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4817'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pykF',
  'pyruvate kinase 1',
  1755698,
  1757110,
  1,
  'b1676',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1676'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lpp',
  'murein lipoprotein',
  1757421,
  1757657,
  1,
  'b1677',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1677'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ldtE',
  'L,D-transpeptidase LdtE',
  1757721,
  1758725,
  -1,
  'b1678',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1678'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sufE',
  'sulfur carrier protein SufE',
  1758874,
  1759290,
  -1,
  'b1679',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1679'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sufS',
  'L-cysteine desulfurase',
  1759303,
  1760523,
  -1,
  'b1680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1680'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sufD',
  'Fe-S cluster scaffold complex subunit SufD',
  1760520,
  1761791,
  -1,
  'b1681',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1681'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sufC',
  'Fe-S cluster scaffold complex subunit SufC',
  1761766,
  1762512,
  -1,
  'b1682',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1682'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sufB',
  'Fe-S cluster scaffold complex subunit SufB',
  1762522,
  1764009,
  -1,
  'b1683',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1683'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sufA',
  'iron-sulfur cluster insertion protein SufA',
  1764018,
  1764386,
  -1,
  'b1684',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1684'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rydB',
  '—',
  1764713,
  1764780,
  -1,
  'b4430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4430'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiH',
  'uncharacterized protein YdiH',
  1764934,
  1765122,
  -1,
  'b1685',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1685'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menI',
  '1,4-dihydroxy-2-naphthoyl-CoA hydrolase',
  1765222,
  1765632,
  -1,
  'b1686',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1686'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiJ',
  'D-2-hydroxyglutarate dehydrogenase',
  1765629,
  1768685,
  -1,
  'b1687',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1687'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiK',
  'putative transporter YdiK',
  1769074,
  1770186,
  1,
  'b1688',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1688'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rprA',
  '—',
  1770372,
  1770477,
  1,
  'b4431',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4431'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiL',
  'DUF1870 domain-containing protein YdiL',
  1770615,
  1770971,
  1,
  'b1689',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1689'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiM',
  'putative exporter YdiM',
  1771071,
  1772285,
  1,
  'b1690',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1690'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiN',
  'putative transporter YdiN',
  1772512,
  1773777,
  1,
  'b1691',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1691'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiB',
  'quinate/shikimate dehydrogenase',
  1773789,
  1774655,
  1,
  'b1692',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1692'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroD',
  '3-dehydroquinate dehydratase',
  1774686,
  1775444,
  1,
  'b1693',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1693'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiF',
  'putative acetate-CoA transferase YdiF',
  1775587,
  1777182,
  1,
  'b1694',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1694'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiO',
  'putative acyl-CoA dehydrogenase YdiO',
  1777196,
  1778347,
  1,
  'b1695',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1695'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiP',
  'DNA-binding transcriptional regulator YdiP',
  1778390,
  1779301,
  -1,
  'b1696',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1696'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiQ',
  'putative electron transfer flavoprotein subunitYdiQ',
  1779617,
  1780381,
  1,
  'b1697',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1697'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiR',
  'putative electron transfer flavoprotein subunitYdiR',
  1780401,
  1781339,
  1,
  'b1698',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1698'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiS',
  'putative electron transfer flavoprotein-quinoneoxidoreductase YdiS',
  1781395,
  1782684,
  1,
  'b1699',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1699'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiT',
  'ferredoxin-like protein YdiT',
  1782681,
  1782974,
  1,
  'b1700',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1700'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadK',
  'medium-chain-fatty-acid--CoA ligase',
  1782977,
  1784677,
  1,
  'b1701',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1701'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppsA',
  'phosphoenolpyruvate synthetase',
  1784734,
  1787112,
  -1,
  'b1702',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1702'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppsR',
  'phosphoenolpyruvate synthetase regulatoryprotein',
  1787445,
  1788278,
  1,
  'b1703',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1703'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroH',
  '3-deoxy-7-phosphoheptulonate synthase,Trp-sensitive',
  1788435,
  1789481,
  1,
  'b1704',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1704'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiE',
  'PF10636 family protein YdiE',
  1789613,
  1789804,
  1,
  'b1705',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1705'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'selO',
  'protein adenylyltransferase SelO',
  1789808,
  1791244,
  -1,
  'b1706',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1706'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rflP',
  'anti-FlhDC factor RflP',
  1791307,
  1792020,
  -1,
  'b1707',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1707'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nlpC',
  'NlpC/P60 family lipoprotein NlpC',
  1792267,
  1792731,
  -1,
  'b1708',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1708'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btuD',
  'vitamin B12 ABC transporter ATP binding subunit',
  1792809,
  1793558,
  -1,
  'b1709',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1709'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btuE',
  'thioredoxin/glutathione peroxidase BtuE',
  1793558,
  1794109,
  -1,
  'b1710',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1710'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btuC',
  'vitamin B12 ABC transporter membrane subunit',
  1794172,
  1795152,
  -1,
  'b1711',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1711'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ihfA',
  'integration host factor subunit alpha',
  1795253,
  1795552,
  -1,
  'b1712',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1712'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheT',
  'phenylalanine--tRNA ligase subunit beta',
  1795557,
  1797944,
  -1,
  'b1713',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1713'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheS',
  'phenylalanine--tRNA ligase',
  1797959,
  1798942,
  -1,
  'b1714',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1714'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pheM',
  'pheST-ihfA operon leader peptide',
  1799226,
  1799270,
  -1,
  'b1715',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1715'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplT',
  '50S ribosomal subunit protein L20',
  1799393,
  1799749,
  -1,
  'b1716',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1716'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpmI',
  '50S ribosomal subunit protein L35',
  1799802,
  1799999,
  -1,
  'b1717',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1717'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'infC',
  'translation initiation factor IF-3',
  1800096,
  1800638,
  -1,
  'b1718',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1718'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thrS',
  'threonine--tRNA ligase',
  1800642,
  1802570,
  -1,
  'b1719',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1719'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arpB',
  '—',
  1803094,
  1804993,
  1,
  'b4494',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4494'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yniD',
  'uncharacterized protein YniD',
  1805165,
  1805272,
  1,
  'b4535',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4535'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiY',
  'acid-inducible putative outer membrane proteinYdiY',
  1805325,
  1806083,
  -1,
  'b1722',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1722'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pfkB',
  '6-phosphofructokinase 2',
  1806370,
  1807299,
  1,
  'b1723',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1723'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydiZ',
  'putative endoribonuclease YdiZ',
  1807400,
  1807690,
  1,
  'b1724',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1724'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yniA',
  'putative kinase YniA',
  1807796,
  1808656,
  1,
  'b1725',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1725'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yniB',
  'uncharacterized protein YniB',
  1808697,
  1809233,
  -1,
  'b1726',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1726'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hxpB',
  'hexitol phosphatase B',
  1809380,
  1810048,
  1,
  'b1727',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1727'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjM',
  'inner membrane protein YdjM',
  1810211,
  1810801,
  1,
  'b1728',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1728'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tcyP',
  'cystine/sulfocysteine:cation symporter',
  1810934,
  1812325,
  1,
  'b1729',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1729'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjO',
  'protein YdjO',
  1812329,
  1813132,
  -1,
  'b1730',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1730'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cedA',
  'cell division modulator',
  1813421,
  1813663,
  -1,
  'b1731',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1731'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'katE',
  'catalase HPII',
  1813867,
  1816128,
  1,
  'b1732',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1732'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chbG',
  'chitooligosaccharide monodeacetylase ChbG',
  1816386,
  1817135,
  -1,
  'b1733',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1733'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chbF',
  'monoacetylchitobiose-6-phosphate hydrolase',
  1817148,
  1818500,
  -1,
  'b1734',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1734'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chbR',
  'DNA binding transcriptional dual regulator ChbR',
  1818605,
  1819447,
  -1,
  'b1735',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1735'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chbA',
  'N,N''-diacetylchitobiose-specific PTS enzyme IIAcomponent',
  1819455,
  1819805,
  -1,
  'b1736',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1736'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chbC',
  'N,N''-diacetylchitobiose-specific PTS enzyme IICcomponent',
  1819856,
  1821214,
  -1,
  'b1737',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1737'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'chbB',
  'N,N''-diacetylchitobiose-specific PTS enzyme IIBcomponent',
  1821299,
  1821619,
  -1,
  'b1738',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1738'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'osmE',
  'osmotically-inducible lipoprotein OsmE',
  1821918,
  1822256,
  -1,
  'b1739',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1739'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nadE',
  'NH3-dependent NAD(+) synthetase',
  1822458,
  1823285,
  1,
  'b1740',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1740'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cho',
  'excinuclease Cho',
  1823515,
  1824402,
  1,
  'b1741',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1741'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ves',
  'HutD family protein Ves',
  1824362,
  1824937,
  -1,
  'b1742',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1742'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'spy',
  'ATP-independent periplasmic chaperone',
  1825140,
  1825625,
  -1,
  'b1743',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1743'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'astE',
  'succinylglutamate desuccinylase',
  1825955,
  1826923,
  -1,
  'b1744',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1744'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'astB',
  'N-succinylarginine dihydrolase',
  1826916,
  1828259,
  -1,
  'b1745',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1745'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'astD',
  'aldehyde dehydrogenase',
  1828256,
  1829734,
  -1,
  'b1746',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1746'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'astA',
  'arginine N-succinyltransferase',
  1829731,
  1830765,
  -1,
  'b1747',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1747'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'astC',
  'succinylornithine transaminase',
  1830762,
  1831982,
  -1,
  'b1748',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1748'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xthA',
  'exodeoxyribonuclease III',
  1832428,
  1833234,
  1,
  'b1749',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1749'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjX',
  'DedA family protein YdjX',
  1833401,
  1834111,
  1,
  'b1750',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1750'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjY',
  '4Fe-4S ferredoxin-type domain-containing proteinYdjY',
  1834116,
  1834793,
  1,
  'b1751',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1751'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjZ',
  'DedA family protein YdjZ',
  1834808,
  1835515,
  1,
  'b1752',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1752'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjA',
  'AhpD-like domain-containing protein YnjA',
  1835515,
  1836063,
  1,
  'b1753',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1753'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjB',
  'putative ABC transporter periplasmic bindingprotein YnjB',
  1836073,
  1837239,
  1,
  'b1754',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1754'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjC',
  'putative ABC transporter membrane subunit YnjC',
  1837212,
  1838747,
  1,
  'b1755',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1755'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjD',
  'putative ABC transporter ATP-binding proteinYnjD',
  1838747,
  1839400,
  1,
  'b1756',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1756'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjE',
  'molybdopterin synthase sulfurtransferase',
  1839467,
  1840774,
  1,
  'b1757',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1757'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjF',
  'CDP-alcohol phosphatidyltransferasedomain-containing protein YnjF',
  1840783,
  1841403,
  -1,
  'b1758',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1758'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudG',
  '5-hydroxy-CTP diphosphatase',
  1841490,
  1841897,
  1,
  'b1759',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1759'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjH',
  'DUF1496 domain-containing protein YnjH',
  1841863,
  1842135,
  -1,
  'b1760',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1760'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gdhA',
  'glutamate dehydrogenase',
  1842371,
  1843714,
  1,
  'b1761',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1761'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ynjI',
  'DUF1266 domain-containing protein YnjI',
  1843831,
  1844871,
  -1,
  'b1762',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1762'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'topB',
  'DNA topoisomerase III',
  1844999,
  1846960,
  -1,
  'b1763',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1763'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'selD',
  'selenide, water dikinase',
  1846965,
  1848008,
  -1,
  'b1764',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1764'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjA',
  'putative oxidoreductase YdjA',
  1848125,
  1848676,
  -1,
  'b1765',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1765'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sppA',
  'protease IV, a signal peptide peptidase',
  1848837,
  1850693,
  1,
  'b1766',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1766'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ansA',
  'L-asparaginase 1',
  1850860,
  1851876,
  1,
  'b1767',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1767'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pncA',
  'nicotinamidase',
  1851887,
  1852528,
  1,
  'b1768',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1768'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjE',
  'putative transporter YdjE',
  1852621,
  1853979,
  -1,
  'b1769',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1769'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjF',
  'putative DNA-binding transcriptional regulatorYdjF',
  1854096,
  1854854,
  -1,
  'b1770',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1770'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjG',
  'NADH-dependent methylglyoxal reductase',
  1854991,
  1855971,
  -1,
  'b1771',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1771'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjH',
  'L-glycero-L-galacto-octuluronate kinase',
  1855981,
  1856928,
  -1,
  'b1772',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1772'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjI',
  'L-glycero-L-galacto-octuluronate-1-phosphatealdolase',
  1856933,
  1857769,
  -1,
  'b1773',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1773'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjJ',
  'putative zinc-binding dehydrogenase YdjJ',
  1857790,
  1858833,
  -1,
  'b1774',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1774'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjK',
  'putative transporter YdjK',
  1858850,
  1860229,
  -1,
  'b1775',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1775'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ydjL',
  'putative zinc-binding dehydrogenase YdjL',
  1860256,
  1861332,
  -1,
  'b1776',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1776'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaC',
  'DUF1315 domain-containing protein YeaC',
  1861702,
  1861974,
  -1,
  'b1777',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1777'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'msrB',
  'methionine sulfoxide reductase B',
  1862016,
  1862429,
  -1,
  'b1778',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1778'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gapA',
  'glyceraldehyde-3-phosphate dehydrogenase A',
  1862771,
  1863766,
  1,
  'b1779',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1779'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaD',
  'putative aldose 1-epimerase YeaD',
  1863850,
  1864734,
  1,
  'b1780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1780'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaE',
  'methylglyoxal reductase YeaE',
  1864782,
  1865636,
  -1,
  'b1781',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1781'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mipA',
  'MltA-interacting protein',
  1865726,
  1866472,
  -1,
  'b1782',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1782'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaG',
  'protein kinase YeaG',
  1866908,
  1868842,
  1,
  'b1783',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1783'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaH',
  'DUF444 domain-containing protein YeaH',
  1868955,
  1870238,
  1,
  'b1784',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1784'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cdgI',
  'putative c-di-GMP binding protein CdgI',
  1870385,
  1871860,
  1,
  'b1785',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1785'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcJ',
  'diguanylate cyclase DgcJ',
  1872041,
  1873531,
  1,
  'b1786',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1786'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaK',
  'mischarged aminoacyl-tRNA deacylase',
  1873574,
  1874077,
  1,
  'b1787',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1787'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaI',
  'protein YoaI',
  1874078,
  1874182,
  -1,
  'b1788',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1788'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaL',
  'DUF441 domain-containing inner membrane proteinYeaL',
  1874352,
  1874798,
  1,
  'b1789',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1789'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nimR',
  'DNA-binding transcriptional repressor NimR',
  1874755,
  1875576,
  -1,
  'b1790',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1790'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nimT',
  '2-nitroimidazole exporter',
  1875673,
  1876854,
  1,
  'b1791',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1791'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaO',
  'DUF488 domain-containing protein YeaO',
  1876909,
  1877256,
  1,
  'b1792',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1792'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaF',
  'DUF333 domain-containing lipoprotein YoaF',
  1877278,
  1877532,
  -1,
  'b1793',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1793'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcP',
  'diguanylate cyclase DgcP',
  1877715,
  1878740,
  1,
  'b1794',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1794'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaK',
  'putative membrane protein YoaK',
  1878773,
  1878871,
  1,
  'b4676',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4676'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaJ',
  'uncharacterized protein YoaJ',
  1878874,
  1878948,
  1,
  'b4675',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4675'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaQ',
  'PF04226 family protein YeaQ',
  1879007,
  1879255,
  -1,
  'b1795',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1795'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaG',
  'DUF1869 domain-containing protein YoaG',
  1879403,
  1879585,
  -1,
  'b1796',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1796'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaR',
  'DUF1971 domain-containing protein YeaR',
  1879589,
  1879948,
  -1,
  'b1797',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1797'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuE',
  'leucine exporter',
  1880121,
  1880759,
  -1,
  'b1798',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1798'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dmlR',
  'DNA-binding transcriptional regulator DmlR',
  1880886,
  1881809,
  -1,
  'b1799',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1799'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dmlA',
  'D-malate/3-isopropylmalate dehydrogenase(decarboxylating)',
  1881912,
  1882997,
  1,
  'b1800',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1800'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaV',
  'putative transporter YeaV',
  1883188,
  1884633,
  1,
  'b1801',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1801'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaW',
  'carnitine monooxygenase subunit YeaW',
  1884665,
  1885789,
  1,
  'b1802',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1802'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaX',
  'carnitine monooxygenase subunit YeaX',
  1885845,
  1886810,
  1,
  'b1803',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1803'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rnd',
  'RNase D',
  1886864,
  1887991,
  -1,
  'b1804',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1804'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadD',
  'long-chain-fatty-acid--CoA ligase',
  1888061,
  1889746,
  -1,
  'b1805',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1805'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeaY',
  'Slp family lipoprotein YeaY',
  1889951,
  1890532,
  -1,
  'b1806',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1806'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsaB',
  'N(6)-L-threonylcarbamoyladenine synthase, TsaBsubunit',
  1890572,
  1891267,
  -1,
  'b1807',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1807'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaA',
  'ATP-dependent DNA helicase YoaA',
  1891325,
  1893235,
  -1,
  'b1808',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1808'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaB',
  'RutC family protein YoaB',
  1893367,
  1893711,
  1,
  'b1809',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1809'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaC',
  'DUF1889 domain-containing protein YoaC',
  1894133,
  1894432,
  1,
  'b1810',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1810'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaH',
  'UFP0181 family protein YoaH',
  1894552,
  1894731,
  -1,
  'b1811',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1811'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pabB',
  'aminodeoxychorismate synthase subunit 1',
  1894805,
  1896166,
  1,
  'b1812',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1812'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudL',
  'putative NUDIX hydrolase with low3-phosphohydroxypyruvate phosphatase activity',
  1896170,
  1896748,
  1,
  'b1813',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1813'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdaA',
  'L-serine deaminase I',
  1896932,
  1898296,
  1,
  'b1814',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1814'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeD',
  'putative cyclic di-GMP phosphodiesterase PdeD',
  1898427,
  1900025,
  1,
  'b1815',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1815'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaE',
  'TerC family inner membrane protein YoaE',
  1900029,
  1901585,
  -1,
  'b1816',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1816'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaL',
  'protein YoaL',
  1901573,
  1901731,
  -1,
  'b4751',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4751'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'manX',
  'mannose-specific PTS enzyme IIAB component',
  1902048,
  1903019,
  1,
  'b1817',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1817'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'manY',
  'mannose-specific PTS enzyme IIC component',
  1903082,
  1903882,
  1,
  'b1818',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1818'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'manZ',
  'mannose-specific PTS enzyme IID component',
  1903895,
  1904746,
  1,
  'b1819',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1819'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yobD',
  'DUF986 domain-containing inner membrane proteinYobD',
  1904801,
  1905259,
  1,
  'b1820',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1820'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mntP',
  'Mn(2(+)) exporter',
  1905688,
  1906254,
  1,
  'b1821',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1821'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rlmA',
  '23S rRNA m(1)G745 methyltransferase',
  1906251,
  1907060,
  -1,
  'b1822',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1822'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cspC',
  'transcription antiterminator and regulator ofmRNA stability CspC',
  1907226,
  1907435,
  -1,
  'b1823',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1823'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yobF',
  'DUF2527 domain-containing protein YobF',
  1907448,
  1907591,
  -1,
  'b1824',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1824'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebO',
  'uncharacterized protein YebO',
  1908261,
  1908548,
  -1,
  'b1825',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1825'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mgrB',
  'PhoQ kinase inhibitor',
  1908623,
  1908766,
  -1,
  'b1826',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1826'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yobH',
  'uncharacterized protein YobH',
  1908925,
  1909164,
  1,
  'b4536',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4536'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'kdgR',
  'DNA-binding transcriptional repressor KdgR',
  1909308,
  1910099,
  -1,
  'b1827',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1827'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebQ',
  'putative transporter YebQ',
  1910276,
  1911649,
  1,
  'b1828',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1828'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'htpX',
  'protease HtpX',
  1911695,
  1912576,
  -1,
  'b1829',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1829'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prc',
  'tail-specific protease',
  1912768,
  1914816,
  -1,
  'b1830',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1830'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proQ',
  'RNA chaperone ProQ',
  1914836,
  1915534,
  -1,
  'b1831',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1831'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'msrC',
  'free methionine-(R)-sulfoxide reductase',
  1915631,
  1916128,
  -1,
  'b1832',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1832'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'letA',
  'intermembrane transport protein LetA',
  1916258,
  1917541,
  1,
  'b1833',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1833'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'letB',
  'lipophilic envelope spanning tunnel',
  1917510,
  1920143,
  1,
  'b1834',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1834'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsmF',
  '16S rRNA m(5)C1407 methyltransferase',
  1920223,
  1921662,
  1,
  'b1835',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1835'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebV',
  'DUF1480 domain-containing protein YebV',
  1921780,
  1922016,
  1,
  'b1836',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1836'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebW',
  'DUF1482 domain-containing protein YebW',
  1922121,
  1922312,
  1,
  'b1837',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1837'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pphA',
  'phosphoprotein phosphatase 1',
  1922313,
  1922969,
  -1,
  'b1838',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1838'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ryeA',
  '—',
  1923066,
  1923337,
  1,
  'b4432',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4432'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdsR',
  '—',
  1923104,
  1923207,
  -1,
  'b4433',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4433'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebY',
  'DUF2511 domain-containing protein YebY',
  1923365,
  1923706,
  -1,
  'b1839',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1839'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebZ',
  'CopD family protein',
  1923719,
  1924591,
  -1,
  'b1840',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1840'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yobA',
  'copper-binding protein',
  1924595,
  1924969,
  -1,
  'b1841',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1841'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'holE',
  'DNA polymerase III subunit theta',
  1925108,
  1925338,
  1,
  'b1842',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1842'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yobB',
  'putative carbon-nitrogen hydrolase familyprotein YobB',
  1925440,
  1926096,
  1,
  'b1843',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1843'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'exoX',
  'exonuclease X',
  1926120,
  1926782,
  1,
  'b1844',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1844'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptrB',
  'oligopeptidase B',
  1926779,
  1928839,
  -1,
  'b1845',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1845'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebE',
  'DUF533 domain-containing inner membrane proteinYebE',
  1929048,
  1929707,
  -1,
  'b1846',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1846'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebF',
  'secreted protein YebF',
  1930034,
  1930390,
  -1,
  'b1847',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1847'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebG',
  'DNA damage-inducible protein YebG',
  1930457,
  1930747,
  -1,
  'b1848',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1848'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purT',
  'phosphoribosylglycinamide formyltransferase 2',
  1930881,
  1932059,
  1,
  'b1849',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1849'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eda',
  'KHG/KDPG aldolase',
  1932115,
  1932756,
  -1,
  'b1850',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1850'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'edd',
  'phosphogluconate dehydratase',
  1932793,
  1934604,
  -1,
  'b1851',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1851'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zwf',
  'NADP(+)-dependent glucose-6-phosphatedehydrogenase',
  1934839,
  1936314,
  -1,
  'b1852',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1852'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebK',
  'DNA-binding transcriptional repressor YebK',
  1936652,
  1937521,
  1,
  'b1853',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1853'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pykA',
  'pyruvate kinase 2',
  1937649,
  1939091,
  1,
  'b1854',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1854'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lpxM',
  'Lipid A biosynthesis myristoyltransferase',
  1939222,
  1940193,
  -1,
  'b1855',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1855'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mepM',
  'peptidoglycan endopeptidase MepM',
  1940313,
  1941635,
  -1,
  'b1856',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1856'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'znuA',
  'Zn(2(+)) ABC transporter periplasmic bindingprotein',
  1941651,
  1942583,
  -1,
  'b1857',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1857'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'znuC',
  'Zn(2(+)) ABC transporter ATP binding subunit',
  1942662,
  1943417,
  1,
  'b1858',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1858'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'znuB',
  'Zn(2(+)) ABC transporter membrane subunit',
  1943414,
  1944199,
  1,
  'b1859',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1859'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ruvB',
  'Holliday junction branch migration complexsubunit RuvB',
  1944346,
  1945356,
  -1,
  'b1860',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1860'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ruvA',
  'Holliday junction branch migration complexsubunit RuvA',
  1945365,
  1945976,
  -1,
  'b1861',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1861'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yobI',
  'uncharacterized protein YobI',
  1946115,
  1946180,
  -1,
  'b4677',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4677'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebB',
  'putative papain-like amidase YebB',
  1946251,
  1946853,
  1,
  'b1862',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1862'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ruvC',
  'crossover junction endodeoxyribonuclease RuvC',
  1946855,
  1947376,
  -1,
  'b1863',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1863'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yebC',
  'putative transcriptional regulator YebC',
  1947411,
  1948151,
  -1,
  'b1864',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1864'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudB',
  'dihydroneopterin triphosphate diphosphatase',
  1948180,
  1948632,
  -1,
  'b1865',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1865'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aspS',
  'aspartate--tRNA ligase',
  1948750,
  1950522,
  -1,
  'b1866',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1866'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecD',
  'isochorismatase family protein YecD',
  1950832,
  1951398,
  1,
  'b1867',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1867'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecE',
  'DUF72 domain-containing protein YecE',
  1951395,
  1952213,
  1,
  'b1868',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1868'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecN',
  'MAPEG family inner membrane protein YecN',
  1952266,
  1952661,
  1,
  'b1869',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1869'
);
COMMIT;