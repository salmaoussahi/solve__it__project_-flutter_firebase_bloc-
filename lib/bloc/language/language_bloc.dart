import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, SelectedLangue> {
  LanguageBloc() : super(SelectedLangue(locale: Locale("fr", ""))) {
    on<ToArabic>((event, emit) {
      print("boloc arb");
      emit(SelectedLangue(locale: event.locale));
      print("boloc arb emmited");
    });
    on<ToEnglish>((event, emit) {
      print("boloc eng");
      emit(SelectedLangue(locale: event.locale));
      print("boloc eng emmited");
    });
    on<ToFrench>((event, emit) {
      print("boloc fr");
      emit(SelectedLangue(locale: event.locale));
      print("boloc fr emmited");
    });
  }
}
