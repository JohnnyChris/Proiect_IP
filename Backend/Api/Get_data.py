from fastapi import APIRouter, HTTPException, FastAPI
from pydantic import BaseModel
from sqlalchemy.orm import Session
from Backend import get_session
from ORM_models.Angajati import Angajati_pydantic, Angajati


router = APIRouter(prefix="/get_data", tags=["get"])

app = FastAPI()

@router.get("/test")
def get(Password:Angajati_pydantic):
    print(Password)
@router.get("/Angajati")
def get_angajat(id:int):
    with get_session()as Session:
        angajati=Session.query(Angajati).where(Angajati.ID_Angajat==id).first()
    return angajati    

class LoginRequest(BaseModel):
    Nume: str
    Prenume: str

@router.post("/login")
def login(credentials: LoginRequest):
    with get_session() as session:
        user = session.query(Angajati).filter(Angajati.Nume == credentials.Nume).first()
        if user and user.Prenume == credentials.Prenume:  # Ensure you hash and check the password securely
            return {"status": "success", "user_id": user.ID_Angajat}
        raise HTTPException(status_code=400, detail="Invalid credentials")