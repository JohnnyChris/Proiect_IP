from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
from fastapi import Depends
from database import SessionLocal, engine
from models import Angajati

router = APIRouter()

class LoginRequest(BaseModel):
    email: str
    password: str

@router.post("/login")
async def login(request: LoginRequest, db: Session = Depends(SessionLocal)):
    user = db.query(Angajati).filter(Angajati.email == request.email).first()
    if user and user.password == request.password:  # Ensure you hash and check the password securely
        return {"status": "success", "user_id": user.ID_Angajat}
    raise HTTPException(status_code=400, detail="Invalid credentials")

# Don't forget to include the router in your main FastAPI app
