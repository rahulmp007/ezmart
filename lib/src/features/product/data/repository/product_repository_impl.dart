import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/data/datasources/product_local_datasource.dart';
import 'package:ezmart/src/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ezmart/src/features/product/data/model/product_model.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AppError, List<Product>>> getProducts() async {
    try {
      List<ProductModel> currentSavedProducts = await localDataSource
          .getCachedProducts();

      if (currentSavedProducts.isNotEmpty) {
        log('fetching from LOCAL DB---------------------');
        return Right(
          currentSavedProducts
              .map((e) => e.toEntity(stockRemaining: e.stockRemaining ?? 50))
              .toList(),
        );
      }

      final remoteProductModels = await remoteDataSource.fetchProducts();

      await localDataSource.cacheProducts(remoteProductModels);

      final products = <Product>[];
      for (final m in remoteProductModels) {
        final p = m.toEntity(stockRemaining: m.stockRemaining ?? 50);
        products.add(p);
      }
      return Right(products);
    } on AppError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, Product>> getProductById(int id) async {
    try {
      final model = await remoteDataSource.fetchProductById(id);
      final savedStock = await localDataSource.getStock(id);
      final prod = model.toEntity(stockRemaining: savedStock ?? 50);
      return Right(prod);
    } catch (e) {
      try {
        final cached = await localDataSource.getCachedProducts();
        final found = cached.firstWhere((m) => m.id == id);
        final savedStock = await localDataSource.getStock(id);
        return Right(found.toEntity(stockRemaining: savedStock ?? 50));
      } catch (_) {
        return Left(ServerError(message: ''));
      }
    }
  }

  @override
  Future<Either<AppError, void>> updateStock(
    int productId,
    int newStock,
  ) async {
    try {
      await localDataSource.saveStock(productId, newStock);
      return Right(null);
    } catch (e) {
      return Left(CacheError(message: ''));
    }
  }
}
