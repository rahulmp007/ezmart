import 'package:ezmart/src/features/cart/data/mapper/cart_mapper.dart';
import 'package:ezmart/src/features/order/data/models/order_model.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';

class OrderMapper {
  static Order toEntity(OrderModel model) {
    return Order(
      id: model.id,
      dateTime: model.dateTime,
      items: model.items.map((item) => CartMapper.toEntity(item)).toList(),
      total: model.total,
      status: model.status,
    );
  }

  static OrderModel toModel(Order entity) {
    return OrderModel(
      id: entity.id,
      dateTime: entity.dateTime,
      items: entity.items
          .map((item) => CartMapper.toModel(item))
          .toList(),
      total: entity.total,
      statusIndex: entity.status.index,
    );
  }
}

