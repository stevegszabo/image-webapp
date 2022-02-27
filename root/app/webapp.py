"""
Sample python webapp container
"""
import os
import socket

from flask import Flask

GAPPLICATION = Flask(__name__)


@GAPPLICATION.route("/")
def indexpage():
    """
    Sample index page
    :return: String
    """
    version = os.getenv('WEBAPP_VERSION', 'WEBAPP_VERSION')
    dbuser = os.getenv('POSTGRES_USER', 'POSTGRES_USER')
    dbpassword = os.getenv('POSTGRES_PASSWORD', 'POSTGRES_PASSWORD')
    hostname = socket.gethostname()
    address = socket.gethostbyname(hostname)
    return "{}:{}:{}:{}:{}\n".format(version, hostname, address, dbuser, dbpassword)


if __name__ == "__main__":
    GAPPLICATION.run(host='0.0.0.0', port=8080)
