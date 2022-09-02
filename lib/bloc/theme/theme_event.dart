import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeEvent extends Equatable {
  final ThemeData theme;
  const ThemeEvent({required this.theme});

  @override
  List<Object> get props => [theme];
}
