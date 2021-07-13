import 'package:equatable/equatable.dart';

enum Gender { male, female }
// enum Age { greaterThan21, lessThan21 }
// enum Unit { english, SI }

class BmiCalcModel extends Equatable {
  double weight;
  double height;
  Gender genderCategory;
  int age;

  BmiCalcModel({
    this.weight = 50.0,
    this.height = 160.0,
    this.genderCategory = Gender.male,
    this.age = 20,
  });

  @override
  List<Object> get props => [weight, height, genderCategory, age];

  @override
  String toString() {
    return "<<< weight:$weight - height:$height - gender:$genderCategory - age:$age >>>";
  }
}
