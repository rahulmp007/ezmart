import 'dart:developer';

import 'package:ezmart/src/features/product/domain/respository/product_repository.dart';
import 'package:ezmart/src/features/product/domain/usecases/get_product_by_id.dart';
import 'package:ezmart/src/features/product/domain/usecases/params/update_stock_params.dart';
import 'package:ezmart/src/features/product/domain/usecases/update_stock.dart';

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
