import 'package:flutter/material.dart';

import '../data/timeline_data.dart';
import '../data/timeline_entry.dart';
import 'timeline_detail_screen.dart';
import 'widgets/empty_results_view.dart';
import 'widgets/era_filter_chips.dart';
import 'widgets/era_header.dart';
import 'widgets/timeline_detail_body.dart';
import 'widgets/timeline_entry_card.dart';
import 'widgets/timeline_search_field.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  static const double _wideBreakpoint = 720;
  static final List<String> _eras =
  timelineEntries.map((e) => e.era).toSet().toList();

  final _searchController = TextEditingController();
  bool _isLoading = true;
  String _query = '';
  String? _selectedEra;
  String? _selectedId; // entri yang tampil di panel kanan (layar lebar)
  bool _showFavoritesOnly = false;
  final Set<String> _favoriteIds = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (!_favoriteIds.remove(id)) _favoriteIds.add(id);
    });
  }

  void _resetFilters() {
    _searchController.clear(); // clear() tidak memicu onChanged
    setState(() {
      _query = '';
      _selectedEra = null;
      _showFavoritesOnly = false;
    });
  }

  List<TimelineEntry> get _filteredEntries {
    final q = _query.trim().toLowerCase();
    return timelineEntries.where((e) {
      final matchesEra = _selectedEra == null || e.era == _selectedEra;
      final matchesQuery = q.isEmpty ||
          e.title.toLowerCase().contains(q) ||
          e.summary.toLowerCase().contains(q);
      final matchesFavorite =
          !_showFavoritesOnly || _favoriteIds.contains(e.id);
      return matchesEra && matchesQuery && matchesFavorite;
    }).toList();
  }

  List<Object> _groupByEra(List<TimelineEntry> entries) {
    final rows = <Object>[];
    String? lastEra;
    for (final entry in entries) {
      if (entry.era != lastEra) {
        rows.add(entry.era);
        lastEra = entry.era;
      }
      rows.add(entry);
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final entries = _filteredEntries;
    final rows = _groupByEra(entries);
    final compact = MediaQuery.sizeOf(context).height < 500;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDark
        ? 'assets/images/star_wars_logo_dark.png'
        : 'assets/images/star_wars_logo_light.png';

    TimelineEntry? selected;
    for (final e in entries) {
      if (e.id == _selectedId) selected = e;
    }
    selected ??= entries.isEmpty ? null : entries.first;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: compact ? 56 : 88,
        title: compact
            ? const Text('Star Wars Timeline')
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              logoAsset,
              height: 60,
              semanticLabel: 'Logo Star Wars',
              errorBuilder: (context, error, stack) =>
              const SizedBox.shrink(),
            ),
            const SizedBox(height: 4),
            const Text('Star Wars Timeline'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _showFavoritesOnly ? 'Tampilkan semua' : 'Hanya favorit',
            isSelected: _showFavoritesOnly,
            icon: const Icon(Icons.star_border),
            selectedIcon: const Icon(Icons.star),
            onPressed: () =>
                setState(() => _showFavoritesOnly = !_showFavoritesOnly),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _wideBreakpoint;
          final list = _buildList(entries, rows, selected?.id, isWide);

          if (!isWide) return list;

          return Row(
            children: [
              SizedBox(width: 380, child: list),
              const VerticalDivider(width: 1),
              Expanded(
                child: selected == null
                    ? const _DetailPlaceholder()
                    : TimelineDetailBody(
                  key: ValueKey(selected.id), // reset posisi scroll
                  entry: selected,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(
      List<TimelineEntry> entries,
      List<Object> rows,
      String? selectedId,
      bool isWide,
      ) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TimelineSearchField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: EraFilterChips(
            eras: _eras,
            selectedEra: _selectedEra,
            onSelected: (era) => setState(() => _selectedEra = era),
          ),
        ),
        if (_isLoading)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (entries.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyResultsView(
              message: _showFavoritesOnly
                  ? 'Ketuk bintang pada sebuah peristiwa untuk menambahkannya.'
                  : 'Coba kata kunci atau era yang lain.',
              actionLabel: 'Reset pencarian & filter',
              onAction: _resetFilters,
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
                  return EraHeader(era: row as String);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: TimelineEntryCard(
                    entry: row,
                    isFavorite: _favoriteIds.contains(row.id),
                    isSelected: isWide && row.id == selectedId,
                    onTap: () {
                      if (isWide) {
                        setState(() => _selectedId = row.id);
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TimelineDetailScreen(entry: row),
                          ),
                        );
                      }
                    },
                    onFavoriteToggled: _toggleFavorite,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _DetailPlaceholder extends StatelessWidget {
  const _DetailPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history_edu, size: 48, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text('Pilih peristiwa untuk melihat detail',
              style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}