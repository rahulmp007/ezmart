import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> saveCartItems(List<CartItemModel> items);
  Future<void> removeCartItem(int productId);
  Future<void> removeAllCartItems();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final LocalStorageService localStorageService;

  CartLocalDataSourceImpl({required this.localStorageService});

  static const String _boxName = 'CART_BOX';

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final box = await localStorageService.openBox<CartItemModel>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final box = await localStorageService.openBox<CartItemModel>(_boxName);

    for (var c in items) {
      await box.put(c.productId, c);
    }
  }

  @override
  Future<void> removeAllCartItems() async {
    final box = await localStorageService.openBox<CartItemModel>(_boxName);
    await box.clear();
  }

  @override
  Future<void> removeCartItem(int productId) async {
    final box = await localStorageService.openBox<CartItemModel>(_boxName);
    if (box.containsKey(productId)) {
      await box.delete(productId);
    }
  }
}
