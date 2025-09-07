import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/entities/note/note.dart';

class NoteTimestampBar extends StatelessWidget {
  final Note note;

  const NoteTimestampBar({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.background,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildTimestamps(),
        ),
      ),
    );
  }

  List<Widget> _buildTimestamps() {
    final widgets = <Widget>[];
    
    // Always show created date
    widgets.add(
      Text(
        'Created: ${note.createdAt.toLocal().toString().substring(0, 19)}',
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.secondaryText,
        ),
      ),
    );
    
    if (note.updatedAt.difference(note.createdAt).inSeconds > 1) {
      widgets.add(
        Text(
          'Updated: ${note.updatedAt.toLocal().toString().substring(0, 19)}',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      );
    }
    
    return widgets;
  }
}