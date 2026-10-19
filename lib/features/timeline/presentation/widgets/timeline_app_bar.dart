import 'package:flutter/material.dart';

class TimelineAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TimelineAppBar({super.key, required this.compact});

  final bool compact;

  @override
  Size get preferredSize => Size.fromHeight(compact ? 56 : 96);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDark
        ? 'assets/images/star_wars_logo_dark.png'
        : 'assets/images/star_wars_logo_light.png';

    return AppBar(
      toolbarHeight: preferredSize.height,
      title: compact
          ? const Text('Star Wars Chronology')
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  logoAsset,
                  height: 60,
                  semanticLabel: 'Logo Star Wars',
                  errorBuilder: (context, error, stack) =>
                      const SizedBox.shrink(),
                ),
                const SizedBox(height: 4),
                const Text('Star Wars Timeline'),
              ],
            ),
    );
  }
}
