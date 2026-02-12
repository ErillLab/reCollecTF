// src/utils/serverless.js
const dispatchUrl = "https://recollectf.vercel.app/api/functions/send-form";

export async function dispatchWorkflow(data) {
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