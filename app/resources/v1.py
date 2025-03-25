from flask_restx import Resource, Namespace, fields
from app.resources.errors import UnauthorizedError, UserIsInvalidError
from app.services.user_service import get_user_by_token, get_user_by_id
from flask import request, make_response
from bson.json_util import dumps
#from app.models import PostsRec
from app.exts import _DB, authenticate, getTemplate

v1_namespace = Namespace('v1', description='Namespace for v1 Pages and Templates')

v1_model = v1_namespace.model(
    'Pages', {
        'user_id': fields.String,
        'refresh_token': fields.String,
        'access_token': fields.String,
        'page': fields.String,
        'v': fields.String,
        'timeout': fields.Integer
	}
)

@v1_namespace.route('/pg')
class V1PageResource(Resource):
#    @authenticate
    def post(self):
        try:
            userAgent = request.args.get("c")
            pn = request.args.get("pn")
            uname = ""
            fname = ""
            try:
                nc = request.args.get("nc")
                a = request.args.get("a")
            except:
                a = None
                
                if userAgent != "og.1.0 (Android >=8.0)":
                    return make_response("Unathorized access", 403)
                error = None
                s = request.args.get("s")
                try:
                    qname = request.args.get("n")
                    if qname:
                        if '@' and '.' in qname:
                            try:
                                user = _DB.users.find_one({"email": qname})
                            except:
                                return make_response("Auth error", 400)
                        else:
                            try:
                                uname = qname.split()
                                fname = uname[0].capitalize()
                                lname = uname[1].capitalize()
                                user = _DB.users.find_one({"firstname": fname, "lastname": lname})
                            except:
                                return make_response("Auth error", 400)
                        t = getTemplate(pn, [{"user": user}], "v1")
                        return make_response(t, 200) 
                    else:
                        return 'error', 403
                except Exception as err:
                    return 'error', 403
        except UserIsInvalidError:
            raise UserIsInvalidError

