
function selectOptionShowProduct(e) {
    let showNumberProduct = document.getElementById("showNumberProduct");
    showNumberProduct.value = e.value;

    document.getElementById("numberPage").value = 1;

    let myForm = document.getElementById("form-filter");

    if (myForm) {
        myForm.submit();
    } else {
        console.log("loi submit form");
    }
}

function selectOptionSortProduct(e) {
    let sortProduct = document.getElementById("sortByProduct");
    sortProduct.value = e.value;

    let myForm = document.getElementById("form-filter");

    if (myForm) {
        myForm.submit();
    } else {
        console.log("loi submit form");
    }

}

// ham de xu ly viec nguoi dung chon ac option, khong duoc chon cung luc
// option all va cac option khac


function selectOption(e, idUL, idAll) {

    let selectAll = true;

    let checkbox = document.querySelectorAll(`#${idUL} li input`);

    console.log(checkbox);

    if (e.id != idAll) {
        selectAll = false;

        let countChecked = 0;
        for (let i = 0; i < checkbox.length; i++) {
            if (checkbox[i].id != idAll) {
                if (checkbox[i].checked === true) {
                    countChecked++;
                }
            }
        }

        if (countChecked === checkbox.length - 1) {
            selectAll = true;
            for (let i = 0; i < checkbox.length; i++) {
                checkbox[i].checked = false;
            }
        }

        if (countChecked === 0) {
            selectAll = true;
        }
    } else {
        selectAll = true;
        for (let i = 0; i < checkbox.length; i++) {
            checkbox[i].checked = false;
        }
    }

    document.getElementById(idAll).checked = selectAll;

    let myForm = document.getElementById("form-filter");

    if (myForm) {
        myForm.submit();
    } else {
        console.log("loi submit form");
    }
}


function selectOptionPage(numberPage) {
    console.log(numberPage);

    document.getElementById("numberPage").value = numberPage;

    let myForm = document.getElementById("form-filter");

    if (myForm) {
        myForm.submit();
    } else {
        console.log("loi submit form");
    }
}

function showFeedbackPopup(productId) {
    document.getElementById('feedback-popup-overlay').style.display = 'flex';
    document.getElementById("product-contribution").value = productId;
}

function hideFeedbackPopup(event) {
    if (event.target.id === 'feedback-popup-overlay' || event.target.className === 'feedback-close-btn') {
        document.getElementById('feedback-popup-overlay').style.display = 'none';
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


document.getElementById('feedback-form').addEventListener('submit', function (event) {
    event.preventDefault();
    // Handle form submission here

    let nameUserContribution = document.getElementById("name-contribution").value;

    let emailUserContribution = document.getElementById("email-contribution").value;

    let feedbackContribution = document.getElementById("feedback-contribution").value;

    let action = document.getElementById("action-contribution").value;

    let productId = document.getElementById("product-contribution").value;


    $.ajax({
        url: `/TechStore/productcontribution`,
        type: 'get',
        data: {
            nameUserContribution: nameUserContribution,
            emailUserContribution: emailUserContribution,
            feedbackContribution: feedbackContribution,
            action: action,
            productId: productId
        }, success: function (response) {


            if (response === "Your response has been noted") {
                document.getElementById("feedback-contribution").value = '';
                // close form sau khi da summit
                document.getElementById('feedback-popup-overlay').style.display = 'none';
            }
            showToast(response);
        }, error: function (fail) {
            console.log("loi get search product" + fail);
        }
    });


});

function showMoreSiderOption(e) {
    document.getElementById("sider-option").style.display = 'block';
    e.style.display = 'none';
}

function hiddenSiderOption(e) {
    document.getElementById("sider-option").style.display = 'none';
    document.getElementById("buttion-show-more").style.display = 'block';
}