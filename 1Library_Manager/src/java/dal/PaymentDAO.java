package dal;

import model.Payment;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

public class PaymentDAO extends DBContext {

    public List<Payment> getPaymentsByBorrowId(int borrowId) {
        String sql = """
            SELECT 
                p.payment_id, 
                u.name AS user_name, 
                b.title AS book_title, 
                p.amount, 
                p.payment_date, 
                p.payment_method, 
                p.status 
            FROM Payments p
            JOIN Fines f ON p.fine_id = f.fine_id
            JOIN Users u ON p.user_id = u.user_id
            JOIN Borrow br ON f.borrow_id = br.borrow_id
            JOIN Books b ON br.book_id = b.book_id
            WHERE f.borrow_id = ?
        """;

        List<Payment> payments = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, borrowId);

            try (var rs = stmt.executeQuery()) {
                while (rs.next()) {
                    payments.add(new Payment(
                            rs.getInt("payment_id"),
                            rs.getString("user_name"),
                            rs.getString("book_title"),
                            rs.getDouble("amount"),
                            rs.getDate("payment_date"),
                            rs.getString("payment_method"),
                            rs.getBoolean("status")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public boolean processPayment(int paymentId) {
        String updatePaymentSQL = "UPDATE Payments SET status = 1 WHERE payment_id = ?";
        String updateBorrowSQL = """
        UPDATE Borrow 
        SET status = 'returned', return_date = ? 
        WHERE borrow_id = (SELECT f.borrow_id FROM Fines f 
                           JOIN Payments p ON f.fine_id = p.fine_id 
                           WHERE p.payment_id = ?)
    """;
        String updateBookQuantitySQL = """
        UPDATE Books 
        SET quantity = quantity + 1, updated_at = GETDATE() 
        WHERE book_id = (SELECT b.book_id FROM Borrow b 
                         JOIN Fines f ON b.borrow_id = f.borrow_id 
                         JOIN Payments p ON f.fine_id = p.fine_id 
                         WHERE p.payment_id = ?)
    """;

        try {
            connection.setAutoCommit(false);

            try (PreparedStatement stmt1 = connection.prepareStatement(updatePaymentSQL)) {
                stmt1.setInt(1, paymentId);
                stmt1.executeUpdate();
            }

            try (PreparedStatement stmt2 = connection.prepareStatement(updateBorrowSQL)) {
                stmt2.setDate(1, Date.valueOf(LocalDate.now()));
                stmt2.setInt(2, paymentId);
                stmt2.executeUpdate();
            }

            try (PreparedStatement stmt3 = connection.prepareStatement(updateBookQuantitySQL)) {
                stmt3.setInt(1, paymentId);
                stmt3.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }
}
