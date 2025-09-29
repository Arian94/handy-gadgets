import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
interface class Note {
  Note({
    required this.title,
    required this.content,
    required this.contentPlainText,
    required this.creationDate,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  List<dynamic> content;
  @HiveField(2)
  String contentPlainText;
  @HiveField(3)
  int creationDate;

  static List<Note> toList(Iterable<dynamic> iterable) {
    // eg: {title: , content: [{insert: qqq}, {insert:... }
    // map.entries.

    return iterable
        .map(
          (value) => Note(
            title: value['title'],
            content: value['content'],
            contentPlainText: value['contentPlainText'],
            creationDate: value['creationDate'],
          ),
        )
        .toList();
  }
}

// CONSTANTS for the Hive "Collection" (Box)
const String notesBoxName = 'notes';

class HiveDb {
  static late Box<dynamic> _notesBox;

  static Box<dynamic> get notesBox => _notesBox;

  static Future<void> initHive() async {
    // Ensure Flutter widgets are ready before we initialize Hive
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Hive for the Flutter environment (handles IndexedDB on web)
    // We assume the hive and hive_flutter dependencies (v2.2.3 or higher) are available.
    return await Hive.initFlutter();
  }

  static Future<void> openNotesBox() async {
    _notesBox = await Hive.openBox<dynamic>(notesBoxName);
  }
}
