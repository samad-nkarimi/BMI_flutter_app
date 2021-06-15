import 'package:equatable/equatable.dart';
import 'package:mbi_app/models/models.dart';

abstract class BmiCalcEvent extends Equatable {
  const BmiCalcEvent();
  @override
  List<Object> get props => [];
}

class WeightSetted extends BmiCalcEvent {
  final BmiCalcModel bmiCalcModel;

  WeightSetted(this.bmiCalcModel);
  @override
  List<Object> get props => [bmiCalcModel];
}

class DataInputChanged extends BmiCalcEvent {
  final BmiCalcModel bmiCalcModel;

  DataInputChanged(this.bmiCalcModel);
  @override
  List<Object> get props => [bmiCalcModel];
}

class HeightSetted extends BmiCalcEvent {
  final BmiCalcModel bmiCalcModel;

  HeightSetted(this.bmiCalcModel);
  @override
  List<Object> get props => [bmiCalcModel];
}

class AgeSetted extends BmiCalcEvent {}

class GenderSetted extends BmiCalcEvent {}

class UnitSetted extends BmiCalcEvent {}
