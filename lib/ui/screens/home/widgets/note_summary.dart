import 'package:flutter/material.dart';
import 'package:connectinno_case_client/domain/entities/note/note.dart';
import 'package:connectinno_case_client/core/theme/app_colors.dart';

class NoteSummary extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;

  const NoteSummary({
    super.key,
    required this.note,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shadowColor: AppColors.primaryText,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (note.title.isNotEmpty) ...[
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (note.content.isNotEmpty) const SizedBox(height: 8),
              ],
              if (note.content.isNotEmpty)
                Text(
                  note.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    height: 1.3,
                  ),
                  maxLines: note.title.isEmpty ? 4 : 12,
                  overflow: TextOverflow.ellipsis,
                ),
              if (note.title.isEmpty && note.content.isEmpty)
                const Text(
                  'Empty note',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}