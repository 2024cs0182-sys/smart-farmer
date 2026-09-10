# Smart Farmer Admin Dashboard - Connected Version

This dashboard reads live data from the Smart Farmer FastAPI + PostgreSQL backend.

## Start backend

From `backend`:

```powershell
venv\Scripts\activate
python -m uvicorn main:app --reload
```

Backend: `http://127.0.0.1:8000`
Swagger: `http://127.0.0.1:8000/docs`

## Start dashboard

From this folder:

```powershell
npm install
npm run dev
```

Open the Vite URL, normally `http://localhost:5173`.

## How the connection works

The React app requests `/api/admin/...`.
Vite proxies `/api` to `http://127.0.0.1:8000` during development, so you do not need to add CORS just to run this dashboard locally.

## Connected endpoints

- `/admin/dashboard/`
- `/admin/centres/`
- `/admin/bookings/`
- `/admin/queue/`
- `/admin/procurement/`
- `/admin/payment/`

The dashboard uses the real API response and no longer displays the old dummy data.
