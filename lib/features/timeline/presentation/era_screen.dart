import 'package:flutter/material.dart';

import '../../../core/widgets/brand_app_bar.dart';
import '../data/timeline_data.dart';
import '../domain/era.dart';
import '../domain/era_summary.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasEvents = _summaries.any((s) => s.eventCount > 0);

    return Scaffold(
      appBar: BrandAppBar.adaptive(context),
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
                        'Explore Eras',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The Star Wars saga, Episodes I through IX, is divided into three eras. '
                        'Pick an era to browse its events in chronological order.',
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
                message: 'Event data is not available yet.',
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
