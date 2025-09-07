import 'package:flutter/material.dart';
import '../../core/errors/app_errors.dart';
import '../../core/utils/error_messages.dart';
import '../../core/theme/app_colors.dart';

class ErrorState extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final String? customTitle;
  final IconData? icon;

  const ErrorState({
    super.key,
    required this.error,
    this.onRetry,
    this.customTitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final errorMessage = ErrorMessages.getErrorMessage(error);
    final showRetryButton = ErrorMessages.shouldShowRetryButton(error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: 16),
            Text(
              customTitle ?? 'Something went wrong',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}