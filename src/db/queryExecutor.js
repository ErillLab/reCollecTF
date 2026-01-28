import { dbWorkerPromise } from "./dbClient";

export async function runQuery(sql, params = []) {
  const worker = await dbWorkerPromise;
  return worker.db.query(sql, params);
}
