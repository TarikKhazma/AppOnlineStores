import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(ProductEntity product) {
    final idx = state.items.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      final updated = List<CartItem>.from(state.items);
      updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity + 1);
      emit(state.copyWith(items: updated));
    } else {
      emit(state.copyWith(items: [...state.items, CartItem(product: product)]));
    }
  }

  void removeFromCart(int productId) {
    emit(state.copyWith(
      items: state.items.where((i) => i.product.id != productId).toList(),
    ));
  }

  void increment(int productId) {
    emit(state.copyWith(
      items: state.items.map((i) {
        return i.product.id == productId
            ? i.copyWith(quantity: i.quantity + 1)
            : i;
      }).toList(),
    ));
  }

  void decrement(int productId) {
    final item = state.items.firstWhere((i) => i.product.id == productId);
    if (item.quantity <= 1) {
      removeFromCart(productId);
    } else {
      emit(state.copyWith(
        items: state.items.map((i) {
          return i.product.id == productId
              ? i.copyWith(quantity: i.quantity - 1)
              : i;
        }).toList(),
      ));
    }
  }

  void clear() => emit(const CartState());
}
