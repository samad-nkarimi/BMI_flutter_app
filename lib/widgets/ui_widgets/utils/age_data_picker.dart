import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../utils/size/size_config.dart';

class AgeDataPicker extends StatefulWidget {
  @override
  _AgeDataPickerState createState() => _AgeDataPickerState();
}

class _AgeDataPickerState extends State<AgeDataPicker> {
  int _currentAge;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        _currentAge = bmiModel.age;
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Center(
            child: Text(
                '${AppLocalizations.of(context).translate(TranslationConstants.select_age)}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, bmiModel.age);
              },
              child: Text(
                "${AppLocalizations.of(context).translate(TranslationConstants.ok)}",
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          content: Container(
            width: SizeConfig.responsiveWidth(10, 50),
            height: SizeConfig.responsiveWidth(50, 40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(width: 1, color: Colors.green),
              borderRadius: BorderRadius.circular(5),
            ),
            child: NumberPicker(
              // selectedTextStyle:
              // Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 40),

              value: _currentAge,
              minValue: CalculationConstants.min_age,
              maxValue: CalculationConstants.max_age,
              itemCount: SizeConfig.isMobilePortrait ? 3 : 5,
              onChanged: (value) {
                setState(() {
                  _currentAge = value;
                });
                bmiModel.age = value;
                BlocProvider.of<BmiCalcBloc>(context).add(
                  AgeHasBeenSet(value),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
