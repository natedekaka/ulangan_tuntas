# Ulangan Tuntas - Sistem Ujian Online

Aplikasi ujian online berbasis PHP dan MySQL untuk sekolah dengan fitur keamanan dan administrasi yang lengkap. Mendukung ujian berbasis komputer (CBT) dengan berbagai fitur keamanan.

## ⭐ Mode "Ulangan Sampai Tuntas"

Fitur utama aplikasi ini: siswa **wajib mencapai target nilai (default 75)** untuk dinyatakan **tuntas**. Jika belum tuntas, siswa **mengulang ulangan** (soal & pilihan jawaban diacak ulang setiap percobaan) sampai mencapai target.

- **Target ketuntasan (KKM)** dapat diatur per ujian (`target_nilai`, default `75`).
- **Wajib tuntas** dapat diaktifkan/nonaktifkan per ujian (`wajib_tuntas`).
- Setiap percobaan **dicatat** di tabel `percobaan_ujian` (tidak menimpa percobaan sebelumnya).
- Nilai yang dilaporkan ke guru = **nilai TERTINGGI** dari semua percobaan (`MAX(nilai)`).
- Siswa yang sudah **tuntas tidak bisa mengulang** (kecuali guru memberi izin remedi).
- Nilai dihitung sebagai persentase: `nilai = (total_skor / total_poin_maks) * 100`.

## Kompatibilitas

### Platform yang Didukung
- **Desktop**: Chrome, Firefox, Safari, Edge (versi terbaru)
- **Mobile**: 
  - **Android**: Android 7.0 (Nougat) ke atas
  - **iOS**: iOS 12 ke atas (termasuk iPhone XR, iPhone 11, dll)
- **Browser Mobile**: Chrome, Safari, Firefox

### Fitur Mobile
- Tampilan responsive mobile-first design
- Interface seperti aplikasi native
- Navigasi soal yang mudah di HP
- Load cepat untuk koneksi lambat

---

## Fitur

### Admin
- **Manajemen Ujian (CRUD)** dengan pengaturan keamanan lengkap
  - Atur judul, deskripsi, durasi, dan status ujian
  - Atur **Target Tuntas (KKM)** dan **Wajib Tuntas** (ulangi sampai tuntas)
  - Opsi acak soal per siswa
  - Tampilkan/nilai ulang hasil ujian
- **Bank Soal** (tambah/edit/hapus soal dengan gambar)
  - Mendukung soal pilihan ganda dan essay
  - Kategori soal: Mudah, Sedang, Sulit (dropdown)
  - Timer per soal (opsional)
  - Poin/score per soal
- **Import Soal Massal** dari Excel/CSV
  - Template download tersedia (format: soal, pilihan_a, pilihan_b, pilihan_c, pilihan_d, pilihan_e, kunci, poin, kategori)
  - Validasi format otomatis
  - Import ribuan soal sekaligus
- **Ekspor Soal ke PDF** dengan formatting rapi
- **Analytics Dashboard** dengan analisis mendalam
  - Distribusi Grade dinamis (berdasarkan KKM)
  - Analisis Butir Soal (Top 20 terburuk berdasarkan success rate)
  - Kategori otomatis: Mudah/Sedang/Sulit berdasarkan tingkat keberhasilan
  - Grafik interaktif (Chart.js): grade distribution, score distribution, question analysis
  - Daftar siswa yang perlu remedial (skor < KKM)
  - Top scorers
  - Export ke Excel (.xls) kompatibel LibreOffice/WPS Office
- **Rekap Nilai** dengan ekspor Excel
  - Filter berdasarkan ujian dan kelas
  - Statistik nilai (rata-rata, tertinggi, terendah)
  - Kolom **Nilai (persentase)**, **Status TUNTAS/BELUM TUNTAS**, dan jumlah percobaan
  - Detail jawaban per siswa
- **Monitor Ujian Real-time**
  - Lihat siswa yang sedang mengerjakan
  - Progress ujian per siswa (soal ke berapa)
  - Hapus siswa dari progress (jika ada kendala)
  - Reset ujian siswa (bisa mengerjakan ulang)
