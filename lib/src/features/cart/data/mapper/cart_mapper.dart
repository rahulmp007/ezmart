import 'package:ezmart/src/features/cart/data/models/cart_item_model.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';

class CartMapper {
  static CartItem toEntity(CartItemModel model) => CartItem(
    productId: model.productId,
    title: model.title,
    image: model.image,
    price: model.price,
    quantity: model.quantity,
  );

  static CartItemModel toModel(CartItem e) => CartItemModel(
    productId: e.productId,
    title: e.title,
    image: e.image,
    price: e.price,
    quantity: e.quantity,
  );
}
