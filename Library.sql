CREATE DATABASE Library_Management;
--tai khoan nguoi dung
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(255) NOT NULL,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(10) NOT NULL CHECK (role IN ('admin', 'user')),
    email NVARCHAR(255) UNIQUE NOT NULL,
    phone_number NVARCHAR(20),
    address NVARCHAR(255)
);
--tac gia cua sach
CREATE TABLE Authors (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    country NVARCHAR(100) NOT NULL
);
--nha xuat ban
CREATE TABLE Publishers (
    publisher_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    address NVARCHAR(255),
    phone NVARCHAR(20)
);
--Danh Muc Sach
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX)
);
--Kho Sach Thu Vien
CREATE TABLE Books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    isbn NVARCHAR(20) UNIQUE NOT NULL,
    publisher_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    available INT NOT NULL CHECK (available >= 0),
    description NVARCHAR(MAX),
    release_date DATE,
	image_url NVARCHAR(255) NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) ON DELETE CASCADE
);
--Ho so muon va tra sach
CREATE TABLE Transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL DEFAULT GETDATE(),
    due_date DATE NOT NULL,
    return_date DATE DEFAULT NULL,
    status NVARCHAR(10) NOT NULL CHECK (status IN ('borrowed', 'returned')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);
--phat khi tar sach tre
CREATE TABLE Fines (
    fine_id INT IDENTITY(1,1) PRIMARY KEY,
    transaction_id INT NOT NULL UNIQUE,
    fine_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    paid BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id) ON DELETE CASCADE
);
-- giam so sach khi muon
GO
CREATE TRIGGER before_borrow
ON Transactions
FOR INSERT
AS
BEGIN
    DECLARE @book_id INT, @available_books INT;

    -- Lấy thông tin sách vừa mượn
    SELECT @book_id = book_id FROM inserted;

    -- Kiểm tra số sách còn có sẵn
    SELECT @available_books = available FROM Books WHERE book_id = @book_id;

    IF @available_books <= 0
    BEGIN
        RAISERROR ('Không đủ sách để mượn!', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        -- Cập nhật số sách có sẵn
        UPDATE Books SET available = available - 1 WHERE book_id = @book_id;
    END
END;
GO
--tang so sach khi tra
GO
CREATE TRIGGER after_return
ON Transactions
FOR UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted WHERE status = 'returned'
    )
    BEGIN
        UPDATE Books
        SET available = available + 1
        WHERE book_id IN (SELECT book_id FROM inserted WHERE status = 'returned');
    END
END;
GO
--tinh tien phat khi tra sach tre
GO
CREATE TRIGGER after_return_check_fine
ON Transactions
FOR UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted WHERE return_date > due_date AND status = 'returned'
    )
    BEGIN
        INSERT INTO Fines (transaction_id, fine_amount, paid)
        SELECT 
            transaction_id,
            DATEDIFF(DAY, due_date, return_date) * 5000, -- Mỗi ngày trễ phạt 5000 VNĐ
            0
        FROM inserted
        WHERE return_date > due_date;
    END
END;
GO

--them nguoi dung
INSERT INTO Users (full_name, username, password, role, email, phone_number, address) 
VALUES 
('Admin', 'admin', 'admin123', 'admin', 'admin@library.com', '0123456789', '123 Library St'),
('Nguyễn Văn A', 'user1', 'user123', 'user', 'user1@example.com', '0987654321', '456 District 7');
INSERT INTO Authors  VALUES
(N'Nguyễn Nhật Ánh', N'Hà Nội'),
(N'Trịnh Thanh Thanh', N'Huế'),
(N'Nguyễn Hồng', N'Hà Nội'),
(N'Tô Hoài', N'Nam Định'),
(N'Nguyễn Đức Hùng', N'Hà Nội'),
(N'Nguyễn Ngọc Tư', N'Thừa Thiên Huế'),
(N'Nguyễn Tuân', N'Thái Bình'),
(N'Xuân Diệu', N'Hà Nội'),
(N'Tản Đà', N'Hà Nội'),
(N'Nguyễn Quang Sáng', N'Thanh Hóa');

