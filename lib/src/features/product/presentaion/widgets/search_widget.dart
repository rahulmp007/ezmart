
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? 16
                      : constraints.maxWidth * 0.2,
                ),
                child: SearchBar(
                  leading: Icon(Icons.search),
                  onChanged: (value) =>
                      context.read<ProductBloc>().add(SearchProducts(value)),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  hintText: 'Seach for products',
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
