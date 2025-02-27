Create Database Library1

-- 1. Bảng Users - Thông tin người dùng
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    role VARCHAR(10) CHECK (role IN ('admin', 'user')) NOT NULL DEFAULT 'user',
    created_at DATETIME DEFAULT GETDATE()
);

-- 2. Bảng Books - Thông tin sách
CREATE TABLE Books (
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(255) NOT NULL,
    author NVARCHAR(100),
    publisher NVARCHAR(100),
    category NVARCHAR(100),
    description NVARCHAR(255),
    image VARCHAR(MAX),
    quantity INT NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- 3. Bảng Borrow - Lượt mượn sách
CREATE TABLE Borrow (
    borrow_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(10) CHECK (status IN ('borrowed', 'returned', 'late')) NOT NULL DEFAULT 'borrowed',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- 5. Bảng Fines - Quản lý phạt vi phạm
CREATE TABLE Fines (
    fine_id INT PRIMARY KEY IDENTITY(1,1),
    borrow_id INT NOT NULL,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    fine_reason NVARCHAR(255) NOT NULL,
    fine_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (borrow_id) REFERENCES Borrow(borrow_id) ON DELETE NO ACTION,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION
);

-- 6. Bảng Payments - Thanh toán tiền phạt
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    fine_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT GETDATE(),
    payment_method NVARCHAR(50) CHECK (payment_method IN ('cash', 'card', 'transfer')) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (fine_id) REFERENCES Fines(fine_id) ON DELETE NO ACTION,
	status BIT DEFAULT 0
);

-- Insert
INSERT INTO Users (username, password, email, full_name, address, role)
VALUES 
    ('admin01', 'admin@123', 'admin@example.com', 'Administrator', '123 Admin Street', 'admin'), --admin
    ('user01', 'user@123', 'user1@example.com', 'Nguyen Van A', '456 User Road', 'user'),
    ('user02', 'user@123', 'user2@example.com', 'Tran Thi B', '789 Member Ave', 'user'),
    ('user03', 'user@123', 'user3@example.com', 'Le Van C', '321 Library St', 'user'),
	('user04', 'user@123', 'user4@example.com', 'Pham Thi D', '567 Book Lane', 'user'),
    ('user05', 'user@123', 'user5@example.com', 'Hoang Van E', '890 Knowledge Blvd', 'user'),
    ('user06', 'user@123', 'user6@example.com', 'Bui Thi F', '135 Learning Ave', 'user'),
    ('user07', 'user@123', 'user7@example.com', 'Dang Van G', '246 Study Rd', 'user'),
    ('user08', 'user@123', 'user8@example.com', 'Ngo Thi H', '357 Wisdom St', 'user'),
    ('user09', 'user@123', 'user9@example.com', 'Tran Van I', '468 Scholar Rd', 'user'),
    ('user10', 'user@123', 'user10@example.com', 'Vu Thi J', '579 Smart St', 'user'),
    ('user11', 'user@123', 'user11@example.com', 'Nguyen Van K', '680 Reader Ln', 'user'),
    ('user12', 'user@123', 'user12@example.com', 'Le Thi L', '791 Thinkers Blvd', 'user'),
    ('user13', 'user@123', 'user13@example.com', 'Pham Van M', '902 Bookworm Ave', 'user'),
    ('user14', 'user@123', 'user14@example.com', 'Hoang Thi N', '103 Knowledge St', 'user'),
    ('user15', 'user@123', 'user15@example.com', 'Bui Van O', '214 Logic Rd', 'user'),
    ('user16', 'user@123', 'user16@example.com', 'Dang Thi P', '325 Learning Way', 'user'),
    ('user17', 'user@123', 'user17@example.com', 'Ngo Van Q', '436 Study Lane', 'user'),
    ('user18', 'user@123', 'user18@example.com', 'Trinh Thi R', '547 Bright Blvd', 'user');

--truy van
SELECT * FROM Users 

-- Tâm linh
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Hành trình về phương Đông', N'Baird T. Spalding', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tâm linh', N'Câu chuyện về cuộc hành trình tìm kiếm tâm linh.', NULL, 9),
(N'Muôn kiếp nhân sinh', N'Nguyên Phong', N'Nhà xuất bản Tổng hợp TP.HCM', N'Tâm linh', N'Bài học về luật nhân quả và luân hồi.', NULL, 11),
(N'Bí mật của nước', N'Masaru Emoto', N'Nhà xuất bản Thế Giới', N'Tâm linh', N'Sức mạnh của nước và những ảnh hưởng của nó.', NULL, 8),
(N'Từ tốt đến vĩ đại', N'Jim Collins', N'Nhà xuất bản Trẻ', N'Tâm linh', N'Cuốn sách về tư duy phát triển bản thân.', NULL, 7),
(N'Sức mạnh của hiện tại', N'Eckhart Tolle', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tâm linh', N'Cuốn sách hướng dẫn thực hành chánh niệm.', NULL, 10);

-- 5. Tư duy
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Tư duy nhanh và chậm', N'Daniel Kahneman', N'Nhà xuất bản Trẻ', N'Tư duy', N'Cách não bộ đưa ra quyết định và xử lý thông tin.', NULL, 13),
(N'Lối tư duy của người thành công', N'Carol S. Dweck', N'Nhà xuất bản Lao động', N'Tư duy', N'Tư duy phát triển giúp đạt được thành công.', NULL, 12),
(N'Bạn có thể đàm phán bất cứ điều gì', N'Herb Cohen', N'Nhà xuất bản Tổng hợp TP.HCM', N'Tư duy', N'Nghệ thuật đàm phán và giao tiếp.', NULL, 9),
(N'Sức mạnh của thói quen', N'Charles Duhigg', N'Nhà xuất bản Trẻ', N'Tư duy', N'Cách hình thành và thay đổi thói quen.', NULL, 14),
(N'Tâm lý học đám đông', N'Gustave Le Bon', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tư duy', N'Tâm lý của đám đông và cách nó ảnh hưởng đến xã hội.', NULL, 11);

-- 6. Khởi nghiệp
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Khởi nghiệp tinh gọn', N'Eric Ries', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Phương pháp Lean Startup giúp khởi nghiệp hiệu quả.', NULL, 10),
(N'Zero to One', N'Peter Thiel', N'Nhà xuất bản Tổng hợp TP.HCM', N'Khởi nghiệp', N'Bài học về sáng tạo và khởi nghiệp từ con số 0.', NULL, 8),
(N'Nghĩ giàu làm giàu', N'Napoleon Hill', N'Nhà xuất bản Lao động', N'Khởi nghiệp', N'Cách tư duy và hành động để trở nên giàu có.', NULL, 9),
(N'Cách mạng công nghiệp 4.0', N'Klaus Schwab', N'Nhà xuất bản Chính trị Quốc gia', N'Khởi nghiệp', N'Tác động của công nghệ đến kinh doanh.', NULL, 7),
(N'Dám thất bại', N'Billi P.S. Lim', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Học cách chấp nhận thất bại và vươn lên.', NULL, 12)

--SELECT * FROM Books 
INSERT INTO Borrow (user_id, book_id, borrow_date, due_date, return_date, status)
VALUES 
    (8, 2, '2025-02-01', '2025-02-15', NULL, 'borrowed'),
    (2, 3, '2025-02-05', '2025-02-20', NULL, 'borrowed'),
    (3, 1, '2025-01-20', '2025-02-05', '2025-02-05', 'returned'),
    (4, 5, '2025-02-10', '2025-02-25', NULL, 'borrowed'),
    (7, 7, '2025-01-30', '2025-02-10', NULL, 'late'),
    (5, 4, '2025-02-08', '2025-02-22', NULL, 'borrowed'),
    (1, 6, '2025-02-01', '2025-02-16', '2025-02-15', 'returned'),
    (3, 8, '2025-01-25', '2025-02-10', '2025-02-09', 'returned'),
    (9, 9, '2025-02-12', '2025-02-27', NULL, 'borrowed'),
    (4, 10, '2025-02-15', '2025-03-01', NULL, 'borrowed'),
	(10, 9, '2025-01-30', '2025-02-19', NULL, 'late'),
	(13, 15, '2025-01-30', '2025-02-12', NULL, 'late'),
    (4, 2, '2025-01-25', '2025-02-10', '2025-02-05', 'returned'),
    (5, 3, '2025-02-01', '2025-02-15', NULL, 'borrowed');


SELECT * FROM Borrow 

INSERT INTO Fines (borrow_id, user_id, amount, fine_reason, fine_date)
SELECT 
    borrow_id, 
    user_id, 
    DATEDIFF(DAY, due_date, GETDATE()) * 5000, -- Tính tiền phạt 5000/ngày trễ
    'Late return',
    GETDATE()
FROM Borrow
WHERE status = 'late';

SELECT * FROM Fines

INSERT INTO Payments (user_id, fine_id, amount, payment_method, payment_date, status)
SELECT 
    f.user_id, 
    f.fine_id, 
    f.amount, 
    'cash',  -- Giả định người dùng trả bằng tiền mặt
    GETDATE(),
    0 -- Mặc định chưa thanh toán
FROM Fines f;

SELECT * FROM Payments;

CREATE TRIGGER trg_UpdateBorrowStatus
ON Payments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Nếu status của Payments chuyển từ 0 -> 1 thì update Borrow
    UPDATE Borrow
    SET status = 'returned',
        return_date = GETDATE()
    WHERE borrow_id IN (
        SELECT f.borrow_id
        FROM Fines f
        JOIN inserted i ON f.fine_id = i.fine_id
        WHERE i.status = 1
    );
END;

UPDATE Payments
SET status = 1
WHERE payment_id = 3;

SELECT * FROM Payments;
SELECT * FROM Fines;
SELECT * FROM Borrow;
SELECT * FROM Books;
SELECT * FROM Users;
