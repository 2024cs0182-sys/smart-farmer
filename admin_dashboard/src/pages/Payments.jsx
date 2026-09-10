import { useCallback, useEffect, useState } from 'react';
import { apiGet } from '../lib/api';
import { Loading, ErrorState, EmptyState } from '../components/PageState';

function Payments() {
  const [payments, setPayments] = useState([]); const [loading, setLoading] = useState(true); const [error, setError] = useState('');
  const load = useCallback(async () => { setLoading(true); setError(''); try { setPayments(await apiGet('/admin/payment/')); } catch (err) { setError(err.message); } finally { setLoading(false); } }, []);
  useEffect(() => { load(); }, [load]);
  return <div className="page"><div className="page-header"><div><p className="eyebrow">PAYMENTS</p><h1>Payments</h1></div><button className="refresh-button" onClick={load}>Refresh</button></div>
    {loading && <Loading text="Loading payments..." />}{!loading && error && <ErrorState message={error} onRetry={load} />}{!loading && !error && payments.length === 0 && <EmptyState text="No payment records found." />}
    {!loading && !error && payments.length > 0 && <div className="table-card"><div className="table-wrap"><table className="data-table"><thead><tr><th>ID</th><th>Booking ID</th><th>Amount</th><th>Status</th></tr></thead><tbody>
      {payments.map(p => <tr key={p.id}><td>{p.id}</td><td>{p.booking_id}</td><td>₹{Number(p.amount || 0).toLocaleString('en-IN')}</td><td><span className={`status ${String(p.status).toLowerCase()}`}>{p.status}</span></td></tr>)}
    </tbody></table></div></div>}
  </div>;
}
export default Payments;
