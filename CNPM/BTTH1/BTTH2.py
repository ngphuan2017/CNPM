a = []
#b = []
n = int(input("Nhập n = "))
while n <= 0:
    n = int(input("Nhap lai n: "))
#def nhap_ds(n):
#    for i in range(1, n + 1):
#       b.append(int(input("b[%d] = " % i)))
#    return b
def nhap_ds2(n):
    return [int(input("a[%d] = " %i)) for i in range(1, n+1)]
#b = nhap_ds(n)
a = nhap_ds2(n)
duong = [x for x in a if x > 0]
am = [x for x in a if x < 0]
print(a, end="\n==============================\n")
#print(b, end="\n==============================\n")
if len(duong) > 0:
    print("Số dương lớn nhất = %d" %max(duong))
else:
    print("Số dương lớn nhất: *")
if len(am) > 0:
    print("Số âm bé nhất = %d" %min(am))
else:
    print("Số âm bé nhất: *")
print("================================================")
for x in set(a):
    print("Số %d xuất hiện %d lần" %(x, a.count(x)), end="\n==========================================\n")
kq = []
k = int(input("Nhập k = "))
for x in set(a):
    if k == a.count(x):
        kq.append(x)
if len(kq) > 0:
    print("Các số xuất hiện %d lần là : %s" %(k, str(kq)))
else:
    print("Không có số nào xuất hiện %d lần" %k)
print("================================================")
a.sort(reverse=True)
print(a)