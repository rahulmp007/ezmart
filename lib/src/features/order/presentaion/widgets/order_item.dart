import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: order.items.length,
      itemBuilder: (context, index) {
        final item = order.items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Image.network(
              item.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item.title),
            subtitle: Text('Qty: ${item.quantity}'),
            trailing: Text(
              '₹${(item.price * item.quantity).toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
