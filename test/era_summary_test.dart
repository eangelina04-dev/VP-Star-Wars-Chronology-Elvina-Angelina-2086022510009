import 'package:flutter_test/flutter_test.dart';
import 'package:star_wars_chronology/features/timeline/data/timeline_data.dart';
import 'package:star_wars_chronology/features/timeline/domain/era.dart';
import 'package:star_wars_chronology/features/timeline/domain/era_summary.dart';
import 'package:star_wars_chronology/features/timeline/domain/timeline_entry.dart';

TimelineEntry _entry(Era era, int year) => TimelineEntry(
  id: '${era.name}-$year',
  title: 'Judul',
  era: era,
  year: year,
  mediaType: MediaType.film,
  summary: 'Ringkasan',
);

void main() {
  group('summarizeEras', () {
    test('menghitung jumlah dan rentang tahun dari data asli', () {
      final summaries = summarizeEras(timelineEntries);

      expect(summaries.map((s) => s.era), Era.values);
      expect(summaries.map((s) => s.eventCount), [10, 7, 3]);
      expect(summaries.map((s) => s.yearRangeLabel), [
        '32 BBY – 19 BBY',
        '0 ABY – 4 ABY',
        '34 ABY – 35 ABY',
      ]);
    });

    test('setiap era punya minimal satu peristiwa', () {
      final summaries = summarizeEras(timelineEntries);

      for (final summary in summaries) {
        expect(summary.eventCount, greaterThan(0), reason: summary.era.label);
      }
    });

    test('era tanpa peristiwa bernilai nol dan tanpa rentang', () {
      final summaries = summarizeEras([_entry(Era.prequel, -10)]);
      final sequel = summaries.firstWhere((s) => s.era == Era.sequel);

      expect(sequel.eventCount, 0);
      expect(sequel.yearRangeLabel, isNull);
    });

    test('satu tahun saja ditampilkan tanpa rentang', () {
      final summaries = summarizeEras([
        _entry(Era.prequel, -10),
        _entry(Era.prequel, -10),
      ]);

      expect(summaries.first.yearRangeLabel, '10 BBY');
    });

    test('rentang tidak bergantung pada urutan data', () {
      final summaries = summarizeEras([
        _entry(Era.original, 2),
        _entry(Era.original, 5),
        _entry(Era.original, -3),
      ]);
      final original = summaries.firstWhere((s) => s.era == Era.original);

      expect(original.yearRangeLabel, '3 BBY – 5 ABY');
    });
  });
}