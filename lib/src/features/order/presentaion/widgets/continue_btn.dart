import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/core/routing/app_router.dart';
import 'package:ezmart/src/features/cart/presentaion/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueButon extends StatelessWidget {
  const ContinueButon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<CartBloc>().add(ClearCartEvent());
          context.router.replaceAll([const ProductListing()]);
        },
        child: const Text('Continue Shopping'),
      ),
    );
  }
}
