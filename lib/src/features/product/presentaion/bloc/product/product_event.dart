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

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);
}

class FilterProducts extends ProductEvent {
  final String? category;
  final double? minRating;
  FilterProducts({this.category, this.minRating});
}

class SortProducts extends ProductEvent {
  final String sortBy;
  final bool ascending;
  SortProducts({required this.sortBy, required this.ascending});
}
