# Responsive Matrix: Star Wars Chronology

Layar yang diuji: **Timeline** (daftar peristiwa), **Detail** (isi satu peristiwa), dan **Empty state** (hasil pencarian kosong).

---

## Tes 1: HP kecil (320 dp)

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Semua elemen muat di lebar 320 dp, tanpa garis kuning dan tanpa teks terpotong | pass | Tidak ada perbaikan. Teks kartu sudah dibungkus `Expanded`, jadi hanya memakai sisa lebar di sebelah tombol bintang. |
| Detail | Judul dan ringkasan muat, isi bisa digulir | pass | Tidak ada perbaikan. Isi sudah dibungkus `SingleChildScrollView`. |
| Empty state | Ikon, judul, dan pesan muat di lebar 320 dp | pass | Tidak ada perbaikan. |

## Tes 2: HP besar (430 dp)

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Tampilan rapi dan nyaman dibaca | pass | Tidak ada perbaikan. Satu kolom kartu sudah pas. |
| Detail | Tampilan rapi dan nyaman dibaca | pass | Tidak ada perbaikan. |
| Empty state | Isi tampil rapi di tengah layar | pass | Tidak ada perbaikan. |

## Tes 3: Tablet (800 dp)

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Layout harus berubah, bukan hanya melebar | fail | Kartu hanya melebar sampai 800 dp dan teksnya jadi sangat panjang. Ditambah `LayoutBuilder` dengan batas 720 dp. Di bawah 720 dp tetap satu kolom. Di atasnya jadi dua panel: daftar di kiri (lebar 380 dp), detail di kanan. Kartu yang sedang dipilih diberi garis tepi. |
| Detail | Layout harus berubah, bukan hanya melebar | fail | Teks detail melebar penuh sehingga sulit dibaca. Isi detail dipisah ke widget `TimelineDetailBody` yang dipakai di layar HP dan di panel kanan tablet. Lebar teks dibatasi maksimal 640 dp. |
| Empty state | Tidak ada panel yang kosong tanpa petunjuk | pass | Tampilan awal sudah baik. Setelah layout dua panel dibuat, panel kanan diberi petunjuk "Pilih peristiwa untuk melihat detail" agar tidak kosong saat hasil pencarian nol. |

## Tes 4: Landscape

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Tidak ada overflow atau konten terpotong saat 320, 430, dan 800 diputar | fail | Di HP 320 landscape, AppBar 88 dp (dengan logo), kolom cari, dan chip memakan hampir seluruh tinggi, sehingga daftar hanya tersisa sekitar 88 dp dan kartu terpotong. Ditambah mode ringkas: kalau tinggi layar kurang dari 500 dp, logo disembunyikan dan AppBar dipendekkan jadi 56 dp. Layar landscape dengan lebar 720 dp ke atas otomatis memakai dua panel. |
| Detail | Konten tetap terbaca penuh | pass | Tidak ada perbaikan. Isi bisa digulir, jadi tinggi pendek tidak memotong teks. |
| Empty state | Tidak overflow di layar pendek | fail | Ikon, teks, dan tombol ditumpuk dalam `Column` biasa yang tidak bisa digulir, sehingga muncul overflow di bawah. Empty state dipindah ke `SliverFillRemaining(hasScrollBody: false)`, jadi kalau layar terlalu pendek isinya bisa digulir. |

## Tes 5: Teks panjang (200 karakter)

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Nama peristiwa 200 karakter tidak membuat overflow | pass | Judul sudah dibatasi 2 baris dan ringkasan 3 baris, diakhiri titik-titik. Untuk memenuhi syarat soal, label tahun dan nama era juga diberi `maxLines: 1` dan `overflow: ellipsis`. |
| Detail | Judul panjang tidak merusak layout | pass | Isi detail memang boleh panjang karena bisa digulir. Judul di AppBar diberi `maxLines: 1` dan titik-titik. |
| Empty state | Pesan panjang tidak overflow | pass | Tidak ada perbaikan. Teks sudah di tengah dan membungkus otomatis. |

## Tes 6: Empty state (nol item)

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Empty state | Ada ikon, pesan, dan tombol aksi, bukan layar kosong | fail | Ikon dan pesan sudah ada, tetapi belum ada tombol aksi. Ditambah tombol "Reset pencarian & filter" (parameter baru `actionLabel` dan `onAction`). Tombol menghapus teks pencarian, filter era, dan filter favorit. Kolom cari diberi `TextEditingController` agar teksnya ikut terhapus. |

## Tes 7: Daftar panjang (500 item)

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Daftar memakai `.builder` dan tidak memakai `shrinkWrap: true` | pass | Tidak ada perbaikan. Sudah memakai `ListView.builder`. Setelah kolom cari dipindah ke dalam area gulir, daftar memakai `SliverList.builder` yang bekerja dengan cara sama: item hanya dibuat saat terlihat. Diuji dengan data uji 500 item (`--dart-define=STRESS=true`). |

## Tes 8: Keyboard

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Kolom cari tetap terlihat saat keyboard terbuka di layar pendek | fail | Kolom cari, chip, dan daftar ada dalam satu `Column`. Saat keyboard muncul di layar pendek, tinggi tersisa lebih kecil dari tinggi kolom cari dan chip, sehingga overflow di bawah. Kolom cari dan chip dipindah ke dalam `CustomScrollView` sebagai `SliverToBoxAdapter`, jadi seluruh halaman bisa digulir dan tidak ada yang overflow. |
| Empty state | Tombol aksi tetap bisa dijangkau saat keyboard terbuka | fail | Penyebabnya sama dengan tes landscape: isi tidak bisa digulir. Diperbaiki dengan `SliverFillRemaining(hasScrollBody: false)` agar isinya ikut bisa digulir. |

## Tes 9: Dark mode

| Layar | Test | Status | Fixed notes |
|---|---|---|---|
| Timeline | Teks dan elemen tetap terbaca | pass | Aplikasi awalnya hanya memakai tema gelap, jadi sudah terbaca. Sebagai tambahan, dibuat tema terang (`AppTheme.light`) dengan aksen emas gelap `#8A6D00` karena kuning `#F5D547` hampir tidak terlihat di latar putih. Aplikasi mengikuti pengaturan sistem (`ThemeMode.system`), dan logo berganti otomatis sesuai tema. |
| Detail | Teks dan elemen tetap terbaca | pass | Tidak ada perbaikan. Semua warna diambil dari tema, bukan ditulis langsung di widget. |
| Empty state | Ikon dan teks tetap terbaca | pass | Tidak ada perbaikan. Ikon memakai warna `outline` dari tema, jadi kontras menyesuaikan otomatis. |

---

## Catatan pengujian

- Data uji: `flutter run -d chrome --dart-define=STRESS=true` (500 item, judul panjang tiap kelipatan 50).
- Ukuran diuji lewat DevTools Chrome: 320, 430, dan 800 dp, masing-masing portrait dan landscape.
- Tes keyboard disimulasikan dengan mengecilkan tinggi viewport, bukan memakai keyboard fisik.