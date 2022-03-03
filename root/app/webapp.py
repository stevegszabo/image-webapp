"""
Sample python webapp container
"""
import os
import socket

from flask import Flask

GAPPLICATION = Flask(__name__)
GVERSION = os.getenv('WEBAPP_VERSION', 'WEBAPP_VERSION')
GDBUSER = os.getenv('POSTGRES_USER', 'POSTGRES_USER')
GDBPASSWORD = os.getenv('POSTGRES_PASSWORD', 'POSTGRES_PASSWORD')
GDBINSTANCE = os.getenv('WEBAPP_DATABASE', 'WEBAPP_DATABASE')


@GAPPLICATION.route("/")
def indexpage():
    """
    Sample index page
    :return: String
    """
    hostname = socket.gethostname()
    address = socket.gethostbyname(hostname)
    result = f'{hostname}[{address}]:{GVERSION}:{GDBINSTANCE}:{GDBUSER}:{GDBPASSWORD}\n'
    return result


if __name__ == "__main__":
    GAPPLICATION.run(host='0.0.0.0', port=8080)
