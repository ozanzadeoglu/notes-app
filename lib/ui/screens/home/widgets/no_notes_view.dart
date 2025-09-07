import 'package:connectinno_case_client/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NoNotesView extends StatelessWidget {
  const NoNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 64, color: AppColors.secondaryText),
          SizedBox(height: 16),
          Text(
            'No notes yet',
            style: TextStyle(fontSize: 18, color: AppColors.secondaryText),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to create your first note',
            style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }
}
