import 'package:flutter/material.dart';

enum UnsavedChangesAction { save, discard, cancel }

class UnsavedChangesDialog extends StatelessWidget {
  const UnsavedChangesDialog({super.key});

  static Future<UnsavedChangesAction?> show(BuildContext context) {
    return showDialog<UnsavedChangesAction>(
      context: context,
      builder: (context) => const UnsavedChangesDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unsaved Changes'),
      content: const Text('You have unsaved changes. What would you like to do?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(UnsavedChangesAction.cancel),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(UnsavedChangesAction.discard),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Discard'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(UnsavedChangesAction.save),
          child: const Text('Save'),
        ),
      ],
    );
  }
}