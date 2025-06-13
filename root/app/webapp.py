"""
Sample python webapp container
"""
import os
import socket

from flask import Flask

GAPPLICATION = Flask(__name__)
GVERSION = os.getenv('WEBAPP_VERSION', '0000000')
GADDRESS = os.getenv('WEBAPP_ADDRESS', '0.0.0.0')
GPORT = os.getenv('WEBAPP_PORT', 8080)

GDBINSTANCE = os.getenv('WEBAPP_DATABASE', 'none')
GRELEASE = os.getenv('WEBAPP_RELEASE', 'none')
GDBUSER = os.getenv('POSTGRES_USER', 'POSTGRES_USER')
GDBPASSWORD = os.getenv('POSTGRES_PASSWORD', 'POSTGRES_PASSWORD')


@GAPPLICATION.route("/")
def indexpage():
    """
    Sample index page
    :return: String
    """
    hostname = socket.gethostname()
    address = socket.gethostbyname(hostname)
    result = f'{hostname}:{address}:{GVERSION}:{GRELEASE}:{GDBINSTANCE}:{GDBUSER}:{GDBPASSWORD}\n'
    return result


if __name__ == "__main__":
    GAPPLICATION.run(host=GADDRESS, port=GPORT)
