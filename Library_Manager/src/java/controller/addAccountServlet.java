/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.UsersDAO;
import model.Users;
/**
 *
 * @author MSI
 */
public class addAccountServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String id_raw = request.getParameter("id");
        String name = request.getParameter("name");
        
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String email = request.getParameter("email");
        String role_raw = request.getParameter("role");
        
        int id;
       
        UsersDAO ad = new UsersDAO();
        Users user = new Users();
        try {
            id = Integer.parseInt(id_raw);
          
          Users a = ad.getAccountById(id);
           

            if (a == null) {
                Users a1 = new Users(id, name, username, password, name, name);
                ad.insert(a1);

                response.sendRedirect("acrud");
            } else {
                request.setAttribute("error","id "+ id + "of account exited");
                request.getRequestDispatcher("accountcrud.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
        }
    
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     
    }
 @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
