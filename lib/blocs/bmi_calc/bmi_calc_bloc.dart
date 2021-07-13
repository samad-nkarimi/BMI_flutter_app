import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mbi_app/blocs/bmi_calc/bmi_calc_event.dart';
import 'package:mbi_app/blocs/bmi_calc/bmi_calc_state.dart';
import 'package:mbi_app/models/bmi_calc.dart';

class BmiCalcBloc extends Bloc<BmiCalcEvent, BmiCalcState> {
  BmiCalcModel bmiCalcModel;
  BmiCalcBloc({@required this.bmiCalcModel}) : super(BmiCalculating());

  @override
  Stream<BmiCalcState> mapEventToState(BmiCalcEvent event) async* {
    if (event is DataInputChanged) {
      yield* _mapDataToState(event);
      // } else if (event is WeightSetted) {
      //   yield* _mapWeightSettedToState(event);
      // } else if (event is HeightSetted) {
      //   yield* _mapHeightSettedToState(event);
    } else if (event is AgeSetted) {
    } else if (event is GenderSetted) {
    } else if (event is UnitSetted) {}
  }

  Stream<BmiCalcState> _mapDataToState(DataInputChanged event) async* {
    double bmiValue = _calculate(event.bmiCalcModel);

    yield BmiCalculated(bmiValue);
  }

  // Stream<BmiCalcState> _mapWeightSettedToState(WeightSetted event) async* {
  //   double bmiValue = _calculate(event.bmiCalcModel);

  //   yield BmiCalculated(bmiValue);
  // }

  // Stream<BmiCalcState> _mapHeightSettedToState(HeightSetted event) async* {
  //   double bmiValue = _calculate(event.bmiCalcModel);

  //   yield BmiCalculated(bmiValue);
  // }

  double _calculate(BmiCalcModel bmiModel) {
    double _bmiValue;
    double _constant = 705;
    bmiCalcModel = bmiModel;
    double _weight = bmiCalcModel.weight / 0.4536; //kg -> lb
    double _height = bmiCalcModel.height / 2.54; //cm -> in

    if (bmiCalcModel.age <= 18) _constant = 703;

    //formula  w:lb , h:in
    _bmiValue = (_weight * _constant) / (pow(_height, 2));

    // print(bmiCalcModel.toString());
    print(_bmiValue);
    return _bmiValue;
  }
}
