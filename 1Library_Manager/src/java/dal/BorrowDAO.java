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
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import model.Books;

/**
 *
 * @author BUI TUAN DAT
 */
public class BorrowDAO extends DBContext {

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
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, c.getUserId());
            st.setInt(2, c.getBookId());

            st.setDate(3, c.getBorrowDate() != null ? new java.sql.Date(c.getBorrowDate().getTime()) : null);
            st.setDate(4, c.getDueDate() != null ? new java.sql.Date(c.getDueDate().getTime()) : null);
            st.setDate(5, c.getReturnDate() != null ? new java.sql.Date(c.getReturnDate().getTime()) : null);

            st.setString(6, c.getStatus()); // 'borrowed', 'returned', 'late'

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Borrow borrow) {
        // Cập nhật câu lệnh SQL không bao gồm trường updated_at
        String sql = "UPDATE [dbo].[Borrow] "
                + "SET [borrow_date] = ?, [due_date] = ?, [return_date] = ?, "
                + "[status] = ? "
                + "WHERE [borrow_id] = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Set giá trị cho các tham số trong câu lệnh SQL
            st.setDate(1, borrow.getBorrowDate());  // Cập nhật ngày mượn
            st.setDate(2, borrow.getDueDate());     // Cập nhật ngày đến hạn
            st.setDate(3, borrow.getReturnDate() != null ? borrow.getReturnDate() : null);  // Nếu có ngày trả, cập nhật; nếu không thì gán null
            st.setString(4, borrow.getStatus());    // Cập nhật trạng thái
            st.setInt(5, borrow.getBorrowId());     // Cập nhật theo borrowId

            // Thực thi câu lệnh SQL
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
    String sql = "SELECT b.borrow_id, b.user_id, b.book_id, b.borrow_date, b.due_date, "
               + "b.return_date, b.status, u.name AS nameUser, bk.title AS nameBook "
               + "FROM Borrow b "
               + "JOIN Users u ON b.user_id = u.user_id "
               + "JOIN Books bk ON b.book_id = bk.book_id "
               + "WHERE b.borrow_id = ?";

    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, borrowId);
        try (ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return new Borrow(
                    rs.getInt("borrow_id"),
                    rs.getInt("user_id"),
                    rs.getInt("book_id"),
                    rs.getDate("borrow_date"),
                    rs.getDate("due_date"),
                    rs.getDate("return_date"),
                    rs.getString("status"),
                    rs.getString("nameUser"),
                    rs.getString("nameBook")
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
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
    


public long calculateLateDays(Borrow borrow) {
    if (borrow.getReturnDate() == null) {
        LocalDate today = LocalDate.now();
        LocalDate dueDate = borrow.getDueDate().toLocalDate(); // Chuyển từ java.sql.Date sang java.time.LocalDate

        if (today.isAfter(dueDate)) {
            return ChronoUnit.DAYS.between(dueDate, today);
        }
    }
    return 0;
}

public boolean updatePaymentStatus(int borrowId) {
    String sql = "UPDATE Borrow SET status = 'paid' WHERE borrow_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, borrowId);
        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}





}
