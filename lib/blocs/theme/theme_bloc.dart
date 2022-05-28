import 'package:bloc/bloc.dart';
import 'package:BMI/blocs/blocs.dart';

import '../../utils/theme/prefs.dart';

enum Themetype { light, dark }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final Themetype theme;
  final Prefs prefs;
  ThemeBloc(this.theme, this.prefs) : super(ThemeChangedState(theme));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChangedEvent) {
      if (event.theme == Themetype.light) {
        prefs.setThemeType(true);
      } else {
        prefs.setThemeType(false);
      }
      yield ThemeChangedState(event.theme);
    }
  }
}
