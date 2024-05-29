from sqlalchemy import TIMESTAMP, Column, Integer, String, BLOB
from database import Base

class Users(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True)
    hashed_password = Column(String)

class Angajati(Base):
    __tablename__ = 'Angajati'
    ID_Angajat = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    ID_Utilizator = Column(Integer, nullable=True)
    username = Column(String(50), unique=True)
    Nume = Column(String(50), nullable=True)
    Prenume = Column(String(50), nullable=True)
    CNP = Column(String(13), nullable=True)
   #Poza = Column(BLOB, nullable=True)
    NumarLegitimatie = Column(Integer, nullable=True)
    Divizia = Column(String(50), nullable=True)
    IntervaleAcces = Column(String(100), nullable=True)
    CodSecuritateBluetooth = Column(String(50), nullable=True)
    NumarMasina = Column(String(11), nullable=True)
    AccesAuto = Column(Integer, nullable=True)
    

class InregistrarePrezenta(Base):
    __tablename__ = 'InregistrarePrezenta'
    ID_Inregistrare = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    username = Column(String(50), unique=True)
    ID_Angajat = Column(Integer, nullable=False)  
    DataIntrare = Column(String(50), nullable=False)
    OraIntrare = Column(String(50), nullable=False)
    OraIesire = Column(String(50), nullable=True)