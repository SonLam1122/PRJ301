/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BooksDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Books;

/**
 *
 * @author BUI TUAN DAT
 */
@WebServlet(name = "detailBookServlet", urlPatterns = {"/detailbook"})
public class detailBookServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdStr = request.getParameter("id");

        try {
            int bookId = Integer.parseInt(bookIdStr);
            BooksDAO booksDAO = new BooksDAO();

            Books book = booksDAO.getBookById(bookId);

            if (book != null) {
                String category = booksDAO.getCategoryByBookId(bookId);

                List<Books> sameCategoryBooks = booksDAO.getTop5BooksByCategoryExcludingId(category, bookId);
                book.setRelatedBooks(sameCategoryBooks); 
            }

            request.setAttribute("book", book);

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("detailbook.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
