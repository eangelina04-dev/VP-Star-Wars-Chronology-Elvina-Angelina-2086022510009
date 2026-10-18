import 'package:flutter/material.dart';

import '../../domain/era_summary.dart';

class EraCard extends StatelessWidget {
  const EraCard({super.key, required this.summary, required this.onTap});

  final EraSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.colorScheme;
    final rangeLabel = summary.yearRangeLabel;
    final meta = ['${summary.eventCount} peristiwa', ?rangeLabel].join(' · ');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                summary.era.imageAsset,
                width: double.infinity,
                fit: BoxFit.cover,
                semanticLabel: 'Gambar ${summary.era.label}',
                errorBuilder: (context, error, stack) => ColoredBox(
                  color: colors.surfaceContainerHigh,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          summary.era.label,
                          style: textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          summary.era.description,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
