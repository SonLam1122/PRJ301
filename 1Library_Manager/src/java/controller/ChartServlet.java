/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ChartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ChartItem;

/**
 *
 * @author MSI
 */
@WebServlet(name = "ChartServlet", urlPatterns = {"/crud"})
public class ChartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dateRange = request.getParameter("dateRange");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        ChartDAO d = new ChartDAO();

        List<ChartItem> ci = null;

        // Check the selected date range and call the appropriate method in ChartDAO
        if ("yesterday".equals(dateRange)) {
            ci = d.getBorrowQuantity("yesterday", "", "");
        } else if ("last7days".equals(dateRange)) {
            ci = d.getBorrowQuantity("last7days", "", "");
        } else if ("last30days".equals(dateRange)) {
            ci = d.getBorrowQuantity("last30days", "", "");
        } else if ("custom".equals(dateRange) && startDate != null && endDate != null) {
            ci = d.getBorrowQuantity("custom", startDate, endDate);
        }

        int totalnumberbook = d.getTotalBooksBorrowed();
        int totalPeople = d.getTotalPeopleWhoBorrowed();
        int totalUsers = d.getTotalUsers();
        double totalFines = d.getTotalFinesCollected();

        request.setAttribute("dataChart1", ci);
        request.setAttribute("totalnumberbook", totalnumberbook);
        request.setAttribute("totalPeople", totalPeople);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalFines", totalFines);

        request.getRequestDispatcher("crud.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
