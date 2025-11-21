import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';

class AddToCart extends UseCase<Unit, CartItem> {
  final CartRepository repo;
  AddToCart({required this.repo});
  @override
  Future<Either<AppError, Unit>> call(CartItem params) async =>
      await repo.addToCart(params);
}
