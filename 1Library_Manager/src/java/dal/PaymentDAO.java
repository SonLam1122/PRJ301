package dal;

import model.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PaymentDAO extends DBContext {
   public boolean insertPayment(Payment payment) {
    String sql = "INSERT INTO Payments (user_id, fine_id, amount, payment_date, payment_method, status) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, payment.getUserId());
        ps.setInt(2, payment.getFineId());
        ps.setDouble(3, payment.getAmount());
        ps.setDate(4, java.sql.Date.valueOf(payment.getPaymentDate()));
        ps.setString(5, payment.getPaymentMethod());
        ps.setInt(6, 1); // 1 = đã thanh toán
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


}
