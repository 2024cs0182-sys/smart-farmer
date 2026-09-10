function Payments() {
  const payments = [
    { id: 'B001', farmer: 'Ramesh Kumar', amount: '₹12,500', status: 'Paid' },
    { id: 'B002', farmer: 'Suresh Babu', amount: '₹7,200', status: 'Pending' },
    { id: 'B003', farmer: 'Lakshmi Devi', amount: '₹16,900', status: 'Paid' },
  ];

  return (
    <div className="page">
      <h1>Payments</h1>
      <table className="data-table">
        <thead>
          <tr>
            <th>Booking ID</th>
            <th>Farmer</th>
            <th>Amount</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {payments.map((p) => (
            <tr key={p.id}>
              <td>{p.id}</td>
              <td>{p.farmer}</td>
              <td>{p.amount}</td>
              <td>{p.status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Payments;