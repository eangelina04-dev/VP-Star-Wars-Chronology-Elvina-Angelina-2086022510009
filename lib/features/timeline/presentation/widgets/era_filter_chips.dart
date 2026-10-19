import 'package:flutter/material.dart';

import '../../domain/era.dart';

class EraFilterChips extends StatelessWidget {
  const EraFilterChips({
    super.key,
    required this.eras,
    required this.selectedEra,
    required this.onSelected,
  });

  final List<Era> eras;
  final Era? selectedEra;
  final ValueChanged<Era?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: selectedEra == null,
            onSelected: (_) => onSelected(null),
          ),
          for (final era in eras) ...[
            const SizedBox(width: 8),
            ChoiceChip(
              label: Text(era.label),
              selected: selectedEra == era,
              onSelected: (_) => onSelected(era),
            ),
          ],
        ],
      ),
    );
  }
}
