

-- 1. Bảng Users - Thông tin người dùng
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
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
INSERT INTO Users (username, password, email, name, role)
VALUES 
    ('admin01', 'admin@123', 'admin@example.com', 'Administrator', 'admin'), --admin
    ('user01', 'user@123', 'user1@example.com', 'Nguyen Van A', 'user'),
    ('user02', 'user@123', 'user2@example.com', 'Tran Thi B',  'user'),
    ('user03', 'user@123', 'user3@example.com', 'Le Van C',  'user'),
	('user04', 'user@123', 'user4@example.com', 'Pham Thi D','user'),
    ('user05', 'user@123', 'user5@example.com', 'Hoang Van E',  'user'),
    ('user06', 'user@123', 'user6@example.com', 'Bui Thi F', 'user'),
    ('user07', 'user@123', 'user7@example.com', 'Dang Van G', 'user'),
    ('user08', 'user@123', 'user8@example.com', 'Ngo Thi H',  'user'),
    ('user09', 'user@123', 'user9@example.com', 'Tran Van I',  'user'),
    ('user10', 'user@123', 'user10@example.com', 'Vu Thi J',  'user'),
    ('user11', 'user@123', 'user11@example.com', 'Nguyen Van K',  'user'),
    ('user12', 'user@123', 'user12@example.com', 'Le Thi L', 'user'),
    ('user13', 'user@123', 'user13@example.com', 'Pham Van M','user'),
    ('user14', 'user@123', 'user14@example.com', 'Hoang Thi N', 'user'),
    ('user15', 'user@123', 'user15@example.com', 'Bui Van O', 'user'),
    ('user16', 'user@123', 'user16@example.com', 'Dang Thi P', 'user'),
    ('user17', 'user@123', 'user17@example.com', 'Ngo Van Q','user'),
    ('user18', 'user@123', 'user18@example.com', 'Trinh Thi R', 'user');


INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'One Piece2', N'Eiichiro Oda', N'Shueisha2', N'Truyện tranh', N'Hành trình trở thành Vua Hải Tặc của Luffy và đồng đội.', 'images/book/onpiece2.jpg', 10),
-- Truyện tranh
(N'One Piece', N'Eiichiro Oda', N'Shueisha', N'Truyện tranh', N'Hành trình trở thành Vua Hải Tặc của Luffy và đồng đội.', 'images/book/onpiec.jpg', 10),
(N'Naruto', N'Masashi Kishimoto', N'Shueisha', N'Truyện tranh', N'Câu chuyện về ninja Naruto và hành trình trưởng thành.', 'images/book/naruto.jpg', 8),
(N'Doraemon', N'Fujiko F. Fujio', N'Shogakukan', N'Truyện tranh', N'Chú mèo máy Doraemon giúp đỡ Nobita với các bảo bối thần kỳ.', 'images/book/doremon.jpg', 12),
(N'Attack on Titan', N'Hajime Isayama', N'Kodansha', N'Truyện tranh', N'Cuộc chiến chống lại Titan của nhân loại.', 'images/book/titan.jpg', 7),
(N'Dragon Ball', N'Akira Toriyama', N'Shueisha', N'Truyện tranh', N'Câu chuyện về Goku và hành trình tìm ngọc rồng.', 'images/book/daragon.jpg', 15),

