// src/components/steps/Step3ExperimentalMethods.jsx
import { useEffect, useState } from "react";
import { runQuery } from "../../db/queryExecutor";
import { useCuration } from "../../context/CurationContext";

const QUICKGO_BASE = "https://www.ebi.ac.uk/QuickGO/services/ontology/eco/terms/";
const PROXY = "https://corsproxy.io/?";

const PRESET_FUNCTIONS = [
  { value: "Detection of binding", label: "Detection of binding" },
  { value: "Assessment of expression", label: "Assessment of expression" },
  { value: "In-silico prediction", label: "In-silico prediction" },
];

function normalizeEco(raw) {
  let v = String(raw || "").trim().toUpperCase();
  if (!v) return "";
  if (!v.startsWith("ECO:")) v = "ECO:" + v;
  return v;
}

function proxify(url, proxyKind) {
  const enc = encodeURIComponent(url);

  if (proxyKind === "direct") return url;
  if (proxyKind === "allorigins") return `https://api.allorigins.win/raw?url=${enc}`;
  if (proxyKind === "isomorphic") return `https://cors.isomorphic-git.org/${url}`;
  if (proxyKind === "corsproxy") return `${PROXY}${enc}`;

  return url;
}

// Fem fetch amb alternatives perquè QuickGO sovint peta per CORS/403 segons proxy
async function fetchWithFallback(url, { timeoutMs = 12000 } = {}) {
  const proxyOrder = ["direct", "allorigins", "isomorphic", "corsproxy"];
  let lastErr = null;

  for (const proxy of proxyOrder) {
    const finalUrl = proxify(url, proxy);
    const ctrl = new AbortController();
    const t = setTimeout(() => ctrl.abort(), timeoutMs);

    try {
      const res = await fetch(finalUrl, {
        method: "GET",
        signal: ctrl.signal,
        headers: { Accept: "application/json" },
      });

      clearTimeout(t);

      if (!res.ok) {
        lastErr = new Error(`HTTP ${res.status} (${proxy})`);
        continue;
      }

      const json = await res.json();
      return json;
    } catch (e) {
      clearTimeout(t);
      lastErr = e;
      continue;
    }
  }

  throw lastErr || new Error("No s'ha pogut fer la petició (tots els proxys han fallat).");
}

async function fetchEcoFromQuickGO(ecoId) {
  const id = normalizeEco(ecoId);
  if (!id) return null;

  const url = `${QUICKGO_BASE}${encodeURIComponent(id)}`;

  try {
    const json = await fetchWithFallback(url);
    const term = json?.results?.[0];
    if (!term?.id) return null;

    return {
      id: term.id,
      name: term.name || "",
      definition: term.definition?.text || term.definition || "",
    };
  } catch {
    return null;
  }
}

// Per llegir ECO igual tant si guardem string com objecte
function getEcoId(t) {
  return typeof t === "string" ? t : t?.ecoId || t?.eco || t?.EO_term || t?.id || "";
}

