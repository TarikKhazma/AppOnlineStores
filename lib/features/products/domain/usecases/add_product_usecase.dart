import 'package:injectable/injectable.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class AddProductUseCase {
  final ProductRepository repository;

  const AddProductUseCase(this.repository);

  Future<void> call(ProductEntity product) => repository.addProduct(product);
}
