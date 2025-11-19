import 'dart:async';
import 'package:ezmart/src/app/startup/bloc/app_startup_event.dart';
import 'package:ezmart/src/app/startup/bloc/app_startup_state.dart';
import 'package:ezmart/src/core/service/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStartupBloc extends Bloc<AppStartupEvent, AppStartupState> {
  final HiveService hiveService;
  AppStartupBloc({required this.hiveService}) : super(AppStartupInitial()) {
    on<InitializeApp>(onAppInitialize);
  }

  FutureOr<void> onAppInitialize(
    InitializeApp event,
    Emitter<AppStartupState> emit,
  ) async {
    try {
      emit(AppStartupLoading());
      await hiveService.init();
      emit(AppStartupSuccess());
    } catch (e) {
      emit(AppStartupFailure());
    }
  }
}
