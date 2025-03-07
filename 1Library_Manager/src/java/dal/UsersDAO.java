package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Users;

public class UsersDAO extends DBContext {

    // Đăng ký tài khoản
    public void register(Users user) {
        String sql = "INSERT INTO Users (username, password, email, name, role) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getEmail());
            st.setString(4, user.getName());
            st.setString(5, user.getRole());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean isNameExist(String name) {
        String sql = "SELECT user_id FROM Users WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);  // Giả sử bạn muốn kiểm tra tên người dùng trong bảng Users
            ResultSet rs = st.executeQuery();
            return rs.next();  // Nếu có kết quả trả về thì tên tồn tại
        } catch (SQLException e) {
            System.out.println(e);  // In ra lỗi nếu có
        }
        return false;  // Nếu không tìm thấy tên người dùng
    }

    // Kiểm tra tài khoản tồn tại
    public boolean existedUserCheck(String username) {
        String sql = "SELECT user_id FROM Users WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    // Kiểm tra mail tồn tại
    public boolean existedEmailCheck(String email) {
        String sql = "SELECT user_id FROM Users WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    // Lấy danh sách tất cả tài khoản
    public List<Users> getAllAccount() {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Users user = new Users(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role")
                );
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    // Lấy tài khoản theo ID
    public Users getAccountById(int id) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Users(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // Chèn tài khoản mới
    public void insert(Users user) {
        register(user);
    }

    // Cập nhật tài khoản
    public void update(Users user) {
        String sql = "UPDATE Users SET name = ?, username = ?, password = ?, email = ?, role = ? WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getName());
            st.setString(2, user.getUsername());
            st.setString(3, user.getPassword());
            st.setString(4, user.getEmail());
            st.setString(5, user.getRole());
            st.setInt(6, user.getUserId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Xóa tài khoản
    public void delete(int id) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Kiểm tra đăng nhập
    public Users check(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Users(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // Đổi mật khẩu
    public void change(Users user) {
        String sql = "UPDATE Users SET password = ? WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getPassword());
            st.setString(2, user.getUsername());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public int getUserIdByName(String nameUser) {
        String sql = "SELECT user_id FROM Users WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, nameUser);  // Thiết lập tên người dùng vào câu truy vấn

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");  // Trả về user_id nếu tìm thấy
            }
        } catch (SQLException e) {
            System.out.println("Error in getUserIdByName: " + e.getMessage());
        }
        return -1;  
    }
}
