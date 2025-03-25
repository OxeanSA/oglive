from app.services.database_service import save_message
from flask import make_response, request, jsonify
from jinja2 import Environment, FileSystemLoader
#from app.models.CollaborativeFiltering import recommend
from app.resources.errors import BadTokenError
from pymongo import MongoClient
from datetime import datetime
from functools import wraps
from flask import g
import sqlite3
import timeago
import string
import socket
import random
import json
import chardet
import re
import os

_versions = [
    "1.0",
    "1.0.1",
    "1.0.2",
    "beta"
]

uri = "mongodb+srv://oxeansa:oxeanpass1@cluster0.sh0vm.mongodb.net/?appName=Cluster0"

def _DB():
    client = MongoClient(uri)
    db = client.get_database("v2db")
    return db

def raw_db_con():
    db = sqlite3.connect(os.path.dirname(os.path.abspath(__file__)) + "/resources/rawdb/db1.db")
    db.row_factory = sqlite3.Row
    return db

def populate():
    enc = chardet.detect(open(os.path.dirname(os.path.abspath(__file__)) + '/resources/rawdb/users-export.json', "rb").read())['encoding']
    with open(os.path.dirname(os.path.abspath(__file__)) + '/resources/rawdb/users-export.json', "r", encoding=enc) as file:
        file_data = json.load(file)
        collection = _DB().users
        if isinstance(file_data, list):
            collection.insert_many(file_data)
        else:
            collection.insert_one(file_data)

def get_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("0.0.0.0", 80))
        return s.getsockname()[0]
    except:
        return "127.0.0.1"

def is_email(email):
    pattern = re.compile(r'([A-Za-z0-9]+[.-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\.[A-Z|a-z]{2,})+')
    return re.fullmatch(pattern, email)

def authenticate(func):
    @wraps(func)
    def decorator(*args, **kwargs):
        req = request.get_json()
        _id = req.get('user_id')
        user = _DB().users.find_one({'user_id': _id})
        access_token = req.get('access_token')
        refresh_token = req.get('refresh_token')
        if user:
            if user['access_token'] == access_token:
                if user['refresh_token'] == refresh_token:
                    return func(*args, **kwargs)
                else:
                    raise BadTokenError
            else:
                raise BadTokenError
        else:
            raise BadTokenError
    return decorator

#def authenticate(func):
#    @wraps(func)
#    def decorator(*args, **kwargs):
#        req = request.headers
#        access_token = ''
#        refresh_token = ''
#        user = []
#        if 'access_token' in req:
#            access_token = req['access_token']
#            refresh_token = req['refresh_token']
#            user = _DB().users.find_one({"access_token": access_token})
#            if user['refresh_token'] == refresh_token:
#                return func(*args, **kwargs)
#            else:
#                raise BadTokenError
#        else:
#            raise access_denied
#    return decorator

def getTemplate(page, u_data, version):
    sql_db = raw_db_con()
    data = u_data
    _vars = ""
    
    if page == "login":
        path = "layouts/login.asp"
        
    elif page == "signup":
        path = "layouts/signup.asp"
        
    elif page == "home":
        path = "layouts/home.asp"
        
    elif page == "friends":
        path = "layouts/friends.asp"
        
    elif page == "messages":
        path = "layouts/messages.asp"
        
    elif page == "explore":
        path = "layouts/explore.asp"
        
    elif page == "profile":
        path = "layouts/profile.asp"
    
    elif page == "notifications":
        path = "layouts/notifications.asp"
        
    elif page == "calls":
        path = "layouts/calls.asp"
        
    elif page == "foryouposts":
        if version == "1.0":
            path = "v1/posts.asp"
            _id = u_data['user_id']
            posts = sql_db.execute(f"SELECT * FROM posts LEFT JOIN users ON users.user_id=posts.uid WHERE posts.uid!='{_id}' ORDER BY random()").fetchall()
            data = posts
        elif version == "beta":
            path = "extends/posts.asp"
            data = _DB().posts.aggregate([
                {
                    '$lookup':
                    {
                        'from': "users",
                        'localField': "user_id",
                        'foreignField': "user_id",
                        'as': "user_id"
                    }
                }
                
            ])
            """ {
                    '$set':
                    {
                        'user_id':
                        {
                            '$first': '$user_id'
                        }
                    }
                } """
