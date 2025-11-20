import 'dart:developer';

import 'package:ezmart/src/features/product/application/product_stock_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ezmart/src/features/cart/domain/usecases/get_cart.dart';
import 'package:ezmart/src/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ezmart/src/features/cart/domain/usecases/update_cart_item.dart';
import 'package:ezmart/src/features/cart/domain/usecases/params/update_cart_param.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartQuantity updateCartQty;
  final GetCartItems getCartItems;

  final ProductStockService stockService;

  CartBloc({
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartQty,
    required this.getCartItems,
    required this.stockService,
  }) : super(CartLoading()) {
    on<LoadCartEvent>(_load);
    on<AddCartEvent>(_add);
    on<RemoveCartEvent>(_remove);
    on<UpdateQtyEvent>(_updateQty);
  }

  Future<void> _load(LoadCartEvent event, Emitter emit) async {
    emit(CartLoading());
    final result = await getCartItems(NoParams());

    result.fold(
      (l) => emit(CartError(l.message)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> _add(AddCartEvent event, Emitter emit) async {
    final item = event.item;

    final currentStock = await stockService.getStock(item.productId);

    log('current stock : $currentStock');

    if (currentStock < item.quantity) {
      emit(CartError("Not enough stock"));
      return;
    }

    await stockService.decrease(item.productId, item.quantity);

    final res = await addToCart(item);

    res.fold((l) => emit(CartError(l.message)), (_) => add(LoadCartEvent()));
  }

  Future<void> _remove(RemoveCartEvent event, Emitter emit) async {
    final current = await getCartItems(NoParams());

    await current.fold((_) {}, (items) async {
      final item = items.firstWhere((e) => e.productId == event.productId);

      log('item : ${item.title} ${item.quantity}');
      await stockService.increase(item.productId, item.quantity);
    });

    final res = await removeFromCart(event.productId);

    res.fold((l) => emit(CartError(l.message)), (_) => add(LoadCartEvent()));
  }

  Future<void> _updateQty(UpdateQtyEvent event, Emitter emit) async {
    final cart = await getCartItems(NoParams());

    cart.fold((_) {}, (items) async {
      final item = items.firstWhere((e) => e.productId == event.productId);
      final oldQty = item.quantity;
      final newQty = event.quantity;

      if (newQty == oldQty) return;

      final currentStock = await stockService.getStock(item.productId);

      if (newQty > oldQty) {
        final needed = newQty - oldQty;
        if (currentStock < needed) {
          emit(CartError("Not enough stock"));
          return;
        }
        await stockService.decrease(item.productId, needed);
      } else {
        final restore = oldQty - newQty;
        await stockService.increase(item.productId, restore);
      }
    });

    await updateCartQty(
      UpdateCartQuantityParams(
        productId: event.productId,
        newStock: event.quantity,
      ),
    );

    add(LoadCartEvent());
  }
}
