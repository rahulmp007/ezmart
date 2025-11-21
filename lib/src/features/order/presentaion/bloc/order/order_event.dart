part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends OrderEvent {
  final List<CartItem> items;
  PlaceOrderEvent(this.items);
  @override
  List<Object?> get props => [items];
}

class LoadOrdersEvent extends OrderEvent {}

class LoadOrderByIdEvent extends OrderEvent {
  final String orderId;
  LoadOrderByIdEvent(this.orderId);
  @override
  List<Object?> get props => [orderId];
}

