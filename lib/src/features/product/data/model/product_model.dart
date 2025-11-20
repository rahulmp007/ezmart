import 'package:ezmart/src/features/product/data/model/rating_model.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ProductModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String? category;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final RatingModel? rating;
  @HiveField(7)
  final int? stockRemaining;

  const ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.stockRemaining,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    RatingModel? rating,
    int? stockRemaining,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      stockRemaining: stockRemaining ?? this.stockRemaining,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id,stockRemaining: $stockRemaining)';
  }
}
