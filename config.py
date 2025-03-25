import os

class BaseConfig(object):
    SECRET_KEY = 'o\xadlT\x97\x82\x1e[\xc6aeFv\x90\xdc\xcc'
    MAIL_SERVER = '192.168.43.3'
    MAIL_PORT = 1025
    MAIL_USERNAME = 'xr@dnx.net'
    MAIL_PASSWORD = 'kilodiouy@3'

class TestConfig(BaseConfig):
    TESTING = True
    DATABASE_URI = 'mongodb://localhost:27017/'

class DevelopmentConfig(BaseConfig):
    DEBUG = True
    MONGODB = 'mongodb://localhost:27017/'

class ProductionConfig(BaseConfig):
    DEBUG = False

    # Security
    SESSION_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_DURATION = 3600
    SECRET_KEY = 'o\xadlT\x97\x82\x1e[\xc6aeFv\x90\xdc\xcc'

    # Mail server
    MAIL_SERVER = '192.168.43.3'
    MAIL_PORT = 1025
    MAIL_USERNAME = 'xr@dnx.net'
    MAIL_PASSWORD = 'kilodiouy@3'

    # Mongo database
    MONGO_DATABASE_URI = '{}://{}:{}/@{}:{}'.format(
        "mongodb",
        "localhost",
        27017,
        "pass",
        "xseedb"
    )

# Load all possible configurations
config_dict = {
    'Production': ProductionConfig,
    'Base': BaseConfig
}
