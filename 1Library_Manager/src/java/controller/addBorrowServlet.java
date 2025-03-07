/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BooksDAO;
import dal.UsersDAO;
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
@WebServlet(name = "addBorrowServlet", urlPatterns = {"/addborrow"})
public class addBorrowServlet extends HttpServlet {

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
            out.println("<title>Servlet addCategoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addCategoryServlet at " + request.getContextPath() + "</h1>");
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
        String nameUser = request.getParameter("nameUser");
        String nameBook = request.getParameter("nameBook");
        String borrowDateStr = request.getParameter("borrowDate");
        String dueDateStr = request.getParameter("dueDate");
        String status = request.getParameter("status");

        BorrowDAO borrowDAO = new BorrowDAO();
        UsersDAO userDAO = new UsersDAO();
        BooksDAO bookDAO = new BooksDAO();

        try {
            if (!userDAO.isNameExist(nameUser)) {
                request.setAttribute("error", "User '" + nameUser + "' does not exist.");
                request.getRequestDispatcher("bcrud").forward(request, response);
                return;
            }

            if (!bookDAO.isBookExist(nameBook)) {
                request.setAttribute("error", "Book '" + nameBook + "' does not exist.");
                request.getRequestDispatcher("bcrud").forward(request, response);
                return;
            }

            if (borrowDateStr == null || borrowDateStr.isEmpty()) {
                request.setAttribute("error", "Borrow date cannot be empty.");
                request.getRequestDispatcher("bcrud").forward(request, response);
                return;
            }

            if (dueDateStr == null || dueDateStr.isEmpty()) {
                request.setAttribute("error", "Due date cannot be empty.");
                request.getRequestDispatcher("bcrud").forward(request, response);
                return;
            }
            
            int bookId = bookDAO.getBookIdByTitle(nameBook);

            Date borrowDate = Date.valueOf(borrowDateStr);
            Date dueDate = Date.valueOf(dueDateStr);

            Borrow newBorrow = new Borrow(userDAO.getUserIdByName(nameUser),
                    bookDAO.getBookIdByTitle(nameBook),
                    borrowDate,
                    dueDate,
                    null,
                    status);

            borrowDAO.insert(newBorrow);
            bookDAO.updateQuantity(bookId, -1);
            response.sendRedirect("bcrud");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("bcrud").forward(request, response);
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
