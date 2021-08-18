import 'dart:math';

import 'package:BMI/models/models.dart';
import 'package:BMI/utils/languages.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import './language_event.dart';
import './language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {

  LanguageBloc() : super(LanguageLoaded(Locale(Languages.languages[1].code)));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ToggleLanguageEvent) {
      yield LanguageLoaded(Locale(event.language.code));
    }
  }

}
