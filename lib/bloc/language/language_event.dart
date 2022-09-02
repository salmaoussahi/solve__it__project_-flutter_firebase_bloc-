// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToArabic extends LanguageEvent {
  Locale locale;
  ToArabic({
    required this.locale,
  });
}

class ToEnglish extends LanguageEvent {
  Locale locale;
  ToEnglish({
    required this.locale,
  });
}

class ToFrench extends LanguageEvent {
  Locale locale;
  ToFrench({
    required this.locale,
  });
}
