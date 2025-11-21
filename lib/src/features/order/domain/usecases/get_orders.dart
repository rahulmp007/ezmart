import 'package:dartz/dartz.dart' hide Order;
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:ezmart/src/features/order/domain/repository/order_repository.dart';

class GetOrdersUseCase implements UseCase<List<Order>, NoParams> {
  final OrderRepository repository;

  GetOrdersUseCase({required this.repository});

  @override
  Future<Either<AppError, List<Order>>> call(NoParams params) async {
    return await repository.getOrders();
  }
}

