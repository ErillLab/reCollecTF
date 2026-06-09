import { useNavigate, useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import Result from "./common/Result";
import { getSearchResult } from "../../../db/queries/search";
import { getQuerySplitView } from "../../../db/queries/uniprotQueries";
//expressionId
export default function DetailedView({  }) {
  const navigate = useNavigate();
const { expressionId } = useParams();
  const [data, setData] = useState(null);
  const [dataSV, setDataSV] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  function handleLogoClick() {
    navigate('/');
  }

  useEffect(() => {
    if (!expressionId || !/^EXPREG_[a-f0-9A-F]+$/.test(expressionId)) {
      console.log("No ha funcionat");
      navigate('/');
      return;
    }

    let tf_id = expressionId.replace('EXPREG_', '');
    const tf_id_parsed = parseInt(tf_id.slice(2, -1), 16);

    async function getData() {
      try {
        const localData = await getSearchResult(tf_id_parsed);
        const localDataSV = await getQuerySplitView(tf_id_parsed);
        setData(localData);
        setDataSV(localDataSV);
      } catch (e) {
        setError("Ha ocurrido un error al cargar los datos.");
      } finally {
        setLoading(false);
      }
    }

    getData();
  }, [expressionId]);

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      <header className="flex justify-between items-center bg-surface px-8 py-4 border-b border-border">
        <h1 className="text-5xl font-bold text-accent cursor-pointer hover:text-text" onClick={handleLogoClick}>
          <Link className="text-accent hover:underline" to="https://collectf.org/">CollecTF</Link>
        </h1>
      </header> <br/> <br/>
      <main>
        {dataSV && dataSV.length > 0 && (
          <>
            <b>{dataSV[0].name}: </b>
            <p>
              <Link
                className="text-accent hover:underline"
                to={`https://www.uniprot.org/uniprotkb/${dataSV[0].accession}/entry`}
              >
                UniProtKB: {dataSV[0].accession}
              </Link>
              {" "}regulon and binding site collection of {dataSV[0].species}:
            </p>
            <br/>
            <Result result={data}/>
          </>
        )}
      </main>
    </>
  );
}