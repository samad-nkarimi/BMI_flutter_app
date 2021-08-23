import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/models/models.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FemaleMaleToggle extends StatefulWidget {
  FemaleMaleToggle({Key key}) : super(key: key);

  @override
  _FemaleMaleToggleState createState() => _FemaleMaleToggleState();
}

class _FemaleMaleToggleState extends State<FemaleMaleToggle> {
  bool maleToggle = true;
  Gender _genderCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        return Container(
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  setState(() {
                    maleToggle = true;
                  });
                  _genderCategory = Gender.male;
                  BlocProvider.of<BmiCalcBloc>(context).add(
                    GenderHasBeenSet(_genderCategory),
                  );
                },
                child: Container(
                  width: SizeConfig.responsiveWidth(14.0, 18.0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${AppLocalizations.of(context).translate(TranslationConstants.male)}",
                    style: maleToggle ? Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue,fontWeight: FontWeight.bold) : Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black26),
                  ),
                ),
              ),
              Text(" | ", style: Theme.of(context).textTheme.subtitle1),
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  setState(() {
                    maleToggle = false;
                  });
                  _genderCategory = Gender.female;
                  BlocProvider.of<BmiCalcBloc>(context).add(
                    GenderHasBeenSet(_genderCategory),
                  );
                },
                child: Container(
                  width: SizeConfig.responsiveWidth(14.0, 18.0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${AppLocalizations.of(context).translate(TranslationConstants.female)}",
                    style: !maleToggle ? Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue,fontWeight: FontWeight.bold)   : Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black26),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
