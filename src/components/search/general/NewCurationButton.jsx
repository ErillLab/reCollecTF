import { useNavigate } from "react-router-dom";

export default function NewCurationButton() {
  const navigate = useNavigate();

  return (
    <button type="button" className="btn" onClick={() => navigate("/curation-pipeline")}>
      NEW CURATION
    </button>   
  );
}
