import 'package:equatable/equatable.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  ProductsLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductLoaded extends ProductState {
  final Product product;
  ProductLoaded(this.product);
  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}
