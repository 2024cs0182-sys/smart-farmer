import { NavLink } from 'react-router-dom';
import './Sidebar.css';

function Sidebar() {
  const links = [
    { to: '/', label: 'Dashboard', icon: '⌂' },
    { to: '/centres', label: 'Centres', icon: '▦' },
    { to: '/bookings', label: 'Bookings', icon: '▤' },
    { to: '/queue', label: 'Queue', icon: '☷' },
    { to: '/procurement', label: 'Procurement', icon: '◈' },
    { to: '/payments', label: 'Payments', icon: '₹' },
  ];
  return <aside className="sidebar"><div className="brand"><div className="brand-mark">SF</div><div><div className="brand-title">Smart Farmer</div><div className="brand-subtitle">Admin Panel</div></div></div><nav>{links.map(link => <NavLink key={link.to} to={link.to} end={link.to === '/'} className={({isActive}) => isActive ? 'sidebar-link active' : 'sidebar-link'}><span className="nav-icon">{link.icon}</span><span>{link.label}</span></NavLink>)}</nav><div className="sidebar-footer">Connected to<br /><strong>FastAPI + PostgreSQL</strong></div></aside>;
}
export default Sidebar;
