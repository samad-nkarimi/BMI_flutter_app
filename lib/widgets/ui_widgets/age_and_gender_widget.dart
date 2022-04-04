import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/size_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:BMI/widgets/ui_widgets/age_and_gender_toggle.dart';
import 'package:BMI/widgets/ui_widgets/utils/age_data_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AgeAndGender extends StatefulWidget {
  @override
  _AgeAndGenderState createState() => _AgeAndGenderState();
}

class _AgeAndGenderState extends State<AgeAndGender> {
  int currentAge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.responsiveHeight(
          SizeConstants.mobileHorizontalPaddingFactorText,
          SizeConstants.tabletHorizontalPaddingFactorText,
        ),
        vertical: SizeConfig.responsiveHeight(2.0, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // age section
          Text("${AppLocalizations.of(context).translate(TranslationConstants.age)} :", style: Theme.of(context).textTheme.subtitle1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.responsiveWidth(1.0, 2.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AgeDataPicker();
                    },
                  ).then((ageValue) {
                    setState(() {
                      currentAge = ageValue;
                    });
                  });
                },
                child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
                  builder: (context, state) {
                    final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                    currentAge = bmiModel.age;
                    return Container(
                      width: SizeConfig.responsiveWidth(
                        SizeConstants.mobileSelectableItemsBackgroundWidth,
                        SizeConstants.tabletSelectableItemsBackgroundWidth,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black.withOpacity(0.08),
                      ),
                      child: Text(
                        "${currentAge.toStringAsFixed(0)}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // spacer for fill space
          Spacer(),

          // gender section
          FemaleMaleToggle(),
        ],
      ),
    );
  }
}
