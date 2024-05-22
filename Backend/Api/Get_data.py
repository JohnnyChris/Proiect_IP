
from fastapi import APIRouter, FastAPI, HTTPException
from Backend import get_session
from ORM_models.Utilizatori import Utilizatori, Utilizatori_pydantic
from ORM_models.Angajati import Angajati_pydantic,Angajati


router = APIRouter(prefix="/get_data", tags=["get"])

app = FastAPI()


    
#Verificare id
@router.get("/Username")
def get_Username(username:str):
    with get_session()as Session:
        username_utilizator=Session.query(Utilizatori).where(Utilizatori.Username==username).first()
        if not username_utilizator:
            raise HTTPException(status_code=404, detail="User not found")
    return username_utilizator

#Verificare Parola
@router.get("/Password")
def get_Password(Pass:str):
    with get_session()as Session:
       parola_utilizator=Session.query(Utilizatori).where(Utilizatori.Parola==Pass).first()
       if not parola_utilizator:
           raise HTTPException(status_code=404, detail="Invalid password") 
    return parola_utilizator

#Afisare informatii dupa id
@router.get("/Informatii_Utilizator")
def get_Informatii(id:int):
    with get_session()as Session:
        Informatii=Session.query(Angajati).where(Angajati.ID_Utilizator==id).first()
        if not Informatii:
            raise HTTPException(status_code=404, detail="User not found")
    return Informatii
