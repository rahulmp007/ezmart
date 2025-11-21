import 'package:dartz/dartz.dart' hide Order;
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:ezmart/src/features/order/domain/repository/order_repository.dart';

class PlaceOrderUseCase implements UseCase<Order, List<CartItem>> {
  final OrderRepository repository;

  PlaceOrderUseCase({required this.repository});

  @override
  Future<Either<AppError, Order>> call(List<CartItem> params) async {
    return await repository.placeOrder(params);
  }
}

