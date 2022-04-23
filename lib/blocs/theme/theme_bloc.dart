import 'package:bloc/bloc.dart';
import 'package:BMI/blocs/blocs.dart';

import '../../utils/theme/prefs.dart';

enum themetype { light, dark }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final themetype theme;
  final Prefs prefs;
  ThemeBloc(this.theme, this.prefs) : super(ThemeChangedState(theme));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChangedEvent) {
      if (event.theme == themetype.light) {
        prefs.setThemeType(true);
      } else {
        prefs.setThemeType(false);
      }
      yield ThemeChangedState(event.theme);
    }
  }
}
