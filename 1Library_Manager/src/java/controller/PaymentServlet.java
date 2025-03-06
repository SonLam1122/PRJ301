/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PaymentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Payment;

/**
 *
 * @author ASUS VIVOBOOK
 */
public class PaymentServlet extends HttpServlet {

    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String borrowIdParam = request.getParameter("id");
        if (borrowIdParam != null && !borrowIdParam.isEmpty()) {
            try {
                int borrowId = Integer.parseInt(borrowIdParam);
                List<Payment> payment = paymentDAO.getPaymentsByBorrowId(borrowId);
                request.setAttribute("payment", payment);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid borrow ID format.");
            }
        } else {
            request.setAttribute("error", "Borrow ID is required.");
        }
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

}
