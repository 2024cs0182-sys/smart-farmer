from sqlalchemy import Column, Integer, String
from models.base import Base


class Booking(Base):
    __tablename__ = "bookings"

    id = Column(Integer, primary_key=True, index=True)
    farmer_id = Column(Integer, nullable=False)
    centre_id = Column(Integer, nullable=False)
    crop = Column(String(100), nullable=False)
    quantity = Column(Integer, nullable=False)
    date = Column(String(20), nullable=False)
    slot_id = Column(Integer, nullable=False)
    token = Column(Integer, unique=True, nullable=False)
    status = Column(String(50), default="confirmed")