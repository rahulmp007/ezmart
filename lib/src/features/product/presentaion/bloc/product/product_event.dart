import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class RefreshProductsEvent extends ProductEvent {}

class LoadProductById extends ProductEvent {
  final int id;
  LoadProductById(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateStock extends ProductEvent {
  final int productId;
  final int newStock;
  UpdateStock(this.productId, this.newStock);
  @override
  List<Object?> get props => [productId, newStock];
}
