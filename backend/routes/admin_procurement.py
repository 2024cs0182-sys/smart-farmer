from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.procurement import Procurement

router = APIRouter(
    prefix="/admin/procurement",
    tags=["Admin Procurement"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/")
def get_all_procurement(
    db: Session = Depends(get_db)
):
    records = db.query(Procurement).all()

    return records