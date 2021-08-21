import 'dart:math' as math;

import 'package:BMI/utils/app_localizations.dart';
import 'package:BMI/utils/language_entity.dart';
import 'package:BMI/utils/languages.dart';
import 'package:BMI/utils/styling.dart';
import 'package:BMI/utils/translation_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../screens/drawer_screen.dart';
import '../utils/size_config.dart';
import '../widgets/radial_gauge.dart';
import '../widgets/slider_height_widget.dart';
import '../widgets/slider_weight_widget.dart';

class MBIHome extends StatefulWidget {
  MBIHome({Key key}) : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  // var _gaugeValue = 12.0;
  double _currentWeightValue = 58.3;
  double _currentHeightValue = 110.6;
  int _minSliderHeight = 40;
  int _maxSliderHeight = 220;
  int _minSliderWeight = 10;
  int _maxSliderWeight = 150;
  int _currentAgeValue = 20;
  double _horizPaddingFactorTextForMobile = 5.0;
  double _horizPaddingFactorTextForTablet = 5.0;


  // NumberPicker decimalNumberPicker;
  List<String> _weightCategories = [];
  List<String> _weightCategoryPercentiles = ["<= 18.5", "18.0 - 25.0", "25.0 - 30.0", ">= 30.0"];

  // initState() {
  //   super.initState();
  //   List<String> _weightCategories = [
  //     "${AppLocalizations.of(context).translate("underweight")}",
  //     "${AppLocalizations.of(context).translate("normal")}",
  //     "${AppLocalizations.of(context).translate("overweight")}",
  //     "${AppLocalizations.of(context).translate("obese")}"
  //   ];
  // }

