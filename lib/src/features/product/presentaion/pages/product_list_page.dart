import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/core/routing/app_router.dart';
import 'package:ezmart/src/core/widgets/cart_icon.dart';
import 'package:ezmart/src/features/cart/presentaion/bloc/cart/cart_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_event.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_state.dart';
import 'package:ezmart/src/features/product/presentaion/widgets/products_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'ProductListing')
class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Products'),
        scrolledUnderElevation: 0,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 16), child: CartIcon()),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(LoadProducts());
        },
        child: SafeArea(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductsLoaded) {
                return ProductsGridListWidget();
              }
              if (state is ProductError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
