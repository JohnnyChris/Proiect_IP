from typing import Optional
from fastapi import APIRouter, HTTPException, Depends, status
from pydantic import BaseModel
from sqlalchemy.orm import Session
from database import SessionLocal
from models import Angajati, InregistrarePrezenta, Users

router = APIRouter(
    prefix="/reg",
    tags=["reg"],
)

class InregistrarePrezentaCreate(BaseModel):
    ID_Inregistrare: Optional[int]
    username: Optional[str]
    ID_Angajat: Optional[int] 
    DataIntrare: Optional[str]
    OraIntrare: Optional[str]
    OraIesire: Optional[str]


class InregistrarePrezentaResponse(BaseModel):
    ID_Inregistrare: Optional[int]
    username: Optional[str]
    ID_Angajat: int
    DataIntrare: Optional[str]
    OraIntrare: Optional[str]
    OraIesire: Optional[str]

    class Config:
        orm_mode = True


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/", status_code=status.HTTP_201_CREATED, response_model=InregistrarePrezentaResponse)
async def create_inregistrare(create_inregistrare: InregistrarePrezentaCreate, db: Session = Depends(get_db)):
    # Check if the user exists based on ID_Angajat
    user = db.query(Users).filter(Users.username == create_inregistrare.username).first()
    if user is None:
        raise HTTPException(status_code=400, detail="Invalid ID_Angajat. User does not exist.")

    # Create new InregistrarePrezenta entry
    new_reg = InregistrarePrezenta(
        ID_Angajat=create_inregistrare.ID_Angajat,
        username=create_inregistrare.username,
        DataIntrare=create_inregistrare.DataIntrare,
        OraIntrare=create_inregistrare.OraIntrare,
        OraIesire=create_inregistrare.OraIesire
    )
    db.add(new_reg)
    db.commit()
    db.refresh(new_reg)
    return new_reg


@router.get("/InregistrarePrezenta/username/{username}", response_model=InregistrarePrezentaResponse)
async def get_reg_by_username(username: str, db: Session = Depends(get_db)):
    reg = db.query(InregistrarePrezenta).filter(InregistrarePrezenta.username == username).first()
    if reg is None:
       raise HTTPException(status_code=404, detail="Register not found")
    return reg
 