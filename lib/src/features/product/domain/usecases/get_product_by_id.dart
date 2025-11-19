import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;
  GetProductByIdUseCase({required this.repository});

  Future<Either<AppError, Product>> call(int id) async {
    return await repository.getProductById(id);
  }
}
