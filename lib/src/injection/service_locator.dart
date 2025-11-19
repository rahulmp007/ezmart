import 'package:ezmart/src/core/network/api_client.dart';
import 'package:ezmart/src/core/service/hive_service.dart';
import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/product/di/product_injection.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());

  sl.registerLazySingleton<HiveService>(() => HiveService());

  await initProduct();
}
