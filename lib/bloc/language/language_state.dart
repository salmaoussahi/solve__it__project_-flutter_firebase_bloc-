// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class SelectedLangue extends LanguageState {
  Locale locale;
  SelectedLangue({
    required this.locale,
  });
}
