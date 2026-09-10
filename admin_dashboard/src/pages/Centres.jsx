function Centres() {
  const centres = [
    { name: 'Centre A', location: 'Thanjavur', capacity: '2000kg', storage: 'Warehouse 1' },
    { name: 'Centre B', location: 'Trichy', capacity: '1500kg', storage: 'Warehouse 2' },
    { name: 'Centre C', location: 'Madurai', capacity: '1800kg', storage: 'Warehouse 3' },
  ];

  return (
    <div className="page">
      <h1>Centres</h1>
      <table className="data-table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Location</th>
            <th>Capacity</th>
            <th>Storage</th>
          </tr>
        </thead>
        <tbody>
          {centres.map((c) => (
            <tr key={c.name}>
              <td>{c.name}</td>
              <td>{c.location}</td>
              <td>{c.capacity}</td>
              <td>{c.storage}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Centres;