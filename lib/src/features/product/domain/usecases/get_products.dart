import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';

class GetProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;
  GetProductsUsecase({required this.repository});

  @override
  Future<Either<AppError, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
