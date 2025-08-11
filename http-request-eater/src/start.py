#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ----------------------------------------------------------------------------------------------------------------------
import datetime
import logging
import os
from http.server import BaseHTTPRequestHandler

from flask import Flask
from flask import request, make_response

HTTP_METHODS = ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS", "HEAD"]

app = Flask(__name__)
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)
BaseHTTPRequestHandler.version_string = lambda x: "null"  # replace default 'Server' header


@app.route('/', defaults={'path': ''}, methods=HTTP_METHODS)
@app.route('/<path:path>', methods=HTTP_METHODS)
def catch_all(path):
    msg = """\u25B6 {} {} - "{} {} {}"\n""".format(
        datetime.datetime.today().strftime("%Y-%m-%d %H:%M:%S"),
        request.remote_addr,
        request.method,
        request.url_root.rstrip('/') + request.path,
        request.environ.get('SERVER_PROTOCOL')
    )
    if request.headers:
        _tmp = ["    {}: {}".format(x, request.headers[x]) for x in request.headers.keys()]
        msg += "\u25CB Headers:\n{}\n".format('\n'.join(_tmp))
    if request.cookies:
        _tmp = ["    {}: {}".format(x, request.cookies[x]) for x in request.cookies.keys()]
        msg += "\u25CB Cookies:\n{}\n".format('\n'.join(_tmp))
    if request.args:
        tmp = '\n'.join(["""    '{0}': '{1}'""".format(x, request.args[x]) for x in request.args])
        msg += "\u25CB URL params:\n{0}\n".format(tmp)
    if request.form:
        tmp = '\n'.join(["""    '{0}': '{1}'""".format(x, request.form[x]) for x in request.form])
        msg += "\u25CB Form:\n{0}\n".format(tmp)
    if request.data:
        try:
            tmp = request.data.decode('utf-8')
        except UnicodeDecodeError:
            tmp = request.data
        msg += "\u25CB Data:\n{}\n".format(tmp)
    if request.files:
        tmp = '\n'.join(["""    '{0}': {1}""".format(x, request.files[x]) for x in request.files])
        msg += "\u25CB Files:\n{0}\n".format(tmp)
    msg += "\u25B2\n\n"
    log.log(msg=msg, level=logging.ERROR)
    #
    resp = make_response('Yummy!\n')
    resp.set_cookie("foo", "bar", max_age=60)
    return resp


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if __name__ == "__main__":
    from werkzeug.serving import run_simple

    run_simple(os.environ.get('SERVER_HOST', "0.0.0.0"), os.environ.get('SERVER_PORT', 8080), app,
               threaded=True, use_reloader=True)
