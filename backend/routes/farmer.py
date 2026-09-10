from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.farmer import Farmer
from schemas.farmer import FarmerCreate

router = APIRouter(
    prefix="/farmer",
    tags=["Farmer"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/register")
def register_farmer(
    data: FarmerCreate,
    db: Session = Depends(get_db)
):
    existing_farmer = db.query(Farmer).filter(
        Farmer.phone == data.phone
    ).first()

    if existing_farmer:
        raise HTTPException(
            status_code=400,
            detail="Phone number already registered"
        )

    farmer = Farmer(
        name=data.name,
        phone=data.phone,
        language=data.language
    )

    db.add(farmer)
    db.commit()
    db.refresh(farmer)

    return {
        "farmer_id": farmer.id,
        "name": farmer.name,
        "phone": farmer.phone,
        "language": farmer.language,
        "status": "registered"
    }
@router.post("/login")
def login_farmer(
    phone: str,
    db: Session = Depends(get_db)
):
    farmer = db.query(Farmer).filter(
        Farmer.phone == phone
    ).first()

    if not farmer:
        raise HTTPException(
            status_code=404,
            detail="Farmer not found"
        )

    return {
        "farmer_id": farmer.id,
        "name": farmer.name,
        "phone": farmer.phone,
        "language": farmer.language,
        "status": "login successful"
    }