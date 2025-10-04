import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesDialogue extends StatefulWidget {
  final int? id;
  final String? title;
  final String? content;
  final int color;
  final List<Color> notesColors;
  final Function onSave;

  const NotesDialogue({
    super.key,
    this.id,
    this.title, // Added title parameter
    this.content,
    required this.color,
    required this.notesColors,
    required this.onSave,
  });

  @override
  State<NotesDialogue> createState() => _NotesDialogueState();
}

class _NotesDialogueState extends State<NotesDialogue> {
  late int _selectedColorIndex;

  @override
  void initState() {
    super.initState();
    _selectedColorIndex = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('E d MMM').format(DateTime.now());
    TextEditingController titleController =
        TextEditingController(text: widget.title ?? '');
    TextEditingController contentController =
        TextEditingController(text: widget.content ?? '');

    return AlertDialog(
      backgroundColor: widget.notesColors[_selectedColorIndex],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Text(
        widget.id == null ? 'Add Note' : 'Edit Note',
        style: const TextStyle(color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentDate,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                // ignore: deprecated_member_use
                fillColor: Colors.white.withOpacity(0.5),
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                // ignore: deprecated_member_use
                fillColor: Colors.white.withOpacity(0.5),
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select Note Color',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: List.generate(widget.notesColors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: widget.notesColors[index],
                    child: _selectedColorIndex == index
                        ? Icon(Icons.check, color: Colors.black54, size: 16)
                        : null,
                  ),
                );
              }),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            // _selectedColorIndex != null
            //     ? widget.notesColors![_selectedColorIndex]
            //     : Colors.grey,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {
            final newTitle = titleController.text;
            final newContent = contentController.text;
            final color = _selectedColorIndex;
            widget.onSave(newTitle, newContent, color, currentDate);
            Navigator.pop(context);
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
