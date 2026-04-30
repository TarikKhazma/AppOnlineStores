import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get totalCount => items.fold(0, (sum, i) => sum + i.quantity);
  double get totalPrice => items.fold(0.0, (sum, i) => sum + i.totalPrice);
  bool get isEmpty => items.isEmpty;
  bool isInCart(int productId) => items.any((i) => i.product.id == productId);

  CartState copyWith({List<CartItem>? items}) =>
      CartState(items: items ?? this.items);

  @override
  List<Object?> get props => [items];
}
