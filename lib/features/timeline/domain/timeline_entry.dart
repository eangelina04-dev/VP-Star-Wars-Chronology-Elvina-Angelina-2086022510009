import 'era.dart';

enum MediaType { film, series, game, book }

extension MediaTypeLabel on MediaType {
  String get label => switch (this) {
    MediaType.film => 'Film',
    MediaType.series => 'Serial',
    MediaType.game => 'Game',
    MediaType.book => 'Buku',
  };
}

String formatYear(int year) => year < 0 ? '${-year} BBY' : '$year ABY';

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
  final Era era;
  final int year;
  final MediaType mediaType;
  final String summary;

  String get yearLabel => formatYear(year);
}
