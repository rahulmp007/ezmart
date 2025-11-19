import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';

class UpdateStockUseCase {
  final ProductRepository repository;
  UpdateStockUseCase({required this.repository});

  Future<Either<AppError, void>> call(int productId, int newStock) async {
    return await repository.updateStock(productId, newStock);
  }
}
