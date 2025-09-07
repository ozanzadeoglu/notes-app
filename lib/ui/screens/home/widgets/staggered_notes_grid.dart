import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:connectinno_case_client/domain/entities/note/note.dart';
import 'package:connectinno_case_client/ui/screens/home/widgets/note_summary.dart';

class StaggeredNotesGrid extends StatelessWidget {
  final List<Note> notes;
  final Function(Note) onNoteTap;

  const StaggeredNotesGrid({
    super.key,
    required this.notes,
    required this.onNoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteSummary(
            note: note,
            onTap: () => onNoteTap(note),
          );
        },
      ),
    );
  }
}