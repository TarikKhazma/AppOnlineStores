import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  const ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(ApiEndpoints.products);
    final data = response.data as List;
    return data
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
