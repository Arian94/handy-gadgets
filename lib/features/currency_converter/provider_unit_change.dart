import 'package:flutter/material.dart';

import 'notifier_unit_change.dart';

class UnitChangeProvider extends InheritedWidget {
  final UnitChangeNotifier unitChangeNotifier;

  const UnitChangeProvider({
    super.key,
    required this.unitChangeNotifier,
    required super.child,
  });

  static UnitChangeNotifier of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<UnitChangeProvider>();

    if (provider == null) {
      throw 'No UnitChangeProvider found in context';
    }

    return provider.unitChangeNotifier;
  }

  @override
  bool updateShouldNotify(UnitChangeProvider oldWidget) {
    return unitChangeNotifier != oldWidget.unitChangeNotifier;
  }
}
