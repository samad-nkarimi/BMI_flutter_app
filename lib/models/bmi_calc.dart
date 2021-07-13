import 'package:equatable/equatable.dart';

enum Gender { male, female }
// enum Age { greaterThan21, lessThan21 }
// enum Unit { english, SI }

class BmiCalcModel extends Equatable {
  double weight;
  double height;
  Gender genderCategory;
  int age;
  double percentile5th;
  double percentile85th;
  double percentile95th;

  BmiCalcModel({
    this.weight = 50.0,
    this.height = 160.0,
    this.genderCategory = Gender.male,
    this.age = 20,
    this.percentile5th = 18.5,
    this.percentile85th = 25.0,
    this.percentile95th = 30.0,
  });

  @override
  List<Object> get props => [weight, height, genderCategory, age];

  @override
  String toString() {
    return "<<< weight:$weight - height:$height - gender:$genderCategory - age:$age >>>";
  }
}
