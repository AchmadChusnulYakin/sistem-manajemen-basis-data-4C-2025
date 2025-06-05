-- =============================================
-- SISTEM MANAJEMEN INVENTARIS ALAT LABORATORIUM
-- =============================================

-- Membuat Database
CREATE DATABASE IF NOT EXISTS inventaris_laboratorium;
USE inventaris_laboratorium;

-- Tabel Master
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

-- Tabel Transaksi
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

-- Tabel Perawatan_ALat
CREATE TABLE Perawatan_Alat (
    id_perawatan INT AUTO_INCREMENT PRIMARY KEY,
    id_alat INT,
    tanggal_perawatan DATE,
    deskripsi_perawatan TEXT,
    petugas_pelaksana VARCHAR(100),
    FOREIGN KEY (id_alat) REFERENCES Alat_Laboratorium(id_alat)
);

-- Tabel Users
CREATE TABLE Users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    PASSWORD VARCHAR(255) NOT NULL
);

-- Insert Data Kategori_Alat
INSERT INTO Kategori_Alat (nama_kategori) VALUES
('Elektronik'), ('Kimia'), ('Biologi'), ('Mekanik'), ('Optik'),
('Thermal'), ('Magnetik'), ('Digital'), ('Analog'), ('Manual');

-- Insert Data Alat_Laboratorium
INSERT INTO Alat_Laboratorium (nama_alat, jenis_alat, jumlah_total, lokasi, kondisi, id_kategori) VALUES
('Multimeter', 'Elektronik', 5, 'Lab Elektronika', 'Baik', 1),
('Mikroskop', 'Optik', 3, 'Lab Biologi', 'Baik', 5),
('Bunsen Burner', 'Kimia', 10, 'Lab Kimia', 'Rusak', 2),
('Thermometer', 'Thermal', 7, 'Lab Fisika', 'Baik', 6),
('Magnet', 'Magnetik', 15, 'Lab Fisika', 'Baik', 7),
('Komputer', 'Digital', 8, 'Lab Komputer', 'Baik', 8),
('Stopwatch', 'Manual', 12, 'Lab Fisika', 'Rusak', 10),
('Centrifuge', 'Biologi', 2, 'Lab Biologi', 'Baik', 3),
('Oscilloscope', 'Elektronik', 4, 'Lab Elektronika', 'Baik', 1),
('pH Meter', 'Kimia', 6, 'Lab Kimia', 'Baik', 2);

-- Insert Data Petugas
INSERT INTO Petugas (nama_petugas, jabatan) VALUES
('Andi', 'Laboran'), ('Budi', 'Teknisi'), ('Citra', 'Admin Lab'),
('Dina', 'Supervisor'), ('Eka', 'Kepala Lab'), ('Fajar', 'Asisten'),
('Gilang', 'Teknisi'), ('Hana', 'Laboran'), ('Indra', 'Admin Lab'), ('Joko', 'Laboran');

-- Insert Data Pengguna
INSERT INTO Pengguna (nama_pengguna, program_studi) VALUES
('Ali', 'Teknik Elektro'), ('Bella', 'Biologi'), ('Cindy', 'Kimia'),
('Dian', 'Fisika'), ('Eko', 'Teknik Mesin'), ('Fina', 'Teknik Kimia'),
('Gita', 'Teknik Komputer'), ('Hadi', 'Bioteknologi'), ('Irma', 'Farmasi'), ('Jaya', 'Teknik Industri');

-- Insert Data Peminjaman
INSERT INTO Peminjaman (id_pengguna, id_petugas, tanggal_pinjam, tanggal_kembali, STATUS) VALUES
(1, 1, '2025-04-05', '2025-04-12', 'Dikembalikan'),
(2, 2, '2025-01-01', '2025-04-01', 'Dipinjam'),
(3, 3, '2025-01-01', '2025-05-05', 'Dikembalikan'),
(4, 4, '2025-04-04', '2025-04-06', 'Dipinjam'),
(5, 5, '2025-04-05', '2025-04-07', 'Dikembalikan'),
(6, 6, '2025-04-06', '2025-04-08', 'Dipinjam'),
(7, 7, '2025-04-07', '2025-04-09', 'Dikembalikan'),
(8, 8, '2025-04-08', '2025-04-10', 'Dipinjam'),
(9, 9, '2025-04-09', '2025-04-11', 'Dikembalikan'),
(10, 10, '2025-04-10', '2025-04-12', 'Dipinjam');

