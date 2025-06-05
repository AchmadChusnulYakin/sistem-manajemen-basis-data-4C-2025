-- Memanggil Database
USE inventaris_laboratorium;

-- Mengecek Status Database
SHOW TRIGGERS FROM inventaris_laboratorium;

-- =====================
-- TRIGGER BEFORE INSERT
-- =====================
DROP TRIGGER IF EXISTS before_insert_alat;

DELIMITER //
CREATE TRIGGER before_insert_alat 
BEFORE INSERT ON Alat_Laboratorium -- sebelum baris dimasukkan ke tabel, berarti: trigger ini khusus untuk tabel Alat_Laboratorium
FOR EACH ROW -- trigger ini akan dieksekusi untuk setiap baris baru yang ingin dimasukkan.
BEGIN -- Awal blok eksekusi trigger
    IF NEW.jumlah_total < 0 THEN -- Cek kondisi: jika nilai jumlah_total dari data yang akan dimasukkan (NEW.jumlah_total) kurang dari 0, maka
        SIGNAL SQLSTATE '45000' -- menghentikan operasi INSERT dan memunculkan error.
        SET MESSAGE_TEXT = 'Jumlah total alat tidak boleh negatif.';
    END IF;
END;
//
DELIMITER ;

-- Coba masukkan alat dengan jumlah negatif:
INSERT INTO Alat_Laboratorium (nama_alat, jenis_alat, jumlah_total, lokasi, kondisi, id_kategori)
VALUES ('Alat Uji Negatif', 'Test', -5, 'Lab Tes', 'Baik', 1);
-- Hasil: Gagal dengan pesan error: Jumlah total alat tidak boleh negatif.


-- =====================
-- TRIGGER BEFORE UPDATE
-- =====================
DROP TRIGGER IF EXISTS before_update_alat;

DELIMITER //
CREATE TRIGGER before_update_alat
BEFORE UPDATE ON Alat_Laboratorium -- Trigger ini aktif sebelum data diupdate.
FOR EACH ROW -- Berlaku untuk setiap baris yang diubah.
BEGIN
    IF NEW.kondisi NOT IN ('Baik', 'Rusak') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kondisi alat hanya boleh Baik atau Rusak.';
    END IF;
END;
//
DELIMITER ;

-- Pastikan data awal kondisi memang 'Baik':
SELECT id_alat, nama_alat, kondisi FROM Alat_Laboratorium WHERE id_alat = 2;

-- Jalankan ulang perintah update:
UPDATE Alat_Laboratorium SET kondisi = 'Cacat' WHERE id_alat = 2;
--  Jika trigger aktif, kamu akan dapat error: Error Code: 1644 - Kondisi alat hanya boleh Baik atau Rusak.


-- =====================
-- TRIGGER BEFORE DELETE
-- =====================
-- menampilkan semua foreign key yang dimiliki tabel:
SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'Detail_Peminjaman'
  AND CONSTRAINT_SCHEMA = 'inventaris_laboratorium'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

-- Hapus trigger jika ada
DROP TRIGGER IF EXISTS before_delete_alat;

-- Hapus FK lama (pastikan nama FK benar)
ALTER TABLE Detail_Peminjaman DROP FOREIGN KEY detail_peminjaman_ibfk_1;
ALTER TABLE Detail_Peminjaman DROP FOREIGN KEY fk_detail_alat;

-- Tambahkan FK TANPA ON DELETE CASCADE (agar tidak langsung menghapus alat)
ALTER TABLE Detail_Peminjaman
ADD CONSTRAINT fk_detail_alat
FOREIGN KEY (id_alat) REFERENCES Alat_Laboratorium(id_alat);

-- Trigger mencegah penghapusan jika alat masih digunakan
DELIMITER //

CREATE TRIGGER before_delete_alat
BEFORE DELETE ON Alat_Laboratorium -- Trigger dijalankan sebelum baris dihapus dari tabel Alat_Laboratorium
FOR EACH ROW -- Berlaku untuk setiap baris (FOR EACH ROW) yang akan dihapus.


BEGIN
  IF EXISTS (SELECT 1 FROM Detail_Peminjaman WHERE id_alat = OLD.id_alat) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tidak bisa menghapus alat karena masih digunakan dalam peminjaman.';
  ELSEIF EXISTS (SELECT 1 FROM perawatan_alat WHERE id_alat = OLD.id_alat) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tidak bisa menghapus alat karena masih digunakan dalam perawatan.';
  END IF;
END;
//
DELIMITER ;

-- Coba hapus alat yang masih digunakan:
DELETE FROM Alat_Laboratorium WHERE id_alat = 2;