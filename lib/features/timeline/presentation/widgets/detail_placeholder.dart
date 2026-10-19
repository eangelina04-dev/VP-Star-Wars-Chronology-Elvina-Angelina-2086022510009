import 'package:flutter/material.dart';

class DetailPlaceholder extends StatelessWidget {
  const DetailPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history_edu, size: 48, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            'Select an event to view details',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
