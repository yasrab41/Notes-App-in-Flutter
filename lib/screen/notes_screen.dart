import 'package:flutter/material.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/screen/notes_dialogue.dart';
import 'package:notes_app/screen/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NoteAppState();
}

class _NoteAppState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final data = await NotesDatabase.instance.fetchAllNotes();

    setState(() {
      notes = data;
    });
  }

  final List<Color> notesColors = [
    Colors.white,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.pink.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
    Colors.teal.shade100,
    Colors.red.shade100,
    Colors.cyan.shade100,
  ];

  void showNoteDialog(
      {int? id,
      String? title,
      String? content,
      int colorIndex = 0,
      String? date}) {
    showDialog(
        context: context,
        builder: (dialogueContext) {
          return NotesDialogue(
            id: id,
            title: title,
            content: content,
            color: colorIndex,
            notesColors: notesColors,
            onSave: (newTitle, newContent, color, date) async {
              if (id == null) {
                await NotesDatabase.instance
                    .addNote(newTitle, newContent, date, color);
              } else {
                await NotesDatabase.instance
                    .updateNote(id, newTitle, newContent, date, color);
              }
              fetchNotes();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showNoteDialog();
          },
          backgroundColor: Colors.blueGrey,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          )),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notes_outlined,
                    size: 100,
                    color: Colors.grey[600],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No notes found",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.84,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    note: note,
                    notesColors: notesColors,
                    onEdit: () {
                      showNoteDialog(
                        id: note['id'],
                        title: note['title'],
                        content: note['content'],
                        colorIndex: note['color'],
                        date: note['date'],
                      );
                    },
                    onDelete: () async {
                      await NotesDatabase.instance.deleteNote(note['id']);
                      fetchNotes();
                    },
                  );
                },
              ),
            ),
    );
  }
}
