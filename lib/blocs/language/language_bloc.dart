import 'dart:math';

import 'package:BMI/models/models.dart';
import 'package:BMI/utils/localization/languages.dart';
import 'package:BMI/utils/theme/prefs.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import './language_event.dart';
import './language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final Prefs prefs;
  final String langCode;
  LanguageBloc(this.langCode, this.prefs)
      : super(LanguageLoaded(Locale(langCode)));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ToggleLanguageEvent) {
      prefs.setLanguageCode(event.language.code);
      yield LanguageLoaded(Locale(event.language.code));
    }
  }
}
