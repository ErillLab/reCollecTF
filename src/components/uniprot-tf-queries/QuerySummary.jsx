import { useParams, useNavigate, Route, Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { getQueryDataSummary } from "../../db/queries/uniprotQueries";
import { getQueryDataSummaryGenome } from "../../db/queries/uniprotQueries";


//This component can be used as an alternative landing page
// it intends to copy the original collecTF landing page
// To make this componens usable you only need to make a random EXPREG_ id 
// get selected to use on the Detail page. ;)
export default function QuerySummary() {
  const { expressionId } = useParams();
  const navigate = useNavigate();
  const [data, setData] = useState(null);
  const [uniqueData, setUniqueData] = useState(null);

  const [tf_instance_id, setTfInstance] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Validem format EXPREG_XXXXXX
    try {
      if (!expressionId || !/^EXPREG_[a-f0-9A-F]+$/.test(expressionId)) {
        // Potser cal canviar a missatge error, preguntar.
        navigate('/');
        return;
      }
      //Tractem per tenir cadena de ints
      var tf_instance_id = expressionId.replace('EXPREG_', '');

      //Cadena només de ints ja util per consultar BD
      tf_instance_id = parseInt(tf_instance_id.slice(2, -1), 16);
      setTfInstance(tf_instance_id);

      // Agafem dades de la BD
      async function fetchData() {
        try {
          const summary = await getQueryDataSummary(tf_instance_id);
          setData(summary);

          const genome = await getQueryDataSummaryGenome(summary[0].curation_id);
          setUniqueData(genome);

        } catch (err) {
          setError(err);
        } finally {
          setLoading(false);
        }
      }

      fetchData()
    }
    catch {
      setError(true);
    }
  }, [expressionId, navigate]);

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error.message}</div>;

  return (
    <div>
        <div>
            <h5 >
                Welcome to CollecTF!
            </h5> <br/>
            <p>
                CollecTF is a database of transcription factor binding sites (TFBS) in the Bacteria domain. It aims at becoming a reference, highly-accessed database by relying on its ability to customize navigation and data extraction, its relevance to the community, the quality and detail of the stored data and the up-to-date nature of the stored information.
            </p> <br/>
        </div>
          
        <div>
          <h4>
            A record from CollecTF | <Link to={`/uniprot/${tf_instance_id}`} className="text-accent hover:underline"> View full record </Link>
          </h4> <br/>
          <ul>
            <li>
              <strong>
                Transcription factor:
              </strong> {" "} 
              {data[0].tf_name}
            </li>
            <li>
              <strong>
                Protein record at UniProtKB:
              </strong> {" "} 
              <Link to={`http://www.uniprot.org/uniprot/${data[0].uniprot_accession}`} className="text-accent hover:underline"> {data[0].uniprot_accession} </Link>
            </li>
            {uniqueData.map((row, i) => (
              <li key={i}>
                <strong>
                  Species:
                </strong> {row.site_species} <br />
                <strong>
                  Genome record at NCBI:
                </strong> {" "} 
                <Link to={`http://www.ncbi.nlm.nih.gov/nuccore/?term=${row.ncbi_accession}`} className="text-accent hover:underline"> {row.ncbi_accession} </Link>  <br />
              </li>
            ))}
          </ul>
        </div>
    </div>
  );
}