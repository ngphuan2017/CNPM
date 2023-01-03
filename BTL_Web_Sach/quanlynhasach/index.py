import datetime

from flask import render_template, request, url_for, session, jsonify, redirect
from quanlynhasach import login
from flask_login import login_user, logout_user, login_required
from quanlynhasach.admin import *
import math, utils, cloudinary.uploader


@app.context_processor
def menu():
  return {
    'category': utils.load_categories(),
    'cart_stats': utils.count_cart(session.get('cart'))
  }


@app.route("/")
def home():
    cates = utils.load_categories()
    cate_id = request.args.get('category_id')
    kw = request.args.get('keyword')
    page = request.args.get("page", 1)
    count = utils.count_products()
    products = utils.load_products(cate_id=cate_id, kw=kw, page=int(page))
    return render_template('index.html', categories=cates, products=products, pages=math.ceil(count/app.config['PAGE_SIZE']))


# @app.route("/products")
# def product_list():
#     cate_id = request.args.get('category_id')
#     kw = request.args.get('keyword')
#     fPrice = request.args.get('fromPrice')
#     toPrice = request.args.get('toPrice')
#     products = utils.load_products(cate_id=cate_id, kw=kw, fPrice=fPrice, toPrice=toPrice, page=0)
#     return render_template('products.html', product=products)


@app.route("/products/<int:product_id>")
def product_detail(product_id):
    product = utils.get_product_by_id(product_id)
    cmt = utils.count_comment(product_id)
    comments = utils.get_comments(product_id=product_id, page=int(request.args.get('page', 1)))
    return render_template('product.html', product=product, comments=comments, cmt=int(cmt),
                        pages=math.ceil(utils.count_comment(product_id=product_id)/app.config['COMMENT_SIZE']))


@app.route('/admin-login', methods=['post'])
def admin_login():
    if request.method.__eq__('POST'):
        username = request.form.get('username')
        password = request.form.get('password')
        user = utils.check_login(username=username, password=password)
        if user:
            login_user(user=user)

        return redirect('/admin')

    return redirect('/admin-login')


@app.route("/register", methods=['get', 'post'])
def user_register():
  err_msg = ""
  if request.method.__eq__('POST'):
    name = request.form.get('name')
    username = request.form.get('username')
    password = request.form.get('password')
    email = request.form.get('email')
    phone = request.form.get('phone')
    confirm = request.form.get('confirm')
    avatar_path = None
    if password.strip().__eq__(confirm.strip()):
      avatar = request.files.get('avatar')
      if avatar:
        res = cloudinary.uploader.upload(avatar)
        avatar_path = res['secure_url']
      if utils.add_user(name=name, username=username, passnew=password, phone=phone, email=email, avatar=avatar_path):
        return redirect(url_for("user_login"))
      else:
        err_msg = "Tên tài khoản đã tồn tại!"
    else:
      err_msg = "Mật khẩu không khớp"

  return render_template('layout/register.html', err_msg=err_msg)


@app.route("/login", methods=["post", "get"])
def user_login():
  err_msg = ""
  if request.method.__eq__('POST'):
    username = request.form.get('username')
    password = request.form.get('password')
    user = utils.check_login(username=username, password=password)
    if user:
      login_user(user=user)
      next = request.args.get('next', '/')
      return redirect(next)

    err_msg = "Tài khoản hoặc mật khẩu không chính xác!!!"
  return render_template("login.html", err_msg=err_msg)


@app.route("/logout")
def logout():
  logout_user()
  return redirect(url_for("user_login"))


@app.route('/api/cart', methods=['post'])
def add_cart():
  data = request.json
  id = str(data.get('id'))
  name = data.get('name')
  price = data.get('price')
  category_id = data.get('category_id')
  cart = session.get('cart')
  if not cart:
    cart = {}
  if id in cart:
    cart[id]['quantity'] = cart[id]['quantity'] + 1
  else:
    cart[id] = {
        'id': id,
        'name': name,
        'price': price,
        'category_id': category_id,
        'quantity': 1
    }
  session['cart'] = cart
  # import pdb
  # pdb.set_trace()
  return jsonify(utils.count_cart(cart))


@app.route('/api/update-cart', methods=['put'])
def update_cart():
  date = request.json
  id = str(date.get('id'))
  quantity = date.get('quantity')
  cart = session.get('cart')
  if cart and id in cart:
    cart[id]['quantity'] = quantity
    session['cart'] = cart

  return jsonify(utils.count_cart(cart))


@app.route('/cart')
def cart():
  return render_template('cart.html', stats=utils.count_cart(session.get('cart')))


@app.route('/api/delete-cart/<product_id>', methods=['delete'])
def delete_cart(product_id):
    cart = session.get('cart')
    if cart and product_id in cart:
        del cart[product_id]
        session['cart'] = cart

    return jsonify(utils.count_cart(cart))


@app.route('/api/pay', methods=['post'])
@login_required
def pay():
  try:
    utils.add_receipt(session.get('cart'))
    infocart = session.get('cart')
    session['infocart'] = infocart
    jsonify(utils.count_cart(infocart))
    del session['cart']
  except:
    return jsonify({'code': 400})

  return jsonify({'code': 200})


@app.route('/users')
def users():
    utils.add_receipt(session.get('infocart'))
    stats = utils.count_cart(session.get('infocart'))
    date = datetime.date.today().strftime('%d/%m/%Y')
    return render_template('user.html', stats=stats, date=str(date))



@app.route('/api/comments', methods=['post'])
@login_required
def comment():
    data = request.json
    content = data.get('content')
    product_id = data.get('product_id')
    try:
        c = utils.add_comment(content=content, product_id=product_id)
    except:
        return {'status': 404, 'err_msg': 'Server đang bảo trì!!!'}
    return {'status': 201, 'comment': {
        'id': c.id,
        'content': c.content,
        'created_date': str(c.created_date),
        'user': {
            'id': c.user.id,
            'username': current_user.username,
            'avatar': current_user.avatar
        }
    }}


# @app.route('/api/products/<int:product_id>/comments')
# def get_comment(product_id):
#     page = request.args.get('page', 1)
#     comments = utils.get_comments(product_id=product_id, page=int(page))
#     results = []
#     for c in comments:
#         results.append({
#             'id': c.id,
#             'content': c.content,
#             'created_date': str(c.created_date),
#             'user': {
#                 'id': c.user.id,
#                 'username': current_user.username,
#                 'avatar': current_user.avatar
#             }
#         })
#
#     return jsonify(results)

@login.user_loader
def load_user(user_id):
    return utils.get_user_by_id(user_id=user_id)


if __name__ == "__main__":
    app.run(debug=True)