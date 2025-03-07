<%-- 
    Document   : updateproduct
    Created on : Mar 2, 2024, 10:41:45 PM
    Author     : BUI TUAN DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Book</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
            }

            .modal-content {
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                background-color: #17a2b8;
                color: white;
                text-align: center;
                padding: 10px 0;
                border-radius: 10px 10px 0 0;
            }

            .modal-body {
                padding: 30px;
                background-color: #f8f9fa;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: bold;
                color: #495057;
            }

            .form-control {
                border-radius: 5px;
                border: 1px solid #ced4da;
                padding: 10px;
                font-size: 14px;
                width: 100%;
                box-sizing: border-box;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #80bdff;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.8);
            }

            .form-control[type="date"] {
                padding: 8px;
            }

            .btn {
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .btn-info {
                background-color: #17a2b8;
                color: white;
                border: none;
            }

            .btn-info:hover {
                background-color: #138496;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
                border: none;
            }

            .btn-secondary:hover {
                background-color: #5a6268;
            }

            .modal-footer {
                text-align: center;
                padding: 20px;
            }

            #error-message {
                font-size: 14px;
                margin-top: 5px;
            }
        </style>

    </head>
    <body>
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">						
                        <h4 class="modal-title">Update Product</h4>
                    </div>
                    <c:set var="p" value="${requestScope.pupdate}" />
                    <form action="updatebook" method="post">

                        <div class="modal-body">					
                            <div class="form-group">
                                <label>ID</label>
                                <input type="number" class="form-control" required name="id" value="${p.bookId}">
                            </div>
                            <div class="form-group">
                                <label>Title</label>
                                <input type="text" class="form-control" required name="title" value="${p.title}">
                            </div>
                            <div class="form-group">
                                <label>Author</label>
                                <input type="text" class="form-control" required name="author" value="${p.author}">
                            </div>
                            <div class="form-group">
                                <label>Publisher</label>
                                <input type="text" class="form-control" required name="publisher" value="${p.publisher}">
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <input type="text" class="form-control" required name="category" value="${p.category}">
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <input type="text" class="form-control" required name="description" value="${p.description}">
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input type="text" class="form-control" required name="image" value="${p.image}">
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <input type="number" class="form-control" required name="quantity" value="${p.quantity}">
                            </div>
                            <div class="form-group">
                                <label>Created At</label>
                                <input type="date" class="form-control" required name="createdAt" value="${p.createdAt}">
                            </div>
                            <div class="form-group">
                                <label>Updated At</label>
                                <input type="date" class="form-control" required name="updatedAt" id="updatedAt" value="${p.updatedAt}">
                                <span id="error-message" style="color: red; display: none;">Ngày không thể lớn hơn ngày hôm nay.</span>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-info" value="Update">
                                <input type="button" class="btn btn-secondary" value="Cancel" onclick="window.history.back();">
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
        <script>
            // Set today's date as the default value for "Updated At" field
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('updatedAt').value = today;

            // Check if the selected date is greater than today
            document.getElementById('updatedAt').addEventListener('input', function () {
                const selectedDate = this.value;
                if (selectedDate > today) {
                    document.getElementById('error-message').style.display = 'inline';
                    this.setCustomValidity('Ngày không thể lớn hơn ngày hôm nay.');
                } else {
                    document.getElementById('error-message').style.display = 'none';
                    this.setCustomValidity('');
                }
            });
        </script>
    </body>
</html>
