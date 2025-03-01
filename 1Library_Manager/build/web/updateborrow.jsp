<%-- 
    Document   : updatecategory
    Created on : Mar 2, 2024, 10:22:23 PM
    Author     : BUI TUAN DAT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Borrow</title>
        <style>
            /* Style for the modal container */
            .modal-body {
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Style for each form group */
            .form-group {
                margin-bottom: 15px;
            }

            /* Label styling */
            .form-group label {
                font-weight: bold;
                color: #333;
                font-size: 16px;
                margin-bottom: 8px;
                display: block;
            }

            /* Input and select box styling */
            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            /* Focus effect for input and select */
            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.25);
            }

            /* Making the input boxes look cleaner and modern */
            input[type="number"],
            input[type="date"],
            select {
                color: #333;
            }

            /* Styling for readonly input */
            input[readonly] {
                background-color: #f0f0f0;
                cursor: not-allowed;
            }

            /* Styling the submit button */
            .btn-info {
                background-color: #17a2b8;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-info:hover {
                background-color: #138496;
            }

            /* Responsive styling for mobile view */
            @media (max-width: 768px) {
                .modal-body {
                    padding: 15px;
                }

                .form-control {
                    padding: 8px;
                    font-size: 12px;
                }

                .btn-info {
                    width: 100%;
                }
            }

        </style>
    </head>
    <body>
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">						
                        <h4 class="modal-title">Update Borrow</h4>
                    </div>
                    <c:set value="${requestScope.cupdate}" var="c"/>
                    <form action="updateborrow"  method="post">

                        <div class="modal-body">
                            <!-- Id field -->
                            <div class="form-group">
                                <label for="id">Id</label>
                                <input type="number" class="form-control" required name="id" value="${c.borrowId}" readonly>
                            </div>

                            <!-- Borrow Date field -->
                            <div class="form-group">
                                <label for="borrowdate">Borrow Date</label>
                                <input type="date" class="form-control" required name="borrowdate" value="${c.borrowDate}">
                            </div>

                            <!-- Due Date field -->
                            <div class="form-group">
                                <label for="duedate">Due Date</label>
                                <input type="date" class="form-control" required name="duedate" value="${c.dueDate}">
                            </div>

                            <!-- Return Date field -->
                            <div class="form-group">
                                <label for="returndate">Return Date</label>
                                <input type="date" class="form-control" name="returndate" value="${c.returnDate}">
                            </div>

                            <!-- Status field -->
                            <div class="form-group">
                                <label for="status">Status</label>
                                <select class="form-control" name="status" required>
                                    <option value="borrowed" ${c.status == 'borrowed' ? 'selected' : ''}>Borrowed</option>
                                    <option value="late" ${c.status == 'late' ? 'selected' : ''}>Late</option>
                                    <option value="returned" ${c.status == 'returned' ? 'selected' : ''}>Returned</option>
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