- **Manajemen Pelanggaran (Violations)**
  - Deteksi tab switching / Alt-Tab
  - Deteksi pergantian device (device fingerprint)
  - Auto-submit setelah batas pelanggaran
  - Hapus pelanggaran (jika false positive)
- **Profil Sekolah**
  - Nama sekolah
  - Upload logo sekolah
  - Pengaturan warna tema (primer & sekunder)
  - Tampilkan/sembunyikan riwayat nilai
- **Pengaturan Keamanan Ujian**:
  - Kode Rahasia (Exam Code) - siswa wajib masukkan kode
  - Batasan IP Address - hanya IP tertentu yang bisa akses
  - Browser Lock - deteksi tab switching / copy-paste
  - Device Fingerprint - deteksi pergantian device/browser

### Siswa
- **Landing Page** dengan daftar ujian yang tersedia
  - Filter ujian berdasarkan status
  - Menampilkan **target ketuntasan** tiap ujian
  - Tampilan responsif dan informatif
- **Ulangan Sampai Tuntas**: jika nilai belum mencapai target, tampil tombol **Ulangi Ulangan** (soal diacak ulang)
- **Riwayat Nilai**: status TUNTAS/BELUM TUNTAS, nilai terbaik, dan jumlah percobaan
- **Verifikasi Kode Rahasia** sebelum ujian (jika diaktifkan)
- **Input Identitas** (NIS, Nama, Kelas) sebelum mulai
- **Sistem Ujian Interaktif** dengan timer countdown
  - 1 soal per halaman (load cepat)
  - Navigasi grid nomor soal (lompat ke soal tertentu)
  - Indicator warna: abu (belum), hijau (dijawab), biru (aktif)
  - Previous/Next button untuk navigasi
  - Auto-save jawaban setiap 30 detik (background)
  - Load jawaban tersimpan jika refresh/halaman crash
  - Dukungan soal essay (isian singkat)
- **Review Jawaban** setelah submit (jika diaktifkan guru)
  - Lihat soal, jawaban siswa, dan kunci jawaban
  - Tampilkan skor per soal
- **Cek Riwayat Nilai** berdasarkan NIS
  - Lihat history semua ujian yang sudah dikerjakan
  - Detail nilai dan skor

### Keamanan
- **CSRF Protection** untuk semua API endpoint
- **Pengecekan Ganda** agar siswa tidak mengerjakan dua kali
- **Auto-submit** jika pelanggaran browser melebihi batas
- **Log Pelanggaran** tab switching dengan detail waktu
- **Race Condition Protection** mencegah double submission saat submit bersamaan
- **Transaksi Database dengan Locking** untuk integritas data
- **Temporary Table** untuk auto-save tanpa mempengaruhi data final
- **Device Fingerprinting** mendeteksi pergantian perangkat
- **IP Address Validation** membatasi akses dari IP tertentu

### Performa
- Mobile-first design untuk load cepat di HP
- Pagination 1 soal per halaman (mengurangi beban server)
- Render JavaScript yang dioptimasi (lazy loading)
- Inisialisasi token di background (tidak blocking UI)
- Database indexes untuk query cepat
- JSON-based answer storage (efisien untuk jawaban kompleks)
- Session-less design (menggunakan token-based authentication)

---

## Requirements

- **PHP 8.0+** (direkomendasikan 8.2)
- **MySQL 8.0+** atau MariaDB 10.4+
- **Web Server**: Apache/Nginx (atau gunakan Podman)
- **Podman** (opsional, direkomendasikan untuk development)

---

## Struktur Direktori

