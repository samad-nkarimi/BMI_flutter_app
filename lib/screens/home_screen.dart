import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import '../blocs/blocs.dart';
import '../models/models.dart';
import '../screens/drawer_screen.dart';
import '../utils/size_config.dart';
import '../widgets/slider_weight_widget.dart';
import 'package:numberpicker/numberpicker.dart';

import '../widgets/slider_height_widget.dart';
import '../widgets/radial_gauge.dart';

class MBIHome extends StatefulWidget {
  MBIHome({Key key}) : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  // var _gaugeValue = 12.0;
  double _currentWeightValue = 58.3;
  double _currentHeightValue = 110.6;
  int _currentAgeValue = 20;
  double _horizPaddingFactorTextForMobile = 5.0;
  double _horizPaddingFactorTextForTablet = 5.0;
  // NumberPicker decimalNumberPicker;
  List<String> _weightCategories = [
    "underweight",
    "normal",
    "overweight",
    "obiouse"
  ];
  List<String> _weightCategoryPercentiles = [
    "<= 18.5",
    "18.0 - 25.0",
    "25.0 - 30.0",
    ">= 30.0"
  ];

  double resHeight(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.heightMultiplier;
  }

  double resWidth(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.widthMultiplier;
  }

  double resText(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.textMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          drawer: MbiDrawer(),
          appBar: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: resWidth(12.0, 8.0),
                      height: resWidth(12.0, 8.0),
                      child: IconButton(
                        // iconSize: 10 * SizeConfig.heightMultiplier,
                        icon: SvgPicture.asset("assets/images/menu_icon.svg"),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    // color: Colors.black12,
                    width: resWidth(50.0, 40.0),
                    height: resHeight(20.0, 15.0),
                    child: SvgPicture.asset("assets/images/bmi_name.svg"),
                  ),
                ),
              ],
            ),
            preferredSize: Size(double.infinity, resHeight(10, 10.0)),
          ),
          body: Stack(
            // alignment: Alignment.topCenter,
            children: [
              Container(
                // color: Colors.black26,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: resWidth(5.0, 0.0), left: 10.0, right: 10.0),
                height: resHeight(50.0, 55.0),
                child: RadialGauge(
                    // value: bmiValue,
                    ),
              ),
              Container(
                // color: Colors.amber.withOpacity(0.4),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<BmiCalcBloc, BmiCalcState>(
                      builder: (context, state) {
                        final bmiModel =
                            BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: resHeight(
                              _horizPaddingFactorTextForMobile +
                                  1.0, // adding 1.0 for card margin
                              _horizPaddingFactorTextForTablet + 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "normal weight(kg)",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: Colors.blue),
                              ),
                              Text(
                                "${((24.5 * bmiModel.height * bmiModel.height * 0.4356) / (703 * 2.54 * 2.54)).toStringAsFixed(1)} - ${((30.5 * bmiModel.height * bmiModel.height * 0.4356) / (703 * 2.54 * 2.54)).toStringAsFixed(1)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: Colors.blue),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    // box marbout be seekha
                    Card(
                      margin: EdgeInsets.only(
                          top: resHeight(1.0, 2.0),
                          left: resHeight(1.0, 2.0),
                          right: resHeight(1.0, 2.0),
                          bottom: resHeight(0.5, 1.0)),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        // side: BorderSide(width: 5, color: Colors.green),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: resHeight(1.0, 2.5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // segment age & gender
                            _ageAndGender(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child:
                                  Divider(height: 0.5, color: Colors.black26),
                            ),
                            // segment weight
                            if (SizeConfig.isMobilePortrait)
                              _propertyRowMobileWeight(20, 200,
                                  name: "weight", unit: "kg"),
                            _sliderTotalWeight(20, 200,
                                name: "weight", unit: "kg"),
                            Divider(
                              height: 5.0,
                              color: Colors.transparent,
                            ),

                            // segment height
                            if (SizeConfig.isMobilePortrait)
                              _propertyRowMobileHeight(130, 220,
                                  name: "height", unit: "cm"),
                            _sliderTotalHeight(130, 220,
                                name: "height", unit: "cm"),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<BmiCalcBloc, BmiCalcState>(
                      builder: (context, state) {
                        final double bmiValue = state is BmiCalculated
                            ? (state.bmiValue ?? 20)
                            : 40;
                        final bmiModel =
                            BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;

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
                          child: _scoreRow(
                              getBmiValueCategory(bmiValue, bmiModel),
                              bmiModel),
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
    );
  }

  Widget _scoreRow(int position, BmiCalcModel bmiModel) {
    List<String> _weightCategoryPercentiles = [
      "<= ${bmiModel.percentile5th.toStringAsFixed(1)}",
      "${bmiModel.percentile5th.toStringAsFixed(1)} - ${bmiModel.percentile85th.toStringAsFixed(1)}",
      "${bmiModel.percentile85th.toStringAsFixed(1)} - ${bmiModel.percentile95th.toStringAsFixed(1)}",
      ">= ${bmiModel.percentile95th.toStringAsFixed(1)}"
    ];

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: resHeight(_horizPaddingFactorTextForMobile,
              _horizPaddingFactorTextForTablet),
          vertical: resHeight(2.0, 2.0)),
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
                        style: TextStyle(color: Colors.blue),
                      ),
                      Expanded(child: Text("")),
                      Text(
                        "${_weightCategoryPercentiles[i]}",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
        ],
      ),
    );
  }

  int getBmiValueCategory(double _bmivalue, BmiCalcModel _bmiModel) {
    int _categoryNumber = 0;
    if (_bmivalue <= _bmiModel.percentile5th) _categoryNumber = 0;
    if (_bmivalue >= _bmiModel.percentile5th &&
        _bmivalue <= _bmiModel.percentile85th) _categoryNumber = 1;
    if (_bmivalue >= _bmiModel.percentile85th &&
        _bmivalue <= _bmiModel.percentile95th) _categoryNumber = 2;
    if (_bmivalue >= _bmiModel.percentile95th) _categoryNumber = 3;
    return _categoryNumber;
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
            "$name($unit): ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          //*********** decimalNumberPicker segment  ************/

          InkWell(
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
                final bmiModel =
                    BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                _currentWeightValue = bmiModel.weight;
                return Text(
                  "${_currentWeightValue.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.bodyText1,
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
            "$name($unit): ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          //*********** decimalNumberPicker segment  ************/
          InkWell(
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
                final bmiModel =
                    BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                _currentHeightValue = bmiModel.height;
                return Text(
                  "${_currentHeightValue.toStringAsFixed(1)}",
                  style: Theme.of(context).textTheme.bodyText1,
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
        horizontal: resHeight(
            _horizPaddingFactorTextForMobile, _horizPaddingFactorTextForTablet),
        vertical: resHeight(2.0, 3.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // age section
          Text("age:", style: Theme.of(context).textTheme.subtitle1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: resWidth(1.0, 2.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
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
                    final bmiModel =
                        BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                    _currentAgeValue = bmiModel.age;
                    return Text(
                      "${_currentAgeValue.toStringAsFixed(0)}",
                      style: Theme.of(context).textTheme.bodyText1,
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
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        _currentValue = bmiModel.weight;
        return AlertDialog(
          title: Text('select weight',
              style: Theme.of(context).textTheme.bodyText1),
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
                "ok",
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
              bmiModel.weight = _currentValue;

              BlocProvider.of<BmiCalcBloc>(context)
                  .add(DataInputChanged(bmiModel));
            },
          ),
        );
      },
    );
  }
}

class HeightDataPicker extends StatefulWidget {
  // double _value;
  final int _min;
  final int _max;

  HeightDataPicker(this._min, this._max);
  @override
  _HeightDataPickerState createState() => _HeightDataPickerState();
}

class _HeightDataPickerState extends State<HeightDataPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        return AlertDialog(
          title: Text('select weight',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, bmiModel.height);
              },
              child: Text(
                "ok",
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          content: DecimalNumberPicker(
            value: bmiModel.height,
            minValue: widget._min,
            maxValue: widget._max,
            itemCount: 3,
            decimalPlaces: 1,
            onChanged: (value) {
              bmiModel.height = value;
              BlocProvider.of<BmiCalcBloc>(context).add(
                DataInputChanged(bmiModel),
              );
            },
          ),
        );
      },
    );
  }
}

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
          title: Container(
            color: Colors.amber,
            child: Expanded(
              child: Text('select age',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, bmiModel.age);
              },
              child: Text(
                "ok",
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          content: Container(
            color: Colors.blue,
            child: NumberPicker(
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
                  DataInputChanged(bmiModel),
                );
              },
            ),
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
                  bmiModel.genderCategory = Gender.male;
                  BlocProvider.of<BmiCalcBloc>(context).add(
                    DataInputChanged(bmiModel),
                  );
                },
                child: Text(
                  "male",
                  style: maleToggle
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Text(" | ", style: Theme.of(context).textTheme.subtitle1),
              GestureDetector(
                onTap: () {
                  setState(() {
                    maleToggle = false;
                  });
                  bmiModel.genderCategory = Gender.female;
                  BlocProvider.of<BmiCalcBloc>(context).add(
                    DataInputChanged(bmiModel),
                  );
                },
                child: Text(
                  "female",
                  style: !maleToggle
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
