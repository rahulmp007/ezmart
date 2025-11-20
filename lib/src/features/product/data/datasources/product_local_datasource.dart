import 'dart:developer';

import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/product/data/model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
  Future<void> saveStock(int productId, int quantity);
  Future<int?> getStock(int productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final LocalStorageService localStorageService;

  ProductLocalDataSourceImpl({required this.localStorageService});

  static const _productBox = 'PRODUCT_BOX';

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final box = await localStorageService.openBox<ProductModel>(_productBox);

    await box.clear();

    for (var p in products) {
      log('saving : $p');
      await box.put(p.id, p);
    }

    log('items in local db : ${box.values.length}');
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final box = await localStorageService.openBox<ProductModel>(_productBox);

    log('CACHED items ---> ${box.values}');
    return box.values.toList();
  }

  @override
  Future<void> saveStock(int productId, int newStock) async {
    final ProductModel? currentProduct = await localStorageService
        .get<ProductModel>(_productBox, productId);
    if (currentProduct == null) return;

    final updatedProduct = currentProduct.copyWith(stockRemaining: newStock);

    log(
      "SAVING PRODUCT WITH ID : $productId WITH NEW STOCK VALUE : $updatedProduct",
    );
    await localStorageService.put(_productBox, productId, updatedProduct);
  }

  @override
  Future<int?> getStock(int productId) async {
    final ProductModel? currentProduct = await localStorageService
        .get<ProductModel>(_productBox, productId);
    if (currentProduct == null) return 0;
    return currentProduct.stockRemaining;
  }
}
