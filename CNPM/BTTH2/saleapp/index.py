from flask import render_template, request
from saleapp import app
import utils


@app.route("/")
def home():
  cates = utils.load_categories()
  return render_template('index.html', category = cates)


@app.route("/products")
def list():
  cate_id = request.args.get('category_id')
  kw = request.args.get('keyword')
  fPrice = request.args.get('fromPrice')
  toPrice = request.args.get('toPrice')
  products = utils.load_products(cate_id=cate_id, kw=kw, fPrice=fPrice, toPrice=toPrice)
  return render_template('products.html', products=products)


@app.route("/products/<int:product_id>")
def product_detail(product_id):
  product = utils.detail(product_id)
  return render_template('product.html', product=product)


if __name__ == '__main__':
  app.run(debug= True)