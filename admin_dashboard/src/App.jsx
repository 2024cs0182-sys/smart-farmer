import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import Centres from './pages/Centres';
import Bookings from './pages/Bookings';
import Queue from './pages/Queue';
import Procurement from './pages/Procurement';
import Payments from './pages/Payments';
import './App.css';

function App() {
  return (
    <BrowserRouter>
      <div className="app-layout">
        <Sidebar />
        <div className="page-content">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/centres" element={<Centres />} />
            <Route path="/bookings" element={<Bookings />} />
            <Route path="/queue" element={<Queue />} />
            <Route path="/procurement" element={<Procurement />} />
            <Route path="/payments" element={<Payments />} />
          </Routes>
        </div>
      </div>
    </BrowserRouter>
  );
}

export default App;
