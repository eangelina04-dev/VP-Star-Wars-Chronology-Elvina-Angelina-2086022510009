# Struktur Proyek

Dokumen ini menjelaskan bagaimana kode di app **Star Wars Chronology** dipisah, dan alasan di balik pilihan foldernya.

## Ide Utamanya

Setiap file diletakkan berdasarkan **tugasnya**. Pertanyaan yang dipakai setiap kali membuat file baru:

1. Apakah ini dipakai di seluruh app? Masukkan ke `core/`.
2. Apakah ini khusus untuk satu feature? Masukkan ke `features/<nama_feature>/`.
3. Di dalam feature, apakah ini data, aturan, atau tampilan? Pilih `data/`, `domain/`, atau `presentation/`.

Dengan cara ini, saat ingin mengubah sesuatu, saya tahu persis harus membuka folder mana.

## Peta Folder

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   └── app_name.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       └── brand_app_bar.dart
└── features/
    └── timeline/
        ├── data/
        │   └── timeline_data.dart
        ├── domain/
        │   ├── era.dart
        │   ├── timeline_entry.dart
        │   ├── timeline_filter.dart
        │   └── era_summary.dart
        └── presentation/
            ├── state/
            │   ├── favorites_controller.dart
            │   └── favorites_scope.dart
            ├── widgets/
            │   └── detail_placeholder.dart
            │   └── empty_results_view.dart
            │   └── era_card.dart
            │   └── era_filter_chips.dart
            │   └── era_grid.dart
            │   └── era_header.dart
            │   └── timeline_detail_body.dart
            │   └── timeline_entry_card.dart
            │   └── timeline_list.dart
            │   └── timeline_search_field.dart
            └── era_screen.dart
            └── home_shell.dart
            └── saved_screen.dart
            └── timeline_detail_screen.dart
            └── timeline_screen.dart
            
test/
└── era_summary_test.dart
```

## Penjelasan Tiap Folder

### `main.dart` dan `app.dart`

- `main.dart` hanya menjalankan app dan mematikan pengunduhan font lewat internet.
- `app.dart` berisi `MaterialApp`: memasang theme terang dan gelap, lalu menentukan screen pertama.

Keduanya sengaja dibuat pendek supaya mudah dibaca.

### `core/` (kode yang dipakai bersama)

Aturannya ketat: **hanya kode yang benar-benar dipakai di banyak tempat**. Kalau sebuah file hanya dipakai satu feature, tempatnya bukan di sini.

| Folder | Isi | Kenapa di sini |
|---|---|---|
| `constants/` | Nama app | Dipakai di banyak tempat |
| `theme/` | Warna, font, dan gaya komponen (tema terang dan gelap) | Semua screen memakai theme yang sama |
| `widgets/` | `BrandAppBar` | Dipakai di semua screen |

Theme ada di satu tempat supaya kode di `features/` tidak perlu menulis warna atau ukuran font sendiri. Kalau mau mengganti warna aksen, cukup ubah satu file.

### `features/timeline/` (semua hal tentang linimasa)

Feature ini dibagi tiga lapis.

#### `data/` (isi konten)

Berisi daftar event Star Wars: judul, tahun, era, dan summary. Widget tidak menyimpan teks sendiri, jadi kalau ada kalimat yang perlu diperbaiki (misalnya bahasa yang tercampur), saya hanya membuka folder ini.

#### `domain/` (aturan dan bentuk data)

Berisi bentuk data dan logika murni yang tidak menyentuh tampilan:

- `Era` dan `TimelineEntry`: model data.
- Fungsi filter dan pengelompokan (`filterEntries`, `groupByEra`): mencari dan mengelompokkan event.
- `summarizeEras`: menghitung jumlah event dan rentang tahun tiap era.

Karena tidak ada kode tampilan di sini, bagian ini mudah dites. Itulah sebabnya ada `test/era_summary_test.dart`.

#### `presentation/` (tampilan dan state)

- **Screen:** `HomeShell` (navigasi bawah atau samping), `EraScreen` (Home), `TimelineScreen` (Explore), screen Detail, dan `SavedScreen`.
- **`widgets/`:** potongan tampilan kecil yang dipakai ulang, seperti `EraCard`, `EraGrid`, `TimelineEntryCard`, `TimelineList`, chip era, `DetailPlaceholder`, dan `TimelineDetailBody`.
- **`state/`:** `FavoritesController` menyimpan daftar favorit, dan `FavoritesScope` membagikannya ke semua screen.

Widget dipecah kecil supaya setiap file pendek dan satu widget bisa dipakai di beberapa screen. Contohnya `TimelineEntryCard` dipakai di Explore dan di Saved.

### `test/`

Berisi test untuk logika di `domain/`. Dijalankan dengan `flutter test`.

## Arah Ketergantungan

Aturan sederhananya: **lapisan atas boleh memakai lapisan bawah, tidak sebaliknya.**

```
presentation  →  domain  ←  data
      ↓
    core
```

- `presentation` boleh memakai `domain` dan `core`.
- `domain` tidak boleh mengimpor apa pun dari `presentation`.
- `core` tidak boleh mengimpor apa pun dari `features`.

Aturan ini mencegah kode saling terikat, sehingga mengubah tampilan tidak merusak logika dan sebaliknya.

## Konvensi

- **Nama file:** `snake_case.dart` (contoh: `timeline_entry_card.dart`).
- **Nama class:** `PascalCase` (contoh: `TimelineEntryCard`).
- **Nama variabel dan fungsi:** `camelCase` (contoh: `filterEntries`).
- **Anggota private:** diawali garis bawah (contoh: `_selectedEra`).
- **Panjang file:** usahakan di bawah sekitar 200 baris. Kalau lebih, pecah menjadi widget atau file lebih kecil.
- **Warna dan ukuran font:** tidak boleh ditulis langsung di folder `features/`. Ambil dari theme.
- **Commit message:** Conventional Commits dalam bahasa Inggris (`feat:`, `fix:`, `docs:`, `test:`, `chore:`, `refactor:`).

## Contoh Alur: Menambah Event Baru

1. Tambahkan datanya di `data/timeline_data.dart`.
2. Selesai. Kartu, pencarian, filter era, dan jumlah event di Home otomatis ikut berubah karena semuanya membaca dari data yang sama.

## Contoh Alur: Menambah Feature Baru

Misalnya feature "Characters":

1. Buat folder `features/characters/` dengan `data/`, `domain/`, dan `presentation/`.
2. Pakai ulang `BrandAppBar` dan theme dari `core/`.
3. Daftarkan screen barunya di navigasi.

Tidak ada kode `timeline` yang perlu diubah.