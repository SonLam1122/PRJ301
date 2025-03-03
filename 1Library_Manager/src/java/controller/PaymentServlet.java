/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BorrowDAO;
import dal.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import model.Borrow;
import model.Payment;

/**
 *
 * @author ASUS VIVOBOOK
 */

public class PaymentServlet extends HttpServlet {
    

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng sang trang payment.jsp
        String borrowId = request.getParameter("id");
        if (borrowId == null) {
            response.sendRedirect("home.jsp");
            return;
        }
        request.setAttribute("borrowId", borrowId);
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if (userRole == null || !userRole.equals("admin")) {
            response.sendRedirect("home.jsp"); 
            return;
        }

        int borrowId = Integer.parseInt(request.getParameter("borrowId"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        String paymentMethod = request.getParameter("paymentMethod");
        int userId = Integer.parseInt(request.getParameter("userId"));

        BorrowDAO borrowDAO = new BorrowDAO();
        PaymentDAO paymentDAO = new PaymentDAO();

        Payment payment = new Payment(userId, borrowId, amount, LocalDate.now(), paymentMethod, 1);
        boolean paymentSuccess = paymentDAO.insertPayment(payment);

        if (paymentSuccess) {
            boolean updateSuccess = borrowDAO.updatePaymentStatus(borrowId);
            if (updateSuccess) {
                response.sendRedirect("home.jsp");

            } else {
                response.sendRedirect("home.jsp?message=update_failed");
            }
        } else {
            response.sendRedirect("home.jsp?message=payment_failed");
        }
    }}

