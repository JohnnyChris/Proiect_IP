from sqlalchemy import BLOB, ForeignKey, inspect
from typing import Any, Optional
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import Column, Integer, String
from ORM_models.Base import Base
from Constante import PASSWORD,USER,HOST,PORT,SCHEMA_NAME


class Angajati(Base):
    __tablename__="Angajati"
    __table_args__ = {"schema": SCHEMA_NAME}
    ID_Angajat = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    ID_Utilizator= Column(Integer, ForeignKey(f'{SCHEMA_NAME}.Utilizatori.ID_Utilizator'), nullable=True)
    Nume = Column(String(50), nullable=True)
    Prenume = Column(String(50), nullable=True)
    CNP = Column(String(13), nullable=True)
    Poza = Column(String(50),nullable=True)
    NumarLegitimatie= Column(Integer,nullable=True)
    Divizia=Column(String(50),nullable=True)
    IntervaleAcces=Column(String(100),nullable=True)
    CodSecuritateBluetooth=Column(String(50),nullable=True)
    NumarMasina=Column(String(11),nullable=True)
    AccesAuto=Column(Integer,nullable=True)

class Angajati_pydantic(BaseModel):
    ID_Angajat :int = Field(default=None)
    ID_Utilizator :int = Field(default=None)
    Nume: str = Field(default=None)
    Prenume: str = Field(default=None)
    CNP: str = Field(default=None)
    Poza: str = Field(default=None)
    NumarLegitimatie: str = Field(default=None)
    Divizia: str = Field(default=None)
    IntervaleAcces:str=Field(default=None)
    CodSecuritateBluetooth:str=Field(default=None)
    NumarMasina:str=Field(default=None)
    AccesAuto:int=Field(default=None)

    def init(self, data:Any):
        super().init(data)

    def get_db_object(self) -> Angajati:
        return Angajati(**self.__dict)