import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product_cubit.dart';
import '../widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products, required this.isLoading});

  final List<ProductEntity> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProductCubit>().loadProducts(),
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          if (isLoading)
            const SliverToBoxAdapter(
              child: LinearProgressIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.primaryLight,
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSizes.md),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: AppSizes.gridCrossAxisCount,
              mainAxisSpacing: AppSizes.gridSpacing,
              crossAxisSpacing: AppSizes.gridSpacing,
              childCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                product: products[index],
                onDelete: () => _confirmDelete(context, products[index].id),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, int productId) {
    final l10n = context.l10n;
    final cubit = context.read<ProductCubit>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        title: Text(l10n.deleteProduct, style: AppTextStyles.titleMedium),
        content: Text(l10n.deleteConfirmation, style: AppTextStyles.bodyLarge),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n.cancel,
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                cubit.deleteProduct(productId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                minimumSize: const Size(80, 44),
              ),
              child: Text(l10n.delete),
            ),
          ),
        ],
      ),
    );
  }
}
