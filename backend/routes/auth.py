import json
from flask_jwt_extended import create_access_token, create_refresh_token, jwt_required, get_jwt, get_jwt_identity
from flask import Blueprint, jsonify

from shared.loader import load_data
from shared.blacklist import blacklist
from controllers.AuthController import AuthController

auth = Blueprint("auth", __name__, url_prefix="/auth")

@auth.post("/login")
@load_data
def login(session, payload) -> dict:
    auth_controller = AuthController(session)
    
    response = auth_controller.authenticate(payload)
    
    return jsonify(
        {
            "message": "Autenticación exitosa.",
            "data": {
                "access_token": create_access_token(identity=response),
                "refresh_token": create_refresh_token(identity=response)
            }
        }
    )

@auth.post("/register")
@load_data
def register(session, payload) -> dict:
    auth_controller = AuthController(session)
    
    response = auth_controller.register(payload)
    
    return jsonify(
        {
            "message": "Registro exitoso.",
        }
    ), 201


@auth.get("/refresh")
@jwt_required(refresh=True)
def refresh():
    payload = get_jwt_identity()
    
    return jsonify(
        {
            "message": "Sesión refrescada con éxito.",
            "data": {
                "access_token": create_access_token(identity=payload),
            }
        }
    )


@auth.get("/logout")
@jwt_required()
def logout():
    jti = get_jwt()["jti"]
    blacklist.add(jti)
    return jsonify(
        {
            "message": "Se cerró la sesión con éxito."
        }    
    )


@auth.get('/logout_refresh')
@jwt_required(refresh=True)
def logout_refresh():
    jti = get_jwt()['jti']
    blacklist.add(jti)
    return jsonify(
        {
            "message": "Se cerró la sesión con éxito."
        }    
    )

@auth.post("/getUsers")
@load_data
def getUsers(session, payload) -> dict:
    auth_controller = AuthController(session)
    
    response = auth_controller.get_users(payload)
    
    return jsonify(
        {
            "message": "Servicio exitoso.",
            "data" : json.loads(str(response))
        }
    )

@auth.post("/registerRest")
@load_data
def registerRest(session, payload) -> dict:
    auth_controller = AuthController(session)
    
    auth_controller.registerRest(payload)
    
    return jsonify(
        {
            "message": "Registro exitoso.",
        }
    ), 201

@auth.get("/generateExcel")
@load_data
def generateExcel(session) -> dict:
    auth_controller = AuthController(session)
    
    response = auth_controller.generateExcel()
    
    return jsonify(
        {
            "message": "Reporte generado exitosamente.",
            "data": response
        }
    ), 200