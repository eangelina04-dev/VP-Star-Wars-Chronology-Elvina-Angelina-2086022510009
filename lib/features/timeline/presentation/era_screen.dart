import 'package:flutter/material.dart';

import '../data/timeline_data.dart';
import '../domain/era.dart';
import '../domain/era_summary.dart';
import 'saved_screen.dart';
import 'timeline_screen.dart';
import 'widgets/empty_results_view.dart';
import 'widgets/era_grid.dart';

class EraScreen extends StatefulWidget {
  const EraScreen({super.key});

  @override
  State<EraScreen> createState() => _EraScreenState();
}

class _EraScreenState extends State<EraScreen> {
  static final List<EraSummary> _summaries = summarizeEras(timelineEntries);

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  void _openEra(Era era) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => TimelineScreen(initialEra: era)));
  }

  void _openSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (routeContext) =>
            SavedScreen(onExplore: () => Navigator.of(routeContext).pop()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasEvents = _summaries.any((s) => s.eventCount > 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Chronology'),
        actions: [
          IconButton(
            tooltip: 'Tersimpan',
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: _openSaved,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jelajahi Era',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Saga Star Wars Episode I sampai IX terbagi ke dalam tiga era. '
                        'Pilih satu era untuk menelusuri peristiwanya secara berurutan.',
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
          if (_isLoading)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (!hasEvents)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyResultsView(
                message: 'Data peristiwa belum tersedia.',
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverToBoxAdapter(
                child: EraGrid(summaries: _summaries, onEraTap: _openEra),
              ),
            ),
        ],
      ),
    );
  }
}