INSERT INTO Publishers  VALUES
(N'Nhà Xuất Bản Kim Đồng', N'9 Nguyễn Khoa Đăng, Phường 10, Quận 5, Hồ Chí Minh', '028 3955 2247'),
(N'Nhà Xuất Bản Giáo Dục', N'236 Lý Chính Thắng, Phường 9, Quận 3, Hồ Chí Minh', '028 3930 4351'),
(N'Nhà Xuất Bản Trẻ', N'161B Lý Chính Thắng, Phường 7, Quận 3, Hồ Chí Minh', '028 3930 3151'),
(N'Nhà Xuất Bản Đại Học Quốc Gia Hà Nội', N'334 Nguyễn Trãi, Thanh Xuân, Hà Nội', '024 3858 1482'),
(N'Nhà Xuất Bản Văn Học', N'15 Lý Thường Kiệt, Quận Hoàn Kiếm, Hà Nội', '024 3824 4120'),
(N'Nhà Xuất Bản Phụ Nữ', N'59 Nguyễn Du, Quận Hai Bà Trưng, Hà Nội', '024 3822 0966'),
(N'Nhà Xuất Bản Thanh Niên', N'161B Lý Chính Thắng, Phường 9, Quận 3, Hồ Chí Minh', '028 3930 2995'),
(N'Nhà Xuất Bản Kim Định', N'23 Phan Đình Phùng, Thành phố Đà Lạt, Lâm Đồng', '0263 3823 544'),
(N'Nhà Xuất Bản Tổng Hợp TPHCM', N'298 Cống Quỳnh, Phường Phạm Ngũ Lão, Quận 1, Hồ Chí Minh', '028 3920 6775'),
(N'Nhà Xuất Bản Hội Nhà Văn', N'50 Nguyễn Công Hoan, Ba Đình, Hà Nội', '024 3843 7723');
-- Insert Category
INSERT INTO Categories  VALUES 
		(N'Tiểu thuyết', N'Thể loại sách miêu tả các câu chuyện tưởng tượng và hư cấu.')
INSERT INTO Categories  VALUES 
       (N'Kỹ năng sống', N'Thể loại sách hướng dẫn và phát triển các kỹ năng sống.')
INSERT INTO Categories  VALUES
	   (N'Truyện tranh', N'Thể loại sách dành cho độc giả thiếu niên và trẻ em.')
INSERT INTO Categories  VALUES
	   (N'Tâm linh', N'Thể loại tâm linh liên quan đến các khía cạnh tâm linh, siêu nhiên và những hiện tượng vượt qua giới hạn thế giới vật chất.')
INSERT INTO Categories  VALUES
	   (N'Truyện ngắn', N'Thể loại truyện ngắn tập trung vào việc kể chuyện trong một số trang giới hạn, thường nhằm mô tả một sự kiện hoặc tình huống ngắn gọn một cách tinh tế.');
INSERT INTO Categories  VALUES
	   (N'Kinh doanh', N'Thể loại sách liên quan đến các khía cạnh kinh doanh và quản lý.')
INSERT INTO Categories  VALUES
		(N'Tâm lý', N'Thể loại sách nghiên cứu và phân tích về tâm lý con người.')

		-- Insert Product
 -- 1. Tiểu thuyết
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Hoàng Tử Bé', 5, 1, '978-6042101575', 1, 100, 100, N'“Hoàng tử bé” kể về sự tò mò, tình yêu, sự mất mát…', '2023-02-04', 'images/hoangtube.jpg'),
(N'Harry Potter', 1, 1, '978-0747532699', 1, 100, 100, N'Harry Potter là bộ truyện (gồm 7 phần) của J. K. Rowling.', '2023-02-05', 'images/harrypotter.jpg'),
(N'Ông già và biển cả', 7, 1, '978-0060930320', 2, 100, 100, N'Tiểu thuyết về hành trình của ông lão đánh cá Santiago.', '2024-04-05', 'images/onggia.jpg'),
(N'Hai số phận', 8, 1, '978-0449200411', 3, 110, 110, N'Cuộc đời hai con người sinh ra cùng năm 1906.', '2020-01-09', 'images/haisophan.jpg'),
(N'The Lord of the Rings', 5, 1, '978-0261102385', 2, 80, 80, N'Tiểu thuyết kinh điển của J. R. R. Tolkien.', '2021-01-30', 'images/lord.jpg'),
(N'Giết con chim nhại', 4, 1, '978-0060935462', 3, 90, 90, N'Cuốn sách về nạn phân biệt chủng tộc và bất công xã hội.', '2020-01-09', 'images/chimnhai.jpg');

