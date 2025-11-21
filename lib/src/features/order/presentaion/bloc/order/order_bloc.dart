import 'package:equatable/equatable.dart';
import 'package:ezmart/src/core/usecase/usecase.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:ezmart/src/features/order/domain/usecases/get_order_by_id.dart';
import 'package:ezmart/src/features/order/domain/usecases/get_orders.dart';
import 'package:ezmart/src/features/order/domain/usecases/place_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUseCase placeOrder;
  final GetOrdersUseCase getOrders;
  final GetOrderByIdUseCase getOrderById;

  OrderBloc({
    required this.placeOrder,
    required this.getOrders,
    required this.getOrderById,
  }) : super(OrderInitial()) {
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<LoadOrdersEvent>(_onLoadOrders);
    on<LoadOrderByIdEvent>(_onLoadOrderById);
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await placeOrder(event.items);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderPlaced(order)),
    );
  }

  Future<void> _onLoadOrders(
    LoadOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await getOrders(NoParams());
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> _onLoadOrderById(
    LoadOrderByIdEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    final result = await getOrderById(event.orderId);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderLoaded(order)),
    );
  }
}

