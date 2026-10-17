import '../domain/era.dart';
import '../domain/timeline_entry.dart';

const bool kStressTest = bool.fromEnvironment('STRESS');

final List<TimelineEntry> timelineEntries = kStressTest
    ? _stressEntries()
    : _realEntries;

List<TimelineEntry> _stressEntries() {
  return List.generate(
    500,
    (i) => TimelineEntry(
      id: 'stress-$i',
      title: i % 50 == 0 ? 'Judul panjang ' * 14 : 'Peristiwa uji ke-$i',
      era: Era.values[i * 3 ~/ 500],
      year: i - 250,
      mediaType: MediaType.values[i % MediaType.values.length],
      summary: 'Ringkasan panjang untuk menguji overflow. ' * 20,
    ),
  );
}

const _realEntries = <TimelineEntry>[
  // ── Prequel Era ──
  TimelineEntry(
    id: 'naboo-blockade',
    title: "Blokade Naboo",
    era: Era.prequel,
    year: -32,
    mediaType: MediaType.film,
    summary: "Federasi Dagang memblokade planet Naboo atas manipulasi rahasia Darth Sidious. Qui-Gon Jinn dan Obi-Wan Kenobi diutus untuk menyelesaikan konflik.",
  ),
  TimelineEntry(
    id: 'anakin-discovery',
    title: "Penemuan Anakin Skywalker",
    era: Era.prequel,
    year: -32,
    mediaType: MediaType.film,
    summary: "Terdampar di Tatooine, Qui-Gon menemukan Anakin Skywalker, seorang budak dengan kadar midi-chlorian tertinggi yang pernah tercatat.",
  ),
  TimelineEntry(
    id: 'battle-of-naboo',
    title: "Pertempuran Naboo",
    era: Era.prequel,
    year: -32,
    mediaType: MediaType.film,
    summary: "Pasukan Gungan dan Naboo melawan Federasi Dagang. Darth Maul membunuh Qui-Gon Jinn sebelum akhirnya dikalahkan oleh Obi-Wan Kenobi.",
  ),
  TimelineEntry(
    id: 'clone-wars-begin',
    title: "Awal Clone Wars",
    era: Era.prequel,
    year: -22,
    mediaType: MediaType.film,
    summary: "Pertempuran Geonosis pecah. Pasukan Klon Republik yang dipesan secara rahasia dikerahkan untuk melawan droid Separatis pimpinan Count Dooku.",
  ),
  TimelineEntry(
    id: 'secret-wedding',
    title: "Pernikahan Rahasia",
    era: Era.prequel,
    year: -22,
    mediaType: MediaType.film,
    summary: "Anakin Skywalker dan Padmé Amidala menikah secara diam-diam di Naboo, melanggar kode etik Jedi yang melarang keterikatan emosional.",
  ),
  TimelineEntry(
    id: 'chancellor-rescue',
    title: "Penyelamatan Kanselir",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Anakin membunuh Count Dooku atas hasutan Kanselir Palpatine saat misi penyelamatan di atas ibukota Coruscant.",
  ),
  TimelineEntry(
    id: 'anakin-fall',
    title: "Kejatuhan Anakin",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Dihantui visi kematian Padmé, Anakin tunduk pada Darth Sidious untuk mempelajari sisi gelap dan diangkat menjadi Darth Vader.",
  ),
  TimelineEntry(
    id: 'order-66',
    title: "Pelaksanaan Order 66",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Palpatine mengeluarkan perintah rahasia yang membuat pasukan Klon mengkhianati dan membantai para Jedi di seluruh galaksi.",
  ),
  TimelineEntry(
    id: 'mustafar-duel',
    title: "Duel di Mustafar",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Obi-Wan mengalahkan Darth Vader dalam duel epik. Vader yang terbakar parah diselamatkan dan dimasukkan ke dalam zirah penyokong kehidupan.",
  ),
  TimelineEntry(
    id: 'twins-born',
    title: "Lahirnya si Kembar",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Padmé meninggal setelah melahirkan Luke dan Leia. Keduanya dipisahkan; Luke ke Tatooine dan Leia diadopsi oleh keluarga kerajaan Alderaan.",
  ),

  // ── Original Trilogy ──
  TimelineEntry(
    id: 'death-star-plans',
    title: "Pencurian Rencana Death Star",
    era: Era.original,
    year: 0,
    mediaType: MediaType.film,
    summary: "Pemberontak berhasil mencuri cetak biru senjata rahasia Kekaisaran, Death Star, dan menyembunyikannya di dalam droid R2-D2.",
  ),
  TimelineEntry(
    id: 'battle-of-yavin',
    title: "Pertempuran Yavin",
    era: Era.original,
    year: 0,
    mediaType: MediaType.film,
    summary: "Dengan panduan Force dari arwah Obi-Wan, Luke Skywalker berhasil menembakkan torpedo proton yang menghancurkan Death Star pertama.",
  ),
  TimelineEntry(
    id: 'battle-of-hoth',
    title: "Pertempuran Hoth",
    era: Era.original,
    year: 3,
    mediaType: MediaType.film,
    summary: "Kekaisaran menyerang pangkalan rahasia Pemberontak di planet es Hoth menggunakan armada AT-AT, memaksa Pemberontak melarikan diri.",
  ),
  TimelineEntry(
    id: 'cloud-city-reveal',
    title: "Pengungkapan di Cloud City",
    era: Era.original,
    year: 3,
    mediaType: MediaType.film,
    summary: "Dalam duel lightsaber, Darth Vader memotong tangan Luke dan mengungkapkan kebenaran kelam: 'I am your father'.",
  ),
  TimelineEntry(
    id: 'han-solo-rescue',
    title: "Penyelamatan Han Solo",
    era: Era.original,
    year: 4,
    mediaType: MediaType.film,
    summary: "Luke, Leia, dan kawan-kawan menyusup ke istana Jabba the Hutt di Tatooine untuk menyelamatkan Han Solo yang membeku dalam carbonite.",
  ),
  TimelineEntry(
    id: 'battle-of-endor',
    title: "Pertempuran Endor",
    era: Era.original,
    year: 4,
    mediaType: MediaType.film,
    summary: "Pemberontak menghancurkan generator perisai Death Star kedua dengan bantuan suku Ewok di bulan hutan Endor.",
  ),
  TimelineEntry(
    id: 'vader-redemption',
    title: "Penebusan Darth Vader",
    era: Era.original,
    year: 4,
    mediaType: MediaType.film,
    summary: "Tidak tahan melihat Luke disiksa Palpatine, Vader mengorbankan nyawanya dengan melempar sang Kaisar ke reaktor. Kekaisaran runtuh.",
  ),

  // ── Sequel Era ──
  TimelineEntry(
    id: 'first-order-rise',
    title: "Kebangkitan First Order",
    era: Era.sequel,
    year: 34,
    mediaType: MediaType.film,
    summary: "Sisa Kekaisaran membentuk First Order. Starkiller Base menghancurkan sistem Hosnian, ibukota New Republic.",
  ),
  TimelineEntry(
    id: 'luke-sacrifice',
    title: "Pengorbanan Luke",
    era: Era.sequel,
    year: 34,
    mediaType: MediaType.film,
    summary: "Luke memproyeksikan dirinya ke planet Crait untuk menahan Kylo Ren, memberi waktu Pemberontak kabur, sebelum menyatu dengan Force.",
  ),
  TimelineEntry(
    id: 'sith-destruction',
    title: "Kehancuran Sith",
    era: Era.sequel,
    year: 35,
    mediaType: MediaType.film,
    summary: "Rey Skywalker dan Ben Solo bersatu di Exegol. Rey membalikkan petir Palpatine, menghancurkan sang Kaisar dan Final Order untuk selamanya.",
  ),
];