```
ulangan_tuntas/
├── admin/                      # Panel admin
│   ├── index.php              # Dashboard admin
│   ├── login.php              # Login admin
│   ├── logout.php             # Logout admin
│   ├── tambah_soal.php        # Tambah/edit soal (dropdown kategori: Mudah/Sedang/Sulit)
│   ├── manage_users.php        # Manajemen pengguna
│   ├── rekap_nilai.php         # Rekap nilai & ekspor
│   ├── monitor_ujian.php       # Monitor ujian real-time
│   ├── profil_sekolah.php      # Pengaturan profil sekolah
│   ├── analytics.php           # Analytics Dashboard (NEW: analisis butir soal, distribusi grade dinamis)
│   ├── import_soal.php         # Import soal dari Excel/CSV (template: kategori Mudah/Sedang/Sulit)
│   ├── ekspor_excel.php        # Ekspor nilai ke Excel
│   ├── ekspor_soal_pdf.php     # Ekspor soal ke PDF
│   └── download_template.php   # Download template import
├── api/                        # API endpoint
│   ├── index.php               # API router
│   └── submit_jawaban.php      # Submit jawaban siswa
├── config/                     # Konfigurasi
│   ├── database.php            # Konfigurasi database
│   ├── init_sekolah.php        # Inisialisasi sekolah & tabel (termasuk kolom tuntas)
│   ├── tuntas.php              # Logika "Ulangan Sampai Tuntas" (hitung nilai, percobaan, status)
│   └── db_helper.php           # Database helper functions (fetchAllPrepared, fetchRowPrepared)
├── vendor/                     # Library (Bootstrap, Bootstrap Icons)
├── uploads/                    # File upload (logo, gambar soal)
├── migrations/                 # Database migrations
│   ├── 06_performance_indexes.sql
│   ├── 07_add_kategori_timer_soal.sql
│   └── 09_ulangan_tuntas.sql   # Kolom target_nilai/wajib_tuntas + tabel percobaan_ujian
├── backup_db/                  # Database backup
│   └── ujian_online.sql       # Full database backup
├── index.php                   # Landing page (list ujian)
├── ujian.php                   # Halaman ujian siswa
├── review.php                  # Review jawaban setelah submit
├── riwayat.php                 # Riwayat nilai siswa
├── docker-compose.yml          # Konfigurasi Podman
└── README.md                   # Dokumentasi ini
```

---

## Skema Database (Fitur Tuntas)

Fitur "ulangan sampai tuntas" menambahkan:

**Kolom baru pada tabel `ujian`:**

| Kolom | Tipe | Default | Keterangan |
|-------|------|---------|------------|
| `target_nilai` | DECIMAL(5,2) | 75.00 | Nilai minimal agar dinyatakan tuntas |
| `wajib_tuntas` | ENUM('ya','tidak') | 'ya' | Jika `ya`, siswa wajib mengulang sampai mencapai target |

**Tabel baru `percobaan_ujian`** (mencatat setiap percobaan, tidak menimpa yang lama):

| Kolom | Tipe | Keterangan |
|-------|------|------------|
| `id` | INT PK | |
| `id_ujian` | INT | FK ke `ujian` |
| `nis`, `nama`, `kelas` | | Identitas siswa |
| `percobaan_ke` | INT | Urutan percobaan (1, 2, 3, ...) |
| `total_skor` | INT | Skor mentah percobaan ini |
| `total_poin_maks` | INT | Total poin maksimal ujian |
| `nilai` | DECIMAL(5,2) | Persentase nilai percobaan ini |
| `jumlah_benar`, `jumlah_soal` | INT | Ringkasan jawaban |
| `tuntas` | TINYINT(1) | 1 bila nilai >= target |
| `detail_jawaban` | LONGTEXT | JSON detail jawaban |
| `waktu_submit` | DATETIME | Waktu submit |

> Tabel `hasil_ujian` (dipakai fitur lain: rekap, analytics, monitor) tetap ada dan menyimpan **percobaan terbaik** per `(id_ujian, nis)`. Jadi nilai yang tampil di rekap = nilai tertinggi.

Kolom & tabel ini dibuat **otomatis** oleh `config/init_sekolah.php` saat aplikasi dijalankan. Untuk setup manual, gunakan `migrations/09_ulangan_tuntas.sql`.

---

## Cara Install

### ⭐ Cara Termudah: Podman (Rekomendasi)

Tidak perlu install PHP, MySQL, atau Apache. Cukup jalankan 3 perintah.

#### Yang Perlu Disiapkan