  double resHeight(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) * SizeConfig.heightMultiplier;
  }

  double resWidth(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) * SizeConfig.widthMultiplier;
  }

  double resText(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) * SizeConfig.textMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    var testTheme = Theme.of(context).textTheme.subtitle1.color;
    print("$testTheme tttttttttttttttttttttttt");
    return BlocBuilder<LanguageBloc,LanguageState>(
      builder:(context,languageState){
        var lang="en";
        if(languageState is LanguageLoaded)
           lang = languageState.locale.languageCode;
        return  SafeArea(



        child: Container(
          child: Scaffold(
            drawer: MbiDrawer(),
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, resHeight(8.0, 10.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resWidth(3.0, 3.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) => Container(
                        // padding: const EdgeInsets.all(10.0),
                        // margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        child: Container(
                          width: resWidth(12.0, 8.0),
                          height: resWidth(12.0, 8.0),
                          child: IconButton(
                            // iconSize: 10 * SizeConfig.heightMultiplier,
                            icon: Transform(
                              alignment: Alignment.center,
                              child: SvgPicture.asset("assets/images/menu_icon.svg"),
                              transform: lang == 'fa' ? Matrix4.rotationY(math.pi): Matrix4.rotationY(0) ,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.black12,
                      // width: resWidth(50.0, 40.0),
                      // height: resHeight(20.0, 15.0),
                      child:
                          // SvgPicture.asset("assets/images/bmi_name.svg"),
                          DropdownButton<LanguageEntity>(
                        items: Languages.languages
                            .map<DropdownMenuItem<LanguageEntity>>(
                              (e) => DropdownMenuItem<LanguageEntity>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(e.value),
                                    Image.asset(
                                      e.flag,
                                      height: resHeight(4.0, 4.0),
                                      width: resHeight(4.0, 4.0),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        underline: SizedBox(),
                        icon: Image.asset(
                          lang == 'en' ? "assets/images/flag_english.png" : "assets/images/flag_persian.png",
                          width: resHeight(5.0, 5.0),
                          height: resHeight(5.0, 5.0),
                        ),
                        onChanged: (index) {
                          // index is LanguageEntity
                          BlocProvider.of<LanguageBloc>(context).add(
                            ToggleLanguageEvent(index),
                          );

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              // alignment: Alignment.topCenter,
              children: [
                Container(
                  // color: Colors.white,
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: resWidth(5.0, 0.0), left: 10.0, right: 10.0),
                  height: resHeight(50.0, 55.0),
                  child: RadialGauge(
                      // value: bmiValue,
                      ),
                ),
                Container(
                  // color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<BmiCalcBloc, BmiCalcState>(
                        builder: (context, state) {
                          final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: resHeight(
                                _horizPaddingFactorTextForMobile + 1.0, // adding 1.0 for card margin
                                _horizPaddingFactorTextForTablet + 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context).translate(TranslationConstants.normal_weight)}(kg)",
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.blue),
                                ),
                                Text(
                                  "${bmiModel.minimumNormalWeight().toStringAsFixed(1)} - ${bmiModel.maximumNormalWeight().toStringAsFixed(1)}",
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.blue),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      // the box relevant to sliders
                      Card(
                        margin: EdgeInsets.only(
                            top: resHeight(1.0, 2.0), left: resHeight(1.0, 2.0), right: resHeight(1.0, 2.0), bottom: resHeight(0.5, 1.0)),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          // side: BorderSide(width: 5, color: Colors.green),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: resHeight(1.0, 2.5)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // segment age & gender
                              _ageAndGender(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Divider(height: 0.5, color: Colors.black26),
                              ),
                              // segment weight
                              if (SizeConfig.isMobilePortrait) _propertyRowMobileWeight(_minSliderWeight, _maxSliderWeight, name: "weight", unit: "kg"),
                              _sliderTotalWeight(_minSliderWeight, _maxSliderWeight, name: "weight", unit: "kg"),
                              Divider(
                                height: 5.0,
                                color: Colors.transparent,
                              ),

                              // segment height
                              if (SizeConfig.isMobilePortrait) _propertyRowMobileHeight(_minSliderHeight, _maxSliderHeight, name: "height", unit: "cm"),
                              _sliderTotalHeight(_minSliderHeight, _maxSliderHeight, name: "height", unit: "cm"),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<BmiCalcBloc, BmiCalcState>(
                        builder: (context, state) {
                          final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;

                          return Card(
                            margin: EdgeInsets.only(
                              top: resHeight(0.5, 1.0),
                              left: resHeight(1.0, 2.0),
                              right: resHeight(1.0, 2.0),
                              bottom: resHeight(1.0, 2.0),
                            ),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: _scoreRow(bmiModel.getBmiValueCategory, bmiModel),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );},
    );
  }

  Widget _scoreRow(int position, BmiCalcModel bmiModel) {
    List<String> _weightCategoryPercentiles = [
      "<= ${bmiModel.percentile5th.toStringAsFixed(1)}",
      "${bmiModel.percentile5th.toStringAsFixed(1)} - ${bmiModel.percentile85th.toStringAsFixed(1)}",
      "${bmiModel.percentile85th.toStringAsFixed(1)} - ${bmiModel.percentile95th.toStringAsFixed(1)}",
      ">= ${bmiModel.percentile95th.toStringAsFixed(1)}"
    ];
    List<String> _weightCategories = [
      "${AppLocalizations.of(context).translate(TranslationConstants.underweight)}",
      "${AppLocalizations.of(context).translate(TranslationConstants.normal)}",
      "${AppLocalizations.of(context).translate(TranslationConstants.overweight)}",
      "${AppLocalizations.of(context).translate(TranslationConstants.obese)}"
    ];
    // print(_weightCategoryPercentiles.toString());

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: resHeight(_horizPaddingFactorTextForMobile, _horizPaddingFactorTextForTablet), vertical: resHeight(2.0, 2.0)),
      child: Column(
        children: [
          for (int i = 0; i < _weightCategories.length; i++)
            i != position
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${_weightCategories[i]}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Expanded(child: Text("")),
                      Text(
                        "${_weightCategoryPercentiles[i]}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${_weightCategories[i]}",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: bmiModel.getRangeColor),
                      ),
                      Expanded(child: Text("")),
                      Text(
                        "${_weightCategoryPercentiles[i]}",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: bmiModel.getRangeColor),
                      ),
                    ],
                  ),
        ],
      ),
    );
  }

  Widget _propertyRowMobileWeight(int min, int max, {name, unit}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: resHeight(
          _horizPaddingFactorTextForMobile,
          _horizPaddingFactorTextForTablet,
        ),
        vertical: resHeight(.7, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${AppLocalizations.of(context).translate("$name")} ($unit): ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          //*********** decimalNumberPicker segment  ************/

          InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              return showDialog(
                context: context,
                builder: (ctx) {
                  return WeightDataPicker(min, max);
                },
              ).then((value) {
                setState(() {
                  _currentWeightValue = value;
                });
              });
            },
            child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
              builder: (context, state) {
                final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                _currentWeightValue = bmiModel.weight;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${_currentWeightValue.toStringAsFixed(1)}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _propertyRowMobileHeight(int min, int max, {name, unit}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: resHeight(
          _horizPaddingFactorTextForMobile,
          _horizPaddingFactorTextForTablet,
        ),
        vertical: resHeight(.7, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${AppLocalizations.of(context).translate("$name")} ($unit): ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          //*********** decimalNumberPicker segment  ************/
          InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              return showDialog(
                context: context,
                builder: (ctx) {
                  return HeightDataPicker(min, max);
                },
              ).then((value) {
                setState(() {
                  _currentHeightValue = value;
                });
              });
            },
            child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
              builder: (context, state) {
                // final bmiModel =
                //     (state as BmiCalculated).bmiCalcModel;
                if (state is HeightChanged) _currentHeightValue = state.height;
                // print("BMI: ${(state as BmiCalculating).value}");

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${_currentHeightValue.toStringAsFixed(1)}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // double weightOrHeightValue(String name) {
  //   if (name == "weight")
  //     return _currentWeightValue;
  //   else
  //     return _currentHeightValue;
  // }
// SliderWidgetWidget
  Widget _sliderTotalHeight(int min, int max, {name, unit}) {
    return Row(
      children: [
        if (!SizeConfig.isMobilePortrait)
          Flexible(
            flex: 30,
            child: _propertyRowMobileHeight(min, max, name: name, unit: unit),
          ),
        Flexible(
          flex: 65,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: resWidth(3.0, 2.0),
            ),
            child: SliderHeightWidget(
              sliderHeight: resHeight(5.0, 10.0),
              min: min,
              max: max,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sliderTotalWeight(int min, int max, {name, unit}) {
    return Row(
      children: [
        if (!SizeConfig.isMobilePortrait)
          Flexible(
            flex: 30,
            child: _propertyRowMobileWeight(min, max, name: name, unit: unit),
          ),
        Flexible(
          flex: 65,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: resWidth(3.0, 2.0),
            ),
            child: SliderWeightWidget(
              sliderHeight: resHeight(5.0, 10.0),
              min: min,
              max: max,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ageAndGender() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: resHeight(_horizPaddingFactorTextForMobile, _horizPaddingFactorTextForTablet),
        vertical: resHeight(2.0, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // age section
          Text("${AppLocalizations.of(context).translate(TranslationConstants.age)} :", style: Theme.of(context).textTheme.subtitle1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: resWidth(1.0, 2.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AgeDataPicker(2, 100, _currentAgeValue);
                    },
                  ).then((ageValue) {
                    setState(() {
                      _currentAgeValue = ageValue;
                    });
                  });
                },
                child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
                  builder: (context, state) {
                    final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                    _currentAgeValue = bmiModel.age;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black.withOpacity(0.08),
                      ),
                      child: Text(
                        "${_currentAgeValue.toStringAsFixed(0)}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // spacer for fill space
          Spacer(),

          // gender section
          FemaleMaleToggle(),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class WeightDataPicker extends StatefulWidget {
  // double _value;
  int _min;
  int _max;

  WeightDataPicker(this._min, this._max);

  @override
  _WeightDataPickerState createState() => _WeightDataPickerState();
}

class _WeightDataPickerState extends State<WeightDataPicker> {
  double _currentValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        // final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        // _currentValue = bmiModel.weight;
        if (state is WeightChanged) _currentValue = state.weight;
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).translate(TranslationConstants.select_weight)}', style: Theme.of(context).textTheme.bodyText1),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Text("cancell", style: Theme.of(context).textTheme.button),
            // ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _currentValue);
              },
              child: Text(
                "${AppLocalizations.of(context).translate(TranslationConstants.ok)}",
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          content: DecimalNumberPicker(
            value: _currentValue,
            minValue: widget._min,
            maxValue: widget._max,
            itemCount: 3,
            decimalPlaces: 1,
            onChanged: (value) {
              setState(() => _currentValue = value);
              // bmiModel.weight = _currentValue;

              BlocProvider.of<BmiCalcBloc>(context).add(WeightHasBeenSet(value));
            },
          ),
        );
      },
    );
  }
}

class HeightDataPicker extends StatefulWidget {
  // double _value;
  int _min;
  int _max;

  HeightDataPicker(this._min, this._max);

  @override
  _HeightDataPickerState createState() => _HeightDataPickerState();
}

class _HeightDataPickerState extends State<HeightDataPicker> {
  double _currentValue = 130;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        // final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        // _currentValue = bmiModel.weight;
        if (state is HeightChanged) _currentValue = state.height;
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).translate(TranslationConstants.select_height)}', style: Theme.of(context).textTheme.bodyText1),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Text("cancell", style: Theme.of(context).textTheme.button),
            // ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _currentValue);
              },
              child: Text(
                "${AppLocalizations.of(context).translate(TranslationConstants.ok)}",
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          content: DecimalNumberPicker(
            value: _currentValue,
            minValue: widget._min,
            maxValue: widget._max,
            itemCount: 3,
            decimalPlaces: 1,
            onChanged: (value) {
              setState(() => _currentValue = value);
              // bmiModel.weight = _currentValue;

              BlocProvider.of<BmiCalcBloc>(context).add(HeightHasBeenSet(value));
            },
          ),
        );
      },
    );
  }
}

// class HeightDataPicker extends StatefulWidget {
//   // double _value;
//   final int _min;
//   final int _max;

//   HeightDataPicker(this._min, this._max);
//   @override
//   _HeightDataPickerState createState() => _HeightDataPickerState();
// }

// class _HeightDataPickerState extends State<HeightDataPicker> {
//   double _currentValue;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BmiCalcBloc, BmiCalcState>(
//       builder: (context, state) {
//         // final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
//         if (state is HeightChanged) _currentValue = state.height;
//         return AlertDialog(
//           title: Text('select height',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyText1),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, _currentValue);
//               },
//               child: Text(
//                 "ok",
//                 style: Theme.of(context).textTheme.button,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//           content: DecimalNumberPicker(
//             value: _currentValue,
//             minValue: widget._min,
//             maxValue: widget._max,
//             itemCount: 3,
//             decimalPlaces: 1,
//             onChanged: (value) {
//               setState(() => _currentValue = value);
//               // bmiModel.height = _currentValue;
//               BlocProvider.of<BmiCalcBloc>(context).add(
//                 HeightHasBeenSet(value),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class AgeDataPicker extends StatefulWidget {
  // int _value;
  final int _min;
  final int _max;
  int _age;

  AgeDataPicker(this._min, this._max, this._age);

  @override
  _AgeDataPickerState createState() => _AgeDataPickerState();
}

class _AgeDataPickerState extends State<AgeDataPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        return AlertDialog(
          title: Text('${AppLocalizations.of(context).translate(TranslationConstants.select_age)}',
              textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, bmiModel.age);
              },
              child: Text(
                "${AppLocalizations.of(context).translate(TranslationConstants.ok)}",
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          content: NumberPicker(
            value: widget._age,
            minValue: widget._min,
            maxValue: widget._max,
            itemCount: 3,
            onChanged: (value) {
              setState(() {
                widget._age = value;
              });
              bmiModel.age = value;
              BlocProvider.of<BmiCalcBloc>(context).add(
                AgeHasBeenSet(value),
              );
            },
          ),
        );
      },
    );
  }
}

class FemaleMaleToggle extends StatefulWidget {
  FemaleMaleToggle({Key key}) : super(key: key);

  @override
  _FemaleMaleToggleState createState() => _FemaleMaleToggleState();
}

class _FemaleMaleToggleState extends State<FemaleMaleToggle> {
  bool maleToggle = true;
  Gender _genderCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        return Container(
          child: Row(
            children: [
              GestureDetector(

                onTap: () {
                  setState(() {
                    maleToggle = true;
                  });
                  _genderCategory = Gender.male;
                  BlocProvider.of<BmiCalcBloc>(context).add(
                    GenderHasBeenSet(_genderCategory),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${AppLocalizations.of(context).translate(TranslationConstants.male)}",
                    style: maleToggle ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              Text(" | ", style: Theme.of(context).textTheme.subtitle1),
              GestureDetector(
                onTap: () {
                  setState(() {
                    maleToggle = false;
                  });
                  _genderCategory = Gender.female;
                  BlocProvider.of<BmiCalcBloc>(context).add(
                    GenderHasBeenSet(_genderCategory),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${AppLocalizations.of(context).translate(TranslationConstants.female)}",
                    style: !maleToggle ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
