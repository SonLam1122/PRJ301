/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Borrow;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author BUI TUAN DAT
 */
public class BorrowDAO extends DBContext {

    public void updateReturnStatus(int borrowId, Date returnDate) {
        String sql = "UPDATE Borrow SET return_date = ?, status = 'returned' WHERE borrow_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, returnDate);
            ps.setInt(2, borrowId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void checkAndUpdateLateBorrows() {
        String deletePaymentsSql = "DELETE FROM Payments";
        String deleteFineSql = "DELETE FROM Fines";
        String updateLateStatusSql = "UPDATE Borrow SET status = 'late' WHERE due_date < GETDATE() AND status = 'borrowed'";
        String insertFineSql = "INSERT INTO Fines (borrow_id, user_id, amount, fine_reason, fine_date) "
                + "SELECT borrow_id, user_id, DATEDIFF(DAY, due_date, GETDATE()) * 5000, 'Late return', GETDATE() "
                + "FROM Borrow WHERE status = 'late'";

        String insertPaymentSql = "INSERT INTO Payments (user_id, fine_id, amount, payment_method, payment_date, status) "
                + "SELECT f.user_id, f.fine_id, f.amount, 'cash', GETDATE(), 0 FROM Fines f";

        try (
                PreparedStatement deletePaymentsStmt = connection.prepareStatement(deletePaymentsSql); PreparedStatement deleteFineStmt = connection.prepareStatement(deleteFineSql); PreparedStatement updateStatusStmt = connection.prepareStatement(updateLateStatusSql); PreparedStatement insertFineStmt = connection.prepareStatement(insertFineSql); PreparedStatement insertPaymentStmt = connection.prepareStatement(insertPaymentSql)) {

            int deletedPayments = deletePaymentsStmt.executeUpdate();
            int deletedFines = deleteFineStmt.executeUpdate();
            int updatedRows = updateStatusStmt.executeUpdate();
            int insertedFines = insertFineStmt.executeUpdate();
            int insertedPayments = insertPaymentStmt.executeUpdate();
            System.out.println("Deleted " + deletedPayments + " payments.");
            System.out.println("Deleted " + deletedFines + " fines.");
            System.out.println("Updated " + updatedRows + " borrow records to 'late' status.");
            System.out.println("Inserted " + insertedFines + " new fines.");
            System.out.println("Inserted " + insertedPayments + " new payment records.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean rentBook(int userId, int bookId, Date borrowDate, Date dueDate) {
        PreparedStatement pstmt = null;
        PreparedStatement updateStmt = null;

        try {
            connection.setAutoCommit(false);

            // Chèn vào bảng Borrow
            String insertSql = "INSERT INTO Borrow (user_id, book_id, borrow_date, due_date,return_date, status) VALUES (?, ?, ?, ?, NULL,  'borrowed')";
            pstmt = connection.prepareStatement(insertSql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookId);
            pstmt.setDate(3, borrowDate);
            pstmt.setDate(4, dueDate);
            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                // Giảm số lượng sách
                String updateSql = "UPDATE Books SET quantity = quantity - 1 WHERE book_id = ? AND quantity > 0";
                updateStmt = connection.prepareStatement(updateSql);
                updateStmt.setInt(1, bookId);

                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    connection.commit();
                    return true;
                } else {
                    connection.rollback();
                }
            } else {
                connection.rollback();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (updateStmt != null) {
                    updateStmt.close();
                }
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    public void insert(Borrow c) {
        String sql = "INSERT INTO Borrow (user_id, book_id, borrow_date, due_date, return_date, status) "
                + "VALUES (?, ?, ?, ?, NULL, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setInt(1, c.getUserId());
            st.setInt(2, c.getBookId());
            st.setDate(3, new java.sql.Date(c.getBorrowDate().getTime()));
            st.setDate(4, new java.sql.Date(c.getDueDate().getTime()));
            st.setString(5, c.getStatus());

            int rowsAffected = st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Borrow borrow) {
        String sql = "UPDATE [dbo].[Borrow] "
                + "SET [borrow_date] = ?, [due_date] = ?, [return_date] = ?, "
                + "[status] = ? "
                + "WHERE [borrow_id] = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setDate(1, borrow.getBorrowDate());
            st.setDate(2, borrow.getDueDate());
            st.setDate(3, borrow.getReturnDate() != null ? borrow.getReturnDate() : null);
            st.setString(4, borrow.getStatus());
            st.setInt(5, borrow.getBorrowId());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in update: " + e.getMessage());
        }
    }

//xoa Category
    public void delete(int id) {
        String sql = "Delete from Borrow where borrow_id=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Borrow> getAllBorrow() {
        List<Borrow> list = new ArrayList<>();
        String sql = "SELECT b.borrow_id, b.user_id, b.book_id, b.borrow_date, b.due_date, b.return_date, b.status, u.name AS nameUser, b1.title AS nameBook "
                + "FROM [dbo].[Borrow] b "
                + "JOIN [dbo].[Users] u ON b.user_id = u.user_id "
                + "JOIN [dbo].[Books] b1 ON b.book_id = b1.book_id";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowId(rs.getInt("borrow_id"));
                borrow.setUserId(rs.getInt("user_id"));
                borrow.setBookId(rs.getInt("book_id"));
                borrow.setBorrowDate(rs.getDate("borrow_date"));
                borrow.setDueDate(rs.getDate("due_date"));
                borrow.setReturnDate(rs.getDate("return_date"));
                borrow.setStatus(rs.getString("status"));
                borrow.setNameUser(rs.getString("nameUser"));
                borrow.setNameBook(rs.getString("nameBook"));

                list.add(borrow);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllBorrow: " + e.getMessage());
        }

        return list;
    }

    public Borrow getBorrowById(int borrowId) {
        String sql = "SELECT * FROM Borrow WHERE borrow_id = ?";

        // Sử dụng try-with-resources để tự động đóng resources
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, borrowId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Borrow borrow = new Borrow(
                            rs.getInt("borrow_id"),
                            rs.getInt("user_id"),
                            rs.getInt("book_id"),
                            rs.getDate("borrow_date"),
                            rs.getDate("due_date"),
                            rs.getDate("return_date"),
                            rs.getString("status")
                    );
                    return borrow;
                }
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public List<Borrow> getAllBorrowsByUsername(String username) {
        List<Borrow> borrowList = new ArrayList<>();
        String sql = "SELECT b.borrow_id, b.user_id, b.book_id, b.borrow_date, b.due_date, "
                + "b.return_date, b.status, u.name AS nameUser, b1.title AS nameBook "
                + "FROM Borrow b "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "JOIN Books b1 ON b.book_id = b1.book_id "
                + "WHERE u.username = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username); // Gán giá trị tham số username
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowId(rs.getInt("borrow_id"));
                borrow.setUserId(rs.getInt("user_id"));
                borrow.setBookId(rs.getInt("book_id"));
                borrow.setBorrowDate(rs.getDate("borrow_date"));
                borrow.setDueDate(rs.getDate("due_date"));
                borrow.setReturnDate(rs.getDate("return_date"));
                borrow.setStatus(rs.getString("status"));
                borrow.setNameUser(rs.getString("nameUser"));
                borrow.setNameBook(rs.getString("nameBook"));

                borrowList.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return borrowList;
    }

}
