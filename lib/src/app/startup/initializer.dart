import 'package:ezmart/src/app/app.dart';
import 'package:ezmart/src/app/bloc_observer.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_event.dart';
import 'package:ezmart/src/core/service/hive_service.dart';
import 'package:ezmart/src/features/cart/presentaion/bloc/cart/cart_bloc.dart';
import 'package:ezmart/src/features/order/presentaion/bloc/order/order_bloc.dart';
import 'package:ezmart/src/features/product/presentaion/bloc/product/product_bloc.dart';
import 'package:ezmart/src/injection/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future initializer() async {
  Bloc.observer = AppBlocObserver();
  await setupLocator();

  final productBloc = sl<ProductBloc>();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppStartupBloc>(
          create: (context) =>
              AppStartupBloc(hiveService: sl<HiveService>())
                ..add(InitializeApp()),
        ),

        BlocProvider<ProductBloc>.value(value: productBloc),
        BlocProvider<CartBloc>(
          create: (context) => sl<CartBloc>(param1: productBloc),
        ),

        BlocProvider<OrderBloc>(create: (context) => sl<OrderBloc>()),
      ],
      child: const EzMart(),
    ),
  );
}
