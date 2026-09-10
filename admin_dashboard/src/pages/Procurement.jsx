function Procurement() {
  const procurement = [
    { id: 'B001', farmer: 'Ramesh Kumar', crop: 'Paddy', receivedQty: '495kg', status: 'Completed' },
    { id: 'B002', farmer: 'Suresh Babu', crop: 'Wheat', receivedQty: '-', status: 'Pending' },
    { id: 'B003', farmer: 'Lakshmi Devi', crop: 'Paddy', receivedQty: '650kg', status: 'Completed' },
  ];

  return (
    <div className="page">
      <h1>Procurement</h1>
      <table className="data-table">
        <thead>
          <tr>
            <th>Booking ID</th>
            <th>Farmer</th>
            <th>Crop</th>
            <th>Received Qty</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {procurement.map((p) => (
            <tr key={p.id}>
              <td>{p.id}</td>
              <td>{p.farmer}</td>
              <td>{p.crop}</td>
              <td>{p.receivedQty}</td>
              <td>{p.status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Procurement;