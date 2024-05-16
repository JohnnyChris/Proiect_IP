from sqlalchemy import Inspector, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import inspect
from Constante import PASSWORD,USER,HOST,PORT,SCHEMA_NAME

def get_engine():
    return create_engine(url=f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}")
    
def get_session():
    session = sessionmaker(bind = get_engine())
    return session()

def tables():
    engine = get_engine()
    insp = inspect(engine)
    print(insp.get_table_names(SCHEMA_NAME))
tables()