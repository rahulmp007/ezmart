part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderPlaced extends OrderState {
  final Order order;
  OrderPlaced(this.order);
  @override
  List<Object?> get props => [order];
}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  OrdersLoaded(this.orders);
  @override
  List<Object?> get props => [orders];
}

class OrderLoaded extends OrderState {
  final Order order;
  OrderLoaded(this.order);
  @override
  List<Object?> get props => [order];
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
  @override
  List<Object?> get props => [message];
}

