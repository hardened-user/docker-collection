#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ----------------------------------------------------------------------------------------------------------------------
import datetime
import os
import traceback
import uuid
import warnings

from authlib.deprecate import AuthlibDeprecationWarning

# Игнорируем предупреждение о переходе на joserfc
warnings.filterwarnings("ignore", category=AuthlibDeprecationWarning)

from authlib.integrations.flask_client import OAuth
from flask import Flask, url_for, session, redirect, make_response, render_template, request
from werkzeug.exceptions import NotFound
from flask_session import Session
from cachelib import SimpleCache

app = Flask(__name__)
app.config['SECRET_KEY'] = os.environ.get("SECRET_KEY",
                                          "a756cd061283fdcb91d8983bd89e3557d5cd2f31981c66c4d834727c7ee5f9e5")
app.config['SESSION_TYPE'] = "cachelib"
# Простая реализация кэша в памяти, которая хранит данные в оперативной памяти Python процесса
app.config['SESSION_CACHELIB'] = SimpleCache()
app.json.ensure_ascii = False  # Отключаем принудительный ASCII для JSON
Session(app)  # Инициализация Flask-Session
oauth = OAuth(app)  # Подключаем OAuth к app для работы с провайдерами авторизации
#
OAUTH_CLIENT_ID = os.environ.get("OAUTH_CLIENT_ID", "").strip()
OAUTH_CLIENT_SECRET = os.environ.get("OAUTH_CLIENT_SECRET", "").strip()
KEYCLOAK_REALM_URL = os.environ.get("KEYCLOAK_REALM_URL", "https://example.com/auth/realms/master").strip().rstrip('/')
KEYCLOAK_CLIENT_SCOPE = os.environ.get("KEYCLOAK_CLIENT_SCOPE", "openid profile email").strip()

#
oauth.register(
    name='keycloak',  # Имя встроенного провайдера (keycloak, google, github, ...)
    client_id=OAUTH_CLIENT_ID,
    client_secret=OAUTH_CLIENT_SECRET,
    code_challenge_method='S256',  # Принудительно включить PKCE
    server_metadata_url=f"{KEYCLOAK_REALM_URL}/.well-known/openid-configuration",
    client_kwargs={'scope': KEYCLOAK_CLIENT_SCOPE}
)


@app.route('/')
def index():
    user = session.get('user')
    token = session.get('token')
    return render_template('index.html',
                           url=KEYCLOAK_REALM_URL, client_id=OAUTH_CLIENT_ID, scope=KEYCLOAK_CLIENT_SCOPE,
                           user=user, token=token), 200


@app.route('/login')
def login():
    redirect_uri = url_for('auth', _external=True)
    return oauth.keycloak.authorize_redirect(redirect_uri)


@app.route('/auth')
def auth():
    token = oauth.keycloak.authorize_access_token()
    session['user'] = token.get('userinfo')
    session['token'] = token
    return redirect('/')


@app.route('/logout')
def logout():
    token = session.get('token')
    session.clear()  # Очищаем нашу локальную сессию (Flask)
    metadata = oauth.keycloak.load_server_metadata()  # Получаем адрес end_session_endpoint из метаданных Keycloak
    logout_url = metadata['end_session_endpoint']
    return_url = url_for('index', _external=True)
    if token and 'id_token' in token:
        return redirect(f"{logout_url}?post_logout_redirect_uri={return_url}&id_token_hint={token['id_token']}")
    return redirect(return_url)


@app.route('/ping')
def ping():
    response = make_response('Pong!\n')
    return response


# ======================================================================================================================
# Handlers
# ======================================================================================================================
@app.before_request
def assign_request_id():
    # Уникальный ID запроса из заголовка X-Request-ID или генерируем
    request.environ['FLASK_REQUEST_ID'] = request.headers.get('X-Request-ID', uuid.uuid4().hex)


@app.errorhandler(NotFound)
def handle_404(e):
    # Минимальный ответ, без логирования
    return "Not Found", 404


@app.errorhandler(Exception)
def handle_bad_request(e):
    msg = ""
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
        msg += "\u25CB Form data:\n{0}\n".format(tmp)
    if request.data:
        msg += "\u25CB Body data:\n{}\n".format(request.data)
    if request.files:
        tmp = '\n'.join(["""    '{0}': {1}""".format(x, request.files[x]) for x in request.files])
        msg += "\u25CB Files:\n{0}\n".format(tmp)

    msg += "\n\u25CB {0}".format(traceback.format_exc())
    msg += "<<<<<\n"
    return render_template('panic.html', error_msg=str(e),
                           date=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")), 500


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if __name__ == "__main__":
    # noinspection PyPackageRequirements
    from werkzeug.serving import run_simple

    run_simple(os.environ.get('SERVER_HOST', "0.0.0.0"), os.environ.get('SERVER_PORT', 8080),
               app, threaded=True, use_reloader=True)
