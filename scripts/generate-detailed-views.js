import fs from "fs";
import readline from "readline";
import { tfInstanceFromExpression } from "../src/utils/tfIdConverterToExpressionId.js"; 
import path from "path";
import { generateExpressionHTML } from "../src/components/uniprot-tf-queries/generateExpressionHTML.js";
import { getAllTfInstanceIds } from "../src/db/queries/uniprotQueries.js";

// This script is intended to be used ONLY by being called with "npm run generate-reports" profile,
// "expregFilePath" is a file with a single column with an "EXPREG_XXXXXXX0" format id on each row
// Example:
//
//  EXPREG_00000030
//  ...
//  EXPREG_00000050

const publicDir = path.resolve("public");
const expregFilePath = "";

function expressionIdFromTfInstanceId(tfInstanceId) {
  const hex = tfInstanceId
    .toString(16)
    .toUpperCase()
    .padStart(7, "0");
  return `EXPREG_${hex}0`;
}

async function getTfFromXRef() {
  const results = [];

  const rl = readline.createInterface({
    input: fs.createReadStream(expregFilePath), 
    terminal: false
  });

  return new Promise((resolve, reject) => {
    rl.on('line', (line) => {
      if (line.trim() !== '') {
        results.push(tfInstanceFromExpression(line.trim()));
      }
    });

    rl.on('close', () => {
      console.log(results);
      resolve(results);
    });

    rl.on('error', reject);
  });
}

async function main() {
  const tfIds = await getTfFromXRef();
  let count = 0;
  const successfulIds = new Set(); // Afegim els que han creat les pàgines correctament

  for (const tfId of tfIds) {
    const expressionId = expressionIdFromTfInstanceId(tfId);
    try {
      const html = await generateExpressionHTML(expressionId);
      const expressionDir = path.join(publicDir, expressionId);
      if (!fs.existsSync(expressionDir)) fs.mkdirSync(expressionDir, { recursive: true });
      fs.writeFileSync(path.join(expressionDir, "index.html"), html, "utf-8");
      successfulIds.add(expressionId);
      count++;
      console.log(`✅ ${expressionId}`);
    } catch (error) {
      console.log(`⚠️  ${expressionId}: ${error.message}`);
    }
  }

  console.log(`\n ${count} páginas generadas en ${publicDir}`);
}

main().catch((error) => { console.error(error); process.exit(1); });