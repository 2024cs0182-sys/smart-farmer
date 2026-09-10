from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.centre import Centre
from models.booking import Booking
from models.procurement import Procurement
from models.payment import Payment

router = APIRouter(
    prefix="/admin/dashboard",
    tags=["Admin Dashboard"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/")
def get_dashboard(
    db: Session = Depends(get_db)
):
    total_centres = db.query(Centre).count()

    total_bookings = db.query(Booking).count()

    confirmed_bookings = db.query(Booking).filter(
        Booking.status == "confirmed"
    ).count()

    total_procurement = db.query(Procurement).count()

    total_payments = db.query(Payment).count()

    return {
        "total_centres": total_centres,
        "total_bookings": total_bookings,
        "confirmed_bookings": confirmed_bookings,
        "total_procurement": total_procurement,
        "total_payments": total_payments
    }