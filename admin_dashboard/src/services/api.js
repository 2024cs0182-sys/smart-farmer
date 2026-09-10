const BASE_URL = 'http://127.0.0.1:8000';

export async function getCentres() {
  const res = await fetch(`${BASE_URL}/centres/`);
  if (!res.ok) throw new Error('Failed to fetch centres');
  return res.json();
}

export async function getCentreCapacity(centreId) {
  const res = await fetch(`${BASE_URL}/centres/${centreId}/capacity`);
  if (!res.ok) throw new Error('Failed to fetch capacity');
  return res.json();
}

export async function getBookings() {
  const res = await fetch(`${BASE_URL}/admin/bookings/`);
  if (!res.ok) throw new Error('Failed to fetch bookings');
  return res.json();
}

export async function getQueue() {
  const res = await fetch(`${BASE_URL}/admin/queue/`);
  if (!res.ok) throw new Error('Failed to fetch queue');
  return res.json();
}

export async function getProcurement() {
  const res = await fetch(`${BASE_URL}/admin/procurement/`);
  if (!res.ok) throw new Error('Failed to fetch procurement');
  return res.json();
}

export async function createProcurement(bookingId, quantityReceived) {
  const res = await fetch(`${BASE_URL}/procurement/${bookingId}?quantity_received=${quantityReceived}`, {
    method: 'POST',
  });
  if (!res.ok) throw new Error('Failed to record procurement');
  return res.json();
}

export async function getPayments() {
  const res = await fetch(`${BASE_URL}/admin/payment/`);
  if (!res.ok) throw new Error('Failed to fetch payments');
  return res.json();
}

export async function createPayment(bookingId) {
  const res = await fetch(`${BASE_URL}/payment/${bookingId}`, {
    method: 'POST',
  });
  if (!res.ok) throw new Error('Failed to create payment');
  return res.json();
}

export async function getDashboardSummary() {
  const res = await fetch(`${BASE_URL}/admin/dashboard/`);
  if (!res.ok) throw new Error('Failed to fetch dashboard summary');
  return res.json();
}