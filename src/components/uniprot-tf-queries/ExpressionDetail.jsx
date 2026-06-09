import { useParams, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import SplitView from "./detail/SplitView";
import EnsembleView from "./detail/EnsembleView";
import ExportData from "./detail/ExportData";
//import {getQueryDataUniprot} from "../../db/queries/uniprotQueries";

export default function ExpressionDetail() {
  const { expressionId } = useParams();
  const navigate = useNavigate();
  const [tf_instance_id, setTfInstance] = useState(null)
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [tabValue, setTabValue] = useState(0);

  useEffect(() => {
    async function fetchData() {
      if (!expressionId || !/^EXPREG_[a-f0-9A-F]+$/.test(expressionId)) {
        // Potser cal canviar a missatge error, preguntar.
        navigate('/');
        return;
      }
      //Tractem per tenir cadena de ints
      var id = expressionId.replace('EXPREG_', '');

      //Cadena només de ints ja util per consultar BD
      id = parseInt(id.slice(2, -1), 16);
      setTfInstance(id);

      setLoading(false)
    }

    fetchData();
  }, [expressionId, navigate]);

const handleChange = (event, newValue) => {
  setTabValue(newValue);
};

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      <Tabs value={tabValue} onChange={handleChange}>
        <Tab label = 'Split View' sx={{color:"white"}}/>
        <Tab label = 'Export Data' sx={{color:"white"}}/>
      </Tabs>
      
      
      {tabValue === 0 && <SplitView tf_instance_id={tf_instance_id}/>}
      {tabValue === 1 && <ExportData />}
    </>
  );
}