| Tools | Download |
|-------|----------|
| **Podman** | https://podman.io/getting-started/installation |
| **Git** (opsional) | https://git-scm.com/downloads |

#### Langkah 1: Clone atau Download

```bash
git clone https://github.com/natedekaka/ulangan_tuntas.git
cd ulangan_tuntas
```

Atau download ZIP dari https://github.com/natedekaka/ulangan_tuntas, ekstrak, lalu buka terminal di folder `ulangan_tuntas`.

#### Langkah 2: Jalankan Aplikasi

```bash
podman compose up -d
```

Tunggu 1-2 menit sampai semua container siap.

#### Langkah 3: Setup Database (OTOMATIS)

✅ **Tidak perlu buat database manual!** Cukup import lewat phpMyAdmin:

> 💡 **Tips biar cepat:** File SQL bisa di-zip dulu sebelum import. phpMyAdmin bisa baca file `.zip` atau `.gz` langsung!

1. **Compress file** (opsional — tapi bikin import jauh lebih cepat):
   ```bash
   gzip -k backup_db/ujian_online.sql
   #   backup_db/ujian_online.sql.gz  (ukuran ~160KB dari ~2.8MB)
   ```
2. Buka http://localhost:9026
3. Login phpMyAdmin:
   - **Server**: `db`
   - **Username**: `root`  
   - **Password**: `rootpass`
4. Di panel kiri, klik **`ujian_online`**
5. Klik tab **"Import"** di menu atas
6. Klik **"Choose File"**, pilih file:
   - **Biasa**: `backup_db/ujian_online.sql`
   - **Lebih cepat**: `backup_db/ujian_online.sql.gz` (compress dulu)
7. Scroll ke bawah, klik **"Go"**
8. ✅ Selesai! Semua tabel terbuat otomatis.

> 🔥 **Sudah termasuk data contoh**: admin, ujian, soal, dan siswa bisa langsung dipakai.

#### Langkah 4: Akses Aplikasi

| Halaman | URL | Login |
|---------|-----|-------|
| **Aplikasi Utama** | http://localhost:9327 | - |
| **Admin Panel** | http://localhost:9327/admin/login.php | `admin` / `admin123` |
| **phpMyAdmin** | http://localhost:9026 | root / rootpass |

#### Langkah 5: Ganti Password Admin

Login admin → klik **Manajemen User** → ganti password `admin123`.

---

### ⚙️ Cara Manual (XAMPP / LAMP / Laragon)

Untuk yang sudah punya web server sendiri.

#### Langkah 1: Letakkan File

| OS | Folder |
|----|--------|
| **Windows (XAMPP)** | `C:\xampp\htdocs\exam6` |
| **Windows (Laragon)** | `C:\laragon\www\exam6` |
| **Linux (LAMP)** | `/var/www/html/exam6` |

Bisa dengan git clone atau download ZIP dan ekstrak ke folder di atas.

#### Langkah 2: Setup Database (via phpMyAdmin)

1. **Buka** http://localhost/phpmyadmin
2. Klik tab **"Databases"** di menu atas
3. **Buat database baru**:
   - Nama: `ujian_online`
   - Collation: `utf8mb4_general_ci`
   - Klik **"Create"**
4. **Klik database** `ujian_online` di panel kiri
5. Klik tab **"Import"** di menu atas
6. Klik **"Choose File"** → pilih file:
   - **Biasa**: `backup_db/ujian_online.sql`
   - **Lebih cepat**: `backup_db/ujian_online.sql.gz` (compress dulu: `gzip -k backup_db/ujian_online.sql`)
7. Scroll ke bawah, klik **"Go"**
8. ✅ Database siap!

> ⚠️ **Error "database exists"?** Lewati langkah 3, langsung klik database `ujian_online` di panel kiri.

#### Langkah 3: Konfigurasi Koneksi Database

Buka file `config/database.php`, sesuaikan bagian ini:

```php
// XAMPP default (tinggal copas):
$host = 'localhost';
$user = 'root';
$password = '';           // XAMPP: kosong
$database = 'ujian_online';
$port = '3306';
```

