import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import 'product_local_datasource.dart';


class ProductLocalDataSourceWeb implements ProductLocalDataSource {
  static const String _key = 'products_cache';

  //  Read 

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((j) => _fromMap(j as Map<String, dynamic>))
        .toList();
  }

  // Write 

  @override
  Future<void> cacheProducts(List<ProductModel> remoteProducts) async {
    // Keep locally added products; replace remote ones.
    final existing = await getCachedProducts();
    final local = existing.where((p) => p.isLocal).toList();
    final merged = [...local, ...remoteProducts];
    await _save(merged);
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    final existing = await getCachedProducts();
    await _save([product, ...existing]);
  }

  @override
  Future<void> deleteProduct(int productId) async {
    final existing = await getCachedProducts();
    await _save(existing.where((p) => p.id != productId).toList());
  }

  // Helpers

  Future<void> _save(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(products.map(_toMap).toList()),
    );
  }

  Map<String, dynamic> _toMap(ProductModel p) => {
        'id': p.id,
        'title': p.title,
        'price': p.price,
        'description': p.description,
        'category': p.category,
        'image': p.image,
        'rating_rate': p.ratingRate,
        'rating_count': p.ratingCount,
        'is_local': p.isLocal,
      };

  ProductModel _fromMap(Map<String, dynamic> m) => ProductModel(
        id: m['id'] as int,
        title: m['title'] as String,
        price: (m['price'] as num).toDouble(),
        description: m['description'] as String,
        category: m['category'] as String,
        image: m['image'] as String,
        ratingRate: (m['rating_rate'] as num?)?.toDouble() ?? 0.0,
        ratingCount: m['rating_count'] as int? ?? 0,
        isLocal: m['is_local'] as bool? ?? false,
      );
}
