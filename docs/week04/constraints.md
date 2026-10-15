# Constraint 

> **Constraints go down, sizes go up, parent sets position.**
> Induk memberi batas (*constraints*) ke anak, anak memilih ukurannya di dalam batas itu dan melaporkannya ke induk, lalu induk yang menentukan posisinya.

---

## Error 1: `Row` tanpa `Expanded` (kartu peristiwa)

![Overflow pada Row di kartu](overflow1_row.png)

- **Diambil di:** emulator Small 320 dp
- **Pesan error:** `A RenderFlex overflowed by 730 pixels on the right.`
- **Lokasi:** `timeline_entry_card.dart:39:18`, widget `Row`, `Axis.horizontal`

**Kode yang dirusak:** `Expanded` pada `Column` teks dihapus.

```dart
Row(
  children: [
    Column(            // tanpa Expanded
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ /* label tahun, judul, ringkasan */ ],
    ),
    IconButton( /* bintang */ ),
  ],
)
```

**Aturan yang dilanggar:** `Row` memberi anak yang tidak fleksibel lebar tak terbatas, sehingga `Text` tidak punya batas untuk membungkus atau memotong dan melebar melewati tepi layar (`maxLines` dan `ellipsis` tidak berguna tanpa batas lebar).

**Perbaikan:** bungkus `Column` dengan `Expanded`, supaya `Row` membagi sisa lebar (setelah tombol bintang) kepada `Column`.

```dart
Row(
  children: [
    Expanded(
      child: Column( /* ...tidak berubah... */ ),
    ),
    IconButton( /* bintang */ ),
  ],
)
```

---

## Error 2: `ListView` di dalam `Column` tanpa `Expanded` (layar Timeline)

![Layar kosong karena ListView tidak mendapat tinggi](overflow2_listview.png)

- **Diambil di:** emulator Small 320 dp
- **Pesan error:** `Vertical viewport was given unbounded height.`, diikuti `RenderBox was not laid out: RenderViewport ... 'hasSize'`
- **Lokasi:** `timeline_screen.dart`, method `_buildList` (`Column` di baris 170, `ListView.builder` di baris 172)

**Kode yang dirusak:** isi `_buildList` diganti sementara dengan `ListView.builder` langsung di dalam `Column`, tanpa `Expanded`.

```dart
return Column(
  children: [
    ListView.builder(            // tanpa Expanded
      itemCount: entries.length,
      itemBuilder: (context, i) => ListTile(title: Text(entries[i].title)),
    ),
  ],
);
```

**Aturan yang dilanggar:** `Column` memberi anak yang tingginya tak terbatas (*unbounded*), sedangkan `ListView` ingin mengisi seluruh tinggi yang diberikan. Karena tidak ada tinggi yang pasti, `ListView` tidak bisa menentukan ukurannya. Pesan `RenderBox was not laid out ... hasSize` muncul sebagai akibatnya: `ListView` gagal diukur, lalu bagian lain yang bergantung padanya ikut gagal.

**Perbaikan:** bungkus `ListView` dengan `Expanded`, sehingga `Column` memberi tinggi yang pasti, yaitu seluruh sisa ruang di bawah widget lain.

```dart
return Column(
  children: [
    Expanded(
      child: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, i) => ListTile(title: Text(entries[i].title)),
      ),
    ),
  ],
);
```

**Solusi yang dipakai di proyek ini:** daftar, kolom cari, dan chip era digabung dalam satu `CustomScrollView` dengan `SliverList.builder`. Dengan begitu tidak ada `ListView` di dalam `Column`, dan seluruh halaman bisa digulir bersama sehingga tidak overflow saat keyboard muncul.

## Error 3: `Column` berisi widget berukuran tetap tanpa scroll (layar Detail)

![Overflow pada Column di layar detail](overflow3_column.png)

- **Diambil di:** emulator Small 320 dp (portrait)
- **Pesan error:** `A RenderFlex overflowed by 385 pixels on the bottom.`
- **Lokasi:** `timeline_detail_body.dart`, widget `Column`, `Axis.vertical`

**Kode yang dirusak:** `SingleChildScrollView` diganti sementara dengan `Padding`, lalu ditambah `SizedBox(height: 700)` di akhir `children`.

```dart
child: Padding(                          // sebelumnya: SingleChildScrollView
  padding: const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(/* label tahun */),
      const SizedBox(height: 8),
      Text(entry.title, style: textTheme.headlineMedium),
      const SizedBox(height: 16),
      Text(entry.summary, style: textTheme.bodyLarge),
      const SizedBox(height: 700),       // tambahan sementara
    ],
  ),
),
```

**Aturan yang dilanggar:** `Column` tidak bisa mengecilkan anak yang ukurannya tetap. Total tinggi anak (teks ditambah 700 dp) melebihi tinggi yang diberikan induknya, sehingga 385 piksel sisanya meluap keluar dari tepi bawah layar. Berbeda dari Error 1, arah overflow di sini vertikal (`bottom`, `Axis.vertical`), karena yang kehabisan ruang adalah tinggi, bukan lebar.

**Perbaikan:** kembalikan `SingleChildScrollView`. Pembungkus ini memberi `Column` tinggi tak terbatas, sehingga `Column` boleh setinggi isinya dan kelebihannya bisa digulir.

```dart
child: SingleChildScrollView(
  padding: const EdgeInsets.all(24),
  child: Column( /* ...tidak berubah... */ ),
),
```

**Kaitan dengan proyek:** pola yang sama pernah menjadi masalah nyata di layar Timeline. Kolom cari, chip, dan daftar dulu berada dalam satu `Column` biasa, sehingga overflow saat keyboard muncul di layar pendek. Perbaikannya sama: isi dibuat bisa digulir (`CustomScrollView`).