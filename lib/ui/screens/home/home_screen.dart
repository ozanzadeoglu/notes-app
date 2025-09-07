import 'package:connectinno_case_client/ui/screens/home/viewmodel/home_viewmodel.dart';
import 'package:connectinno_case_client/ui/screens/home/widgets/no_notes_view.dart';
import 'package:connectinno_case_client/ui/screens/home/widgets/notes_and_sync_row.dart';
import 'package:connectinno_case_client/ui/screens/home/widgets/user_profile_header.dart';
import 'package:connectinno_case_client/ui/screens/home/widgets/staggered_notes_grid.dart';
import 'package:connectinno_case_client/core/theme/app_colors.dart';
import 'package:connectinno_case_client/ui/common/error_banner.dart';
import 'package:connectinno_case_client/ui/common/error_snackbar.dart';
import 'package:connectinno_case_client/ui/common/error_state.dart';
import 'package:connectinno_case_client/core/errors/app_errors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isInitialized = context.select<HomeViewModel, bool>((vm) => vm.isInitialized);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 96),
        child: SafeArea(child: UserProfileHeader())),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // User Profile Header
            // const UserProfileHeader(),

            // Title and Sync Status
            Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return NotesAndSyncRow(
                  () => _handleManualSync(context, viewModel),
                  viewModel.isLoading,
                );
              },
            ),

            // Error Banner for persistent errors
            Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.error != null) {
                  return ErrorBanner(
                    error: viewModel.error!,
                    onRetry: () => _handleRetryLoadNotes(context, viewModel),
                    onDismiss: () {
                      viewModel.clearError();
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 16),

            // Notes Grid
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  // Show error state for critical failures
                  if (viewModel.error != null && viewModel.notes.isEmpty) {
                    return ErrorState(
                      error: viewModel.error!,
                      onRetry: () => _handleRetryLoadNotes(context, viewModel),
                    );
                  }
                  
                  if (viewModel.notes.isEmpty && isInitialized) {
                    return NoNotesView();
                  }
                  
                  return StaggeredNotesGrid(
                    notes: viewModel.notes,
                    onNoteTap: (note) async {
                      final result = await context.pushNamed(
                        'note',
                        extra: {'note': note, 'isNew': false},
                      );
                      if (result == true && context.mounted) {
                        viewModel.refreshNotes();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return FloatingActionButton(
            onPressed: viewModel.isLoading
                ? null
                : () async {
                    final result = await context.pushNamed(
                      'note',
                      extra: {'isNew': true},
                    );
                    if (result == true && context.mounted) {
                      viewModel.refreshNotes();
                    }
                  },
            backgroundColor: AppColors.accent,
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
    );
  }

  Future<void> _handleManualSync(BuildContext context, HomeViewModel viewModel) async {
    try {
      await viewModel.triggerManualSync();
      if (context.mounted) {
        ErrorSnackbar.showSuccess(context, 'Sync completed successfully');
      }
    } catch (e) {
      if (context.mounted) {
        ErrorSnackbar.show(
          context,
          AppError.syncFailed,
          onRetry: () => _handleManualSync(context, viewModel),
        );
      }
    }
  }

  Future<void> _handleRetryLoadNotes(BuildContext context, HomeViewModel viewModel) async {
    await viewModel.refreshNotes();
    if (viewModel.error == null && context.mounted) {
      ErrorSnackbar.showSuccess(context, 'Notes loaded successfully');
    }
  }
}
