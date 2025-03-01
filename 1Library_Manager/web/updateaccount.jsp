<%-- 
    Document   : updateaccount
    Created on : Mar 2, 2024, 9:49:19 PM
    Author     : BUI TUAN DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update User</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .modal {
                display: block;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                overflow: auto;
            }

            .modal-dialog {
                width: 500px;
                margin: 10% auto;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                padding: 20px;
            }

            .modal-header {
                background-color: #007bff;
                color: white;
                padding: 10px 15px;
                text-align: center;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .modal-title {
                margin: 0;
                font-size: 1.5em;
            }

            .modal-body {
                padding: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
                display: inline-block;
                color: #333;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 1em;
                color: #333;
            }

            .form-group input:focus,
            .form-group select:focus {
                outline: none;
                border-color: #007bff;
            }

            .modal-footer {
                display: flex;
                justify-content: center;
                padding: 15px;
                border-top: 1px solid #ccc;
                border-bottom-left-radius: 8px;
                border-bottom-right-radius: 8px;
            }

            .btn-info {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                font-size: 1em;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-info:hover {
                background-color: #0056b3;
            }
        </style>

    </head>
    <body>
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">						
                        <h4 class="modal-title">Update Employee</h4>
                    </div>
                    <c:set var="a" value="${requestScope.aupdate}"/>
                    <form action="update" method="post">
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Id</label>
                                <input type="number" class="form-control" required name="id" value="${a.userId}" readonly>
                            </div>
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" required name="name" value="${a.name}">
                            </div>
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" class="form-control" required name="user" value="${a.username}">
                            </div>	
                            <div class="form-group">
                                <label>Password</label>
                                <input type="text" class="form-control" required name="pass" value="${a.password}">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" class="form-control" required name="email" value="${a.email}">
                            </div>
                            <div class="form-group">
                                <label>Role</label>
                                <select class="form-control" required name="role">
                                    <option value="user" ${a.role == 'user' ? 'selected' : ''}>User</option>
                                    <option value="admin" ${a.role == 'admin' ? 'selected' : ''}>Admin</option>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <input type="submit" class="btn btn-info" value="Update" style="margin-right: 10px;">
                            <input type="button" class="btn btn-info" value="Cancel" onclick="window.history.back();">
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
