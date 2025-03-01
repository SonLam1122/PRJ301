/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BooksDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Books;
import java.sql.Date;

/**
 *
 * @author BUI TUAN DAT
 */
@WebServlet(name = "addBookServlet", urlPatterns = {"/addbook"})
public class addBookServlet extends HttpServlet {

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
            out.println("<title>Servlet addProductCRUD</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addProductCRUD at " + request.getContextPath() + "</h1>");
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
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        String quantity_raw = request.getParameter("quantity");
        String createdAt_raw = request.getParameter("createdAt");
        String updatedAt_raw = request.getParameter("updatedAt");

        int quantity;
        Date createdAt = null;
        Date updatedAt = null;

        try {
            // Parse các tham số đầu vào (không có id vì id sẽ tự động tăng)
            quantity = Integer.parseInt(quantity_raw);
            createdAt = Date.valueOf(createdAt_raw);
            updatedAt = Date.valueOf(updatedAt_raw);

            // Tạo đối tượng sách mới mà không cần id
            BooksDAO pd = new BooksDAO();

            // Tạo đối tượng Books mới mà không truyền id (id sẽ tự động tăng)
            Books newBook = new Books(title, author, publisher, category, description, image, quantity, createdAt, updatedAt);

            // Thêm sách vào cơ sở dữ liệu
            pd.insert(newBook);

            // Chuyển hướng đến trang quản lý sách sau khi thêm thành công
            response.sendRedirect("lcrud");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // Xử lý lỗi khi số liệu không hợp lệ
            request.setAttribute("error", "Dữ liệu nhập vào không hợp lệ");
            request.getRequestDispatcher("bookscrud.jsp").forward(request, response);
        }

    }

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
