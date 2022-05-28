import 'package:BMI/blocs/theme/theme_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  final Themetype theme;
  const ThemeState(this.theme);

  @override
  List<Object> get props => [theme];
}

class ThemeChangedState extends ThemeState {
  ThemeChangedState(theme) : super(theme);

  @override
  List<Object> get props => [theme];
}

// class SendFeedbackEmail extends DrawerItemState {}

// class ShareAppLink extends DrawerItemState {}

// class ShareMoreAppLink extends DrawerItemState {}

// class ShowAboutUs extends DrawerItemState {}