-- Insert Data Detail_Peminjaman
INSERT INTO Detail_Peminjaman (id_peminjaman, id_alat, jumlah_dipinjam) VALUES
(1, 1, 2), (2, 2, 1), (3, 3, 2), (4, 4, 1), (5, 5, 3),
(6, 6, 2), (7, 7, 1), (8, 8, 1), (9, 9, 1), (10, 10, 2);

-- Insert Data Perawatan_Alat
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

-- Insert Data Login Users
INSERT INTO users (username, PASSWORD) VALUES
('admin', MD5('admin123')),
('chusnul', MD5('passwordku'));

-- Menampilkan Data tabel
SELECT * FROM Kategori_Alat;
SELECT * FROM Alat_Laboratorium;
SELECT * FROM Petugas;
SELECT * FROM Pengguna;
SELECT * FROM Peminjaman;
SELECT * FROM Detail_Peminjaman;
SELECT * FROM Perawatan_Alat;


-- =====
-- View
-- =====
SHOW FULL TABLES IN inventaris_laboratorium WHERE TABLE_TYPE = 'VIEW';

-- 1. Gabungan 2 Tabel: Alat_Laboratorium Dan Kategori_Alat
CREATE VIEW view_alat_kategori AS
SELECT a.id_alat, a.nama_alat, a.jenis_alat, k.nama_kategori
FROM Alat_Laboratorium a
JOIN Kategori_Alat k ON a.id_kategori = k.id_kategori;

-- 2. Gabungan 3 Tabel: Peminjaman, Pengguna, Dan Petugas
CREATE VIEW view_peminjaman_detail AS
SELECT p.id_peminjaman, p.tanggal_pinjam, p.tanggal_kembali, p.status,
       g.nama_pengguna, g.program_studi, t.nama_petugas
FROM Peminjaman p
JOIN Pengguna g ON p.id_pengguna = g.id_pengguna
JOIN Petugas t ON p.id_petugas = t.id_petugas;

-- 3. View Dengan Kondisi WHERE
CREATE VIEW view_alat_baik AS
SELECT a.id_alat, a.nama_alat, a.kondisi, k.nama_kategori
FROM Alat_Laboratorium a
JOIN Kategori_Alat k ON a.id_kategori = k.id_kategori
WHERE a.kondisi = 'Baik';

-- 4. View Agregasi
CREATE VIEW view_total_peminjaman_alat AS
SELECT a.nama_alat, k.nama_kategori, SUM(d.jumlah_dipinjam) AS total_dipinjam
FROM Detail_Peminjaman d
JOIN Alat_Laboratorium a ON d.id_alat = a.id_alat
JOIN Kategori_Alat k ON a.id_kategori = k.id_kategori
GROUP BY a.nama_alat, k.nama_kategori;

-- 5. View Custom (Riwayat Perawatan Alat)
CREATE VIEW view_riwayat_perawatan AS
SELECT a.nama_alat, p.tanggal_perawatan, p.deskripsi_perawatan, p.petugas_pelaksana
FROM Perawatan_Alat p
JOIN Alat_Laboratorium a ON p.id_alat = a.id_alat;

-- Menampilkan Data View
SELECT * FROM view_alat_kategori;
SELECT * FROM view_peminjaman_detail;
SELECT * FROM view_alat_baik;
SELECT * FROM view_total_peminjaman_alat;
SELECT * FROM view_riwayat_perawatan;


-- =====
-- Join
-- =====
SELECT 
    p.id_peminjaman,
    u.nama_pengguna,
    pt.nama_petugas,
    al.nama_alat,
    dp.jumlah_dipinjam,
    p.tanggal_pinjam,
    p.tanggal_kembali,
    p.STATUS
FROM Peminjaman p
JOIN Pengguna u ON p.id_pengguna = u.id_pengguna
JOIN Petugas pt ON p.id_petugas = pt.id_petugas
JOIN Detail_Peminjaman dp ON p.id_peminjaman = dp.id_peminjaman
JOIN Alat_Laboratorium al ON dp.id_alat = al.id_alat
WHERE p.STATUS = 'Dipinjam'
ORDER BY p.tanggal_pinjam DESC;


