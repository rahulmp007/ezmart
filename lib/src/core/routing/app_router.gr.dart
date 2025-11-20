// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ProductDetail.name: (routeData) {
      final args = routeData.argsAs<ProductDetailArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductDetailPage(key: args.key, product: args.product),
      );
    },
    ProductListing.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProductListPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Splash(),
      );
    },
  };
}

/// generated route for
/// [ProductDetailPage]
class ProductDetail extends PageRouteInfo<ProductDetailArgs> {
  ProductDetail({
    Key? key,
    required Product product,
    List<PageRouteInfo>? children,
  }) : super(
         ProductDetail.name,
         args: ProductDetailArgs(key: key, product: product),
         initialChildren: children,
       );

  static const String name = 'ProductDetail';

  static const PageInfo<ProductDetailArgs> page = PageInfo<ProductDetailArgs>(
    name,
  );
}

class ProductDetailArgs {
  const ProductDetailArgs({this.key, required this.product});

  final Key? key;

  final Product product;

  @override
  String toString() {
    return 'ProductDetailArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [ProductListPage]
class ProductListing extends PageRouteInfo<void> {
  const ProductListing({List<PageRouteInfo>? children})
    : super(ProductListing.name, initialChildren: children);

  static const String name = 'ProductListing';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Splash]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
