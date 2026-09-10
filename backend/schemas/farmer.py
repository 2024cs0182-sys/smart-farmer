from pydantic import BaseModel


class FarmerCreate(BaseModel):
    name: str
    phone: str
    language: str = "English"