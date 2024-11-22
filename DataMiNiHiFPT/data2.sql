create database MiniHiFPT

-- Bảng KhachHang: Quản lý thông tin khách hàng
CREATE TABLE Customer (
    ID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    SoDienThoai VARCHAR(15) NOT NULL UNIQUE, 
    TenKhachHang VARCHAR(100) NOT NULL,
    GioiTinh CHAR(1) CHECK (GioiTinh IN ('M', 'F', 'O')),
    NgaySinh DATE NULL,
    Email VARCHAR(255) NULL,
    LoaiKhachHang CHAR(1) NOT NULL DEFAULT 'T'
);
go
-- Bảng HopDong: Quản lý thông tin hợp đồng
CREATE TABLE Contractt (
    ID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    TenKhachHang VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(255) NOT NULL,
    MaTinh CHAR(10) NOT NULL,
    MaQuanHuyen CHAR(10) NOT NULL,
    MaPhuongXa CHAR(10) NOT NULL,
    MaDuong CHAR(10) NULL,
    SoNha VARCHAR(50) NULL
);
go
-- Bảng KhachHang_HopDong: Liên kết khách hàng và hợp đồng (nhiều-nhiều)
CREATE TABLE Customer_Contractt(
    ID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    SoDienThoai VARCHAR(15) NOT NULL,
    HopDongID UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_KhachHang FOREIGN KEY (SoDienThoai) REFERENCES Customer(SoDienThoai) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT FK_HopDong FOREIGN KEY (HopDongID) REFERENCES Contractt(ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

go
-- Bảng Accounts: Quản lý thông tin đăng nhập
CREATE TABLE Accounts (
    ID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), -- Sử dụng UNIQUEIDENTIFIER
    SoDienThoai VARCHAR(15) NOT NULL UNIQUE,  -- Đảm bảo SoDienThoai là UNIQUE
    MatKhau NVARCHAR(255) NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE(),
    LanDangNhapGanNhat DATETIME NULL
);

go
-- Bảng Devices: Quản lý thiết bị đã đăng nhập
CREATE TABLE Devices (
    ID VARCHAR(45) PRIMARY KEY, -- Lưu trữ địa chỉ IP của thiết bị
    SoDienThoai VARCHAR(15) NOT NULL, -- Số điện thoại của người dùng
    LanDungGanNhat DATETIME DEFAULT GETDATE(), -- Lần đăng nhập gần nhất
    CONSTRAINT FK_Devices_Account FOREIGN KEY (SoDienThoai) REFERENCES Accounts(SoDienThoai)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);



go
-- Bảng OTP_Codes: Quản lý mã OTP
CREATE TABLE OTP_Codes (
    ID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    SoDienThoai VARCHAR(15) NOT NULL,
    OTP_Code CHAR(6) NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    HetHan DATETIME NOT NULL,
    DaXacThuc BIT DEFAULT 0,
    CONSTRAINT FK_OTP_Codes_Account FOREIGN KEY (SoDienThoai) REFERENCES Accounts(SoDienThoai) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
