// src/components/steps/Step3ExperimentalMethods.jsx
import { useState, useEffect } from "react";
import { runQuery } from "../../db/queryExecutor";
import { useCuration } from "../../context/CurationContext";

const QUICKGO_BASE = "https://www.ebi.ac.uk/QuickGO/services/ontology/eco/terms/";

function normalizeEco(raw) {
  let v = String(raw || "").trim().toUpperCase();
  if (!v) return "";
  if (!v.startsWith("ECO:")) v = "ECO:" + v;
  return v;
}

async function fetchEcoFromQuickGO(ecoId, { proxy = "" } = {}) {
  const id = normalizeEco(ecoId);
  if (!id) return null;

  const url = `${QUICKGO_BASE}${encodeURIComponent(id)}`;
  const res = await fetch(proxy ? proxy + encodeURIComponent(url) : url, {
    headers: { Accept: "application/json" },
  });

  if (!res.ok) return null;
  const json = await res.json();

  const term = json?.results?.[0];
  if (!term?.id) return null;

  return {
    id: term.id,
    name: term.name || "",
    definition:
      term.definition?.text ||
      term.definition ||
      "",
  };
}

export default function Step3ExperimentalMethods() {
  const { techniques, setTechniques, goToNextStep } = useCuration();

  const [ecoInput, setEcoInput] = useState("");
  const [validatedEco, setValidatedEco] = useState(null);
  const [ecoName, setEcoName] = useState("");
  const [existsInDB, setExistsInDB] = useState(null);

  // Create a new technique (category + description)
  const [categories, setCategories] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState("");
  const [techDescription, setTechDescription] = useState("");

  const [suggestions, setSuggestions] = useState([]);

  const [error, setError] = useState("");
  const [showCreateForm, setShowCreateForm] = useState(false);

  // Preset function (like CollecTF)
  const PRESET_FUNCTIONS = [
    { value: "Detection of binding", label: "Detection of binding" },
    { value: "Assessment of expression", label: "Assessment of expression" },
    { value: "In-silico prediction", label: "In-silico prediction" },
  ];

  const [presetFunction, setPresetFunction] = useState("");

  // Manual ECO code (new)
  const [newEcoCode, setNewEcoCode] = useState("");

  const PROXY = "https://corsproxy.io/?";
  const [quickGoTerm, setQuickGoTerm] = useState(null);
  const [validatingQuickGo, setValidatingQuickGo] = useState(false);


  function esc(str) {
    return String(str || "").replace(/'/g, "''");
  }

  // Normalize technique shape
  // - If string => ECO code
  // - If object => try common keys
  function getEcoId(t) {
    return typeof t === "string" ? t : t?.ecoId || t?.eco || t?.EO_term || t?.id || "";
  }

  // Load categories
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

  useEffect(() => {
    if (!showCreateForm) return;

    const id = normalizeEco(newEcoCode);
    setQuickGoTerm(null);

    // si está vacío, no validamos
    if (!id) return;

    let cancelled = false;
    setValidatingQuickGo(true);
    setError("");

    const t = setTimeout(async () => {
      try {
        const term = await fetchEcoFromQuickGO(id, { proxy: PROXY });
        if (cancelled) return;

        if (!term) {
          setQuickGoTerm(null);
          setError(`ECO code not found in QuickGO: ${id}`);
        } else {
          setQuickGoTerm(term);
          setError("");
        }
      } catch (e) {
        if (cancelled) return;
        setQuickGoTerm(null);
        setError("Error contacting QuickGO for ECO validation.");
      } finally {
        if (!cancelled) setValidatingQuickGo(false);
      }
    }, 400); // pequeño debounce para no spamear la API

    return () => {
      cancelled = true;
      clearTimeout(t);
    };
  }, [newEcoCode, showCreateForm]);

  // Autocomplete (by name or ECO code)
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

  // Select existing technique from autocomplete
  function selectExisting(ecoCode, name) {
    setEcoInput(ecoCode);
    setValidatedEco(ecoCode);
    setEcoName(name);
    setExistsInDB(true);
    setShowCreateForm(false);
    setSuggestions([]);
    setError("");
  }

  // Add existing technique to curation
  function handleAddExisting() {
    if (!validatedEco) return;

    const exists = techniques.some((t) => getEcoId(t) === validatedEco);
    if (exists) {
      setError("This ECO code is already added to the curation.");
      return;
    }

    // Store BOTH ecoId + name (so Step5 can display names/columns)
    setTechniques([...techniques, { ecoId: validatedEco, name: ecoName }]);

    setValidatedEco(null);
    setEcoInput("");
    setError("");
  }

  // Open manual create form
  function handleAddTechnique() {
    setError("");
    setShowCreateForm(true);

    setValidatedEco(null);
    setExistsInDB(false);
    setTechDescription("");
    setSelectedCategory("");
    setNewEcoCode("");
    setPresetFunction("");
  }

  // Create a new technique manually
  async function handleCreateEco() {
    setError("");

    const raw = normalizeEco(newEcoCode);
    if (!raw) {
      setError("Please enter an ECO code.");
      return;
    }

    // 1) Debe existir en QuickGO
    // (si aún no está cargado, intenta buscarlo aquí también)
    let term = quickGoTerm;
    if (!term || term.id !== raw) {
      setValidatingQuickGo(true);
      term = await fetchEcoFromQuickGO(raw, { proxy: PROXY });
      setValidatingQuickGo(false);
    }

    if (!term) {
      setError(`This ECO code does not exist in QuickGO: ${raw}`);
      return;
    }

    // 2) No duplicados en la curation actual
    const exists = techniques.some((t) => getEcoId(t) === raw);
    if (exists) {
      setError("This ECO code is already added to the curation.");
      return;
    }

    // 3) Campos internos tuyos (siguen igual)
    if (!presetFunction) {
      setError("Please select a preset function.");
      return;
    }
    if (!selectedCategory) {
      setError("Please select a category.");
      return;
    }

    // 4) Insert a DB (IMPORTANTE: name NO NULL)
    const presetValue = presetFunction ? `'${esc(presetFunction)}'` : "NULL";

    // Si el usuario no pone descripción, usa la definición de QuickGO como fallback
    const finalDesc =
      String(techDescription || "").trim() ||
      String(term.definition || "").trim() ||
      "—";

    // 5) Guardar en contexto (con nombre oficial QuickGO)
    setTechniques([
      ...techniques,
      { ecoId: raw, name: term.name || raw, description: finalDesc },
    ]);

    // limpiar UI
    setShowCreateForm(false);
    setNewEcoCode("");
    setTechDescription("");
    setSelectedCategory("");
    setPresetFunction("");
    setQuickGoTerm(null);
    setError("");
  }

  // Remove technique
  function handleRemoveTechnique(index) {
    const updated = techniques.filter((_, i) => i !== index);
    setTechniques(updated);
  }

  return (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Step 3 – Experimental Methods</h2>

      {/* INPUT + Add technique button */}
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

        {/* Autocomplete */}
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

        {/* Error message */}
        {error && <p className="text-red-400 text-sm mt-2">{error}</p>}
      </div>

      {/* Existing ECO selected */}
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

      {/* Manual create form */}
      {showCreateForm && (
        <div className="p-4 bg-surface border border-border rounded space-y-3">
          <h3 className="text-lg font-semibold">Create new experimental technique</h3>

          {/* ECO code manual */}
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

          {/* Preset function */}
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

          {/* Category */}
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

          {/* Description */}
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

      {/* List */}
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
