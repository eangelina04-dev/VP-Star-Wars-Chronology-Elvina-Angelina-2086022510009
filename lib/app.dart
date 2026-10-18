import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/timeline/presentation/home_shell.dart';
import 'features/timeline/presentation/state/favorites_controller.dart';
import 'features/timeline/presentation/state/favorites_scope.dart';

class StarWarsApp extends StatefulWidget {
  const StarWarsApp({super.key});

  @override
  State<StarWarsApp> createState() => _StarWarsAppState();
}

class _StarWarsAppState extends State<StarWarsApp> {
  final _favorites = FavoritesController();

  @override
  void dispose() {
    _favorites.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesScope(
      controller: _favorites,
      child: MaterialApp(
        title: 'Star Wars Chronology',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const HomeShell(),
      ),
    );
  }
}
