import 'package:flutter/material.dart';

class TimelineAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TimelineAppBar({
    super.key,
    required this.compact,
    required this.showFavoritesOnly,
    required this.onToggleFavorites,
  });

  final bool compact;
  final bool showFavoritesOnly;
  final VoidCallback onToggleFavorites;

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
          ? const Text('Star Wars Timeline')
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
      actions: [
        IconButton(
          tooltip: showFavoritesOnly ? 'Tampilkan semua' : 'Hanya favorit',
          isSelected: showFavoritesOnly,
          icon: const Icon(Icons.star_border),
          selectedIcon: const Icon(Icons.star),
          onPressed: onToggleFavorites,
        ),
      ],
    );
  }
}