import 'package:flutter/material.dart';

import '../domain/timeline_entry.dart';
import 'widgets/timeline_detail_body.dart';

class TimelineDetailScreen extends StatelessWidget {
  const TimelineDetailScreen({super.key, required this.entry});

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.era, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: TimelineDetailBody(entry: entry),
    );
  }
}
