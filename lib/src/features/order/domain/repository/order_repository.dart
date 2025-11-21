import 'package:dartz/dartz.dart' hide Order;
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';

abstract class OrderRepository {
  Future<Either<AppError, Order>> placeOrder(List<CartItem> items);
  Future<Either<AppError, List<Order>>> getOrders();
  Future<Either<AppError, Order>> getOrderById(String orderId);
}
