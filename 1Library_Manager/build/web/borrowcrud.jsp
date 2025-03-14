<%-- 
    Document   : CRUD
    Created on : Feb 29, 2024, 9:53:05 AM
    Author     : BUI TUAN DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            * {
                font-family: 'Roboto', sans-serif !important;
                font-weight: 400;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family: 'Roboto', sans-serif;
                font-weight: 700;
            }
            body, p, span, a, li, label, button {
                font-family: 'Roboto', sans-serif;
                font-weight: 400;
            }
        </style>
        <style>
            body {
                color: #566787;
                background: #f5f5f5;
                font-family: 'Varela Round', sans-serif;
                font-size: 13px;
            }
            .table-responsive {
                margin: 30px 0;
            }
            .table-wrapper {
                background: #fff;
                padding: 20px 25px;
                border-radius: 3px;
                min-width: 1000px;
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 15px;
                background: #435d7d;
                color: #fff;
                padding: 16px 30px;
                min-width: 100%;
                margin: -20px -25px 10px;
                border-radius: 3px 3px 0 0;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
            .table-title .btn-group {
                float: right;
            }
            .table-title .btn {
                color: #fff;
                float: right;
                font-size: 13px;
                border: none;
                min-width: 50px;
                border-radius: 2px;
                border: none;
                outline: none !important;
                margin-left: 10px;
            }
            .table-title .btn i {
                float: left;
                font-size: 21px;
                margin-right: 5px;
            }
            .table-title .btn span {
                float: left;
                margin-top: 2px;
            }
            table.table tr th, table.table tr td {
                border-color: #e9e9e9;
                padding: 12px 15px;
                vertical-align: middle;
            }
            table.table tr th:first-child {
                width: 60px;
            }
            table.table tr th:last-child {
                width: 100px;
            }
            table.table-striped tbody tr:nth-of-type(odd) {
                background-color: #fcfcfc;
            }
            table.table-striped.table-hover tbody tr:hover {
                background: #f5f5f5;
            }
            table.table th i {
                font-size: 13px;
                margin: 0 5px;
                cursor: pointer;
            }
            table.table td:last-child i {
                opacity: 0.9;
                font-size: 22px;
                margin: 0 5px;
            }
            table.table td a {
                font-weight: bold;
                color: #566787;
                display: inline-block;
                text-decoration: none;
                outline: none !important;
            }
            table.table td a:hover {
                color: #2196F3;
            }
            table.table td a.edit {
                color: #FFC107;
            }
            table.table td a.delete {
                color: #F44336;
            }
            table.table td i {
                font-size: 19px;
            }
            table.table .avatar {
                border-radius: 50%;
                vertical-align: middle;
                margin-right: 10px;
            }
            .pagination {
                float: right;
                margin: 0 0 5px;
            }
            .pagination li a {
                border: none;
                font-size: 13px;
                min-width: 30px;
                min-height: 30px;
                color: #999;
                margin: 0 2px;
                line-height: 30px;
                border-radius: 2px !important;
                text-align: center;
                padding: 0 6px;
            }
            .pagination li a:hover {
                color: #666;
            }
            .pagination li.active a, .pagination li.active a.page-link {
                background: #03A9F4;
            }
            .pagination li.active a:hover {
                background: #0397d6;
            }
            .pagination li.disabled i {
                color: #ccc;
            }
            .pagination li i {
                font-size: 16px;
                padding-top: 6px
            }
            .hint-text {
                float: left;
                margin-top: 10px;
                font-size: 13px;
            }
            /* Custom checkbox */
            .custom-checkbox {
                position: relative;
            }
            .custom-checkbox input[type="checkbox"] {
                opacity: 0;
                position: absolute;
                margin: 5px 0 0 3px;
                z-index: 9;
            }
            .custom-checkbox label:before{
                width: 18px;
                height: 18px;
            }
            .custom-checkbox label:before {
                content: '';
                margin-right: 10px;
                display: inline-block;
                vertical-align: text-top;
                background: white;
                border: 1px solid #bbb;
                border-radius: 2px;
                box-sizing: border-box;
                z-index: 2;
            }
            .custom-checkbox input[type="checkbox"]:checked + label:after {
                content: '';
                position: absolute;
                left: 6px;
                top: 3px;
                width: 6px;
                height: 11px;
                border: solid #000;
                border-width: 0 3px 3px 0;
                transform: inherit;
                z-index: 3;
                transform: rotateZ(45deg);
            }
            .custom-checkbox input[type="checkbox"]:checked + label:before {
                border-color: #03A9F4;
                background: #03A9F4;
            }
            .custom-checkbox input[type="checkbox"]:checked + label:after {
                border-color: #fff;
            }
            .custom-checkbox input[type="checkbox"]:disabled + label:before {
                color: #b8b8b8;
                cursor: auto;
                box-shadow: none;
                background: #ddd;
            }
            /* Modal styles */
            .modal .modal-dialog {
                max-width: 400px;
            }
            .modal .modal-header, .modal .modal-body, .modal .modal-footer {
                padding: 20px 30px;
            }
            .modal .modal-content {
                border-radius: 3px;
                font-size: 14px;
            }
            .modal .modal-footer {
                background: #ecf0f1;
                border-radius: 0 0 3px 3px;
            }
            .modal .modal-title {
                display: inline-block;
            }
            .modal .form-control {
                border-radius: 2px;
                box-shadow: none;
                border-color: #dddddd;
            }
            .modal textarea.form-control {
                resize: vertical;
            }
            .modal .btn {
                border-radius: 2px;
                min-width: 100px;
            }
            .modal form label {
                font-weight: normal;
            }
        </style>

        <style>
            .btn-payment {
                background-color: red; /* Màu cam */
                color: white;
            }
            .btn-return {
                background-color: #ff9800; /* Màu xanh */
                color: white;
            }
        </style>
        <script>
            $(document).ready(function () {
                // Activate tooltip
                $('[data-toggle="tooltip"]').tooltip();

                // Select/Deselect checkboxes
                var checkbox = $('table tbody input[type="checkbox"]');
                $("#selectAll").click(function () {
                    if (this.checked) {
                        checkbox.each(function () {
                            this.checked = true;
                        });
                    } else {
                        checkbox.each(function () {
                            this.checked = false;
                        });
                    }
                });
                checkbox.click(function () {
                    if (!this.checked) {
                        $("#selectAll").prop("checked", false);
                    }
                });
            });

            function showModal(entityType) {
                $('#add' + entityType + 'Modal').modal('show');
            }
            function toDelete(id) {
                if (confirm("Bạn có muốn xóa Borrow với id=" + id + " không?")) {
                    window.location = "deleteborrow?id=" + id;
                }
            }
        </script>
    </head>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">

                            <div class="row">
                                <div class="col">
                                    <a href="acrud"><button class="btn btn-secondary"  >Account</button></a>
                                </div>
                                <div class="col">
                                    <a href="lcrud"><button class="btn btn-secondary"  >Library</button></a>
                                </div>
                                <div class="col">
                                    <a href="bcrud"><button class="btn btn-secondary"  >Borrow</button></a>
                                </div>
                                <div class="col">
                                    <a href="crud"><button class="btn btn-secondary"  >Chart</button></a>
                                </div>
                            </div>


                            <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons"></i> <span>Add Borrow</span></a>


                            <div class="col">
                                <h2 style="color: red">${requestScope.error}</h2>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <div class="row mb-3">
                            <div class="col">
                                <input type="text" id="searchInput" class="form-control" placeholder="Tìm theo User hoặc Book...">
                            </div>
                        </div>
                        <div>Tổng số Borrow: ${requestScope.size}</div>
                        <script>
                            document.getElementById("searchInput").addEventListener("keyup", function () {
                                let input = this.value.toLowerCase();
                                let rows = document.querySelectorAll("table tbody tr");

                                rows.forEach(row => {
                                    let user = row.cells[2].textContent.toLowerCase(); 
                                    let book = row.cells[3].textContent.toLowerCase(); 

                                    if (user.includes(input) || book.includes(input)) {
                                        row.style.display = "";
                                    } else {
                                        row.style.display = "none";
                                    }
                                });
                            });
                        </script>
                        <thead>
                            <tr>
                                <th>
                                    <span class="custom-checkbox">
                                        <input type="checkbox" id="selectAll">
                                        <label for="selectAll"></label>
                                    </span>
                                </th>

                                <th>Id</th>
                                <th>User</th>
                                <th>Book</th>
                                <th>Borrow Date</th>
                                <th>Due Date</th>
                                <th>Return Date</th>
                                <th>Status</th>
                                <th>Action</th>
                                <th>Return</th>
                            </tr>
                        </thead>
                        <tbody>

                            <!--do du lieu vao bang account-->
                            <c:forEach var="cl" items="${requestScope.borrowlist}">
                                <c:set value="${cl.borrowId}" var="id"/>
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options[]" value="1">
                                            <label for="checkbox1"></label>
                                        </span>
                                    </td>

                                    <td>${cl.borrowId}</td>
                                    <td>${cl.nameUser}</td>
                                    <td>${cl.nameBook}</td>
                                    <td>${cl.borrowDate}</td>
                                    <td>${cl.dueDate}</td>
                                    <td>${cl.returnDate}</td>
                                    <td>${cl.status}</td>
                                    <td>
                                        <a href="updateborrow?id=${cl.borrowId}">Update</a>
                                        <a href="#" onclick="toDelete('${cl.borrowId}')">Delete</a>
                                    </td>
                                    <td>
                                        <c:if test="${cl.status eq 'late'}">
                                            <a href="payment?id=${cl.borrowId}" class="btn btn-payment">Payment</a>
                                        </c:if>
                                        <c:if test="${cl.status eq 'borrowed'}">
                                            <a href="return?id=${cl.borrowId}" class="btn btn-return">Return</a>
                                        </c:if>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="clearfix">
                        <div class="hint-text"><a href="home">Back to home</a></div>
                    </div>
                </div>
            </div>        
        </div>

        <!-- Edit Modal HTML -->


        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="addborrow" method="GET">

                        <div class="modal-header">						
                            <h4 class="modal-title">Add Borrow</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>

                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name User</label>
                                <input type="text" class="form-control" required name="nameUser">
                            </div>
                            <div class="form-group">
                                <label>Name Book</label>
                                <input type="text" class="form-control" required name="nameBook">
                            </div>
                            <div class="form-group">
                                <label>Borrow Date</label>
                                <input type="date" class="form-control" required name="borrowDate" id="borrowDate">
                            </div>
                            <div class="form-group">
                                <label>Number of Days for Borrow</label>
                                <input type="number" class="form-control" required name="numberOfDays" id="numberOfDays" min="1">
                            </div>
                            <div class="form-group">
                                <label>Due Date</label>
                                <input type="date" class="form-control" required name="dueDate" id="dueDate" readonly>
                            </div>
                            <div class="form-group">
                                <label>Status</label>
                                <input type="text" class="form-control" required name="status" id="status" readonly value="borrowed">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- Delete Modal HTML -->
        <div id="deleteEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">						
                            <h4 class="modal-title">Delete Employee</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <p>Are you sure you want to delete these Records?</p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            window.onload = function () {
                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();

                today = yyyy + '-' + mm + '-' + dd;

                document.getElementById("borrowDate").value = today;
            };
        </script>
        <script>
            window.onload = function () {
                // Lấy ngày hiện tại và gán vào Borrow Date
                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                today = yyyy + '-' + mm + '-' + dd;
                document.getElementById("borrowDate").value = today;

                // Lắng nghe sự thay đổi của Borrow Date và số ngày cho thuê để tính lại Due Date
                document.getElementById("borrowDate").addEventListener('change', calculateDueDate);
                document.getElementById("numberOfDays").addEventListener('input', calculateDueDate);

                function calculateDueDate() {
                    var borrowDate = document.getElementById("borrowDate").value;
                    var numberOfDays = document.getElementById("numberOfDays").value;

                    if (borrowDate && numberOfDays) {
                        var dueDate = new Date(borrowDate);
                        dueDate.setDate(dueDate.getDate() + parseInt(numberOfDays));

                        // Định dạng lại ngày due date theo định dạng YYYY-MM-DD
                        var dd = String(dueDate.getDate()).padStart(2, '0');
                        var mm = String(dueDate.getMonth() + 1).padStart(2, '0');
                        var yyyy = dueDate.getFullYear();
                        var dueDateFormatted = yyyy + '-' + mm + '-' + dd;

                        // Gán giá trị tính toán được vào trường Due Date
                        document.getElementById("dueDate").value = dueDateFormatted;
                    }
                }
            };
        </script>
        <script>
            document.getElementById("numberOfDays").addEventListener("input", function () {
                let borrowDate = document.getElementById("borrowDate").value;
                let days = parseInt(this.value);

                if (borrowDate && days > 0) {
                    let date = new Date(borrowDate);
                    date.setDate(date.getDate() + days);
                    let dueDate = date.toISOString().split("T")[0];
                    document.getElementById("dueDate").value = dueDate;
                }
            });
        </script>


    </body>
</html>
