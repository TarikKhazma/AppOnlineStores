import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/product_entity.dart';

class FavoritesState extends Equatable {
  final List<ProductEntity> products;

  const FavoritesState({this.products = const []});

  bool isFavorite(int productId) => products.any((p) => p.id == productId);
  bool get isEmpty => products.isEmpty;

  FavoritesState copyWith({List<ProductEntity>? products}) =>
      FavoritesState(products: products ?? this.products);

  @override
  List<Object?> get props => [products];
}
