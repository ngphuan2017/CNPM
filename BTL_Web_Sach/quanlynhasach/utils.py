from quanlynhasach.models import User, Category, Product, Receipt, ReceiptDetail, Comment
from sqlalchemy import func
from flask_login import current_user
from quanlynhasach import db, app
import hashlib


def get_user_by_id(user_id):
    return User.query.get(user_id)


def check_login(username, password):
    if username and password:
        password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())

        return User.query.filter(User.username.__eq__(username.strip()),
                                 User.password.__eq__(password)).first()


def load_categories(id=None):
    if id:
        category = Category.query.filter(Category.id.__eq__(id))
        return category.all()
    return Category.query.all()


def count_products():
    return Product.query.filter(Product.active.__eq__(True)).count()


def load_products(cate_id=None, kw=None, fPrice=None, toPrice=None, page=1):
    products = Product.query.filter(Product.active.__eq__(True))

    if cate_id:
        products = products.filter(Product.category_id.__eq__(cate_id))
        page = 1

    if kw:
        products = products.filter(Product.name.contains(kw))
        page = 1

    # if fPrice:
    #     products = products.filter(Product.price.__ge__(fPrice))
    #
    # if toPrice:
    #     products = products.filter(Product.price.__le__(toPrice))

    if page != 0:
        page_size = app.config['PAGE_SIZE']
        start = (page - 1) * page_size
        end = start + page_size
        return products.slice(start, end).all()

    return products.all()


def get_product_by_id(product_id):
    return Product.query.get(product_id)


def add_user(name, username, passnew, phone, **kwargs):
    if User.query.filter(User.username.__eq__(username.strip())).count() > 0:
        return False
    else:
        password = str(hashlib.md5(passnew.strip().encode('utf-8')).hexdigest())
        user = User(name=name.strip(), username=username.strip(), password=password, phone=phone.strip(),
                        email=kwargs.get('email'), avatar=kwargs.get('avatar'))
        db.session.add(user)
        db.session.commit()
        return True


def add_receipt(cart):
    if cart:
        receipt = Receipt(user=current_user)
        db.session.add(receipt)
        for c in cart.values():
            d = ReceiptDetail(receipt=receipt, product_id=c['id'], quantity=c['quantity'], unit_price=c['price'])
            db.session.add(d)

        db.session.commit()


def count_cart(cart):
    total_quantity, total_amount = 0, 0
    if cart:
        for c in cart.values():
            total_quantity += c['quantity']
            total_amount += c['quantity']*c['price']

    return {
        'total_quantity': total_quantity,
        'total_amount': total_amount
    }


def add_comment(content, product_id):
    if content and product_id:
        c = Comment(content=content, product_id=product_id, user=current_user)
        db.session.add(c)
        db.session.commit()
        return c


def get_comments(product_id, page=1):
    if page != 0:
        page_size = app.config['COMMENT_SIZE']
        start = (page - 1) * page_size
    return Comment.query.filter(Comment.product_id.__eq__(product_id)).order_by(-Comment.id).slice(start, start + page_size).all()


def count_comment(product_id):
    return Comment.query.filter(Comment.product_id.__eq__(product_id)).count()


def category_stats():
    return db.session.query(Category.id, Category.name, func.count(Product.id))\
            .join(Product, Category.id.__eq__(Product.category_id), isouter=True)\
            .group_by(Category.id, Category.name).all()