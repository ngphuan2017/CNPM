from sqlalchemy import Column, Integer, String, Boolean, Enum, Float, DateTime, ForeignKey
from sqlalchemy.orm import relationship, backref
from quanlynhasach import db
from datetime import datetime
from enum import Enum as UserEnum
from flask_login import UserMixin


class Base(db.Model):
    __abstract__ = True

    id = Column(Integer, primary_key=True, autoincrement=True)


class UserRole(UserEnum):
    ADMIN = 1
    MANAGER = 2


class User(Base, UserMixin):
    name = Column(String(50),nullable=False)
    username = Column(String(50),nullable=False, unique=True)
    password = Column(String(50), nullable=False)
    avatar = Column(String(100))
    email = Column(String(50))
    phone = Column(String(10), nullable=False)
    active = Column(Boolean, default=True)
    joined_date = Column(DateTime, default=datetime.now())
    user_role = Column(Enum(UserRole), default=UserRole.MANAGER)
    receipts = relationship('Receipt', backref='user', lazy=True)
    comments = relationship('Comment', backref='user', lazy=True)

    def __str__(self):
        return self.name


class Category(Base):
    __tablename__ = 'category'
    name = Column(String(20), nullable=False)
    products = relationship('Product', backref='category', lazy=True)

    def __str__(self):
        return self.name


product_tag = db.Table('product_tag', Column('product_id', Integer, ForeignKey('product.id'), primary_key=True),
                       Column('tag_id', Integer, ForeignKey('tag.id'), primary_key=True))


class Product(Base):
    __tablename__ = 'product'
    name = Column(String(50), nullable=False)
    description = Column(String(255))
    price = Column(Float, default=0)
    active = Column(Boolean, default=True)
    image = Column(String(100))
    entry_date = Column(DateTime, default=datetime.now())
    category_id = Column(Integer, ForeignKey(Category.id), nullable=False)
    tags = relationship('Tag', secondary='product_tag', lazy='subquery', backref=backref('products', lazy=True))
    comments = relationship("Comment", backref="product", lazy=True)
    receipt_details = relationship('ReceiptDetail', backref='product', lazy=True)


class Comment(Base):
    content = Column(String(255), nullable=False)
    product_id = Column(Integer, ForeignKey(Product.id), nullable=False)
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)
    created_date = Column(DateTime, default=datetime.now())
    updated_date = Column(DateTime, default=datetime.now())

    def __str__(self):
        return self.content


class Tag(Base):
    __tablename__ = 'tag'
    name = Column(String(50), nullable=False, unique=True)

    def __str__(self):
        return self.name


class Receipt(Base):
    created_date = Column(DateTime, default=datetime.now())
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)
    details = relationship('ReceiptDetail', backref='receipt', lazy=True)


class ReceiptDetail(db.Model):
    receipt_id = Column(Integer, ForeignKey(Receipt.id), nullable=False, primary_key=True)
    product_id = Column(Integer, ForeignKey(Product.id), nullable=False, primary_key=True)
    quantity = Column(Integer, default=0)
    unit_price = Column(Float, default=0)


if __name__ == '__main__':
    db.create_all()

    # p1 = Product(name='7 Bài học hay nhất về Vật Lý', description='Sách cung cấp các kiến thức hay về Vật Lý học', price=30000, category_id=1, image="images/vatlyhoc.jpg")
    # p2 = Product(name='Hóa học 8', description='Sách giáo khoa hóa họa lớp 8', price=30000, category_id=1, image="images/hoahoc.jpg")
    # p3 = Product(name='Thế chiến thứ hai', description='Sách tư liệu lịch sử về đệ nhị thế chiến',price=40000, category_id=2, image="images/thechien.jpg")
    # p4 = Product(name='Naruto', description='Truyện tranh thiếu nhi', price=20000, category_id=3, image="images/naruto.jpg")
    # p5 = Product(name='Đất nước Nhật Bản', description='Sách về đất nước và con người Nhật Bản', price=35000, category_id=4, image="images/nhatban.jpg")
    # p6 = Product(name='Giải toán cùng Einstein', description='Sách kiến thức về toán học', price=30000, category_id=1, image="images/toanhoc.jpg")
    # p7 = Product(name='Trí tuệ nhân tạo', description='Sách kiến thức về trí tuệ nhân tạo', price=40000, category_id=1, image="images/AI.jpg")
    # p8 = Product(name='Bản sắc văn hóa Việt Nam', description='Sách về văn hóa Việt Nam', price=30000, category_id=4, image="images/vanhoavn.jpg")
    #
    #
    # db.session.add(p1)
    # db.session.add(p2)
    # db.session.add(p3)
    # db.session.add(p4)
    # db.session.add(p5)
    # db.session.add(p6)
    # db.session.add(p7)
    # db.session.add(p8)
    #
    # db.session.commit()