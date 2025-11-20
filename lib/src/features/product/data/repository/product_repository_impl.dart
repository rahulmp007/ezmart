import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/data/datasources/product_local_datasource.dart';
import 'package:ezmart/src/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ezmart/src/features/product/data/mapper/product_mapper.dart';
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

      log('CACHED PRODUCTS =========> $currentSavedProducts');

      if (currentSavedProducts.isNotEmpty) {
        log('fetching from LOCAL DB---------------------');
        return Right(
          currentSavedProducts
              .map(
                (e) => ProductMapper.toEntity(
                  e.copyWith(stockRemaining: e.stockRemaining ?? 50),
                ),
              )
              .toList(),
        );
      }

      final remoteProductModels = await remoteDataSource.fetchProducts();

      await localDataSource.cacheProducts(remoteProductModels);

      final products = <Product>[];
      for (final m in remoteProductModels) {
        final p = ProductMapper.toEntity(
          m.copyWith(stockRemaining: m.stockRemaining ?? 50),
        );

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
      final cached = await localDataSource.getCachedProducts();

      log('FROM LOCAL DB => $cached');

      final found = cached.firstWhere((m) => m.id == id);

      log('CURRENT ITEM => $found');

      return Right(
        ProductMapper.toEntity(
          found.copyWith(stockRemaining: found.stockRemaining ?? 50),
        ),
      );
    } catch (e) {
      return Left(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> updateStock(
    int productId,
    int quantity,
  ) async {
    try {
      await localDataSource.saveStock(productId, quantity);
      return Right(null);
    } catch (e) {
      return Left(CacheError(message: ''));
    }
  }
}
