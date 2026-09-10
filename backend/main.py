from fastapi import FastAPI

from database.database import engine
from models.base import Base

from models.farmer import Farmer
from models.centre import Centre
from models.crop import Crop
from models.slot import Slot
from models.booking import Booking
from models.procurement import Procurement
from models.payment import Payment

from routes.centre import router as centre_router
from routes.slot import router as slot_router
from routes.booking import router as booking_router
from routes.queue import router as queue_router
from routes.procurement import router as procurement_router
from routes.payment import router as payment_router
from routes.admin_centre import router as admin_centre_router
from routes.admin_booking import router as admin_booking_router
from routes.admin_queue import router as admin_queue_router
from routes.admin_procurement import router as admin_procurement_router
from routes.admin_payment import router as admin_payment_router
from routes.farmer import router as farmer_router
from routes.admin_slot import router as admin_slot_router
from routes.admin_dashboard import router as admin_dashboard_router

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Smart Farmer Procurement API")


app.include_router(centre_router)
app.include_router(slot_router)
app.include_router(booking_router)
app.include_router(queue_router)
app.include_router(procurement_router)
app.include_router(payment_router)
app.include_router(admin_centre_router)
app.include_router(admin_booking_router)
app.include_router(admin_queue_router)
app.include_router(admin_procurement_router)
app.include_router(admin_payment_router)
app.include_router(farmer_router)
app.include_router(admin_slot_router)
app.include_router(admin_dashboard_router)


@app.get("/health")
def health():
    return {"status": "Backend is running"}