dicts = {
    "hello" : "Xin chào",
    "computer": "Máy tính",
    "telephone": "Điện thoại"
}
def add_word(dicts, word, meaning):
    if word not in dicts:
        dicts[word] = meaning
def display(dicts):
    for w, m in dicts.items():
        print("%s = %s" %(w,m))
def search(dicts, f):
    if f in dicts:
        return print("Từ cần tìm là: %s = %s" %(f, dicts[f]))
    else:
        print("Không tìm thấy từ!")
def delete(dicts, d):
    if d in dicts:
        del dicts[d]
        print("Xóa thành công!")
    else:
        print("Từ muốn xóa không có trong từ điển!")
add_word(dicts, "hi", "Chào cậu")
display(dicts)
f = input("Nhập từ cần tìm: ")
search(dicts, f)
d = input("Nhập từ muốn xóa: ")
delete(dicts, d)
display(dicts)
