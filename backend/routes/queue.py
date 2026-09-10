from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.booking import Booking

router = APIRouter(prefix="/queue", tags=["Queue"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/{token}")
def get_queue(token: int, db: Session = Depends(get_db)):

    booking = db.query(Booking).filter(
        Booking.token == token
    ).first()

    if not booking:
        raise HTTPException(
            status_code=404,
            detail="Token not found"
        )

    # Count confirmed bookings before this token
    waiting = db.query(Booking).filter(
        Booking.token < token,
        Booking.status == "confirmed"
    ).count()

    position = waiting + 1

    if waiting <= 5:
        alert = "Your turn is near"
    else:
        alert = "Please wait"

    return {
        "token": token,
        "queue_position": position,
        "farmers_ahead": waiting,
        "alert": alert
    }