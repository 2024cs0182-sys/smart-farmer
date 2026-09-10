import { NavLink } from 'react-router-dom';
import './Sidebar.css';

function Sidebar() {
    const links = [
    { to: '/', label: 'Dashboard' },
    { to: '/centres', label: 'Centres' },
    { to: '/bookings', label: 'Bookings' },
    { to: '/queue', label: 'Queue' },
    { to: '/procurement', label: 'Procurement' },
    { to: '/payments', label: 'Payments' },
    ];

    return (
    <div className="sidebar">
        <h2 className="sidebar-title">Admin</h2>
        <nav>
        {links.map((link) => (
            <NavLink
            key={link.to}
            to={link.to}
            end={link.to === '/'}
            className={({ isActive }) =>
            isActive ? 'sidebar-link active' : 'sidebar-link'
            }
        >
            {link.label}
            </NavLink>
        ))}
    </nav>
</div>
);
}

export default Sidebar;