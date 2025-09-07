import 'package:flutter/material.dart';
import '../../core/errors/app_errors.dart';
import '../../core/utils/error_messages.dart';

class ErrorBanner extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final bool showIcon;

  const ErrorBanner({
    super.key,
    required this.error,
    this.onRetry,
    this.onDismiss,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final errorMessage = ErrorMessages.getErrorMessage(error);
    final showRetryButton = ErrorMessages.shouldShowRetryButton(error);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showIcon) ...[
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade600,
                  size: 20,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red.shade800,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: onDismiss,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      color: Colors.red.shade600,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 32,
              child: TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red.shade700,
                  backgroundColor: Colors.red.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Try again',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}