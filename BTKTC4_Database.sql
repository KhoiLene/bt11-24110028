-- =============================================
-- KỊCH BẢN TẠO VÀ KHỞI TẠO CƠ SỞ DỮ LIỆU ĐỀ SỐ 04
-- Môn: Lập Trình Web - HK1 2026-2027
-- Sinh viên: Lê Nguyễn Minh Khôi - MSSV: 24110028
-- Đề thi: Đề số 04
-- =============================================

USE master;
GO

-- 1. TẠO CƠ SỞ DỮ LIỆU NẾU CHƯA TỒN TẠI
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'WebDB')
BEGIN
    CREATE DATABASE WebDB;
END
GO

USE WebDB;
GO

-- 2. XÓA BẢNG CŨ NẾU ĐÃ TỒN TẠI (THEO THỨ TỰ RÀNG BUỘC KHÓA NGOẠI)
IF OBJECT_ID(N'dbo.Favorites', N'U') IS NOT NULL DROP TABLE dbo.Favorites;
IF OBJECT_ID(N'dbo.Shares', N'U') IS NOT NULL DROP TABLE dbo.Shares;
IF OBJECT_ID(N'dbo.Videos', N'U') IS NOT NULL DROP TABLE dbo.Videos;
IF OBJECT_ID(N'dbo.Users', N'U') IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID(N'dbo.Category', N'U') IS NOT NULL DROP TABLE dbo.Category;
GO

-- =============================================
-- 3. TẠO CẤU TRÚC CÁC BẢNG (SCHEMA)
-- =============================================

-- 3.1. BẢNG CATEGORY (Danh mục video)
CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Categoryname NVARCHAR(100) NOT NULL,
    Categorycode NVARCHAR(100) NULL,
    Images NVARCHAR(500) NULL,
    Status BIT DEFAULT 1
);
GO

-- 3.2. BẢNG USERS (Người dùng hệ thống)
CREATE TABLE Users (
    Username NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15) NULL,
    Fullname NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    Admin BIT DEFAULT 0,
    Active BIT DEFAULT 1,
    Images NVARCHAR(500) NULL
);
GO

-- 3.3. BẢNG VIDEOS (Video bài giảng / giải trí)
CREATE TABLE Videos (
    VideoId NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Poster NVARCHAR(50) NULL,
    Views INT DEFAULT 0,
    Description NVARCHAR(500) NULL,
    Active BIT DEFAULT 1,
    CategoryId INT NULL,
    CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE SET NULL
);
GO

