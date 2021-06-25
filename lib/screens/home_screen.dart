import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mbi_app/blocs/blocs.dart';
import 'package:mbi_app/models/models.dart';
import 'package:mbi_app/screens/drawer_screen.dart';
import 'package:mbi_app/utils/size_config.dart';
import 'package:numberpicker/numberpicker.dart';

import '../widgets/custom_slider.dart';
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
  // NumberPicker decimalNumberPicker;
  Map<String, String> _scores = {
    "underweight": "18.5>=",
    "normal": "18.5 - 25.0",
    "overweight": "25.0 - 30.0",
    "obiouse": ">=30.0"
  };

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
                    top: resWidth(5.0, 0.0), left: 15, right: 15),
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
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Normal Weight"),
                            Text(
                                "(${((24.5 * bmiModel.height * bmiModel.height * 0.4356) / (703 * 2.54 * 2.54)).toStringAsFixed(1)} - ${((30.5 * bmiModel.height * bmiModel.height * 0.4356) / (703 * 2.54 * 2.54)).toStringAsFixed(1)})")
                          ],
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
                        borderRadius: BorderRadius.circular(15.0),
                        // side: BorderSide(width: 5, color: Colors.green),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: resHeight(1.0, 2.5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // segment weight
                            if (SizeConfig.isMobilePortrait)
                              _propertyRowMobile(20, 200,
                                  name: "weight", unit: "kg"),
                            _sliderTotal(20, 200, name: "weight", unit: "kg"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child:
                                  Divider(height: 0.5, color: Colors.black26),
                            ),

                            // segment height
                            if (SizeConfig.isMobilePortrait)
                              _propertyRowMobile(130, 220,
                                  name: "height", unit: "cm"),
                            _sliderTotal(130, 220, name: "height", unit: "cm"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child:
                                  Divider(height: 0.5, color: Colors.black26),
                            ),
                            // segment age & gender
                            _ageAndGender(),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<BmiCalcBloc, BmiCalcState>(
                      builder: (context, state) {
                        final double bmiValue = state is BmiCalculated
                            ? (state.bmiValue ?? 20)
                            : 40;

                        return Card(
                          margin: EdgeInsets.only(
                              top: resHeight(0.5, 1.0),
                              left: resHeight(1.0, 2.0),
                              right: resHeight(1.0, 2.0),
                              bottom: resHeight(1.0, 2.0)),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: _scoreRow(getBmiValueCategory(bmiValue)),
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

  Widget _scoreRow(int position) {
    print("position: $position**************************************");
    return Container(
      // width: double.infinity,
      // color: Colors.black12,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      child: Column(
        children: [
          for (int i = 0; i < _scores.length; i++)
            i != position
                ? Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("${_scores.keys.elementAt(i)}"),
                      Expanded(
                        child: Text(
                          "",
                        ),
                      ),
                      Text("${_scores.values.elementAt(i)}"),
                    ],
                  )
                : Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${_scores.keys.elementAt(i)}",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Expanded(
                        child: Text(
                          // "----------------",
                          "<<  >>",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: resText(3.0, 3.0), color: Colors.blue),
                        ),
                      ),
                      Text(
                        "${_scores.values.elementAt(i)}",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
        ],
      ),
    );
  }

  int getBmiValueCategory(double _bmivalue) {
    print("bmi: $_bmivalue*********************************************");
    int _categoryNumber = 0;
    if (_bmivalue <= 18.5) _categoryNumber = 0;
    if (_bmivalue >= 18.5 && _bmivalue <= 25.0) _categoryNumber = 1;
    if (_bmivalue >= 25.0 && _bmivalue <= 30.0) _categoryNumber = 2;
    if (_bmivalue >= 30.0) _categoryNumber = 3;
    print("categoryNumber: $_categoryNumber*******************************");
    return _categoryNumber;
  }

  Widget _propertyRowMobile(int min, int max, {name, unit}) {
    final parameter = name == "weight" ? Parameter.weight : Parameter.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(0.5 * SizeConfig.heightMultiplier),
          child: Text(
            "$name($unit): ",
          ),
        ),
        //*********** decimalNumberPicker segment  ************/
        TextButton(
          onPressed: () {
            return showDialog(
              context: context,
              builder: (ctx) {
                return _DecimalExample(parameter, min, max);
              },
            ).then((value) {
              setState(() {
                if (value != null && name == "weight")
                  _currentWeightValue = value;
                if (value != null && name == "height")
                  _currentHeightValue = value;
              });
            });
          },
          child: Text(
            "${weightOrHeightValue(name)}",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }

  double weightOrHeightValue(String name) {
    if (name == "weight")
      return _currentWeightValue;
    else
      return _currentHeightValue;
  }

  Widget _sliderTotal(int min, int max, {name, unit}) {
    return Row(
      children: [
        if (!SizeConfig.isMobilePortrait)
          Flexible(
            flex: 30,
            child: _propertyRowMobile(min, max, name: name, unit: unit),
          ),
        Flexible(
          flex: 65,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: resWidth(1.0, 2.0),
            ),
            child: SliderWidget(
              Parameter.weight,
              sliderHeight: 6.0 * SizeConfig.heightMultiplier,
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
      padding: EdgeInsets.all(resHeight(1.0, 1.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 30,
            child: Text("age & gender"),
          ),
          BlocBuilder<BmiCalcBloc, BmiCalcState>(builder: (context, state) {
            final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
            return Flexible(
              flex: 65,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: resWidth(1.0, 2.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlutterToggleTab(
                        isScroll: false,
                        width: resWidth(7.0, 2.8),
                        height: resHeight(6.0, 5.5),
                        borderRadius: 15,
                        initialIndex: 0,
                        selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: resText(2.5, 3.5),
                            fontWeight: FontWeight.w600),
                        unSelectedTextStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: resText(2.5, 3.5),
                            fontWeight: FontWeight.w400),
                        labels: ["-21", "+21"],
                        selectedLabelIndex: (index) {
                          bmiModel.ageCategory =
                              index == 0 ? Age.lessThan21 : Age.greaterThan21;
                          BlocProvider.of<BmiCalcBloc>(context).add(
                            DataInputChanged(bmiModel),
                          );
                          print("Selected Index $index");
                        },
                      ),
                      // Spacer(),
                      FlutterToggleTab(
                        isScroll: false,
                        width: resWidth(7.0, 2.8),
                        height: resHeight(6.0, 5.5),
                        borderRadius: 15,
                        initialIndex: 0,
                        selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: resText(2.0, 3.5),
                            fontWeight: FontWeight.w600),
                        unSelectedTextStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: resText(2.0, 3.5),
                            fontWeight: FontWeight.w400),
                        labels: ["male", "female"],
                        selectedLabelIndex: (index) {
                          bmiModel.genderCategory =
                              index == 0 ? Gender.male : Gender.female;
                          BlocProvider.of<BmiCalcBloc>(context)
                              .add(DataInputChanged(bmiModel));
                          print("Selected Index $index");
                        },
                      ),
                    ],
                  )),
            );
          }),

          // Row(
          //   children: [
          //     SvgPicture.asset(
          //       "assets/images/woman.svg",
          //       color: Colors.red,
          //     ),
          //     SizedBox(
          //       width: resWidth(2.0, 4.0),
          //     ),
          //     VerticalDivider(
          //       width: 1,
          //       color: Colors.black,
          //     ),
          //     SvgPicture.asset(
          //         "assets/images/man.svg"),
          //   ],
          // ),
        ],
      ),
    );
  }

  // _handleValueChanged(num value) {
  //   print("$value ***************************");
  //   if (value != null) {
  //     setState(() => _currentDoubleValue = value);
  //     // decimalNumberPicker.animateDecimalAndInteger(value);

  //   }
  // }
  // Future _showDoubleDialog() async {
  // await showDialog<double>(

  //   context: context,
  //   builder: (BuildContext context) {
  //     return DecimalNumberPicker.(
  //       minValue: 1,
  //       maxValue: 5,
  //       decimalPlaces: 2,
  //       initialDoubleValue: _currentDoubleValue,
  //       title: new Text("Pick a decimal value"),
  //     );
  //   },
  // ).then(_handleValueChangedExternally);
  // }

}

// ignore: must_be_immutable
class _DecimalExample extends StatefulWidget {
  // double _value;
  int _min;
  int _max;
  final Parameter parameterType;
  _DecimalExample(this.parameterType, this._min, this._max);
  @override
  __DecimalExampleState createState() => __DecimalExampleState();
}

class __DecimalExampleState extends State<_DecimalExample> {
  // double _currentDoubleValue;
  int _minValue;
  int _maxValue;
  @override
  void initState() {
    // _currentDoubleValue = widget._value;
    _minValue = widget._min;
    _maxValue = widget._max;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        return AlertDialog(
          title: Text('select weight',
              style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancell", style: Theme.of(context).textTheme.button),
            ),
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
              minValue: _minValue,
              maxValue: _maxValue,
              itemCount: 3,
              decimalPlaces: 1,
              onChanged: (value) {
                // setState(
                //   () => _currentDoubleValue = value,
                // );
                if (widget.parameterType == Parameter.weight)
                  bmiModel.weight = value;
                else
                  bmiModel.height = value;
                BlocProvider.of<BmiCalcBloc>(context)
                    .add(DataInputChanged(bmiModel));
              }),
        );
      },
    );
  }
}
