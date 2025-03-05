/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function sortTableByID() {
    sortTable(0, true);
}

// Hàm sắp xếp theo các cột khác
function sortTableByColumn(n) {
    sortTable(n, false);
}

// Hàm sắp xếp dữ liệu dựa trên cột được chọn
function sortTable(n, isNumeric) {
    let table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = document.getElementById("responsive-data-table");
    switching = true;
    dir = "asc";
    while (switching) {
        switching = false;
        rows = table.rows;
        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            //Khai báo biến cột theo tag td để thêm vào mảng so sánh
            x = rows[i].getElementsByTagName("TD")[n];
            y = rows[i + 1].getElementsByTagName("TD")[n];
            if (isNumeric) {
                /*So sánh giá trị của ID để sắp xếp*/
                if (dir === "asc") {//sắp xếp bảng tăng dần
                    if (Number(x.innerHTML) > Number(y.innerHTML)) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (dir === "desc") {//sắp xếp bảng giảm dần
                    if (Number(x.innerHTML) < Number(y.innerHTML)) {
                        shouldSwitch = true;
                        break;
                    }
                }
            } else {/*Kiểm tra để sắp xếp các buton của status sau khi chuyển trạng thái để sort*/
                let xVal = x.getElementsByTagName("button")[0] ? x.getElementsByTagName("button")[0].textContent.toLowerCase() : x.innerHTML.toLowerCase();
                let yVal = y.getElementsByTagName("button")[0] ? y.getElementsByTagName("button")[0].textContent.toLowerCase() : y.innerHTML.toLowerCase();
                if (dir === "asc") {//tăng dần
                    if (xVal.localeCompare(yVal) > 0) {
                        shouldSwitch = true;
                        break;
                    }
                } else if (dir === "desc") {//giảm dần
                    if (xVal.localeCompare(yVal) < 0) {
                        shouldSwitch = true;
                        break;
                    }
                }
            }
        } /*Sắp xếp các cột khác theo alphabet của kí tự đầu tiên trong chuỗi*/
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            switchcount++;
        } else {
            if (switchcount === 0 && dir === "asc") {
                dir = "desc";
                switching = true;
            }
        }
    }
}
/*Nút thay đổi Status từ Hide sang Show và ngược lại*/
function toggleButton(button) {
    //Add a confirmation dialog
    if (!confirm('Are you sure want to change status')) {
        return;
    }

    // Toggle the button color and text
    if (button.textContent === 'Show') {
        button.className = 'btn btn-danger';
        button.textContent = 'Hide';
    } else {
        button.className = 'btn btn-success';
        button.textContent = 'Show';
    }
    // Submit the form
    button.parentElement.submit();
}
var direction = 1; // 1 for ascending, -1 for descending

function sortTableByFeatured() {
    let table, rows, switching, i, x, y, shouldSwitch;
    table = document.getElementById("responsive-data-table");
    switching = true;
    while (switching) {
        switching = false;
        rows = table.rows;
        for (i = 1; i < (rows.length - 1); i++) {
            shouldSwitch = false;
            x = rows[i].getElementsByTagName("TD")[5]; // 5 is the index of the "Featured" column
            y = rows[i + 1].getElementsByTagName("TD")[5];
            if (direction * statusValue(x.innerHTML) > direction * statusValue(y.innerHTML)) {
                shouldSwitch = true;
                break;
            }
        }
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
        }
    }
    // Flip the direction for the next sort
    direction *= -1;
}

function statusValue(status) {
    switch (status.trim()) {
        case 'Latest':
            return 3;
        case 'Recently':
            return 2;
        case 'Oldest':
            return 1;
        default:
            return 0;
    }
}

/*Post detail */
function togglePostStatus() {
    // Logic to toggle post status goes here
    // Change the color of the flag icon based on the post status
    var flagIcon = document.getElementById('flag-icon');
    if (post.isActive) {
        flagIcon.style.color = 'green';
    } else {
        flagIcon.style.color = 'red';
    }
}

/*Validate form*/


/*Add new post category*/


