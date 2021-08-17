import 'package:BMI/utils/language_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:BMI/models/models.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
  @override
  List<Object> get props => [];
}

class ToggleLanguageEvent extends LanguageEvent {
  final LanguageEntity language;

  const ToggleLanguageEvent(this.language);
  @override
  List<Object> get props => [language];
}






