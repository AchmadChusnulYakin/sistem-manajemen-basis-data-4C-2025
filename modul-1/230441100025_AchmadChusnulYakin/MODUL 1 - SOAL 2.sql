-- ======================================
-- SOAL 2: SISTEM INVENTARIS LABORATORIUM
-- ======================================

-- Membuat Database
CREATE DATABASE IF NOT EXISTS inventaris_laboratorium;
USE inventaris_laboratorium;


-- Tabel Kategori_Alat
CREATE TABLE Kategori_Alat (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);

-- Tabel Alat_Laboratorium
CREATE TABLE Alat_Laboratorium (
    id_alat INT AUTO_INCREMENT PRIMARY KEY,
    nama_alat VARCHAR(100) NOT NULL,
    jenis_alat VARCHAR(50),
    jumlah_total INT,
    lokasi VARCHAR(100),
    kondisi VARCHAR(50),
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES Kategori_Alat(id_kategori)
);

-- Tabel Petugas
CREATE TABLE Petugas (
    id_petugas INT AUTO_INCREMENT PRIMARY KEY,
    nama_petugas VARCHAR(100),
    jabatan VARCHAR(100)
);

-- Tabel Pengguna
CREATE TABLE Pengguna (
    id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
    nama_pengguna VARCHAR(100),
    program_studi VARCHAR(100)
);


-- Tabel Peminjaman
CREATE TABLE Peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    id_pengguna INT,
    id_petugas INT,
    tanggal_pinjam DATE,
    tanggal_kembali DATE,
    STATUS ENUM('Dipinjam', 'Dikembalikan') DEFAULT 'Dipinjam',
    FOREIGN KEY (id_pengguna) REFERENCES Pengguna(id_pengguna),
    FOREIGN KEY (id_petugas) REFERENCES Petugas(id_petugas)
);

-- Tabel Detail_Peminjaman 
CREATE TABLE Detail_Peminjaman (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman INT,
    id_alat INT,
    jumlah_dipinjam INT,
    FOREIGN KEY (id_peminjaman) REFERENCES Peminjaman(id_peminjaman),
    FOREIGN KEY (id_alat) REFERENCES Alat_Laboratorium(id_alat)
);

-- Tabel Perawa`inventaris_laboratorium`tan_Alat
CREATE TABLE Perawatan_Alat (
    id_perawatan INT AUTO_INCREMENT PRIMARY KEY,
    id_alat INT,
    tanggal_perawatan DATE,
    deskripsi_perawatan TEXT,
    petugas_pelaksana VARCHAR(100),
    FOREIGN KEY (id_alat) REFERENCES Alat_Laboratorium(id_alat)
);

SELECT * FROM Kategori_Alat;
SELECT * FROM Alat_Laboratorium;
SELECT * FROM Petugas;
SELECT * FROM Pengguna;
SELECT * FROM Peminjaman;
SELECT * FROM Detail_Peminjaman;
SELECT * FROM Perawatan_Alat;
