from fastapi import APIRouter, FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from Backend import get_session
from ORM_models.Utilizatori import Utilizatori, Utilizatori_pydantic
from ORM_models.Angajati import Angajati_pydantic, Angajati

router = APIRouter(prefix="/get_data", tags=["get"])
app = FastAPI()
app.include_router(router)

# Dependency to get DB session
def get_db():
    db = get_session()
    try:
        yield db
    finally:
        db.close()

# Verificare id
@router.get("/Username", response_model=Utilizatori_pydantic)
def get_Username(username: str, db: Session = Depends(get_db)):
    username_utilizator = db.query(Utilizatori).filter(Utilizatori.Username == username).first()
    if not username_utilizator:
        raise HTTPException(status_code=404, detail="User not found")
    return username_utilizator

# Verificare Parola
@router.get("/Password")
def get_Password(Pass: str, db: Session = Depends(get_db)):
    parola_utilizator = db.query(Utilizatori).filter(Utilizatori.Parola == Pass).first()
    if parola_utilizator:
        return {"message": "Password exists"}
    else:
        raise HTTPException(status_code=404, detail="Invalid password")

# Login endpoint
@router.post("/login")
def login(username: str, password: str, db: Session = Depends(get_db)):
    username_utilizator = db.query(Utilizatori).filter(Utilizatori.Username == username).first()
    if not username_utilizator:
        raise HTTPException(status_code=404, detail="User not found")

    parola_utilizator = db.query(Utilizatori).filter(Utilizatori.Username == username, Utilizatori.Parola == password).first()
    if not parola_utilizator:
        raise HTTPException(status_code=404, detail="Invalid password")

    return {"message": "Login successful"}

# Afisare informatii dupa id
@router.get("/Informatii_Utilizator", response_model=Angajati_pydantic)
def get_Informatii(id: int, db: Session = Depends(get_db)):
    informatii = db.query(Angajati).filter(Angajati.ID_Utilizator == id).first()
    if not informatii:
        raise HTTPException(status_code=404, detail="User not found")
    return informatii
