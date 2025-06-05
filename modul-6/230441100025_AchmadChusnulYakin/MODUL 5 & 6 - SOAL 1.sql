-- Membuat Database
CREATE DATABASE laboratorium;
USE laboratorium;

-- Mengecek Status Database
SHOW PROCEDURE STATUS WHERE Db = 'inventaris_laboratorium';

-- Menghapus Database
DROP DATABASE IF EXISTS laboratorium;

-- Tabel Kategori_Alat
CREATE TABLE Kategori_Alat (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);

-- Tabel Alat_Laboratorium (perbaikan: tambah tanggal_input)
CREATE TABLE Alat_Laboratorium (
    id_alat INT AUTO_INCREMENT PRIMARY KEY,
    nama_alat VARCHAR(100) NOT NULL,
    jenis_alat VARCHAR(50),
    jumlah_total INT,
    lokasi VARCHAR(100),
    kondisi VARCHAR(50),
    tanggal_input DATE DEFAULT CURRENT_DATE,
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

-- Tabel Peminjaman (perbaikan: ubah ENUM menjadi VARCHAR dan tambah created_at)
CREATE TABLE Peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    id_pengguna INT,
    id_petugas INT,
    tanggal_pinjam DATE,
    tanggal_kembali DATE,
    STATUS VARCHAR(20) DEFAULT 'Dipinjam',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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

-- Tabel Perawatan_Alat
CREATE TABLE Perawatan_Alat (
    id_perawatan INT AUTO_INCREMENT PRIMARY KEY,
    id_alat INT,
    tanggal_perawatan DATE,
    deskripsi_perawatan TEXT,
    petugas_pelaksana VARCHAR(100),
    FOREIGN KEY (id_alat) REFERENCES Alat_Laboratorium(id_alat)
);

INSERT INTO Kategori_Alat (nama_kategori) VALUES
('Elektronik'), ('Kimia'), ('Biologi'), ('Mekanik'), ('Optik'),
('Thermal'), ('Magnetik'), ('Digital'), ('Analog'), ('Manual');

INSERT INTO Alat_Laboratorium (nama_alat, jenis_alat, jumlah_total, lokasi, kondisi, tanggal_input, id_kategori) VALUES
('Multimeter', 'Elektronik', 5, 'Lab Elektronika', 'Baik', '2024-12-01', 1),
('Mikroskop', 'Optik', 3, 'Lab Biologi', 'Baik', '2025-04-01', 5),
('Bunsen Burner', 'Kimia', 10, 'Lab Kimia', 'Rusak', '2024-02-10', 2),
('Thermometer', 'Thermal', 7, 'Lab Fisika', 'Baik', '2025-03-15', 6),
('Magnet', 'Magnetik', 15, 'Lab Fisika', 'Baik', '2025-03-20', 7),
('Komputer', 'Digital', 8, 'Lab Komputer', 'Baik', '2025-04-15', 8),
('Stopwatch', 'Manual', 12, 'Lab Fisika', 'Rusak', '2025-02-01', 10),
('Centrifuge', 'Biologi', 2, 'Lab Biologi', 'Baik', '2025-03-01', 3),
('Oscilloscope', 'Elektronik', 4, 'Lab Elektronika', 'Baik', '2025-04-10', 1),
('pH Meter', 'Kimia', 6, 'Lab Kimia', 'Baik', '2025-03-25', 2);

INSERT INTO Petugas (nama_petugas, jabatan) VALUES
('Andi', 'Laboran'), ('Budi', 'Teknisi'), ('Citra', 'Admin Lab'),
('Dina', 'Supervisor'), ('Eka', 'Kepala Lab'), ('Fajar', 'Asisten'),
('Gilang', 'Teknisi'), ('Hana', 'Laboran'), ('Indra', 'Admin Lab'), ('Joko', 'Laboran');

INSERT INTO Pengguna (nama_pengguna, program_studi) VALUES
('Ali', 'Teknik Elektro'), ('Bella', 'Biologi'), ('Cindy', 'Kimia'),
('Dian', 'Fisika'), ('Eko', 'Teknik Mesin'), ('Fina', 'Teknik Kimia'),
('Gita', 'Teknik Komputer'), ('Hadi', 'Bioteknologi'), ('Irma', 'Farmasi'), ('Jaya', 'Teknik Industri');

INSERT INTO Peminjaman (id_pengguna, id_petugas, tanggal_pinjam, tanggal_kembali, STATUS, created_at) VALUES
(1, 1, '2023-03-01', '2023-03-10', 'Dikembalikan', '2023-03-01 08:00:00'),
(2, 2, '2023-04-01', '2023-05-01', 'Dipinjam', '2023-04-01 09:00:00'),
(3, 3, '2024-05-01', '2024-05-10', 'Dikembalikan', '2024-05-01 10:00:00'),
(4, 4, '2025-04-01', '2025-04-04', 'Dipinjam', '2025-04-01 11:00:00'),
(5, 5, '2025-04-02', '2025-04-05', 'Dikembalikan', '2025-04-02 12:00:00'),
(6, 6, '2025-04-03', '2025-04-06', 'Dipinjam', '2025-04-03 13:00:00'),
(7, 7, '2025-04-04', '2025-04-07', 'Dikembalikan', '2025-04-04 14:00:00'),
(8, 8, '2025-04-05', '2025-04-08', 'Dipinjam', '2025-04-05 15:00:00'),
(9, 9, '2025-04-06', '2025-04-09', 'Dikembalikan', '2025-04-06 16:00:00'),
(10, 10, '2025-04-07', '2025-04-10', 'Dipinjam', '2025-04-07 17:00:00');

INSERT INTO Detail_Peminjaman (id_peminjaman, id_alat, jumlah_dipinjam) VALUES
(1, 1, 2), (2, 2, 1), (3, 3, 2), (4, 4, 1), (5, 5, 3),
(6, 6, 2), (7, 7, 1), (8, 8, 1), (9, 9, 1), (10, 10, 2);

INSERT INTO Perawatan_Alat (id_alat, tanggal_perawatan, deskripsi_perawatan, petugas_pelaksana) VALUES
(1, '2024-03-01', 'Kalibrasi ulang', 'Andi'),
(2, '2024-03-02', 'Pembersihan lensa', 'Budi'),
(3, '2024-03-03', 'Perbaikan selang gas', 'Citra'),
(4, '2024-03-04', 'Penggantian baterai', 'Dina'),
(5, '2024-03-05', 'Pemeriksaan medan magnet', 'Eka'),
(6, '2024-03-06', 'Update software', 'Fajar'),
(7, '2024-03-07', 'Penggantian stopwatch rusak', 'Gilang'),
(8, '2024-03-08', 'Servis motor mesin', 'Hana'),
(9, '2024-03-09', 'Kalibrasi ulang', 'Indra'),
(10, '2024-03-10', 'Kalibrasi elektroda', 'Joko');

-- Menampilkan Data tabel
SELECT * FROM Kategori_Alat;
SELECT * FROM Alat_Laboratorium;
SELECT * FROM Petugas;
SELECT * FROM Pengguna;
SELECT * FROM Peminjaman;
SELECT * FROM Detail_Peminjaman;
SELECT * FROM Perawatan_Alat;


-- ===================================================
-- SOAL 1: Filter Alat Berdasarkan Lama Tanggal Masuk
-- ===================================================
DROP PROCEDURE IF EXISTS Tampil_Alat_Berdasarkan_Umur;

DELIMITER //
CREATE PROCEDURE Tampil_Alat_Berdasarkan_Umur(
    IN jumlah INT,
    IN satuan VARCHAR(10)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM Alat_Laboratorium WHERE tanggal_input >= CURDATE() - INTERVAL ', jumlah, ' ', satuan);
    PREPARE stmt FROM @query; -- Siapkan statement dari string query.
    EXECUTE stmt; -- Jalankan statement
    DEALLOCATE PREPARE stmt; -- Hapus statement setelah selesai untuk membersihkan memori.
END //
DELIMITER ;

-- Menampilkan alat-alat yang baru diinput dalam rentang waktu tersebut
CALL Tampil_Alat_Berdasarkan_Umur(7, 'DAY');
CALL Tampil_Alat_Berdasarkan_Umur(1, 'MONTH');
CALL Tampil_Alat_Berdasarkan_Umur(3, 'MONTH');


-- ==================================================================
-- SOAL 2: Hapus Transaksi Lebih dari 1 Tahun Jika Sudah Dikembalikan
-- ==================================================================
DROP PROCEDURE IF EXISTS Hapus_Transaksi_Lama;

-- Membuat tabel log
CREATE TABLE IF NOT EXISTS Log_Peminjaman_Dihapus AS 
SELECT * FROM Peminjaman WHERE 1 = 0;

DELIMITER //
CREATE PROCEDURE Hapus_Transaksi_Lama()
BEGIN
    -- Backup dulu ke tabel log
    INSERT INTO Log_Peminjaman_Dihapus
    SELECT * FROM Peminjaman
    WHERE STATUS = 'Dikembalikan'
    AND created_at < CURDATE() - INTERVAL 1 YEAR;
    
    -- Baru hapus
    DELETE FROM Peminjaman
    WHERE STATUS = 'Dikembalikan'
    AND created_at < CURDATE() - INTERVAL 1 YEAR;
END //
DELIMITER ;

-- Cek data yang terhapus dari tabel log
SELECT * FROM Log_Peminjaman_Dihapus;


-- ==========================================
-- SOAL 3: Update Status Minimal 7 Transaksi
-- ==========================================
DROP PROCEDURE IF EXISTS Update_Status_Massal;

DELIMITER //
CREATE PROCEDURE Update_Status_Massal()
BEGIN
  -- Menghapus tabel sementara jika sudah ada
  DROP TEMPORARY TABLE IF EXISTS TempUpdate;

  -- Membuat temporary table untuk id pinjaman yang akan diupdate
  CREATE TEMPORARY TABLE TempUpdate AS
    SELECT id_peminjaman
    FROM Peminjaman
    WHERE STATUS = 'Dipinjam'
    ORDER BY id_peminjaman
    LIMIT 7;

  -- Update dengan join ke temporary table
  UPDATE Peminjaman AS p
  JOIN TempUpdate AS t ON p.id_peminjaman = t.id_peminjaman
  SET p.STATUS = 'Sukses';

END //
DELIMITER ;

-- Memastikan ada data dengan status 'Dipinjam' yang bisa diupdate
UPDATE Peminjaman SET STATUS = 'Dipinjam' WHERE id_peminjaman BETWEEN 1 AND 7;

-- Menjalankan prosedur untuk mengupdate status
CALL Update_Status_Massal();

-- Memeriksa hasilnya
SELECT id_peminjaman, STATUS FROM Peminjaman WHERE id_peminjaman BETWEEN 1 AND 7;


-- ============================================
-- SOAL 4: Edit User Jika Tidak Punya Transaksi
-- ============================================
DROP PROCEDURE IF EXISTS Edit_Pengguna;

DELIMITER //
CREATE PROCEDURE Edit_Pengguna(
    IN uid INT,
    IN nama_baru VARCHAR(100),
    IN prodi_baru VARCHAR(100)
)
BEGIN
    UPDATE Pengguna
    SET nama_pengguna = nama_baru, program_studi = prodi_baru
    WHERE id_pengguna = uid
      AND NOT EXISTS (
          SELECT 1 FROM Peminjaman
          WHERE id_pengguna = uid AND STATUS != 'Dikembalikan'
      );
END //
DELIMITER ;

-- Cek transaksi aktif pengguna id 1
SELECT * FROM Peminjaman WHERE id_pengguna = 1 AND STATUS != 'Dikembalikan';

-- Panggil prosedur untuk update data pengguna jika tidak ada transaksi aktif
CALL Edit_Pengguna(1, 'Ali Baru', 'Fisika');

-- Cek data pengguna setelah update
SELECT * FROM Pengguna WHERE id_pengguna = 1;


-- ====================================================
-- SOAL 5: Branching Status Transaksi 1 Bulan Terakhir
-- ====================================================
DROP PROCEDURE IF EXISTS Update_Status_Berdasarkan_Jumlah;

DELIMITER //
CREATE PROCEDURE Update_Status_Berdasarkan_Jumlah()
BEGIN
  DECLARE id_min INT; -- Mendeklarasikan 3 variabel lokal untuk menyimpan id_peminjaman
  DECLARE id_max INT;
  DECLARE id_mid INT; -- ID tengah (urutan ke-2 dari 3).
  
  -- Mengambil id_transaksi dengan jumlah paling sedikit
  SELECT id_peminjaman
  INTO id_min
  FROM Peminjaman
  WHERE STATUS = 'Dipinjam'
  ORDER BY id_peminjaman ASC -- proses mengurutkan data dari nilai terkecil ke nilai terbesar
  LIMIT 1;
  
  -- Mengambil id_transaksi dengan jumlah paling banyak
  SELECT id_peminjaman
  INTO id_max
  FROM Peminjaman
  WHERE STATUS = 'Dipinjam'
  ORDER BY id_peminjaman DESC
  LIMIT 1;
  
  -- Mengambil id_transaksi dengan jumlah tengah
  SELECT id_peminjaman
  INTO id_mid
  FROM Peminjaman
  WHERE STATUS = 'Dipinjam'
  ORDER BY id_peminjaman
  LIMIT 1 OFFSET 1;

  -- Update status berdasarkan jumlah transaksi
  UPDATE Peminjaman
  SET STATUS = CASE
    WHEN id_peminjaman = id_min THEN 'Non-Aktif'
    WHEN id_peminjaman = id_mid THEN 'Pasif'
    WHEN id_peminjaman = id_max THEN 'Aktif'
  END
  WHERE id_peminjaman IN (id_min, id_mid, id_max);
END//
DELIMITER ;

-- Menampilkan seluruh data peminjaman yang saat ini berstatus "Dipinjam"
SELECT * FROM Peminjaman WHERE STATUS = 'Dipinjam';

-- Mengambil 5 ID peminjaman pertama yang berstatus "Dipinjam"
SELECT id_peminjaman FROM Peminjaman WHERE STATUS = 'Dipinjam' LIMIT 5;

-- Mengubah status dari transaksi dengan id_peminjaman 1 sampai 5 menjadi "Dipinjam"
UPDATE Peminjaman SET STATUS = 'Dipinjam' WHERE id_peminjaman IN (1, 2, 3, 4, 5);

-- Memanggil prosedur tersimpan (stored procedure) bernama Update_Status_Berdasarkan_Jumlah
CALL Update_Status_Berdasarkan_Jumlah();

-- Menampilkan id_peminjaman dan STATUS untuk transaksi yang sudah diubah statusnya menjadi salah satu dari 'Aktif', 'Pasif', atau 'Non-Aktif'
SELECT id_peminjaman, STATUS FROM Peminjaman WHERE STATUS IN ('Aktif', 'Pasif', 'Non-Aktif');


-- ==============================================================================
-- SOAL 6: Menampilkan Jumlah Transaksi "Sukses" per Hari dalam 1 Bulan Terakhir
-- ==============================================================================
DROP PROCEDURE IF EXISTS Hitung_Transaksi_Berhasil;

DELIMITER //
CREATE PROCEDURE Hitung_Transaksi_Berhasil()
BEGIN
    DECLARE cur_date DATE;
    DECLARE last_date DATE;

    SET cur_date = CURDATE() - INTERVAL 30 DAY;
    SET last_date = CURDATE();

    WHILE cur_date <= last_date DO
        SELECT cur_date AS Tanggal,
               COUNT(*) AS Jumlah_Transaksi_Berhasil
        FROM Peminjaman
        WHERE DATE(created_at) = cur_date
        AND STATUS = 'Sukses';

        SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
    END WHILE;
END //
DELIMITER ;

-- Memanggil prosedur tersimpan (stored procedure) bernama Hitung_Transaksi_Berhasil
CALL Hitung_Transaksi_Berhasil();

-- Menampilkan seluruh data dari tabel Peminjaman
SELECT * FROM Peminjaman;

