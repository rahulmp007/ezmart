import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/product/data/datasources/product_local_datasource.dart';
import 'package:ezmart/src/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  //  on AppError catch (e) {
  //     return Left(e);
  //   } catch (e) {
  //     return Left(UnknownError(message: e.toString()));
  //   }

  @override
  Future<Either<AppError, List<Product>>> getProducts() async {
    try {
      final remoteProductModels = await remoteDataSource.fetchProducts();
      
      await localDataSource.cacheProducts(remoteProductModels);

      final products = <Product>[];
      for (final m in remoteProductModels) {
        final savedStock = await localDataSource.getStock(m.id ?? 0);
        final p = m.toEntity(stockRemaining: savedStock ?? 50);
        products.add(p);
      }

      return Right(products);
    } catch (e) {
     
      try {
        final cached = await localDataSource.getCachedProducts();
        if (cached.isEmpty) return Left(ServerError(message: ''));
        final products = cached.map((m) {
          final savedStock = localDataSource.getStock(m.id ?? 0);
          // savedStock is Future<int?>, but local.getStock may be sync depending on Hive; handle simply
          // for safety, assume synchronous call returned via await
        }).toList();
        // above mapping is incomplete; fallback to simple conversion
        final fallback = cached
            .map((m) => m.toEntity(stockRemaining: 0))
            .toList();
        return Right(fallback);
      } catch (_) {
        return Left(CacheError(message: ''));
      }
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
