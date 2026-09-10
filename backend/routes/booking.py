from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func

from database.database import SessionLocal
from models.booking import Booking
from models.farmer import Farmer
from models.centre import Centre
from models.slot import Slot
from schemas.booking import BookingCreate

router = APIRouter(prefix="/booking", tags=["Booking"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/")
def create_booking(
    data: BookingCreate,
    db: Session = Depends(get_db)
):

    # Check farmer
    farmer = db.query(Farmer).filter(
        Farmer.id == data.farmer_id
    ).first()

    if not farmer:
        raise HTTPException(
            status_code=404,
            detail="Farmer not found"
        )

    # Check centre
    centre = db.query(Centre).filter(
        Centre.id == data.centre_id
    ).first()

    if not centre:
        raise HTTPException(
            status_code=404,
            detail="Centre not found"
        )

    # Check slot
    slot = db.query(Slot).filter(
        Slot.id == data.slot_id
    ).first()

    if not slot:
        raise HTTPException(
            status_code=404,
            detail="Slot not found"
        )

    # Check slot belongs to centre
    if slot.centre_id != data.centre_id:
        raise HTTPException(
            status_code=400,
            detail="Slot does not belong to this centre"
        )

    # Check capacity
    if slot.booked + data.quantity > slot.capacity:
        raise HTTPException(
            status_code=400,
            detail="Not enough slot capacity"
        )

    # Generate token
    max_token = db.query(
        func.max(Booking.token)
    ).scalar()

    if max_token is None:
        token = 1
    else:
        token = max_token + 1

    # Create booking
    booking = Booking(
        farmer_id=data.farmer_id,
        centre_id=data.centre_id,
        crop=data.crop,
        quantity=data.quantity,
        date=data.date,
        slot_id=data.slot_id,
        token=token,
        status="confirmed"
    )

    # Update slot booked quantity
    slot.booked += data.quantity

    db.add(booking)
    db.commit()
    db.refresh(booking)

    return {
        "booking_id": booking.id,
        "token": booking.token,
        "status": booking.status
    }
@router.get("/{booking_id}")
def get_booking(
    booking_id: int,
    db: Session = Depends(get_db)
):
    booking = db.query(Booking).filter(
        Booking.id == booking_id
    ).first()

    if not booking:
        raise HTTPException(
            status_code=404,
            detail="Booking not found"
        )

    return booking
@router.delete("/{booking_id}")
def cancel_booking(
    booking_id: int,
    db: Session = Depends(get_db)
):
    booking = db.query(Booking).filter(
        Booking.id == booking_id
    ).first()

    if not booking:
        raise HTTPException(
            status_code=404,
            detail="Booking not found"
        )

    if booking.status == "cancelled":
        raise HTTPException(
            status_code=400,
            detail="Booking already cancelled"
        )

    # Free the booked quantity from the slot
    slot = db.query(Slot).filter(
        Slot.id == booking.slot_id
    ).first()

    if slot:
        slot.booked -= booking.quantity

    booking.status = "cancelled"

    db.commit()

    return {
        "booking_id": booking.id,
        "status": "cancelled"
    }