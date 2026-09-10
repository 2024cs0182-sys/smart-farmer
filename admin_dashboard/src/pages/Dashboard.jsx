import { useCallback, useEffect, useState } from 'react';
import { apiGet } from '../lib/api';
import { Loading, ErrorState } from '../components/PageState';

function Dashboard() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const load = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      setData(await apiGet('/admin/dashboard/'));
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { load(); }, [load]);

  const stats = data ? [
    ['Total Centres', data.total_centres],
    ['Total Bookings', data.total_bookings],
    ['Confirmed Bookings', data.confirmed_bookings],
    ['Procurement Records', data.total_procurement],
    ['Payment Records', data.total_payments],
  ] : [];

  return (
    <div className="page">
      <div className="page-header">
        <div>
          <p className="eyebrow">SMART FARMER PROCUREMENT</p>
          <h1>Dashboard</h1>
          <p className="page-subtitle">Live information from FastAPI and PostgreSQL.</p>
        </div>
        <button className="refresh-button" onClick={load}>Refresh</button>
      </div>

      {loading && <Loading text="Loading dashboard..." />}
      {!loading && error && <ErrorState message={error} onRetry={load} />}

      {!loading && !error && (
        <div className="stat-grid">
          {stats.map(([label, value]) => (
            <div className="stat-card" key={label}>
              <div className="stat-value">{value ?? 0}</div>
              <div className="stat-label">{label}</div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default Dashboard;
