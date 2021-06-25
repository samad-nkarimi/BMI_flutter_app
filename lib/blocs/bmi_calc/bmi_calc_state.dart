import 'package:equatable/equatable.dart';

abstract class BmiCalcState extends Equatable {
  final double bmiValue = 150;
  const BmiCalcState();

  @override
  List<Object> get props => [];
}

class BmiCalculating extends BmiCalcState {}

class BmiCalculated extends BmiCalcState {
  final double bmiValue;
  BmiCalculated(this.bmiValue);

  @override
  List<Object> get props => [bmiValue];
}
