import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import 'viewmodel/note_view_model.dart';
import 'widgets/note_app_bar.dart';
import 'widgets/error_message_widget.dart';
import 'widgets/note_title_field.dart';
import 'widgets/note_content_field.dart';
import 'widgets/note_timestamp_bar.dart';
import 'widgets/delete_confirmation_dialog.dart';
import 'widgets/unsaved_changes_dialog.dart';
import '../../common/error_snackbar.dart';

class NoteView extends StatelessWidget {
  final VoidCallback? onSaved;
  final VoidCallback? onDeleted;

  const NoteView({
    super.key,
    this.onSaved,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NoteViewModel>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: NoteAppBar(
        onSave: () => _handleSave(context, viewModel),
        onDelete: () => _handleDelete(context, viewModel),
        onClose: () => _handleClose(context, viewModel),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ErrorMessageWidget(
                onRetry: () => _handleSave(context, viewModel),
              ),
              const SizedBox(height: 12.0),
              NoteTitleField(controller: viewModel.titleController),
              const SizedBox(height: 12.0),
              NoteContentField(controller: viewModel.contentController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NoteTimestampBar(note: viewModel.originalNote),
    );
  }

  Future<void> _handleSave(BuildContext context, NoteViewModel viewModel) async {
    final success = await viewModel.saveNote();
    if (success && context.mounted) {
      debugPrint("HEYYYYYYYYY");
      ErrorSnackbar.showSuccess(context, 'Note saved successfully');
      onSaved?.call();
      Navigator.of(context).pop(true);
    } else if (viewModel.errorMessage != null && context.mounted) {
      ErrorSnackbar.show(
        context,
        viewModel.errorMessage!,
        onRetry: () => _handleSave(context, viewModel),
      );
    }
  }

  Future<void> _handleDelete(BuildContext context, NoteViewModel viewModel) async {
    final shouldDelete = await DeleteConfirmationDialog.show(context);
    if (shouldDelete == true && context.mounted) {
      final success = await viewModel.deleteNote();
      if (success && context.mounted) {
        ErrorSnackbar.showSuccess(context, 'Note deleted successfully');
        onDeleted?.call();
        Navigator.of(context).pop(true);
      } else if (viewModel.errorMessage != null && context.mounted) {
        ErrorSnackbar.show(
          context,
          viewModel.errorMessage!,
          onRetry: () => _handleDelete(context, viewModel),
        );
      }
    }
  }

  Future<void> _handleClose(BuildContext context, NoteViewModel viewModel) async {
    if (viewModel.hasUnsavedChanges) {
      final action = await UnsavedChangesDialog.show(context);
      
      if (action == UnsavedChangesAction.save && context.mounted) {
        final success = await viewModel.saveNote();
        if (success && context.mounted) {
          onSaved?.call();
          Navigator.of(context).pop(true);
        }
      } else if (action == UnsavedChangesAction.discard && context.mounted) {
        Navigator.of(context).pop(false);
      }
    } else {
      Navigator.of(context).pop(false);
    }
  }
}