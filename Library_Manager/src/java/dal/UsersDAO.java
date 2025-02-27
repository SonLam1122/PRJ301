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

/**
 *
 * @author MSI
 */
public class UsersDAO extends DBContext{
    public void resgister(Users a) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([full_name]\n"
                + "           ,[username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[role])\n"
                + "     VALUES(?,?,?,?,?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getName());
            st.setString(2, a.getUsername());
            st.setString(3, a.getPassword());
            st.setString(4, a.getEmail());
            st.setString(4, a.getRole());
          
           
        

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //check úsertontai
    public boolean ExitsedUser_check(String username) {
        String sql = "SELECT [user_id]\n"
                + "      ,[full_name]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[role]\n"
                + "      ,[email]\n"
                + "  FROM [dbo].[Users]\n"
                + "  where username=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (SQLException e) {
        }
        return false;
    }

    public List<Users> getAllAccount() {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT [user_id]\n"
                + "      ,[full_name]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[role]\n"
                + "      ,[email]\n"
                + "  FROM [dbo].[Users]";
               

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                
                Users a = new Users(rs.getInt("id"), 
                        rs.getString("name"), 
                        rs.getString("username"), 
                        rs.getString("password"), 
                        rs.getString("email"), 
                        rs.getString("role"));
                list.add(a);
            }
        } catch (Exception e) {
        }

        return list;
    }

    public Users getAccountById(int id) {

        String sql = "SELECT [user_id]\n"
                + "      ,[full_name]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[role]\n"
                + "      ,[email]\n"
                + "  FROM [dbo].[Users]\n"
                + "  where user_id=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Users a = new Users(rs.getInt("id"), 
                        rs.getString("name"), 
                        rs.getString("username"), 
                        rs.getString("password"), 
                        rs.getString("email"), 
                        rs.getString("role"));
                return a;
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public void insert(Users c) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([full_name]\n"
                + "           ,[username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[role])\n"
                + "     VALUES(?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            //set cho 5 dau ?
             st.setString(1, c.getName());
            st.setString(2, c.getUsername());
            st.setString(3, c.getPassword());
            st.setString(4, c.getEmail());
            st.setString(4, c.getRole());
            st.executeUpdate();//khi insert,dele,upd deu dung lenh nay
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    //update a account
    public void update(Users a) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [full_name] = ?\n"
               
                + "      ,[username] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[email] = ?\n"
                
                + "      ,[role] = ?\n"
                + " WHERE user_id=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

             st.setString(1, a.getName());
            st.setString(2, a.getUsername());
            st.setString(3, a.getPassword());
            st.setString(4, a.getEmail());
            st.setString(4, a.getRole());
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    //xoa account
    public void delete(int id) {
        String sql = "Delete from Account where id=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Users check(String username, String password) {
        String sql = "SELECT [user_id]\n"
                + "      ,[full_name]\n"
                
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[email]\n"
                + "      ,[role]\n"
                + "  FROM [dbo].[Users]\n"
                + "  where username=? and password=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Users a = new Users(rs.getInt("id"), 
                        rs.getString("name"), 
                        rs.getString("username"), 
                        rs.getString("password"), 
                        rs.getString("email"), 
                        rs.getString("role"));

                return a;
            }

        } catch (SQLException e) {
        }
        return null;
    }

    public void change(Users a) {
        String sql = "update account set password=? where username=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getPassword());
            st.setString(2, a.getUsername());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        int id = 1;
        UsersDAO ad = new UsersDAO();
        Users a = ad.getAccountById(id);

        System.out.println(a.getName());
    }
}
