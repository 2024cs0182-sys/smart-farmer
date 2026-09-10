import { useCallback, useEffect, useState } from 'react';
import { apiGet } from '../lib/api';
import { Loading, ErrorState, EmptyState } from '../components/PageState';

function Queue() {
  const [queue, setQueue] = useState([]); const [loading, setLoading] = useState(true); const [error, setError] = useState('');
  const load = useCallback(async () => { setLoading(true); setError(''); try { setQueue(await apiGet('/admin/queue/')); } catch (err) { setError(err.message); } finally { setLoading(false); } }, []);
  useEffect(() => { load(); }, [load]);
  return <div className="page"><div className="page-header"><div><p className="eyebrow">LIVE QUEUE</p><h1>Queue</h1></div><button className="refresh-button" onClick={load}>Refresh</button></div>
    {loading && <Loading text="Loading queue..." />}{!loading && error && <ErrorState message={error} onRetry={load} />}{!loading && !error && queue.length === 0 && <EmptyState text="No confirmed bookings in the queue." />}
    {!loading && !error && queue.length > 0 && <div className="table-card"><div className="table-wrap"><table className="data-table"><thead><tr><th>Position</th><th>Token</th><th>Booking ID</th><th>Farmer ID</th><th>Centre ID</th><th>Crop</th><th>Quantity</th><th>Status</th></tr></thead><tbody>
      {queue.map((b, i) => <tr key={b.id}><td><strong>{i + 1}</strong></td><td><span className="token">#{b.token}</span></td><td>{b.id}</td><td>{b.farmer_id}</td><td>{b.centre_id}</td><td>{b.crop}</td><td>{b.quantity} kg</td><td><span className="status confirmed">{b.status}</span></td></tr>)}
    </tbody></table></div></div>}
  </div>;
}
export default Queue;
