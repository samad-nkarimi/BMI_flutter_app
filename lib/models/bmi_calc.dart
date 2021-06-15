import 'package:equatable/equatable.dart';

enum Gender { male, female }
enum Age { greaterThan21, lessThan21 }
enum Unit { english, SI }

class BmiCalcModel extends Equatable {
  double weight;
  double height;
  Gender genderCategory;
  Age ageCategory;
  Unit heightUnit;
  Unit weightUnit;

  BmiCalcModel({
    this.weight = 30.0,
    this.height = 130.0,
    this.genderCategory = Gender.male,
    this.ageCategory = Age.greaterThan21,
    this.heightUnit = Unit.SI,
    this.weightUnit = Unit.SI,
  });

  @override
  List<Object> get props =>
      [weight, height, genderCategory, ageCategory, heightUnit, weightUnit];

  @override
  String toString() {
    return "";
  }
}
