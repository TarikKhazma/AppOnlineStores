import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailSheet extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) {
        final l10n = context.l10n;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.bottomSheetRadius),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Handle(),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.lg, 0, AppSizes.lg, AppSizes.xxl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(),
                      const SizedBox(height: AppSizes.md),
                      _buildBadgeRow(l10n),
                      const SizedBox(height: AppSizes.sm),
                      Text(product.title, style: AppTextStyles.titleLarge),
                      const SizedBox(height: AppSizes.sm),
                      _buildRatingRow(l10n),
                      const SizedBox(height: AppSizes.md),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.priceDisplay,
                      ),
                      const SizedBox(height: AppSizes.md),
                      const Divider(),
                      const SizedBox(height: AppSizes.sm),
                      Text(l10n.description, style: AppTextStyles.titleSmall),
                      const SizedBox(height: AppSizes.xs),
                      Text(
                        product.description,
                        style: AppTextStyles.bodyLarge
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: 'product-${product.id}',
      child: Center(
        child: CachedNetworkImage(
          imageUrl: product.image,
          height: 220,
          fit: BoxFit.contain,
          placeholder: (_, _) => Container(
            height: 220,
            color: AppColors.shimmer,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            ),
          ),
          errorWidget: (_, _, _) => Container(
            height: 220,
            color: AppColors.shimmer,
            child: const Icon(Icons.broken_image_outlined,
                size: 48, color: AppColors.textLight),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeRow(AppLocalizations l10n) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.sm, vertical: AppSizes.xs),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          ),
          child: Text(
            product.category.toUpperCase(),
            style: AppTextStyles.badge
                .copyWith(color: AppColors.primary, fontSize: 10),
          ),
        ),
        if (product.isLocal) ...[
          const SizedBox(width: AppSizes.xs),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm, vertical: AppSizes.xs),
            decoration: BoxDecoration(
              color: AppColors.badgeNew,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Text(l10n.newLabel, style: AppTextStyles.badge),
          ),
        ],
      ],
    );
  }

  Widget _buildRatingRow(AppLocalizations l10n) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          return Icon(
            i < product.ratingRate.round()
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            color: AppColors.star,
            size: AppSizes.iconSm,
          );
        }),
        const SizedBox(width: AppSizes.xs),
        Text(
          '${product.ratingRate.toStringAsFixed(1)} '
          '(${product.ratingCount} ${l10n.reviews})',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      width: AppSizes.handleWidth,
      height: AppSizes.handleHeight,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
      ),
    );
  }
}
