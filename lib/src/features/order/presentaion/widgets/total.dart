
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:flutter/widgets.dart';

class Total extends StatelessWidget {
  const Total({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '₹${order.total.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
