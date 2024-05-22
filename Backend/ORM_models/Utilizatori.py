from sqlalchemy import BLOB, inspect
from typing import Any, Optional
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import Column, Integer, String
from ORM_models.Base import Base
from Constante import PASSWORD,USER,HOST,PORT,SCHEMA_NAME

class Utilizatori(Base):
    __tablename__="Utilizatori"
    __table_args__ = {"schema": SCHEMA_NAME}
    ID_Utilizator= Column(Integer, nullable=True,primary_key=True,autoincrement=True)
    Username=Column(String(50),nullable=True)
    Parola=Column(String(50),nullable=True)
    Rol=Column(String(50),nullable=True)
    
    
class Utilizatori_pydantic(BaseModel):
    ID_Utilizator: int=Field(default=None)
    Username: str=Field(default=None)
    Parola: str=Field(default=None)
    Rol: str=Field(default=None)
    
    def init(self, data:Any):
        super().init(data)

    def get_db_object(self) -> Utilizatori:
        return Utilizatori(**self.__dict)