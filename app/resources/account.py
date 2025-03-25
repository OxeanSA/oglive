from app.resources.errors import InternalServerError, UnauthorizedError, EmailDoesnotExistsError, PasswordLengthError, BadTokenError, ExpiredTokenError, EmailAlreadyExistsError
from flask_jwt_extended import create_access_token, create_refresh_token, jwt_required, get_jwt_identity
from jwt.exceptions import ExpiredSignatureError, DecodeError, InvalidTokenError
from app.services.user_service import add_user, get_user, update_user, get_user_by_id
from flask import make_response, request, jsonify, render_template
from flask_restx import Resource, Namespace, fields
#from app.services.mail_service import send_email
import datetime
import bcrypt
import random
import string

account_namespace = Namespace('account', description='A namespace for accounts')

login_model = account_namespace.model(
	'Login', {
		'email': fields.String,
		'password': fields.String
	}
)

signup_model = account_namespace.model(
	'Signup', {
		'firstname': fields.String,
		'lastname': fields.String,
		'email': fields.String,
		'password': fields.String
	}
)

forgot_password_model = account_namespace.model(
	'ForgotPassword', {
		'email': fields.String
	}
)

reset_password_model = account_namespace.model(
	'ResetPassword', {
		'password': fields.String
	}
)

userval_model = account_namespace.model(
	'Userval', {
		'user_id': fields.String,
		'access_token': fields.String,
		'refresh_token': fields.String
	}
)

@account_namespace.route('/login')
class LoginResource(Resource):
	@account_namespace.expect(login_model)
	def post(self):
		try:
			req = request.get_json()
			email = req.get('email')
			print(email)
			user = get_user(email)

			if user:
				password = req.get('password')
				print(password)
				passwordcheck = user['password']

				if bcrypt.checkpw(password.encode('utf-8'), passwordcheck):
					_iid =  str(user['user_id'])
					print("logging in")
					access_token = str(user['access_token'])
					refresh_token = create_refresh_token(identity=_iid)

					update_user(_iid, {"refresh_token": refresh_token})

					return make_response(jsonify({
						'status': "ok", 'user_id': _iid, 'access_token': access_token, 'refresh_token': refresh_token
					}), 200)
				else:
					raise UnauthorizedError
			else:
				raise UnauthorizedError

		except UnauthorizedError:
			raise UnauthorizedError

@account_namespace.route('/signup')
class SignupResource(Resource):
	@account_namespace.expect(signup_model)
	def post(self):
		try:
			req = request.get_json()
			email = req.get('email')
			firstname = req.get('firstname')
			lastname = req.get('lastname')
			password = req.get('password')

			if "" in [firstname, lastname, password, email]:
				raise UnauthorizedError

			else:
				if get_user(email):
					raise EmailAlreadyExistsError

				else:
					hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
					strc = string.ascii_lowercase + string.digits
					_iid = ''.join(random.choice(strc) for i in range(9))

					username = firstname.split()[0] + "" + lastname
					user_input = {'user_id': _iid, 'firstname': firstname, 'lastname': lastname, 'username': username, 'email': email, 'password': hashed, 'account_type': 'free', 'profile_ul': 'df'}

					add_user(user_input)

					access_token = create_access_token(identity=_iid)
					refresh_token = create_refresh_token(identity=_iid)

					update_user(_iid, {"access_token": access_token, "refresh_token": refresh_token})

#					send_email(
#						'[Test] Account confimation',
#						recipients=[email],
#						text_body='Account created successful',
#						html_body='<p>Account created successful</p>'
#					)

					return jsonify({
						'status': "ok", 'user_id': _iid, 'access_token': access_token, 'refresh_token': refresh_token
					})

		except EmailAlreadyExistsError:
			raise EmailAlreadyExistsError

@account_namespace.route('/forgot-password')
class ForgotPasswordResource(Resource):
	@account_namespace.expect(forgot_password_model)
	def post(self):
		url = request.host_url + 'reset-password/'
		try:
			body = request.get_json()
			email = body.get('email')
			user =  get_user(email)
			if not user:
				raise EmailDoesnotExistsError

			expires = datetime.timedelta(hours=12)
			reset_token = create_access_token(str(user['user_id']), expires_delta=expires)

#			return send_email(
#				'[Test] Reset your password',
#				sender='suppport@ogapp.com',
#				recipients=[user.email],
#				text_body=render_template('email/reset_password.txt', url=url + reset_token),
##				html_body=render_template('email/reset_password.html', url=url + reset_token)
#			)

		except EmailDoesnotExistsError:
			raise EmailDoesnotExistsError

		except Exception as e:
			raise InternalServerError

@account_namespace.route('/reset-password')
class ResetPasswordResource(Resource):
	@account_namespace.expect(reset_password_model)
	def post(self):
		try:
			body = request.get_json()
			email = body.get('email')
			password = body.get('password')
			if len(body.get('password')) < 6:
				raise PasswordLengthError

			user = get_user(email)
			hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

			update_user({"user_id": user['user_id']}, {"$set": {'password': hashed}})

#			return send_email(
#				'[Test] Password reset successful',
#				sender='dnx@ceera.com',
#				recipients=[user.email],
#				text_body='Password reset was successful!',
#				html_body='<p>Password reset was successful!</p>'
#			)

		except PasswordLengthError:
			raise PasswordLengthError

		except ExpiredSignatureError:
			raise ExpiredTokenError

		except (DecodeError, InvalidTokenError):
			raise BadTokenError

		except Exception as e:
			raise InternalServerError

@account_namespace.route('/refresh')
class RefreshResource(Resource):
	@jwt_required(refresh=True)
	def post(self):
		current_user = get_jwt_identity()
		new_access_token = create_access_token(identity=current_user)
		return make_response(jsonify({'access_token': new_access_token}), 200)

@account_namespace.route('/userval')
class UservalResource(Resource):
	@account_namespace.expect(userval_model)
	def post(self):
		try:
			req = request.get_json()
			_id = req.get('user_id')
			user = get_user_by_id(_id)

			print(user['user_id'])
			if user:
				access_token = req.get('access_token')
				refresh_token = req.get('refresh_token')
				print(access_token)
				print(user['access_token'])
				if user['access_token'] == access_token:
					if user['refresh_token'] == refresh_token:
						print(refresh_token)
						print("auth success")
						return make_response(jsonify({'status': 'ok', 'access_token': access_token, 'refresh_token': refresh_token}), 200)
					else:
						return make_response(jsonify({'status': "False"}), 200)
				else:
					return make_response(jsonify({'status': "False", 'access_token': access_token, 'refresh_token': refresh_token}), 200)
			else:
				raise UnauthorizedError

		except UnauthorizedError:
			raise UnauthorizedError
