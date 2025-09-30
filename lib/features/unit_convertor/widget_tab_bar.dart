import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final List<String> tabNames;
  final void Function(int)? onTap;

  const TabBarWidget({super.key, required this.tabNames, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      tabs: tabNames.map((name) => Tab(text: name.toUpperCase())).toList(),
      onTap: onTap,
    );
  }
}