| Software | Username | Password |
|----------|----------|----------|
| **XAMPP** | `root` | `(kosong)` |
| **Laragon** | `root` | `(kosong)` |
| **LAMP Ubuntu** | `root` | `(password MySQL Anda)` |
| **MAMP** | `root` | `root` |

#### Langkah 4: Permission Folder

**Linux/Mac:**
```bash
chmod -R 777 exam6/uploads/
```

**Windows:** Tidak perlu setting apa-apa.

#### Langkah 5: Akses Aplikasi

Buka browser: **http://localhost/exam6**

Login admin: http://localhost/exam6/admin/login.php → `admin` / `admin123`

---

### 🔧 Setup Database via Command Line (Alternatif)

Buat yang lebih suka terminal:

#### Via Podman (langsung ke container MySQL — paling cepat)
```bash
# Import database langsung ke container (beberapa detik, tidak lewat browser)
podman exec -i exam6-db mysql -uroot -prootpass ujian_online < backup_db/ujian_online.sql
```

> ⚠️ Kalau error `Warning` di baris pertama SQL, buka file `backup_db/ujian_online.sql` dan hapus baris pertama yang diawali `mysqldump: [Warning]`.

#### Via XAMPP / MySQL langsung

**Langkah 1: Masuk ke MySQL**
```bash
# XAMPP (Windows)
"C:\xampp\mysql\bin\mysql.exe" -u root

# Linux/Mac
mysql -u root -p
```

**Langkah 2: Buat database dan import**
```sql
-- Jalankan perintah ini satu per satu di MySQL:
CREATE DATABASE IF NOT EXISTS ujian_online CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ujian_online;
SOURCE lokasi_folder_exam6/backup_db/ujian_online.sql;
EXIT;
```

**Atau satu baris:**
```bash
# XAMPP (Windows):
"C:\xampp\mysql\bin\mysql.exe" -u root ujian_online < "C:\xampp\htdocs\exam6\backup_db\ujian_online.sql"

# Linux/Mac:
mysql -u root -p ujian_online < /var/www/html/exam6/backup_db/ujian_online.sql
```

---

### ✅ Verifikasi Instalasi

Setelah semua langkah di atas:

1. **Buka** http://localhost:9327 (Podman) atau http://localhost/exam6 (Manual)
2. **Login admin**: http://localhost:9327/admin/login.php — `admin` / `admin123`
3. Di dashboard, klik **"Manajemen Ujian"** — seharusnya sudah ada ujian contoh
4. Klik **"Soal"** pada salah satu ujian — seharusnya sudah ada soal
5. Buka tab baru, buka http://localhost:9327 — lihat daftar ujian yang tersedia
6. Klik **"Mulai Ujian"** pada salah satu ujian, isi identitas contoh, dan coba kerjakan

> ❓ **Udah login tapi error?** Cek kembali langkah import database. Pastikan file `backup_db/ujian_online.sql` sudah diimport dengan benar.

---

## Cara Penggunaan

### Admin

#### 1. Login Admin
- Buka `/admin/login.php`
- Masukkan username: `admin`, password: `admin123`
- ⚠️ Segera ganti password setelah login pertama

#### 2. Pengaturan Profil Sekolah
- Dashboard → **Profil Sekolah**
- Isi nama sekolah
- Upload logo sekolah (format: PNG/JPG, max 2MB)
- Atur warna primer dan sekunder (untuk tema aplikasi)
- Pilih apakah riwayat nilai ditampilkan untuk siswa

#### 3. Manajemen Ujian
- Dashboard → **Manajemen Ujian** → **Tambah Ujian**
- Isi form:
  - **Judul Ujian**: Nama ujian yang akan ditampilkan
  - **Deskripsi**: Keterangan tambahan (opsional)
  - **Durasi**: Waktu pengerjaan dalam menit
  - **Status**: Aktif/Nonaktif
  - **Acak Soal**: Ya/Tidak (soal akan diacak per siswa)
  - **Tampilkan Review**: Izinkan siswa melihat review setelah submit
  - **Target Tuntas (KKM)**: Nilai minimal agar siswa dinyatakan tuntas (default 75)
  - **Wajib Tuntas**: `Ya` = siswa wajib mengulang sampai mencapai target; `Tidak` = cukup sekali mengerjakan
  - **Acak Opsi**: Ya (disarankan) agar pilihan jawaban ikut diacak ulang tiap percobaan
  
