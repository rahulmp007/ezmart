// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_event.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_state.dart';

@RoutePage(name: 'ProductDetail')
class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int qty = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(widget.product.image ?? "", height: 200),
            ),
            SizedBox(height: 12),
            Text(
              widget.product.title ?? "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.product.description ?? "",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text('Price: ₹${widget.product.price?.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            Text(
              'Rating: ${widget.product.rating?.rate} (${widget.product.rating?.count})',
            ),
            SizedBox(height: 8),
            Text('Stock: ${widget.product.stockRemaining}'),
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
                  onPressed: (widget.product.stockRemaining ?? 0) <= 0
                      ? null
                      : () async {
                          // Here you'd call add to cart usecase from cart feature (not in this product feature code)
                          // For now, update stock locally by reducing qty and notify
                          final newStock =
                              (widget.product.stockRemaining ?? 0) - qty;
                          context.read<ProductBloc>().add(
                            UpdateStock(widget.product.id ?? 0, newStock),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to cart (local).')),
                          );
                        },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
