import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase _getProducts;
  final AddProductUseCase _addProduct;
  final DeleteProductUseCase _deleteProduct;

  ProductCubit({
    required GetProductsUseCase getProductsUseCase,
    required AddProductUseCase addProductUseCase,
    required DeleteProductUseCase deleteProductUseCase,
  })  : _getProducts = getProductsUseCase,
        _addProduct = addProductUseCase,
        _deleteProduct = deleteProductUseCase,
        super(const ProductState());

  Future<void> loadProducts() async {
    emit(state.copyWith(
      status: ProductStatus.loading,
      clearError: true,
      clearSuccess: true,
    ));
    try {
      final products = await _getProducts();
      emit(state.copyWith(products: products, status: ProductStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        error: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> addProduct(ProductEntity product) async {
    try {
      await _addProduct(product);
      final updated = List<ProductEntity>.from(state.products)
        ..insert(0, product);
      emit(state.copyWith(
        products: updated,
        success: ProductSuccess.added,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await _deleteProduct(productId);
      final updated =
          state.products.where((p) => p.id != productId).toList();
      emit(state.copyWith(
        products: updated,
        success: ProductSuccess.deleted,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        error: e.toString(),
      ));
    }
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
