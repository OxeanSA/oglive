from tornado.ioloop import IOLoop
from app import create_app
from app.exts import get_ip
import time
import os

port = "5000"
#host = get_ip()
host = "172.31.32.1"
#app = create_app()

if __name__ == '__main__':
#	os.system('clear')
	print("V2 API Server")
	create_app(host)
#	app.listen(port=int(port), address=host)
	time.sleep(1)
	print("IP: " + host)
	time.sleep(1)
	print("Port: " + port)
	time.sleep(1)
	print("Online •")
#	IOLoop.instance().start()
