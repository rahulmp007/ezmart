// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/features/cart/domain/entity/cart_item.dart';
import 'package:ezmart/src/features/cart/presentaion/bloc/cart/cart_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_event.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/quantity/quantity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ezmart/src/features/product/domain/entity/product.dart';

import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_state.dart';

@RoutePage(name: 'ProductDetail')
class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuantityCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartLoaded) {
                  context.read<ProductBloc>().add(LoadProducts());
                }
              },
              builder: (context, state) {
                return BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is! ProductsLoaded) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final currentProduct = state.products.firstWhere(
                      (p) => p.id == product.id,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            currentProduct.image ?? "",
                            height: 200,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          currentProduct.title ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          currentProduct.description ?? "",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Price: ₹${currentProduct.price?.toStringAsFixed(2)}',
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Rating: ${currentProduct.rating?.rate} (${currentProduct.rating?.count})',
                        ),

                        const SizedBox(height: 8),

                        BlocSelector<QuantityCubit, int, int>(
                          selector: (qty) => qty,
                          builder: (context, quantity) {
                            final remaining =
                                (currentProduct.stockRemaining ?? 0) - quantity;

                            return Text(
                              'Stock: ${remaining < 0 ? 0 : remaining}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        BlocBuilder<QuantityCubit, int>(
                          builder: (context, quantity) {
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      context.read<QuantityCubit>().decrement(),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text('$quantity'),
                                IconButton(
                                  onPressed: () =>
                                      context.read<QuantityCubit>().increment(
                                        currentProduct.stockRemaining ?? 0,
                                      ),
                                  icon: const Icon(Icons.add),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed:
                                      (currentProduct.stockRemaining ?? 0) == 0
                                      ? null
                                      : () {
                                          context.read<CartBloc>().add(
                                            AddCartEvent(
                                              CartItem(
                                                productId: currentProduct.id!,
                                                title:
                                                    currentProduct.title ?? '',
                                                image:
                                                    currentProduct.image ?? '',
                                                price:
                                                    currentProduct.price ?? 0.0,
                                                quantity: quantity,
                                              ),
                                            ),
                                          );

                                          context.router.back();
                                        },
                                  child: const Text('Add to Cart'),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
