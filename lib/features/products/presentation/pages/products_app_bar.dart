import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.appName, style: AppTextStyles.appBarTitle),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (_, state) => Text(
              '${state.products.length} ${l10n.items}',
              style: AppTextStyles.caption
                  .copyWith(color: Colors.white70, fontSize: 11),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.xs),
          child: TextButton(
            onPressed: () => context.read<LanguageCubit>().toggleLanguage(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm,
                vertical: AppSizes.xs,
              ),
              minimumSize: const Size(0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
            ),
            child: Text(
              l10n.toggleLanguageLabel,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () => context.read<ProductCubit>().loadProducts(),
          tooltip: l10n.refresh,
        ),
      ],
    );
  }
}
