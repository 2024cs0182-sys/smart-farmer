from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.booking import Booking

router = APIRouter(
    prefix="/admin/bookings",
    tags=["Admin Bookings"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/")
def get_all_bookings(
    db: Session = Depends(get_db)
):
    bookings = db.query(Booking).all()

    return bookings