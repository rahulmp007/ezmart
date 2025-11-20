import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/app/presentation/page/splash.dart';
import 'package:ezmart/src/features/product/domain/entity/product.dart';
import 'package:ezmart/src/features/product/presentaion/pages/product_details_page.dart';
import 'package:ezmart/src/features/product/presentaion/pages/product_list_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: ProductListing.page),
    AutoRoute(page: ProductDetail.page),

    
  ];
}
