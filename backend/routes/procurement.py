from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.procurement import Procurement
from models.booking import Booking

router = APIRouter(
    prefix="/procurement",
    tags=["Procurement"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/{booking_id}")
def create_procurement(
    booking_id: int,
    quantity_received: float,
    db: Session = Depends(get_db)
):

    # Check booking
    booking = db.query(Booking).filter(
        Booking.id == booking_id
    ).first()

    if not booking:
        raise HTTPException(
            status_code=404,
            detail="Booking not found"
        )

    # Create procurement record
    procurement = Procurement(
        booking_id=booking_id,
        quantity_received=quantity_received,
        status="completed"
    )

    db.add(procurement)
    db.commit()
    db.refresh(procurement)

    return {
        "procurement_id": procurement.id,
        "booking_id": booking_id,
        "quantity_received": quantity_received,
        "status": procurement.status
    }


@router.get("/{booking_id}")
def get_procurement(
    booking_id: int,
    db: Session = Depends(get_db)
):

    procurement = db.query(Procurement).filter(
        Procurement.booking_id == booking_id
    ).first()

    if not procurement:
        raise HTTPException(
            status_code=404,
            detail="Procurement record not found"
        )

    return procurement