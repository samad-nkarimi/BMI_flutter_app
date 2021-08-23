// import 'file:///D:/dev/flutterProjects/mbi_app/lib/utils/localization/language_entity.dart';
import 'package:BMI/utils/localization/language_entity.dart';
import 'package:equatable/equatable.dart';

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






