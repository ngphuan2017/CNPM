function addToCart(id, name, price, category_id){
    event.preventDefault()
    fetch('/api/cart', {
        method: 'post',
        body: JSON.stringify({
            'id': id,
            'name': name,
            'price': price,
            'category_id': category_id
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => {
        console.info(res)
        return res.json()
    }).then(data => {
        console.info(data)
        let counter = document.getElementsByClassName('cart-counter')
        for(let i = 0; i < counter.length; i++)
        counter[i].innerText = data.total_quantity
    }).catch(err => console.error(err))
}
function pay(){
    if(confirm('Bạn chắc chắn muốn thanh toán không?') == true){
        fetch('/api/pay', {
        method: 'post'
    }).then(res => res.json()).then(data => {
        if (data.code == 200)
            location.reload()
            alert('Đơn hàng của quý khách đã thanh toán thành công!')
    }).catch(err => console.error(err))
    }
}
function updateCart(id, obj){
    fetch('api/update-cart', {
        method: 'put',
        body: JSON.stringify({
            'id': id,
            'quantity': parseInt(obj.value)
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(res => res.json()).then(data => {
        let counter = document.getElementsByClassName('cart-counter')
        for(let i = 0; i < counter.length; i++)
            counter[i].innerText = data.total_quantity

        let amount = document.getElementById('total_amount')
        amount.innerText = new Intl.NumberFormat().format(data.total_amount)
    }).catch(err => console.error(err))
}
function deleteCart(id){
    if(confirm('Bạn chắc chắn muốn xóa không?') == true){
        fetch('/api/delete-cart/' + id, {
            method: 'delete',
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(res => res.json()).then(data => {
            let counter = document.getElementsByClassName('cart-counter')
            for(let i = 0; i < counter.length; i++)
                counter[i].innerText = data.total_quantity

            let amount = document.getElementById('total_amount')
            amount.innerText = new Intl.NumberFormat().format(data.total_amount)
            let e = document.getElementById("product" + id)
            e.style.display = 'none'
        }).catch(err => console.error(err))
    }
}
function addComment(productId, pages=1){
    let content = document.getElementById('commentId')
    if (content != null){
        fetch('/api/comments?page=${page}', {
            method: 'post',
            body: JSON.stringify({
                'product_id': productId,
                'content': content.value
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(res => res.json()).then(data => {
            if(data.status == 201){
                let c = data.comment
                let comments = document.getElementById('comments')
                content.value = ""
                comments.innerHTML =
                `
                    <div class="row">
                        <div class="col-md-1 col-xs-2">
                            <img class="img-fluid rounded-circle" src="${c.user.avatar}" alt="avatar" />
                        </div>
                        <div class="col-md-11 col-xs-10">
                            <p>${c.content}</p>
                            <p><em>${moment(c.created_date).locale('vi').fromNow()}</em></p>
                        </div>
                    </div>
                ` + comments.innerHTML
            }
            else if (data.status == 404)
                alert(data.err_msg)
        })
    }
}
//function getHtmlComment(comment){
//    let img = comment.user.avatar
//    if (img === null || !img.startsWidth('https'))
//        img = 'static/images/avatar-mac-dinh-1.png'
//    return `
//        <div class="row">
//            <div class="col-md-1 col-xs-2">
//                <img class="img-fluid rounded-circle" src="${img}" alt="avatar" />
//            </div>
//            <div class="col-md-11 col-xs-10">
//                <p>${comment.content}</p>
//                <p><em>${moment(comment.created_date).locale('vi').fromNow()}</em></p>
//            </div>
//        </div>
//    `
//}
//function loadComment(productId, page=1){
//    fetch(`/api/products/${productId}/comments?page=${page}`).then(res => res.json()).then(data => {
//        console.info(data)
//        let comments = document.getElementById('comments')
//        comments.innerHTML = ""
//        for(let i = 0; i<data.length; i++)
//            comments.innerHTML += getHtmlComment(data[i])
//    })
//}