-- Tiểu thuyết
(N'Harry Potter và Hòn Đá Phù Thủy', N'J.K. Rowling', N'Nhà xuất bản Trẻ', N'Tiểu thuyết', N'Cuộc hành trình đầu tiên của Harry Potter tại trường Hogwarts.', 'images/book/harrypotter.jpg', 20),
(N'Sherlock Holmes: Tập Truyện Ngắn', N'Arthur Conan Doyle', N'Nhà xuất bản Văn học', N'Tiểu thuyết', N'Tuyển tập các vụ án nổi tiếng của thám tử Sherlock Holmes.', 'images/book/holmes.jpg', 18),
(N'Chạng Vạng (Twilight)', N'Stephenie Meyer', N'Nhà xuất bản Trẻ', N'Tiểu thuyết', N'Câu chuyện tình yêu giữa Bella và ma cà rồng Edward.', 'images/book/changvang.jpg', 15),
(N'Đồi Gió Hú', 'Emily Brontë', N'Nhà xuất bản Văn học', N'Tiểu thuyết', N'Câu chuyện tình yêu mãnh liệt giữa Heathcliff và Catherine.', 'images/book/doigiohu.jpg', 12),
(N'Kẻ Đọc Sách (The Reader)', N'Bernhard Schlink', N'Nhà xuất bản Thế giới', N'Tiểu thuyết', N'Một câu chuyện cảm động về tình yêu và trách nhiệm.', 'images/book/kedocsach.jpg', 17),
-- Tâm linh
(N'Hành trình về phương Đông', N'Baird T. Spalding', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tâm linh', N'Câu chuyện về cuộc hành trình tìm kiếm tâm linh.', 'images/book/hanhtrinhvephuongdong.jpg', 9),
(N'Muôn kiếp nhân sinh', N'Nguyên Phong', N'Nhà xuất bản Tổng hợp TP.HCM', N'Tâm linh', N'Bài học về luật nhân quả và luân hồi.', 'images/book/muonkiepnhansinh.jpg', 11),
(N'Bí mật của nước', N'Masaru Emoto', N'Nhà xuất bản Thế Giới', N'Tâm linh', N'Sức mạnh của nước và những ảnh hưởng của nó.', 'images/book/bimatcuanuoc.jpg', 8),
(N'Từ tốt đến vĩ đại', N'Jim Collins', N'Nhà xuất bản Trẻ', N'Tâm linh', N'Cuốn sách về tư duy phát triển bản thân.', 'images/book/tutotdenvidai.jpg', 7),
(N'Sức mạnh của hiện tại', N'Eckhart Tolle', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tâm linh', N'Cuốn sách hướng dẫn thực hành chánh niệm.', 'images/book/sucmanhcuahientai.jpg', 10),

-- 5. Tư duy
(N'Tư duy nhanh và chậm', N'Daniel Kahneman', N'Nhà xuất bản Trẻ', N'Tư duy', N'Cách não bộ đưa ra quyết định và xử lý thông tin.', 'images/book/tuduynhanhvacham.jpg', 13),
(N'Lối tư duy của người thành công', N'Carol S. Dweck', N'Nhà xuất bản Lao động', N'Tư duy', N'Tư duy phát triển giúp đạt được thành công.', 'images/book/loituduycuanguoithanhcong.jpg', 12),
(N'Bạn có thể đàm phán bất cứ điều gì', N'Herb Cohen', N'Nhà xuất bản Tổng hợp TP.HCM', N'Tư duy', N'Nghệ thuật đàm phán và giao tiếp.', 'images/book/bancosthedamphanbatcudieugi.png', 9),
(N'Sức mạnh của thói quen', N'Charles Duhigg', N'Nhà xuất bản Trẻ', N'Tư duy', N'Cách hình thành và thay đổi thói quen.', 'images/book/sucmanhcuathoiquen.jpg', 14),
(N'Tâm lý học đám đông', N'Gustave Le Bon', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tư duy', N'Tâm lý của đám đông và cách nó ảnh hưởng đến xã hội.', 'images/book/tamlyhocdamdong.jpg', 11),

-- 6. Khởi nghiệp
(N'Khởi nghiệp tinh gọn', N'Eric Ries', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Phương pháp Lean Startup giúp khởi nghiệp hiệu quả.', 'images/book/khoinghiemtinhgon.jpg', 10),
(N'Zero to One', N'Peter Thiel', N'Nhà xuất bản Tổng hợp TP.HCM', N'Khởi nghiệp', N'Bài học về sáng tạo và khởi nghiệp từ con số 0.', 'images/book/zerotoone.jpg', 8),
(N'Nghĩ giàu làm giàu', N'Napoleon Hill', N'Nhà xuất bản Lao động', N'Khởi nghiệp', N'Cách tư duy và hành động để trở nên giàu có.', 'images/book/nghigiaulamgiau.jpg', 9),
(N'Cách mạng công nghiệp 4.0', N'Klaus Schwab', N'Nhà xuất bản Chính trị Quốc gia', N'Khởi nghiệp', N'Tác động của công nghệ đến kinh doanh.', 'images/book/cachmangcongnghiep.jpg', 7),
(N'Dám thất bại', N'Billi P.S. Lim', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Học cách chấp nhận thất bại và vươn lên.', 'images/book/damthatbai.jpg', 12)

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

INSERT INTO Fines (borrow_id, user_id, amount, fine_reason, fine_date)
SELECT 
    borrow_id, 
    user_id, 
    DATEDIFF(DAY, due_date, GETDATE()) * 5000, -- Tính tiền phạt 5000/ngày trễ
    'Late return',
    GETDATE()
FROM Borrow
WHERE status = 'late';

INSERT INTO Payments (user_id, fine_id, amount, payment_method, payment_date, status)
SELECT 
    f.user_id, 
    f.fine_id, 
    f.amount, 
    'cash',  -- Giả định người dùng trả bằng tiền mặt
    GETDATE(),
    0 -- Mặc định chưa thanh toán
FROM Fines f;

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
SELECT TOP 4 *
FROM Books
ORDER BY created_at DESC;