-- ===============
-- Seleksi Kondisi
-- ===============
DELIMITER $$
CREATE PROCEDURE sp_get_peminjaman_by_status(IN p_status ENUM('Dipinjam','Dikembalikan'))
BEGIN
    SELECT 
        p.id_peminjaman,
        u.nama_pengguna,
        pt.nama_petugas,
        al.nama_alat,
        dp.jumlah_dipinjam,
        p.tanggal_pinjam,
        p.tanggal_kembali,
        p.STATUS
    FROM Peminjaman p
    JOIN Pengguna u ON p.id_pengguna = u.id_pengguna
    JOIN Petugas pt ON p.id_petugas = pt.id_petugas
    JOIN Detail_Peminjaman dp ON p.id_peminjaman = dp.id_peminjaman
    JOIN Alat_Laboratorium al ON dp.id_alat = al.id_alat
    WHERE p.STATUS = p_status;
END$$
DELIMITER ;

-- Menampilkan Data Peminjaman Dengan Status "Dipinjam"
CALL sp_get_peminjaman_by_status('Dipinjam');
-- Menampilkan Data Peminjaman Dengan Status "Dikembalikan"
CALL sp_get_peminjaman_by_status('Dikembalikan');


-- =============================
-- Looping pada Stored Procedure
-- =============================
DELIMITER $$
CREATE PROCEDURE sp_list_alat_loop_fixed()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE alat_id INT;
    DECLARE alat_name VARCHAR(100);
    DECLARE alat_jumlah INT;

    DECLARE alat_cursor CURSOR FOR
        SELECT id_alat, nama_alat, jumlah_total FROM Alat_Laboratorium;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DROP TEMPORARY TABLE IF EXISTS tmp_output;
    CREATE TEMPORARY TABLE tmp_output (info VARCHAR(200));

    OPEN alat_cursor;

    read_loop: LOOP
        FETCH alat_cursor INTO alat_id, alat_name, alat_jumlah;
        IF done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO tmp_output (info)
        VALUES (CONCAT('Alat: ', alat_name, ' - Stok: ', alat_jumlah));
    END LOOP;

    CLOSE alat_cursor;

    SELECT * FROM tmp_output;
END$$
DELIMITER ;

-- Menampilkan Data Hasil Looping
CALL sp_list_alat_loop_fixed();


-- =================================
-- Stored Procedure dengan Parameter
-- =================================
-- 1. Cari Alat Berdasarkan Kategori
DELIMITER $$
CREATE PROCEDURE sp_get_alat_by_kategori(IN p_id_kategori INT)
BEGIN
    SELECT * FROM Alat_Laboratorium WHERE id_kategori = p_id_kategori;
END$$
DELIMITER ;

-- Menampilkan Alat Berdasarkan id_kategori
CALL sp_get_alat_by_kategori(1);


-- 2. Update Status Peminjaman
DELIMITER $$
CREATE PROCEDURE sp_update_status_peminjaman(IN p_id_peminjaman INT, IN p_status ENUM('Dipinjam', 'Dikembalikan'))
BEGIN
    UPDATE Peminjaman SET STATUS = p_status WHERE id_peminjaman = p_id_peminjaman;
END$$
DELIMITER ;

-- Mengubah Status Peminjaman Menjadi 'Dipinjam' atau 'Dikembalikan'
CALL sp_update_status_peminjaman(1, 'Dipinjam');
-- Setelah itu, untuk melihat apakah berhasil
SELECT * FROM Peminjaman WHERE id_peminjaman = 1;


-- 3. Tambah Data Petugas Baru
DELIMITER $$
CREATE PROCEDURE sp_add_petugas(IN p_nama VARCHAR(100), IN p_jabatan VARCHAR(100))
BEGIN
    INSERT INTO Petugas (nama_petugas, jabatan) VALUES (p_nama, p_jabatan);
END$$
DELIMITER ;

-- Menambahkan Data Petugas Baru.
CALL sp_add_petugas('Zaki', 'Asisten');
-- Kemudian cek
SELECT * FROM Petugas ORDER BY id_petugas DESC LIMIT 5;


