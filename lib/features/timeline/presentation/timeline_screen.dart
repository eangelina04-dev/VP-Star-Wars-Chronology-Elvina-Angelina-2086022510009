import 'package:flutter/material.dart';

import '../data/timeline_data.dart';
import '../domain/era.dart';
import '../domain/timeline_entry.dart';
import '../domain/timeline_filter.dart';
import 'widgets/timeline_list.dart';
import 'state/favorites_scope.dart';
import 'timeline_detail_screen.dart';
import 'widgets/detail_placeholder.dart';
import 'widgets/timeline_app_bar.dart';
import 'widgets/timeline_detail_body.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key, this.initialEra});

  final Era? initialEra;

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  static const double _wideBreakpoint = 700;

  final _searchController = TextEditingController();
  bool _isLoading = true;
  String _query = '';
  Era? _selectedEra;
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedEra = widget.initialEra;
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

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _selectedEra = null;
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
    final favorites = FavoritesScope.of(context);
    final entries = filterEntries(
      timelineEntries,
      query: _query,
      era: _selectedEra,
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
        compact: compact),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _wideBreakpoint;
          final list = TimelineList(
            rows: rows,
            selectedId: selected?.id,
            showSelection: isWide,
            isLoading: _isLoading,
            eras: Era.values,
            selectedEra: _selectedEra,
            searchController: _searchController,
            favoriteIds: favorites.ids,
            onQueryChanged: (value) => setState(() => _query = value),
            onEraSelected: (era) => setState(() => _selectedEra = era),
            onReset: _resetFilters,
            onEntryTap: (entry) => _openEntry(entry, isWide),
            onFavoriteToggled: favorites.toggle,
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
