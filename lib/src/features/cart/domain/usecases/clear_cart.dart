import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';

class ClearCart extends UseCase<Unit, NoParams> {
  final CartRepository repo;
  ClearCart({required this.repo});

  @override
  Future<Either<AppError, Unit>> call(NoParams params) async =>
      await repo.clearCart();
}
