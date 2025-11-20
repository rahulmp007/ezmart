import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';

abstract class CartRepository {
  Future<Either<AppError, List<CartItem>>> getCartItems();
  Future<Either<AppError, Unit>> addToCart(CartItem item);
  Future<Either<AppError, Unit>> removeFromCart(int productId);
  Future<Either<AppError, Unit>> updateCartQuantity({
    required int productId,
    required int quantity,
  });
}
