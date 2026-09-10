from pydantic import BaseModel


class BookingCreate(BaseModel):
    farmer_id: int
    centre_id: int
    crop: str
    quantity: int
    date: str
    slot_id: int