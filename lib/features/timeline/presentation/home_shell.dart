import 'package:flutter/material.dart';

import 'era_screen.dart';
import 'saved_screen.dart';
import 'timeline_screen.dart';

class _Destination {
  const _Destination(this.icon, this.selectedIcon, this.label);

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  static const _destinations = [
    _Destination(Icons.home_outlined, Icons.home, 'Home'),
    _Destination(Icons.explore_outlined, Icons.explore, 'Explore'),
    _Destination(Icons.bookmarks_outlined, Icons.bookmarks, 'Saved'),
  ];

  int _index = 0;

  void _select(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _select(0);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: [
            const EraScreen(),
            const TimelineScreen(),
            SavedScreen(onExplore: () => _select(1)),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _select,
          destinations: [
            for (final d in _destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
          ],
        ),
      ),
    );
  }
}
