import logging
import os
from datetime import datetime
from functools import wraps
from random import choice
from typing import Callable, Any

from flask import jsonify, Response, abort, url_for
from flask_login import current_user, logout_user
from pymongo.errors import DuplicateKeyError, PyMongoError
from pymongo.mongo_client import MongoClient
from werkzeug.security import generate_password_hash

uri = "mongodb+srv://oxeansa:oxeanpass1@cluster0.sh0vm.mongodb.net/?appName=Cluster0"

client = MongoClient(uri)

# database
_db = client.get_database("v2db")

# collections: tables
users_collection = _db.get_collection("users")
posts_collection = _db.posts.aggregate([
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
likes_collection = _db.likes.aggregate([
    {
        '$lookup':
            {
                'from': "posts",
                'localField': "post_id",
                'foreignField': "post_id",
                'as': "post_id"
            }
    }
])
comments_collection = _db.comments.aggregate([
    {
        '$lookup':
            {
                'from': "posts",
                'localField': "post_id",
                'foreignField': "post_id",
                'as': "post_id"
            }
    }
])
forwards_collection = _db.get_collection("forwards").aggregate([
    {
        '$lookup':
            {
                'from': "posts",
                'localField': "post_id",
                'foreignField': "post_id",
                'as': "post_id"
            }
    }
])
group_chats_collection = _db.get_collection("group_chats")
group_chat_members_collection = _db.get_collection("goup_chat_members")
messages_collection = _db.get_collection("messages").aggregate([
    {
        '$lookup':
            {
                'from': "users",
                'localField': "sender_id",
                'foreignField': "user_id",
                'as': "user_id"
            }
    }
])
notifications_collection = _db.get_collection("notifications").aggregate([
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

# User Operations
def get_user(user_id: int) -> dict:
    """
    Gets the data of user from the database by unique `user_id`
    :param user_id: User id sent
    :returns: User Object
    :rtype: Dict
    """
    user_data = users_collection.find_one({"user_id": user_id})
    return user_data if user_data else None


def save_user(user_id: str, email: str, password: str) -> Response:
    """
    Saves a user to database.

    :param user_id: user_id of the user that will be created.
    :param email: email of the user that will be created.
    :param password: password of the user that will be created.
    :return: Response
    """
    try:
        users_collection.insert_one({
            "user_id": user_id,
            "email": email,
            "password": generate_password_hash(password)

        })
    except DuplicateKeyError:
        return jsonify({
            "status": False,
            "message": "user_id has already been taken! try different one"
        })

    return jsonify({
        "status": True,
        "message": "Registration Success! Redirecting to the login page",
        "redirectUrl": url_for("authentication.login")
    })

def db_change_user_id(old_user_id: str, new_user_id: str) -> Response:
    """
    Updates the user_id of the current user in the database.

    :param old_user_id: current user's user_id
    :param new_user_id: The new user_id to set for the current user.
    :type old_user_id: str    :type new_user_id: str

    :returns: A Response object indicating the status of the user_id update.
    :rtype: Response
    """
    try:
        # Update the user_id in the users_collection
        users_collection.update_one(
            {"user_id": old_user_id},
            {"$set": {"user_id": new_user_id}},
        )

        # Update the user_id in the chat_members collection where added_by matches the old user_id
        group_chat_members_collection.update_many(
            {"$and": [{"user_id": old_user_id}, {"added_by": old_user_id}]},
            {"$set": {"user_id": new_user_id, "added_by": new_user_id}},
        )

        # Update the user_id in the chats collection
        group_chats_collection.update_many(
            {"created_by": old_user_id},
            {"$set": {"created_by": new_user_id}},
        )

        # Update the sender information in messages collection
        messages_collection.update_many(
            {"sender": old_user_id},
            {"$set": {"sender": new_user_id}}
        )

    except DuplicateKeyError:
        return jsonify({
            "status": False,
            "message": "This user_id already in use, try different one!",
            "alertDiv": ".user_idAlert"
        })

    except PyMongoError:
        return jsonify({
            "status": False,
            "message": "An error occurred when writing to the database, try again later!",
            "alertDiv": ".user_idAlert"
        })

    return jsonify({
        "status": True,
        "message": "Changed user_id successfully",
        "alertDiv": ".user_idAlert"
    })


def db_change_email(user_id: str, new_email: str) -> Response:
    """
    Updates the user_id of the current user in the database.

    :param user_id:  current user's user_id
    :param new_email: The new email to set for the current user.
    :type new_email: str

    :returns: A Response object indicating the status of the email update.
    :rtype: Response
    """
    try:
        users_collection.update_one(
            {"user_id": user_id},
            {"$set": {"email": new_email}}
        )
    except PyMongoError:
        return jsonify({
            "status": False,
            "message": "An error occurred, try again later!",
            "alertDiv": "#emailAlert"
        })

    return jsonify({
        "status": True,
        "redirectUrl": url_for("home")
    })


def db_change_password(user_id: str, new_password: str) -> Response:
    """
    Updates the password of the current user in the database.

    :param user_id: current user's user_id
    :param new_password: user's new password

    :return: A Response object indicating the status of the password update.
    :rtype: Response
    """
    try:
        users_collection.update_one(
            {"user_id": user_id},
            {"$set": {"password": generate_password_hash(new_password)}}
        )
    except PyMongoError:
        return jsonify({
            "status": False,
            "alertDiv": "#passwordAlert",
            "message": "An error occurred, try again later!"
        })

    return jsonify({
        "status": True
    })


def is_chat_member(chat_id: int, user_id: str) -> int:
    """
    Checks for if the current user is member of the chat that he want to view and text into.

    :param chat_id: chat id fetched from the link in my_chats.html template
    :param user_id: current user's user_id.
    :return: Integer state which represent boolean value (0 or 1).
    """
    return group_chat_members_collection.count_documents({'chat_id': chat_id, 'user_id': user_id})


def is_admin(chat_id: int, user_id: str) -> int:
    """
    Checks if the user is admin.

    :param chat_id: chat's id.
    :param user_id: current user's user_id.
    :return: Boolean state of 0 or 1 (True or False)
    """
    return group_chat_members_collection.count_documents({
        "chat_id": chat_id,
        "user_id": user_id,
        "is_chat_admin": True
    })


def admin_required(func: Callable[..., Any]) -> Callable[..., Any]:
    """
    Decorator to prevent accessing some routes for non-admin users.
    :param func: Decorated function
    :return: Callable[..., Any]
    """

    @wraps(func)
    def wrapper(*args, **kwargs):
        chat_id = kwargs.get("chat_id")
        # Assuming you have access to the current user's user_id
        user_id = current_user.user_id

        # Check if the user is an admin for the specified chat
        if not is_admin(chat_id, user_id):
            # Return a forbidden (403) error if the user is not an admin
            return abort(403)

        return func(*args, **kwargs)

    return wrapper


def delete_group_member(chat_id: int, user_id: str) -> Response:
    """
    Deletes a member from a chat. If the member is the admin and there are other members in the chat,
    the admin abilities are transferred to a random user. If the admin is the only member in the chat
    and leaves, the chat is deleted.

    :param chat_id: current chat's id.
    :param user_id: current logged-in user's user_id.
    :return: Response
    """
    try:
        # Check if the user is an admin
        if is_admin(chat_id, user_id):
            chat_members = get_chat_members(chat_id)

            # Delete non-admin members
            chat_members = [member["user_id"] for member in chat_members if not member["is_chat_admin"]]
            if chat_members:
                new_admin = choice(chat_members)
                group_chat_members_collection.update_one(
                    {'chat_id': chat_id, "user_id": new_admin},
                    {'$set': {"is_chat_admin": True}}
                )
            else:
                # Delete the chat because no members left
                group_chats_collection.delete_one({"chat_id": chat_id})

        # Delete the user
        group_chat_members_collection.delete_one(
            {"chat_id": chat_id, "user_id": user_id}
        )

        return jsonify({
            "status": True,
            "message": "Leaved chat Successfully",
            "redirectUrl": url_for("chat.my_chats")
        })

    except PyMongoError:
        return jsonify({
            "status": False,
            "message": "Failed to leave!"
        })


def db_kick_member(chat_id: int, user_id: str) -> Response:
    """
    Responsible about kicking user from the chat.

    :param chat_id: selected chat's id.
    :param user_id: current user's (admin) user_id.
    :return: Response
    """
    try:
        group_chat_members_collection.delete_one({
            "chat_id": chat_id, "user_id": user_id
        })
    except PyMongoError:
        return jsonify({"status": False})

    return jsonify({"status": True})


# chat Operations

def get_chat(chat_id: int) -> dict:
    """
    Find a chat by `chat_id`

    :param chat_id: fetched id for the chat.
    :type chat_id: int
    :return: Dictionary (JSON) object contains chat data.
    """
    return group_chats_collection.find_one({'chat_id': chat_id})


def save_chat(chat_name: str, created_by: str) -> int:
    """
    Allows a user to create a chat; giving them admin access,
    and automatically adding them to the chat.

    :param chat_name: The name of the chat to be created.
    :param created_by: The user_id of the user who is creating the chat.
    :type chat_name: str,
    :type created_by: str

    :return: Created chat's ID.
    """
    chat_id = ("chat_id")
    group_chats_collection.insert_one({
        "chat_id": chat_id,
        "name": chat_name,
        "created_by": created_by,
        "created_at": datetime.now()
    })

    add_chat_member(chat_id, chat_name=chat_name, user_id=created_by,
                    added_by=created_by, is_chat_admin=True)
    return chat_id


def add_chat_member(chat_id: int, chat_name: str, user_id: str, added_by, is_chat_admin=False):
    """
    Add a member to a chat with `chat_id`.

    :param chat_id: The id of the chat to which the member will be added.
    :param chat_name: The name of the chat.
    :param user_id: The user_id of the member to be added.
    :param added_by: The user_id of the user who is adding the member.
    :param is_chat_admin: Whether the member should have admin privileges in the chat.
    :return:
    """
    group_chat_members_collection.insert_one(
        {"chat_id": chat_id, 'user_id': user_id, 'chat_name': chat_name, 'added_by': added_by,
         'added_at': datetime.now(), 'is_chat_admin': is_chat_admin})


def get_chats_for_user(user_id: str) -> list:
    """
    Returns a list of chats for the current signed-in user.

    :param user_id: The user_id of the user.
    :return: A list of chats the user is a member of.
    """
    return list(group_chat_members_collection.find({'user_id': user_id}))


def get_chat_members(chat_id: int) -> list:
    """
    Returns a list of members for a chat.

    :param chat_id: The id of the chat.
    :return: A list of chat members.
    """
    return list(group_chat_members_collection.find({'chat_id': chat_id}))


def join_chat_member(chat_id: int, chat_name: str, user_id: str, added_by="Himself",
                     is_chat_admin=False) -> Response:
    """
    Responsible for joining a chat by chat_id, handling this operation on the join chat modal.

    :param chat_id: The id of the chat to join.
    :param chat_name: The name of the chat.
    :param user_id: The user_id of the user joining the chat.
    :param added_by: The user_id of the user who is added the member.
    :param is_chat_admin: Whether the member should have admin privileges in the chat.
    :return: Response
    """
    group_chat_members_collection.insert_one(
        {'chat_id': chat_id, 'user_id': user_id, 'chat_name': chat_name, 'added_by': added_by,
         'added_at': datetime.now(), 'is_chat_admin': is_chat_admin})
    chat_members = get_chat_members(chat_id=chat_id)
    chat_members = [member["user_id"] for member in chat_members]
    if current_user.user_id in chat_members:
        return jsonify({
            "status": True,
            "message": "Joined chat Successfully",
            "redirectUrl": url_for("chat.my_chats")
        })

    return jsonify({
        "status": False,
        "message": "An error occurred, try again later!"
    })


def db_change_chat_name(chat_id: int, new_chat_name: str) -> Response:
    """
    Change chat's name in the database.
    :param chat_id: chat's id.
    :param new_chat_name: new chat name to be set.
    :return: Response
    """
    try:
        # chats collection
        group_chats_collection.find_one_and_update(
            {"chat_id": chat_id},
            {"$set": {"name": new_chat_name}}
        )

        # chat members collection
        group_chat_members_collection.update_many(
            {"chat_id": chat_id},
            {"$set": {"chat_name": new_chat_name}}
        )
    except PyMongoError:
        return jsonify({
            "status": False,
            "message": "Failed to change chat name!"
        })

    return jsonify({
        "status": True,
        "message": "Changed chat name successfully!",
        "redirectUrl": url_for("chat.view_chat", chat_id=chat_id)
    })


# Messages

def get_messages(chat_id: int) -> list:
    """
    Returns a list of messages for the selected chat.

    :param chat_id: The id of the chat.
    :return: A list of messages in the chat.
    """
    return list(messages_collection.find({"chat_id": chat_id}))


def save_message(chat_id: int, text: str, sender: str) -> None:
    """
    Save a message to the database after emitting an event of SocketIO.

    :param chat_id: The id of the chat where the message is sent.
    :param text: The content of the message.
    :param sender: The user_id of the message sender.
    :return: None
    """
    messages_collection.insert_one({
        "chat_id": chat_id,
        "text": text,
        "sender": sender,
        "create_at": datetime.now()
    })


def fetch_latest_message(chat_id: int) -> dict[str, Any] | str:
    """
    Returns latest message document sent to the chat.

    :prarm chat_id: The id of the chat to fetch the message.
    :return: Message document.
    """

    cursor = messages_collection.find({
        "chat_id": int(chat_id)
    }).sort([('create_at', -1)]).limit(1)

    try:
        recent_message = cursor.next()
        sender: str = recent_message["sender"]
        text: str = recent_message["text"]
        sent_at: str = str(recent_message["create_at"]).split(" ")[1][:5]  # fetch hour and minute only
        return {
            "sender": sender,
            "text": text,
            "time": sent_at
        }

    except StopIteration as error:
        logging.info(f"No messages were sent at chat with id of {chat_id} - {error}")
        return None
