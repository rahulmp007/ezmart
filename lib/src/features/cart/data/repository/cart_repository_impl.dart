import 'package:dartz/dartz.dart';
import 'package:ezmart/src/core/error/failure.dart';
import 'package:ezmart/src/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:ezmart/src/features/cart/data/mapper/cart_mapper.dart';
import 'package:ezmart/src/features/cart/data/models/cart_item_model.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<AppError, List<CartItem>>> getCartItems() async {
    try {
      final items = await localDataSource.getCartItems();
      return Right(items.map((e) => CartMapper.toEntity(e)).toList());
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, Unit>> addToCart(CartItem item) async {
    try {
      final current = await localDataSource.getCartItems();
      final existing = current.firstWhere(
        (e) => e.productId == item.productId,
        orElse: () => CartItemModel(
          productId: -1,
          title: '',
          image: '',
          price: 0,
          quantity: 0,
        ),
      );

      if (existing.productId != -1) {
        final updated = existing.copyWith(
          quantity: existing.quantity + item.quantity,
        );
        current[current.indexWhere((e) => e.productId == item.productId)] =
            updated;
      } else {
        current.add(CartMapper.toModel(item));
      }

      await localDataSource.saveCartItems(current);
      return const Right(unit);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, Unit>> removeFromCart(int productId) async {
    try {
      await localDataSource.removeCartItem(productId);
      return const Right(unit);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, Unit>> updateCartQuantity({
    required int productId,
    required int quantity,
  }) async {
    try {
      final current = await localDataSource.getCartItems();
      final index = current.indexWhere((e) => e.productId == productId);
      if (index == -1) return Left(CacheError(message: 'Item not found'));

      current[index] = current[index].copyWith(quantity: quantity);

      await localDataSource.saveCartItems(current);
      return const Right(unit);
    } catch (e) {
      return Left(CacheError(message: e.toString()));
    }
  }
}
