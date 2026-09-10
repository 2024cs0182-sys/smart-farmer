from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.payment import Payment
from models.booking import Booking

router = APIRouter(
    prefix="/payment",
    tags=["Payment"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# Demo MSP rates from the SIH proposal
MSP_RATES = {
    "Paddy": 2369,
    "Wheat": 2585
}


@router.post("/{booking_id}")
def create_payment(
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

    # Check if payment already exists
    existing_payment = db.query(Payment).filter(
        Payment.booking_id == booking_id
    ).first()

    if existing_payment:
        return existing_payment

    if booking.crop not in MSP_RATES:
        raise HTTPException(
            status_code=400,
            detail="MSP rate not available for this crop"
        )

    rate = MSP_RATES[booking.crop]

    # Quantity is in kg
    # 100 kg = 1 quintal
    amount = (booking.quantity / 100) * rate

    payment = Payment(
        booking_id=booking_id,
        amount=amount,
        status="pending"
    )

    db.add(payment)
    db.commit()
    db.refresh(payment)

    return {
        "payment_id": payment.id,
        "booking_id": booking_id,
        "crop": booking.crop,
        "quantity": booking.quantity,
        "amount": amount,
        "status": payment.status
    }


@router.get("/{booking_id}")
def get_payment(
    booking_id: int,
    db: Session = Depends(get_db)
):
    payment = db.query(Payment).filter(
        Payment.booking_id == booking_id
    ).first()

    if not payment:
        raise HTTPException(
            status_code=404,
            detail="Payment record not found"
        )

    return payment