


import 'package:BMI/models/bmi_calc.dart';
import 'package:equatable/equatable.dart';

abstract class BmiCalcState extends Equatable {
  BmiCalcState();

  @override
  List<Object> get props => [];
}

class BmiCalculating extends BmiCalcState {
  double value = 50;
  BmiCalculating(this.value);

  @override
  List<Object> get props => [value];
}

class BmiCalculated extends BmiCalcState {
  final double bmiValue;
  BmiCalculated(this.bmiValue);

  @override
  List<Object> get props => [bmiValue];
}

class WeightChanged extends BmiCalcState {
  final double weight;
  WeightChanged(this.weight);

  @override
  List<Object> get props => [weight];
}

class HeightChanged extends BmiCalcState {
  final double height;
  HeightChanged(this.height);

  @override
  List<Object> get props => [height];
}

class GenderChanged extends BmiCalcState {
  final Gender gender;
  GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

class AgeChanged extends BmiCalcState {
  final int age;
  AgeChanged(this.age);

  @override
  List<Object> get props => [age];
}
