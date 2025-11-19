import 'package:auto_route/auto_route.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_state.dart';
import 'package:ezmart/src/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'SplashRoute')
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppStartupBloc, AppStartupState>(
        listener: (context, state) {
          if (state is AppStartupSuccess) {
            context.router.push(ProductListing());
          } else if (state is AppStartupFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Startup failed')));
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
