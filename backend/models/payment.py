from sqlalchemy import Column, Integer, String, Float
from models.base import Base


class Payment(Base):
    __tablename__ = "payments"

    id = Column(Integer, primary_key=True, index=True)
    booking_id = Column(Integer, nullable=False)
    amount = Column(Float, default=0)
    status = Column(String(50), default="pending")