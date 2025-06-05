USE umkm_jabar;
SHOW PROCEDURE STATUS WHERE Db = 'umkm_jabar';

-- 1. Stored Procedure AddUMKM
DROP PROCEDURE IF EXISTS AddUMKM;

DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(100),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL AddUMKM('Toko Sukses Makmur', 10);
SELECT * FROM umkm;


-- 2. Stored Procedure UpdateKategoriUMKM
DROP PROCEDURE IF EXISTS UpdateKategoriUMKM;

DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL UpdateKategoriUMKM(1, 'Kategori Baru');
SELECT * FROM kategori_umkm;


-- 3. Stored Procedure DeletePemilikUMKM
DROP PROCEDURE IF EXISTS DeletePemilikUMKM;

DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    -- Menghapus Data Yang Terkait di Tabel produk_umkm
    DELETE FROM produk_umkm WHERE id_umkm IN (SELECT id_umkm FROM umkm WHERE id_pemilik = p_id_pemilik);
    
    -- Menghapus Data Yang Terkait di Tabel umkm
    DELETE FROM umkm WHERE id_pemilik = p_id_pemilik;

    -- Menghapus Data Pemilik di Tabel pemilik_umkm
    DELETE FROM pemilik_umkm WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL DeletePemilikUMKM(2);

-- Cek di tabel produk_umkm, umkm, dan pemilik_umkm
SELECT * FROM produk_umkm WHERE id_umkm IN (SELECT id_umkm FROM umkm WHERE id_pemilik = 2);
SELECT * FROM umkm WHERE id_pemilik = 2;
SELECT * FROM pemilik_umkm WHERE id_pemilik = 2;

-- Menampilkan semua data dari tabel produk_umkm, umkm, dan pemilik_umkm
SELECT * FROM produk_umkm;
SELECT * FROM umkm;
SELECT * FROM pemilik_umkm;


-- 4. Stored Procedure AddProduk
DROP PROCEDURE IF EXISTS AddProduk;

DELIMITER //
CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(100),
    IN p_harga INT
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END //
DELIMITER ;

-- Contoh Pemanggilan
CALL AddProduk(16, 'Keripik Tempe', 15000);
SELECT * FROM produk_umkm;


-- 5. Stored Procedure GetUMKMByID
DROP PROCEDURE IF EXISTS GetUMKMByID;

DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT,
    OUT p_nama_usaha VARCHAR(100),
    OUT p_jumlah_karyawan INT
)
BEGIN
    SELECT nama_usaha, jumlah_karyawan
    INTO p_nama_usaha, p_jumlah_karyawan
    FROM umkm
    WHERE id_umkm = p_id_umkm;
END //
DELIMITER ;

-- Contoh Pemanggilan
-- Siapkan Variabel
SET @nama := '';
SET @karyawan := 0;

-- Panggil Prosedur
CALL GetUMKMByID(1, @nama, @karyawan);

-- Tampilkan Hasil
SELECT @nama AS Nama_Usaha, @karyawan AS Jumlah_Karyawan;
