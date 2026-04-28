import 'package:injectable/injectable.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class DeleteProductUseCase {
  final ProductRepository repository;

  const DeleteProductUseCase(this.repository);

  Future<void> call(int productId) => repository.deleteProduct(productId);
}
