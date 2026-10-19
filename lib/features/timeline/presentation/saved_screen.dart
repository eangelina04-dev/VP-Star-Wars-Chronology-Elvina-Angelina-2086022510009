import 'package:flutter/material.dart';

import '../../../core/widgets/brand_app_bar.dart';
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
    final theme = Theme.of(context);
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
      appBar: BrandAppBar.adaptive(context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Saved', style: theme.textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text(
                        'Events you have starred are grouped by era.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (rows.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyResultsView(
                icon: Icons.star_border,
                title: 'No saved events yet',
                message: 'Tap the star on an event to save it.',
                actionLabel: 'Explore events',
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
    );
  }
}
