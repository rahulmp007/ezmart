import 'dart:developer';

import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';

class ProductStockService {
  final ProductRepository repository;

  ProductStockService({required this.repository});

  Future<int> getStock(int productId) async {
    final productRes = await repository.getProductById(productId);
    return productRes.fold((_) => 0, (p) => p.stockRemaining ?? 0);
  }

  Future<void> decrease(int productId, int qty) async {
    final current = await getStock(productId);
    final newStock = current - qty;
    log("current stock : $current");
    log("item added in cart: $qty");
    log("newStock : $newStock");
    await repository.updateStock(productId, newStock);
  }

  Future<void> increase(int productId, int qty) async {
    final current = await getStock(productId);
    final newStock = current + qty;
    log("current stock : $current");
    log("item added in cart: $qty");
    log("newStock : $newStock");

    await repository.updateStock(productId, newStock);
  }
}
