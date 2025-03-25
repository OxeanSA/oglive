from flask import render_template, request
from flask_restx import Resource, Namespace, fields

from flask_jwt_extended import create_access_token, decode_token
from jwt.exceptions import ExpiredSignatureError, DecodeError, InvalidTokenError

from app.resources.errors import InternalServerError, EmailDoesnotExistsError, PasswordLengthError, BadTokenError, ExpiredTokenError

from app.services.mail_service import send_email
from app.exts import _DB
import datetime
import bcrypt

reset_password_namespace = Namespace('reset', description='A namespace for reset password')
users_db = _DB().users

forgot_password_model = reset_password_namespace.model(
	'ForgotPassword', {
		'email': fields.String
	}
)

reset_password_model = reset_password_namespace.model(
	'ResetPassword', {
		'password': fields.String
	}
)

@reset_password_namespace.route('/forgot-password')
class ForgotPasswordResource(Resource):
	@reset_password_namespace.expect(forgot_password_model)
	def post(self):
		url = request.host_url + 'reset-password/'
		try:
			body = request.get_json()
			email = body.get('email')
			user =  users_db.find_one({"email": email})
			if not user:
				raise EmailDoesnotExistsError

			expires = datetime.timedelta(hours=12)
			reset_token = create_access_token(str(user['id']), expires_delta=expires)

			return send_email(
				'[Test] Reset your password',
				sender='suppport@ceera.com',
				recipients=[user.email],
				text_body=render_template('email/reset_password.txt', url=url + reset_token),
				html_body=render_template('email/reset_password.html', url=url + reset_token)
			)

		except EmailDoesnotExistsError:
			raise EmailDoesnotExistsError

		except Exception as e:
			raise InternalServerError

@reset_password_namespace.route('/reset-password')
class ResetPasswordResource(Resource):
	@reset_password_namespace.expect(reset_password_model)
	def post(self):
		try:
			body = request.get_json()
			email = body.get('email')
			password = body.get('password')
			if len(body.get('password')) < 6:
				raise PasswordLengthError
			
			user = users_db.find_one({"email": email})
			hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
			user_input = {'password': hashed}

			# Change to upgrade currrent password
			users_db.insert_one(user_input)
	
			return send_email(
				'[Test] Password reset successful',
				sender='dnx@ceera.com',
				recipients=[user.email],
				text_body='Password reset was successful!',
				html_body='<p>Password reset was successful!</p>'
			)

		except PasswordLengthError:
			raise PasswordLengthError

		except ExpiredSignatureError:
			raise ExpiredTokenError

		except (DecodeError, InvalidTokenError):
			raise BadTokenError

		except Exception as e:
			raise InternalServerError