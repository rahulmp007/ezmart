import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';
import 'package:ezmart/src/features/cart/domain/usecases/params/update_cart_param.dart';

class UpdateCartQuantity implements UseCase<Unit, UpdateCartQuantityParams> {
  final CartRepository repo;

  UpdateCartQuantity({required this.repo});

  @override
  Future<Either<AppError, Unit>> call(UpdateCartQuantityParams params) {
    return repo.updateCartQuantity(
      productId: params.productId,
      quantity: params.newStock,
    );
  }
}
