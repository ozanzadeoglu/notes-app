import 'package:connectinno_case_client/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotesAndSyncRow extends StatelessWidget {
  final VoidCallback? triggerSync;
  final bool isLoading;
  const NotesAndSyncRow(this.triggerSync, this.isLoading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Notes',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              // Sync button
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: isLoading ? null : triggerSync,
                child: _SyncButtonView(isLoading),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SyncButtonView extends StatelessWidget {
  final bool isLoading;
  const _SyncButtonView(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.secondaryText,
              ),
            )
          : const Icon(Icons.sync, color: AppColors.secondaryText, size: 24),
    );
  }
}
