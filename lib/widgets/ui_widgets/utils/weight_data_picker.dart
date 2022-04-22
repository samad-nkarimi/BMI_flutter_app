import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/size/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightDataPicker extends StatefulWidget {
  // double _value;
  final int _min;
  final int _max;

  WeightDataPicker(this._min, this._max);

  @override
  _WeightDataPickerState createState() => _WeightDataPickerState();
}

class _WeightDataPickerState extends State<WeightDataPicker> {
  double _currentWeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        _currentWeight = bmiModel.weight;
        // if (state is WeightChanged) _currentWeight = state.weight;
        return AlertDialog(
          backgroundColor: Colors.orange.shade200,
          title: Center(
            child: Text(
                '${AppLocalizations.of(context).translate(TranslationConstants.select_weight)}',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, _currentWeight);
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
              value: _currentWeight,
              minValue: widget._min,
              maxValue: widget._max,
              itemCount: SizeConfig.isMobilePortrait ? 3 : 5,
              decimalPlaces: 1,
              onChanged: (value) {
                setState(() => _currentWeight = value);
                // bmiModel.weight = _currentValue;

                BlocProvider.of<BmiCalcBloc>(context)
                    .add(WeightHasBeenSet(value));
              },
            ),
          ),
        );
      },
    );
  }
}
