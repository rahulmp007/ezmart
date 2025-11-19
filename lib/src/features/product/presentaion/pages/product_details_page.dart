import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_event.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int qty = 1;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductById(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading)
            return Center(child: CircularProgressIndicator());
          if (state is ProductLoaded) {
            final p = state.product;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(p.image ?? "", height: 200)),
                  SizedBox(height: 12),
                  Text(
                    p.title ?? "",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    p.description ?? "",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text('Price: ₹${p.price?.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  Text('Rating: ${p.rating} (${p.rating?.count})'),
                  SizedBox(height: 8),
                  Text('Stock: ${p.stockRemaining}'),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        onPressed: qty > 1 ? () => setState(() => qty--) : null,
                        icon: Icon(Icons.remove),
                      ),
                      Text('$qty'),
                      IconButton(
                        onPressed: qty < 0 ? () => setState(() => qty++) : null,
                        icon: Icon(Icons.add),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: (p.stockRemaining ?? 0) <= 0
                            ? null
                            : () async {
                                // Here you'd call add to cart usecase from cart feature (not in this product feature code)
                                // For now, update stock locally by reducing qty and notify
                                final newStock = (p.stockRemaining ?? 0) - qty;
                                context.read<ProductBloc>().add(
                                  UpdateStock(p.id ?? 0, newStock),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to cart (local).'),
                                  ),
                                );
                              },
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          if (state is ProductError) return Center(child: Text(state.message));
          return Center(child: Text('No product'));
        },
      ),
    );
  }
}
