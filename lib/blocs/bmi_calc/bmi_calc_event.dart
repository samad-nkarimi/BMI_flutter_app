import 'package:equatable/equatable.dart';
import 'package:BMI/models/models.dart';

abstract class BmiCalcEvent extends Equatable {
  const BmiCalcEvent();
  @override
  List<Object> get props => [];
}

class WeightHasBeenSet extends BmiCalcEvent {
  final double weight;

  WeightHasBeenSet(this.weight);
  @override
  List<Object> get props => [weight];
}

class DataInputChanged extends BmiCalcEvent {
  final BmiCalcModel bmiCalcModel;

  DataInputChanged(this.bmiCalcModel);
  @override
  List<Object> get props => [bmiCalcModel];
}

class HeightHasBeenSet extends BmiCalcEvent {
  final double height;

  HeightHasBeenSet(this.height);
  @override
  List<Object> get props => [height];
}

class AgeHasBeenSet extends BmiCalcEvent {
  final int age;

  AgeHasBeenSet(this.age);
  @override
  List<Object> get props => [age];
}

class GenderHasBeenSet extends BmiCalcEvent {
  final Gender gender;

  GenderHasBeenSet(this.gender);
  @override
  List<Object> get props => [gender];
}



// class UnitSetted extends BmiCalcEvent {}
