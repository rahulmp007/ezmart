import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';

class RemoveFromCart extends UseCase<Unit, int> {
  final CartRepository repo;
  RemoveFromCart({required this.repo});
  @override
  Future<Either<AppError, Unit>> call(int productId) =>
      repo.removeFromCart(productId);
}