- **Pengaturan Keamanan** (di form ujian):
  - **Kode Ujian**: Kode rahasia yang harus dimasukkan siswa
  - **Batasan IP**: Batasi akses dari IP tertentu (pisahkan dengan koma)
  - **Browser Lock**: Deteksi tab switching (auto-submit setelah X pelanggaran)
  - **Device Fingerprint**: Deteksi pergantian device/browser

#### 4. Mengelola Soal
- Di daftar ujian, klik tombol **"Soal"** pada ujian tertentu
- **Tambah Soal**:
  - Isi teks soal (mendukung HTML)
  - Upload gambar soal (opsional)
  - Tambah pilihan jawaban (A, B, C, D, E)
  - Pilih kunci jawaban benar
  - Isi poin soal
  - **Kategori soal**: Pilih dari dropdown (Mudah/Sedang/Sulit) atau kosongkan untuk auto-kategorisasi
  - Timer per soal (opsional, dalam detik)
  
- **Edit/Hapus Soal**: Klik tombol edit/hapus pada daftar soal

- **Import Soal Massal**:
  1. Klik menu **"Import Massal"**
  2. Download template CSV terlebih dahulu
  3. Isi template dengan data soal (kolom kategori: Mudah/Sedang/Sulit)
  4. Upload file CSV
  5. Sistem akan validasi otomatis

- **Ekspor Soal ke PDF**:
  - Klik menu **"Ekspor PDF"**
  - Pilih ujian yang ingin diekspor
  - Download PDF lengkap dengan kunci jawaban

#### 5. Monitor Ujian Real-time
- Dashboard → **Monitor Ujian**
- Pilih ujian yang sedang berlangsung
- Lihat daftar siswa yang sedang mengerjakan:
  - NIS, Nama, Kelas
  - Progress (soal ke berapa dari total)
  - Waktu mulai dan status
  - IP Address dan device info
  
- **Aksi yang tersedia**:
  - **Reset Ujian Siswa**: Hapus hasil ujian agar siswa bisa mengerjakan ulang
  - **Hapus dari Progress**: Hapus siswa dari daftar yang sedang ujian
  - **Lihat Pelanggaran**: Cek tab switching/device change

#### 6. Rekap Nilai
- Dashboard → **Rekap Nilai**
- Pilih ujian yang ingin direkap
- Lihat tabel nilai:
  - NIS, Nama, Kelas
  - Skor total dan persentase
  - Waktu submit
  - Status kelulusan
  
- **Ekspor ke Excel**:
  - Klik tombol "Ekspor Excel"
  - File Excel akan diunduh dengan format rapi
  - Berisi semua detail jawaban per siswa

#### 7. Analytics Dashboard (NEW)
- Dashboard → **Analytics Dashboard**
- Pilih ujian yang ingin dianalisis
- Atur KKM (Kriteria Ketuntasan Minimal) - default 75
- **Fitur Analytics**:
  - **Summary Statistics**: Total peserta, rata-rata skor, completion rate
  - **Distribusi Grade Dinamis** (berdasarkan KKM):
    - Grade A: Score ≥ (KKM + 17) → Sangat Baik
    - Grade B: Score ≥ (KKM + 9) → Baik
    - Grade C: Score ≥ KKM → Cukup (Tuntas)
    - Grade D: Score < KKM → Perlu Bimbingan (Belum Tuntas)
  - **Analisis Butir Soal** (Top 20 terburuk):
    - Question ID, Category (Mudah/Sedang/Sulit)
    - Success rate, correct count, average poin
    - Kategori otomatis berdasarkan tingkat keberhasilan
  - **Top Scorers**: 10 siswa dengan nilai tertinggi
  - **Students Needing Remedial**: Siswa dengan skor < KKM
  - **Visualisasi Grafik** (Chart.js):
    - Grade Distribution Chart
    - Score Distribution Chart
    - Question Analysis Chart (horizontal bar)
  - **Export ke Excel**: Download laporan lengkap (.xls) kompatibel LibreOffice/WPS Office

