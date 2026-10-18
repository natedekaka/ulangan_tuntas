-- Migration: Ulangan Sampai Tuntas
-- Menambahkan pengaturan target ketuntasan pada ujian dan tabel riwayat percobaan.
--
-- Catatan: aplikasi juga membuat kolom/tabel ini otomatis lewat
-- config/init_sekolah.php (initUlanganTuntas). File ini disediakan untuk
-- instalasi/dokumentasi manual.
--
-- Jalankan: mysql -u root -p ulangan < migrations/09_ulangan_tuntas.sql
-- (hanya bila kolom belum ada; aplikasi juga menambahkannya otomatis)

ALTER TABLE `ujian`
  ADD COLUMN `target_nilai` DECIMAL(5,2) NOT NULL DEFAULT 75.00 AFTER `tampilkan_skor`,
  ADD COLUMN `wajib_tuntas` ENUM('ya','tidak') NOT NULL DEFAULT 'ya' AFTER `target_nilai`;

CREATE TABLE IF NOT EXISTS `percobaan_ujian` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ujian` int NOT NULL,
  `nis` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kelas` varchar(50) NOT NULL,
  `percobaan_ke` int NOT NULL DEFAULT 1,
  `total_skor` int NOT NULL DEFAULT 0,
  `total_poin_maks` int NOT NULL DEFAULT 0,
  `nilai` decimal(5,2) NOT NULL DEFAULT 0.00,
  `jumlah_benar` int NOT NULL DEFAULT 0,
  `jumlah_soal` int NOT NULL DEFAULT 0,
  `tuntas` tinyint(1) NOT NULL DEFAULT 0,
  `skor_awal` int DEFAULT NULL,
  `detail_jawaban` longtext,
  `ip_address` varchar(45) DEFAULT NULL,
  `device_fingerprint` varchar(64) DEFAULT NULL,
  `waktu_submit` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_ujian_nis` (`id_ujian`,`nis`),
  KEY `idx_ujian_tuntas` (`id_ujian`,`tuntas`),
  CONSTRAINT `fk_percobaan_ujian` FOREIGN KEY (`id_ujian`) REFERENCES `ujian` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
