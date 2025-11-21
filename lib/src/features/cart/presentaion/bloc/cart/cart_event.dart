part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class AddCartEvent extends CartEvent {
  final CartItem item;
  AddCartEvent(this.item);
}

class RemoveCartEvent extends CartEvent {
  final int productId;
  RemoveCartEvent(this.productId);
}

class UpdateQtyEvent extends CartEvent {
  final int productId;
  final int quantity;
  UpdateQtyEvent(this.productId, this.quantity);
}

class ClearCartEvent extends CartEvent {}
