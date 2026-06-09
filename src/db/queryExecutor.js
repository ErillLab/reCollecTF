import { dbWorkerPromise } from "./dbClient.js";

export default async function runQuery(sql, params = []) {
  const worker = await dbWorkerPromise;
  return worker.db.query(sql, params);
}


/*
import { initDb } from "./dbClient.js";

export async function runQuery(sql, params = []) {

    try {
        const db = await initDb();
        return db.db.query(sql, params);
    }
    catch (error) {
        console.error("Error running query:", error);
        throw error;
    }
}
    */