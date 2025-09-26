import 'package:flutter/material.dart';

import 'features/unit_convertor/page.dart';
import 'features/home/page.dart';

void main() {
  runApp(const HandyGadgets());
}

class HandyGadgets extends StatelessWidget {
  const HandyGadgets({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handy Gadgets App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case RouteNames.unitConverter:
            page = const UnitConverterPage();
            break;
          default:
            page = const HomePage();
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Handy Gadgets'), centerTitle: true),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: page,
            ),
          ),
        );
      },
    );
  }
}

class RouteNames {
  static const String unitConverter = "unit-converter";
}
