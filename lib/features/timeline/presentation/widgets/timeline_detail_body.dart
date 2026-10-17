import 'package:flutter/material.dart';

import '../../data/timeline_entry.dart';

class TimelineDetailBody extends StatelessWidget {
  const TimelineDetailBody({super.key, required this.entry});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.colorScheme;

    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640), // batas baca di layar lebar
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${entry.yearLabel} · ${entry.mediaType.label}',
                style: textTheme.labelMedium
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Text(entry.title, style: textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text(entry.summary, style: textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}