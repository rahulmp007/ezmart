import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/order/data/datasources/order_local_datasource.dart';
import 'package:ezmart/src/features/order/data/repository/order_repository_impl.dart';
import 'package:ezmart/src/features/order/domain/repository/order_repository.dart';
import 'package:ezmart/src/features/order/domain/usecases/get_order_by_id.dart';
import 'package:ezmart/src/features/order/domain/usecases/get_orders.dart';
import 'package:ezmart/src/features/order/domain/usecases/place_order.dart';
import 'package:ezmart/src/features/order/presentaion/bloc/order/order_bloc.dart';
import 'package:ezmart/src/injection/service_locator.dart';

Future<void> initOrder() async {
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(
      localStorageService: sl<LocalStorageService>(),
    ),
  );

  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(localDataSource: sl<OrderLocalDataSource>()),
  );

  sl.registerLazySingleton(
    () => PlaceOrderUseCase(repository: sl<OrderRepository>()),
  );

  sl.registerLazySingleton(
    () => GetOrdersUseCase(repository: sl<OrderRepository>()),
  );

  sl.registerLazySingleton(
    () => GetOrderByIdUseCase(repository: sl<OrderRepository>()),
  );

  sl.registerFactory(
    () => OrderBloc(
      placeOrder: sl<PlaceOrderUseCase>(),
      getOrders: sl<GetOrdersUseCase>(),
      getOrderById: sl<GetOrderByIdUseCase>(),
    ),
  );
}
