from sqlalchemy import TIMESTAMP, ForeignKey, inspect
from typing import Any, Optional
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import Column, Integer, String
from ORM_models.Base import Base
from Constante import PASSWORD,USER,HOST,PORT,SCHEMA_NAME
from Angajati import Angajati

class InregistrarePrezenta(Base):
    __tablename__="InregistrarePrezenta"
    __table_args__ = {"schema": SCHEMA_NAME}
    ID_Inregistrare = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    ID_Angajat = Column(Integer,ForeignKey(Angajati.ID_Angajat) , nullable=False, autoincrement=True)
    DataIntrare = Column(TIMESTAMP, primary_key=True, nullable=False, autoincrement=True)
    OraIntrare = Column(TIMESTAMP, primary_key=True, nullable=False, autoincrement=True)
    OraIesire = Column(TIMESTAMP, primary_key=True, nullable=False, autoincrement=True)


  