import 'package:ezmart/src/features/cart/data/models/cart_item_model.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class OrderModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final List<CartItemModel> items;

  @HiveField(3)
  final double total;

  @HiveField(4)
  @JsonKey(name: 'status')
  final int statusIndex;

  OrderModel({
    required this.id,
    required this.dateTime,
    required this.items,
    required this.total,
    required this.statusIndex,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    String? id,
    DateTime? dateTime,
    List<CartItemModel>? items,
    double? total,
    int? statusIndex,
  }) {
    return OrderModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      items: items ?? this.items,
      total: total ?? this.total,
      statusIndex: statusIndex ?? this.statusIndex,
    );
  }

  OrderStatus get status => OrderStatus.values[statusIndex];
}

