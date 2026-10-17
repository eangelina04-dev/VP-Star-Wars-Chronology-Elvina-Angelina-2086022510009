import 'era.dart';
import 'timeline_entry.dart';

List<TimelineEntry> filterEntries(
  List<TimelineEntry> entries, {
  required String query,
  required Era? era,
  required bool favoritesOnly,
  required Set<String> favoriteIds,
}) {
  final q = query.trim().toLowerCase();
  return entries.where((e) {
    final matchesEra = era == null || e.era == era;
    final matchesQuery =
        q.isEmpty ||
        e.title.toLowerCase().contains(q) ||
        e.summary.toLowerCase().contains(q);
    final matchesFavorite = !favoritesOnly || favoriteIds.contains(e.id);
    return matchesEra && matchesQuery && matchesFavorite;
  }).toList();
}

List<Object> groupByEra(List<TimelineEntry> entries) {
  final rows = <Object>[];
  Era? lastEra;
  for (final entry in entries) {
    if (entry.era != lastEra) {
      rows.add(entry.era);
      lastEra = entry.era;
    }
    rows.add(entry);
  }
  return rows;
}
