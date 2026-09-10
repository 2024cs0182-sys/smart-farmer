from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.payment import Payment

router = APIRouter(
    prefix="/admin/payment",
    tags=["Admin Payment"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/")
def get_all_payments(
    db: Session = Depends(get_db)
):
    payments = db.query(Payment).all()

    return payments