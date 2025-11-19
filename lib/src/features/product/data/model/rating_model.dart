import 'package:ezmart/src/features/product/domain/entity/rating.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class RatingModel {
  @HiveField(0)
  final double? rate;
  @HiveField(1)

  final int? count;

  const RatingModel({this.rate, this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  Rating toEntity() => Rating(rate: rate, count: count);

  RatingModel copyWith({
    double? rate,
    int? count,
  }) {
    return RatingModel(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }
}
