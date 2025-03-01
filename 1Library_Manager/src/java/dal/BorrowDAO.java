/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Users;
import model.Borrow;
import java.sql.Timestamp;


/**
 *
 * @author BUI TUAN DAT
 */
public class BorrowDAO extends DBContext {

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

    public List<Borrow> getAllBorrowsWithUserNames() {
        List<Borrow> borrowList = new ArrayList<>();
        String sql = "SELECT b.borrowId, b.bookId, b.userId, u.name AS userName "
                + "FROM Borrow b JOIN User u ON b.userId = u.userId";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Borrow borrow = new Borrow();
                borrow.setBorrowId(rs.getInt("borrowId"));
                borrow.setBookId(rs.getInt("bookId"));
                borrow.setUserId(rs.getInt("userId"));
                borrow.setNameUser(rs.getString("userName"));  // Lấy tên người dùng từ User

                borrowList.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return borrowList;
    }
}
