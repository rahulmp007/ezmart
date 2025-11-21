import 'package:ezmart/src/features/product/data/mapper/rating_mapper.dart';

import '../model/product_model.dart';
import '../../domain/entity/product.dart';

class ProductMapper {
  static Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: RatingMapper.toEntity(model.rating),
      stockRemaining: model.stockRemaining,
    );
  }

  static ProductModel toModel(Product entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      image: entity.image,
      rating: RatingMapper.toModel(entity.rating),
      stockRemaining: entity.stockRemaining,
    );
  }
}
