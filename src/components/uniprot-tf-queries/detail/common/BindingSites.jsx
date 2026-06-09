import { useParams, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { getQuerySequence } from "../../../../db/queries/uniprotQueries";

export default function BindingSites({tf_instance_id}) {
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  const [sites, setSites] = useState([]);


  useEffect(() => {
    async function getReportedSites() {
      try{
        console.log("ID:", tf_instance_id);
        const data = await getQuerySequence(tf_instance_id);
        setSites(data);
      } catch {
        setError(true);
      } finally {
        setLoading(false);
      }
    }

    getReportedSites()
  }, [tf_instance_id]);

  if (loading) return <div className="container mt-5">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;
 // "Passar Binding sites" i "Aligned binding sites" a component únic a repetir a multiples
  return (
    <>
      <ul>
        {sites.map(site => (
          <li key={site.id}>{site.sequence}</li>
        ))}
      </ul>
    </>
  );
}