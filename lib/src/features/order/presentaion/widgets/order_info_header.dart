import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:flutter/material.dart';

class OrderInfoHeader extends StatelessWidget {
  const OrderInfoHeader({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Icon(Icons.check_circle, size: 50, color: Colors.green),
        ),
        const SizedBox(height: 16),
        Text(
          'Order ID: ${order.id}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
