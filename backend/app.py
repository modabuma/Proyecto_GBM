import os
from datetime import timedelta

from flask_jwt_extended import JWTManager
from flask import Flask
from flask_cors import CORS

from routes.auth import auth
from shared.blacklist import blacklist

app = Flask(__name__)
CORS(app)

app.config["JWT_SECRET_KEY"] = "SECRET_KEY"
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(hours=24)
app.config['JWT_BLACKLIST_ENABLED'] = True
app.config['JWT_BLACKLIST_TOKEN_CHECKS'] = ['access']
jwt = JWTManager(app)

@jwt.token_in_blocklist_loader
def check_if_token_revoked(jwt_header, jwt_payload):
    jti = jwt_payload['jti']
    return jti in blacklist

app.register_blueprint(auth)