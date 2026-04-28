import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'products_app_bar.dart';
import 'products_body.dart';
import 'products_fab.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) => Scaffold(
        appBar: const ProductsAppBar(),
        body: BlocConsumer<ProductCubit, ProductState>(
          listener: _onStateChanged,
          builder: (ctx, state) => ProductsBody(state: state),
        ),
        floatingActionButton: const ProductsFAB(),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ProductState state) {
    final l10n = context.l10n;
    if (state.hasError && state.products.isNotEmpty) {
      _showSnackBar(
        context: context,
        message: state.error!,
        icon: Icons.error_outline_rounded,
        color: AppColors.error,
      );
      context.read<ProductCubit>().clearMessages();
    } else if (state.hasSuccess) {
      _showSnackBar(
        context: context,
        message: state.success == ProductSuccess.added
            ? l10n.productAdded
            : l10n.productDeleted,
        icon: Icons.check_circle_outline_rounded,
        color: AppColors.success,
      );
      context.read<ProductCubit>().clearMessages();
    }
  }

  void _showSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white, size: AppSizes.iconMd),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: color,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
