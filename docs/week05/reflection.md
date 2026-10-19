# Refleksi Week 05

## 1. Keputusan struktur dari Week 1 mana yang paling membantu sampai Week 5?

Dua keputusan yang paling terasa manfaatnya.

**Memisahkan `core/` dari `features/`.** `core/` hanya berisi kode yang benar-benar dipakai bersama di seluruh app: theme, constants, dan `BrandAppBar`. Semua yang spesifik untuk timeline ada di `features/timeline/`. Dengan batas ini, saya selalu tahu file baru harus diletakkan di mana, dan bagian bersama seperti theme bisa diubah tanpa menyentuh kode feature.

**Memisahkan `data/` dari `presentation/`.** Semua konten (judul event, summary, nama era) ada di `data/`, sedangkan widget hanya menampilkannya. Ini sangat membantu saat saya sadar bahwa teks di app bercampur bahasa Inggris dan bahasa Indonesia. Memperbaikinya cukup dengan mengedit beberapa file di `data/`, tanpa mencari satu per satu di setiap widget. Pemisahan yang sama juga membuat dataset uji 500 item mudah ditambahkan, karena screen tidak perlu diubah.

## 2. Keputusan mana yang memakan waktu, dan apa yang akan kamu lakukan berbeda?

**Saved (starred) screen** adalah yang paling memakan waktu. Awalnya saya membuatnya sebagai bagian dari feature di dalam screen lain, bukan sebagai screen sendiri. Itu berjalan baik sampai saya membuat navigation, dan baru saat itu saya sadar bahwa Saved seharusnya menjadi destination tersendiri sejak awal. Saya lalu harus memindahkannya keluar, membuat screen sendiri, dan membuat state favorites bisa diakses oleh semua screen yang membutuhkannya.

Yang akan saya lakukan berbeda: sebelum menulis widget apa pun, saya akan mendaftar semua screen yang dibutuhkan app dan menggambar peta navigation sederhana (Home, Explore, Detail, Saved). Memutuskan "ini screen sendiri atau hanya bagian dari screen?" di awal akan menghindarkan saya dari pekerjaan ulang.

## 3. Di mana state app kamu sekarang, dan apa yang akan sulit saat memindahkannya di Module 2?

"State" adalah data yang bisa berubah saat app berjalan dan membuat UI ikut bereaksi. Di app saya, state saat ini ada di dua tempat:

- **Favorites:** sebuah `Set` berisi ID event di dalam `FavoritesController`, dibagikan lewat `FavoritesScope` (sebuah `InheritedNotifier`). Semua screen membacanya dari sana. State ini hanya disimpan di memori, jadi favorites hilang saat app ditutup.
- **State milik screen:** search query, chip era yang dipilih, entry yang dipilih (pada layout dua panel), dan flag loading berada di dalam `_TimelineScreenState` dan state milik `EraScreen`. Semuanya ter-reset setiap kali screen dibangun ulang.

Yang akan sulit di Module 2:

- **Persistence.** Favorites harus bertahan setelah app ditutup, artinya perlu menambahkan local storage dan memuatnya sebelum UI tampil.
- **Mengganti cara berbagi state buatan sendiri.** `FavoritesScope` adalah solusi yang saya tulis sendiri. Pindah ke pendekatan state management yang standar berarti menulis ulang cara setiap screen membaca dan mengubah favorites.
- **Memindahkan filter state keluar dari widget.** Search query dan era yang dipilih terikat pada satu screen. Kalau screen lain membutuhkannya, state itu harus diangkat ke state bersama.
- **Layout bergantung pada state.** Di layout lebar, mengetuk item mengubah entry yang dipilih di tempat, sedangkan di layout sempit mengetuk item membuka screen baru. Memindahkan selection ke state bersama berarti kedua perilaku itu harus tetap benar.
- **Pengecekan layout dan overflow.** Memastikan tidak ada overflow di berbagai ukuran dan orientasi memakan banyak usaha manual. Setiap UI baru yang digerakkan oleh state (empty state baru, teks lebih panjang) menambah kombinasi yang harus dites ulang.