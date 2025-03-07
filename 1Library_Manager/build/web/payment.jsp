<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        <meta charset="UTF-8">
        <title>Payment Invoice</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .invoice-container {
                max-width: 600px;
                margin: auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 10px;
                background: #f9f9f9;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .invoice-header {
                text-align: center;
                margin-bottom: 20px;
                font-weight: bold;
            }
            .invoice-item {
                background: #fff;
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 10px;
            }
            .invoice-item label {
                font-weight: bold;
            }
        </style>
    </head>
    <body class="container mt-5">
        <div class="invoice-container">
            <h2 class="invoice-header">Payment Invoice</h2>
            <c:if test="${not empty payment}">
                <c:forEach var="p" items="${payment}">
                    <div class="invoice-item">
                        <p><label>Payment ID:</label> ${p.paymentId}</p>
                        <p><label>User Name:</label> ${p.userName}</p>
                        <p><label>Book Title:</label> ${p.bookTitle}</p>
                        <p><label>Amount:</label> ${p.amount}</p>
                        <p><label>Payment Date:</label> ${p.paymentDate}</p>
                        <p><label>Payment Method:</label> ${p.paymentMethod}</p>
                        <p><label>Status:</label>
                            <span class="badge ${p.status ? 'bg-success' : 'bg-warning'}">
                                ${p.status ? "Paid" : "Pending"}
                            </span>
                        </p>
                        <c:if test="${!p.status}">
                            <form action="processPayment" method="POST">
                                <input type="hidden" name="paymentId" value="${p.paymentId}">
                                <button type="submit" class="btn btn-primary">Pay Now</button>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty payment}">
                <p class="text-center text-muted">No payment records found.</p>
            </c:if>
            <c:if test="${not empty error}">
                <p class="text-center text-danger">${error}</p>
            </c:if>
        </div>
    </body>
</html>
