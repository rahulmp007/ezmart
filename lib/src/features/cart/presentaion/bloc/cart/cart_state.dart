part of 'cart_bloc.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  CartLoaded(this.items);

  double get total => items.fold(0, (sum, e) {
   

    return sum + (e.price * e.quantity);
  });
}
