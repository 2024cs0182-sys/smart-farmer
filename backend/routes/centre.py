from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.centre import Centre

router = APIRouter(
    prefix="/centres",
    tags=["Centres"]
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/")
def get_centres(
    db: Session = Depends(get_db)
):
    centres = db.query(Centre).all()
    return centres


@router.get("/nearby")
def get_nearby_centres(
    latitude: float,
    longitude: float,
    db: Session = Depends(get_db)
):
    centres = db.query(Centre).all()

    result = []

    for centre in centres:
        if (
            abs(centre.latitude - latitude) < 1
            and abs(centre.longitude - longitude) < 1
        ):
            result.append(centre)

    return result
@router.get("/{centre_id}/capacity")
def get_capacity(
    centre_id: int,
    db: Session = Depends(get_db)
):
    centre = db.query(Centre).filter(
        Centre.id == centre_id
    ).first()

    if not centre:
        return {"error": "Centre not found"}

    return {
        "centre_id": centre.id,
        "capacity": centre.capacity
    }