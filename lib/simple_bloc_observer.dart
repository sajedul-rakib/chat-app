import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('on change bloc: ${bloc.runtimeType} change: $change');
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    log('create bloc : ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('on change ${bloc.runtimeType} event: ${event.runtimeType}');
    super.onEvent(bloc, event);
  }
}
