import 'package:flutter/material.dart';

import '../constants/app_name.dart';

class BrandAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandAppBar({super.key, required this.compact});

  factory BrandAppBar.adaptive(BuildContext context) {
    return BrandAppBar(
      compact: MediaQuery.sizeOf(context).height < _compactHeight,
    );
  }

  static const double _compactHeight = 500;

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
          ? const Text(appName, maxLines: 1, overflow: TextOverflow.ellipsis)
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
                const Text(
                  appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
    );
  }
}
