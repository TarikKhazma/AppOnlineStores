import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';

class ErrorViewWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorViewWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: AppSizes.iconXl,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            Text(
              context.l10n.errorOccurred,
              style: AppTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.xl),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(context.l10n.retry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
