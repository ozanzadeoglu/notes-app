import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/note_view_model.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../common/error_banner.dart';

class ErrorMessageWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const ErrorMessageWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<NoteViewModel, AppError?>(
      selector: (_, vm) => vm.errorMessage,
      builder: (context, errorMessage, _) {
        if (errorMessage != null) {
          return ErrorBanner(
            error: errorMessage,
            onRetry: onRetry,
            onDismiss: () => context.read<NoteViewModel>().clearError(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}