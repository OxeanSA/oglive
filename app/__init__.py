from flask import Flask
from flask_restx import Api
from flask.logging import default_handler
from flask_jwt_extended import JWTManager
from flask_cors import CORS
from tornado.httpserver import HTTPServer
from tornado.wsgi import WSGIContainer
from app.exts import handle_requests, handle_sockets
from app.resources.query import query_namespace
from app.resources.account import account_namespace
from app.resources.pages import page_namespace
from app.resources.v1 import v1_namespace
from flask_socketio import SocketIO

def create_app(host):
    app = Flask(__name__)

#    app.logger.removeHandler(default_handler)
    app.config.from_object('config.DevelopmentConfig')

    JWTManager(app)
    CORS(app)
    
    socketio = SocketIO(app)
    
    api = Api(app, title='OG API', version='2.0 beta', doc='/')
    api.add_namespace(query_namespace, path='/query')
    api.add_namespace(account_namespace, path='/account')
    api.add_namespace(page_namespace, path='/page')
    api.add_namespace(v1_namespace, path='/v1')

    handle_requests(app)
    handle_sockets(socketio, app)
    app.run()
#    server = HTTPServer(WSGIContainer(app))
#    return server



