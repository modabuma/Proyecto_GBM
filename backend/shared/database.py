import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

base = declarative_base()

def get_session() -> object:
    engine = create_engine('mysql+pymysql://root:@localhost:3306/observability_center'
    )
    Session = sessionmaker(bind=engine)
    return Session()