-- 3.4. BẢNG SHARES (Chia sẻ video qua email)
CREATE TABLE Shares (
    ShareId INT IDENTITY(1,1) PRIMARY KEY,
    Emails NVARCHAR(50) NULL,
    SharedDate DATE DEFAULT GETDATE(),
    Username NVARCHAR(50) NULL,
    VideoId NVARCHAR(50) NULL,
    CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- 3.5. BẢNG FAVORITES (Video yêu thích / Like)
CREATE TABLE Favorites (
    FavoriteId INT IDENTITY(1,1) PRIMARY KEY,
    LikedDate DATE DEFAULT GETDATE(),
    VideoId NVARCHAR(50) NULL,
    Username NVARCHAR(50) NULL,
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES Users(Username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId) ON DELETE CASCADE
);
GO

-- =============================================
-- 4. THÊM DỮ LIỆU MẪU (SEED DATA ĐÃ ĐỒNG BỘ)
-- =============================================

-- 4.1. Dữ liệu bảng Category (5 danh mục sản phẩm)
INSERT INTO Category (Categoryname, Categorycode, Images, Status) VALUES 
(N'Đồ Gia Dụng Thông Minh', N'GIA_DUNG', N'https://picsum.photos/seed/cat_giadung/300/200', 1),
(N'Thời Trang & Phụ Kiện', N'THOI_TRANG', N'https://picsum.photos/seed/cat_fashion/300/200', 1),
(N'Đồ Công Nghệ & Phụ Kiện', N'CONG_NGHE', N'https://picsum.photos/seed/cat_tech/300/200', 1),
(N'Mỹ Phẩm & Chăm Sóc Da', N'MY_PHAM', N'https://picsum.photos/seed/cat_beauty/300/200', 1),
(N'Đồ Ăn Vặt & Đặc Sản', N'AN_VAT', N'https://picsum.photos/seed/cat_food/300/200', 1);
GO

-- 4.2. Dữ liệu bảng Users (1 Admin + 1 User cá nhân Lê Nguyễn Minh Khôi + 12 User kiểm thử phân trang)
-- Tất cả mật khẩu mặc định: 12102006
INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES 
(N'admin', N'12102006', N'0779799000', N'Quản Trị Viên', N'admin@ute.edu.vn', 1, 1, NULL),
(N'lekhoi', N'12102006', N'0779799006', N'Lê Nguyễn Minh Khôi', N'lenguyenminhkhoi2006bl@gmail.com', 0, 1, NULL),
(N'user1', N'12102006', N'0779799015', N'Nguyễn Văn An', N'user1@gmail.com', 0, 1, NULL),
(N'user2', N'12102006', N'0779799023', N'Trần Thị Bích', N'user2@gmail.com', 0, 1, NULL),
(N'user3', N'12102006', N'0779799037', N'User 3', N'user3@gmail.com', 0, 1, NULL),
(N'user4', N'12102006', N'0779799042', N'User 4', N'user4@gmail.com', 0, 1, NULL),
(N'user5', N'12102006', N'0779799058', N'User 5', N'user5@gmail.com', 0, 1, NULL),
(N'user6', N'12102006', N'0779799064', N'User 6', N'user6@gmail.com', 0, 1, NULL),
(N'user7', N'12102006', N'0779799071', N'User 7', N'user7@gmail.com', 0, 1, NULL),
(N'user8', N'12102006', N'0779799085', N'User 8', N'user8@gmail.com', 0, 1, NULL),
(N'user9', N'12102006', N'0779799092', N'User 9', N'user9@gmail.com', 0, 1, NULL),
(N'user10', N'12102006', N'0779799018', N'User 10', N'user10@gmail.com', 0, 1, NULL),
(N'user11', N'12102006', N'0779799049', N'User 11', N'user11@gmail.com', 0, 1, NULL),
(N'user12', N'12102006', N'0779799083', N'User 12', N'user12@gmail.com', 0, 1, NULL);
GO

-- 4.3. Dữ liệu bảng Videos (17 sản phẩm bán hàng qua video kèm giá bán)
INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, Price, CategoryId) VALUES 
(N'SP01', N'Nồi Chiên Không Dầu Điện Tử 6L Lock&Lock Review & Nướng Thử', N'VIDEOtest.mp4', 5420, N'Video review trải nghiệm thực tế nướng gà và khoai tây bằng Nồi Chiên Không Dầu 6L. Công nghệ nhiệt Rapid Air đối lưu 360 độ, lòng nồi phủ chống dính ceramic cao cấp dễ vệ sinh. Đặt hàng COD ngay hôm nay được tặng kèm kẹp thức ăn inox!', 1, 890000, 1),
(N'SP02', N'Máy Hút Bụi Cầm Tay Không Dây Siêu Hút Bụi Mịn Giường Nệm', N'VIDEOtest.mp4', 3890, N'Trải nghiệm sức hút lốc xoáy 18.000Pa hút sạch bụi mịn lông thú cưng trên sofa và đệm. Pin Lithium 2500mAh dùng liên tục 45 phút, đầu hút xoay 180 độ linh hoạt. Bảo hành chính hãng 12 tháng, đổi mới trong 7 ngày!', 1, 450000, 1),
(N'SP03', N'Bình Giữ Nhiệt Inox 316 Cao Cấp 1000ml Giữ Lạnh 24H Giữ Nóng 12H', N'VIDEOtest.mp4', 2150, N'Test khả năng giữ đá lạnh suốt 24 giờ của bình giữ nhiệt chất liệu Inox 316 y tế không rỉ sét. Nắp bấm chống tràn tuyệt đối, có quai xách tiện lợi mang đi làm, tập gym. Hàng nhập khẩu chính hãng bảo hành rò rỉ 6 tháng.', 1, 180000, 1),
(N'SP04', N'Đèn Bàn Học Sinh Chống Cận Thị 3 Chế Độ Sáng Cảm Ứng Thông Minh', N'VIDEOtest.mp4', 1980, N'Video so sánh ánh sáng bảo vệ mắt đạt chuẩn bảo vệ thị lực học đường. Không chớp nháy, chỉ số hoàn màu CRI > 95, tích hợp cổng sạc USB cho điện thoại và giá đỡ iPad học online tiện lợi.', 1, 230000, 1),

