/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UsersDAO;
import dal.BooksDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Users;
import model.Books;

@WebServlet(name = "libraryCRUDServlet", urlPatterns = {"/lcrud"})
public class libraryCRUDServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet productCRUDServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet productCRUDServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        ProductDAO pd = new ProductDAO();
//
//        List<Product> list = pd.getAllProduct();
//
//        request.setAttribute("productlist", list);
//        int n;
//        if (list.size() > 0) {
//            n = list.size();
//        } else {
//            n = 0;
//        }
//        request.setAttribute("size", n);
//        request.getRequestDispatcher("productcrud.jsp").forward(request, response);
//    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BooksDAO pd = new BooksDAO();

        List<Books> list1 = pd.getAllBooks();

        request.setAttribute("bookslist", list1);
        int n;
        if (list1.size() > 0) {
            n = list1.size();
        } else {
            n = 0;
        }
        request.setAttribute("size", n);
        // Số sản phẩm trên mỗi trang
        int productsPerPage = 5;

        // Tính tổng số sản phẩm
        int totalProducts = pd.getTotalProducts();

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        // Truyền số trang hiện tại từ yêu cầu HTTP
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            currentPage = Integer.parseInt(pageParam);
        }

        // Tính chỉ mục sản phẩm bắt đầu và kết thúc cho trang hiện tại
        int startIndex = (currentPage - 1) * productsPerPage;
        int endIndex = Math.min(startIndex + productsPerPage, totalProducts);

        // Lấy danh sách sản phẩm cho trang hiện tại
        List<Books> list = pd.getBooksPerPage(startIndex, productsPerPage);

        request.setAttribute("productlist", list);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);

        request.getRequestDispatcher("bookscrud.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
