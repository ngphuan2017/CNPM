employees = [{
"ma_nv": 1,
"ten_nv": "Nguyễn Văn A",
}, {
"ma_nv": 2,
"ten_nv": "Dương Trọng C",
}, {
"ma_nv": 3,
"ten_nv": "Nguyễn Thanh N",
}]
def display(employees):
    for w, k in employees.items():
        if w == "ma_nv":
            print("Mã nhân viên:", k)
        elif w == "ten_nv":
            print("Tên nhân viên:", k)

def displays(employees):
    for emp in employees:
        display(emp)
displays(employees)

def search(employees, f):
    kq =[]
    for emp in employees:
        if emp["ten_nv"].find(f) >= 0:
            kq.append(emp)
    return kq

def  delete(employees, id):
    for emp in employees:
        if emp["ma_nv"] == id:
            employees.remove(emp)
            return True
    return False

def add_employees(employees, ma, ten):
    for emp in employees:
        if emp["ma_nv"] == ma:
            return False
    emp = {
        "ma_nv": ma,
        "ten_nv": ten
    }
    employees.append(emp)
    return True

f = input("Nhập từ khóa tìm kiếm: ")
print("===Kết quả tìm kiếm===")
if len(search(employees, f)) > 0:
    displays(search(employees, f))
else:
    print("===Không tìm thấy nhân viên này===")
d = int(input("Nhập id muốn xóa: "))
if delete(employees, d):
    print("===Xóa thành công===")
    displays(employees)
else:
    print("===Không có nhân viên này===")
ma = int(input("Nhập mã nhân viên: "))
ten = input("Nhập tên nhân viên: ")
if add_employees(employees, ma, ten):
    print("===Thêm thành công===")
else:
    print("===Mã nhân viên đã tồn tại===")
displays(employees)