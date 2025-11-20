import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class CartItemModel {
  @HiveField(0)
  final int productId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final int quantity;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  CartItemModel copyWith({
    int? productId,
    String? title,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
