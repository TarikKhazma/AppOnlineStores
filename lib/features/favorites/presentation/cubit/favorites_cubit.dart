import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/domain/entities/product_entity.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggle(ProductEntity product) {
    if (state.isFavorite(product.id)) {
      emit(state.copyWith(
        products: state.products.where((p) => p.id != product.id).toList(),
      ));
    } else {
      emit(state.copyWith(products: [...state.products, product]));
    }
  }
}