export default function Step3ExperimentalMethods() {
  const { techniques, setTechniques, goToNextStep } = useCuration();

  const [ecoInput, setEcoInput] = useState("");
  const [suggestions, setSuggestions] = useState([]);

  const [validatedEco, setValidatedEco] = useState(null);
  const [ecoName, setEcoName] = useState("");
  const [existsInDB, setExistsInDB] = useState(null);

  const [categories, setCategories] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState("");
  const [techDescription, setTechDescription] = useState("");
  const [presetFunction, setPresetFunction] = useState("");

  const [showCreateForm, setShowCreateForm] = useState(false);
  const [newEcoCode, setNewEcoCode] = useState("");

  const [quickGoTerm, setQuickGoTerm] = useState(null);
  const [validatingQuickGo, setValidatingQuickGo] = useState(false);

  const [error, setError] = useState("");

  // Categories del desplegable (DB)
  useEffect(() => {
    async function fetchCategories() {
      const rows = await runQuery(`
        SELECT category_id, name
        FROM core_experimentaltechniquecategory
        ORDER BY name ASC
      `);
      setCategories(rows);
    }
    fetchCategories();
  }, []);

  // Quan escrius un ECO nou al formulari, el validem amb QuickGO
  useEffect(() => {
    if (!showCreateForm) return;

    const id = normalizeEco(newEcoCode);
    setQuickGoTerm(null);

    if (!id) return;

    let cancelled = false;
    setValidatingQuickGo(true);
    setError("");

    const t = setTimeout(async () => {
      try {
        const term = await fetchEcoFromQuickGO(id);
        if (cancelled) return;

        if (!term) {
          setQuickGoTerm(null);
          setError(`ECO code not found in QuickGO: ${id}`);
        } else {
          setQuickGoTerm(term);
          setError("");
        }
      } catch {
        if (cancelled) return;
        setQuickGoTerm(null);
        setError("Error contacting QuickGO for ECO validation.");
      } finally {
        if (!cancelled) setValidatingQuickGo(false);
      }
    }, 400);

    return () => {
      cancelled = true;
      clearTimeout(t);
    };
  }, [newEcoCode, showCreateForm]);

  // Autocomplete: per nom o per codi ECO (DB)
  async function handleAutocomplete(val) {
    setEcoInput(val);
    setValidatedEco(null);
    setExistsInDB(null);
    setShowCreateForm(false);
    setError("");

    if (!val) {
      setSuggestions([]);
      return;
    }

    const rows = await runQuery(
      `
      SELECT EO_term, name
      FROM core_experimentaltechnique
      WHERE LOWER(name) LIKE LOWER(? || '%')
         OR LOWER(EO_term) LIKE LOWER(? || '%')
      ORDER BY name ASC
      `,
      [val, val]
    );

    setSuggestions(rows);
  }

  function selectExisting(ecoCode, name) {
    setEcoInput(ecoCode);
    setValidatedEco(ecoCode);
    setEcoName(name);
    setExistsInDB(true);
    setShowCreateForm(false);
    setSuggestions([]);
    setError("");
  }

  function handleAddExisting() {
    if (!validatedEco) return;

    const exists = techniques.some((t) => getEcoId(t) === validatedEco);
    if (exists) {
      setError("This ECO code is already added to the curation.");
      return;
    }

    // Guardem ecoId + name perquè a Step5 quedi bé a les columnes
    setTechniques([...techniques, { ecoId: validatedEco, name: ecoName }]);

    setValidatedEco(null);
    setEcoInput("");
    setError("");
  }

  function handleAddTechnique() {
    setError("");
    setShowCreateForm(true);

    setValidatedEco(null);
    setExistsInDB(false);

    setTechDescription("");
    setSelectedCategory("");
    setNewEcoCode("");
    setPresetFunction("");
    setQuickGoTerm(null);
  }

  async function handleCreateEco() {
    setError("");

    const raw = normalizeEco(newEcoCode);
    if (!raw) {
      setError("Please enter an ECO code.");
      return;
    }

    // Si per timing encara no hi és, fem una última validació directa
    let term = quickGoTerm;
    if (!term || term.id !== raw) {
      setValidatingQuickGo(true);
      term = await fetchEcoFromQuickGO(raw);
      setValidatingQuickGo(false);
    }

    if (!term) {
      setError(`This ECO code does not exist in QuickGO: ${raw}`);
      return;
    }

    // Evitem duplicats dins la curation actual
    const exists = techniques.some((t) => getEcoId(t) === raw);
    if (exists) {
      setError("This ECO code is already added to the curation.");
      return;
    }

    if (!presetFunction) {
      setError("Please select a preset function.");
      return;
    }
    if (!selectedCategory) {
      setError("Please select a category.");
      return;
    }

    const finalDesc =
      String(techDescription || "").trim() ||
      String(term.definition || "").trim() ||
      "—";

    setTechniques([
      ...techniques,
      { ecoId: raw, name: term.name || raw, description: finalDesc },
    ]);

    // Neteja del formulari
    setShowCreateForm(false);
    setNewEcoCode("");
    setTechDescription("");
    setSelectedCategory("");
    setPresetFunction("");
    setQuickGoTerm(null);
    setError("");
  }

  function handleRemoveTechnique(index) {
    const updated = techniques.filter((_, i) => i !== index);
    setTechniques(updated);
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Step 3 – Experimental Methods</h2>

      <div>
        <label className="block font-medium">Enter ECO code or name</label>

        <div className="flex gap-2">
          <input
            className="form-control flex-1"
            placeholder="Example: ECO:0005667 or ChIP-Seq"
            value={ecoInput}
            onChange={(e) => handleAutocomplete(e.target.value)}
          />

          <button className="btn" type="button" onClick={handleAddTechnique}>
            + Add technique
          </button>
        </div>

        {suggestions.length > 0 && (
          <div className="border border-border p-2 bg-surface rounded mt-1">
            {suggestions.map((s) => (
              <div
                key={s.EO_term}
                className="p-1 hover:bg-muted cursor-pointer"
                onClick={() => selectExisting(s.EO_term, s.name)}
              >
                {s.name} ({s.EO_term})
              </div>
            ))}
          </div>
        )}

        {error && <p className="text-red-400 text-sm mt-2">{error}</p>}
      </div>

      {validatedEco && existsInDB === true && (
        <div className="p-4 bg-surface border border-border rounded">
          <p>
            <strong>{ecoName}</strong> ({validatedEco})
          </p>
          <button className="btn mt-2" type="button" onClick={handleAddExisting}>
            Add to curation
          </button>
        </div>
      )}

      {showCreateForm && (
        <div className="p-4 bg-surface border border-border rounded space-y-3">
          <h3 className="text-lg font-semibold">Create new experimental technique</h3>

          <div>
            <label className="block font-medium">ECO code</label>
            <input
              className="form-control"
              placeholder="Example: ECO:1234567"
              value={newEcoCode}
              onChange={(e) => setNewEcoCode(e.target.value)}
            />
          </div>

          {validatingQuickGo && (
            <p className="text-xs text-muted">Validating ECO in QuickGO...</p>
          )}

          {quickGoTerm && (
            <div className="text-xs text-emerald-300">
              Found in QuickGO: {quickGoTerm.name} ({quickGoTerm.id})
            </div>
          )}

          <div>
            <label className="block font-medium">Preset function</label>
            <select
              className="form-control"
              value={presetFunction}
              onChange={(e) => setPresetFunction(e.target.value)}
            >
              <option value="">---------</option>
              {PRESET_FUNCTIONS.map((p) => (
                <option key={p.value} value={p.value}>
                  {p.label}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block font-medium">Category</label>
            <select
              className="form-control"
              value={selectedCategory}
              onChange={(e) => setSelectedCategory(e.target.value)}
            >
              <option value="">Select a category...</option>
              {categories.map((c) => (
                <option key={c.category_id} value={c.category_id}>
                  {c.name}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block font-medium">Description</label>
            <textarea
              className="form-control"
              value={techDescription}
              onChange={(e) => setTechDescription(e.target.value)}
            />
          </div>

          <button
            className="btn"
            type="button"
            onClick={handleCreateEco}
            disabled={validatingQuickGo || !quickGoTerm}
            title={!quickGoTerm ? "Enter a valid ECO code that exists in QuickGO" : ""}
          >
            Save new technique
          </button>
        </div>
      )}

      <div>
        <h3 className="font-semibold mt-4">Added techniques:</h3>
        {techniques.length === 0 && <p>None yet.</p>}

        <ul className="list-disc pl-6">
          {techniques.map((t, i) => {
            const ecoId = getEcoId(t);
            const name = typeof t === "string" ? "" : t?.name || "";
            return (
              <li key={i} className="list-item">
                <div className="flex items-center gap-2">
                  {typeof t === "string" ? ecoId : `${ecoId} — ${name}`}

                  <button
                    type="button"
                    onClick={() => handleRemoveTechnique(i)}
                    className="text-red-400 hover:text-red-300"
                    title="Remove"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.8}
                      stroke="currentColor"
                      className="w-5 h-5"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M6 7h12M9 7V4h6v3m-8 4h10l-1 9H8l-1-9z"
                      />
                    </svg>
                  </button>
                </div>
              </li>
            );
          })}
        </ul>
      </div>

      {techniques.length > 0 && (
        <button className="btn mt-4" type="button" onClick={goToNextStep}>
          Confirm and continue →
        </button>
      )}
    </div>
  );
}
