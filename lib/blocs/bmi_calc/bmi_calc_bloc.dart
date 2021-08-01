import 'dart:math';

import 'package:BMI/models/bmi_calc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import './bmi_calc_event.dart';
import './bmi_calc_state.dart';

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
    double _constant = 705; // for adults
    bmiCalcModel = bmiModel;
    double _weight = bmiCalcModel.weight / 0.4536; //kg -> lb
    double _height = bmiCalcModel.height / 2.54; //cm -> in
    int _age = bmiCalcModel.age;
    double _percentile5th = bmiModel.percentile5th;
    double _percentile85th = bmiModel.percentile85th;
    double _percentile95th = bmiModel.percentile95th;

    // for adults
    if (_age >= 18) {
      //formula  w:lb , h:in
      _bmiValue = (_weight * _constant) / (pow(_height, 2));
      _percentile5th = 18.5;
      _percentile85th = 25.0;
      _percentile95th = 30.0;
    } else {
      // for chields
      _constant = 703;
      _bmiValue = (_weight * _constant) / (pow(_height, 2));
      if (bmiCalcModel.genderCategory == Gender.male) {
        _percentile5th = _boysPercentile5th(_age);
        _percentile85th = _boysPercentile85th(_age);
        _percentile95th = _boysPercentile95th(_age);
        _bmiValue++;
      } else {
        _percentile5th = _girlsPercentile5th(_age);
        _percentile85th = _girlsPercentile85th(_age);
        _percentile95th = _girlsPercentile95th(_age);
        _bmiValue--;
      }
      _bmiValue += 2.5;
    }
    bmiCalcModel.percentile5th = _percentile5th;
    bmiCalcModel.percentile85th = _percentile85th;
    bmiCalcModel.percentile95th = _percentile95th;
    // print(bmiCalcModel.toString());
    print(_bmiValue);
    print(bmiCalcModel.genderCategory);
    print("age: ${bmiModel.age}");
    print("p5th: $_percentile5th");
    print("p85th: $_percentile85th");
    print("p95th: $_percentile95th");
    return _bmiValue;
  }

  double _boysPercentile5th(int x) {
    double percentile5th = -0.0001 * pow(x, 4) +
        0.0028 * pow(x, 3) +
        0.0196 * pow(x, 2) -
        0.5195 * x +
        15.665;

    return percentile5th;
  }

  double _boysPercentile85th(int x) {
    double percentile85th;
    if (x <= 8)
      percentile85th =
          -0.0093 * pow(x, 3) + 0.2731 * pow(x, 2) - 1.9818 * x + 21.08;
    else
      percentile85th = -0.0067 * pow(x, 2) + 0.9683 * x + 10.364;

    return percentile85th;
  }

  double _boysPercentile95th(int x) {
    double percentile95th;
    if (x <= 8)
      percentile95th =
          -0.0222 * pow(x, 3) + 0.5274 * pow(x, 2) - 3.2909 * x + 23.943;
    else
      percentile95th = -0.0234 * pow(x, 2) + 1.4935 * x + 9.6123;

    return percentile95th;
  }

  double _girlsPercentile5th(int x) {
    double girl5th =
        -0.0022 * pow(x, 3) + 0.0965 * pow(x, 2) - 0.9365 * x + 15.983;

    return girl5th;
  }

  double _girlsPercentile85th(int x) {
    double girl85th;
    if (x <= 8)
      girl85th = -0.0111 * pow(x, 3) + 0.3167 * pow(x, 2) - 2.1841 * x + 21.193;
    else
      girl85th = -0.0223 * pow(x, 2) + 1.3306 * x + 8.9687;

    return girl85th;
  }

  double _girlsPercentile95th(int x) {
    double girl95th;
    if (x <= 8)
      girl95th = -0.0167 * pow(x, 3) + 0.4381 * pow(x, 2) - 2.7143 * x + 22.921;
    else
      girl95th = -0.0293 * pow(x, 2) + 1.7324 * x + 8.615;

    return girl95th;
  }
}
