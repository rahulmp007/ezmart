import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';
import 'package:ezmart/src/features/product/domain/usecases/params/update_stock_params.dart';

class UpdateStockUseCase {
  final ProductRepository repository;
  UpdateStockUseCase({required this.repository});

  Future<Either<AppError, void>> call({
    required UpdateStockParams params,
  }) async {
    return await repository.updateStock(params.productId, params.quantity);
  }
}
