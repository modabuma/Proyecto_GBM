from sqlalchemy.orm import sessionmaker

from models.UsersModel import UsersModel
from shared.custom_exceptions import BadCredentialsError, NotFoundError

class AuthController:
    def __init__(self, session: sessionmaker):
        self.session = session
        
    def authenticate(self, payload: dict) -> dict:
        user_model = UsersModel()
        
        response = user_model.get_data(self.session, {
            "email": payload["email"], "role": 1,
            "active": 1
        })
        
        if not response:
            raise BadCredentialsError("El correo ingresado no coincide.")

        if not response.verify_password(payload["password"]):
            raise BadCredentialsError("La contraseña ingresada no coincide.")
            
        
        return {
            "id": response.id,
            "names": response.name,
            "lastnames": response.last_name
        }
    
    def register(self, payload:dict) ->dict:
        user_model = UsersModel()
        user_model.insert_data(self.session, payload)

    def get_users(self, payload:dict) ->dict:
        user_model = UsersModel()

        if "role" not in payload or payload["role"] == "0":
            users = user_model.get_data_diff(self.session)
        else:
            users = user_model.get_data(self.session, payload, "all")
     
        if not users:
            raise NotFoundError("No existen usuarios.")
        return users