-- 2. Kỹ năng sống
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Tư duy logic', 1, 2, '978-0134494166', 2, 50, 50, N'Giúp bạn phân tích và suy luận logic.', '2020-01-09', 'images/tuduylogic.jpg'),
(N'Tư duy mở', 10, 2, '978-1473614499', 7, 70, 70, N'Hướng dẫn tư duy mở để đón nhận kiến thức.', '2020-01-09', 'images/tuduymo.jpg'),
(N'Tư duy phản biện', 5, 2, '978-0143127801', 3, 80, 80, N'Học cách phân tích tình huống đa góc độ.', '2020-01-09', 'images/tuduyphanbien.jpg'),
(N'Tư duy sâu', 9, 2, '978-1476784861', 2, 100, 100, N'Tìm hiểu tư duy sâu và nâng cao nhận thức.', '2020-01-09', 'images/tuduysau.jpg');

-- 3. Truyện tranh
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Ba vị hòa thượng', 2, 3, '978-6042080986', 4, 40, 40, N'Truyện tranh hài hước về ba vị hòa thượng.', '2020-01-09', 'images/bavihoathuong.jpg'),
(N'Bầy voi đen', 9, 3, '978-6042080510', 1, 50, 50, N'Câu chuyện về những con voi trong tự nhiên.', '2023-10-10', 'images/bayvoiden.jpg'),
(N'Doraemon - Ngôi nhà nhỏ trên núi băng to', 7, 3, '978-4092271316', 2, 80, 80, N'Doraemon cùng Nobita phiêu lưu.', '2021-02-01', 'images/ngoinhanho.jpg');

-- 4. Tâm linh
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Hành trình tâm linh', 10, 4, '978-6042080511', 10, 50, 50, N'Câu chuyện về hành trình giác ngộ.', '2020-01-09', 'images/hanhtrinhtamlinh.jpg'),
(N'Luân hồi tiền kiếp', 9, 4, '978-6042080899', 6, 40, 40, N'Khám phá tiền kiếp và tái sinh.', '2024-03-04', 'images/luanhoitienkiep.jpg');

-- 5. Truyện ngắn
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Những người hàng xóm', 6, 5, '978-6042080316', 2, 30, 30, N'Những câu chuyện về hàng xóm.', '2023-07-09', 'images/hangxom.jpg'),
(N'Làng', 1, 5, '978-6042080455', 1, 80, 80, N'Câu chuyện về làng quê Việt Nam.', '2021-01-29', 'images/lang.jpg');

-- 6. Kinh doanh
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Bí mật tư duy triệu phú', 5, 6, '978-0060763282', 9, 50, 50, N'Bí quyết tư duy thành công của triệu phú.', '2021-10-09', 'images/tuduytrieuphu.jpg'),
(N'Dám thất bại', 9, 6, '978-0060776732', 7, 20, 20, N'Câu chuyện về sự thất bại và thành công.', '2023-05-05', 'images/thatbai.jpg');

-- 7. Tâm lý
INSERT INTO Books (title, author_id, category_id, isbn, publisher_id, quantity, available, description, release_date, image_url) VALUES
(N'Tâm Lý Học Hài Hước', 2, 7, '978-0805076143', 7, 50, 50, N'Khám phá những yếu tố hài hước trong tâm lý.', '2023-11-19', 'images/wise.jpg'),
(N'Tâm Lý Học – Nghệ Thuật Giải Mã Hành Vi', 9, 7, '978-0143125470', 3, 60, 60, N'Hướng dẫn giải mã hành vi con người.', '2021-01-29', 'images/nghethuat.jpg');
