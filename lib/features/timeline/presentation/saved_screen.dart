import 'package:flutter/material.dart';

import '../../../core/constants/app_name.dart';
import '../data/timeline_data.dart';
import '../domain/era.dart';
import '../domain/timeline_entry.dart';
import '../domain/timeline_filter.dart';
import 'state/favorites_scope.dart';
import 'timeline_detail_screen.dart';
import 'widgets/empty_results_view.dart';
import 'widgets/era_header.dart';
import 'widgets/timeline_entry_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesScope.of(context);
    final entries = filterEntries(
      timelineEntries,
      query: '',
      era: null,
      favoritesOnly: true,
      favoriteIds: favorites.ids,
    );
    final rows = groupByEra(entries);

    return Scaffold(
      appBar: AppBar(title: const Text(appName)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: CustomScrollView(
            slivers: [
              if (rows.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyResultsView(
                    icon: Icons.star_border,
                    title: 'Belum ada peristiwa tersimpan',
                    message: 'Ketuk bintang pada sebuah peristiwa untuk menyimpannya.',
                    actionLabel: 'Jelajahi peristiwa',
                    onAction: onExplore,
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 16),
                  sliver: SliverList.builder(
                    itemCount: rows.length,
                    itemBuilder: (context, index) {
                      final row = rows[index];
                      if (row is! TimelineEntry) {
                        return EraHeader(era: row as Era);
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: TimelineEntryCard(
                          entry: row,
                          isFavorite: true,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TimelineDetailScreen(entry: row),
                            ),
                          ),
                          onFavoriteToggled: favorites.toggle,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
