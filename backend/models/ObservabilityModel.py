import json

from sqlalchemy import Column, Integer, String, Text, TIMESTAMP, func, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.mysql import TINYINT
from sqlalchemy.orm import sessionmaker
import math
import bcrypt
from datetime import datetime

from shared.custom_exceptions import NotFoundError
from shared.database import base
from .QueriesMixin import QueriesMixin

class ObservabilityModel(QueriesMixin, base):
    __tablename__ = "observability"
    
    id = Column(Integer, primary_key=True)
    name_rest = Column(String, nullable=False)
    last_name_rest = Column(String, nullable=False)
    name_not_rest = Column(String, nullable=False)
    last_name_not_rest = Column(String, nullable=False)  
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    updated_at = Column(TIMESTAMP, server_default=func.current_timestamp(), onupdate=func.current_timestamp())
    
    def __init__(self, payload: dict = {}):

        self.name_rest = payload.get("name_rest", "")
        self.last_name_rest = payload.get("last_name_rest", "")
        self.name_not_rest = payload.get("name_not_rest","")
        self.last_name_not_rest = payload.get("last_name_not_rest","")
                  
    def __repr__(self) -> str:
        return json.dumps(
            {
                "id": self.id,
                "name_rest": self.name_rest,
                "last_name_rest": self.last_name_rest,
                "name_not_rest": self.name_not_rest,
                "last_name_not_rest": self.last_name_not_rest,
                "created_at": str(self.created_at),
                "updated_at": str(self.updated_at)
            }
        )