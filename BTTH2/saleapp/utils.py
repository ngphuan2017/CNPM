import json, os
from saleapp import app


def read_json(path):
    with open(path, "r") as f:
        return json.load(f)

def load_categories():
    return read_json(os.path.join(app.root_path, 'data/categories.json'))


def load_products(cate_id=None, kw=None, fPrice=None, toPrice=None):
    products = read_json(os.path.join(app.root_path, 'data/products.json'))
    if cate_id:
        products = [p for p in products if p['category_id'] == int(cate_id)]
    if kw:
        products = [p for p in products if p['name'].lower().find(kw.lower()) >= 0]
    if fPrice:
        products = [p for p in products if p['price'] >= float(fPrice)]
    if toPrice:
        products = [p for p in products if p['price'] <= float(toPrice)]
    return products


def detail(product_id):
    products = read_json(os.path.join(app.root_path, 'data/products.json'))
    for p in products:
        if p['id'] == int(product_id):
            product = p
            return product