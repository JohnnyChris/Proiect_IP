from typing import Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from database import SessionLocal
from models import Angajati

router = APIRouter(
    prefix="/ang",
    tags=["ang"],
) 

class AngajatiResponse(BaseModel):
    ID_Angajat: int
    ID_Utilizator: Optional[int]
    Nume: Optional[str]
    Prenume: Optional[str]
    CNP: Optional[str]
    Poza: Optional[bytes]
    NumarLegitimatie: Optional[int]
    Divizia: Optional[str]
    IntervaleAcces: Optional[str]
    CodSecuritateBluetooth: Optional[str]
    NumarMasina: Optional[str]
    AccesAuto: Optional[int]

    class Config:
        orm_mode = True

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/Angajati/{angajati_id}", response_model=AngajatiResponse)
async def read_angajati(angajati_id: int, db: Session = Depends(get_db)):
    angajati = db.query(Angajati).filter(Angajati.ID_Angajat == angajati_id).first()
    if angajati is None:
        raise HTTPException(status_code=404, detail="Angajat not found")
    return angajati
