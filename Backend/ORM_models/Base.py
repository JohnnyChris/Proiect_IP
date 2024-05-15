from sqlalchemy import inspect
from sqlalchemy.orm import DeclarativeBase

class Base(DeclarativeBase):
    def repr(self) -> str:
        return f"{self.tablename}"

    def getobjprimarykeysdict(self):
        columns = [key.name for key in inspect(self.__class).columns if key.primary_key == True]
        return {key:self.__dict[key] for key in columns}