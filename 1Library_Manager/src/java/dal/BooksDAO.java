/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.sun.jdi.connect.spi.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Books;
import java.sql.Timestamp;

/**
 *
 * @author BUI TUAN DAT
 */
public class BooksDAO extends DBContext {

    public Books getBookWithLowestQuantity() {
        Books book = null;
        String sql = "SELECT TOP 1 * FROM Books ORDER BY quantity ASC"; 

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            System.out.println("Error in getBookWithLowestQuantity: " + e.getMessage());
        }
        return book;
    }

    public List<Books> getBooksByCategory(String category) {
        List<Books> books = new ArrayList<>();
        String query = "SELECT TOP 8 * FROM Books WHERE category = ? ORDER BY updated_at DESC";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, category);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Books book = new Books();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setImage(rs.getString("image")); // Cột ảnh sách
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public void updateQuantity(int bookId, int amount) {
        String sql = "UPDATE Books SET quantity = quantity + ?, updated_at = GETDATE() WHERE book_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, amount);
            ps.setInt(2, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM Books WHERE category IS NOT NULL";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllCategories: " + e.getMessage());
        }
        return categories;
    }

    public List<Books> fourbooknew() {
        List<Books> books = new ArrayList<>();
        String sql = "SELECT TOP 4 * FROM Books ORDER BY created_at DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Books book = new Books(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("publisher"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Books> searchBooks(String keyword, String category) {
        List<Books> books = new ArrayList<>();
        String sql = "SELECT book_id, title, author, publisher, category, description, image, quantity "
                + "FROM Books WHERE (title LIKE ? or description LIKE ? )";

        if (category != null && !category.isEmpty()) {
            sql += " AND category = ?";
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");

            if (category != null && !category.isEmpty()) {
                stmt.setString(3, category);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Books book = new Books();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPublisher(rs.getString("publisher"));
                    book.setCategory(rs.getString("category"));
                    book.setDescription(rs.getString("description"));
                    book.setImage(rs.getString("image"));
                    book.setQuantity(rs.getInt("quantity"));

                    books.add(book);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in searchBooks: " + e.getMessage());
        }
        return books;
    }

    // lay sach theo the loai
    public List<Books> getBooksByCid(String category) {
        List<Books> list = new ArrayList<>();
        String sql = "SELECT [book_id], [title], [author], [publisher], [category], "
                + "[description], [image], [quantity], [created_at], [updated_at] "
                + "FROM [dbo].[Books] WHERE category = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(book);
            }
        } catch (SQLException e) {
            System.out.println("Error in getBooksByCid: " + e.getMessage());
        }

        return list;
    }

    public boolean isBookExist(String bookName) {
        String sql = "SELECT book_id FROM Books WHERE title = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, bookName);  // Kiểm tra tên sách trong bảng Books
            ResultSet rs = st.executeQuery();
            return rs.next();  // Nếu có kết quả trả về thì tên sách tồn tại
        } catch (SQLException e) {
            System.out.println(e);  // In ra lỗi nếu có
        }
        return false;  // Nếu không tìm thấy tên sách
    }

    // top 5 sach theo the loại
    public List<Books> getTop5BooksByCategory(String category) {
        List<Books> list = new ArrayList<>();
        String sql = "SELECT TOP (5) [book_id], [title], [author], [publisher], [category], "
                + "[description], [image], [quantity], [created_at], [updated_at] "
                + "FROM [dbo].[Books] "
                + "WHERE category = ? "
                + "ORDER BY book_id DESC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(book);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTop5BooksByCategory: " + e.getMessage());
        }

        return list;
    }

    // lay theo id
    public Books getBookById(int bookId) {
        String sql = "SELECT [book_id], [title], [author], [publisher], [category], "
                + "[description], [image], [quantity], [created_at], [updated_at] "
                + "FROM [dbo].[Books] WHERE book_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, bookId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));

                return book;
            }
        } catch (SQLException e) {
            System.out.println("Error in getBookById: " + e.getMessage());
        }

        return null;
    }

    // lay tat ca sach
    public List<Books> getAllBooks() {
        List<Books> list = new ArrayList<>();
        String sql = "SELECT [book_id], [title], [author], [publisher], [category], "
                + "[description], [image], [quantity], [created_at], [updated_at] "
                + "FROM [dbo].[Books]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(book);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllBooks: " + e.getMessage());
        }

        return list;
    }

    public Books getTop1Book() {
        String sql = "SELECT TOP (1) [book_id], [title], [author], [publisher], [category], "
                + "[description], [image], [quantity], [created_at], [updated_at] "
                + "FROM [dbo].[Books] "
                + "ORDER BY book_id DESC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));

                return book;
            }
        } catch (SQLException e) {
            System.out.println("Error in getTop1Book: " + e.getMessage());
        }

        return null;
    }

    public void insert(Books book) {
        String sql = "INSERT INTO [dbo].[Books] "
                + "([title], [author], [publisher], [category], [description], "
                + "[image], [quantity], [created_at], [updated_at]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, book.getTitle());
            st.setString(2, book.getAuthor());
            st.setString(3, book.getPublisher());
            st.setString(4, book.getCategory());
            st.setString(5, book.getDescription());
            st.setString(6, book.getImage());
            st.setInt(7, book.getQuantity());
            st.setTimestamp(8, new Timestamp(System.currentTimeMillis())); // created_at
            st.setTimestamp(9, new Timestamp(System.currentTimeMillis())); // updated_at

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in insert: " + e.getMessage());
        }
    }

    public void update(Books book) {
        String sql = "UPDATE [dbo].[Books] "
                + "SET [title] = ?, [author] = ?, [publisher] = ?, "
                + "[category] = ?, [description] = ?, [image] = ?, "
                + "[quantity] = ?, [updated_at] = ? "
                + "WHERE [book_id] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, book.getTitle());
            st.setString(2, book.getAuthor());
            st.setString(3, book.getPublisher());
            st.setString(4, book.getCategory());
            st.setString(5, book.getDescription());
            st.setString(6, book.getImage());
            st.setInt(7, book.getQuantity());
            st.setTimestamp(8, new Timestamp(System.currentTimeMillis())); // updated_at
            st.setInt(9, book.getBookId());

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in update: " + e.getMessage());
        }
    }

    //delete product
    public void delete(int id) {
        String sql = "Delete from Books where book_id=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<Books> getBooksPerPage(int startIndex, int booksPerPage) {
        List<Books> books = new ArrayList<>();
        String sql = "SELECT [book_id], [title], [author], [publisher],[description],[image], [quantity] "
                + "FROM [dbo].[Books] "
                + "ORDER BY book_id "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, startIndex);
            st.setInt(2, booksPerPage);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setImage(rs.getString("image"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setQuantity(rs.getInt("quantity"));

                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public int getTotalProducts() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM [dbo].[Books]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    public int getBookIdByTitle(String title) {
        String sql = "SELECT book_id FROM Books WHERE title = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setNString(1, title);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("book_id");
            }
        } catch (SQLException e) {
            System.out.println("Error in getBookIdByTitle: " + e.getMessage());
        }
        return -1;
    }

    public String getCategoryByBookId(int bookId) {
        String category = null;
        String sql = "SELECT category FROM Books WHERE book_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                category = rs.getString("category");
            }
        } catch (SQLException e) {
            System.out.println("Error in getCategoryByBookId: " + e.getMessage());
        }

        return category;
    }

    public List<Books> getTop5BooksByCategoryExcludingId(String category, int bookId) {
        List<Books> list = new ArrayList<>();
        String sql = "SELECT TOP (5) [book_id], [title], [author], [publisher], [category], "
                + "[description], [image], [quantity], [created_at], [updated_at] "
                + "FROM [dbo].[Books] "
                + "WHERE category = ? AND book_id <> ? "
                + "ORDER BY book_id DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, category);
            st.setInt(2, bookId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Books book = new Books();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setCategory(rs.getString("category"));
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(book);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTop5BooksByCategoryExcludingId: " + e.getMessage());
        }

        return list;
    }

}
