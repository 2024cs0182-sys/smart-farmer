import { useCallback, useEffect, useState } from 'react';
import { apiGet } from '../lib/api';
import { Loading, ErrorState, EmptyState } from '../components/PageState';

function Centres() {
  const [centres, setCentres] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const load = useCallback(async () => {
    setLoading(true); setError('');
    try { setCentres(await apiGet('/admin/centres/')); }
    catch (err) { setError(err.message); }
    finally { setLoading(false); }
  }, []);

  useEffect(() => { load(); }, [load]);

  return (
    <div className="page">
      <div className="page-header"><div><p className="eyebrow">CENTRES</p><h1>Procurement Centres</h1></div><button className="refresh-button" onClick={load}>Refresh</button></div>
      {loading && <Loading text="Loading centres..." />}
      {!loading && error && <ErrorState message={error} onRetry={load} />}
      {!loading && !error && centres.length === 0 && <EmptyState text="No centres found in PostgreSQL." />}
      {!loading && !error && centres.length > 0 && (
        <div className="table-card"><div className="table-wrap"><table className="data-table"><thead><tr><th>ID</th><th>Name</th><th>Location</th><th>Latitude</th><th>Longitude</th><th>Capacity</th></tr></thead><tbody>
          {centres.map(c => <tr key={c.id}><td>{c.id}</td><td>{c.name}</td><td>{c.location}</td><td>{c.latitude ?? '-'}</td><td>{c.longitude ?? '-'}</td><td>{c.capacity ?? 0} kg</td></tr>)}
        </tbody></table></div></div>
      )}
    </div>
  );
}
export default Centres;
