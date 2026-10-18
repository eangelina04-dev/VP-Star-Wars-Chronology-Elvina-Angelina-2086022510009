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
  static const double _railBreakpoint = 720;
  static const _destinations = [
    _Destination(Icons.home_outlined, Icons.home, 'Home'),
    _Destination(Icons.explore_outlined, Icons.explore, 'Explore'),
    _Destination(Icons.bookmarks_outlined, Icons.bookmarks, 'Saved'),
  ];

  final _pagesKey = GlobalKey();
  int _index = 0;

  void _select(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final useRail = MediaQuery.sizeOf(context).width >= _railBreakpoint;
    final pages = IndexedStack(
      key: _pagesKey,
      index: _index,
      children: [
        const EraScreen(),
        const TimelineScreen(),
        SavedScreen(onExplore: () => _select(1)),
      ],
    );

    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _select(0);
      },
      child: Scaffold(
        body: useRail
            ? Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: _select,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: pages),
          ],
        )
            : pages,
        bottomNavigationBar: useRail
            ? null
            : NavigationBar(
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