/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BooksDAO;
import dal.BorrowDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.sql.Date;
import model.Borrow;

/**
 *
 * @author SonLam29
 */
@WebServlet(name = "ReturnBookServlet", urlPatterns = {"/return"})
public class ReturnBookServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReturnBookServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReturnBookServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String borrowIdRaw = request.getParameter("id");
        if (borrowIdRaw == null || borrowIdRaw.isEmpty()) {
            response.sendRedirect("bcrud"); // Chuyển hướng nếu không có ID
            return;
        }

        int borrowId;
        try {
            borrowId = Integer.parseInt(borrowIdRaw);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("bcrud");
            return;
        }

        BorrowDAO borrowDAO = new BorrowDAO();
        BooksDAO booksDAO = new BooksDAO();

        try {
            Borrow borrow = borrowDAO.getBorrowById(borrowId);
            if (borrow != null) {
                int bookId = borrow.getBookId();
                LocalDate today = LocalDate.now();

                // Cập nhật bảng Borrow
                borrowDAO.updateReturnStatus(borrowId, Date.valueOf(today));

                // Cập nhật số lượng sách
                booksDAO.updateQuantity(bookId, 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("bcrud");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