---

### Siswa

#### 1. Akses Halaman Ujian
- Buka landing page aplikasi (http://localhost:9327)
- Lihat daftar ujian yang tersedia (status: Aktif)
- Klik **"Kerjakan"** pada ujian yang diinginkan

#### 2. Verifikasi Kode Rahasia (jika diaktifkan)
- Masukkan kode rahasia yang diberikan guru
- Klik **"Verifikasi"**
- Jika kode salah, akan diminta ulang

#### 3. Isi Identitas
- Masukkan **NIS** (Nomor Induk Siswa)
- Masukkan **Nama Lengkap**
- Pilih **Kelas**
- Klik **"Mulai Ujian"**

#### 4. Mengerjakan Soal
- Soal ditampilkan 1 per 1 halaman
- Navigasi menggunakan:
  - **Previous/Next button** di bawah soal
  - **Grid nomor** di sidebar (klik untuk lompat ke soal tertentu)
  
- **Indicator warna**:
  - 🔵 **Biru**: Soal yang sedang dikerjakan
  - 🟢 **Hijau**: Soal sudah dijawab
  - ⚪ **Abu-abu**: Soal belum dijawab
  
- **Timer** akan berjalan di pojok kanan atas
- Jawaban **auto-save** setiap 30 detik (jika koneksi bermasalah, jawaban tetap tersimpan)
- Jika halaman refresh/crash, jawaban sebelumnya akan dimuat otomatis

#### 5. Submit Jawaban
- Setelah semua soal dijawab, klik **"Kirim Jawaban"**
- Konfirmasi pengiriman (pastikan semua soal sudah dijawab)
- Nilai akan muncul langsung setelah submit

#### 6. Review Jawaban (jika diaktifkan guru)
- Setelah submit, klik **"Lihat Review"**
- Lihat soal, jawaban Anda, dan kunci jawaban benar
- Tampilkan skor per soal

#### 7. Cek Riwayat Nilai
- Klik menu **"Riwayat Nilai"** di landing page
- Masukkan **NIS**
- Lihat history semua ujian yang sudah dikerjakan
- Klik detail untuk melihat breakdown nilai

---

## Pengaturan Keamanan Ujian

Saat membuat/mengedit ujian di admin, tersedia pengaturan keamanan:

| Fitur | Deskripsi | Rekomendasi |
|-------|-----------|-------------|
| **Kode Ujian** | Kode rahasia yang harus dimasukkan siswa untuk mengakses ujian | Aktifkan untuk ujian penting |
| **Batasan IP** | Batasi akses ujian hanya dari IP tertentu (pisahkan dengan koma) | Gunakan untuk ujian di lab sekolah |
| **Browser Lock** | Deteksi jika siswa switch tab/copy-paste. Akan melakukan auto-submit setelah X pelanggaran | Aktifkan untuk ujian bersifat formal |
| **Device Fingerprint** | Deteksi jika siswa ganti device/browser di tengah ujian | Aktifkan untuk mencegah kecurangan |

**Contoh pengaturan:**
```
Kode Ujian: UJIAN2024
Batasan IP: 192.168.1.10, 192.168.1.11, 192.168.1.12
Browser Lock: 3 pelanggaran (auto-submit)
Device Fingerprint: Aktif
```

---

## Alur Ujian

1. **Halaman Utama**: Siswa melihat list ujian yang tersedia
2. **Input Kode** (jika diperlukan): Masukkan kode rahasia
3. **Identitas**: Isi NIS, Nama, Kelas → klik "Mulai Ujian"
4. **Soal**: Jawab 1 soal per halaman dengan navigasi:
   - Previous/Next button
   - Grid nomor soal untuk lompat ke soal tertentu
   - Indicator warna: abu (belum), hijau (dijawab), biru (aktif)
5. **Submit**: Klik "Kirim Jawaban" jika sudah selesai
6. **Hasil**: Lihat skor langsung
7. **Review** (opsional): Lihat detail jawaban dan kunci

---

## Akun Default

| Role | Username | Password | Keterangan |
|------|----------|----------|------------|
| Admin | `admin` | `admin123` | Segera ganti setelah login pertama |

> ⚠️ **Penting**: Untuk keamanan, segera ubah password default admin. Saat ini fitur manajemen user belum tersedia di panel admin (dalam pengembangan).

---

## Teknologi

- **Frontend**: 
  - Bootstrap 5 (CSS Framework)
  - Bootstrap Icons (Icon library)
  - Vanilla JavaScript (ES6+)
  - Google Fonts (Inter)
  - Chart.js 4.4.1 (Data visualization)
  
- **Backend**: 
  - PHP 8.2 Native (tanpa framework)
  - MySQL 8.0 (database)
  - JSON untuk penyimpanan jawaban
  
- **Container**: 
  - Podman
  - PHP 8.2 Apache image
  - MySQL 8.0 image
  - phpMyAdmin latest

- **Tools**:
  - Composer (opsional, untuk pengembangan)
  - Git untuk version control

---

## Troubleshooting

### 1. Error: "Koneksi database gagal"
- **Penyebab paling umum**: Database belum dibuat atau file SQL belum diimport
- Cek konfigurasi di `config/database.php`:
  ```php
  // XAMPP: password kosong, host localhost
  // Podman: host = db, password = rootpass
  ```
- Untuk Podman: pastikan container `exam6-db` sudah running (`podman ps`)
- Coba akses phpMyAdmin untuk pastikan database `ujian_online` ada dan berisi tabel

### 2. Error "Table 'ujian_online.ujian' doesn't exist" atau tabel tidak ditemukan
- **Penyebab**: File `backup_db/ujian_online.sql` belum diimport
- Solusi: Ikuti langkah import database di atas (bagian Setup Database)
- Untuk Podman via phpMyAdmin: http://localhost:9026 → login → pilih `ujian_online` → Import
- Untuk XAMPP via phpMyAdmin: http://localhost/phpmyadmin → Import

### 3. Gambar soal tidak muncul
- Pastikan folder `uploads/` memiliki permission 777 (Linux/Mac)
- Cek apakah file gambar ada di folder `uploads/`

### 4. Auto-save tidak berfungsi
- Pastikan JavaScript tidak diblokir browser
- Cek console browser (F12) untuk error

### 5. Siswa tidak bisa submit
- Cek apakah ada pelanggaran browser lock (terlalu sering tab switch)
- Cek apakah siswa sudah pernah submit sebelumnya (butuh izin remedial dari admin)

### 6. Container tidak bisa start
```bash
# Cek logs
podman logs exam6-app
podman logs exam6-db

# Restart containers
podman compose down
podman compose up -d
```

### 7. Database error setelah update
```bash
# Jalankan migration terbaru (jika ada file baru di migrations/)
# Lewat phpMyAdmin: buka database ujian_online → SQL → paste isi file migration
# Atau command line:
mysql -u root -p ujian_online < migrations/08_increase_max_violations.sql
```

---

## Lisensi

MIT License

Copyright (c) 2026 Exam6 - Sistem Ujian Online

Dibenarkan untuk menggunakan, memodifikasi, dan mendistribusikan aplikasi ini dengan atau tanpa modifikasi untuk keperluan komersial maupun non-komersial.

---

## Kontribusi

Kontribusi selalu diterima! Silakan:
1. Fork repository ini
2. Buat branch fitur (`git checkout -b fitur/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin fitur/AmazingFeature`)
5. Buat Pull Request

---

## Kontak & Support

- **Repository**: https://github.com/natedekaka/ulangan_tuntas
- **Issues**: https://github.com/natedekaka/ulangan_tuntas/issues
- **Email**: natedekaka@gmail.com

---

**Dibuat dengan ❤️ untuk dunia pendidikan Indonesia spesial sman6cimahi**
