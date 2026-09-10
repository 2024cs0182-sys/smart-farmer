from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database.database import SessionLocal
from models.centre import Centre

router = APIRouter(
    prefix="/admin/centres",
    tags=["Admin Centres"]
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/")
def add_centre(
    name: str,
    location: str,
    latitude: float,
    longitude: float,
    capacity: int,
    db: Session = Depends(get_db)
):
    centre = Centre(
        name=name,
        location=location,
        latitude=latitude,
        longitude=longitude,
        capacity=capacity
    )

    db.add(centre)
    db.commit()
    db.refresh(centre)

    return {
        "centre_id": centre.id,
        "name": centre.name,
        "location": centre.location,
        "capacity": centre.capacity
    }


@router.get("/")
def get_all_centres(
    db: Session = Depends(get_db)
):
    centres = db.query(Centre).all()

    return centres