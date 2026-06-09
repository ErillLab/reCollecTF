import { createDbWorker } from "sql.js-httpvfs";

const isNode = typeof Worker === "undefined";

// Use Vite base so files in `public/` are resolved both in dev and production
const base = import.meta.env && import.meta.env.BASE_URL ? import.meta.env.BASE_URL : "/";
const workerUrl = `${base}sqlite.worker.js`;
const wasmUrl = `${base}sql-wasm.wasm`;

function runSqlJsQuery(db, sql, params = []) {
  const stmt = db.prepare(sql);
  if (params.length) stmt.bind(params);

  const rows = [];
  while (stmt.step()) {
    rows.push(stmt.getAsObject());
  }
  stmt.free();
  return rows;
}

async function loadNodeDatabase() {
  const [{ default: initSqlJs }, fs, zlib] = await Promise.all([
    import("sql.js"),
    import("node:fs/promises"),
    import("node:zlib"),
  ]);

  const SQL = await initSqlJs({
    locateFile: (file) => new URL(`../../node_modules/sql.js/dist/${file}`, import.meta.url).href,
  });

  const gzPath = new URL("../../public/CollecTF.db.gz", import.meta.url);
  const compressed = await fs.readFile(gzPath);
  const sqliteBytes =
    compressed.length >= 2 && compressed[0] === 0x1f && compressed[1] === 0x8b
      ? zlib.gunzipSync(compressed)
      : compressed;
  const db = new SQL.Database(sqliteBytes);

  return {
    db: {
      query: (sql, params = []) => runSqlJsQuery(db, sql, params),
    },
  };
}

export const dbWorkerPromise = isNode
  ? loadNodeDatabase()
  : createDbWorker(
      [
        {
          from: "inline",
          config: {
            serverMode: "full",
            url: `${base}CollecTF.db.gz`,
            requestChunkSize: 4096,
          },
        },
      ],
      workerUrl,
      wasmUrl,
      10 * 1024 * 1024
    );

