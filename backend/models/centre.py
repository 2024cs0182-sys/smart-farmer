from sqlalchemy import Column, Integer, String, Float
from models.base import Base


class Centre(Base):
    __tablename__ = "centres"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    location = Column(String(200), nullable=False)
    latitude = Column(Float)
    longitude = Column(Float)
    capacity = Column(Integer, default=0)