/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.sun.jdi.connect.spi.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.ChartItem;

/**
 *
 * @author MSI
 */
public class ChartDAO extends DBContext {

    public List<ChartItem> getBorrowQuantity(String dateRange, String startDate, String endDate) {
        List<ChartItem> chart = new ArrayList<>();

        // Determine which method to call based on the date range selection
        if (dateRange.equals("yesterday")) {
            chart = getBorrowedReturnedForYesterday();
        } else if (dateRange.equals("last7days")) {
            chart = getBorrowedReturnedForLast7Days();
        } else if (dateRange.equals("last30days")) {
            chart = getBorrowedReturnedForLast30Days();
        } else if (dateRange.equals("custom")) {
            chart = getBorrowedReturnedForCustomRange(startDate, endDate);
        }

        return chart;
    }

    // Get borrowed and returned data for yesterday
    private List<ChartItem> getBorrowedReturnedForYesterday() {
        List<ChartItem> chart = new ArrayList<>();
        String sql = "SELECT CONVERT(DATE, borrow_date) AS date, "
                + "SUM(CASE WHEN status = 'borrowed' THEN 1 ELSE 0 END) AS borrowedCount, "
                + "SUM(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) AS returnedCount "
                + "FROM Borrow "
                + "WHERE borrow_date = CONVERT(DATE, GETDATE() - 1) "
                + "GROUP BY CONVERT(DATE, borrow_date) "
                + "ORDER BY date";

        executeQuery(chart, sql);

        return chart;
    }

    // Get borrowed and returned data for the last 7 days
    private List<ChartItem> getBorrowedReturnedForLast7Days() {
        List<ChartItem> chart = new ArrayList<>();
        String sql = "SELECT CONVERT(DATE, borrow_date) AS date, "
                + "SUM(CASE WHEN status = 'borrowed' THEN 1 ELSE 0 END) AS borrowedCount, "
                + "SUM(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) AS returnedCount "
                + "FROM Borrow "
                + "WHERE borrow_date BETWEEN DATEADD(DAY, -7, GETDATE()) AND GETDATE() "
                + "GROUP BY CONVERT(DATE, borrow_date) "
                + "ORDER BY date";

        executeQuery(chart, sql);

        return chart;
    }

    // Get borrowed and returned data for the last 30 days
    private List<ChartItem> getBorrowedReturnedForLast30Days() {
        List<ChartItem> chart = new ArrayList<>();
        String sql = "SELECT CONVERT(DATE, borrow_date) AS date, "
                + "SUM(CASE WHEN status = 'borrowed' THEN 1 ELSE 0 END) AS borrowedCount, "
                + "SUM(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) AS returnedCount "
                + "FROM Borrow "
                + "WHERE borrow_date BETWEEN DATEADD(DAY, -30, GETDATE()) AND GETDATE() "
                + "GROUP BY CONVERT(DATE, borrow_date) "
                + "ORDER BY date";

        executeQuery(chart, sql);

        return chart;
    }

    // Get borrowed and returned data for a custom date range
    private List<ChartItem> getBorrowedReturnedForCustomRange(String startDate, String endDate) {
        List<ChartItem> chart = new ArrayList<>();
        String sql = "SELECT CONVERT(DATE, borrow_date) AS date, "
                + "SUM(CASE WHEN status = 'borrowed' THEN 1 ELSE 0 END) AS borrowedCount, "
                + "SUM(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) AS returnedCount "
                + "FROM Borrow "
                + "WHERE borrow_date BETWEEN ? AND ? "
                + "GROUP BY CONVERT(DATE, borrow_date) "
                + "ORDER BY date";

        executeQuery(chart, sql, startDate, endDate);

        return chart;
    }

    // Helper method to execute the SQL query
    private void executeQuery(List<ChartItem> chart, String sql, String... params) {
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Set parameters for custom date range
            if (params.length > 0) {
                stmt.setString(1, params[0]);
                stmt.setString(2, params[1]);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Date date = rs.getDate("date");
                    int borrowedCount = rs.getInt("borrowedCount");
                    int returnedCount = rs.getInt("returnedCount");

                    ChartItem newChart = new ChartItem(date, borrowedCount, returnedCount);
                    chart.add(newChart);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in executeQuery: " + e.getMessage());
        }
    }

    // Main method for testing
    public int getTotalBooksBorrowed() {
        String sql = "SELECT SUM(CASE WHEN status = 'borrowed' THEN 1 ELSE 0 END) AS totalBooksBorrowed "
                + "FROM Borrow";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalBooksBorrowed");
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalBooksBorrowed: " + e.getMessage());
        }
        return 0;
    }

    public int getTotalPeopleWhoBorrowed() {
        String sql = "SELECT COUNT(DISTINCT user_id) AS totalPeople FROM Borrow WHERE status = 'borrowed'";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                int total = rs.getInt("totalPeople");
                System.out.println("Total people borrowed: " + total);
                return total;
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalPeopleWhoBorrowed: " + e.getMessage());
        }
        return 0;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(user_id) AS totalUsers FROM Users";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalUsers");
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalUsers: " + e.getMessage());
        }
        return 0;
    }

    public double getTotalFinesCollected() {
        String sql = "SELECT SUM(amount) AS totalFines FROM Payments";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("totalFines");
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalFinesCollected: " + e.getMessage());
        }
        return 0.0;
    }

    public static void main(String[] args) {
        ChartDAO d = new ChartDAO();
        List<ChartItem> result = d.getBorrowQuantity("last30days", "", "");
        System.out.println(result);
    }
}
