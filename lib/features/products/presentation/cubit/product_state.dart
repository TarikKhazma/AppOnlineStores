import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, loaded, error }

enum ProductSuccess { added, deleted }

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final ProductStatus status;
  final String? error;
  final ProductSuccess? success;

  const ProductState({
    this.products = const [],
    this.status = ProductStatus.initial,
    this.error,
    this.success,
  });

  bool get isLoading => status == ProductStatus.loading;
  bool get hasError => error != null;
  bool get hasSuccess => success != null;
  bool get isEmpty => status == ProductStatus.loaded && products.isEmpty;

  ProductState copyWith({
    List<ProductEntity>? products,
    ProductStatus? status,
    String? error,
    ProductSuccess? success,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      error: clearError ? null : (error ?? this.error),
      success: clearSuccess ? null : (success ?? this.success),
    );
  }

  @override
  List<Object?> get props => [products, status, error, success];
}
