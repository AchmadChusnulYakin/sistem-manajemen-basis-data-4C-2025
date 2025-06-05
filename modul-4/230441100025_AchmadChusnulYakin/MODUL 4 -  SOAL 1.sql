USE inventaris_laboratorium;

-- 1. Tambahkan Kolom Keterangan di Tabel Alat_Laboratorium
ALTER TABLE Alat_Laboratorium
ADD COLUMN keterangan TEXT;

-- Update Nilai Keterangan Untuk Beberapa Alat
UPDATE Alat_Laboratorium
SET keterangan = 'Untuk melihat objek mikroskopis'
WHERE nama_alat = 'Mikroskop';

UPDATE Alat_Laboratorium
SET keterangan = 'Alat pemanas dalam eksperimen kimia'
WHERE nama_alat = 'Bunsen Burner';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk mengukur suhu'
WHERE nama_alat = 'Thermometer';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk mengukur medan magnet'
WHERE nama_alat = 'Magnet';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk perhitungan dan pemrograman'
WHERE nama_alat = 'Komputer';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk pengukuran waktu'
WHERE nama_alat = 'Stopwatch';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk memisahkan partikel dalam cairan'
WHERE nama_alat = 'Centrifuge';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk mengukur sinyal listrik'
WHERE nama_alat = 'Oscilloscope';

UPDATE Alat_Laboratorium
SET keterangan = 'Digunakan untuk mengukur pH larutan'
WHERE nama_alat = 'pH Meter';

-- Tampilkan Nama Alat Dan Keterangannya
SELECT nama_alat, keterangan FROM Alat_Laboratorium;


-- 2. Gabungan 2 Tabel: Peminjaman Dan Pengguna
SELECT 
    Peminjaman.id_peminjaman,
    Pengguna.nama_pengguna,
    Peminjaman.tanggal_pinjam,
    Peminjaman.tanggal_kembali,
    Peminjaman.status
FROM Peminjaman
JOIN Pengguna ON Peminjaman.id_pengguna = Pengguna.id_pengguna;


-- 3. Order By DESC dan Order By ASC
-- A. Urutan DESC: Berdasarkan jumlah_total (Terbesar - Terkecil)
SELECT * FROM Alat_Laboratorium
ORDER BY jumlah_total DESC;

-- B. Urutan ASC: Berdasarkan nama_alat (A-Z)
SELECT * FROM Alat_Laboratorium
ORDER BY nama_alat ASC;


-- 4. Perubahan Tipe Data jumlah_total Menjadi SMALLINT
ALTER TABLE Alat_Laboratorium
MODIFY COLUMN jumlah_total SMALLINT;

-- Mengecek Hasil
DESCRIBE Alat_Laboratorium;


-- 5. Left Join, Right Join dan Self Join
-- A. LEFT JOIN: Semua Alat Dengan (atau tanpa) Perawatan
SELECT 
    Alat_Laboratorium.nama_alat,
    Perawatan_Alat.tanggal_perawatan
FROM Alat_Laboratorium
LEFT JOIN Perawatan_Alat ON Alat_Laboratorium.id_alat = Perawatan_Alat.id_alat;

-- B. RIGHT JOIN: Semua Perawatan, Meskipun Alat Tidak Ditemukan
SELECT 
    Alat_Laboratorium.nama_alat,
    Perawatan_Alat.tanggal_perawatan
FROM Alat_Laboratorium
RIGHT JOIN Perawatan_Alat ON Alat_Laboratorium.id_alat = Perawatan_Alat.id_alat;

-- C. SELF JOIN: Petugas dengan jabatan yang sama
SELECT 
    A.nama_petugas AS petugas1,
    B.nama_petugas AS petugas2,
    A.jabatan
FROM Petugas A
JOIN Petugas B ON A.jabatan = B.jabatan AND A.id_petugas < B.id_petugas;


-- 6. Operator Perbandingan (>= 5 contoh)
-- A. jumlah_total > 5
SELECT * FROM Alat_Laboratorium WHERE jumlah_total > 5;

-- B. jumlah_total <= 3
SELECT * FROM Alat_Laboratorium WHERE jumlah_total <= 3;

-- C. kondisi != 'Baik'
SELECT * FROM Alat_Laboratorium WHERE kondisi != 'Baik';

-- D. tanggal_pinjam > '2024-04-05'
SELECT * FROM Peminjaman WHERE tanggal_pinjam > '2024-04-05';

-- E. id_kategori BETWEEN 1 AND 5
SELECT * FROM Alat_Laboratorium WHERE id_kategori BETWEEN 1 AND 5;

SELECT * FROM Alat_Laboratorium 
WHERE kondisi != 'Baik' 
AND kondisi LIKE '%rusak%';




