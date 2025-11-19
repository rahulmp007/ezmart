import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/product/data/model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
  Future<void> saveStock(int productId, int stock);
  Future<int?> getStock(int productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final LocalStorageService localStorageService;

  ProductLocalDataSourceImpl({required this.localStorageService});

  static const _productBox = 'PRODUCT_BOX';
  static const _stockBox = 'STOCK_BOX';

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final box = await localStorageService.openBox<ProductModel>(_productBox);

    // clear old data
    await box.clear();

    // store each product with its own key
    for (var p in products) {
      await box.put(p.id, p);
    }
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final box = await localStorageService.openBox<ProductModel>(_productBox);
    return box.values.toList();
  }

  @override
  Future<void> saveStock(int productId, int stock) async {
    final box = await localStorageService.openBox<int>(_stockBox);
    await box.put(productId, stock);
  }

  @override
  Future<int?> getStock(int productId) async {
    final box = await localStorageService.openBox<int>(_stockBox);
    return box.get(productId);
  }
}
