from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.slot import Slot


router = APIRouter(prefix="/centres", tags=["Slots"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/{centre_id}/slots")
def get_slots(centre_id: int, db: Session = Depends(get_db)):
    slots = db.query(Slot).filter(
        Slot.centre_id == centre_id
    ).all()

    return slots