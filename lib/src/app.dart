import 'package:ezmart/src/core/routing/app_router.dart';
import 'package:flutter/material.dart';

class EzMart extends StatelessWidget {
  const EzMart({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      title: 'EzMart',
    );
  }
}