(N'SP05', N'Áo Thun Unisex Cotton 100% 250gsm Dày Dặn Form Rộng Trẻ Trung', N'VIDEOtest.mp4', 6800, N'Cận cảnh chất vải cotton 100% chải kỹ 2 chiều không xù lông, thấm hút mồ hôi cực tốt. Bo cổ dệt dày không dão, hình in lụa cao cấp sắc nét giặt máy thoải mái. Đủ size từ M đến XXL cho nam nữ mang đồ đôi cực đẹp!', 1, 149000, 2),
(N'SP06', N'Giày Sneaker Thể Thao Nam Nữ Phối Màu Retro Đi Êm Chân Thoáng Khí', N'VIDEOtest.mp4', 4920, N'Mở hộp và lên chân mẫu giày sneaker phong cách Hàn Quốc hot trend năm nay. Đế cao su non đúc nguyên khối chống trơn trượt, lót đệm bọt khí đàn hồi êm ái đi bộ cả ngày không mỏi. Kiểm tra hàng trước khi thanh toán COD!', 1, 390000, 2),
(N'SP07', N'Balo Laptop Thời Trang Chống Thấm Nước Có Ngăn Khóa Kéo Chống Trộm', N'VIDEOtest.mp4', 3100, N'Test thử độ chống nước của vải Oxford 900D cao cấp dưới trời mưa lớn. Thiết kế ngăn đựng laptop 15.6 inch lót đệm chống sốc tổ ong, quai đeo êm ái phân bổ đều trọng lượng bảo vệ cột sống học sinh sinh viên.', 1, 279000, 2),

(N'SP08', N'Tai Nghe Không Dây Bluetooth 5.4 Chống Ồn Chủ Động ANC Âm Bass Đầy', N'VIDEOtest.mp4', 9800, N'Test chất âm âm bass trầm ấm và tính năng chống ồn chủ động cách ly âm thanh môi trường. Thời lượng pin trâu 40 giờ kèm hộp sạc, độ trễ cực thấp 45ms chơi game xem phim chuẩn đồng bộ âm hình. Bảo hành 1 đổi 1 trong 12 tháng.', 1, 350000, 3),
(N'SP09', N'Pin Sạc Dự Phòng 20000mAh Sạc Siêu Nhanh 22.5W Có Màn Hình LED Báo Pin', N'VIDEOtest.mp4', 7450, N'Thử nghiệm sạc nhanh đầy 60% pin iPhone 15 chỉ trong 30 phút. Lõi pin Polymer cao cấp chống cháy nổ theo tiêu chuẩn hàng không quốc tế, trang bị 2 cổng Type-C và 2 cổng USB sạc cùng lúc 3 thiết bị an toàn.', 1, 320000, 3),
(N'SP10', N'Bàn Phím Cơ Không Dây 3 Chế Độ RGB Hot-swap Gõ Siêu Êm Mượt', N'VIDEOtest.mp4', 8300, N'Sound test gõ phím cơ Linear Switch đã lube sẵn cực êm tai không gây ồn văn phòng. Đèn LED RGB 16.8 triệu màu 19 hiệu ứng ánh sáng bắt mắt, kết nối linh hoạt Bluetooth, 2.4Ghz và Dây Type-C đa thiết bị PC, Mac, iPad.', 1, 650000, 3),
(N'SP11', N'Chuột Công Thái Học Không Dây Silent Click Chống Mỏi Cổ Tay', N'VIDEOtest.mp4', 2890, N'Thiết kế uốn lượn ôm sát lòng bàn tay chuẩn nhân trắc học giúp loại bỏ cảm giác căng cơ cổ tay khi làm việc suốt 8 tiếng. Nút bấm Silent êm ái không tạo tiếng ồn, mắt đọc quang học 4000 DPI siêu chuẩn trên mọi mặt bàn.', 1, 290000, 3),

