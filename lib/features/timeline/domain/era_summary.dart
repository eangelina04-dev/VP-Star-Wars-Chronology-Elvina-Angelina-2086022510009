import 'dart:math';

import 'era.dart';
import 'timeline_entry.dart';

class EraSummary {
  const EraSummary({
    required this.era,
    required this.eventCount,
    this.firstYear,
    this.lastYear,
  });

  final Era era;
  final int eventCount;
  final int? firstYear;
  final int? lastYear;

  String? get yearRangeLabel {
    final first = firstYear;
    final last = lastYear;
    if (first == null || last == null) return null;
    if (first == last) return formatYear(first);
    return '${formatYear(first)} – ${formatYear(last)}';
  }
}

List<EraSummary> summarizeEras(List<TimelineEntry> entries) {
  return Era.values.map((era) {
    final years = [
      for (final e in entries)
        if (e.era == era) e.year,
    ];
    return EraSummary(
      era: era,
      eventCount: years.length,
      firstYear: years.isEmpty ? null : years.reduce(min),
      lastYear: years.isEmpty ? null : years.reduce(max),
    );
  }).toList();
}
