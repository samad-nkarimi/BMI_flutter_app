

import 'package:BMI/utils/localization/language_entity.dart';

abstract class Languages {

  const Languages._();
  static const languages=[
    LanguageEntity(code:'en', value:"English",flag: "assets/images/flag_english.png"),
    LanguageEntity(code:'fa', value:"Persian",flag: "assets/images/flag_persian.png"),
  ];

}
