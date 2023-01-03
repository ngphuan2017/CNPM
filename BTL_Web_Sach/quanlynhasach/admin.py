from quanlynhasach import db, app, utils
from quanlynhasach.models import Category, Product, Tag, User, UserRole
from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView, expose, Admin, AdminIndexView
from flask_login import logout_user,current_user
from flask import redirect


class AuthenticatedModelViews(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN


class AuthenticatedModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated


class AuthenticatedBaseView(BaseView):
    def is_accessible(self):
        return current_user.is_authenticated


class ProductView(AuthenticatedModelView):
    column_display_pk = True
    can_view_details = True
    edit_modal = True
    details_modal = True
    column_filters = ['name', 'price']
    column_searchable_list = ['name', 'description']
    column_labels = {
        'id': 'Mã sản phẩm',
        'name': 'Tên',
        'description': 'Mô tả',
        'author': 'Tác giả',
        'price': 'Giá',
        'category': 'Thể loại',
        'active': 'Còn hàng',
        'entry_date': 'Ngày nhập',
        'image': 'Ảnh sản phẩm'
    }
    form_excluded_columns = ['tags']


class LogoutView(AuthenticatedBaseView):
    @expose('/')
    def index(self):
        logout_user()

        return redirect('/admin')


class StatsView(AuthenticatedBaseView):
    @expose('/')
    def index(self):
        stats = utils.category_stats()
        return self.render('admin/stats.html', stats=stats)


class MyAdminIndexView(AdminIndexView):
    @expose('/')
    def index(self):
        return self.render('admin/index.html')


admin = Admin(app=app, name='Quản trị hệ thống nhà sách',template_mode='bootstrap4',index_view=MyAdminIndexView())
admin.add_view(AuthenticatedModelViews(Category, db.session, name='Thể loại'))
admin.add_view(ProductView(Product, db.session, name='Sách'))
admin.add_view(AuthenticatedModelViews(Tag, db.session,name='Nhãn'))
admin.add_view(AuthenticatedModelViews(User,db.session, name='Người dùng'))
admin.add_view(StatsView(name='Thống kê báo cáo'))
admin.add_view(LogoutView(name='Đăng xuất'))