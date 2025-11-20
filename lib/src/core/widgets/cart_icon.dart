import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/core/routing/app_router.dart';
import 'package:ezmart/src/features/cart/presentaion/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int itemCount = 0;
        if (state is CartLoaded) {
          itemCount = state.items.length;
        }
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, size: 30),
              onPressed: () {
                context.router.push(const CartList());
              },
            ),
            if (itemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    '$itemCount',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
