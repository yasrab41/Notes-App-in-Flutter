import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> note;
  final Function onDelete;
  final Function onEdit;
  final List<Color> notesColors;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
    required this.notesColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onEdit(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notesColors[note['color']],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                note['content'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
                maxLines: 5,
                overflow: TextOverflow.fade,
              ),
            ),
            const Spacer(),
            Text(
              note['date'],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white70),
                  onPressed: () => onDelete(),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white70),
                  onPressed: () => onEdit(),
                ),
              ],
            )
          ],
        ),
      ),
    ); // Replace with your desired widget
  }
}
