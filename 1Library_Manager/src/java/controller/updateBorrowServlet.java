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
import java.sql.Date;
import model.Borrow;

/**
 *
 * @author BUI TUAN DAT
 */
@WebServlet(name = "updateBorrowServlet", urlPatterns = {"/updateborrow"})
public class updateBorrowServlet extends HttpServlet {

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
            out.println("<title>Servlet updateCategoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateCategoryServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");

        BorrowDAO cd = new BorrowDAO();
        try {
            int id = Integer.parseInt(id_raw);
            Borrow c = cd.getBorrowById(id);

            request.setAttribute("cupdate", c);

            request.getRequestDispatcher("updateborrow.jsp").forward(request, response);
        } catch (NumberFormatException e) {
        }

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
        String id_raw = request.getParameter("id");
        String borrowDateStr = request.getParameter("borrowdate");
        String dueDateStr = request.getParameter("duedate");
        String returnDateStr = request.getParameter("returndate");
        String status = request.getParameter("status");

        int id;
        Date borrowDate = null, dueDate = null, returnDate = null;
        BorrowDAO borrowDAO = new BorrowDAO();
        BooksDAO bookDAO = new BooksDAO();

        try {
            id = Integer.parseInt(id_raw);
            borrowDate = Date.valueOf(borrowDateStr);
            dueDate = Date.valueOf(dueDateStr);
            returnDate = (returnDateStr != null && !returnDateStr.isEmpty()) ? Date.valueOf(returnDateStr) : null;

            Borrow borrow = borrowDAO.getBorrowById(id);
            if (borrow != null) {
                int bookId = borrow.getBookId();

                if ("returned".equals(status)) {
                    bookDAO.updateQuantity(bookId, 1);
                } else if ("borrowed".equals(status)) {
                    bookDAO.updateQuantity(bookId, -1);
                } else if ("late".equals(status)) {
                    bookDAO.updateQuantity(bookId, -1);
                }
            }
            // Cập nhật bản ghi mượn trả
            Borrow updatedBorrow = new Borrow(id, borrowDate, dueDate, returnDate, status);
            borrowDAO.update(updatedBorrow);

            response.sendRedirect("bcrud");
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

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
