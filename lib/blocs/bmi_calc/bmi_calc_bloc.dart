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
    } else if (event is WeightSetted) {
      yield* _mapWeightSettedToState(event);
    } else if (event is HeightSetted) {
      yield* _mapHeightSettedToState(event);
    } else if (event is AgeSetted) {
    } else if (event is GenderSetted) {
    } else if (event is UnitSetted) {}
  }

  Stream<BmiCalcState> _mapDataToState(DataInputChanged event) async* {
    double bmiValue = _calculate(event.bmiCalcModel);

    yield BmiCalculated(bmiValue);
  }

  Stream<BmiCalcState> _mapWeightSettedToState(WeightSetted event) async* {
    double bmiValue = _calculate(event.bmiCalcModel);

    yield BmiCalculated(bmiValue);
  }

  Stream<BmiCalcState> _mapHeightSettedToState(HeightSetted event) async* {
    double bmiValue = _calculate(event.bmiCalcModel);

    yield BmiCalculated(bmiValue);
  }

  double _calculate(BmiCalcModel bmiModel) {
    double bmiValue;
    bmiCalcModel = bmiModel;
    double weight = bmiCalcModel.weight;
    double height = bmiCalcModel.height;
    if (bmiCalcModel.heightUnit == Unit.SI) {
      height = height / 2.54;
    }
    if (bmiCalcModel.heightUnit == Unit.SI) {
      weight = weight / 0.4536;
    }

    //formula  w:lb , h:in
    bmiValue = (weight * 705) / (pow(height, 2));

    print("weihgt: $weight");
    print("height: $height");
    print(bmiValue);
    return bmiValue;
  }
}
