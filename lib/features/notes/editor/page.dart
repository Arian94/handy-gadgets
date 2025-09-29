import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:handy_gadgets_app/collections/note.dart';

class NotesEditorPage extends StatefulWidget {
  final String id;

  const NotesEditorPage({super.key, required this.id});

  @override
  State<NotesEditorPage> createState() => _NotesEditorPageState();
}

class _NotesEditorPageState extends State<NotesEditorPage> {
  QuillController _quillController = QuillController.basic();
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.id.isNotEmpty) {
      final noteContent = HiveDb.notesBox.getAt(int.parse(widget.id));
      final document = Document.fromJson(noteContent['content']);
      _titleController = TextEditingController(text: noteContent['title']);
      _quillController = QuillController(
        document: document,
        selection: TextSelection.collapsed(
          offset: document.toPlainText().length - 1,
        ),
      );
    }
  }

  @override
  void dispose() {
    onSave();
    super.dispose();
  }

  bool isNoteEmpty() {
    return _titleController.text.trim().isEmpty &&
        _quillController.document.toPlainText().toString().trim().isEmpty;
  }

  void onSave() async {
    final content = _quillController.document.toDelta();
    final value = {
      'title': _titleController.text,
      'content': content.toJson(),
      'contentPlainText': _quillController.document.toPlainText(),
      'creationDate': DateTime.now().millisecondsSinceEpoch,
    };

    if (isNoteEmpty()) {
      return;
    }

    if (widget.id.isEmpty) {
      await HiveDb.notesBox.add(value);
    } else {
      await HiveDb.notesBox.putAt(int.parse(widget.id), value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'Title'),
        ),
        QuillSimpleToolbar(
          controller: _quillController,
          config: const QuillSimpleToolbarConfig(showSearchButton: false),
        ),
        Expanded(
          child: QuillEditor.basic(
            controller: _quillController,
            config: const QuillEditorConfig(autoFocus: true),
          ),
        ),
      ],
    );
  }
}
