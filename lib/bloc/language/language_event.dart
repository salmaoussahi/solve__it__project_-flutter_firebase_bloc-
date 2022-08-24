part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToArabic extends LanguageEvent {}

class ToEnglish extends LanguageEvent {}

class ToFrensh extends LanguageEvent {}