(N'SP12', N'Kem Chống Nắng Kiềm Dầu Nâng Tông Tự Nhiên Dịu Nhẹ SPF50+ PA++++', N'VIDEOtest.mp4', 5100, N'Thử chất kem mỏng nhẹ thấm nhanh chỉ sau 10 giây không nhờn rít hay vón cục trên da. Màng lọc chống nắng thế hệ mới bảo vệ toàn diện trước tia UVA, UVB và ánh sáng xanh từ màn hình máy tính, giúp da sáng mịn tự nhiên suốt ngày dài.', 1, 220000, 4),
(N'SP13', N'Bộ Sữa Rửa Mặt & Nước Hoa Hồng Chiết Xuất Rau Má Làm Dịu Da Mụn', N'VIDEOtest.mp4', 3600, N'Review hiệu quả làm sạch sâu se khít lỗ chân lông và kiểm soát dầu nhờn sau 14 ngày sử dụng. Độ pH 5.5 cân bằng lý tưởng không làm khô căng da, chiết xuất rau má và tràm trà hữu cơ tự nhiên lành tính cho mọi loại da nhạy cảm.', 1, 310000, 4),
(N'SP14', N'Son Kem Lì Mịn Như Nhung Kháng Nước Lâu Trôi Màu Đỏ Cam Trendy', N'VIDEOtest.mp4', 4250, N'Test swatch màu son đỏ cam tôn da lên môi cực chuẩn chỉ sau một lần quẹt. Công thức dưỡng ẩm với vitamin E không làm lộ vân môi, độ bám màu bền bỉ suốt 8 tiếng không dính vào khẩu trang hay ly cốc khi ăn uống.', 1, 165000, 4),

(N'SP15', N'Khô Gà Lá Chanh Cay Giòn Thơm Ngon Hũ Nắp Nhôm 500g Chuẩn Vị', N'VIDEOtest.mp4', 6200, N'Cận cảnh sợi khô gà vàng ruộm ngập tràn lá chanh sấy giòn thơm phức cay cay ngọt ngọt khó cưỡng. Chế biến từ ức gà tươi trang trại đạt chuẩn vệ sinh an toàn thực phẩm HACCP, ăn vặt khi xem phim hay nhâm nhi cuối tuần tuyệt đỉnh!', 1, 125000, 5),
(N'SP16', N'Khô Bò Miếng Thượng Hạng Cay Nồng Chuẩn Vị Tây Bắc Đậm Đà Hũ 500g', N'VIDEOtest.mp4', 4780, N'Từng miếng thịt bắp bò nguyên thớ sấy chín tới đượm hương ớt rừng, gừng và mắc khén đặc trưng. Dai ngọt tự nhiên từ thịt bò tươi không pha phẩm màu, món nhậu đặc sản trứ danh được hàng vạn thực khách yêu thích!', 1, 240000, 5),
(N'SP17', N'Cơm Cháy Chà Bông Sốt Nước Mắm Hành Ớt Giòn Rụm Hút Chân Không 500g', N'VIDEOtest.mp4', 3900, N'Âm thanh giòn tan rôm rốp khi cắn miếng cơm cháy gạo nếp cái hoa vàng phủ ngập chà bông gà cay. Sốt nước mắm kẹo gia truyền sánh đậm hòa quyện vị cay the của ớt hiểm và béo ngậy của mỡ hành, bảo quản giòn ngon 6 tháng.', 1, 95000, 5);
GO

-- 4.4. Dữ liệu bảng Shares & Favorites
INSERT INTO Shares (Emails, SharedDate, Username, VideoId) VALUES 
(N'banbe1@gmail.com', '2026-09-20', N'lekhoi', N'SP01'),
(N'banbe2@gmail.com', '2026-09-21', N'user1', N'SP08'),
(N'banbe3@gmail.com', '2026-09-22', N'user2', N'SP10');
GO

