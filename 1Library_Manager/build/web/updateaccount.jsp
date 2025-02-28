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
        <title>JSP Page</title>
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
                                <input type="number" class="form-control" required name="id" value="${a.aid}" readonly>
                            </div>
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" required name="name" value="${a.name}">
                            </div>
                            <div class="form-group">
                                <label>Amount</label>
                                <input type="number" class="form-control" required name="amount" value="${a.amount}">
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
                                <label>Role</label>
                                <input type="number" class="form-control" required name="role" value="${a.role}">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <input type="submit" class="btn btn-info" value="Update">
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
