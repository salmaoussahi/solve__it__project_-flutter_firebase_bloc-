// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_bloc.dart';

class SelectedLangue extends Equatable {
  Locale locale;
  SelectedLangue({
    required this.locale,
  });

  @override
  List<Object> get props => [locale];
}
