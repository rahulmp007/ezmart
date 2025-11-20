import 'package:ezmart/src/core/network/api_client.dart';
import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/product/application/product_stock_service.dart';
import 'package:ezmart/src/features/product/data/datasources/product_local_datasource.dart';
import 'package:ezmart/src/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ezmart/src/features/product/data/repository/product_repository_impl.dart';
import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';
import 'package:ezmart/src/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ezmart/src/features/product/domain/usecases/get_products.dart';
import 'package:ezmart/src/features/product/domain/usecases/update_stock.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/injection/service_locator.dart';

Future<void> initProduct() async {
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(
      localStorageService: sl<LocalStorageService>(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl<ProductRemoteDataSource>(),
      localDataSource: sl<ProductLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<ProductStockService>(
    () => ProductStockService(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton(
    () => GetProductsUsecase(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton(
    () => GetProductByIdUseCase(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton(
    () => UpdateStockUseCase(repository: sl<ProductRepository>()),
  );

  sl.registerFactory(
    () => ProductBloc(
      getProducts: sl<GetProductsUsecase>(),
      getProductById: sl<GetProductByIdUseCase>(),
      updateStock: sl<UpdateStockUseCase>(),
    ),
  );
}
