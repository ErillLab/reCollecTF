import { useNavigate } from "react-router-dom";

export default function NewCurationButton({userStatus }) {
  const navigate = useNavigate();

  return (
    <button type="button" className="btn" onClick={() => navigate("/curation-pipeline")} disabled={userStatus != 2}>
      NEW CURATION
    </button>   
  );
}
