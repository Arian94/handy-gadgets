import 'package:flutter/material.dart';

import 'screen_converter_tab.dart';
import 'notifier_unit_change.dart';
import 'provider_unit_change.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<StatefulWidget> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  int activeTabIndex = 0;
  static const tabTypes = ['converter & ratio plot'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTypes.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: tabTypes[0].toUpperCase())],
          ),
        ),
        body: TabBarView(
          children: [
            UnitChangeProvider(
              unitChangeNotifier: UnitChangeNotifier(),
              child: const ConverterTabScreen(),
            ),
          ],
        ),
      ),
    );
    // Spacer(),
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 24),
    //   child: const CurrencyConverterForm(),
    // ),
    // Spacer(),
  }
}