#            data = ContentBasedFiltering.recommend("posts")

    elif page == "stories":
        path = "v1/stories.asp"
        _id = u_data['user_id']
        stories = sql_db.execute(f"SELECT * FROM stories LEFT JOIN users ON users.user_id=stories.uid WHERE stories.uid!='{_id}' ORDER BY RANDOM()").fetchall()
        data = stories
    
    elif page == "videoposts":
        path = "v1/posts.asp"
        _id = u_data['user_id']
        _vars = "videos"
        posts = sql_db.execute(f"SELECT * FROM posts LEFT JOIN users ON users.user_id=posts.uid WHERE posts.uid!='{_id}' AND posts.post_type=='video' ORDER BY random()").fetchall()
        data = posts
    
    elif page == "marketposts":
        path = "v1/posts.asp"
        _id = u_data['user_id']
        _vars = "market"
        posts = sql_db.execute(f"SELECT * FROM posts LEFT JOIN users ON users.user_id=posts.uid WHERE posts.uid!='{_id}' AND posts.priority=='private' ORDER BY random()").fetchall()
        data = posts
        
    elif page == "postview":
        path = "v1/intn/postview.asp"
        post = sql_db.execute(f"SELECT * FROM posts LEFT JOIN users ON users.user_id=posts.uid WHERE posts.post_id=='{u_data[0]}'").fetchall()
        data = post
        
    elif page == "relatedposts":
        path = "v1/int_posts/relatedposts.asp"
        leftcolumn = sql_db.execute(f"SELECT * FROM posts LEFT JOIN users ON users.user_id=posts.uid ORDER BY RANDOM()").fetchall()
        rightcolumn = sql_db.execute(f"SELECT * FROM posts LEFT JOIN users ON users.user_id=posts.uid ORDER BY RANDOM()").fetchall()
        data = [leftcolumn, rightcolumn]
        
    elif page == "foryoufriends":
        path = "v1/int_friends/foryoufriends.asp"
        _id = u_data['user_id']
        friends = sql_db.execute(f"SELECT * FROM users ORDER BY RANDOM()").fetchall()
        data = friends
         
    elif page == "storyview":
        path = "v1/intn/storyview.asp"
        user_story = sql_db.execute(f"SELECT * FROM stories LEFT JOIN users ON users.user_id=stories.uid WHERE stories.story_id=='{u_data[0]}'").fetchone()
        data = user_story
        
    elif page == "profileview":
        path = "v1/intn/profileview.asp"
        user_profile = sql_db.execute(f"SELECT * FROM users WHERE users.user_id=='{u_data[0]}'").fetchone()
        data = user_profile
        
    elif page == "chatview":
        path = "v1/intn/chatview.asp"
        user_profile = u_data[0]
        data = user_profile
        
    elif page == "active_users":
        path = "v1/active_users.asp"
        active_users = sql_db.execute(f"SELECT * FROM users ORDER BY random()").fetchall()
        data = active_users

    elif page == "user_messages":
        path = "v1/user_messages.asp"
        u_msgs = sql_db.execute(f"SELECT * FROM messages LEFT JOIN users ON users.user_id=messages.sender_id WHERE messages.uid=='{id}' GROUP BY messages.sender_id ORDER BY time DESC").fetchall()
        data = u_msgs

    else:
        path = "v1/err_pages/403.asp"
    
    if version not in _versions:
        path = "v1/err_pages/403.asp"
        
    env = Environment(loader=FileSystemLoader(os.path.dirname(__file__) + "/templates/"))
    t = env.get_template(path)
    return t.render(data=data, pape=page, var=_vars, conn=sql_db, _ipaddr=get_ip(), helpers=PageHelpers)

class PageHelpers:
    def _tags(regex, text):
        tag_list = re.findall(regex, text)
        for tag in tag_list:
            return tag

    def _random_str(length, st='chars'):
        strc = None
        if st == 'chars':
            strc = string.ascii_letters
        elif st == 'digits':
            strc = string.digits
        elif st == 'lowerdouble':
            strc = string.ascii_lowercase + string.digits
        result_str = ''.join(random.choice(strc) for i in range(length))
        return (result_str)

    def _time(dt):
        dtm = datetime.strptime(dt, "%d/%m/%Y")
        now = datetime.now()
        dt = timeago.format(now, dtm, 'en_short')
        dt = dt.replace('in ', '')
        if "mo" in dt:\
            dt = dtm.strftime("%d %b")
        return dt

    def _trim(text, length):
        if len(text) > length:
            text = text[0:+length]+".."
            return text
        else:
            return text

    def _look(intg, lst):
        try:
            if intg in lst:
                return True
            else:
                return False
        except:
            return False
        
def handle_requests(app):

    @app.after_request
    def apply_caching(response):
        response.headers['Strict-Transport-Security'] = 'max-age=315360; includeSubDomains'
        response.headers['X-Content-Type-Options'] = 'nosniff'
        response.headers['X-Frame-Options'] = 'SAMEORIGIN'
        response.headers['X-XSS-Protection'] = '1; mode=block'
        return response
    
def handle_sockets(soc, app):
    @soc.on("send_message")
    def handle_send_message_event(data) -> None:
        """
        Handle the sent message event from socket.on() in javascript.

        :param data: JSON data parsed from javascript.
        :return: None
        """
        app.logger.info(f"{data['user_id']} message {data['message']}")
        save_message(room_id=data['room_id'], text=data['message'], sender=data['username'])
        soc.emit("receive_message", data, room=data["room_id"])
        # from backend to frontend, we should handle this event in javascript.
