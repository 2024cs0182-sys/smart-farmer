import { useEffect, useState } from 'react';
import { getDashboardSummary } from '../services/api';

function Dashboard() {
  const [summary, setSummary] = useState(null);
  const [error, setError] = useState(null);

  useEffect(() => {
    getDashboardSummary()
      .then(setSummary)
      .catch((err) => setError(err.message));
  }, []);

  if (error) return <div className="page"><h1>Dashboard</h1><p>Error: {error}. Is the backend running?</p></div>;
  if (!summary) return <div className="page"><h1>Dashboard</h1><p>Loading...</p></div>;

  const stats = [
    { label: 'Total Centres', value: summary.total_centres },
    { label: 'Total Bookings', value: summary.total_bookings },
    { label: 'Confirmed Bookings', value: summary.confirmed_bookings },
    { label: 'Total Procurement', value: summary.total_procurement },
    { label: 'Total Payments', value: summary.total_payments },
  ];

  return (
    <div className="page">
      <h1>Dashboard</h1>
      <div className="stat-grid">
        {stats.map((s) => (
          <div className="stat-card" key={s.label}>
            <div className="stat-value">{s.value}</div>
            <div className="stat-label">{s.label}</div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default Dashboard;