import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'features/notes/editor/page.dart';
import 'features/notes/list/page.dart';
import 'features/currency_converter/page.dart';
import 'features/unit_convertor/page.dart';
import 'features/home/page.dart';

import 'collections/note.dart';

void main() async {
  await HiveDb.initHive();
  await HiveDb.openNotesBox();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );
  runApp(const HandyGadgets());
}

class HandyGadgets extends StatelessWidget {
  const HandyGadgets({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handy Gadgets App',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case RouteNames.unitConverter:
            page = const UnitConverterPage();
            break;
          case RouteNames.currencyConverter:
            page = const CurrencyConverterPage();
            break;
          case RouteNames.notesList:
            page = const NotesListPage();
            break;

          default:
            {
              if (settings.name!.startsWith(RouteNames.notesEditor)) {
                if (settings.name!.length == RouteNames.notesEditor.length) {
                  page = NotesEditorPage(id: '');
                } else {
                  final id = settings.name!.substring(
                    RouteNames.notesEditor.length + 1,
                  );
                  page = NotesEditorPage(id: id);
                }
                break;
              }
              page = const HomePage();
            }
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Handy Gadgets',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
            ),
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
  static const String currencyConverter = "currency-converter";
  static const String notesList = "notes/list";
  static const String notesEditor = "notes/editor";
}
