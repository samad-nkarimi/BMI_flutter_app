import 'dart:math';

import 'package:BMI/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import './bmi_calc_event.dart';
import './bmi_calc_state.dart';

class BmiCalcBloc extends Bloc<BmiCalcEvent, BmiCalcState> {
  BmiCalcModel bmiCalcModel;
  BmiCalcBloc({@required this.bmiCalcModel}) : super(BmiCalculating(5.5));

  @override
  Stream<BmiCalcState> mapEventToState(BmiCalcEvent event) async* {
    if (event is DataInputChanged) {
      // yield* _mapDataToState(event);
      // } else if (event is WeightSetted) {
      //   yield* _mapWeightSettedToState(event);
      // } else if (event is HeightSetted) {
      //   yield* _mapHeightSettedToState(event);
    } else if (event is GenderHasBeenSet) {
      yield* _mapGenderHasbeenSetToState(event);
      yield* _mapGenderHasbeenSetToGengerState(event);
    } else if (event is AgeHasBeenSet) {
      yield* _mapAgeHasbeenSetToState(event);
      yield* _mapAgeHasbeenSetToAgeState(event);
    } else if (event is WeightHasBeenSet) {
      yield* _mapWeightHasbeenSetToState(event);
      yield* _mapWeightHasbeenSetToWeightState(event);
    } else if (event is HeightHasBeenSet) {
      yield* _mapHeightHasbeenSetToState(event);
      yield* _mapHeightHasbeenSetToHeightState(event);
    }
  }

  // Stream<BmiCalcState> _mapDataToState(DataInputChanged event) async* {
  //   BmiCalcModel _bmiCalcModel = _calculate(event.bmiCalcModel);

  //   yield BmiCalculated(_bmiCalcModel);
  // }

  //gender
  Stream<BmiCalcState> _mapGenderHasbeenSetToState(
      GenderHasBeenSet event) async* {
    bmiCalcModel.genderCategory = event.gender;
    yield BmiCalculated(bmiCalcModel.bmiValueCalculation());
  }

  Stream<BmiCalcState> _mapGenderHasbeenSetToGengerState(
      GenderHasBeenSet event) async* {
    bmiCalcModel.genderCategory = event.gender;
    yield GenderChanged(event.gender);
  }

  //age
  Stream<BmiCalcState> _mapAgeHasbeenSetToState(AgeHasBeenSet event) async* {
    bmiCalcModel.age = event.age;
    yield BmiCalculated(bmiCalcModel.bmiValueCalculation());
  }

  Stream<BmiCalcState> _mapAgeHasbeenSetToAgeState(AgeHasBeenSet event) async* {
    bmiCalcModel.age = event.age;
    yield AgeChanged(event.age);
  }

  //weight
  Stream<BmiCalcState> _mapWeightHasbeenSetToState(
      WeightHasBeenSet event) async* {
    bmiCalcModel.weight = event.weight;
    yield BmiCalculated(bmiCalcModel.bmiValueCalculation());
  }

  Stream<BmiCalcState> _mapWeightHasbeenSetToWeightState(
      WeightHasBeenSet event) async* {
    bmiCalcModel.weight = event.weight;
    yield WeightChanged(event.weight);
  }

  // height
  Stream<BmiCalcState> _mapHeightHasbeenSetToState(
      HeightHasBeenSet event) async* {
    bmiCalcModel.height = event.height;
    yield BmiCalculated(bmiCalcModel.bmiValueCalculation());
  }

  Stream<BmiCalcState> _mapHeightHasbeenSetToHeightState(
      HeightHasBeenSet event) async* {
    bmiCalcModel.height = event.height;
    yield HeightChanged(event.height);
  }

  // Stream<BmiCalcState> _mapWeightSettedToState(WeightSetted event) async* {
  //   double bmiValue = _calculate(event.bmiCalcModel);

  //   yield BmiCalculated(bmiValue);
  // }

  // Stream<BmiCalcState> _mapHeightSettedToState(HeightSetted event) async* {
  //   double bmiValue = _calculate(event.bmiCalcModel);

  //   yield BmiCalculated(bmiValue);
  // }

  BmiCalcModel _calculate(BmiCalcModel bmiModel) {
    double _bmiValue;
    double _constant = 705; // for adults
    BmiCalcModel bmiCalcModel = new BmiCalcModel();
    // bmiCalcModel = state.bmiCalcModel;

    double _weight = bmiCalcModel.weight / 0.4536; //kg -> lb
    double _height = bmiCalcModel.height / 2.54; //cm -> in
    int _age = bmiCalcModel.age;
    double _percentile5th = bmiCalcModel.percentile5th;
    double _percentile85th = bmiCalcModel.percentile85th;
    double _percentile95th = bmiCalcModel.percentile95th;

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
      } else {
        _percentile5th = _girlsPercentile5th(_age);
        _percentile85th = _girlsPercentile85th(_age);
        _percentile95th = _girlsPercentile95th(_age);
      }
    }
    bmiCalcModel.bmiValue = _bmiValue;
    bmiCalcModel.percentile5th = _percentile5th;
    bmiCalcModel.percentile85th = _percentile85th;
    bmiCalcModel.percentile95th = _percentile95th;
    // print(bmiCalcModel.toString());
    print(_bmiValue);
    print(bmiCalcModel.genderCategory);
    print("Height: ${bmiCalcModel.height}");
    print("age: ${bmiModel.age}");
    print("p5th: $_percentile5th");
    print("p85th: $_percentile85th");
    print("p95th: $_percentile95th");
    return bmiCalcModel;
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
