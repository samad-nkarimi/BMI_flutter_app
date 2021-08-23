import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class AgeDataPicker extends StatefulWidget {
  // int _value;
  final int _min;
  final int _max;
  int _age;

  AgeDataPicker(this._min, this._max, this._age);

  @override
  _AgeDataPickerState createState() => _AgeDataPickerState();
}

class _AgeDataPickerState extends State<AgeDataPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).translate(TranslationConstants.select_age)}',
              textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
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
          content: NumberPicker(
            value: widget._age,
            minValue: widget._min,
            maxValue: widget._max,
            itemCount: 3,
            onChanged: (value) {
              setState(() {
                widget._age = value;
              });
              bmiModel.age = value;
              BlocProvider.of<BmiCalcBloc>(context).add(
                AgeHasBeenSet(value),
              );
            },
          ),
        );
      },
    );
  }
}

