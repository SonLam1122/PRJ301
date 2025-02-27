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
import java.util.List;
import model.Users;
import dal.UsersDAO;
/**
 *
 * @author MSI
 */
public class usersCRUDServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        UsersDAO ad = new UsersDAO();
        
        List<Users> list = ad.getAllAccount();
        
        request.setAttribute("userlist", list);
        int n;
        if(list.size()>0){
            n=list.size();
        }else{
            n=0;
        }
        request.setAttribute("size", n);
        request.getRequestDispatcher("accountcrud.jsp").forward(request, response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     
    }

  public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
