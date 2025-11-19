import 'package:ezmart/src/app.dart';
import 'package:ezmart/src/app/bloc_observer.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_event.dart';
import 'package:ezmart/src/core/service/hive_service.dart';
import 'package:ezmart/src/injection/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future initializer() async {
  Bloc.observer = AppBlocObserver();
  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppStartupBloc>(
          create: (context) =>
              AppStartupBloc(hiveService: sl<HiveService>())
                ..add(InitializeApp()),
        ),
      ],
      child: const EzMart(),
    ),
  );
}
