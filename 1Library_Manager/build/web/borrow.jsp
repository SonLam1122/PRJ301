<%-- 
    Document   : borrow
    Created on : Mar 2, 2025, 3:08:27 AM
    Author     : SonLam29
--%>

<%@ page import="java.util.ArrayList, model.BorrowHistory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Borrow History</title>
        <!-- Thêm link tới Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
            /* Tùy chỉnh thêm CSS */
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }

            h2 {
                text-align: center;
                margin: 20px 0;
            }

            .table {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: white;
            }

            .table th, .table td {
                text-align: center;
                vertical-align: middle;
            }

            .table thead {
                background-color: #007bff;
                color: white;
            }

            .table th, .table td {
                padding: 10px;
            }

            .action-buttons a {
                color: #007bff;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 5px;
            }

            .action-buttons a:hover {
                background-color: #e2e6ea;
            }

            .no-data {
                text-align: center;
                font-style: italic;
                color: #999;
            }

            /* Thêm style cho nút quay lại */
            .back-btn {
                display: block;
                width: 200px;
                margin: 30px auto;
                text-align: center;
            }
        </style>
    </head>
    <body>

        <h2>Borrow History - ${username}</h2>

        <!-- Form gửi tự động khi người dùng đã đăng nhập -->
        <form action="borrow" method="GET">
            <input type="hidden" name="username" value="${username}" />
        </form>

        <div class="container">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Sách</th>
                        <th>Ngày Mượn</th>
                        <th>Ngày Đến Hạn</th>
                        <th>Ngày Trả</th>
                        <th>Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty borrowList}">
                            <c:forEach var="borrow" items="${borrowList}">
                                <tr>
                                    <td>${borrow.borrowId}</td>
                                    <td>${borrow.nameBook}</td>
                                    <td>${borrow.borrowDate}</td>
                                    <td>${borrow.dueDate}</td>
                                    <td>${borrow.returnDate != null ? borrow.returnDate : "Chưa trả"}</td>
                                    <td>${borrow.status}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="7" class="no-data">Không có dữ liệu</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- Nút quay lại Home -->
            <div class="back-btn">
                <a href="home" class="btn btn-secondary btn-lg">Quay lại Home</a>
            </div>
        </div>

        <!-- Thêm link tới Bootstrap JS và Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>


