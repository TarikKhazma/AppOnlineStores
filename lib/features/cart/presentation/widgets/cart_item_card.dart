import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CartCubit>();
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.md, vertical: AppSizes.xs),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sm),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              child: CachedNetworkImage(
                imageUrl: item.product.image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                placeholder: (_, _) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.shimmer,
                ),
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
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: AppTextStyles.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.price,
                  ),
                ],
              ),
            ),
            // Quantity controls
            Column(
              children: [
                IconButton(
                  onPressed: () => cubit.removeFromCart(item.product.id),
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: AppColors.error, size: AppSizes.iconSm),
                  tooltip: l10n.removeFromCart,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: AppSizes.xs),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.divider),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _QtyButton(
                        icon: Icons.remove,
                        onTap: () => cubit.decrement(item.product.id),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm),
                        child: Text(
                          '${item.quantity}',
                          style: AppTextStyles.titleSmall,
                        ),
                      ),
                      _QtyButton(
                        icon: Icons.add,
                        onTap: () => cubit.increment(item.product.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xs),
        child: Icon(icon, size: AppSizes.iconSm, color: AppColors.primary),
      ),
    );
  }
}
