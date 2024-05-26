from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

#URL_DATABASE = 'mysql+pymysql://root:admin@localhost:3306/blogapplication'
URL_DATABASE = 'mysql+pymysql://ulthmvhrvmx0ykdw:NdJoZz8ELnBDE7N343nK@byrowjk8t7iswcuuyell-mysql.services.clever-cloud.com:3306/byrowjk8t7iswcuuyell'

#SQLALCHEMY_DATABSE_URL = 'sqlite:///./todosapp.db'

engine = create_engine(URL_DATABASE)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()