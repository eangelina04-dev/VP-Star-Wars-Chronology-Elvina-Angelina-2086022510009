import 'package:flutter/material.dart';

import '../../domain/era.dart';
import '../../domain/timeline_entry.dart';
import 'empty_results_view.dart';
import 'era_filter_chips.dart';
import 'era_header.dart';
import 'timeline_entry_card.dart';
import 'timeline_search_field.dart';

class TimelineList extends StatelessWidget {
  const TimelineList({
    super.key,
    required this.rows,
    required this.selectedId,
    required this.showSelection,
    required this.isLoading,
    required this.eras,
    required this.selectedEra,
    required this.searchController,
    required this.favoriteIds,
    required this.showFavoritesOnly,
    required this.onQueryChanged,
    required this.onEraSelected,
    required this.onReset,
    required this.onEntryTap,
    required this.onFavoriteToggled,
  });

  final List<Object> rows;
  final String? selectedId;
  final bool showSelection;
  final bool isLoading;
  final List<Era> eras;
  final Era? selectedEra;
  final TextEditingController searchController;
  final Set<String> favoriteIds;
  final bool showFavoritesOnly;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<Era?> onEraSelected;
  final VoidCallback onReset;
  final ValueChanged<TimelineEntry> onEntryTap;
  final ValueChanged<String> onFavoriteToggled;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TimelineSearchField(
              controller: searchController,
              onChanged: onQueryChanged,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: EraFilterChips(
            eras: eras,
            selectedEra: selectedEra,
            onSelected: onEraSelected,
          ),
        ),
        if (isLoading)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (rows.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyResultsView(
              message: showFavoritesOnly
                  ? 'Ketuk bintang pada sebuah peristiwa untuk menambahkannya.'
                  : 'Coba kata kunci atau era yang lain.',
              actionLabel: 'Reset pencarian & filter',
              onAction: onReset,
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
                    isFavorite: favoriteIds.contains(row.id),
                    isSelected: showSelection && row.id == selectedId,
                    onTap: () => onEntryTap(row),
                    onFavoriteToggled: onFavoriteToggled,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
