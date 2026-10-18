import 'dart:collection';

import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {
  final Set<String> _ids = {};

  Set<String> get ids => UnmodifiableSetView(_ids);

  bool isFavorite(String id) => _ids.contains(id);

  void toggle(String id) {
    if (!_ids.remove(id)) _ids.add(id);
    notifyListeners();
  }
}
