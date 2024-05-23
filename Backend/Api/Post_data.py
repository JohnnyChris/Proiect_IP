from fastapi import APIRouter, FastAPI, HTTPException,Depends
from Backend import get_session
from ORM_models.Utilizatori import Utilizatori, Utilizatori_pydantic
from ORM_models.Angajati import Angajati_pydantic,Angajati
from sqlalchemy.orm import Session
from ORM_models.Utilizatori import Utilizatori


router = APIRouter(prefix="/post_data", tags=["post"])
app = FastAPI()


