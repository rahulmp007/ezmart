import 'package:dartz/dartz.dart' hide Order;
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:ezmart/src/features/order/domain/repository/order_repository.dart';

class GetOrderByIdUseCase {
  final OrderRepository repository;

  GetOrderByIdUseCase({required this.repository});

  Future<Either<AppError, Order>> call(String orderId) async {
    return await repository.getOrderById(orderId);
  }
}

