from sqlalchemy import BLOB, ForeignKey, inspect
from typing import Any, Optional
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import Column, Integer, String
from ORM_models.Base import Base
from Constante import PASSWORD,USER,HOST,PORT,SCHEMA_NAME


class LogAcces(Base):
    __tablename__="LogAcces"
    __table_args__ = {"schema": SCHEMA_NAME} 
    ID_Log= Column(Integer,primary_key=True, nullable=True, autoincrement=True)
    ID_Angajat = Column(Integer,  ForeignKey(f'{SCHEMA_NAME}.Angajati.ID_Angajat'), nullable=False)
    TipAcces= Column(Integer,nullable=False)
    OraAcces=Column(String,nullable=False)
    DataAcces=Column(String,nullable=True)
    Status=Column(Integer,nullable=True)
    
class LogAcces_pydantic(BaseModel):
    ID_Angajat: int= Field(default=None)
    ID_Utilizator: int= Field(default=None)
    TipAcces: int= Field(default=None)
    OraAcces: str= Field(default=None)
    DataAcces: str= Field(default=None)
    Status: int= Field(default=None)
    
    def init(self, data:Any):
        super().init(data)

    def get_db_object(self) -> LogAcces:
        return LogAcces(**self.__dict)