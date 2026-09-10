import { useCallback, useEffect, useState } from 'react';
import { apiGet } from '../lib/api';
import { Loading, ErrorState, EmptyState } from '../components/PageState';

function Procurement() {
  const [records, setRecords] = useState([]); const [loading, setLoading] = useState(true); const [error, setError] = useState('');
  const load = useCallback(async () => { setLoading(true); setError(''); try { setRecords(await apiGet('/admin/procurement/')); } catch (err) { setError(err.message); } finally { setLoading(false); } }, []);
  useEffect(() => { load(); }, [load]);
  return <div className="page"><div className="page-header"><div><p className="eyebrow">PROCUREMENT</p><h1>Procurement</h1></div><button className="refresh-button" onClick={load}>Refresh</button></div>
    {loading && <Loading text="Loading procurement..." />}{!loading && error && <ErrorState message={error} onRetry={load} />}{!loading && !error && records.length === 0 && <EmptyState text="No procurement records found." />}
    {!loading && !error && records.length > 0 && <div className="table-card"><div className="table-wrap"><table className="data-table"><thead><tr><th>ID</th><th>Booking ID</th><th>Quantity Received</th><th>Status</th></tr></thead><tbody>
      {records.map(p => <tr key={p.id}><td>{p.id}</td><td>{p.booking_id}</td><td>{p.quantity_received ?? 0} kg</td><td><span className={`status ${String(p.status).toLowerCase()}`}>{p.status}</span></td></tr>)}
    </tbody></table></div></div>}
  </div>;
}
export default Procurement;
