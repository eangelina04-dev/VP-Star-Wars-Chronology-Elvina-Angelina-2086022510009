enum MediaType { film, series, game, book }

extension MediaTypeLabel on MediaType {
  String get label => switch (this) {
    MediaType.film => 'Film',
    MediaType.series => 'Serial',
    MediaType.game => 'Game',
    MediaType.book => 'Buku',
  };
}

class TimelineEntry {
  const TimelineEntry({
    required this.id,
    required this.title,
    required this.era,
    required this.year,
    required this.mediaType,
    required this.summary,
  });

  final String id;
  final String title;
  final String era;
  final int year; // negatif = BBY, positif = ABY
  final MediaType mediaType;
  final String summary;

  String get yearLabel => year < 0 ? '${-year} BBY' : '$year ABY';
}
