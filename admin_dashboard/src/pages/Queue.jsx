function Bookings() {
  const bookings = [
    { id: 'B001', farmer: 'Ramesh Kumar', crop: 'Paddy', qty: '500kg', centre: 'Centre A', status: 'Confirmed' },
    { id: 'B002', farmer: 'Suresh Babu', crop: 'Wheat', qty: '300kg', centre: 'Centre B', status: 'Pending' },
    { id: 'B003', farmer: 'Lakshmi Devi', crop: 'Paddy', qty: '650kg', centre: 'Centre A', status: 'Confirmed' },
  ];

  return (
    <div className="page">
      <h1>Bookings</h1>
      <table className="data-table">
        <thead>
          <tr>
            <th>Booking ID</th>
            <th>Farmer</th>
            <th>Crop</th>
            <th>Quantity</th>
            <th>Centre</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {bookings.map((b) => (
            <tr key={b.id}>
              <td>{b.id}</td>
              <td>{b.farmer}</td>
              <td>{b.crop}</td>
              <td>{b.qty}</td>
              <td>{b.centre}</td>
              <td>{b.status}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Bookings;