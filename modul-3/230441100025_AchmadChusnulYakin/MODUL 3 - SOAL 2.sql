USE inventaris_laboratorium;
SHOW PROCEDURE STATUS WHERE Db = 'inventaris_laboratorium';

-- 1. Stored Procedure UpdateDataMaster
DROP PROCEDURE IF EXISTS UpdateDataMaster;

DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nilai_baru VARCHAR(100),
    OUT p_status VARCHAR(50)
)
BEGIN
    UPDATE Alat_Laboratorium
    SET nama_alat = p_nilai_baru
    WHERE id_alat = p_id;

    IF ROW_COUNT() > 0 THEN
        SET p_status = 'Update berhasil';
    ELSE
        SET p_status = 'ID tidak ditemukan';
    END IF;
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL UpdateDataMaster(2, 'Alat Baru', @status);
SELECT @status;


-- 2. Stored Procedure CountTransaksi
DROP PROCEDURE IF EXISTS CountTransaksi;

DELIMITER //
CREATE PROCEDURE CountTransaksi (
    OUT p_total_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO p_total_transaksi FROM Peminjaman;
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL CountTransaksi(@total_transaksi);
SELECT @total_transaksi;


-- 3. Stored Procedure GetDataMasterByID
DROP PROCEDURE IF EXISTS GetDataMasterByID;

DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_nama_alat VARCHAR(100),
    OUT p_jenis_alat VARCHAR(50),
    OUT p_lokasi VARCHAR(100)
)
BEGIN
    SELECT nama_alat, jenis_alat, lokasi
    INTO p_nama_alat, p_jenis_alat, p_lokasi
    FROM Alat_Laboratorium
    WHERE id_alat = p_id;
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL GetDataMasterByID(2, @nama_alat, @jenis_alat, @lokasi);
SELECT @nama_alat, @jenis_alat, @lokasi;


-- 4. Stored Procedure UpdateFieldTransaksi
DROP PROCEDURE IF EXISTS UpdateFieldTransaksi ;

DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_field1 VARCHAR(100),
    INOUT p_field2 VARCHAR(100)
)
BEGIN
    IF p_field1 IS NOT NULL THEN
        UPDATE Peminjaman
        SET tanggal_pinjam = p_field1
        WHERE id_peminjaman = p_id;
    END IF;

    IF p_field2 IS NOT NULL THEN
        UPDATE Peminjaman
        SET tanggal_kembali = p_field2
        WHERE id_peminjaman = p_id;
    END IF;
END //
DELIMITER ;

-- Contoh Pemanggilan
SET @field1 = '2025-01-01', @field2 = '2025-01-10';
CALL UpdateFieldTransaksi(2, @field1, @field2);
SELECT @field1, @field2;


-- 5. Stored Procedure DeleteEntriesByIDMaster
DROP PROCEDURE IF EXISTS DeleteEntriesByIDMaster ;

DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id INT
)
BEGIN
    -- Hapus dari Detail_Peminjaman
    DELETE FROM Detail_Peminjaman WHERE id_alat = p_id;

    -- Hapus dari Perawatan_Alat
    DELETE FROM Perawatan_Alat WHERE id_alat = p_id;

    -- Hapus dari Alat_Laboratorium
    DELETE FROM Alat_Laboratorium WHERE id_alat = p_id;
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL DeleteEntriesByIDMaster(1);

-- Cek Pada Tabel alat_laboratorium, detail_peminjaman, dan perawatan_alat
SELECT * FROM Alat_Laboratorium WHERE id_alat = 1;
SELECT * FROM Detail_Peminjaman WHERE id_alat = 1;
SELECT * FROM Perawatan_Alat WHERE id_alat = 1;

-- Menampilkan Semua Data Dari Tabel Alat_Laboratorium, Detail_Peminjaman, dan Perawatan_Alat
SELECT * FROM Alat_Laboratorium;
SELECT * FROM Detail_Peminjaman;
SELECT * FROM Perawatan_Alat;

