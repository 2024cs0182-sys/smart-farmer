from sqlalchemy import Column, Integer, String, Float
from models.base import Base


class Procurement(Base):
    __tablename__ = "procurement"

    id = Column(Integer, primary_key=True, index=True)
    booking_id = Column(Integer, nullable=False)
    quantity_received = Column(Float, default=0)
    status = Column(String(50), default="pending")