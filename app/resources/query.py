from flask_restx import Resource, Namespace, fields
from app.resources.errors import UnauthorizedError, UserIsInvalidError
from app.services.user_service import get_user_by_token, get_user_by_id
from flask import request
from bson.json_util import dumps
#from app.models import PostsRec
from app.exts import _DB, authenticate

query_namespace = Namespace('query', description='Namespace for inner queries')

posts_model = query_namespace.model(
	'Posts', {
		'refresh_token': fields.String,
		'access_token': fields.String,
		'ptype': fields.String,
		'np': fields.Integer
	}
)

stories_model = query_namespace.model(
	'Stories', {
		'refresh_token': fields.String,
		'access_token': fields.String,
		'ns': fields.Integer
	}
)

@query_namespace.route('/posts')
class PostsResource(Resource):
	@query_namespace.expect(posts_model)
	@authenticate
	def post(self):
		try:
			req = request.get_json()
			token = req.get('access_token')
			nposts = req.get('np')
			ptype = req.get('ptype')

			print(token)
			user = get_user_by_token(token)
			_uid = user['user_id']
#			_uid = self.user['user_id']

#			p_rec = PostsRec()
#			recs = p_rec.recommend_subset(p_rec.single_user_subset(_uid), nposts)
#			recs = p_rec.recommend_subset(p_rec.single_user_subset(_uid), 25)
#			recs_ = [str(i[0]) for i in recs.select('recommendations').collect()]

#			print(recs_)

#			rec_user_ids = [int(i.split("=")[1].split(", ")[0]) for i in recs_[0].split("Row(")[1:] ]
#			_items = [int(i.split("=")[1].split(", ")[0]) for i in recs_[0].split("Row(")[1:]]

#			return dumps(_items)

		except UserIsInvalidError:
			raise UserIsInvalidError


@query_namespace.route('/stories')
class StoriesResource(Resource):
	@authenticate
	@query_namespace.expect(stories_model)
	def post(self):
		try:
			req = request.get_json()
			_uid = req.get('userid')
			access_token = req.get('access_token')
			nposts = req.get('ns')
			user = get_user_by_id(_uid)

			if user['access_token'] == access_token:

				_items = _DB().stories.find({}, {'_id': False})

				return dumps(_items)
			else:
				raise UnauthorizedError
		except UnauthorizedError:
			raise UnauthorizedError


