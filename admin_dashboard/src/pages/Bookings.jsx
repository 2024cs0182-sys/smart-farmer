import { useCallback, useEffect, useState } from 'react';
import { apiGet } from '../lib/api';
import { Loading, ErrorState, EmptyState } from '../components/PageState';

function Bookings() {
  const [bookings, setBookings] = useState([]); const [loading, setLoading] = useState(true); const [error, setError] = useState('');
  const load = useCallback(async () => { setLoading(true); setError(''); try { setBookings(await apiGet('/admin/bookings/')); } catch (err) { setError(err.message); } finally { setLoading(false); } }, []);
  useEffect(() => { load(); }, [load]);
  return <div className="page"><div className="page-header"><div><p className="eyebrow">BOOKINGS</p><h1>Bookings</h1></div><button className="refresh-button" onClick={load}>Refresh</button></div>
    {loading && <Loading text="Loading bookings..." />}{!loading && error && <ErrorState message={error} onRetry={load} />}{!loading && !error && bookings.length === 0 && <EmptyState text="No bookings found." />}
    {!loading && !error && bookings.length > 0 && <div className="table-card"><div className="table-wrap"><table className="data-table"><thead><tr><th>ID</th><th>Farmer ID</th><th>Centre ID</th><th>Crop</th><th>Quantity</th><th>Date</th><th>Slot</th><th>Token</th><th>Status</th></tr></thead><tbody>
      {bookings.map(b => <tr key={b.id}><td>{b.id}</td><td>{b.farmer_id}</td><td>{b.centre_id}</td><td>{b.crop}</td><td>{b.quantity} kg</td><td>{b.date}</td><td>{b.slot_id}</td><td><span className="token">#{b.token}</span></td><td><span className={`status ${String(b.status).toLowerCase()}`}>{b.status}</span></td></tr>)}
    </tbody></table></div></div>}
  </div>;
}
export default Bookings;
