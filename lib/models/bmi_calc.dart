import 'dart:math';

import 'package:equatable/equatable.dart';

enum Gender { male, female }
// enum Age { greaterThan21, lessThan21 }
// enum Unit { english, SI }

class BmiCalcModel extends Equatable {
  double bmiValue;
  double weight;
  double height;
  Gender genderCategory;
  int age;
  double percentile5th;
  double percentile85th;
  double percentile95th;

  BmiCalcModel({
    this.bmiValue = 24.5,
    this.weight = 50.0,
    this.height = 160.0,
    this.genderCategory = Gender.male,
    this.age = 20,
    this.percentile5th = 18.5,
    this.percentile85th = 25.0,
    this.percentile95th = 30.0,
  });

  @override
  List<Object> get props => [bmiValue, weight, height, genderCategory, age];

  @override
  String toString() {
    return "<<< BMI:$bmiValue - weight:$weight - height:$height - gender:$genderCategory - age:$age >>>";
  }

  // main bmi value calculation method
  double bmiValueCalculation() {
    double _constant = 705; // for adults
    double _weight = weight / 0.4536; //kg -> lb
    double _height = height / 2.54; //cm -> in

    // for adults
    if (age >= 18) {
      //formula  w:lb , h:in
      bmiValue = (_weight * _constant) / (pow(_height, 2));
      percentile5th = 18.5;
      percentile85th = 25.0;
      percentile95th = 30.0;
    } else {
      // for chields
      _constant = 703;
      bmiValue = (_weight * _constant) / (pow(_height, 2));
      if (genderCategory == Gender.male) {
        percentile5th = _boysPercentile5th(age);
        percentile85th = _boysPercentile85th(age);
        percentile95th = _boysPercentile95th(age);
      } else {
        percentile5th = _girlsPercentile5th(age);
        percentile85th = _girlsPercentile85th(age);
        percentile95th = _girlsPercentile95th(age);
      }
    }
    // bmiValue = bmiValue;
    // percentile5th = percentile5th;
    // percentile85th = percentile85th;
    // percentile95th = percentile95th;
    // print(bmiCalcModel.toString());
    print(bmiValue);
    print(genderCategory);
    print("Height: $height");
    print("age: $age");
    print("p5th: $percentile5th");
    print("p85th: $percentile85th");
    print("p95th: $percentile95th");
    return bmiValue;
  }

  // percentile calculateion methods
  double _boysPercentile5th(int age) {
    double percentile5th = -0.0001 * pow(age, 4) +
        0.0028 * pow(age, 3) +
        0.0196 * pow(age, 2) -
        0.5195 * age +
        15.665;

    return percentile5th;
  }

  double _boysPercentile85th(int age) {
    double percentile85th;
    if (age <= 8)
      percentile85th =
          -0.0093 * pow(age, 3) + 0.2731 * pow(age, 2) - 1.9818 * age + 21.08;
    else
      percentile85th = -0.0067 * pow(age, 2) + 0.9683 * age + 10.364;

    return percentile85th;
  }

  double _boysPercentile95th(int age) {
    double percentile95th;
    if (age <= 8)
      percentile95th =
          -0.0222 * pow(age, 3) + 0.5274 * pow(age, 2) - 3.2909 * age + 23.943;
    else
      percentile95th = -0.0234 * pow(age, 2) + 1.4935 * age + 9.6123;

    return percentile95th;
  }

  double _girlsPercentile5th(int age) {
    double girl5th =
        -0.0022 * pow(age, 3) + 0.0965 * pow(age, 2) - 0.9365 * age + 15.983;

    return girl5th;
  }

  double _girlsPercentile85th(int age) {
    double girl85th;
    if (age <= 8)
      girl85th =
          -0.0111 * pow(age, 3) + 0.3167 * pow(age, 2) - 2.1841 * age + 21.193;
    else
      girl85th = -0.0223 * pow(age, 2) + 1.3306 * age + 8.9687;

    return girl85th;
  }

  double _girlsPercentile95th(int age) {
    double girl95th;
    if (age <= 8)
      girl95th =
          -0.0167 * pow(age, 3) + 0.4381 * pow(age, 2) - 2.7143 * age + 22.921;
    else
      girl95th = -0.0293 * pow(age, 2) + 1.7324 * age + 8.615;

    return girl95th;
  }
}
