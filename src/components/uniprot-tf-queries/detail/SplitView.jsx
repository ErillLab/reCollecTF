import { useParams, useNavigate, Link } from "react-router-dom";
import { useEffect, useState } from "react";
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import BindingSites from "./common/BindingSites";
import { getQuerySplitView } from "../../../db/queries/uniprotQueries";
import DetailedView from "./DetailedView";

export default function SplitView({tf_instance_id}) {
  const navigate = useNavigate();
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [tabValue, setTabValue] = useState(0);
  const [data,setData] = useState(null);


  useEffect(() => {
      async function getData() {
        try {
          var localData = await getQuerySplitView(tf_instance_id);
          setData(await localData);
        } catch {
          setError(true);
        }finally {
          setLoading(false);
        };
      }

      getData();
    
  },  [tf_instance_id, navigate]);

  const handleChange = (event, newValue) => {
    setTabValue(newValue);
  };

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;
  // "Passar Binding sites" i "Aligned binding sites" a component únic a repetir a multiples
  return (
    <>
       <h3>{data[0].name} </h3> 
       <p> <Link className="text-accent hover:underline" > UniProtKB: {data[0].accession}</Link> regulon and binding site collection of {data[0].species} </p>

      <Tabs value={tabValue} onChange={handleChange}>
        <Tab label = 'Binding sites' sx={{color:"white"}}/>
        <Tab label = 'Aligned binding sites' sx={{color:"white"}}/>
        <Tab label = 'Detailed view' sx={{color:"white"}}/>
      </Tabs>
        
      {tabValue === 0 && <BindingSites tf_instance_id={tf_instance_id}/>} 
      {tabValue === 2 && <DetailedView tf_instance_id={tf_instance_id} />}
    </>
  );
}
  