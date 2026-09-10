from sqlalchemy import Column, Integer, String, Date
from models.base import Base


class Slot(Base):
    __tablename__ = "slots"

    id = Column(Integer, primary_key=True, index=True)
    centre_id = Column(Integer, nullable=False)
    date = Column(Date, nullable=False)
    time = Column(String(50), nullable=False)
    capacity = Column(Integer, default=0)
    booked = Column(Integer, default=0)