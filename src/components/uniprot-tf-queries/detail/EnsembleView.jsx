import { useParams, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';

export default function EnsembleView(data) {
  const navigate = useNavigate();
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [tabValue, setTabValue] = useState(0);

  useEffect(() => {
    try {
      setLoading(false)
    }
    catch {
      setError(true);
    }
  }, [navigate]);


const handleChange = (event, newValue) => {
  setTabValue(newValue);
};

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;
 // "Passar Binding sites" i "Aligned binding sites" a component únic a repetir a multiples
  return (
    <>
      <Tabs value={tabValue} onChange={handleChange}>
        <Tab label = 'Binding sites' sx={{color:"white"}}/>
        <Tab label = 'Aligned binding sites' sx={{color:"white"}}/>
        <Tab label = 'Sequence Logo' sx={{color:"white"}}/>
      </Tabs>
    </>
  );
}