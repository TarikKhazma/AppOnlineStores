import 'package:injectable/injectable.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductsUseCase {
  final ProductRepository repository;

  const GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() => repository.getProducts();
}
