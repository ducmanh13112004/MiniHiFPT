package models

import ()

type Customer struct {
	ID            string `gorm:"primary_key"`
	SoDienThoai   string `gorm:"unique;not null"`
	TenKhachHang  string `gorm:"not null"`
	GioiTinh      string
	NgaySinh      string
	Email         string
	LoaiKhachHang string `gorm:"default:'T'"`
}

type Contract struct {
	ID           string `gorm:"primary_key"`
	TenKhachHang string `gorm:"not null"`
	DiaChi       string `gorm:"not null"`
	MaTinh       string `gorm:"not null"`
	MaQuanHuyen  string `gorm:"not null"`
	MaPhuongXa   string `gorm:"not null"`
	MaDuong      string
	SoNha        string
}

type Account struct {
	ID                 string `gorm:"primary_key"`
	SoDienThoai        string `gorm:"unique;not null"`
	MatKhau            string `gorm:"not null"`
	LanDangNhapGanNhat string
}

type OTPCode struct {
	ID          string `gorm:"primary_key"`
	SoDienThoai string `gorm:"not null"`
	OTPCode     string `gorm:"not null"`
	NgayTao     string `gorm:"default:CURRENT_TIMESTAMP"`
	HetHan      string `gorm:"not null"`
	DaXacThuc   bool   `gorm:"default:false"`
}

type Device struct {
	ID             string  `gorm:"primary_key"`
	SoDienThoai    string  `gorm:"not null"`
	LanDungGanNhat string  `gorm:"default:CURRENT_TIMESTAMP"`
	Account        Account `gorm:"foreignkey:SoDienThoai;association_foreignkey:SoDienThoai"`
}
