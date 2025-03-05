/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

//line chart in here


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
        window.location = `productsdetail?option=detail&productId=${productId}&colorId=${colorId}&memoryId=${memoryId}`;
    } else if (memoryId === null && colorId === null) {
        window.location = `productsdetail?option=common&productId=${productId}`;
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
            url: `/TechStore/productdetails`,
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
            url: `/TechStore/productdetails`,
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

