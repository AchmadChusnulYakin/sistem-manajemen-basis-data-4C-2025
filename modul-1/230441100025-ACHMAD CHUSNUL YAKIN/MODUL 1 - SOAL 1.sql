-- ========================
-- SOAL 1: SISTEM AKADEMIK
-- ========================

-- Memuat Database
CREATE DATABASE IF NOT EXISTS akademik;
USE akademik;

-- Tabel Mahasiswa
CREATE TABLE Mahasiswa (
    nim CHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    jurusan VARCHAR(100),
    angkatan YEAR
);

-- Tabel Dosen
CREATE TABLE Dosen (
    nip CHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    prodi VARCHAR(100)
);

-- Tabel Mata_Kuliah
CREATE TABLE Mata_Kuliah (
    kode_mk CHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    nip CHAR(10),
    FOREIGN KEY (nip) REFERENCES Dosen(nip)
);

-- Tabel KRS
CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(10),
    kode_mk CHAR(10),
    semester INT,
    FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES Mata_Kuliah(kode_mk)
);

-- Insert Data Mahasiswa
INSERT INTO Mahasiswa VALUES
('23010001', 'Alya Putri', 'Sistem Informasi', 2023),
('23010002', 'Budi Santoso', 'Sistem Informasi', 2023),
('23010003', 'Clara Wijaya', 'Sistem Informasi', 2023),
('23010004', 'Dimas Hadi', 'Sistem Informasi', 2023),
('23010005', 'Eka Riani', 'Sistem Informasi', 2023),
('23010006', 'Fajar Nugroho', 'Sistem Informasi', 2023),
('23010007', 'Gita Lestari', 'Sistem Informasi', 2023),
('23010008', 'Hadi Saputra', 'Sistem Informasi', 2023),
('23010009', 'Indah Wulandari', 'Sistem Informasi', 2023),
('23010010', 'Joko Susilo', 'Sistem Informasi', 2023);

-- Insert Data Dosen
INSERT INTO Dosen VALUES
('0010010001', 'Dr. Andi Nugroho', 'Sistem Informasi'),
('0010010002', 'Dr. Rina Sari', 'Sistem Informasi'),
('0010010003', 'Prof. Budi Rahardjo', 'Sistem Informasi'),
('0010010004', 'Dr. Maya Lestari', 'Sistem Informasi'),
('0010010005', 'Dr. Denny Pratama', 'Sistem Informasi'),
('0010010006', 'Dr. Farah Hanum', 'Sistem Informasi'),
('0010010007', 'Dr. Tommy Wijaya', 'Sistem Informasi'),
('0010010008', 'Dr. Siti Aisyah', 'Sistem Informasi'),
('0010010009', 'Dr. Wahyu Hidayat', 'Sistem Informasi'),
('0010010010', 'Dr. Lina Marlina', 'Sistem Informasi');

-- Insert Data Mata_Kuliah
INSERT INTO Mata_Kuliah VALUES
('SI101', 'Algoritma Pemograman', 4, '0010010001'),
('SI102', 'Pemrograman Berbasis Objek', 4, '0010010002'),
('SI103', 'Pemrograman Berbasis Web', 4, '0010010003'),
('SI104', 'Pemrograman Visual', 4, '0010010004'),
('SI105', 'Pemrograman Bergerak', 4, '0010010005'),
('SI106', 'Sistem Manajemen Basis Data', 4, '0010010006'),
('SI107', 'Rekayasa Perangkat Lunak', 3, '0010010007'),
('SI108', 'Interaksi Manusia dan Komputer', 3, '0010010008'),
('SI109', 'Pengantar Basis Data', 3, '0010010009'),
('SI110', 'Kecerdasan Buatan', 3, '0010010010');


-- Menampilkan Semua Data
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM Mata_Kuliah;
SELECT * FROM KRS;

-- Menambahkan 5 Data ke Tabel KRS
INSERT INTO KRS (nim, kode_mk, semester) VALUES
('23010001', 'SI101', 4),
('23010002', 'SI101', 4),
('23010003', 'SI102', 4),
('23010004', 'SI103', 4),
('23010005', 'SI102', 4);

-- Melakukan Perubahan
ALTER TABLE Mahasiswa RENAME TO MHS;
SELECT * FROM Mhs

UPDATE Mata_Kuliah
SET sks = '5'
WHERE nama_MK = 'kecerdasan Buatan';

SELECT * FROM Mata_Kuliah
WHERE nama_MK = 'Kecerdasan Buatan';

-- Menghapus Database
DROP DATABASE akademik;
