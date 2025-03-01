/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

/**
 *
 * @author BUI TUAN DAT
 */
@WebServlet(name = "addUsersServlet", urlPatterns = {"/add"})
public class addUsersServlet extends HttpServlet {

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
            out.println("<title>Servlet addAccoumtServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addAccoumtServlet at " + request.getContextPath() + "</h1>");
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
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        UsersDAO userDao = new UsersDAO();
        String role = "user"; // Mặc định vai trò là "user"

        try {
            // Kiểm tra tài khoản hoặc email đã tồn tại chưa
            boolean isUsernameExisted = userDao.existedUserCheck(username);
            boolean isEmailExisted = userDao.existedEmailCheck(email);

            if (isUsernameExisted || isEmailExisted) {
                request.setAttribute("error", "Tên đăng nhập hoặc email đã tồn tại!");
                request.getRequestDispatcher("acrud").forward(request, response);
            } else {
                // Đăng ký tài khoản mới
                Users newUser = new Users(name, username, password, email, role);
                userDao.register(newUser);

                // Chuyển hướng về trang đăng nhập sau khi đăng ký thành công
                request.getRequestDispatcher("acrud").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi để debug
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại!");
            request.getRequestDispatcher("acrud").forward(request, response);
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
