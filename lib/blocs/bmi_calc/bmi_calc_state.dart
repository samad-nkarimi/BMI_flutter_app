import 'package:BMI/models/bmi_calc.dart';
import 'package:equatable/equatable.dart';

abstract class BmiCalcState extends Equatable {
  BmiCalcModel bmiCalcModel;
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
  BmiCalcModel bmiCalcModel;
  BmiCalculated(this.bmiCalcModel);

  @override
  List<Object> get props => [bmiCalcModel];
}
