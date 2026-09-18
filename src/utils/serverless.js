const dispatchUrl = "https://recollectf2.vercel.app/api/functions/send-form.ts" //  "http://localhost:3000/api/auth/functions/send-form.ts"
const BASE_URL = "https://recollectf2.vercel.app/api/functions/"
import { getMaxTfInstanceId } from "../db/queries/uniprotQueries";
import { expressionIdFromTfInstanceId } from "../../src/utils/tfIdConverterToExpressionId";

export async function dispatchWorkflow(data) {

    console.log("Data to dispatch:", data);
    
    const res = await fetch(dispatchUrl, {
        method: 'POST',
        headers: {
        'Content-Type': 'application/json',
        },
        credentials: 'include',    
        body: JSON.stringify(data),
    });

    return await res;
}

// Diferentiated dispatches for use in pipeline or outside. Main difference is different return format and error control
export async function dispatchWorkflowPipe(data) {
  console.log("Data to dispatch:", data);

  const res = await fetch(dispatchUrl, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    credentials: "include",
    body: JSON.stringify(data),
  });

  const text = await res.text();
  let payload;
  try {
    payload = text ? JSON.parse(text) : null;
  } catch {
    payload = text;
  }

  if (!res.ok) {
    const err = new Error(`Dispatch failed (${res.status})`);
    err.payload = payload;
    throw err;
  }

  return payload;
}

// htmlContent - index.html content / tf_instance_id - TF_instance id from DB 
// uniprotAccession - uniprot code for that gene / expressionInfo - bool that defines if curation contains experimentally verified data
export async function createUniprotAccessionFile(htmlContent, tf_instance_id, uniprotAccession, expressionInfo) {
  const expressionId = expressionIdFromTfInstanceId(tf_instance_id); //+1 to generate the next tfId

  const res = await fetch("https://recollectf2.vercel.app/api/functions/create-expression-page", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    credentials: "include",
    body: JSON.stringify({ expressionId, htmlContent,expressionInfo, uniprotAccession }),
  });

  const text = await res.text();
  let payload;
  try {
    payload = text ? JSON.parse(text) : null;
  } catch {
    payload = text;
  }

  if (!res.ok) {
    const err = new Error(`Create expression page failed (${res.status})`);
    err.payload = payload;
    throw err;
  }

  return payload;
}

export async function dispatchAndCreate(data, htmlContent, tf_instance_id, uniprotAccession, expressionInfo) {
  const expressionId = expressionIdFromTfInstanceId(tf_instance_id);
  const BASE_URL = "https://recollectf2.vercel.app/api/functions";

  const res = await fetch(`${BASE_URL}/dispatch-and-create`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    credentials: "include",
    body: JSON.stringify({
      inputs: data.inputs,
      expressionId,
      htmlContent,
      expressionInfo,
      uniprotAccession,
    }),
  });

  const text = await res.text();
  let payload;
  try { payload = text ? JSON.parse(text) : null; } catch { payload = text; }

  if (!res.ok) {
    const err = new Error(`Dispatch and create failed (${res.status})`);
    err.payload = payload;
    throw err;
  }

  return payload;
}