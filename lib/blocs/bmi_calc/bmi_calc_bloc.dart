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




}
