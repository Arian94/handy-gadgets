import 'package:flutter/material.dart';

import 'widget_form.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<StatefulWidget> createState() => UnitConverterPageState();
}

class UnitConverterPageState extends State<UnitConverterPage> {
  int activeTabIndex = 0;
  final tabTypes = ['length', 'time', 'weight'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: tabTypes.length,
          child: Column(
            children: [
              TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: tabTypes[0].toUpperCase()),
                  Tab(text: tabTypes[1].toUpperCase()),
                  Tab(text: tabTypes[2].toUpperCase()),
                ],
                onTap: (index) {
                  setState(() {
                    activeTabIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: UnitConverterForm(type: tabTypes[activeTabIndex]),
        ),
        Spacer(),
      ],
    );
  }
}
