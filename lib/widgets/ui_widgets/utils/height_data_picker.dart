import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../utils/size/size_config.dart';

class HeightDataPicker extends StatefulWidget {
  @override
  _HeightDataPickerState createState() => _HeightDataPickerState();
}

class _HeightDataPickerState extends State<HeightDataPicker> {
  double _currentHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        _currentHeight = bmiModel.height;
        if (state is HeightChanged) _currentHeight = state.height;
        return AlertDialog(
          backgroundColor: Colors.orange.shade200,
          title: Center(
              child: Text(
                  '${AppLocalizations.of(context).translate(TranslationConstants.select_height)}',
                  style: Theme.of(context).textTheme.bodyText1)),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Text("cancell", style: Theme.of(context).textTheme.button),
            // ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _currentHeight);
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
              color: Colors.orange.shade100,
              border: Border.all(width: 1, color: Colors.green),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DecimalNumberPicker(
              value: _currentHeight,
              minValue: CalculationConstants.min_height,
              maxValue: CalculationConstants.max_height,
              itemCount: SizeConfig.isMobilePortrait ? 3 : 5,
              decimalPlaces: 1,
              onChanged: (value) {
                setState(() => _currentHeight = value);
                // bmiModel.weight = _currentValue;

                BlocProvider.of<BmiCalcBloc>(context)
                    .add(HeightHasBeenSet(value));
              },
            ),
          ),
        );
      },
    );
  }
}
