from sqlalchemy import  ForeignKey, inspect
from typing import Any, Optional
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import Column, Integer, String
from ORM_models.Base import Base
from sqlalchemy.orm import relationship
from Constante import PASSWORD,USER,HOST,PORT,SCHEMA_NAME
from Angajati import Angajati

class InregistrarePrezenta(Base):
    __tablename__="InregistrarePrezenta"
    __table_args__ = {"schema": SCHEMA_NAME}
    ID_Inregistrare = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    ID_Angajat = Column(Integer, ForeignKey(f'{SCHEMA_NAME}.Angajati.ID_Angajat') , nullable=False, autoincrement=True)
    DataIntrare = Column(String, primary_key=True, nullable=False, autoincrement=True)
    OraIntrare = Column(String, primary_key=True, nullable=False, autoincrement=True)
    OraIesire = Column(String, primary_key=True, nullable=False, autoincrement=True)

class InregistrarePrezenta_pydantic(BaseModel):
    ID_Inregistrare: int = Field(default=None) 
    ID_Angajat: int = Field(default=None)
    DataIntrare: str = Field(default=None)
    OraIntrare: str=Field(default=None)
    OraIesire: str=Field(default=None)

    def init(self, data:Any):
        super().init(data)

    def get_db_object(self) -> InregistrarePrezenta:
        return InregistrarePrezenta(**self.__dict)