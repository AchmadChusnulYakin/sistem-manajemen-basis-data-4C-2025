-- Memanggil Database
USE inventaris_laboratorium;

-- Mengecek Status Database
SHOW TRIGGERS FROM inventaris_laboratorium;

-- ====================
-- TRIGGER AFTER INSERT
-- ====================
DROP TRIGGER IF EXISTS Log_Peminjaman;

CREATE TABLE IF NOT EXISTS Log_Peminjaman (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman INT,
    tanggal_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    keterangan TEXT
);

DELIMITER //
CREATE TRIGGER after_insert_peminjaman 
AFTER INSERT ON Peminjaman -- dijalankan setelah ada data baru yang dimasukkan ke tabel Peminjaman
FOR EACH ROW
BEGIN
    INSERT INTO Log_Peminjaman (id_peminjaman, keterangan)
    VALUES (NEW.id_peminjaman, CONCAT('Peminjaman dibuat oleh pengguna ID ', NEW.id_pengguna));
END;
//
DELIMITER ;

-- Coba tambahkan peminjaman baru
INSERT INTO Peminjaman (id_pengguna, id_petugas, tanggal_pinjam, tanggal_kembali, STATUS)
VALUES (1, 1, '2025-05-14', '2025-05-20', 'Dipinjam');

-- Cek isi log
SELECT * FROM Log_Peminjaman;


-- =====================
-- TRIGGER AFTER UPDATE
-- =====================
DROP TRIGGER IF EXISTS after_update_peminjaman;

DELIMITER //
CREATE TRIGGER after_update_peminjaman
AFTER UPDATE ON Peminjaman -- digunakan untuk melakukan aksi otomatis setelah sebuah data diperbarui di tabel Peminjaman.
FOR EACH ROW
BEGIN
    IF NEW.STATUS = 'Dikembalikan' THEN
        UPDATE Alat_Laboratorium a
        JOIN Detail_Peminjaman d ON a.id_alat = d.id_alat
        SET a.kondisi = 'Baik'
        WHERE d.id_peminjaman = NEW.id_peminjaman;
    END IF;
END;
//
DELIMITER ;

-- Ubah status peminjaman menjadi "Dikembalikan
UPDATE Peminjaman SET STATUS = 'Dikembalikan' WHERE id_peminjaman = 3;

--  Cek apakah alat yang dipinjam dalam id_peminjaman = 3 berubah kondisinya menjadi "Baik"
SELECT a.nama_alat, a.kondisi
FROM Alat_Laboratorium a
JOIN Detail_Peminjaman d ON a.id_alat = d.id_alat
WHERE d.id_peminjaman = 3;


-- =====================
-- TRIGGER AFTER DELETE
-- =====================
DROP TRIGGER IF EXISTS after_delete_perawatan;

-- Buat tabel log jika belum ada
CREATE TABLE IF NOT EXISTS Log_Perawatan (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_alat INT,
    tanggal_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    keterangan TEXT
);

-- Buat trigger baru untuk mencatat log saat data perawatan dihapus
DELIMITER //
CREATE TRIGGER after_delete_perawatan
AFTER DELETE ON Perawatan_Alat -- digunakan ketika data perawatan dihapus
FOR EACH ROW
BEGIN
    INSERT INTO Log_Perawatan (id_alat, keterangan)
    VALUES (
        OLD.id_alat,
        CONCAT('Data perawatan dihapus untuk alat ID ', OLD.id_alat)
    );
END;
//
DELIMITER ;

-- Menghapus data perawatan (contoh id = 3)
DELETE FROM Perawatan_Alat WHERE id_perawatan = 3;

-- Menampilkan isi log
SELECT * FROM Log_Perawatan;

