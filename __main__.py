from tornado.ioloop import IOLoop
from app import create_app
from app.exts import get_ip
import time
import streamlit as st
import request
import os

port = "8501"
server_ip = "127.0.0.1"
app = create_app()

if __name__ == '__main__':
	os.system('clear')
	print("V2 API Server")

	app.listen(port=int(port), address=server_ip)
	time.sleep(1)
	print("IP: " + server_ip)
	time.sleep(1)
	print("Port: " + port)
	time.sleep(1)
	print("Online •")
	IOLoop.instance().start()
	
