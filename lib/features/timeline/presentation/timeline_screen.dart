import 'package:flutter/material.dart';

import '../data/timeline_data.dart';
import '../domain/timeline_entry.dart';
import '../domain/timeline_filter.dart';
import 'widgets/timeline_list.dart';
import 'timeline_detail_screen.dart';
import 'widgets/detail_placeholder.dart';
import 'widgets/timeline_app_bar.dart';
import 'widgets/timeline_detail_body.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  static const double _wideBreakpoint = 720;
  static final List<String> _eras = timelineEntries
      .map((e) => e.era)
      .toSet()
      .toList();

  final _searchController = TextEditingController();
  bool _isLoading = true;
  String _query = '';
  String? _selectedEra;
  String? _selectedId;
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
    _searchController.clear();
    setState(() {
      _query = '';
      _selectedEra = null;
      _showFavoritesOnly = false;
    });
  }

  void _openEntry(TimelineEntry entry, bool isWide) {
    if (isWide) {
      setState(() => _selectedId = entry.id);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TimelineDetailScreen(entry: entry)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = filterEntries(
      timelineEntries,
      query: _query,
      era: _selectedEra,
      favoritesOnly: _showFavoritesOnly,
      favoriteIds: _favoriteIds,
    );
    final rows = groupByEra(entries);
    final compact = MediaQuery.sizeOf(context).height < 500;

    TimelineEntry? selected;
    for (final e in entries) {
      if (e.id == _selectedId) selected = e;
    }
    selected ??= entries.isEmpty ? null : entries.first;

    return Scaffold(
      appBar: TimelineAppBar(
        compact: compact,
        showFavoritesOnly: _showFavoritesOnly,
        onToggleFavorites: () =>
            setState(() => _showFavoritesOnly = !_showFavoritesOnly),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _wideBreakpoint;
          final list = TimelineList(
            rows: rows,
            selectedId: selected?.id,
            showSelection: isWide,
            isLoading: _isLoading,
            eras: _eras,
            selectedEra: _selectedEra,
            searchController: _searchController,
            favoriteIds: _favoriteIds,
            showFavoritesOnly: _showFavoritesOnly,
            onQueryChanged: (value) => setState(() => _query = value),
            onEraSelected: (era) => setState(() => _selectedEra = era),
            onReset: _resetFilters,
            onEntryTap: (entry) => _openEntry(entry, isWide),
            onFavoriteToggled: _toggleFavorite,
          );

          if (!isWide) return list;

          return Row(
            children: [
              SizedBox(width: 380, child: list),
              const VerticalDivider(width: 1),
              Expanded(
                child: selected == null
                    ? const DetailPlaceholder()
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
}
