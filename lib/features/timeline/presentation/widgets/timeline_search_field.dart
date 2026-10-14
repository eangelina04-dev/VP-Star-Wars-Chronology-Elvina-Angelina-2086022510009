import 'package:flutter/material.dart';

class TimelineSearchField extends StatelessWidget {
  const TimelineSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: 'Cari peristiwa...',
      leading: const Icon(Icons.search),
      onChanged: onChanged,
    );
  }
}