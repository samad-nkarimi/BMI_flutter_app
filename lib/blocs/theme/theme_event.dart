import 'package:BMI/blocs/blocs.dart';

import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChangedEvent extends ThemeEvent {
  final Themetype theme;

  ThemeChangedEvent(this.theme);
  @override
  List<Object> get props => [theme];
}
