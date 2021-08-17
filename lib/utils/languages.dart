import 'package:BMI/utils/language_entity.dart';


abstract class Languages {

  const Languages._();
  static const languages=[
    LanguageEntity(code:'en', value:"English"),
    LanguageEntity(code:'fa', value:"Persian"),
  ];

}
