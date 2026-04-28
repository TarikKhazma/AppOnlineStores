import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    super.ratingRate,
    super.ratingCount,
    super.isLocal,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rating = json['rating'] as Map<String, dynamic>?;
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      ratingRate: (rating?['rate'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (rating?['count'] as num?)?.toInt() ?? 0,
      isLocal: false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': {'rate': ratingRate, 'count': ratingCount},
      };

  // SQLite 

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'] as int,
        title: map['title'] as String,
        price: map['price'] as double,
        description: map['description'] as String,
        category: map['category'] as String,
        image: map['image'] as String,
        ratingRate: (map['rating_rate'] as num?)?.toDouble() ?? 0.0,
        ratingCount: map['rating_count'] as int? ?? 0,
        isLocal: (map['is_local'] as int? ?? 0) == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating_rate': ratingRate,
        'rating_count': ratingCount,
        'is_local': isLocal ? 1 : 0,
      };

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        category: entity.category,
        image: entity.image,
        ratingRate: entity.ratingRate,
        ratingCount: entity.ratingCount,
        isLocal: entity.isLocal,
      );
}
