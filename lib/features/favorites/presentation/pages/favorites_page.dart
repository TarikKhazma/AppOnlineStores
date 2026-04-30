import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) {
        final l10n = context.l10n;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.favorites, style: AppTextStyles.appBarTitle),
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state.isEmpty) return _EmptyFavorites(l10n: l10n);
              return _FavoritesList(products: state.products, l10n: l10n);
            },
          ),
        );
      },
    );
  }
}

// Empty State 

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border_rounded,
              size: AppSizes.iconXxl, color: AppColors.textLight),
          const SizedBox(height: AppSizes.md),
          Text(l10n.favoritesEmpty, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSizes.xs),
          Text(l10n.favoritesEmptySubtitle,
              style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// List 

class _FavoritesList extends StatelessWidget {
  const _FavoritesList({required this.products, required this.l10n});
  final List<ProductEntity> products;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: AppSizes.sm,
        bottom: AppSizes.xxl + AppSizes.lg,
      ),
      itemCount: products.length,
      itemBuilder: (_, i) => _FavoriteCard(product: products[i], l10n: l10n),
    );
  }
}

// Favorite Card 

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.product, required this.l10n});
  final ProductEntity product;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.md, vertical: AppSizes.xs),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sm),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                placeholder: (_, _) =>
                    Container(width: 80, height: 80, color: AppColors.shimmer),
                errorWidget: (_, _, _) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.shimmer,
                  child: const Icon(Icons.broken_image_outlined,
                      color: AppColors.textLight),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: AppTextStyles.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: AppSizes.xs),
                  Text('\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.price),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.read<FavoritesCubit>().toggle(product),
              icon: const Icon(Icons.favorite_rounded,
                  color: Colors.red, size: AppSizes.iconMd),
            ),
          ],
        ),
      ),
    );
  }
}
