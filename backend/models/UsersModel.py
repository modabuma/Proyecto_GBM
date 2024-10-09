import json

from sqlalchemy import Column, Integer, String, Text, TIMESTAMP, func, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.mysql import TINYINT
from sqlalchemy.orm import sessionmaker
import math
import bcrypt

from shared.custom_exceptions import NotFoundError
from shared.database import base
from .QueriesMixin import QueriesMixin

class UsersModel(QueriesMixin, base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True)
    email = Column(String, nullable=False)
    password = Column(Text, nullable=False)
    name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    active = Column(TINYINT, nullable=False, default=1)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(TIMESTAMP, server_default=func.current_timestamp(), onupdate=func.current_timestamp())
    role = Column(TINYINT, nullable=False)
    
    def __init__(self, payload: dict = {}):
        self.email = payload.get("email", "")
        self.password = self.hash_password(payload.get("password", ""))
        self.name = payload.get("name","")
        self.last_name = payload.get("last_name","")
        self.role = payload.get("role","")
    
    def hash_password(self, password: str) -> str:
        salt = bcrypt.gensalt()
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
        return hashed_password.decode('utf-8')
    
    def verify_password(self, password_: str) -> bool:
        return bcrypt.checkpw(password_.encode('utf-8'), self.password.encode('utf-8'))
          
    def __repr__(self) -> str:
        return json.dumps(
            {
                "id": self.id,
                "email": self.email,
                "active": self.active,
                "name": self.name,
                "last_name": self.last_name,
                "created_at": str(self.created_at),
                "updated_at": str(self.updated_at),
                "role" : self.role
            }
        )
    
    def get_data_diff(self, session: sessionmaker) -> any:
        
        return getattr(
            session.query(self.__class__).filter(self.__class__.role != 1 ), "all")()    