/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.UsersDAO;
import model.Users;
/**
 *
 * @author MSI
 */
public class loginServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
      String user=request.getParameter("user");
        String pass=request.getParameter("pass");
        String remember=request.getParameter("rem");
        UsersDAO ad = new UsersDAO();
        Cookie cu= new Cookie("cuser", user);
        Cookie cp= new Cookie("cpass", pass);
        Cookie cr= new Cookie("crem", remember);
        
        if(remember!=null){
            cu.setMaxAge(60*60*24*7);
            cp.setMaxAge(60*60*24*7);
            cr.setMaxAge(60*60*24*7);
        }else{
            cu.setMaxAge(0);
            cp.setMaxAge(0);
            cr.setMaxAge(0);
        }
        response.addCookie(cu);
        response.addCookie(cp);
        response.addCookie(cr);               
        Users a = ad.check(user, pass);
        HttpSession session=request.getSession();
        if(a==null){
            request.setAttribute("error", "Username or Password in valid!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else{
            session.setAttribute("account", a);
            if(a.getRole()== "admin"){
                //day la admin
                request.getRequestDispatcher("crud.jsp").forward(request, response);
            }else{
                response.sendRedirect("home.jsp");
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    }



