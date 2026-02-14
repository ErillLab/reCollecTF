PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cmoA',
  'carboxy-S-adenosyl-L-methionine synthase',
  1952702,
  1953445,
  1,
  'b1870',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1870'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cmoB',
  'tRNA U34 carboxymethyltransferase',
  1953442,
  1954413,
  1,
  'b1871',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1871'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'torZ',
  'trimethylamine N-oxide reductase 2',
  1954578,
  1957007,
  -1,
  'b1872',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1872'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'torY',
  'cytochrome c quinol dehydrogenase TorY',
  1957032,
  1958132,
  -1,
  'b1873',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1873'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'micL',
  '—',
  1958441,
  1958747,
  -1,
  'b4717',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4717'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cutC',
  'PF03932 family protein CutC',
  1958520,
  1959266,
  -1,
  'b1874',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1874'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecM',
  'putative metal-binding enzyme YecM',
  1959280,
  1959846,
  -1,
  'b1875',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1875'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argS',
  'arginine--tRNA ligase',
  1960062,
  1961795,
  1,
  'b1876',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1876'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecV',
  'protein YecV',
  1961837,
  1961881,
  -1,
  'b4778',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4778'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecT',
  'protein YecT',
  1961972,
  1962460,
  1,
  'b1877',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1877'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flhE',
  'flagellar protein FlhE',
  1962580,
  1962972,
  -1,
  'b1878',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1878'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flhA',
  'flagellar biosynthesis protein FlhA',
  1962972,
  1965050,
  -1,
  'b1879',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1879'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flhB',
  'flagellar biosynthesis protein FlhB',
  1965043,
  1966191,
  -1,
  'b1880',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1880'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cheZ',
  'chemotaxis protein CheZ',
  1966393,
  1967037,
  -1,
  'b1881',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1881'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cheY',
  'chemotaxis protein CheY',
  1967048,
  1967437,
  -1,
  'b1882',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1882'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cheB',
  'protein-glutamate methylesterase/proteinglutamine deamidase',
  1967452,
  1968501,
  -1,
  'b1883',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1883'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cheR',
  'chemotaxis protein methyltransferase',
  1968504,
  1969364,
  -1,
  'b1884',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1884'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tap',
  'methyl-accepting chemotaxis protein Tap',
  1969383,
  1970984,
  -1,
  'b1885',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1885'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tar',
  'methyl-accepting chemotaxis protein Tar',
  1971030,
  1972691,
  -1,
  'b1886',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1886'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cheW',
  'chemotaxis protein CheW',
  1972836,
  1973339,
  -1,
  'b1887',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1887'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cheA',
  'chemotaxis protein CheA',
  1973360,
  1975324,
  -1,
  'b1888',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1888'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'motB',
  'motility protein B',
  1975329,
  1976255,
  -1,
  'b1889',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1889'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'motA',
  'motility protein A',
  1976252,
  1977139,
  -1,
  'b1890',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1890'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'motR',
  '—',
  1977208,
  1977302,
  -1,
  'b4828',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4828'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flhC',
  'DNA-binding transcriptional dual regulator FlhC',
  1977266,
  1977844,
  -1,
  'b1891',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1891'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flhD',
  'DNA-binding transcriptional dual regulator FlhD',
  1977847,
  1978197,
  -1,
  'b1892',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1892'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asflhD',
  '—',
  1978176,
  1978395,
  1,
  'b4839',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4839'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insB5',
  'IS1 protein InsB',
  1978518,
  1979021,
  -1,
  'b1893',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1893'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insA5',
  'IS1 protein InsA',
  1978940,
  1979215,
  -1,
  'b1894',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1894'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uspC',
  'universal stress protein C',
  1979753,
  1980181,
  1,
  'b1895',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1895'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'otsA',
  'trehalose-6-phosphate synthase',
  1980188,
  1981612,
  -1,
  'b1896',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1896'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'otsB',
  'trehalose-6-phosphate phosphatase',
  1981587,
  1982387,
  -1,
  'b1897',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1897'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'araH',
  'arabinose ABC transporter membrane subunit',
  1982554,
  1983540,
  -1,
  'b4460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4460'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'araG',
  'arabinose ABC transporter ATP binding subunit',
  1983555,
  1985069,
  -1,
  'b1900',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1900'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'araF',
  'arabinose ABC transporter periplasmic bindingprotein',
  1985139,
  1986128,
  -1,
  'b1901',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1901'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftnB',
  'putative ferritin-like protein',
  1986925,
  1987428,
  1,
  'b1902',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1902'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecJ',
  'DUF2766 domain-containing protein YecJ',
  1987507,
  1987758,
  -1,
  'b4537',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4537'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'azuR',
  '—',
  1987843,
  1988001,
  -1,
  'b4434',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4434'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'azuC',
  'small regulatory membrane protein AzuC',
  1987873,
  1987959,
  -1,
  'b4663',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4663'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecR',
  'lipoprotein YecR',
  1988222,
  1988545,
  1,
  'b1904',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1904'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftnA',
  'ferritin iron storage protein',
  1988716,
  1989213,
  1,
  'b1905',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1905'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecH',
  'DUF2492 domain-containing protein YecH',
  1989251,
  1989490,
  -1,
  'b1906',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1906'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tyrP',
  'tyrosine:H(+) symporter',
  1989681,
  1990892,
  1,
  'b1907',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1907'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecA',
  'putative Fe-binding protein YecA',
  1990954,
  1991619,
  -1,
  'b1908',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1908'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  '3''ETS-leuZ',
  '—',
  1991748,
  1991814,
  -1,
  'b4759',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4759'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'leuZ',
  '—',
  1991815,
  1991901,
  -1,
  'b1909',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1909'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysT',
  '—',
  1991914,
  1991987,
  -1,
  'b1910',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1910'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glyW',
  '—',
  1992042,
  1992117,
  -1,
  'b1911',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1911'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pgsA',
  'CDP-diacylglycerol--glycerol-3-phosphate3-phosphatidyltransferase',
  1992269,
  1992817,
  -1,
  'b1912',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1912'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uvrC',
  'UvrABC excision nuclease subunit C',
  1992874,
  1994706,
  -1,
  'b1913',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1913'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uvrY',
  'DNA-binding transcriptional activator UvrY',
  1994703,
  1995359,
  -1,
  'b1914',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1914'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecU',
  'protein YecU',
  1995655,
  1995831,
  1,
  'b4752',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4752'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yecF',
  'DUF2594 domain-containing protein YecF',
  1995818,
  1996042,
  1,
  'b1915',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1915'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdiA',
  'DNA-binding transcriptional dual regulator SdiA',
  1996110,
  1996832,
  -1,
  'b1916',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1916'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sdsN',
  '—',
  1996921,
  1997057,
  1,
  'b4719',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4719'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tcyN',
  'cystine ABC transporter ATP binding subunit',
  1997062,
  1997814,
  -1,
  'b1917',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1917'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tcyL',
  'cystine ABC transporter membrane subunit',
  1997811,
  1998479,
  -1,
  'b1918',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1918'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcyD',
  'D-cysteine desulfhydrase',
  1998494,
  1999480,
  -1,
  'b1919',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1919'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tcyJ',
  'cystine ABC transporter periplasmic bindingprotein',
  1999585,
  2000385,
  -1,
  'b1920',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1920'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliZ',
  'DNA-binding transcriptional regulator FliZ',
  2000473,
  2001024,
  -1,
  'b1921',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1921'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliA',
  'RNA polymerase sigma factor FliA',
  2001070,
  2001789,
  -1,
  'b1922',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1922'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliX',
  '—',
  2001912,
  2002106,
  -1,
  'b4827',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4827'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliC',
  'flagellar filament structural protein',
  2002110,
  2003606,
  -1,
  'b1923',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1923'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliD',
  'flagellar filament capping protein',
  2003872,
  2005278,
  1,
  'b1924',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1924'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliS',
  'flagellar biosynthesis protein FliS',
  2005303,
  2005713,
  1,
  'b1925',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1925'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliT',
  'flagellar biosynthesis protein FliT',
  2005713,
  2006078,
  1,
  'b1926',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1926'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'amyA',
  'alpha-amylase',
  2006156,
  2007643,
  1,
  'b1927',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1927'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedD',
  'lipoprotein YedD',
  2007677,
  2008090,
  -1,
  'b1928',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1928'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedE',
  'putative selenium transporter YedE',
  2008277,
  2009482,
  1,
  'b1929',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1929'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedF',
  'putative sulfurtransferase YedF',
  2009479,
  2009712,
  1,
  'b1930',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1930'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedK',
  'genome maintenance protein',
  2009821,
  2010489,
  1,
  'b1931',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1931'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedL',
  'putative acetyltransferase YedL',
  2010600,
  2011079,
  1,
  'b1932',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1932'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedN',
  '—',
  2011223,
  2012351,
  -1,
  'b4495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4495'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intG',
  '—',
  2012502,
  2012780,
  1,
  'b1936',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1936'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliE',
  'flagellar protein FliE',
  2012700,
  2013014,
  -1,
  'b1937',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1937'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliF',
  'flagellar basal-body MS-ring and collar protein',
  2013229,
  2014887,
  1,
  'b1938',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1938'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliG',
  'flagellar motor switch protein FliG',
  2014880,
  2015875,
  1,
  'b1939',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1939'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliH',
  'flagellar biosynthesis protein FliH',
  2015868,
  2016554,
  1,
  'b1940',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1940'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliI',
  'flagellar export ATPase FliI',
  2016554,
  2017927,
  1,
  'b1941',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1941'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliJ',
  'flagellar biosynthesis protein FliJ',
  2017946,
  2018389,
  1,
  'b1942',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1942'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliK',
  'flagellar hook-length control protein',
  2018386,
  2019513,
  1,
  'b1943',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1943'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliL',
  'flagellar protein FliL',
  2019618,
  2020082,
  1,
  'b1944',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1944'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliM',
  'flagellar motor switch protein FliM',
  2020087,
  2021091,
  1,
  'b1945',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1945'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliN',
  'flagellar motor switch protein FliN',
  2021088,
  2021501,
  1,
  'b1946',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1946'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliO',
  'flagellar biosynthesis protein FliO',
  2021504,
  2021869,
  1,
  'b1947',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1947'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliP',
  'flagellar biosynthesis protein FliP',
  2021869,
  2022606,
  1,
  'b1948',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1948'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliQ',
  'flagellar biosynthesis protein FliQ',
  2022616,
  2022885,
  1,
  'b1949',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1949'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fliR',
  'flagellar biosynthesis protein FliR',
  2022893,
  2023678,
  1,
  'b1950',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1950'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcsA',
  'DNA-binding transcriptional activator RcsA',
  2023968,
  2024591,
  1,
  'b1951',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1951'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsrB',
  'protein DsrB',
  2024635,
  2024823,
  -1,
  'b1952',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1952'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yodD',
  'stress-induced protein',
  2024986,
  2025213,
  1,
  'b1953',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1953'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsrA',
  '—',
  2025223,
  2025313,
  -1,
  'b1954',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1954'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedP',
  'putative mannosyl-3-phosphoglyceratephosphatase',
  2025511,
  2026326,
  1,
  'b1955',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1955'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcQ',
  'diguanylate cyclase DgcQ',
  2026323,
  2028017,
  -1,
  'b1956',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1956'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yodC',
  'protein YodC',
  2028188,
  2028370,
  -1,
  'b1957',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1957'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedI',
  'DUF808 domain-containing inner membrane proteinYedI',
  2028449,
  2029366,
  -1,
  'b1958',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1958'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedA',
  'putative transporter YedA',
  2029539,
  2030459,
  1,
  'b1959',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1959'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'vsr',
  'DNA mismatch endonuclease Vsr',
  2030448,
  2030918,
  -1,
  'b1960',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1960'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcm',
  'DNA-cytosine methyltransferase',
  2030899,
  2032317,
  -1,
  'b1961',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1961'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedJ',
  'putative HD superfamily phosphohydrolase YedJ',
  2032384,
  2033079,
  -1,
  'b1962',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1962'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'drpB',
  'cell division protein DrpB',
  2033119,
  2033421,
  -1,
  'b1963',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1963'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rseX',
  '—',
  2033649,
  2033739,
  1,
  'b4603',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4603'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yedS',
  '—',
  2034051,
  2035243,
  1,
  'b4496',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4496'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hchA',
  'protein/nucleic acid deglycase 1',
  2035835,
  2036686,
  1,
  'b1967',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1967'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hprS',
  'sensor histidine kinase HprS',
  2036794,
  2038152,
  -1,
  'b1968',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1968'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hprR',
  'DNA-binding transcriptional dual regulator HprR',
  2038152,
  2038823,
  -1,
  'b1969',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1969'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hiuH',
  'hydroxyisourate hydrolase/transthyretin-relatedprotein',
  2038956,
  2039369,
  1,
  'b1970',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1970'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'msrP',
  'protein-L-methionine sulfoxide reductasecatalytic subunit MsrP',
  2039478,
  2040482,
  1,
  'b1971',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1971'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'msrQ',
  'membrane-bound flavocytochrome MsrQ',
  2040483,
  2041118,
  1,
  'b1972',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1972'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zinT',
  'metal-binding protein ZinT',
  2041375,
  2042025,
  1,
  'b1973',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1973'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yodB',
  'putative cytochrome b561 YodB',
  2042368,
  2042898,
  1,
  'b1974',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1974'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'serU',
  '—',
  2043468,
  2043557,
  -1,
  'b1975',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1975'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mtfA',
  'Mlc titration factor',
  2043651,
  2044448,
  1,
  'b1976',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1976'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asnT',
  '—',
  2044549,
  2044624,
  1,
  'b1977',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1977'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeJ',
  'inverse autotransporter adhesin',
  2044995,
  2052014,
  1,
  'b1978',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1978'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeL',
  '—',
  2052276,
  2053328,
  -1,
  'b4497',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4497'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'shiA',
  'shikimate:H(+) symporter',
  2053643,
  2054959,
  1,
  'b1981',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1981'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'amn',
  'AMP nucleosidase',
  2055061,
  2056515,
  1,
  'b1982',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1982'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeN',
  'putative transcriptional regulator YeeN',
  2056858,
  2057574,
  1,
  'b1983',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1983'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asnW',
  '—',
  2058027,
  2058102,
  -1,
  'b1984',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1984'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeO',
  'FMN/FAD exporter',
  2058203,
  2059846,
  -1,
  'b1985',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1985'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asnU',
  '—',
  2059851,
  2059926,
  1,
  'b1986',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1986'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cbl',
  'DNA-binding transcriptional activator Cbl',
  2059964,
  2060914,
  -1,
  'b1987',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1987'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nac',
  'DNA-binding transcriptional dual regulator Nac',
  2061016,
  2061933,
  -1,
  'b1988',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1988'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asnV',
  '—',
  2062260,
  2062335,
  1,
  'b1989',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1989'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ldtA',
  'L,D-transpeptidase LdtA',
  2062391,
  2063323,
  -1,
  'b1990',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1990'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cobT',
  'nicotinate-nucleotide--dimethylbenzimidazolephosphoribosyltransferase',
  2063388,
  2064467,
  -1,
  'b1991',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1991'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cobS',
  'cobalamin 5''-phosphate synthase',
  2064479,
  2065222,
  -1,
  'b1992',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1992'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cobU',
  'cobinamide-P guanylyltransferase/cobinamidekinase',
  2065219,
  2065764,
  -1,
  'b1993',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1993'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeH',
  '—',
  2066068,
  2066154,
  -1,
  'b4639',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4639'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH6',
  'IS5 transposase and trans-activator',
  2066305,
  2067285,
  -1,
  'b1994',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1994'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeG',
  '—',
  2067360,
  2067892,
  -1,
  'b4640',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4640'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeH',
  '—',
  2068261,
  2068419,
  -1,
  'b4641',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4641'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeA',
  'CP4-44 prophage; TonB-dependent receptor plugdomain-containing protein YoeA',
  2068635,
  2070474,
  1,
  'b4582',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4582'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insD3',
  'IS2 insertion element protein InsB',
  2068952,
  2069857,
  -1,
  'b1996',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1996'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insC3',
  'IS2 insertion element repressor InsA',
  2069815,
  2070180,
  -1,
  'b1997',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1997'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeP',
  '—',
  2070786,
  2071211,
  1,
  'b1999',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b1999'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'isrC',
  '—',
  2071317,
  2071511,
  1,
  'b4435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4435'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flu',
  'self recognizing antigen 43 (Ag43)autotransporter',
  2071539,
  2074658,
  1,
  'b2000',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2000'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeR',
  'inner membrane protein YeeR',
  2074779,
  2076311,
  1,
  'b2001',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2001'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeS',
  'RadC-like JAB domain-containing protein YeeS',
  2076308,
  2076754,
  1,
  'b2002',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2002'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeT',
  'DUF987 domain-containing protein YeeT',
  2076817,
  2077038,
  1,
  'b2003',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2003'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cbeA',
  'cytoskeleton bundling-enhancing antitoxin CbeA',
  2077112,
  2077480,
  1,
  'b2004',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2004'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cbtA',
  'cytoskeleton-binding toxin CbtA',
  2077569,
  2077943,
  1,
  'b2005',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2005'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeW',
  'putative uncharacterized protein YeeW',
  2077940,
  2078134,
  1,
  'b2006',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2006'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeD',
  '—',
  2078549,
  2078677,
  -1,
  'b4642',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4642'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeF',
  'putative uncharacterized protein YoeF',
  2078575,
  2078931,
  1,
  'b4538',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4538'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tmaR',
  'PTS system regulator TmaR',
  2079032,
  2079361,
  -1,
  'b2007',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2007'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeJ',
  'protein YoeJ',
  2079427,
  2079477,
  -1,
  'b4818',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4818'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeA',
  'putative transporter YeeA',
  2079533,
  2080591,
  -1,
  'b2008',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2008'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sbmC',
  'DNA gyrase inhibitor',
  2080789,
  2081262,
  -1,
  'b2009',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2009'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dacD',
  'D-alanyl-D-alanine carboxypeptidase DacD',
  2081381,
  2082547,
  -1,
  'b2010',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2010'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sbcB',
  'exodeoxyribonuclease I',
  2082756,
  2084183,
  1,
  'b2011',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2011'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsuB',
  'putative thiosulfate sulfurtransferase',
  2084226,
  2084453,
  -1,
  'b2012',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2012'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tsuA',
  'thiosulfate transporter',
  2084467,
  2085525,
  -1,
  'b2013',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2013'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'plaP',
  'putrescine:H(+) symporter PlaP',
  2085704,
  2087062,
  -1,
  'b2014',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2014'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeI',
  'uncharacterized protein YoeI',
  2087052,
  2087114,
  -1,
  'b4678',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4678'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeY',
  'putative DNA-binding transcriptional regulatorYeeY',
  2087329,
  2088258,
  -1,
  'b2015',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2015'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeeZ',
  'putative epimerase YeeZ',
  2088304,
  2089128,
  -1,
  'b2016',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2016'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoeB',
  'ribosome-dependent mRNA interferase toxin YoeB',
  2089211,
  2089465,
  -1,
  'b4539',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4539'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yefM',
  'YefM antitoxin of the YoeB-YefM toxin-antitoxinpair and DNA binding transcriptional repressor',
  2089462,
  2089713,
  -1,
  'b2017',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2017'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisL',
  'his operon leader peptide',
  2089996,
  2090046,
  1,
  'b2018',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2018'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisG',
  'ATP phosphoribosyltransferase',
  2090192,
  2091091,
  1,
  'b2019',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2019'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisD',
  'histidinal/histidinol dehydrogenase',
  2091097,
  2092401,
  1,
  'b2020',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2020'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisC',
  'histidinol-phosphate aminotransferase',
  2092398,
  2093468,
  1,
  'b2021',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2021'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisB',
  'imidazoleglycerol-phosphatedehydratase/histidinol-phosphatase',
  2093468,
  2094535,
  1,
  'b2022',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2022'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisH',
  'imidazole glycerol phosphate synthase subunitHisH',
  2094535,
  2095125,
  1,
  'b2023',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2023'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisA',
  '1-(5-phosphoribosyl)-5-[(5-phosphoribosylamino)methylideneamino]imidazole-4-carboxamide isomerase',
  2095125,
  2095862,
  1,
  'b2024',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2024'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisF',
  'imidazole glycerol phosphate synthase subunitHisF',
  2095844,
  2096620,
  1,
  'b2025',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2025'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisI',
  'putative bifunctional phosphoribosyl-AMPcyclohydrolase/phosphoribosyl-ATP pyrophosphatase',
  2096614,
  2097225,
  1,
  'b2026',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2026'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzzB',
  'O-antigen co-polymerase',
  2097321,
  2098301,
  -1,
  'b2027',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2027'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ugd',
  'UDP-glucose 6-dehydrogenase',
  2098447,
  2099613,
  -1,
  'b2028',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2028'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gnd',
  '6-phosphogluconate dehydrogenase,decarboxylating',
  2099862,
  2101268,
  -1,
  'b2029',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2029'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wbbL',
  'interrupted rhamnosyltransferase WbbL',
  2101396,
  2103389,
  -1,
  'b4571',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4571'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH7',
  'IS5 transposase and trans-activator',
  2101895,
  2102875,
  -1,
  'b2030',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2030'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wbbK',
  'putative glycosyltransferase WbbK',
  2103391,
  2104509,
  -1,
  'b2032',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2032'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wbbJ',
  'putative lipopolysaccharide biosynthesisO-acetyl transferase WbbJ',
  2104494,
  2105084,
  -1,
  'b2033',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2033'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wbbI',
  'beta-1,6-galactofuranosyltransferase WbbI',
  2105065,
  2106057,
  -1,
  'b2034',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2034'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wbbH',
  'putative O-antigen polymerase',
  2106060,
  2107226,
  -1,
  'b2035',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2035'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glf',
  'UDP-galactopyranose mutase',
  2107226,
  2108329,
  -1,
  'b2036',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2036'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfbX',
  'polyisoprenol-linked O16-antigen repeat unitflippase',
  2108337,
  2109584,
  -1,
  'b2037',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2037'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfbC',
  'dTDP-4-dehydrorhamnose 3,5-epimerase',
  2109581,
  2110138,
  -1,
  'b2038',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2038'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfbA',
  'glucose-1-phosphate thymidylyltransferase 1',
  2110138,
  2111019,
  -1,
  'b2039',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2039'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfbD',
  'dTDP-4-dehydrorhamnose reductase',
  2111077,
  2111976,
  -1,
  'b2040',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2040'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rfbB',
  'dTDP-glucose 4,6-dehydratase 1',
  2111976,
  2113061,
  -1,
  'b2041',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2041'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'galF',
  'UTP:glucose-1-phosphate uridylyltransferase, lowactivity',
  2113434,
  2114327,
  -1,
  'b2042',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2042'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaM',
  'putative colanic acid biosynthesis protein WcaM',
  2114502,
  2115896,
  -1,
  'b2043',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2043'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaL',
  'putative colanic acid biosynthesis glycosyltransferase WcaL',
  2115907,
  2117127,
  -1,
  'b2044',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2044'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaK',
  'colanic acid biosynthesis pyruvyl transferaseWcaK',
  2117124,
  2118404,
  -1,
  'b2045',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2045'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzxC',
  'colanic acid repeat unit flippase',
  2118680,
  2120158,
  -1,
  'b2046',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2046'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaJ',
  'UDP-glucose:undecaprenyl-phosphateglucose-1-phosphate transferase',
  2120160,
  2121554,
  -1,
  'b2047',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2047'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpsG',
  'phosphomannomutase',
  2121609,
  2122979,
  -1,
  'b2048',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2048'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cpsB',
  'mannose-1-phosphate guanylyltransferase',
  2123084,
  2124520,
  -1,
  'b2049',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2049'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaI',
  'colanic acid biosynthesis fucosyltransferaseWcaI',
  2124523,
  2125746,
  -1,
  'b2050',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2050'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gmm',
  'GDP-mannose mannosyl hydrolase',
  2125743,
  2126222,
  -1,
  'b2051',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2051'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fcl',
  'GDP-L-fucose synthase',
  2126225,
  2127190,
  -1,
  'b2052',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2052'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gmd',
  'GDP-mannose 4,6-dehydratase',
  2127193,
  2128314,
  -1,
  'b2053',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2053'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaF',
  'colanic acid biosynthesis acetyltransferaseWcaF',
  2128340,
  2128888,
  -1,
  'b2054',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2054'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaE',
  'GDP-Fuc:2/3-O-Ac-alpha-L-Fuc-(1->3)-alpha-D-Glc-PP-Und alpha-(1,4)-fucosyltransferase',
  2128904,
  2129650,
  -1,
  'b2055',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2055'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaD',
  'colanic acid polymerase',
  2129661,
  2130878,
  -1,
  'b2056',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2056'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaC',
  'colanic acid biosynthesis galactosyltransferaseWcaC',
  2130853,
  2132070,
  -1,
  'b2057',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2057'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaB',
  'colanic acid biosynthesis acetyltransferaseWcaB',
  2132067,
  2132555,
  -1,
  'b2058',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2058'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wcaA',
  'UDP-glucuronate:2-O-Ac-beta-D-Gal-(1->3)-alpha-L-Fuc-(1->4)-2/3-O-Ac-alpha-L-Fuc-(1->3)-beta-D-Glc-PP-Undbeta-(1,3)-glucuronosyltransferase',
  2132558,
  2133397,
  -1,
  'b2059',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2059'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzc',
  'protein-tyrosine kinase Wzc',
  2133490,
  2135652,
  -1,
  'b2060',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2060'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wzb',
  'protein-tyrosine phosphatase',
  2135655,
  2136098,
  -1,
  'b2061',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2061'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'wza',
  'outer membrane polysaccharide export proteinWza',
  2136104,
  2137243,
  -1,
  'b2062',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2062'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegH',
  'inner membrane protein YegH',
  2137902,
  2139485,
  1,
  'b2063',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2063'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'asmA',
  'putative assembly protein AsmA',
  2139759,
  2141612,
  -1,
  'b2064',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2064'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dcd',
  'dCTP deaminase',
  2141634,
  2142215,
  -1,
  'b2065',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2065'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'udk',
  'uridine/cytidine kinase',
  2142307,
  2142948,
  -1,
  'b2066',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2066'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dgcE',
  'diguanylate cyclase DgcE',
  2143266,
  2146583,
  1,
  'b2067',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2067'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alkA',
  'DNA-3-methyladenine glycosylase 2',
  2146692,
  2147540,
  -1,
  'b2068',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2068'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegD',
  'HSP70 family protein YegD',
  2147674,
  2149026,
  1,
  'b2069',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2069'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegI',
  'putative serine/threonine-protein kinase YegI',
  2149039,
  2150985,
  -1,
  'b2070',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2070'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegJ',
  'DUF2314 domain-containing protein YegJ',
  2151185,
  2151646,
  1,
  'b2071',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2071'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pphC',
  'protein-serine/threonine phosphatase PphC',
  2151711,
  2152472,
  -1,
  'b2072',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2072'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegL',
  'IPR002035 domain-containing protein YegL',
  2152469,
  2153128,
  -1,
  'b2073',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2073'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sibA',
  '—',
  2153311,
  2153454,
  1,
  'b4436',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4436'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibsA',
  'toxic peptide IbsA',
  2153349,
  2153408,
  -1,
  'b4667',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4667'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sibB',
  '—',
  2153646,
  2153781,
  1,
  'b4437',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4437'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ibsB',
  'putative toxic peptide IbsB',
  2153681,
  2153737,
  -1,
  'b4668',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4668'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtA',
  'multidrug efflux pump membrane fusion proteinMdtA',
  2154016,
  2155263,
  1,
  'b2074',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2074'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtB',
  'multidrug efflux pump RND permease subunit MdtB',
  2155263,
  2158385,
  1,
  'b2075',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2075'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtC',
  'multidrug efflux pump RND permease subunit MdtC',
  2158386,
  2161463,
  1,
  'b2076',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2076'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtD',
  'putative multidrug efflux pump MdtD',
  2161464,
  2162879,
  1,
  'b2077',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2077'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'baeS',
  'sensor histidine kinase BaeS',
  2162876,
  2164279,
  1,
  'b2078',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2078'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'baeR',
  'DNA-binding transcriptional activator BaeR',
  2164276,
  2164998,
  1,
  'b2079',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2079'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegP',
  'DUF1508 domain-containing protein YegP',
  2165189,
  2165521,
  1,
  'b2080',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2080'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'trhP',
  'tRNA wobble base hydroxylation protein TrhP',
  2165668,
  2167029,
  1,
  'b2081',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2081'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cyaR',
  '—',
  2167114,
  2167200,
  1,
  'b4438',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4438'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ogrK',
  'prophage P2 late control protein OgrK',
  2167302,
  2167520,
  -1,
  'b2082',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2082'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegZ',
  '—',
  2167602,
  2167820,
  -1,
  'b2083',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2083'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegR',
  'uncharacterized protein YegR',
  2167989,
  2168306,
  -1,
  'b2085',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2085'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegS',
  'lipid kinase YegS',
  2168712,
  2169611,
  1,
  'b2086',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2086'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatR',
  'DNA-binding transcriptional repressor GatR,N-terminal fragment',
  2169693,
  2171727,
  -1,
  'b4498',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4498'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insE5',
  'IS3 element protein InsE',
  2170236,
  2170535,
  1,
  'b2088',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2088'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insF5',
  'IS3 element protein InsF',
  2170532,
  2171398,
  1,
  'b2089',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2089'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatD',
  'galactitol-1-phosphate 5-dehydrogenase',
  2171833,
  2172873,
  -1,
  'b2091',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2091'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatC',
  '—',
  2172921,
  2174278,
  -1,
  'b2092',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2092'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatB',
  'galactitol-specific PTS enzyme IIB component',
  2174282,
  2174566,
  -1,
  'b2093',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2093'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatA',
  'galactitol-specific PTS enzyme IIA component',
  2174597,
  2175049,
  -1,
  'b2094',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2094'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatZ',
  'putative tagatose-1,6-bisphosphate aldolase 2chaperone',
  2175059,
  2176321,
  -1,
  'b2095',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2095'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gatY',
  'tagatose-1,6-bisphosphate aldolase 2',
  2176350,
  2177204,
  -1,
  'b2096',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2096'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fbaB',
  'fructose-bisphosphate aldolase class I',
  2177512,
  2178564,
  -1,
  'b2097',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2097'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegT',
  'putative transporter YegT',
  2178821,
  2180098,
  1,
  'b2098',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2098'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegU',
  'putative ADP-ribosylglycohydrolase YegU',
  2180095,
  2181099,
  1,
  'b2099',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2099'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegV',
  'putative sugar kinase YegV',
  2181096,
  2182061,
  1,
  'b2100',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2100'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegW',
  'DNA-binding transcriptional regulator GgaR',
  2182035,
  2182781,
  -1,
  'b2101',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2101'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yegX',
  'putative glycosyl hydrolase YegX',
  2182833,
  2183651,
  -1,
  'b2102',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2102'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiD',
  'bifunctional hydroxymethylpyrimidinekinase/phosphomethylpyrimidine kinase',
  2183716,
  2184516,
  -1,
  'b2103',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2103'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'thiM',
  'hydroxyethylthiazole kinase',
  2184513,
  2185301,
  -1,
  'b2104',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2104'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcnR',
  'DNA-binding transcriptional repressor RcnR',
  2185524,
  2185796,
  -1,
  'b2105',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2105'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcnA',
  'Ni(2(+))/Co(2(+)) exporter',
  2185917,
  2186741,
  1,
  'b2106',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2106'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcnB',
  'periplasmic protein involved in Ni/Co export',
  2186960,
  2187298,
  1,
  'b2107',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2107'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehA',
  'putative fimbrial adhesin YehA',
  2187380,
  2188414,
  -1,
  'b2108',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2108'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehB',
  'putative fimbrial usher protein YehB',
  2188430,
  2190910,
  -1,
  'b2109',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2109'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehC',
  'putative fimbrial chaperone YehC',
  2190926,
  2191645,
  -1,
  'b2110',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2110'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehD',
  'putative fimbrial protein YehD',
  2191680,
  2192222,
  -1,
  'b2111',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2111'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehE',
  'DUF2574 domain-containing protein YehE',
  2192515,
  2192796,
  -1,
  'b2112',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2112'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mrp',
  'P-loop NTPase family protein Mrp',
  2193059,
  2194168,
  -1,
  'b2113',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2113'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'metG',
  'methionine--tRNA ligase',
  2194300,
  2196333,
  1,
  'b2114',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2114'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehF',
  'PF05406 family protein YehF',
  2196474,
  2197298,
  1,
  'b2115',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2115'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehH',
  '—',
  2197410,
  2200269,
  1,
  'b4499',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4499'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehI',
  'DUF4132 domain-containing protein YehI',
  2200279,
  2203911,
  1,
  'b2118',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2118'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehK',
  'uncharacterized protein YehK',
  2203972,
  2204289,
  1,
  'b4541',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4541'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehL',
  'putative AAA(+) MoxR family ATPase YehL',
  2204596,
  2205684,
  1,
  'b2119',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2119'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehM',
  'uncharacterized protein YehM',
  2205695,
  2207974,
  1,
  'b2120',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2120'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehP',
  'VWA domain-containing protein YehP',
  2207967,
  2209103,
  1,
  'b2121',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2121'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehQ',
  'SWIM zinc finger domains-containing proteinYehQ',
  2209100,
  2210944,
  1,
  'b2122',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2122'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehR',
  'DUF1307 domain-containing lipoprotein YehR',
  2211225,
  2211686,
  1,
  'b2123',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2123'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehS',
  'DUF1456 domain-containing protein YehS',
  2211726,
  2212196,
  -1,
  'b2124',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2124'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btsR',
  'DNA-binding transcriptional dual regulator BtsR',
  2212243,
  2212962,
  -1,
  'b2125',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2125'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'btsS',
  'high-affinity pyruvate receptor',
  2212959,
  2214644,
  -1,
  'b2126',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2126'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlrA',
  'DNA-binding transcriptional activator MlrA',
  2214866,
  2215597,
  1,
  'b2127',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2127'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohO',
  'UPF0387 family protein YohO',
  2215657,
  2215764,
  1,
  'b4542',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4542'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehW',
  'glycine betaine ABC transporter membrane subunitYehW',
  2215745,
  2216476,
  -1,
  'b2128',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2128'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehX',
  'glycine betaine ABC transporter ATP bindingsubunit YehX',
  2216481,
  2217407,
  -1,
  'b2129',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2129'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yehY',
  'glycine betaine ABC transporter membrane subunitYehY',
  2217400,
  2218557,
  -1,
  'b2130',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2130'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'osmF',
  'glycine betaine ABC transporter periplasmicbinding protein OsmF',
  2218564,
  2219481,
  -1,
  'b2131',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2131'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bglX',
  'putative periplasmic glycoside hydrolase',
  2219692,
  2221989,
  -1,
  'b2132',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2132'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dld',
  'quinone-dependent D-lactate dehydrogenase',
  2222185,
  2223900,
  1,
  'b2133',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2133'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pbpG',
  'peptidoglycan DD-endopeptidase PbpG',
  2223938,
  2224870,
  -1,
  'b2134',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2134'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohC',
  'putative inner membrane protein',
  2225044,
  2225631,
  -1,
  'b2135',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2135'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohD',
  'DedA family protein YohD',
  2225801,
  2226379,
  1,
  'b2136',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2136'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohF',
  'putative oxidoreductase YohF',
  2226509,
  2227270,
  -1,
  'b2137',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2137'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mdtQ',
  '—',
  2227323,
  2228758,
  -1,
  'b2139',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2139'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohP',
  'putative membrane protein YohP',
  2228982,
  2229065,
  1,
  'b4679',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4679'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dusC',
  'tRNA-dihydrouridine(16) synthase',
  2229438,
  2230385,
  -1,
  'b2140',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2140'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohJ',
  'putative 3-hydroxypropanoate export proteinYohJ',
  2230624,
  2231022,
  1,
  'b2141',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2141'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yohK',
  'putative 3-hydroxypropanoate export proteinYohK',
  2231019,
  2231714,
  1,
  'b2142',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2142'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cdd',
  'cytidine/deoxycytidine deaminase',
  2231844,
  2232728,
  1,
  'b2143',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2143'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sanA',
  'DUF218 domain-containing protein SanA',
  2232878,
  2233597,
  1,
  'b2144',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2144'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiS',
  'DUF2542 domain-containing protein YeiS',
  2233600,
  2233839,
  1,
  'b2145',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2145'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'preT',
  'dihydropyrimidine dehydrogenase (NAD(+)) subunitPreT',
  2234033,
  2235271,
  1,
  'b2146',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2146'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'preA',
  'dihydropyrimidine dehydrogenase (NAD(+)) subunitPreA',
  2235265,
  2236500,
  1,
  'b2147',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2147'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mglC',
  'D-galactose/methyl-galactoside ABC transportermembrane subunit',
  2236743,
  2237753,
  -1,
  'b2148',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2148'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mglA',
  'D-galactose/methyl-galactoside ABC transporterATP binding subunit',
  2237769,
  2239289,
  -1,
  'b2149',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2149'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mglB',
  'D-galactose/methyl-galactoside ABC transporterperiplasmic binding protein',
  2239350,
  2240348,
  -1,
  'b2150',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2150'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'galS',
  'DNA-binding transcriptional dual regulator GalS',
  2240628,
  2241668,
  -1,
  'b2151',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2151'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiB',
  'DUF418 domain-containing protein YeiB',
  2241810,
  2242967,
  -1,
  'b2152',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2152'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'folE',
  'GTP cyclohydrolase 1',
  2242984,
  2243652,
  -1,
  'b2153',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2153'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiG',
  'S-formylglutathionehydrolase/S-lactoylglutathione hydrolase',
  2243910,
  2244746,
  1,
  'b2154',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2154'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cirA',
  'Fe-catecholate outer membrane transporter CirA',
  2244778,
  2246769,
  -1,
  'b2155',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2155'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysP',
  'lysine:H(+) symporter',
  2247063,
  2248532,
  -1,
  'b2156',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2156'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiE',
  'DNA-binding transcriptional dual regulator YeiE',
  2248737,
  2249618,
  -1,
  'b2157',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2157'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiH',
  'PF03601 family inner membrane protein YeiH',
  2249717,
  2250766,
  1,
  'b2158',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2158'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nfo',
  'endonuclease IV',
  2250840,
  2251697,
  1,
  'b2159',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2159'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiI',
  'putative sugar kinase YeiI',
  2251700,
  2252788,
  1,
  'b2160',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2160'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nupX',
  'putative nucleoside transporter',
  2252895,
  2254145,
  -1,
  'b2161',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2161'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rihB',
  'pyrimidine-specific ribonucleoside hydrolaseRihB',
  2254245,
  2255186,
  -1,
  'b2162',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2162'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiL',
  'DNA-binding transcriptional activator YeiL',
  2255355,
  2256014,
  1,
  'b2163',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2163'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'psuT',
  'putative pseudouridine transporter',
  2256085,
  2257335,
  -1,
  'b2164',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2164'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'psuG',
  'pseudouridine-5''-phosphate glycosidase',
  2257429,
  2258367,
  -1,
  'b2165',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2165'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'psuK',
  'putative pseudouridine kinase',
  2258355,
  2259296,
  -1,
  'b2166',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2166'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fruA',
  'fructose-specific PTS multiphosphoryl transferprotein FruA',
  2259719,
  2261410,
  -1,
  'b2167',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2167'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fruK',
  '1-phosphofructokinase',
  2261427,
  2262365,
  -1,
  'b2168',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2168'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fruB',
  'fructose-specific PTS multiphosphoryl transferprotein FruB',
  2262365,
  2263495,
  -1,
  'b2169',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2169'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'setB',
  'sugar exporter SetB',
  2263863,
  2265044,
  1,
  'b2170',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2170'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiW',
  'putative metal-chelating domain-containingprotein YeiW',
  2265041,
  2265295,
  -1,
  'b4502',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4502'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiP',
  'elongation factor P-like protein YeiP',
  2265450,
  2266022,
  1,
  'b2171',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2171'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiQ',
  'putative oxidoreductase YeiQ',
  2266245,
  2267711,
  1,
  'b2172',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2172'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yeiR',
  'zinc-binding GTPase YeiR',
  2267829,
  2268815,
  1,
  'b2173',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2173'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lpxT',
  'lipid A-core phosphotransferase',
  2268854,
  2269567,
  1,
  'b2174',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2174'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mepS',
  'peptidoglycan endopeptidase/peptidoglycanL,D-carboxypeptidase',
  2269979,
  2270545,
  1,
  'b2175',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2175'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeN',
  'putative c-di-GMP phosphodiesterase PdeN',
  2270726,
  2272282,
  1,
  'b2176',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2176'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejA',
  'oligopeptide ABC transporter periplasmic bindingprotein YejA',
  2272364,
  2274178,
  1,
  'b2177',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2177'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejB',
  'putative oligopeptide ABC transporter membranesubunit YejB',
  2274179,
  2275273,
  1,
  'b2178',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2178'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejE',
  'putative oligopeptide ABC transporter membranesubunit YejE',
  2275273,
  2276298,
  1,
  'b2179',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2179'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejF',
  'oligopeptide ABC transporter ATP binding subunitYejF',
  2276300,
  2277889,
  1,
  'b2180',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2180'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejG',
  'protein YejG',
  2277893,
  2278237,
  -1,
  'b2181',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2181'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcr',
  'multidrug efflux pump Bcr',
  2278570,
  2279760,
  -1,
  'b2182',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2182'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rsuA',
  '16S rRNA pseudouridine(516) synthase',
  2279788,
  2280483,
  -1,
  'b2183',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2183'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'radD',
  'DNA repair helicase RadD',
  2280632,
  2282392,
  1,
  'b2184',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2184'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rplY',
  '50S ribosomal subunit protein L25',
  2282517,
  2282801,
  1,
  'b2185',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2185'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejK',
  'nucleoid-associated protein YejK',
  2282940,
  2283947,
  -1,
  'b2186',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2186'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejL',
  'DUF1414 domain-containing protein YejL',
  2284129,
  2284356,
  1,
  'b2187',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2187'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lapC',
  'lipopolysaccharide signal transducer LapC',
  2284376,
  2286136,
  1,
  'b2188',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2188'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'proL',
  '—',
  2286211,
  2286287,
  1,
  'b2189',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2189'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yejO',
  'adhesin-like autotransporter YejO',
  2286390,
  2290180,
  -1,
  'b2190',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2190'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insH8',
  'IS5 transposase and trans-activator',
  2289065,
  2290045,
  -1,
  'b2192',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2192'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narP',
  'DNA-binding transcriptional dual regulator NarP',
  2290500,
  2291147,
  1,
  'b2193',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2193'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmH',
  'holocytochrome c synthase CcmH component',
  2291358,
  2292410,
  -1,
  'b2194',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2194'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmG',
  'thiol:disulfide oxidoreductase CcmG',
  2292407,
  2292964,
  -1,
  'b2195',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2195'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmF',
  'holocytochrome c synthase CcmF component',
  2292961,
  2294904,
  -1,
  'b2196',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2196'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmE',
  'periplasmic heme chaperone',
  2294901,
  2295380,
  -1,
  'b2197',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2197'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmD',
  'cytochrome c maturation protein D',
  2295377,
  2295586,
  -1,
  'b2198',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2198'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmC',
  'cytochrome c maturation protein C',
  2295583,
  2296320,
  -1,
  'b2199',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2199'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmB',
  'cytochrome c maturation protein B',
  2296362,
  2297024,
  -1,
  'b2200',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2200'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ccmA',
  'cytochrome c maturation protein A',
  2297021,
  2297644,
  -1,
  'b2201',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2201'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napC',
  'periplasmic nitrate reductase cytochrome cprotein',
  2297657,
  2298259,
  -1,
  'b2202',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2202'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napB',
  'periplasmic nitrate reductase cytochrome c550protein',
  2298269,
  2298718,
  -1,
  'b2203',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2203'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napH',
  'ferredoxin-type protein NapH',
  2298715,
  2299578,
  -1,
  'b2204',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2204'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napG',
  'ferredoxin-type protein NapG',
  2299565,
  2300260,
  -1,
  'b2205',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2205'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napA',
  'periplasmic nitrate reductase subunit NapA',
  2300267,
  2302753,
  -1,
  'b2206',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2206'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napD',
  'NapA signal peptide-binding chaperone NapD',
  2302750,
  2303013,
  -1,
  'b2207',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2207'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'napF',
  'ferredoxin-type protein',
  2303003,
  2303497,
  -1,
  'b2208',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2208'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yojO',
  'uncharacterized protein YojO',
  2303606,
  2303770,
  1,
  'b4604',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4604'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eco',
  'serine protease inhibitor ecotin',
  2303905,
  2304393,
  1,
  'b2209',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2209'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mqo',
  'malate:quinone oxidoreductase',
  2305108,
  2306754,
  -1,
  'b2210',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2210'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yojI',
  'ABC transporter family protein/microcin J25efflux protein',
  2306972,
  2308615,
  -1,
  'b2211',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2211'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alkB',
  'DNA oxidative demethylase',
  2308691,
  2309341,
  -1,
  'b2212',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2212'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ada',
  'DNA-binding transcriptional dual regulator/DNArepair protein Ada',
  2309341,
  2310405,
  -1,
  'b2213',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2213'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ftp',
  'FAD:protein FMN transferase',
  2310479,
  2311534,
  -1,
  'b2214',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2214'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ompC',
  'outer membrane porin C',
  2311646,
  2312749,
  -1,
  'b2215',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2215'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'micF',
  '—',
  2313084,
  2313176,
  1,
  'b4439',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4439'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcsD',
  'RcsD phosphotransferase',
  2313488,
  2316160,
  1,
  'b2216',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2216'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcsB',
  'DNA-binding transcriptional activator RcsB',
  2316177,
  2316827,
  1,
  'b2217',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2217'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rcsC',
  'histidine kinase RcsC',
  2317027,
  2319876,
  -1,
  'b2218',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2218'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atoS',
  'sensor histidine kinase AtoS',
  2320043,
  2321869,
  1,
  'b2219',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2219'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atoC',
  'DNA-binding transcriptional activator/ornithinedecarboxylase inhibitor AtoC',
  2321866,
  2323251,
  1,
  'b2220',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2220'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atoD',
  'acetyl-CoA:acetoacetyl-CoA transferase subunitalpha',
  2323447,
  2324109,
  1,
  'b2221',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2221'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atoA',
  'acetyl-CoA:acetoacetyl-CoA transferase subunitbeta',
  2324109,
  2324759,
  1,
  'b2222',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2222'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atoE',
  'short chain fatty acid transporter',
  2324756,
  2326078,
  1,
  'b2223',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2223'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'atoB',
  'acetyl-CoA acetyltransferase',
  2326109,
  2327293,
  1,
  'b2224',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2224'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaP',
  'DUF2135 domain-containing protein YfaP',
  2327367,
  2328143,
  -1,
  'b2225',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2225'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaQ',
  'tandem DUF2300 domain-containing protein YfaQ',
  2328148,
  2329797,
  -1,
  'b2226',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2226'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaS',
  '—',
  2329798,
  2334402,
  -1,
  'b4500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4500'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaT',
  'DUF1175 domain-containing protein YfaT',
  2334336,
  2334959,
  -1,
  'b2229',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2229'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaA',
  'DUF2138 domain-containing protein YfaA',
  2334956,
  2336644,
  -1,
  'b2230',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2230'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gyrA',
  'DNA gyrase subunit A',
  2336793,
  2339420,
  -1,
  'b2231',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2231'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiG',
  'bifunctional 3-demethylubiquinone-83-O-methyltransferase and 2-octaprenyl-6-hydroxyphenolmethylase',
  2339567,
  2340289,
  1,
  'b2232',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2232'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaL',
  'putative autotransporter adhesin YfaL',
  2340417,
  2344169,
  -1,
  'b2233',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2233'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypaB',
  'protein YpaB',
  2344594,
  2344737,
  -1,
  'b4605',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4605'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdA',
  'ribonucleoside-diphosphate reductase 1 subunitalpha',
  2344865,
  2347150,
  1,
  'b2234',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2234'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yoaM',
  'protein YoaM',
  2347350,
  2347385,
  -1,
  'b4779',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4779'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nrdB',
  'ribonucleoside-diphosphate reductase 1 subunitbeta',
  2347384,
  2348514,
  1,
  'b2235',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2235'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaE',
  'ferredoxin-like diferric-tyrosyl radicalcofactor maintenance protein YfaE',
  2348514,
  2348768,
  1,
  'b2236',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2236'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'inaA',
  'putative lipopolysaccharide kinase InaA',
  2348822,
  2349472,
  -1,
  'b2237',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2237'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaH',
  '—',
  2349687,
  2349893,
  1,
  'b2238',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2238'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpQ',
  'glycerophosphoryl diester phosphodiesteraseGlpQ',
  2349935,
  2351011,
  -1,
  'b2239',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2239'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpT',
  'sn-glycerol 3-phosphate:phosphate antiporter',
  2351016,
  2352374,
  -1,
  'b2240',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2240'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpA',
  'anaerobic glycerol-3-phosphate dehydrogenasesubunit A',
  2352647,
  2354275,
  1,
  'b2241',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2241'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpB',
  'anaerobic glycerol-3-phosphate dehydrogenasesubunit B',
  2354265,
  2355524,
  1,
  'b2242',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2242'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glpC',
  'anaerobic glycerol-3-phosphate dehydrogenasesubunit C',
  2355521,
  2356711,
  1,
  'b2243',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2243'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpnE',
  'inactive recombination-promoting nuclease-likeprotein RpnE',
  2356904,
  2357803,
  1,
  'b2244',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2244'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypaA',
  '—',
  2357816,
  2358001,
  1,
  'b4543',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4543'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaU',
  '2-keto-3-deoxy-L-rhamnonate aldolase',
  2358042,
  2358845,
  -1,
  'b2245',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2245'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaV',
  'putative transporter YfaV',
  2358863,
  2360152,
  -1,
  'b2246',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2246'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rhmD',
  'L-rhamnonate dehydratase',
  2360209,
  2361414,
  -1,
  'b2247',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2247'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaX',
  'putative DNA-binding transcriptional regulatorYfaX',
  2361429,
  2362211,
  -1,
  'b2248',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2248'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaY',
  'IPR008135 CinA family protein YfaY',
  2362431,
  2363633,
  -1,
  'b2249',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2249'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfaZ',
  'putative porin YfaZ',
  2363733,
  2364275,
  -1,
  'b2250',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2250'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudI',
  'pyrimidine deoxynucleotide diphosphatase NudI',
  2364554,
  2364979,
  1,
  'b2251',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2251'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ais',
  'putative lipopolysaccharide coreheptose(II)-phosphate phosphatase',
  2365018,
  2365620,
  -1,
  'b2252',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2252'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnB',
  'UDP-4-amino-4-deoxy-L-arabinoseaminotransferase',
  2365910,
  2367067,
  1,
  'b2253',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2253'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnC',
  'undecaprenyl-phosphate4-deoxy-4-formamido-L-arabinose transferase',
  2367071,
  2368039,
  1,
  'b2254',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2254'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnA',
  'fused UDP-4-amino-4-deoxy-L-arabinoseformyltransferase/UDP-glucuronate dehydrogenase',
  2368039,
  2370021,
  1,
  'b2255',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2255'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnD',
  'putative4-deoxy-4-formamido-L-arabinose-phosphoundecaprenoldeformylase ArnD',
  2370018,
  2370908,
  1,
  'b2256',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2256'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnT',
  'lipid IVA4-amino-4-deoxy-L-arabinosyltransferase',
  2370908,
  2372560,
  1,
  'b2257',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2257'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnE',
  'undecaprenyl-phosphate-alpha-L-Ara4N flippase -ArnE subunit',
  2372557,
  2372892,
  1,
  'b4544',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4544'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'arnF',
  'undecaprenyl-phosphate-alpha-L-Ara4N flippase -ArnF subunit',
  2372892,
  2373278,
  1,
  'b2258',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2258'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pmrD',
  'signal transduction protein PmrD',
  2373272,
  2373538,
  -1,
  'b2259',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2259'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menE',
  'o-succinylbenzoate--CoA ligase',
  2373648,
  2375003,
  -1,
  'b2260',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2260'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menC',
  'o-succinylbenzoate synthase',
  2375000,
  2375962,
  -1,
  'b2261',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2261'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menB',
  '1,4-dihydroxy-2-naphthoyl-CoA synthase',
  2375962,
  2376819,
  -1,
  'b2262',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2262'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menH',
  '2-succinyl-6-hydroxy-2,4-cyclohexadiene-1-carboxylate synthase',
  2376834,
  2377592,
  -1,
  'b2263',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2263'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menD',
  '2-succinyl-5-enolpyruvyl-6-hydroxy-3-cyclohexene-1-carboxylate synthase',
  2377589,
  2379259,
  -1,
  'b2264',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2264'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'menF',
  'isochorismate synthase MenF',
  2379348,
  2380643,
  -1,
  'b2265',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2265'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'elaB',
  'tail-anchored inner membrane protein ElaB',
  2380722,
  2381027,
  -1,
  'b2266',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2266'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'elaA',
  'putative acetyltransferase ElaA',
  2381082,
  2381543,
  -1,
  'b2267',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2267'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rbn',
  'ribonuclease BN',
  2381608,
  2382525,
  1,
  'b2268',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2268'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'elaD',
  'protease ElaD',
  2382713,
  2383924,
  1,
  'b2269',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2269'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbK',
  'IPR002035/DUF3520 domain-containing proteinYfbK',
  2383995,
  2385722,
  -1,
  'b2270',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2270'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbL',
  'putative peptidase YfbL',
  2385860,
  2386831,
  1,
  'b2271',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2271'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbM',
  'DUF1877 domain-containing protein YfbM',
  2386934,
  2387437,
  1,
  'b2272',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2272'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbN',
  'uncharacterized protein YfbN',
  2387710,
  2388426,
  -1,
  'b2273',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2273'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbO',
  'uncharacterized protein YfbO',
  2388635,
  2389057,
  1,
  'b2274',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2274'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbP',
  'uncharacterized protein YfbP',
  2389116,
  2389964,
  1,
  'b2275',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2275'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoN',
  'NADH:quinone oxidoreductase subunit N',
  2390048,
  2391505,
  -1,
  'b2276',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2276'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoM',
  'NADH:quinone oxidoreductase subunit M',
  2391512,
  2393041,
  -1,
  'b2277',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2277'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoL',
  'NADH:quinone oxidoreductase subunit L',
  2393205,
  2395046,
  -1,
  'b2278',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2278'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoK',
  'NADH:quinone oxidoreductase subunit K',
  2395043,
  2395345,
  -1,
  'b2279',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2279'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoJ',
  'NADH:quinone oxidoreductase subunit J',
  2395342,
  2395896,
  -1,
  'b2280',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2280'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoI',
  'NADH:quinone oxidoreductase subunit I',
  2395908,
  2396450,
  -1,
  'b2281',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2281'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoH',
  'NADH:quinone oxidoreductase subunit H',
  2396465,
  2397442,
  -1,
  'b2282',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2282'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoG',
  'NADH:quinone oxidoreductase subunit G',
  2397439,
  2400165,
  -1,
  'b2283',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2283'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoF',
  'NADH:quinone oxidoreductase subunit F',
  2400218,
  2401555,
  -1,
  'b2284',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2284'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoE',
  'NADH:quinone oxidoreductase subunit E',
  2401552,
  2402052,
  -1,
  'b2285',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2285'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoC',
  'NADH:quinone oxidoreductase subunit CD',
  2402055,
  2403845,
  -1,
  'b2286',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2286'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoB',
  'NADH:quinone oxidoreductase subunit B',
  2403951,
  2404613,
  -1,
  'b2287',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2287'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nuoA',
  'NADH:quinone oxidoreductase subunit A',
  2404629,
  2405072,
  -1,
  'b2288',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2288'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lrhA',
  'DNA-binding transcriptional dual regulator LrhA',
  2405703,
  2406641,
  -1,
  'b2289',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2289'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaA',
  'glutamate--pyruvate aminotransferase AlaA',
  2407561,
  2408778,
  1,
  'b2290',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2290'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbR',
  'dCMP phosphohydrolase',
  2408862,
  2409461,
  1,
  'b2291',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2291'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbS',
  'putative transporter YfbS',
  2409520,
  2411352,
  -1,
  'b2292',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2292'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hxpA',
  'hexitol phosphatase A',
  2411439,
  2412089,
  -1,
  'b2293',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2293'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbU',
  'PF03887 family protein YfbU',
  2412100,
  2412594,
  -1,
  'b2294',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2294'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfbV',
  'PF04217 family membrane protein YfbV',
  2412677,
  2413132,
  -1,
  'b2295',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2295'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ackA',
  'acetate kinase',
  2413470,
  2414672,
  1,
  'b2296',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2296'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pta',
  'phosphate acetyltransferase',
  2414747,
  2416891,
  1,
  'b2297',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2297'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcC',
  'putative transporter YfcC',
  2417081,
  2418601,
  1,
  'b2298',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2298'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcD',
  'putative Nudix hydrolase YfcD',
  2418634,
  2419176,
  -1,
  'b2299',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2299'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcE',
  'phosphodiesterase YfcE',
  2419234,
  2419788,
  -1,
  'b2300',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2300'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcF',
  'glutathione S-transferase YfcF',
  2419841,
  2420485,
  -1,
  'b2301',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2301'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcG',
  'disulfide bond oxidoreductase YfcG',
  2420621,
  2421268,
  1,
  'b2302',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2302'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'folX',
  'dihydroneopterin triphosphate 2''-epimerase',
  2421325,
  2421687,
  1,
  'b2303',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2303'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcH',
  'epimerase family protein YfcH',
  2421708,
  2422601,
  1,
  'b2304',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2304'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'rpnB',
  'recombination-promoting nuclease RpnB',
  2422649,
  2423539,
  -1,
  'b2305',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2305'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisP',
  'lysine/arginine/ornithine ABCtransporter/histidine ABC transporter, ATP bindingsubunit',
  2423736,
  2424509,
  -1,
  'b2306',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2306'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisM',
  'lysine/arginine/ornithine ABCtransporter/histidine ABC transporter, membrane subunitHisM',
  2424517,
  2425233,
  -1,
  'b2307',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2307'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisQ',
  'lysine/arginine/ornithine ABCtransporter/histidine ABC transporter, membrane subunitHisQ',
  2425230,
  2425916,
  -1,
  'b2308',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2308'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hisJ',
  'histidine ABC transporter periplasmic bindingprotein',
  2426006,
  2426788,
  -1,
  'b2309',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2309'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argT',
  'lysine/arginine/ornithine ABC transporterperiplasmic binding protein',
  2427009,
  2427791,
  -1,
  'b2310',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2310'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ubiX',
  'flavin prenyltransferase',
  2428057,
  2428626,
  -1,
  'b2311',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2311'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purF',
  'amidophosphoribosyltransferase',
  2428721,
  2430238,
  -1,
  'b2312',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2312'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cvpA',
  'colicin V production protein',
  2430275,
  2430763,
  -1,
  'b2313',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2313'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dedD',
  'cell division protein DedD',
  2431022,
  2431684,
  -1,
  'b2314',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2314'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'folC',
  'bifunctional folylpolyglutamatesynthetase/dihydrofolate synthetase',
  2431674,
  2432942,
  -1,
  'b2315',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2315'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'accD',
  'acetyl-CoA carboxyltransferase subunit beta',
  2433012,
  2433926,
  -1,
  'b2316',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2316'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dedA',
  'DedA family protein DedA',
  2434082,
  2434741,
  -1,
  'b2317',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2317'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'truA',
  'tRNA pseudouridine(38-40) synthase',
  2434824,
  2435636,
  -1,
  'b2318',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2318'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'usg',
  'putative semialdehyde dehydrogenase Usg',
  2435636,
  2436649,
  -1,
  'b2319',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2319'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdxB',
  'erythronate-4-phosphate dehydrogenase',
  2436715,
  2437851,
  -1,
  'b2320',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2320'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'flk',
  'putative flagella assembly protein',
  2437950,
  2438945,
  1,
  'b2321',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2321'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcJ',
  'putative transporter YfcJ',
  2438942,
  2440120,
  -1,
  'b2322',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2322'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fabB',
  '3-oxoacyl-[acyl carrier protein] synthase 1',
  2440385,
  2441605,
  -1,
  'b2323',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2323'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mnmC',
  'fused tRNA 5-aminomethyl-2-thiouridylatemethyltransferase and tRNA 5-aminomethyl-2-thiouridylatesynthase',
  2441764,
  2443770,
  1,
  'b2324',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2324'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcL',
  'PF08891 family protein YfcL',
  2443891,
  2444169,
  -1,
  'b2325',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2325'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'epmC',
  'EF-P-Lys34 hydroxylase',
  2444203,
  2444751,
  -1,
  'b2326',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2326'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcA',
  'putative transporter YfcA',
  2444751,
  2445560,
  -1,
  'b2327',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2327'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mepA',
  'peptidoglycan DD-endopeptidase/peptidoglycanLD-endopeptidase',
  2445560,
  2446384,
  -1,
  'b2328',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2328'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aroC',
  'chorismate synthase',
  2446388,
  2447473,
  -1,
  'b2329',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2329'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'prmB',
  'ribosomal protein L3 N(5)-glutaminemethyltransferase',
  2447508,
  2448440,
  -1,
  'b2330',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2330'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'smrB',
  'ribosome rescue factor SmrB',
  2448606,
  2449157,
  1,
  'b2331',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2331'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcO',
  'DUF2544 domain-containing protein YfcO',
  2449228,
  2450049,
  -1,
  'b2332',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2332'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcP',
  'putative fimbrial protein YfcP',
  2450051,
  2450590,
  -1,
  'b2333',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2333'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcQ',
  'putative fimbrial protein YfcQ',
  2450587,
  2451075,
  -1,
  'b2334',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2334'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcR',
  'putative fimbrial protein YfcR',
  2451072,
  2451584,
  -1,
  'b2335',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2335'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcS',
  'putative fimbrial chaperone YfcS',
  2451584,
  2452336,
  -1,
  'b2336',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2336'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcU',
  '—',
  2452356,
  2455001,
  -1,
  'b4661',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4661'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcV',
  'putative fimbrial protein YfcV',
  2455083,
  2455646,
  -1,
  'b2339',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2339'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'sixA',
  'phosphohistidine phosphatase SixA',
  2456327,
  2456812,
  -1,
  'b2340',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2340'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadJ',
  'multifunctional 3-hydroxyacyl-CoAdehydrogenase/3-hydroxyacyl-CoA epimerase/enoyl-CoAhydratase FadJ',
  2457015,
  2459159,
  -1,
  'b2341',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2341'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadI',
  '3-ketoacyl-CoA thiolase FadI',
  2459159,
  2460469,
  -1,
  'b2342',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2342'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfcZ',
  'DUF406 domain-containing protein YfcZ',
  2460650,
  2460934,
  -1,
  'b2343',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2343'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fadL',
  'long-chain fatty acid outer membranechannel/bacteriophage T2 receptor',
  2461306,
  2462646,
  1,
  'b2344',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2344'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdF',
  'protein YfdF',
  2463012,
  2464070,
  1,
  'b2345',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2345'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mlaA',
  'intermembrane phospholipid transport system -outer membrane lipoprotein MlaA',
  2464252,
  2465007,
  -1,
  'b2346',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2346'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdC',
  'inner membrane protein YfdC',
  2465301,
  2466233,
  1,
  'b2347',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2347'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'argW',
  '—',
  2466309,
  2466383,
  1,
  'b2348',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2348'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intS',
  'prophage CPS-53 integrase',
  2466545,
  2467702,
  1,
  'b2349',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2349'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdG',
  'putative bactoprenol-linked glucose translocase',
  2467855,
  2468217,
  1,
  'b2350',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2350'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdH',
  'bactoprenol glucosyl transferase',
  2468214,
  2469134,
  1,
  'b2351',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2351'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdI',
  'serotype-specific glucosyl transferase YfdI',
  2469131,
  2470462,
  1,
  'b2352',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2352'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yodE',
  'toxic protein YodE',
  2470497,
  2470643,
  -1,
  'b4780',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4780'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tfaS',
  '—',
  2470803,
  2471105,
  1,
  'b2353',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2353'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdK',
  'putative tail fiber assembly protein YfdK',
  2471077,
  2471517,
  -1,
  'b2354',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2354'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdL',
  '—',
  2471544,
  2472062,
  -1,
  'b2355',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2355'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdM',
  'putative methyltransferase YfdM',
  2472112,
  2472387,
  -1,
  'b2356',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2356'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdN',
  'uncharacterized protein YfdN',
  2472387,
  2472881,
  -1,
  'b2357',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2357'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdO',
  'protein YdfO',
  2472878,
  2473246,
  -1,
  'b2358',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2358'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdP',
  'uncharacterized protein YfdP',
  2473604,
  2473966,
  1,
  'b2359',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2359'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdQ',
  'DUF2303 domain-containing protein YfdQ',
  2474032,
  2474856,
  1,
  'b2360',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2360'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdR',
  '5''-deoxynucleotidase',
  2474984,
  2475520,
  1,
  'b2361',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2361'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdS',
  'protein YfdS',
  2475511,
  2475873,
  1,
  'b2362',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2362'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdT',
  'protein YfdT',
  2475873,
  2476178,
  1,
  'b2363',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2363'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypdJ',
  'putative uncharacterized protein YpdJ',
  2476094,
  2476234,
  1,
  'b4545',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4545'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'torI',
  'prophage CPS-53 recombination directionalityfactor and response regulator inhibitor',
  2476310,
  2476510,
  1,
  'b4501',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4501'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pawZ',
  '—',
  2476584,
  2476598,
  1,
  'b4643',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4643'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsdC',
  'DNA-binding transcriptional dual regulator DsdC',
  2476694,
  2477629,
  -1,
  'b2364',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2364'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsdX',
  'D-serine transporter',
  2477847,
  2479184,
  1,
  'b2365',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2365'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dsdA',
  'D-serine ammonia-lyase',
  2479202,
  2480530,
  1,
  'b2366',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2366'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'emrY',
  'tripartite efflux pump membrane subunit EmrY',
  2480638,
  2482176,
  -1,
  'b2367',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2367'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'emrK',
  'tripartite efflux pump membrane fusion proteinEmrK',
  2482176,
  2483339,
  -1,
  'b2368',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2368'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'evgL',
  'protein EvgL',
  2483729,
  2483758,
  1,
  'b4781',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4781'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'evgA',
  'DNA-binding transcriptional activator EvgA',
  2483755,
  2484369,
  1,
  'b2369',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2369'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'evgS',
  'sensor histidine kinase EvgS',
  2484374,
  2487967,
  1,
  'b2370',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2370'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdE',
  'acetyl-CoA:oxalate CoA-transferase',
  2488023,
  2489168,
  -1,
  'b2371',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2371'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdV',
  'putative transport protein YfdV',
  2489242,
  2490186,
  -1,
  'b2372',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2372'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'oxc',
  'oxalyl-CoA decarboxylase',
  2490256,
  2491950,
  -1,
  'b2373',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2373'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'frc',
  'formyl-CoA transferase',
  2492004,
  2493254,
  -1,
  'b2374',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2374'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdX',
  'protein YfdX',
  2493767,
  2494402,
  -1,
  'b2375',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2375'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypdI',
  'colanic acid synthesis putative lipoproteinYpdI',
  2494698,
  2494973,
  1,
  'b2376',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2376'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfdY',
  'DUF2545 domain-containing protein YfdY',
  2495050,
  2495292,
  -1,
  'b2377',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2377'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lpxP',
  'palmitoleoyl acyltransferase',
  2495645,
  2496565,
  1,
  'b2378',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2378'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypdK',
  'putative membrane protein YpdK',
  2496921,
  2496992,
  1,
  'b4680',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4680'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaC',
  'glutamate--pyruvate aminotransferase AlaC',
  2497057,
  2498295,
  -1,
  'b2379',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2379'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrS',
  'sensor histidine kinase PyrS',
  2498671,
  2500368,
  1,
  'b2380',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2380'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pyrR',
  'DNA-binding transcriptional activator PyrR',
  2500383,
  2501117,
  1,
  'b2381',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2381'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypdC',
  'putative AraC-type DNA-binding transcriptionalregulator YpdC',
  2501130,
  2501987,
  1,
  'b2382',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2382'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fryA',
  'putative PTS multiphosphoryl transfer proteinFryA',
  2501990,
  2504485,
  -1,
  'b2383',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2383'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypdE',
  'aminopeptidase YpdE',
  2504510,
  2505547,
  -1,
  'b2384',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2384'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypdF',
  'aminopeptidase YpdF',
  2505547,
  2506632,
  -1,
  'b2385',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2385'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fryC',
  'putative PTS enzyme IIC component FryC',
  2506647,
  2507894,
  -1,
  'b2386',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2386'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'fryB',
  'putative PTS enzyme IIB component FryB',
  2507916,
  2508242,
  -1,
  'b2387',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2387'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'glk',
  'glucokinase',
  2508461,
  2509426,
  -1,
  'b2388',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2388'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeO',
  'putative transport protein YfeO',
  2509630,
  2510886,
  1,
  'b2389',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2389'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypeC',
  'DUF2502 domain-containing protein YpeC',
  2511001,
  2511327,
  1,
  'b2390',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2390'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'mntH',
  'Mn(2(+)):H(+) symporter',
  2511468,
  2512706,
  -1,
  'b2392',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2392'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypeD',
  'protein YpeD',
  2512687,
  2512776,
  -1,
  'b4819',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4819'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nupC',
  'nucleoside:H(+) symporter NupC',
  2513042,
  2514244,
  1,
  'b2393',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2393'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'insL3',
  'putative IS186/IS421 transposase',
  2514331,
  2515443,
  1,
  'b2394',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2394'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdeA',
  'putative cyclic di-GMP phosphodiesterase PdeA',
  2515643,
  2517832,
  -1,
  'b2395',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2395'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaX',
  '—',
  2518041,
  2518116,
  -1,
  'b2396',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2396'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'alaW',
  '—',
  2518156,
  2518231,
  -1,
  'b2397',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2397'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeC',
  'DNA-binding transcriptional dual regulator YfeC',
  2518467,
  2518811,
  1,
  'b2398',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2398'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeD',
  'putative DNA-binding transcriptional regulatorYfeD',
  2518813,
  2519205,
  1,
  'b2399',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2399'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gltX',
  'glutamate--tRNA ligase',
  2519257,
  2520672,
  -1,
  'b2400',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2400'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'valU',
  '—',
  2520931,
  2521006,
  1,
  'b2401',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2401'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'valX',
  '—',
  2521051,
  2521126,
  1,
  'b2402',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2402'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'valY',
  '—',
  2521173,
  2521248,
  1,
  'b2403',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2403'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'lysV',
  '—',
  2521253,
  2521328,
  1,
  'b2404',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2404'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xapR',
  'DNA-binding transcriptional activator XapR',
  2521593,
  2522477,
  -1,
  'b2405',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2405'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xapB',
  'xanthosine:H(+) symporter XapB',
  2522729,
  2523985,
  -1,
  'b2406',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2406'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'xapA',
  'xanthosine phosphorylase',
  2524045,
  2524878,
  -1,
  'b2407',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2407'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeN',
  'putative outer membrane porin YfeN',
  2525127,
  2525891,
  1,
  'b2408',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2408'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeR',
  'putative DNA-binding transcriptional regulatorYfeR',
  2525930,
  2526856,
  -1,
  'b2409',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2409'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeH',
  'putative solute:Na(+) symporter',
  2526946,
  2527944,
  1,
  'b2410',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2410'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypeB',
  'PF12843 family protein YpeB',
  2527941,
  2528159,
  -1,
  'b4546',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4546'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ligA',
  'DNA ligase',
  2528161,
  2530176,
  -1,
  'b2411',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2411'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'zipA',
  'cell division protein ZipA',
  2530247,
  2531233,
  -1,
  'b2412',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2412'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysZ',
  'sulfate:H(+) symporter',
  2531463,
  2532224,
  1,
  'b2413',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2413'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysK',
  'cysteine synthase A',
  2532409,
  2533380,
  1,
  'b2414',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2414'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptsH',
  'phosphocarrier protein HPr',
  2533764,
  2534021,
  1,
  'b2415',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2415'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ptsI',
  'PTS enzyme I',
  2534066,
  2535793,
  1,
  'b2416',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2416'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'crr',
  'Enzyme IIA(Glc)',
  2535834,
  2536343,
  1,
  'b2417',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2417'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'pdxK',
  'pyridoxine/pyridoxal/pyridoxamine kinase',
  2536386,
  2537237,
  -1,
  'b2418',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2418'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeK',
  'DUF5329 domain-containing protein YfeK',
  2537342,
  2537716,
  1,
  'b2419',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2419'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeS',
  'PF05406 family protein YfeS',
  2537749,
  2538483,
  1,
  'b2420',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2420'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysM',
  'cysteine synthase B',
  2538672,
  2539583,
  -1,
  'b2421',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2421'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysA',
  'sulfate/thiosulfate ABC transporter ATP bindingsubunit',
  2539717,
  2540814,
  -1,
  'b2422',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2422'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysW',
  'sulfate/thiosulfate ABC transporter innermembrane subunit CysW',
  2540804,
  2541679,
  -1,
  'b2423',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2423'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysU',
  'sulfate/thiosulfate ABC transporter innermembrane subunit CysU',
  2541679,
  2542512,
  -1,
  'b2424',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2424'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'cysP',
  'thiosulfate/sulfate ABC transporter periplasmicbinding protein CysP',
  2542512,
  2543528,
  -1,
  'b2425',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2425'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ucpA',
  'oxidoreductase UcpA',
  2543832,
  2544623,
  -1,
  'b2426',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2426'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'murR',
  'DNA-binding transcriptional dual regulator MurR',
  2544752,
  2545609,
  -1,
  'b2427',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2427'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'murQ',
  'N-acetylmuramic acid 6-phosphate etherase',
  2545773,
  2546669,
  1,
  'b2428',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2428'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'murP',
  'N-acetylmuramic acid-specific PTS enzyme IICBcomponent/anhydro-N-acetylmuramic acid transporter',
  2546673,
  2548097,
  1,
  'b2429',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2429'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeW',
  'penicillin binding protein 4B',
  2548102,
  2549406,
  1,
  'b2430',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2430'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeX',
  'porphyrinogen peroxidase',
  2549646,
  2550545,
  -1,
  'b2431',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2431'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeY',
  'DUF1131 domain-containing lipoprotein YfeY',
  2550641,
  2551216,
  -1,
  'b2432',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2432'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfeZ',
  'putative inner membrane protein',
  2551277,
  2551726,
  -1,
  'b2433',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2433'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypeA',
  'putative acetyltransferase YpeA',
  2551713,
  2552138,
  -1,
  'b2434',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2434'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'amiA',
  'N-acetylmuramoyl-L-alanine amidase A',
  2552352,
  2553221,
  1,
  'b2435',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2435'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hemF',
  'coproporphyrinogen III oxidase',
  2553225,
  2554124,
  1,
  'b2436',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2436'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutR',
  'putative DNA-binding transcriptional regulatorEutR',
  2554130,
  2555182,
  -1,
  'b2437',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2437'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutK',
  'putative structural protein, ethanolamineutilization microcompartment',
  2555228,
  2555728,
  -1,
  'b2438',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2438'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutL',
  'putative structural protein, ethanolamineutilization microcompartment',
  2555741,
  2556400,
  -1,
  'b2439',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2439'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutC',
  'ethanolamine ammonia-lyase subunit beta',
  2556410,
  2557297,
  -1,
  'b2440',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2440'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutB',
  'ethanolamine ammonia-lyase subunit alpha',
  2557318,
  2558679,
  -1,
  'b2441',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2441'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'intZ',
  'putative phage integrase IntZ',
  2558858,
  2560066,
  1,
  'b2442',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2442'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffL',
  'uncharacterized protein YffL',
  2560257,
  2560898,
  1,
  'b2443',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2443'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffM',
  'uncharacterized protein YffM',
  2561368,
  2561613,
  1,
  'b2444',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2444'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffN',
  'uncharacterized protein YffN',
  2561625,
  2561993,
  1,
  'b2445',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2445'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffO',
  'uncharacterized protein YffO',
  2562111,
  2562527,
  1,
  'b2446',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2446'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffP',
  'uncharacterized protein YffP',
  2562524,
  2563117,
  1,
  'b2447',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2447'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffQ',
  'uncharacterized protein YffQ',
  2563592,
  2563969,
  1,
  'b2448',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2448'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffR',
  'uncharacterized protein YffR',
  2563980,
  2564372,
  1,
  'b2449',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2449'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffS',
  'uncharacterized protein YffS',
  2564523,
  2565332,
  1,
  'b2450',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2450'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutA',
  'ethanolamine ammonia-lyase reactivase EutA',
  2565481,
  2566884,
  -1,
  'b2451',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2451'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutH',
  'putative ethanolamine permease EutH',
  2566881,
  2568107,
  -1,
  'b2452',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2452'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutG',
  'putative alcohol dehydrogenase EutG',
  2568324,
  2569511,
  -1,
  'b2453',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2453'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutJ',
  'putative ethanolamine utilization chaperoninEutJ',
  2569501,
  2570337,
  -1,
  'b2454',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2454'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutE',
  'acetaldehyde dehydrogenase (acetylating) EutE',
  2570348,
  2571751,
  -1,
  'b2455',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2455'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutN',
  'putative ethanolamine catabolic microcompartmentshell protein EutN',
  2571763,
  2572050,
  -1,
  'b2456',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2456'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutM',
  'putative ethanolamine catabolic microcompartmentshell protein EutM',
  2572157,
  2572450,
  -1,
  'b2457',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2457'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutD',
  'phosphate acetyltransferase EutD',
  2572489,
  2573505,
  -1,
  'b2458',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2458'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutT',
  'putative ethanolamine utilization cobalaminadenosyltransferase',
  2573502,
  2574305,
  -1,
  'b2459',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2459'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutQ',
  'putative ethanolamine utilization acetate kinaseEutQ',
  2574302,
  2575003,
  -1,
  'b2460',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2460'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutP',
  'putative ethanolamine utilization acetate kinaseEutP',
  2574978,
  2575457,
  -1,
  'b2461',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2461'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'eutS',
  'putative ethanolamine catabolic microcompartmentshell protein EutS',
  2575470,
  2575805,
  -1,
  'b2462',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2462'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'maeB',
  'malate dehydrogenase(oxaloacetate-decarboxylating) (NADP(+))',
  2576098,
  2578377,
  -1,
  'b2463',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2463'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'talA',
  'transaldolase A',
  2578666,
  2579616,
  1,
  'b2464',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2464'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tktB',
  'transketolase 2',
  2579636,
  2581639,
  1,
  'b2465',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2465'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypfG',
  'DUF1176 domain-containing protein YpfG',
  2581734,
  2582777,
  -1,
  'b2466',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2466'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'nudK',
  'GDP-mannose hydrolase',
  2582903,
  2583478,
  -1,
  'b2467',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2467'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'aegA',
  'putative oxidoreductase AegA',
  2583546,
  2585525,
  -1,
  'b2468',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2468'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'narQ',
  'sensor histidine kinase NarQ',
  2585731,
  2587431,
  1,
  'b2469',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2469'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'acrD',
  'multidrug efflux pump RND permease AcrD',
  2587595,
  2590708,
  1,
  'b2470',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2470'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypfM',
  'uncharacterized protein YpfM',
  2590807,
  2590866,
  -1,
  'b4606',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4606'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yffB',
  'putative reductase YffB',
  2591247,
  2591603,
  1,
  'b2471',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2471'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dapE',
  'succinyl-diaminopimelate desuccinylase',
  2591607,
  2592734,
  1,
  'b2472',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2472'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypfN',
  'PF13980 family protein YpfN',
  2592762,
  2592962,
  1,
  'b4547',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b4547'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypfH',
  'esterase YpfH',
  2593072,
  2593770,
  -1,
  'b2473',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2473'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'tmcA',
  'tRNA(Met) cytidine acetyltransferase',
  2593844,
  2595859,
  -1,
  'b2474',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2474'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ypfJ',
  'uncharacterized protein YpfJ',
  2595874,
  2596737,
  -1,
  'b2475',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2475'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purC',
  'phosphoribosylaminoimidazole-succinocarboxamidesynthase',
  2596905,
  2597618,
  -1,
  'b2476',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2476'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bamC',
  'outer membrane protein assembly factor BamC',
  2597831,
  2598865,
  -1,
  'b2477',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2477'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'dapA',
  '4-hydroxy-tetrahydrodipicolinate synthase',
  2598882,
  2599760,
  -1,
  'b2478',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2478'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'gcvR',
  'transcriptional regulator GcvR',
  2599906,
  2600478,
  1,
  'b2479',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2479'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bcp',
  'thiol peroxidase',
  2600478,
  2600948,
  1,
  'b2480',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2480'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfA',
  'hydrogenase 4 component A',
  2601201,
  2601818,
  1,
  'b2481',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2481'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfB',
  'hydrogenase 4 component B',
  2601818,
  2603836,
  1,
  'b2482',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2482'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfC',
  'hydrogenase 4 component C',
  2603847,
  2604794,
  1,
  'b2483',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2483'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfD',
  'hydrogenase 4 component D',
  2604811,
  2606250,
  1,
  'b2484',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2484'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfE',
  'hydrogenase 4 component E',
  2606262,
  2606912,
  1,
  'b2485',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2485'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfF',
  'hydrogenase 4 component F',
  2606917,
  2608497,
  1,
  'b2486',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2486'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfG',
  'hydrogenase 4 catalytic subunit HyfG',
  2608487,
  2610154,
  1,
  'b2487',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2487'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfH',
  'hydrogenase 4 component H',
  2610164,
  2610709,
  1,
  'b2488',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2488'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfI',
  'hydrogenase 4 catalytic subunit HyfI',
  2610706,
  2611464,
  1,
  'b2489',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2489'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfJ',
  'putative hydrogenase 4 assembly protein',
  2611457,
  2611870,
  1,
  'b2490',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2490'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hyfR',
  'DNA-binding transcriptional activator HyfR',
  2611900,
  2613912,
  1,
  'b2491',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2491'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'focB',
  'formate channel FocB',
  2613934,
  2614782,
  1,
  'b2492',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2492'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgO',
  'putative transporter YfgO',
  2614820,
  2615881,
  -1,
  'b2493',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2493'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'bepA',
  'beta-barrel assembly-enhancing protease',
  2616094,
  2617557,
  1,
  'b2494',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2494'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'yfgD',
  'putative oxidoreductase YfgD',
  2617578,
  2617937,
  1,
  'b2495',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2495'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'hda',
  'inibitor of reinitiation of DNA replication',
  2618075,
  2618776,
  -1,
  'b2496',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2496'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'uraA',
  'uracil:H(+) symporter UraA',
  2618871,
  2620160,
  -1,
  'b2497',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2497'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'upp',
  'uracil phosphoribosyltransferase',
  2620246,
  2620872,
  -1,
  'b2498',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2498'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purM',
  'phosphoribosylformylglycinamide cyclo-ligase',
  2621197,
  2622234,
  1,
  'b2499',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2499'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'purN',
  'phosphoribosylglycinamide formyltransferase 1',
  2622234,
  2622872,
  1,
  'b2500',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2500'
);
INSERT INTO core_gene (genome_id, name, description, start, end, strand, locus_tag, gene_type)
SELECT
  (SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1),
  'ppk',
  'polyphosphate kinase',
  2623044,
  2625110,
  1,
  'b2501',
  'CDS'
WHERE NOT EXISTS (
  SELECT 1 FROM core_gene
  WHERE genome_id=(SELECT genome_id FROM core_genome WHERE genome_accession='NC_000913.3' LIMIT 1) AND locus_tag='b2501'
);
COMMIT;