-- Gabungan 2 Tabel: Alat_Laboratorium Dan Kategori_Alat
CREATE VIEW view_alat_kategori AS
SELECT a.id_alat, a.nama_alat, a.jenis_alat, k.nama_kategori
FROM Alat_Laboratorium a
JOIN Kategori_Alat k ON a.id_kategori = k.id_kategori;

-- Gabungan 3 Tabel: Peminjaman, Pengguna, Dan Petugas
CREATE VIEW view_peminjaman_detail AS
SELECT p.id_peminjaman, p.tanggal_pinjam, p.tanggal_kembali, p.status,
       g.nama_pengguna, g.program_studi, t.nama_petugas
FROM Peminjaman p
JOIN Pengguna g ON p.id_pengguna = g.id_pengguna
JOIN Petugas t ON p.id_petugas = t.id_petugas;

-- View Dengan Kondisi WHERE
CREATE VIEW view_alat_baik AS
SELECT a.id_alat, a.nama_alat, a.kondisi, k.nama_kategori
FROM Alat_Laboratorium a
JOIN Kategori_Alat k ON a.id_kategori = k.id_kategori
WHERE a.kondisi = 'Baik';

-- View Agregasi
CREATE VIEW view_total_peminjaman_alat AS
SELECT a.nama_alat, k.nama_kategori, SUM(d.jumlah_dipinjam) AS total_dipinjam
FROM Detail_Peminjaman d
JOIN Alat_Laboratorium a ON d.id_alat = a.id_alat
JOIN Kategori_Alat k ON a.id_kategori = k.id_kategori
GROUP BY a.nama_alat, k.nama_kategori;

-- View Custom (Riwayat Perawatan Alat)
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
