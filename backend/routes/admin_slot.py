from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import date

from database.database import SessionLocal
from models.slot import Slot

router = APIRouter(
    prefix="/admin/slots",
    tags=["Admin Slots"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/")
def add_slot(
    centre_id: int,
    slot_date: date,
    time: str,
    capacity: int,
    db: Session = Depends(get_db)
):
    slot = Slot(
        centre_id=centre_id,
        date=slot_date,
        time=time,
        capacity=capacity,
        booked=0
    )

    db.add(slot)
    db.commit()
    db.refresh(slot)

    return {
        "slot_id": slot.id,
        "centre_id": slot.centre_id,
        "date": slot.date,
        "time": slot.time,
        "capacity": slot.capacity,
        "booked": slot.booked
    }


@router.get("/")
def get_all_slots(
    db: Session = Depends(get_db)
):
    slots = db.query(Slot).all()

    return slots