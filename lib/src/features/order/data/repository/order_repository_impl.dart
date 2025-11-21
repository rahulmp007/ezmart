import 'package:dartz/dartz.dart' hide Order;
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/order/data/datasources/order_local_datasource.dart';
import 'package:ezmart/src/features/order/data/mapper/order_mapper.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:ezmart/src/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<AppError, Order>> placeOrder(List<CartItem> items) async {
    try {
      if (items.isEmpty) {
        return Left(CacheError(message: 'Cart is empty'));
      }

      final total = items.fold<double>(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateTime: DateTime.now(),
        items: items,
        total: total,
        status: OrderStatus.confirmed,
      );

      final orderModel = OrderMapper.toModel(order);
      await localDataSource.saveOrder(orderModel);

      return Right(order);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<Order>>> getOrders() async {
    try {
      final orderModels = await localDataSource.getOrders();
      final orders = orderModels
          .map((model) => OrderMapper.toEntity(model))
          .toList();
      return Right(orders);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, Order>> getOrderById(String orderId) async {
    try {
      final orderModel = await localDataSource.getOrderById(orderId);
      if (orderModel == null) {
        return Left(CacheError(message: 'Order not found'));
      }
      return Right(OrderMapper.toEntity(orderModel));
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }
}
