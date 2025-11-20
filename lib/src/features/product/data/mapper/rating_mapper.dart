import 'package:ezmart/src/features/product/data/model/rating_model.dart';
import 'package:ezmart/src/features/product/domain/entity/rating.dart';

class RatingMapper {
  static Rating toEntity(RatingModel? model) {
    return Rating(rate: model?.rate, count: model?.count);
  }

  static RatingModel toModel(Rating? entity) {
    return RatingModel(rate: entity?.rate, count: entity?.count);
  }
}
