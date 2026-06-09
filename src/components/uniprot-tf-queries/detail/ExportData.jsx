import { useParams, useNavigate, Link } from "react-router-dom";
import { useEffect, useState } from "react";

export default function ExportData(data) {
  const navigate = useNavigate();
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    try {
      setLoading(false)
    }
    catch {
      setError(true);
    }
  }, [navigate]);

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;
 // Cal fer funcionalitats per descarregar formats a cada descarrega corresponents
  return (
    <>
      <lu>
        <li> 
          <Link className="text-accent hover:underline">
            Download FASTA:
          </Link>  Download data in FASTA format. <br />
        </li> 
        <li> 
          <Link className="text-accent hover:underline">
            Download Spreadsheet(TSV):
          </Link>  Download data in TSV (tab-separated-value) format. For each binding site, all sources of evidence (i.e. experimental techniques and publication information) are combined into one record. <br />
        </li> 
        <li> 
          <Link className="text-accent hover:underline">
            Download Spreadsheet(TSV, raw):
          </Link>  Download raw data in TSV format. All reported sites are exported individually. <br />
        </li> 
        <li> 
          <Link className="text-accent hover:underline">
            Download ARFF:
          </Link>  Download data in Attribute-Relation File Format (ARFF). <br />
        </li>
        <li>  
          <Link className="text-accent hover:underline">
            Download PSFM(TRANSFAC):
          </Link>  Download Position-Specific-Frequency-Matrix of the motif in TRANSFAC format. <br />
        </li>
        <li>  
          <Link className="text-accent hover:underline">
           Download PSFM(JASPAR):
          </Link>  Download Position-Specific-Frequency-Matrix of the motif in JASPAR format. <br />
        </li>
        <li>  
          <Link className="text-accent hover:underline">
            Download PSFM(raw-FASTA):
          </Link>  Download Position-Specific-Frequency-Matrix of the motif in raw FASTA format. The matrix consists of four columns in the order A C G T. <br />
        </li> 
      </lu>
    </>
  );
}