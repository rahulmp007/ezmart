import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';

class GetCartItems extends UseCase<List<CartItem>, NoParams> {
  final CartRepository repo;
  GetCartItems({required this.repo});
  @override
  Future<Either<AppError, List<CartItem>>> call(NoParams p) async =>
      await repo.getCartItems();
}
