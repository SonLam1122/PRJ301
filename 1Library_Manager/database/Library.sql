--Create database Library

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

INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Fullmetal Alchemist', N'Hiromu Arakawa', N'Shueisha', N'Truyện tranh', N'Hai anh em Edward và Alphonse Elric tìm kiếm cách phục hồi cơ thể sau một thí nghiệm alchemy thất bại.', 'images/book/fullmetal.jpg', 9),
(N'Bleach', N'Tite Kubo', N'Shueisha', N'Truyện tranh', N'Ichigo Kurosaki, một thanh niên sở hữu sức mạnh của một Shinigami, bảo vệ thế giới khỏi linh hồn tà ác.', 'images/book/bleach.jpg', 11),
(N'Hunter x Hunter', N'Yoshihiro Togashi', N'Shueisha', N'Truyện tranh', N'Gon Freecss tìm kiếm cha mình và khám phá thế giới Hunter đầy nguy hiểm.', 'images/book/hunterxhunter.jpg', 10),
(N'Yu Yu Hakusho', N'Yoshihiro Togashi', N'Shueisha', N'Truyện tranh', N'Yusuke Urameshi, một học sinh trung học, phải bảo vệ thế giới con người sau khi hy sinh để cứu một đứa trẻ.', 'images/book/yuyuhakusho.jpg', 14),
(N'One Punch Man', N'ONE', N'Shogakukan', N'Truyện tranh', N'Saitama, một anh hùng có sức mạnh vô địch, tìm kiếm một đối thủ xứng tầm để chiến đấu.', 'images/book/onepunchman.jpg', 13),
(N'Fairy Tail', N'Hiro Mashima', N'Shueisha', N'Truyện tranh', N'Mối quan hệ giữa Natsu Dragneel và những người bạn trong Hội Fairy Tail trong cuộc phiêu lưu của họ.', 'images/book/fairytail.jpg', 16),
(N'My Hero Academia', N'Kohei Horikoshi', N'Shueisha', N'Truyện tranh', N'Izuku Midoriya, một cậu bé không có khả năng siêu nhiên, quyết tâm trở thành anh hùng số một.', 'images/book/myheroacademia.jpg', 9),
(N'Kaguya-sama: Love is War', N'Aka Akasaka', N'Shuisha', N'Truyện tranh', N'Câu chuyện về cuộc chiến tranh tình yêu giữa Kaguya Shinomiya và Miyuki Shirogane tại hội học sinh.', 'images/book/kaguyasama.jpg', 7),
(N'Jujutsu Kaisen', N'Gege Akutami', N'Shueisha', N'Truyện tranh', N'Yuji Itadori đối mặt với nguy hiểm khi anh ta nuốt phải một ngón tay của Sukuna, một con quái vật cổ xưa.', 'images/book/jujutsukaisen.jpg', 8),
(N'Demon Slayer', N'Koyoharu Gotouge', N'Shueisha', N'Truyện tranh', N'Tanjiro Kamado chiến đấu chống lại quái vật để cứu em gái mình và trả thù cho gia đình.', 'images/book/demonslayer.jpg', 14),
(N'Tokyo Ghoul', N'Sui Ishida', N'Shuisha', N'Truyện tranh', N'Kaneeki, một con người trở thành Ghoul, phải đối mặt với những thử thách trong thế giới ghoul đầy tàn nhẫn.', 'images/book/tokyoghoul.jpg', 6),
(N'Slam Dunk', N'Takehiko Inoue', N'Shueisha', N'Truyện tranh', N'Hanamichi Sakuragi, một thanh niên nóng tính, gia nhập đội bóng rổ để tìm kiếm sự tôn trọng và tình yêu.', 'images/book/slamdunk.jpg', 15),
(N'Rurouni Kenshin', N'Nobuhiro Watsuki', N'Shueisha', N'Truyện tranh', N'Himura Kenshin, một samurai bị nguyền rủa, chiến đấu để bảo vệ những người vô tội trong thời kỳ Minh Trị.', 'images/book/rurounikenshin.jpg', 8)

