import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/era.dart';
import '../../domain/era_summary.dart';
import 'era_card.dart';

class EraGrid extends StatelessWidget {
  const EraGrid({super.key, required this.summaries, required this.onEraTap});

  final List<EraSummary> summaries;
  final ValueChanged<Era> onEraTap;

  static const double _spacing = 16;
  static const double _minCardWidth = 320;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fitting =
            (constraints.maxWidth + _spacing) ~/ (_minCardWidth + _spacing);
        final columns = max(1, min(fitting, summaries.length));
        final cardWidth =
            (constraints.maxWidth - _spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: [
            for (final summary in summaries)
              SizedBox(
                width: cardWidth,
                child: EraCard(
                  summary: summary,
                  onTap: () => onEraTap(summary.era),
                ),
              ),
          ],
        );
      },
    );
  }
}