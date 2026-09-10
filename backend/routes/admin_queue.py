from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.booking import Booking

router = APIRouter(
    prefix="/admin/queue",
    tags=["Admin Queue"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/")
def get_queue(
    db: Session = Depends(get_db)
):
    bookings = db.query(Booking).filter(
        Booking.status == "confirmed"
    ).order_by(
        Booking.token
    ).all()

    return bookings