import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/core/routing/app_router.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(ProductDetail(product: product)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(product.image ?? "", fit: BoxFit.contain),
            ),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 6),

            /// PRICE + STOCK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// PRICE
                  Text(
                    "₹ ${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  /// STOCK
                  Text(
                    "Stock: ${product.stockRemaining ?? 0}",
                    style: TextStyle(
                      color: (product.stockRemaining ?? 0) > 0
                          ? Colors.black
                          : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