-- Insert Japanese manga
INSERT INTO Books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Spirit Circle', N'Daisuke Ashihara', N'Shueisha', N'Truyện tranh', N'Câu chuyện về một cậu bé có thể sống lại trong các cuộc sống khác nhau qua các kiếp trước, phải đối mặt với những thử thách lớn.', 'images/book/spiritcircle.jpg', 8),
(N'Platinum End', N'Tsugumi Ohba', N'Verve', N'Truyện tranh', N'Một câu chuyện về một cậu bé bị bỏ rơi phải chiến đấu để trở thành một thiên thần, khi một cuộc chiến tranh giành quyền lực với những thiên thần khác bắt đầu.', 'images/book/platinumend.jpg', 9);


INSERT INTO books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Kinh Tế Học', N'Paul A. Samuelson', N'Nhà xuất bản Đại học Kinh tế Quốc dân', N'Khởi nghiệp', N'Giới thiệu các lý thuyết cơ bản trong kinh tế học.', 'images/book/kinhtehoc.jpg', 9),
(N'Start with Why', N'Simon Sinek', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Khám phá lý do đằng sau thành công của các tổ chức.', 'images/book/startwithwhy.jpg', 10),
(N'Chiến Lược Đại Dương Xanh', N'W. Chan Kim & Renée Mauborgne', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Một cách tiếp cận chiến lược để mở rộng thị trường mà không có đối thủ cạnh tranh.', 'images/book/chienluocdaiduongxanh.jpg', 9),
(N'Billion Dollar Whale', N'Tom Wright & Bradley Hope', N'Nhà xuất bản Tổng hợp TP.HCM', N'Khởi nghiệp', N'Câu chuyện về vụ lừa đảo tài chính lớn nhất trong lịch sử hiện đại.', 'images/book/billiondollarwhale.jpg', 8),
(N'Good to Great', N'Jim Collins', N'Nhà xuất bản Tổng hợp TP.HCM', N'Khởi nghiệp', N'Nghiên cứu lý do tại sao một số công ty có thể duy trì sự xuất sắc lâu dài.', 'images/book/goodtogreat.jpg', 10),
(N'Grit', N'Angela Duckworth', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Mạnh mẽ và kiên cường là yếu tố quan trọng trong việc đạt được thành công.', 'images/book/grit.jpg', 9),
(N'Lean In', N'Sheryl Sandberg', N'Nhà xuất bản NXB Phụ nữ', N'Khởi nghiệp', N'Một thông điệp mạnh mẽ về sự tham gia và lãnh đạo của phụ nữ trong xã hội.', 'images/book/leanin.jpg', 8),
(N'Rich Dad Poor Dad', N'Robert Kiyosaki', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Giới thiệu về sự khác biệt trong tư duy và đầu tư giữa người giàu và người nghèo.', 'images/book/richdadpoordad.jpg', 10),
(N'Người Giàu Nhất Thành Babylon', N'George S. Clason', N'Nhà xuất bản Tổng hợp TP.HCM', N'Khởi nghiệp', N'Một cuốn sách về các nguyên tắc tài chính cơ bản, giúp bạn quản lý tiền bạc hiệu quả và đầu tư thông minh.', 'images/book/nguoigiauchobabylon.jpg', 8),
(N'Mindset', N'Carol S. Dweck', N'Nhà xuất bản Trẻ', N'Khởi nghiệp', N'Sự khác biệt giữa tư duy cố định và tư duy phát triển sẽ ảnh hưởng thế nào đến thành công của bạn.', 'images/book/mindset.jpg', 9);

INSERT INTO books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Đời thay đổi khi chúng ta thay đổi', N'Andrew Matthews', N'Nhà xuất bản Trẻ', N'Tâm linh', N'Khám phá cách thay đổi tư duy và cuộc sống của bạn thông qua những bài học từ cuộc sống.', 'images/book/doithaydoikhichungtathaydoi.jpg', 9),
(N'Chánh niệm trong từng hơi thở', N'Tich Nhat Hanh', N'Nhà xuất bản Thế Giới', N'Tâm linh', N'Hướng dẫn về chánh niệm và những lợi ích của việc sống trong khoảnh khắc hiện tại.', 'images/book/chanhniemtrongtunghoitho.jpg', 9),
(N'Để sống hạnh phúc', N'Anthony Robbins', N'Nhà xuất bản NXB Phụ nữ', N'Tâm linh', N'Khám phá cách thức sống hạnh phúc và đạt được sự bình an trong tâm hồn.', 'images/book/desonghanhphuc.jpg', 9),
(N'Bí mật của sức mạnh tiềm thức', N'Joseph Murphy', N'Nhà xuất bản Trẻ', N'Tâm linh', N'Khám phá sức mạnh của tiềm thức và cách nó ảnh hưởng đến cuộc sống của bạn.', 'images/book/bimatcuasucmanhtiembut.jpg', 10);


INSERT INTO books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Khả Năng Tư Duy Đột Phá', N'Edward de Bono', N'Nhà xuất bản Trẻ', N'Tư duy', N'Khám phá cách phát triển tư duy sáng tạo và đột phá.', 'images/book/khanangtuduydotpha.jpg', 9),
(N'Tư Duy Tích Cực', N'Norman Vincent Peale', N'Nhà xuất bản Thế Giới', N'Tư duy', N'Khám phá sức mạnh của tư duy tích cực trong cuộc sống và công việc.', 'images/book/tuduytichcuc.jpg', 10),
(N'Chìa Khóa Thành Công', N'Brian Tracy', N'Nhà xuất bản Tổng hợp TP.HCM', N'Tư duy', N'Những nguyên tắc tư duy và hành động giúp đạt được thành công bền vững.', 'images/book/chiakhoathanhcong.jpg', 8),
(N'Giới Hạn Của Bạn Là Gì?', N'Gareth Jones', N'Nhà xuất bản Thế Giới', N'Tư duy', N'Khám phá giới hạn của bản thân và cách vượt qua chúng để đạt được mục tiêu.', 'images/book/gioihanbatlaigi.jpg', 8)

INSERT INTO books (title, author, publisher, category, description, image, quantity)
VALUES
(N'Giết Con Chim Nhại', N'Harper Lee', N'Nhà xuất bản Văn học', N'Tiểu thuyết', N'Câu chuyện về sự phân biệt chủng tộc và công lý tại miền Nam nước Mỹ.', 'images/book/gietconchimnhai.jpg', 19),
(N'To Kill a Mockingbird', N'Harper Lee', N'Nhà xuất bản Tổng hợp TP.HCM', N'Tiểu thuyết', N'Một câu chuyện về tình yêu và sự công bằng trong xã hội phân biệt chủng tộc.', 'images/book/tokillamockingbird.jpg', 20),
(N'1984', N'George Orwell', N'Nhà xuất bản Văn hóa - Văn nghệ', N'Tiểu thuyết', N'Câu chuyện về một xã hội toàn trị nơi chính phủ kiểm soát mọi thứ, bao gồm cả suy nghĩ của con người.', 'images/book/1984.jpg', 18),
(N'Mắt Biếc', N'Nguyễn Nhật Ánh', N'Nhà xuất bản Trẻ', N'Tiểu thuyết', N'Cuốn sách kể về tình yêu đầu đời trong sáng và những ký ức đẹp của tuổi thơ.', 'images/book/matbiec.jpg', 17),
(N'Nhà Giả Kim', N'Paulo Coelho', N'Nhà xuất bản Thế Giới', N'Tiểu thuyết', N'Cuốn sách kể về hành trình tìm kiếm ý nghĩa cuộc sống và sự giàu có đích thực.', 'images/book/nhagiakim.jpg', 20),
(N'Cánh Đồng Bất Tận', N'Nguyễn Ngọc Tư', N'Nhà xuất bản Trẻ', N'Tiểu thuyết', N'Một tác phẩm về cuộc sống và những khó khăn của người dân vùng quê miền Tây Nam Bộ.', 'images/book/canhdombutan.jpg', 18);

