import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/features/order/domain/entity/order.dart';
import 'package:ezmart/src/features/order/presentaion/widgets/continue_btn.dart';
import 'package:ezmart/src/features/order/presentaion/widgets/order_details.dart';
import 'package:ezmart/src/features/order/presentaion/widgets/order_info_header.dart';
import 'package:ezmart/src/features/order/presentaion/widgets/order_item.dart';
import 'package:ezmart/src/features/order/presentaion/widgets/total.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'OrderConfirmation')
class OrderConfirmationPage extends StatelessWidget {
  final Order order;
  const OrderConfirmationPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrientationBuilder(
            builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;

              if (isPortrait) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: OrderInfoHeader(order: order)),
                    const SizedBox(height: 24),
                    OrderDetails(order: order),
                    const SizedBox(height: 24),
                    Text(
                      'Items',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Expanded(child: OrderItems(order: order)),
                    const SizedBox(height: 12),
                    Total(order: order),
                    const SizedBox(height: 16),
                    ContinueButon(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: OrderInfoHeader(order: order)),
                          const SizedBox(height: 24),
                          OrderDetails(order: order),
                          const SizedBox(height: 24),
                          Total(order: order),
                          const SizedBox(height: 16),
                          ContinueButon(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Expanded(child: OrderItems(order: order)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
