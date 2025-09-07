import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const DeleteConfirmationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Note'),
      content: const Text('Are you sure you want to delete this note? This action cannot be undone.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}