/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
const urlParams = new URLSearchParams(window.location.search);
var colorId = urlParams.get("colorId");
var memoryId = urlParams.get("memoryId");

var colorIdPopup = null;
var memoryIdPopup = null;


let selectAll = false;

let productSelected = new Set();

let productSelectedAndQuantity = new Map();

function selectProduct(parameters) {

}


window.onload = function () {
    if (window.location.href.includes('cartdetail')) {
        let subTotal = 0;

        let priceOrigin = 0;

        let productDetails = document.querySelectorAll("#table-data tr");



        for (let i = 0; i < productDetails.length; i++) {
            let productDetail = productDetails[i];

            // lay ve productDetailId dang duoc selected;
            let productDetailId = productDetail.firstElementChild.children[1].value;

            // lay ve so luong san pham muon mua theo productDetailId tuong ung
            let quantityProductDetailInCart = productDetail.children[6].querySelector('input').value;

            if (productDetail.firstElementChild.firstElementChild.checked === true) {

                // add san pham da chon vao vung nho tam 
                productSelected.add(productDetailId);


                // cong don gia tien vao bien subTotal de hien thi ra tong so tien nhung san pham selected
                subTotal += productDetail.children[7].querySelector("span").innerText * 1000000;

                priceOrigin += document.getElementById(`price-origin-${productDetailId}`).innerText * quantityProductDetailInCart * 1000000;
            } else {
                productSelected.delete(productDetailId);
            }

        }

        if (productSelected.size === productDetails.length) {
            document.getElementById("selectAll").checked = true;
        } else {
            document.getElementById("selectAll").checked = false;
        }

//    console.log(productSelected);

        document.getElementById("sub-total").innerText = subTotal.toLocaleString('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });

        document.getElementById("quantity-product").innerText = productSelected.size;


        document.getElementById("discounts").innerText = "- " + (priceOrigin - subTotal).toLocaleString('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });

        document.getElementById("totalPrice").innerText = (priceOrigin).toLocaleString('vi-VN', {
            style: 'currency',
            currency: 'VND'
        });
    }
};





function selectProductPayment() {

    let subTotal = 0;

    let priceOrigin = 0;

    let productDetails = document.querySelectorAll("#table-data tr");



    for (let i = 0; i < productDetails.length; i++) {
        let productDetail = productDetails[i];

        // lay ve productDetailId dang duoc selected;
        let productDetailId = productDetail.firstElementChild.children[1].value;

        // lay ve so luong san pham muon mua theo productDetailId tuong ung
        let quantityProductDetailInCart = productDetail.children[6].querySelector('input').value;

        if (productDetail.firstElementChild.firstElementChild.checked === true) {

            // add san pham da chon vao vung nho tam 
            productSelected.add(productDetailId);


            // cong don gia tien vao bien subTotal de hien thi ra tong so tien nhung san pham selected
            subTotal += productDetail.children[7].querySelector("span").innerText * 1000000;

            priceOrigin += document.getElementById(`price-origin-${productDetailId}`).innerText * quantityProductDetailInCart * 1000000;
        } else {
            productSelected.delete(productDetailId);
        }

    }

    if (productSelected.size === productDetails.length) {
        document.getElementById("selectAll").checked = true;
    } else {
        document.getElementById("selectAll").checked = false;
    }

//    console.log(productSelected);

    document.getElementById("sub-total").innerText = subTotal.toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    document.getElementById("quantity-product").innerText = productSelected.size;


    document.getElementById("discounts").innerText = "- " + (priceOrigin - subTotal).toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    document.getElementById("totalPrice").innerText = (priceOrigin).toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

}

function selectAllProductPayment() {
    let productDetails = document.querySelectorAll("#table-data tr");
    for (let i = 0; i < productDetails.length; i++) {
        let productDetail = productDetails[i];

        if (selectAll === true) {
            productDetail.firstElementChild.firstElementChild.checked = false;
        } else {
            productDetail.firstElementChild.firstElementChild.checked = true;
        }
    }

    selectAll = !selectAll;
    selectProductPayment();
}

function optionChoose(choose, option, productId, chooseId) {
    var danhDau = false;

    if (choose.classList[0]) {
        danhDau = true;
        if (option === 'memory') {
            memoryId = null;
        } else {
            colorId = null;
        }
        choose.classList.remove("choose");
    }



    let optionAll = document.querySelectorAll(`#${option} span`);

    for (let i = 0; i < optionAll.length; i++) {
        optionAll[i].classList.remove("choose");
    }

    if (danhDau === false) {
        choose.classList.add("choose");
    }

    if (danhDau === false && option === 'memory') {
        memoryId = chooseId;
    } else if (danhDau === false && option === 'color') {
        colorId = chooseId;
    }


    if (memoryId !== null && colorId !== null) {
        window.location = `productdetail?option=detail&productId=${productId}&colorId=${colorId}&memoryId=${memoryId}`;
    } else if (memoryId === null && colorId === null) {
        window.location = `productdetail?option=common&productId=${productId}`;
    }
}


if (colorId != null && memoryId != null) {
    let optionMemory = document.getElementById(`memory${memoryId}`);
    let optionColor = document.getElementById(`color${colorId}`);

    optionMemory.classList.add('choose');
    optionColor.classList.add('choose');
}


function optionChoosePopup(choose, option, productId, chooseId) {
    var danhDau = false;

    if (choose.classList[0]) {
        danhDau = true;
        if (option === 'memory') {
            memoryId = null;
        } else {
            colorId = null;
        }
        choose.classList.remove("choose");
    }



    let optionAll = document.querySelectorAll(`#${option} span`);

    for (let i = 0; i < optionAll.length; i++) {
        optionAll[i].classList.remove("choose");
    }

    if (danhDau === false) {
        choose.classList.add("choose");
    }

    if (danhDau === false && option === 'memory') {
        memoryId = chooseId;
    } else if (danhDau === false && option === 'color') {
        colorId = chooseId;
    }


    if (memoryId !== null && colorId !== null) {
//        window.location = `productdetail?option=detail&productId=${productId}&colorId=${colorId}&memoryId=${memoryId}`;

        $.ajax({
            url: `/TechStore/productdetail`,
            type: 'post',
            data: {
                productId: productId,
                option: 'detail',
                colorId: colorId,
                memoryId: memoryId
            }, success: function (response) {
                var row = document.getElementById("product-detail-popup");
                row.innerHTML = response;

                let optionMemory = document.getElementById(`memoryyy${memoryId}`);
                let optionColor = document.getElementById(`colorrr${colorId}`);

                optionMemory.classList.add('choose');
                optionColor.classList.add('choose');

                document.getElementById('popup').style.display = 'flex';


            }, error: function (fail) {
                console.log("loi get search product" + fail);
            }
        });



    } else if (memoryId === null && colorId === null) {
//        window.location = `productdetail?option=common&productId=${productId}`;
        $.ajax({
            url: `/TechStore/productdetail`,
            type: 'post',
            data: {
                productId: productId,
                option: 'common'
            }, success: function (response) {
                var row = document.getElementById("product-detail-popup");
                row.innerHTML = response;

                document.getElementById('popup').style.display = 'flex';

            }, error: function (fail) {
                console.log("loi get search product" + fail);
            }
        });
    }
}


function upDowQuantity(option, selected) {

    var quantity = document.getElementById(`quantity${selected}`).value;


    quantity = parseInt(quantity);
    if (option === 'giam') {
        quantity -= 1;
        document.getElementById(`quantity${selected}`).value = quantity;
        if (quantity <= 0) {
            document.getElementById(`quantity${selected}`).value = 0;
        }
    } else {
        quantity += 1;
        document.getElementById(`quantity${selected}`).value = quantity;
        if (quantity >= 100) {
            document.getElementById(`quantity${selected}`).value = 100;
        }
    }
}


function upDowQuantityCartDetail(option, selected, productDetailId) {

    let quantityStock = null;

    $.ajax({
        url: `/TechStore/updatetocart`,
        type: 'get',
        data: {
            productDetailId: productDetailId
        }, success: function (response) {

            quantityStock = Number(response);

            let quantity_raw = document.getElementById(`quantity${selected}`).value;

            if (quantity_raw >= 1) {
                let priceUnit = document.querySelector(`#table-data-productdetail-${productDetailId} .price span`);
                let priceTotal = document.querySelector(`#table-data-productdetail-${productDetailId} .total span`);

                let quantity = Number(quantity_raw);

                let isDelete = false;
                if (option === 'giam') {
                    quantity -= 1;
                    if (quantity <= 0) {
                        quantity += 1;
                        document.getElementById(`quantity${selected}`).value = 1;
                        priceTotal.innerText = priceUnit.innerText;
                        isDelete = deleteProductFromCart(productDetailId);
                    } else {
                        document.getElementById(`quantity${selected}`).value = quantity;
                        console.log(quantity * priceUnit);
                        priceTotal.innerText = quantity * priceUnit.innerText;
                    }
                } else {
                    quantity += 1;

                    if (quantity > quantityStock) {
                        quantity -= 1;
                        showToast(`Sorry, you can only purchase up to ${quantityStock} for this product`);
                        document.getElementById(`quantity${selected}`).value = quantity;
                        priceTotal.innerText = quantity * priceUnit.innerText;
                    } else {
                        document.getElementById(`quantity${selected}`).value = quantity;
                        priceTotal.innerText = quantity * priceUnit.innerText;
                    }
                }

                if (isDelete === false) {
                    $.ajax({
                        url: `/TechStore/updatetocart`,
                        type: 'post',
                        data: {
                            productDetailId: productDetailId,
                            quantity: quantity,
                            option: option
                        }, success: function (response) {
                            updateQuickViewCart();

                            selectProductPayment();
                        }, error: function (fail) {
                            console.log("loi get search product" + fail);
                        }
                    });
                }
            } else {
                showToast("quantity must be a positive integer");

                document.getElementById(`quantity${selected}`).value = 1;
                priceTotal.innerText = 1 * priceUnit.innerText;
                quantity = 1;
            }

        }, error: function (fail) {
            console.log("loi get quantity stock by  product detail: " + fail);
        }
    });




}


function changeQuantityInCart(selected, productDetailId) {
    let quantityStock = null;

    $.ajax({
        url: `/TechStore/updatetocart`,
        type: 'get',
        data: {
            productDetailId: productDetailId
        }, success: function (response) {

            quantityStock = Number(response);

            let quantity_raw = document.getElementById(`quantity${selected}`).value;


            if (quantity_raw >= 1) {
                let priceUnit = document.querySelector(`#table-data-productdetail-${productDetailId} .price span`);
                let priceTotal = document.querySelector(`#table-data-productdetail-${productDetailId} .total span`);

                let quantity = Number(quantity_raw);

                let isDelete = false;

                if (quantity <= 0) {
                    quantity = 1;
                    document.getElementById(`quantity${selected}`).value = 1;
                    priceTotal.innerText = priceUnit.innerText;
                    isDelete = deleteProductFromCart(productDetailId);
                } else if (quantity > quantityStock) {
                    showToast(`Sorry, you can only purchase up to ${quantityStock} for this product`);
                    document.getElementById(`quantity${selected}`).value = quantityStock;
                    priceTotal.innerText = quantityStock * priceUnit.innerText;
                    quantity = quantityStock;
                } else {
                    document.getElementById(`quantity${selected}`).value = quantity;
                    priceTotal.innerText = quantity * priceUnit.innerText;
                }

                if (isDelete === false) {
                    console.log("abc");
                    $.ajax({
                        url: `/TechStore/updatetocart`,
                        type: 'post',
                        data: {
                            productDetailId: productDetailId,
                            quantity: quantity
                        }, success: function (response) {
                            updateQuickViewCart();
                            selectProductPayment();
                        }, error: function (fail) {
                            console.log("loi get search product" + fail);
                        }
                    });
                }
            } else {
                showToast("quantity must be a positive integer");

                document.getElementById(`quantity${selected}`).value = 1;
                priceTotal.innerText = 1 * priceUnit.innerText;
                quantity = 1;
            }




        }, error: function (fail) {
            console.log("loi get quantity stock by  product detail: " + fail);
        }
    });
}

function limit() {
    var quantity = document.getElementById("quantity0").value;
    quantity = parseInt(quantity);
    if (quantity <= 0) {
        document.getElementById("quantity0").value = 0;
    }
    if (quantity >= 100) {
        document.getElementById("quantity0").value = 100;
    }
}

function showToast(text) {
    const container = document.getElementById('toast-container');

    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.innerHTML = `${text} <div class="progress"></div>`;

    const closeBtn = document.createElement('button');
    closeBtn.className = 'close-btn';
    closeBtn.innerHTML = '&times;';
    closeBtn.onclick = () => toast.remove();

    toast.appendChild(closeBtn);
    container.insertBefore(toast, container.firstChild);

    setTimeout(() => {
        toast.remove();
    }, 5000);
}

function checkQuantityAddCart(coSan, productId) {

    console.log(`memoryId: ${memoryId}`)
    console.log(`colorId: ${colorId}`);
    var soLuongMua_raw = document.getElementById("quantity0").value;

    if (colorId === null || memoryId === null) {
        showToast("Please select product category!");

    } else {
        soLuongMua = parseInt(soLuongMua_raw);
        if (soLuongMua_raw === '') {

            showToast("Enter the quantity you want to buy!");

        } else if (soLuongMua > coSan) {

            showToast("Product quantity is not enough!");

        } else if (soLuongMua <= 0) {
            showToast("The quantity you want to buy must be a positive integer!");
        } else {
            // ve sau lm cart se xu ly o day

            let soLuongSanPhamCoTrongCartBanDau = null;

            $.ajax({
                url: `/TechStore/cartdetail`,
                type: 'post',
                data: {
                    productId: productId,
                    colorId: colorId,
                    memoryId: memoryId
                }, success: function (response) {
                    soLuongSanPhamCoTrongCartBanDau = Number(response);
                    let isCheckQuantity = true;

                    if (soLuongSanPhamCoTrongCartBanDau !== -1) {
                        if (soLuongSanPhamCoTrongCartBanDau + soLuongMua > coSan) {
                            isCheckQuantity = false;
                            showToast(`You can only buy up to ${coSan} for this product
     the quantity in your shopping cart for this product of is ${soLuongSanPhamCoTrongCartBanDau}`);
                        }
                    }

                    if (isCheckQuantity) {
                        console.log("Nghiem Xuan Loc");
                        showLoadingPopup();
                        $.ajax({
                            url: `/TechStore/addtocart`,
                            type: 'get',
                            data: {
                                productId: productId,
                                colorId: colorId,
                                memoryId: memoryId,
                                soLuong: soLuongMua
                            }, success: function (response) {
                                if (soLuongSanPhamCoTrongCartBanDau === -1) {
                                    console.log("add trung lap");
                                    updateQuantityIconCart('up');
                                }
                                updateQuickViewCart();
                                hideLoadingPopup();
                                showToast("Add to cart successfully!");
                            }, error: function (fail) {
                                console.log("loi get search product" + fail);
                            }
                        });
                    }
                }, error: function (fail) {
                    console.log("loi check so luong san pham co san trong cart ban dau: " + fail);
                }
            });



        }
    }
}

function closePopupNotification() {
    var popup = document.getElementsByClassName("popupNotification");

    popup[0].style.display = 'none';
}

var countProduct = 0;

function selectProductCompare(img, name, id) {
    var popup = document.getElementsByClassName("popup-compare");
    popup[0].style.display = 'flex';


    if (countProduct >= 2) {
        showToast("Vui long xoa bot san pham de tiep tuc so sanh");
//        notification("Vui long xoa bot san pham de tiep tuc so sanh");
    } else {
        countProduct++;

        var product1 = document.getElementById("product-1");
        var product2 = document.getElementById("product-2");

        console.log(product1.querySelector("span").innerText);

        if (countProduct == 1) {
            product1.querySelector("img").src = img;
            product1.querySelector("span").innerText = name;
            product1.querySelector("input").value = id;
        }

        if (countProduct == 2) {
            if (id === product1.querySelector("input").value) {
                showToast("Vui long khong chon 2 san pham giong nhau");
//                notification("Vui long khong chon 2 san pham giong nhau");
                countProduct--;
            } else {
                product2.querySelector("img").src = img;
                product2.querySelector("span").innerText = name;
                product2.querySelector("input").value = id;
            }

        }
    }
}

function findProductAddPopupCompare(item) {
    var popup = document.getElementById("nen-add-compare");
    if (item.src.toString().indexOf('logo-add') !== -1) {
        popup.style.display = 'block';
    }
}


function closePopupAddProductCompare() {
    var popup = document.getElementById("nen-add-compare");
    popup.style.display = 'none';

    document.getElementById("textSearchAddCompare").value = '';
    var row = document.getElementById("list-search-product-add-compare-suggestions");
    row.innerHTML = "";
}


function deleteCompare(option) {
    if (option === 'all') {
        var product1 = document.getElementById("product-1");
        var product2 = document.getElementById("product-2");

        product1.querySelector("img").src = '/TechStore/images/popup/logo-add.png';
        product1.querySelector("div span").innerText = '';
        product1.querySelector("input").value = '';

        product2.querySelector("img").src = '/TechStore/images/popup/logo-add.png';
        product2.querySelector("div span").innerText = '';
        product2.querySelector("input").value = '';
        countProduct = 0;
    } else if (option === '1') {
        var product2 = document.getElementById("product-2");


        var product1 = document.getElementById("product-1");
        product1.querySelector("img").src = product2.querySelector("img").src;
        product1.querySelector("div span").innerText = product2.querySelector("div span").innerText;
        product1.querySelector("input").value = product2.querySelector("input").value;
        product2.querySelector("img").src = '/TechStore/images/popup/logo-add.png';
        product2.querySelector("div span").innerText = '';
        product2.querySelector("input").value = '';
        countProduct--;
    } else {
        var product2 = document.getElementById("product-2");
        product2.querySelector("img").src = '/TechStore/images/popup/logo-add.png';
        product2.querySelector("div span").innerText = '';
        product2.querySelector("input").value = '';
        countProduct--;
    }
    if (countProduct === 0) {
        var popup = document.getElementsByClassName("popup-compare");
        var popupAddProduct = document.getElementById("nen-add-compare");

        popup[0].style.display = 'none';
        popupAddProduct.style.display = 'none';
    }
}

function compare() {
    var product1 = document.getElementById("product-1");
    var product2 = document.getElementById("product-2");

    var popupAddProductCompare = document.getElementById("nen-add-compare");
    popupAddProductCompare.style.display = 'none';

    var id1 = product1.querySelector("input").value;
    var id2 = product2.querySelector("input").value;


    if (id1 === '' || id2 === '') {
        notification("Vui long chon du 2 san pham");
    } else {
//        window.location = `compareproduct?productId1=${id1}&productId2=${id2}`;
        console.log(`productId1=${id1}&productId2=${id2}`);
        $.ajax({
            url: `/TechStore/compareproduct`,
            type: 'get',
            data: {
                productId1: id1,
                productId2: id2
            }, success: function (response) {
                var row = document.getElementById("pop-compare-detail");
                row.style.display = 'block';
                row.innerHTML = response;
            }, error: function (fail) {
                console.log("loi");
            }
        });
    }
}

function closeCompare() {
    var row = document.getElementById("pop-compare-detail");
    row.style.display = 'none';
}


function notification(text) {
    var popup = document.getElementById("popupNotification");
    var content = text;
    popup.querySelector("p").innerText = content;
    popup.style.display = 'block';


    setTimeout(() => {
        popup.style.display = 'none';
    }, 3000);
}


document.addEventListener('click', function (event) {
    const selectedArea = document.getElementById('pop-compare-detail');
    if (!selectedArea.contains(event.target)) {
        var row = document.getElementById("pop-compare-detail");
        row.style.display = 'none';
    }
});



function pagination(quantityFeedback, productId, select) {

    let totalPage = Math.ceil(quantityFeedback / 5);

    let pagination = document.getElementById("pagination");

    pagination.innerHTML = "";


    for (let i = 1; i <= totalPage; i++) {
        let liItem = document.createElement("li");

        let aItem = document.createElement("a");

        aItem.className = "waves-effect waves-teal";

        aItem.href = "javascript:void(0)";

        let numberPage = i;

        aItem.innerText = "" + numberPage;

        aItem.onclick = () => {

            let options = document.querySelectorAll("#reivewss span");

            // luu tru xem so sao ma minh mong muon la bao nhieu
            let selected = null;

            for (let i = 0; i < options.length; i++) {
                if (options[i].classList.contains('choose')) {
                    selected = options[i];
                    break;
                }
            }


            selectStarPagination(selected, select, productId, quantityFeedback, numberPage);
        };

        liItem.appendChild(aItem);

        if (totalPage >= 2) {
            pagination.appendChild(liItem);
        }
    }
}


function selectStarPagination(item, select, productId, quantityFeedback, numberPage) {
    // danh dau xem minh dang o option nao(all, 5 sao, 4 sao, 3 sao, ....)
    var listSelect = document.querySelectorAll("#reivewss span");

    for (let i = 0; i < listSelect.length; i++) {
        listSelect[i].classList.remove("choose");
    }

    item.classList.add("choose");


    // danh dau xem minh dang o page nao
    let paginationList = document.querySelectorAll("#pagination li a");

    console.log(paginationList);

    for (let i = 0; i < paginationList.length; i++) {
        paginationList[i].classList.remove("choose");
    }

    paginationList[numberPage - 1].classList.add("choose");


    $.ajax({
        url: `/TechStore/reloadreview`,
        type: 'get',
        data: {
            select: select,
            productId: productId,
            numberPage: numberPage
        }, success: function (response) {
            var row = document.getElementById("review-list");
            row.style.display = 'block';
            row.innerHTML = response;
        }, error: function (fail) {
            console.log("loi");
        }
    });
}


function selectStar(item, select, productId, quantityFeedback) {

//    console.log("number page: " + numberPage);
    pagination(quantityFeedback, productId, select);


    // danh dau xem minh dang o page nao
    let paginationList = document.querySelectorAll("#pagination li a");

    if (paginationList.length >= 2) {

        for (let i = 0; i < paginationList.length; i++) {
            paginationList[i].classList.remove("choose");
        }

        paginationList[0].classList.add("choose");
    }


    var listSelect = document.querySelectorAll("#reivewss span");

    for (let i = 0; i < listSelect.length; i++) {
        listSelect[i].classList.remove("choose");
    }

    item.classList.add("choose");
    $.ajax({
        url: `/TechStore/reloadreview`,
        type: 'get',
        data: {
            select: select,
            productId: productId,
            numberPage: 1
        }, success: function (response) {
            var row = document.getElementById("review-list");
            row.style.display = 'block';
            row.innerHTML = response;
        }, error: function (fail) {
            console.log("loi");
        }
    });
}


if (urlParams.get("productId") != null) {
    document.getElementById("start").click();
}


function likeFeedback(feedbackId) {
    console.log("like: " + feedbackId);

}

function reportFeedback(feedbackId) {
    console.log("report: " + feedbackId);
}


function autoSearch() {
    var textSearch = document.getElementById("textSearch").value.trim();

    $.ajax({
        url: `/TechStore/searchproduct`,
        type: 'get',
        data: {
            textSearch: textSearch,
            action: 'SearchProduct'
        }, success: function (response) {
            var row = document.getElementById("list-search-product-suggestions");
            if (response === '') {
                response = "No suitable products found!";
            }
            row.innerHTML = response;
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}

function autoSearchAddCompare() {
    var textSearch = document.getElementById("textSearchAddCompare").value.trim();

    $.ajax({
        url: `/TechStore/searchproduct`,
        type: 'get',
        data: {
            textSearch: textSearch,
            action: 'AddCompare'
        }, success: function (response) {
            var row = document.getElementById("list-search-product-add-compare-suggestions");
            if (response === '') {
                response = "No suitable products found!";
            }
            row.innerHTML = response;
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}




const inputTextSearchAddCompare = document.getElementById("textSearchAddCompare");
const searchSuggestions = document.getElementById("search-suggestions");

function showSuggestions() {
    var suggest = document.getElementById("search-suggestions");
    suggest.style.display = 'block';
}

function hiddenSuggestions() {
    var suggest = document.getElementById("search-suggestions");
    suggest.style.display = 'none';
}


function hoverSuggets() {
    inputTextSearchAddCompare.removeEventListener('blur', hiddenSuggestions);
//    showSuggestions();
}

function outSuggests() {
    inputTextSearchAddCompare.addEventListener('blur', hiddenSuggestions);
    inputTextSearchAddCompare.focus();
//    hiddenSuggestions();
}


inputTextSearchAddCompare.addEventListener('focus', showSuggestions);
inputTextSearchAddCompare.addEventListener('blur', hiddenSuggestions);


searchSuggestions.addEventListener('mouseover', hoverSuggets);
searchSuggestions.addEventListener('mouseout', outSuggests);



function selectProductWishList(productId) {
    $.ajax({
        url: `/TechStore/wishlist`,
        type: 'get',
        data: {
            productId: productId,
            action: "addwishlist"
        }, success: function (response) {
            var row = document.getElementById("so-luong-product");
            if (response === 'false') {
                showToast('Please log in to use this feature!');
            } else if (response !== 'false') {
                showToast('Add wishlist success!');
                row.innerText = response;
            }

        }, error: function (fail) {
            console.log("loi get select product" + fail);
        }
    });
}

function viewWishList(url) {
    $.ajax({
        url: `/TechStore/wishlist`,
        type: 'get',
        success: function (response) {
            if (response === 'false') {
                showToast('Please log in to use this feature!');
            } else {
                window.location = url;
            }
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}

function confirmDeleteWishList(productId) {
    if (confirm("Are you sure you want to remove this product from the waiting list?")) {
        deleteWishList(productId);
    }
}

function deleteWishList(productId) {
    var row = document.getElementById("so-luong-product");
    row.innerText = row.innerText - 1;
    $.ajax({
        url: `/TechStore/wishlist`,
        type: 'get',
        data: {
            productId: productId,
            action: "deleteWishList"
        }, success: function (response) {
            var row = document.getElementById("item-productt");
            row.innerHTML = response;
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}


function deleteProductFromCart(productDetailId) {
    if (confirm("Are you sure you want to remove this product from your cart?")) {

        // xoa product khoi vung nho nhung san pham da chon
        console.log("thang can deleted:", productDetailId, typeof (productDetailId + ""));

        console.log("truoc delete: ", productSelected);
        productSelected.delete(productDetailId + "");
        productSelectedAndQuantity.delete(productDetailId + "");
        console.log("nhung thang sau khi delete: ", productSelected);
        console.log(productSelectedAndQuantity);
        $.ajax({
            url: `/TechStore/deletetocart`,
            type: 'get',
            data: {
                productDetailId: productDetailId
            }, success: function (response) {
                var row = document.getElementById("table-data");
                row.innerHTML = response;

                // danh dau lai nhung thang da chon truoc do trong vung nho tam
                danhDauLaiNhungThangDaChon();

                updateQuantityIconCart('dow');
                updateQuickViewCart();
                selectProductPayment();
            }, error: function (fail) {
                console.log("loi get search product" + fail);
            }
        });
        return true;
    } else {
        return false;
    }
}

function updateQuantityIconCart(action) {
    let numberQuantity = document.getElementById("quantityIconCart");

    let quantity = Number(numberQuantity.innerText);

    if (action == 'up') {
        numberQuantity.innerText = quantity + 1;
    } else {
        numberQuantity.innerText = quantity - 1;
    }
}


function updateQuickViewCart() {
    $.ajax({
        url: `/TechStore/updatequickviewcart`,
        type: 'get',
        data: {
        }, success: function (response) {
            var row = document.getElementById("quick-view-cart");
            row.innerHTML = response;
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });
}

function danhDauLaiNhungThangDaChon() {

    // mang luu chu tat ca cac row trong cart
    let rowCarts = document.querySelectorAll("#table-data tr");

    for (let i = 0; i < rowCarts.length; i++) {
        let productDetailId = rowCarts[i].firstElementChild.children[1].value;

        // kiem tra xem product detail kia da ton tai trong set hay chua,
        // neu ton tai tuc la truoc do da duoc danh dau la selected;
        if (productSelected.has(productDetailId)) {
            rowCarts[i].firstElementChild.firstElementChild.checked = true;
        }
    }
}

// Lấy phần tử loading-popup
var loadingPopup = document.getElementById("loading-popup");

// Giả sử chúng ta có một nút để bắt đầu tải dữ liệu từ server
var loadDataButton = document.getElementById("load-data-button");

// Hàm để hiển thị popup loading
function showLoadingPopup() {
    loadingPopup.style.display = "flex";
}

// Hàm để ẩn popup loading
function hideLoadingPopup() {
    loadingPopup.style.display = "none";
}



// Mở popup với tên sản phẩm
function openPopup(productId) {

    $.ajax({
        url: `/TechStore/productdetail`,
        type: 'post',
        data: {
            productId: productId,
            option: 'common'
        }, success: function (response) {
            var row = document.getElementById("product-detail-popup");
            row.innerHTML = response;

            document.getElementById('popup').style.display = 'flex';

        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });


}

// Đóng popup
function closePopup() {
    document.getElementById('popup').style.display = 'none';
    colorId = null;
    memoryId = null;
}

// Xác nhận mua hàng
function confirmPurchase() {
    alert('Purchase confirmed!');
    closePopup();
}

// Đóng popup khi click ra ngoài
window.addEventListener('click', function (event) {
    var popup = document.getElementById('popup');
    if (event.target === popup) {
        closePopup();
    }
});

// Đóng popup khi click vào nút đóng
document.querySelector('.close-btn').addEventListener('click', closePopup);



function checkCustomerInformation() {
    let fullName = document.getElementById("fullName").value;
    let email = document.getElementById("emaill").value;
    let phoneNumber = document.getElementById("phoneNumber").value;
    let address = document.getElementById("addressForm").value;
    let notes = document.getElementById("notes").value;


    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    const vietnamPhoneRegex = /^0\d{9}$/;


    console.log(email);
    console.log(address);

    if (fullName == '') {
        showToast("fullName cannot be empty!");
    } else if (!emailRegex.test(email)) {
        showToast("Email invalidate!");
    } else if (!vietnamPhoneRegex.test(phoneNumber)) {
        showToast("phone nubmer invalidate!");
    } else if (address == '') {
        showToast("Address invalidate!");
    } else {
        document.getElementById("form-checkout").submit();
    }
}


function handleSubmitForm() {
    let form = document.getElementById("formCartContact");

    if (productSelected.size) {
        form.submit();
    } else {
        showToast("Please select at least 1 product!");
    }
}