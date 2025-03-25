from flask_restx import Resource, Namespace, fields
from app.resources.errors import UnauthorizedError, UserIsInvalidError
from app.services.database_service import get_user
from flask import request, make_response
from bson.json_util import dumps
#from app.models import PostsRec
from app.exts import _DB, authenticate, getTemplate

page_namespace = Namespace('page', description='Namespace for Pages and Templates')

page_model = page_namespace.model(
    'Main', {
        'user_id': fields.String,
        'refresh_token': fields.String,
        'access_token': fields.String,
        'page': fields.String,
        'version': fields.String
	}
)
view_model = page_namespace.model(
    'View', {
        'user_id': fields.String,
        'refresh_token': fields.String,
        'access_token': fields.String,
        'page': fields.String,
        'view_id': fields.String,
        'version': fields.String
	}
)
account_page_model = page_namespace.model(
    'Account_page', {
        'page': fields.String,
        'version': fields.String
	}
)

@page_namespace.route('/a')
class AuthPageResource(Resource):
    @page_namespace.expect(account_page_model)
    def post(self):
        try:
            req = request.get_json()
            version = req.get('version')
            page = req.get('page')

            _pages = [
                "login",
                "signup"
            ]
            if page in _pages:
                print(page)
                t = getTemplate(page, None, version)
                return make_response(t, 200)
            else:
                return make_response("", 200)

        except UserIsInvalidError:
            raise UserIsInvalidError
        
@page_namespace.route('/m')
class MainPageResource(Resource):
    @page_namespace.expect(page_model)
    @authenticate
    def post(self):
        try:
            req = request.get_json()
            _id = req.get('user_id')
            user = get_user(_id)
            version = req.get('version')
            page = req.get('page')

            _pages = [
                "home",
                "friends",
                "messages",
                "explore",
                "profile",
                "notifications",
                "calls",
                "new_post"
            ]
            if page in _pages:
                print(page)
                t = getTemplate(page, user, version)
                return make_response(t, 200)
            else:
                return make_response("", 200)

        except UserIsInvalidError:
            raise UserIsInvalidError

@page_namespace.route('/f')
class InnerPageResource(Resource):
    @page_namespace.expect(page_model)
    @authenticate
    def post(self):
        try:
            req = request.get_json()
            _id = req.get('user_id')
            user = get_user(_id)
            version = req.get('version')
            page = req.get('page')

            _pages = [
                "foryouposts",
                "videoposts",
                "marketposts",
                "popular",
                "live",
                "reels",
                "stories",
                "searches",
                "foryoufriends",
                "active_users",
                "user_messages"
            ]
            if page in _pages:
                t = getTemplate(page, user, version)
                return make_response(t, 200)
            else:
                return make_response("", 200)

        except UserIsInvalidError:
            raise UserIsInvalidError

@page_namespace.route('/i')
class ViewPageResource(Resource):
    @page_namespace.expect(view_model)
    @authenticate
    def post(self):
        try:
            req = request.get_json()
            _id = req.get('user_id')
            user = get_user(_id)
            version = req.get('version')
            page = req.get('page')
            view_id = req.get('view_id')

            data = [view_id, user]

            _pages = [
                "postview",
                "searchview",
                "profileview",
                "chatview",
                "storyview",
                "notificationview",
                "callview"
            ]
            if page in _pages:
                t = getTemplate(page, data, version)
                return make_response(t, 200)
            else:
                return make_response("", 200)

        except UserIsInvalidError:
            raise UserIsInvalidError
        
@page_namespace.route('/e')
class ViewExtendPageResource(Resource):
    @page_namespace.expect(view_model)
    @authenticate
    def post(self):
        try:
            req = request.get_json()
            _id = req.get('user_id')
            user = get_user(_id)
#           user = get_user(_id)
            version = req.get('version')
            page = req.get('page')
            view_id = req.get('view_id')

            data = [view_id, user]

            _pages = [
                "relatedposts"
            ]
            if page in _pages:
                t = getTemplate(page, data, version)
                return make_response(t, 200)
            else:
                return make_response("", 200)

        except UserIsInvalidError:
            raise UserIsInvalidError
        
        
