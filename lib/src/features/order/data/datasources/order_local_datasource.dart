import 'package:ezmart/src/core/service/local_storage.dart';
import 'package:ezmart/src/features/order/data/models/order_model.dart';

abstract class OrderLocalDataSource {
  Future<void> saveOrder(OrderModel order);
  Future<List<OrderModel>> getOrders();
  Future<OrderModel?> getOrderById(String orderId);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final LocalStorageService localStorageService;

  OrderLocalDataSourceImpl({required this.localStorageService});

  static const String _orderBox = 'ORDER_BOX';

  @override
  Future<void> saveOrder(OrderModel order) async {
    await localStorageService.put(_orderBox, order.id, order);
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final orders = await localStorageService.getAll<OrderModel>(_orderBox);
    orders.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return orders;
  }

  @override
  Future<OrderModel?> getOrderById(String orderId) async {
    return await localStorageService.get<OrderModel>(_orderBox, orderId);
  }
}
