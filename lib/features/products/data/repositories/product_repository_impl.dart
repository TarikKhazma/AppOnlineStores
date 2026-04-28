import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  const ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final remote = await remoteDataSource.getProducts();
      await localDataSource.cacheProducts(remote);
    } on DioException {
      // Network unavailable 
    }
    final cached = await localDataSource.getCachedProducts();
    if (cached.isEmpty) {
      throw Exception('No products available. Please check your connection.');
    }
    return cached;
  }

  @override
  Future<void> addProduct(ProductEntity product) =>
      localDataSource.insertProduct(ProductModel.fromEntity(product));

  @override
  Future<void> deleteProduct(int productId) =>
      localDataSource.deleteProduct(productId);
}
