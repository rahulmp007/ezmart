import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:ezmart/src/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';
import 'package:ezmart/src/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ezmart/src/features/cart/domain/usecases/get_cart.dart';
import 'package:ezmart/src/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ezmart/src/features/cart/domain/usecases/update_cart_item.dart';
import 'package:ezmart/src/features/cart/presentaion/bloc/cart/cart_bloc.dart';
import 'package:ezmart/src/features/product/application/product_stock_service.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/injection/service_locator.dart';

Future<void> initCart() async {
  sl.registerLazySingleton<CartLocalDataSource>(
    () =>
        CartLocalDataSourceImpl(localStorageService: sl<LocalStorageService>()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl<CartLocalDataSource>()),
  );

  sl.registerLazySingleton<AddToCart>(
    () => AddToCart(repo: sl<CartRepository>()),
  );

  sl.registerLazySingleton<GetCartItems>(
    () => GetCartItems(repo: sl<CartRepository>()),
  );

  sl.registerLazySingleton<RemoveFromCart>(
    () => RemoveFromCart(repo: sl<CartRepository>()),
  );

  sl.registerLazySingleton<UpdateCartQuantity>(
    () => UpdateCartQuantity(repo: sl<CartRepository>()),
  );

  sl.registerFactory(
    () => CartBloc(
      addToCart: sl<AddToCart>(),
      getCartItems: sl<GetCartItems>(),
      removeFromCart: sl<RemoveFromCart>(),
      updateCartQty: sl<UpdateCartQuantity>(),
      stockService: sl<ProductStockService>(),
    ),
  );
}
