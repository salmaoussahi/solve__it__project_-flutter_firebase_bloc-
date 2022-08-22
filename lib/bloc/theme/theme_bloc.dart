import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterfirebase/bloc/theme/theme_event.dart';
import 'package:flutterfirebase/bloc/theme/theme_state.dart';

import '../../pages/config/config.theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: MyTheme.lightTheme)) {
    on<ThemeEvent>((event, emit) {
      emit(ThemeState(themeData: event.theme));
      // TODO: implement event handler
    });
  }
}
