
from fastapi import APIRouter, FastAPI
from Backend import get_session
from ORM_models.Utilizatori import Utilizatori, Utilizatori_pydantic
from ORM_models.Angajati import Angajati_pydantic,Angajati


router = APIRouter(prefix="/get_data", tags=["get"])

app = FastAPI()

@router.get("/test")
def get(Password:Angajati_pydantic):
    print(Password)
    
@router.get("/test_Utilizatori")
def get_utilizator(id:int):
    with get_session()as Session:
        utilizatori=Session.query(Utilizatori).where(Utilizatori.ID_Utilizator==id).first()
    return utilizatori
    
@router.get("/Angajati")
def get_angajat(id:int):
    with get_session()as Session:
        angajati=Session.query(Angajati).where(Angajati.ID_Angajat==id).first()
    return angajati    