INSERT INTO Favorites (LikedDate, VideoId, Username) VALUES 
('2026-09-20', N'SP01', N'lekhoi'),
('2026-09-21', N'SP01', N'user1'),
('2026-09-22', N'SP01', N'user2'),
('2026-09-23', N'SP08', N'lekhoi'),
('2026-09-24', N'SP08', N'user3'),
('2026-09-25', N'SP10', N'user1'),
('2026-09-26', N'SP15', N'lekhoi');
GO

-- 4.5. Dữ liệu bảng Orders & OrderDetails (8 trạng thái)
INSERT INTO Orders (Username, CustomerName, Phone, Address, Note, TotalAmount, PaymentMethod, Status, CreatedDate) VALUES 
(N'lekhoi', N'Lê Nguyễn Minh Khôi', N'0779799006', N'12 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM', N'Xem video ưng ý chốt đơn luôn, giao giờ hành chính giúp em', 1340000, N'COD', N'Đơn hàng mới', GETDATE()),
(N'lekhoi', N'Lê Nguyễn Minh Khôi', N'0779799006', N'12 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM', N'Shop gọi xác nhận đơn trước khi đóng hàng nhé', 650000, N'COD', N'Đã xác nhận', DATEADD(HOUR, -6, GETDATE())),
(N'lekhoi', N'Lê Nguyễn Minh Khôi', N'0779799006', N'12 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM', N'Đóng gói xốp khí cẩn thận tránh va đập', 890000, N'COD', N'Chuẩn bị hàng', DATEADD(DAY, -1, GETDATE())),
(N'user1', N'Nguyễn Văn An', N'0779799015', N'456 Lê Văn Việt, Tăng Nhơn Phú A, TP. Thủ Đức, TP.HCM', N'Giao hàng nhanh giúp mình', 670000, N'COD', N'Vận chuyển', DATEADD(DAY, -2, GETDATE())),
(N'lekhoi', N'Lê Nguyễn Minh Khôi', N'0779799006', N'12 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM', N'Shipper đến cổng trường ĐH Sư Phạm Kỹ Thuật gọi em ra nhận', 350000, N'COD', N'Giao hàng', DATEADD(DAY, -3, GETDATE())),
(N'lekhoi', N'Lê Nguyễn Minh Khôi', N'0779799006', N'12 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM', N'Đã nhận hàng xem video unbox rất hài lòng!', 609000, N'COD', N'Đã giao', DATEADD(DAY, -4, GETDATE())),
(N'user2', N'Trần Thị Bích', N'0779799023', N'789 Nguyễn Kiệm, Phường 3, Q. Gò Vấp, TP.HCM', N'Khách đổi ý muốn mua sản phẩm màu khác', 149000, N'COD', N'Đơn hàng hủy', DATEADD(DAY, -5, GETDATE())),
(N'lekhoi', N'Lê Nguyễn Minh Khôi', N'0779799006', N'12 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP.HCM', N'Bưu tá giao không liên lạc được với người nhận sau 3 lần hẹn', 450000, N'COD', N'Đơn hàng hoàn', DATEADD(DAY, -6, GETDATE()));
GO

INSERT INTO OrderDetails (OrderId, VideoId, Price, Quantity, Amount) VALUES
(1, N'SP01', 890000, 1, 890000),
(1, N'SP02', 450000, 1, 450000),
(2, N'SP10', 650000, 1, 650000),
(3, N'SP01', 890000, 1, 890000),
(4, N'SP08', 350000, 1, 350000),
(4, N'SP09', 320000, 1, 320000),
(5, N'SP08', 350000, 1, 350000),
(6, N'SP06', 390000, 1, 390000),
(6, N'SP12', 219000, 1, 219000),
(7, N'SP05', 149000, 1, 149000),
(8, N'SP02', 450000, 1, 450000);
GO

PRINT N'=====================================================';
PRINT N'Cơ sở dữ liệu WebDB Bán Hàng Qua Video đã khởi tạo thành công!';
PRINT N'Mật khẩu cho tất cả tài khoản là: 12102006';
PRINT N'=====================================================';
GO
