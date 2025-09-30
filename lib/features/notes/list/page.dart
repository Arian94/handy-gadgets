import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:handy_gadgets_app/collections/note.dart';
import 'package:handy_gadgets_app/main.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  final Map<int, int?> _itemIndexAndKeysToDelete = {};

  List<Note> _notes = [];
  VoidCallback? _noteBoxListener;

  @override
  void initState() {
    super.initState();

    _notes = Note.toList(HiveDb.notesBox.toMap().values);

    _noteBoxListener = () {
      setState(() {
        _notes = Note.toList(HiveDb.notesBox.toMap().values);
      });
    };

    HiveDb.notesBox.listenable().addListener(_noteBoxListener!);
  }

  @override
  void dispose() {
    super.dispose();

    if (_noteBoxListener != null) {
      HiveDb.notesBox.listenable().removeListener(_noteBoxListener!);
    }
  }

  String showSubstringedText(String text, int length) {
    return text.length >= length ? '${text.substring(0, length)}...' : text;
  }

  void onTapEmptyInkWell() {
    Navigator.pushNamed(context, RouteNames.notesEditor);
  }

  void onTapInkWell(MapEntry<int, dynamic> item) {
    if (_itemIndexAndKeysToDelete.isEmpty) {
      Navigator.pushNamed(context, "${RouteNames.notesEditor}/${item.key}");
    } else {
      setState(() {
        if (_itemIndexAndKeysToDelete[item.key] == null) {
          final key = HiveDb.notesBox.keyAt(item.key);
          _itemIndexAndKeysToDelete[item.key] = key;
        } else {
          if (_itemIndexAndKeysToDelete.length == 1) {
            _itemIndexAndKeysToDelete.clear();
          } else {
            _itemIndexAndKeysToDelete[item.key] = null;
          }
        }
      });
    }
  }

  void onLongPressInkWell(MapEntry<int, dynamic> item) {
    setState(() {
      final key = HiveDb.notesBox.keyAt(item.key);
      _itemIndexAndKeysToDelete[item.key] = key;
    });
  }

  void onDelete() async {
    await HiveDb.notesBox.deleteAll(_itemIndexAndKeysToDelete.values);
    setState(() {
      _itemIndexAndKeysToDelete.clear();
    });
  }

  void onPopInvoked() {
    setState(() {
      _itemIndexAndKeysToDelete.clear();
    });
  }

  void onTapBottomNavigationBar(int value) {
    if (value == 0) {
      if (_itemIndexAndKeysToDelete.length == _notes.length) {
        setState(() {
          _itemIndexAndKeysToDelete.clear();
        });
        return;
      }
      _notes.asMap().entries.toList().forEach((item) {
        final key = HiveDb.notesBox.keyAt(item.key);
        _itemIndexAndKeysToDelete[item.key] = key;
      });
      setState(() {
        _itemIndexAndKeysToDelete;
      });
    }
    if (value == 1) {
      onDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: PopScope(
        canPop: _itemIndexAndKeysToDelete.isEmpty,
        onPopInvokedWithResult: (_, _) => {onPopInvoked()},
        child: Scaffold(
          body: GridView.count(
            // 1. Set fixed number of columns (3x3 grid)
            crossAxisCount: 2,
            // 2. Control vertical space
            mainAxisSpacing: 15.0,
            // 3. Control horizontal space
            crossAxisSpacing: 15.0,
            // Required when placing GridView inside a container/column
            shrinkWrap: true,
            // Disable scrolling since we only have 9 items
            physics: const NeverScrollableScrollPhysics(),
            // 4. Map the data to 9 custom widget children
            children: [
              ..._notes.asMap().entries.toList().map((item) {
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () => {onTapInkWell(item)},
                    onLongPress: () => {onLongPressInkWell(item)},
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: _itemIndexAndKeysToDelete[item.key] == null
                            ? null
                            : Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            showSubstringedText(item.value.title, 5),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            showSubstringedText(
                              item.value.contentPlainText,
                              10,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            DateFormat('EEE, MMM dd / yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                item.value.creationDate,
                              ).toLocal(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Card(
                child: InkWell(
                  onTap: onTapEmptyInkWell,
                  child: const Icon(Icons.add, size: 44),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: _itemIndexAndKeysToDelete.isNotEmpty,
            child: BottomNavigationBar(
              currentIndex: 0,
              onTap: onTapBottomNavigationBar,
              items: [
                _itemIndexAndKeysToDelete.length == _notes.length
                    ? BottomNavigationBarItem(
                        icon: Icon(
                          Icons.deselect_outlined,
                          color: Colors.blueAccent,
                          size: 32,
                        ),
                        label: 'Deselect All',
                      )
                    : BottomNavigationBarItem(
                        icon: Icon(
                          Icons.select_all,
                          color: Colors.red,
                          size: 32,
                        ),
                        label: 'Select All',
                      ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.delete, color: Colors.red, size: 32),
                  label: 'Delete',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
