import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_state.dart';

class ProductsGridListWidget extends StatelessWidget {
  const ProductsGridListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is! ProductsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = state.products;

        return OrientationBuilder(
          builder: (context,orientation) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ?  2 : 4,
                childAspectRatio: 0.70,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }
        );
      },
    );
  }
}
