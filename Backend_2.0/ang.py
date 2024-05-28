from typing import Optional
from fastapi import APIRouter, HTTPException, Depends, status
from pydantic import BaseModel
from sqlalchemy.orm import Session
from database import SessionLocal
from models import Angajati, Users

router = APIRouter(
    prefix="/ang",
    tags=["ang"],
)

class AngajatiCreate(BaseModel):
    ID_Utilizator: Optional[int]
    username: Optional[str]
    Nume: Optional[str]
    Prenume: Optional[str]
    CNP: Optional[str]
    # Poza: Optional[bytes]
    NumarLegitimatie: Optional[int]
    Divizia: Optional[str]
    IntervaleAcces: Optional[str]
    CodSecuritateBluetooth: Optional[str]
    NumarMasina: Optional[str]
    AccesAuto: Optional[int]

class AngajatiResponse(BaseModel):
    ID_Angajat: int
    ID_Utilizator: Optional[int]
    username: Optional[str]
    Nume: Optional[str]
    Prenume: Optional[str]
    CNP: Optional[str]
    # Poza: Optional[bytes]
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

@router.post("/", status_code=status.HTTP_201_CREATED, response_model=AngajatiResponse)
async def create_angajat(create_angajat: AngajatiCreate, db: Session = Depends(get_db)):
    if create_angajat.username is not None:
        utilizator = db.query(Users).filter(Users.id == create_angajat.username).first()
        if not utilizator:
            raise HTTPException(status_code=400, detail="Invalid ID_Utilizator. User does not exist.")
    
    new_angajat = Angajati(
        ID_Utilizator=create_angajat.ID_Utilizator,
        username=create_angajat.username,
        Nume=create_angajat.Nume,
        Prenume=create_angajat.Prenume,
        CNP=create_angajat.CNP,
        # Poza=create_angajat.Poza,
        NumarLegitimatie=create_angajat.NumarLegitimatie,
        Divizia=create_angajat.Divizia,
        IntervaleAcces=create_angajat.IntervaleAcces,
        CodSecuritateBluetooth=create_angajat.CodSecuritateBluetooth,
        NumarMasina=create_angajat.NumarMasina,
        AccesAuto=create_angajat.AccesAuto,
    )
    db.add(new_angajat)
    db.commit()
    db.refresh(new_angajat)
    return new_angajat

@router.get("/Angajati/{angajati_id}", response_model=AngajatiResponse)
async def read_angajati(angajati_id: int, db: Session = Depends(get_db)):
    angajati = db.query(Angajati).filter(Angajati.ID_Angajat == angajati_id).first()
    if angajati is None:
        raise HTTPException(status_code=404, detail="Angajat not found")
    return angajati

# New endpoint to get Angajati details by username
@router.get("/Angajati/username/{username}", response_model=AngajatiResponse)
async def get_angajati_by_username(username: str, db: Session = Depends(get_db)):
    angajati = db.query(Angajati).filter(Angajati.username == username).first()
    if angajati is None:
        raise HTTPException(status_code=404, detail="Angajat not found")
    return angajati
