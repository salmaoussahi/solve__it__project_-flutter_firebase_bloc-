import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, SelectedLangue> {
  LanguageBloc() : super(SelectedLangue(locale: Locale("fr", ""))) {
    on<ToArabic>((event, emit) {
      emit(SelectedLangue(locale: Locale("ar")));
    });
    on<ToEnglish>((event, emit) {
      print("dd");
      emit(SelectedLangue(locale: Locale("en")));
    });
    on<ToFrensh>((event, emit) {
      emit(SelectedLangue(locale: Locale("fr")));
    });
  }
}
