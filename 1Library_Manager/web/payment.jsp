<%-- 
    Document   : payment.jsp
    Created on : Mar 3, 2025, 3:59:59 PM
    Author     : ASUS VIVOBOOK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Borrow, dal.BorrowDAO"%>
<%@page import="java.time.LocalDate"%>
<%
    // Nhận borrowId từ request
    String borrowIdParam = request.getParameter("id");
    if (borrowIdParam == null) {
        out.println("<p style='color:red;'>Error: borrowId is null</p>");
        return;
    }
    
    int borrowId = Integer.parseInt(borrowIdParam);
    BorrowDAO borrowDAO = new BorrowDAO();
    Borrow borrow = borrowDAO.getBorrowById(borrowId);

    if (borrow == null) {
        out.println("<p style='color:red;'>Error: Cannot find borrow record in DB</p>");
        return;
    }

    long daysLate = borrowDAO.calculateLateDays(borrow);
    double penaltyFee = daysLate * 5000;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                max-width: 600px;
                margin-top: 50px;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .btn-pay {
                width: 100%;
                font-size: 18px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center mb-4">Payment Details</h2>

            <div class="mb-3">
                <strong>Borrow ID:</strong> <%= borrowId %>
            </div>
            <div class="mb-3">
                <strong>User:</strong> <%= borrow.getNameUser() %>
            </div>
            <div class="mb-3">
                <strong>Book:</strong> <%= borrow.getNameBook() %>
            </div>
            <div class="mb-3">
                <strong>Days Late:</strong> <%= daysLate %>
            </div>
            <div class="mb-3">
                <strong>Penalty Fee:</strong> <span class="text-danger"><%= penaltyFee %> VND</span>
            </div>

            <form action="processPayment" method="POST" id="paymentForm">
                <input type="hidden" name="borrowId" value="<%= borrowId %>">
                <input type="hidden" name="amount" value="<%= penaltyFee %>">
                <input type="hidden" name="userId" value="<%= borrow.getUserId() %>">

                <label for="paymentMethod">Choose Payment Method:</label>
                <select name="paymentMethod" class="form-control">
                    <option value="cash">Cash</option>
                    <option value="credit_card">Credit Card</option>
                    <option value="paypal">PayPal</option>
                </select>

                <button type="submit" class="btn btn-success btn-lg btn-block" id="confirmPaymentBtn">Confirm Payment</button>
            </form>

            <script>
                document.getElementById("paymentForm").onsubmit = function (event) {
                    event.preventDefault();
                    fetch("processPayment", {
                        method: "POST",
                        body: new FormData(this)
                    }).then(response => {
                        alert("Thanh toán thành công!");
                        window.location.href = "home.jsp"; // Chuyển hướng về trang home
                    }).catch(error => {
                        alert("Lỗi trong quá trình thanh toán!");
                    });
                };
            </script>


        </div>
    </body>
</html>

