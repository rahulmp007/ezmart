import 'package:equatable/equatable.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  completed,
  cancelled,
}

class Order extends Equatable {
  final String id;
  final DateTime dateTime;
  final List<CartItem> items;
  final double total;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.dateTime,
    required this.items,
    required this.total,
    this.status = OrderStatus.confirmed,
  });

  Order copyWith({
    String? id,
    DateTime? dateTime,
    List<CartItem>? items,
    double? total,
    OrderStatus? status,
  }) {
    return Order(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      items: items ?? this.items,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, dateTime, items, total, status];
}

