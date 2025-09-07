import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/note_view_model.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSave;
  final VoidCallback? onDelete;
  final VoidCallback? onClose;

  const NoteAppBar({
    super.key,
    this.onSave,
    this.onDelete,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NoteViewModel>();
    
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppColors.primaryText),
        onPressed: onClose,
      ),
      actions: [
        if (!viewModel.isNewNote)
          Selector<NoteViewModel, bool>(
            selector: (_, vm) => vm.isLoading,
            builder: (context, isLoading, _) {
              return IconButton(
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryText,
                        ),
                      )
                    : const Icon(Icons.delete_forever, color: AppColors.primaryText),
                onPressed: isLoading ? null : onDelete,
                tooltip: 'Delete note',
              );
            },
          ),
        Selector<NoteViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder: (context, isLoading, _) => IconButton(
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryText,
                    ),
                  )
                : const Icon(Icons.save, color: AppColors.primaryText),
            onPressed: isLoading ? null : onSave,
            tooltip: 'Save note',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}