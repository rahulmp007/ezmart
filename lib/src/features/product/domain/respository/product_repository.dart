import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<AppError, List<Product>>> getProducts();
  Future<Either<AppError, Product>> getProductById(int id);
  Future<Either<AppError, void>> updateStock(int productId, int newStock);
}
