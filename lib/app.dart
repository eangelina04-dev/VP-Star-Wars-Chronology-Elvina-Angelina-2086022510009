import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/timeline/presentation/timeline_screen.dart';

class StarWarsApp extends StatelessWidget {
  const StarWarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Chronology',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const TimelineScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
