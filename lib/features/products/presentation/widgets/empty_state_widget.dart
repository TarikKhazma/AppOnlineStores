import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: AppSizes.iconXl,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text(
            context.l10n.noProducts,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            context.l10n.addFirstProduct,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
