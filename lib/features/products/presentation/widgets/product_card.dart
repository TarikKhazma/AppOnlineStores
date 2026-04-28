import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../domain/entities/product_entity.dart';
import 'product_detail_sheet.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _openDetail(context),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'product-${product.id}',
          child: CachedNetworkImage(
            imageUrl: product.image,
            height: AppSizes.cardImageHeight,
            width: double.infinity,
            fit: BoxFit.contain,
            placeholder: (_, _) => Container(
              height: AppSizes.cardImageHeight,
              color: AppColors.shimmer,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ),
            errorWidget: (_, _, _) => Container(
              height: AppSizes.cardImageHeight,
              color: AppColors.shimmer,
              child: const Icon(
                Icons.broken_image_outlined,
                color: AppColors.textLight,
              ),
            ),
          ),
        ),
        Positioned(
          top: AppSizes.xs,
          right: AppSizes.xs,
          child: _DeleteButton(onPressed: onDelete),
        ),
        if (product.isLocal)
          Positioned(
            top: AppSizes.xs,
            left: AppSizes.xs,
            child: _Badge(
              label: context.l10n.newLabel,
              color: AppColors.badgeNew,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: AppTextStyles.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            children: [
              const Icon(Icons.star_rounded,
                  size: AppSizes.iconXs, color: AppColors.star),
              const SizedBox(width: 2),
              Text(
                product.ratingRate.toStringAsFixed(1),
                style: AppTextStyles.caption
                    .copyWith(fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 3),
              Text('(${product.ratingCount})', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.xs, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                  ),
                  child: Text(
                    product.category,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context) {
    final languageCubit = context.read<LanguageCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: languageCubit,
        child: ProductDetailSheet(product: product),
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

class _DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          boxShadow: [
            BoxShadow(
              color: AppColors.error.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: AppSizes.iconXs,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.xs, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
      ),
      child: Text(label, style: AppTextStyles.badge),
    );
  }
}
