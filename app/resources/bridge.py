from flask import json , request , make_response
from flask_socketio import emit
from flask_restx import Resource, Namespace, fields
from app.resources.errors import UnauthorizedError, UserIsInvalidError
from app.services.database_service import get_user
from flask import request, make_response
from bson.json_util import dumps
#from app.models import PostsRec
from app.exts import _DB, authenticate, getTemplate

bridge_namespace = Namespace('bridge', description='Namespace for Bridges')

bridge_model = bridge_namespace.model(
    'Emit', {
        'user_id': fields.String,
        'refresh_token': fields.String,
        'access_token': fields.String,
        'route': fields.String,
        'receiver_id': fields.String,
        'message': fields.String,
        'version': fields.String
	}
)

@bridge_namespace.route('/emit')
class BridgeResource(Resource):
    @bridge_namespace.expect(bridge_model)
    @authenticate
    def post(self):
        try:
            req = request.get_json()
            _id = req.get('user_id')
            user = get_user(_id)
            receiver_id = req.get('receiver_id')
            route = req.get('route')
            message = req.get('message')

            print(_id)

            _routes = [
                "user_message",
                "group_message",
                "notification",
                "voice_call",
                "video_call"
            ]
            if route in _routes:
                print(_routes)
                emit(route,{"user_id": _id, route: _id,"message": message}, broadcast=True ,to=receiver_id , namespace='/') 
                return make_response('', 200)
            else:
                return make_response("", 200)

        except UserIsInvalidError:
            raise UserIsInvalidError

