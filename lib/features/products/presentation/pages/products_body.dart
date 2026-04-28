import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_view_widget.dart';
import '../widgets/loading_widget.dart';
import 'products_grid.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key, required this.state});

  final ProductState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.products.isEmpty) {
      return const LoadingWidget();
    }
    if (state.hasError && state.products.isEmpty) {
      return ErrorViewWidget(
        message: state.error!,
        onRetry: () => context.read<ProductCubit>().loadProducts(),
      );
    }
    if (state.isEmpty) return const EmptyStateWidget();
    return ProductsGrid(products: state.products, isLoading: state.isLoading);
  }
}