-- 4. Hapus Alat Berdasarkan ID
DELIMITER $$
CREATE PROCEDURE sp_delete_alat(IN p_id_alat INT)
BEGIN
    DELETE FROM Alat_Laboratorium WHERE id_alat = p_id_alat;
END$$
DELIMITER ;

-- Menghapus Data Alat Berdasarkan ID
CALL sp_delete_alat(10);
-- Kemudian Cek
SELECT * FROM Alat_Laboratorium WHERE id_alat = 10;


-- 5. Cari Peminjaman Berdasarkan Nama Pengguna
DELIMITER $$
CREATE PROCEDURE sp_get_peminjaman_by_pengguna(IN p_nama_pengguna VARCHAR(100))
BEGIN
    SELECT p.id_peminjaman, p.tanggal_pinjam, p.tanggal_kembali, p.STATUS
    FROM Peminjaman p
    JOIN Pengguna u ON p.id_pengguna = u.id_pengguna
    WHERE u.nama_pengguna LIKE CONCAT('%', p_nama_pengguna, '%');
END$$
DELIMITER ;

-- Menampilkan Data Peminjaman Berdasarkan Nama Pengguna
CALL sp_get_peminjaman_by_pengguna('Ali');


-- ================================
-- Trigger (INSERT, UPDATE, DELETE)
-- ================================
-- 1. Trigger INSERT di Peminjaman — Mencatat Log
DROP TABLE IF EXISTS Log_Peminjaman;
DROP TRIGGER IF EXISTS trg_after_insert_peminjaman;

CREATE TABLE Log_Peminjaman (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman INT,
    aksi VARCHAR(100),
    waktu DATETIME
);

ALTER TABLE Log_Peminjaman ADD COLUMN keterangan TEXT;

DELIMITER $$
CREATE TRIGGER trg_after_insert_peminjaman
AFTER INSERT ON Peminjaman
FOR EACH ROW
BEGIN
    INSERT INTO Log_Peminjaman (id_peminjaman, aksi, waktu, keterangan)
    VALUES (
        NEW.id_peminjaman,
        'INSERT',
        NOW(),
        'Data peminjaman baru ditambahkan'
    );
END$$
DELIMITER ;

-- Simulasi Tambah Data
INSERT INTO Peminjaman (id_pengguna, id_petugas, tanggal_pinjam, tanggal_kembali, STATUS)
VALUES (1, 2, '2025-05-21', '2025-05-25', 'Dipinjam');
-- Kemudian Lihat Log-nya
SELECT * FROM Log_Peminjaman;


-- 2. Trigger UPDATE di Peminjaman — Mencatat Perubahan Status
DELIMITER $$
CREATE TRIGGER trg_after_update_peminjaman
AFTER UPDATE ON Peminjaman
FOR EACH ROW
BEGIN
    IF NEW.STATUS <> OLD.STATUS THEN
        INSERT INTO Log_Peminjaman (id_peminjaman, aksi, waktu)
        VALUES (NEW.id_peminjaman, CONCAT('UPDATE STATUS dari ', OLD.STATUS, ' ke ', NEW.STATUS), NOW());
    END IF;
END$$
DELIMITER ;

-- Misalnya Update Status Peminjaman Ke 'Dikembalikan'
UPDATE Peminjaman SET STATUS = 'Dikembalikan' WHERE id_peminjaman = 10;
-- Kemudian Cek Log-nya
SELECT * FROM Log_Peminjaman WHERE id_peminjaman = 10 ORDER BY waktu DESC;


-- 3. Trigger DELETE di Peminjaman — Mencatat Penghapusan
DELIMITER $$
CREATE TRIGGER trg_after_delete_peminjaman
AFTER DELETE ON Peminjaman
FOR EACH ROW
BEGIN
    INSERT INTO Log_Peminjaman (id_peminjaman, aksi, waktu)
    VALUES (OLD.id_peminjaman, 'DELETE', NOW());
END$$
DELIMITER ;

-- Hapus Data Peminjaman
DELETE FROM Peminjaman WHERE id_peminjaman = 9;
-- Kemudian Cek Log-nya
SELECT * FROM Log_Peminjaman WHERE id_peminjaman = 9;
