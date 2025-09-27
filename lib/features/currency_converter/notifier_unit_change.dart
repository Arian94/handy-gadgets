import 'package:flutter/foundation.dart';

class UnitChangeNotifier extends ChangeNotifier {
  String _fromUnit = '';
  String _toUnit = '';

  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;

  void updateFromUnit(String newFromUnit) {
    _fromUnit = newFromUnit;

    notifyListeners();
  }

  void updateToUnit(String newToUnit) {
    _toUnit = newToUnit;

    notifyListeners();
  }
}
