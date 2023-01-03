from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_babelex import Babel
from flask_login import LoginManager
import cloudinary

app = Flask(__name__)
app.secret_key = 'tebrtrj$%*((Jkknfnkcm(&%#INnjdkwqncv'

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:anlovelinh2802@localhost/quanlynhasach?charset=utf8mb4"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = True
app.config['PAGE_SIZE'] = 8
app.config['COMMENT_SIZE'] = 3

db = SQLAlchemy(app=app)

login = LoginManager(app=app)

cloudinary.config(
    cloud_name = 'nguyen-phu-an',
    api_key = '962459519178933',
    api_secret = 'Pq__BqvLwruRUtSf8RYFwkcltd4',
)

babel = Babel(app=app)
@babel.localeselector
def get_locale():
        return 'vi'