import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double ratingRate;
  final int ratingCount;
  final bool isLocal;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.ratingRate = 0.0,
    this.ratingCount = 0,
    this.isLocal = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        ratingRate,
        ratingCount,
        isLocal,
      ];
}
