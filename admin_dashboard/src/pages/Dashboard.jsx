function Dashboard() {
    const stats = [
    { label: 'Total Bookings', value: 128 },
    { label: "Today's Arrivals", value: 14 },
    { label: 'Current Queue', value: 6 },
    { label: 'Remaining Capacity', value: 32 },
    { label: 'Completed Procurement', value: 98 },
    { label: 'Pending Payments', value: 11 },
    { label: 'No-shows', value: 3 },
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