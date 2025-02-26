

-- 1. Bảng Users - Thông tin người dùng
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    role VARCHAR(10) CHECK (role IN ('admin', 'user')) NOT NULL DEFAULT 'user',
    created_at DATETIME DEFAULT GETDATE(),
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

-- 4. Bảng Borrow_History - Lịch sử mượn/trả sách
CREATE TABLE Borrow_History (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    borrow_id INT NOT NULL,
    user_full_name VARCHAR(100) NOT NULL,
    user_address VARCHAR(255),
    book_title VARCHAR(255) NOT NULL,
    status VARCHAR(10) CHECK (status IN ('borrowed', 'returned')) NOT NULL,
    status_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (borrow_id) REFERENCES Borrow(borrow_id) ON DELETE CASCADE
);

-- 5. Bảng Fines - Quản lý tiền phạt
CREATE TABLE Fines (
    fine_id INT PRIMARY KEY IDENTITY(1,1),
    borrow_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status BIT DEFAULT 0,
    status_date DATE,
    FOREIGN KEY (borrow_id) REFERENCES Borrow(borrow_id) ON DELETE CASCADE
);

-- 6. Bảng Payments - Lưu thông tin thanh toán phạt
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    fine_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (fine_id) REFERENCES Fines(fine_id) ON DELETE NO ACTION
);

INSERT INTO Users (username, password, email, full_name, address, role)
VALUES 
('admin1', 'hashed_password1', 'admin1@example.com', 'Admin One', '123 Main St', 'admin'),
('user1', 'hashed_password2', 'user1@example.com', 'User One', '456 Elm St', 'user'),
('user2', 'hashed_password3', 'user2@example.com', 'User Two', '789 Oak St', 'user');

-- 1. Tiểu thuyết
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Bố già', N'Mario Puzo', N'Nhà xuất bản Văn học', N'Tiểu thuyết', N'Cuốn sách kinh điển về giới mafia Ý.', NULL, 10),
(N'Nhà giả kim', N'Paulo Coelho', N'Nhà xuất bản Lao động', N'Tiểu thuyết', N'Hành trình tìm kiếm kho báu và ý nghĩa cuộc sống.', NULL, 8),
(N'Totto-chan: Cô bé bên cửa sổ', N'Tetsuko Kuroyanagi', N'Nhà xuất bản Trẻ', N'Tiểu thuyết', N'Câu chuyện về giáo dục đặc biệt và sự tự do học tập.', NULL, 12),
(N'Trăm năm cô đơn', N'Gabriel García Márquez', N'Nhà xuất bản Hội Nhà Văn', N'Tiểu thuyết', N'Một trong những tiểu thuyết hay nhất của văn học Mỹ Latinh.', NULL, 6),
(N'Chuông nguyện hồn ai', N'Ernest Hemingway', N'Nhà xuất bản Văn học', N'Tiểu thuyết', N'Cuốn sách về chiến tranh và ý nghĩa của hy sinh.', NULL, 9);

-- 2. Kỹ năng sống
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Đắc Nhân Tâm', N'Dale Carnegie', N'Nhà xuất bản Trẻ', N'Kỹ năng sống', N'Bí quyết giao tiếp và thành công.', NULL, 15),
(N'7 Thói Quen Hiệu Quả', N'Stephen R. Covey', N'Nhà xuất bản Tổng hợp TP.HCM', N'Kỹ năng sống', N'Phương pháp quản lý bản thân và đạt được thành công.', NULL, 10),
(N'Tư Duy Tích Cực', N'Napoleon Hill', N'Nhà xuất bản Lao động', N'Kỹ năng sống', N'Sức mạnh của tư duy trong cuộc sống.', NULL, 7),
(N'Sống đơn giản cho đời thanh thản', N'Shunmyo Masuno', N'Nhà xuất bản Trẻ', N'Kỹ năng sống', N'Bài học từ triết lý Thiền trong cuộc sống.', NULL, 8),
(N'Quẳng gánh lo đi và vui sống', N'Dale Carnegie', N'Nhà xuất bản Trẻ', N'Kỹ năng sống', N'Bí quyết sống lạc quan, hạnh phúc.', NULL, 12);

-- 3. Truyện tranh
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Doraemon', N'Fujiko F. Fujio', N'Nhà xuất bản Kim Đồng', N'Truyện tranh', N'Bộ truyện tranh huyền thoại về chú mèo máy Doraemon.', NULL, 30),
(N'One Piece', N'Eiichiro Oda', N'Nhà xuất bản Kim Đồng', N'Truyện tranh', N'Câu chuyện về hành trình tìm kiếm kho báu của Luffy và đồng đội.', NULL, 25),
(N'Naruto', N'Masashi Kishimoto', N'Nhà xuất bản Kim Đồng', N'Truyện tranh', N'Cuộc hành trình của Naruto để trở thành Hokage.', NULL, 20),
(N'Conan - Thám tử lừng danh', N'Gosho Aoyama', N'Nhà xuất bản Kim Đồng', N'Truyện tranh', N'Câu chuyện phá án của thám tử nhí Conan.', NULL, 18),
(N'Dragon Ball', N'Akira Toriyama', N'Nhà xuất bản Kim Đồng', N'Truyện tranh', N'Câu chuyện về cuộc phiêu lưu của Son Goku.', NULL, 22);

-- 4. Tâm linh
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
(N'Dám thất bại', N'Billi P.S. Lim', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Học cách chấp nhận thất bại và vươn lên.', NULL, 12);

INSERT INTO Borrow (user_id, book_id, borrow_date, due_date, return_date, status)
VALUES 
(2, 1, '2025-02-20', '2025-03-05', NULL, 'borrowed'),
(3, 2, '2025-02-18', '2025-03-03', '2025-02-28', 'returned'),
(2, 3, '2025-02-15', '2025-03-01', NULL, 'late');

-- 4. Thêm lịch sử mượn/trả sách
INSERT INTO Borrow_History (borrow_id, user_full_name, user_address, book_title, status)
VALUES 
(1, 'User One', '456 Elm St', 'Clean Code', 'borrowed'),
(2, 'User Two', '789 Oak St', 'The Pragmatic Programmer', 'returned'),
(3, 'User One', '456 Elm St', 'Introduction to Algorithms', 'borrowed');

-- 5. Thêm tiền phạt cho các lượt mượn quá hạn
INSERT INTO Fines (borrow_id, amount, status, status_date)
VALUES 
(3, 5.00, 0, '2025-03-02');

-- 6. Thêm thông tin thanh toán tiền phạt
INSERT INTO Payments (user_id, fine_id, amount, payment_date)
VALUES 
(2, 1, 5.00, '2025-03-05');

