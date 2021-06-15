import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mbi_app/blocs/blocs.dart';
import 'package:mbi_app/screens/drawer_screen.dart';
import 'package:mbi_app/utils/size_config.dart';

import '../widgets/custom_slider.dart';
import '../widgets/radial_gauge.dart';

class MBIHome extends StatefulWidget {
  MBIHome({Key key}) : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  String _selectedWeightUnit = "kg";
  String _selectedHeightUnit = "ft";
  var _gaugeValue = 12.0;

  Widget _scoreRow(String text, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            text2,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  double resHeight(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.heightMultiplier;
  }

  double resWidth(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.widthMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final double bmiValue =
            state is BmiCalculated ? (state.bmiValue ?? 20) : 24;

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
                        child: IconButton(
                          iconSize: 10 * SizeConfig.heightMultiplier,
                          icon: Image.asset(
                            "assets/icons/menu.png",
                            fit: BoxFit.fill,
                            width: resWidth(8.0, 6.0),
                            height: resWidth(8.0, 6.0),
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
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
                      value: bmiValue,
                    ),
                  ),
                  Container(
                    // color: Colors.amber.withOpacity(0.4),
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                            padding: EdgeInsets.symmetric(
                                vertical: resHeight(1.0, 2.5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (SizeConfig.isMobilePortrait)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            0.5 * SizeConfig.heightMultiplier),
                                        child: Text(
                                          "weight",
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            0.5 * SizeConfig.heightMultiplier),
                                        child: Text(
                                          "70",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                      FlutterToggleTab(
                                        isScroll: false,
                                        width: resWidth(7.0, 2.0),
                                        height: resHeight(4.0, 4.0),
                                        borderRadius: 10,
                                        initialIndex: 0,
                                        selectedTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        unSelectedTextStyle: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                        labels: ["kg", "lb"],
                                        selectedLabelIndex: (index) {
                                          print("Selected Index $index");
                                        },
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    if (!SizeConfig.isMobilePortrait)
                                      Flexible(
                                        flex: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // if (SizeConfig.isMobilePortrait)
                                            Padding(
                                              padding: EdgeInsets.all(0.5 *
                                                  SizeConfig.heightMultiplier),
                                              child: Text(
                                                "weight",
                                              ),
                                            ),
                                            Container(
                                              width: 70,
                                              padding: EdgeInsets.all(0.5 *
                                                  SizeConfig.heightMultiplier),
                                              child: Expanded(
                                                child: TextField(
                                                  enabled: true,
                                                  maxLength: 3,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    hintText: '150',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // if (SizeConfig.isMobilePortrait)
                                            FlutterToggleTab(
                                              isScroll: false,
                                              width: resWidth(7.0, 1.5),
                                              height: resHeight(4.0, 4.0),
                                              borderRadius: 10,
                                              initialIndex: 0,
                                              selectedTextStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                              unSelectedTextStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                              labels: ["kg", "lb"],
                                              selectedLabelIndex: (index) {
                                                print("Selected Index $index");
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    Flexible(
                                      flex: 65,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.0 *
                                                SizeConfig.heightMultiplier,
                                            horizontal: 3.0 *
                                                SizeConfig.heightMultiplier),
                                        child: SliderWidget(
                                          Parameter.weight,
                                          sliderHeight:
                                              6.0 * SizeConfig.heightMultiplier,
                                          min: 30,
                                          max: 200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Divider(
                                      height: 0.5, color: Colors.black26),
                                ),

                                // for height
                                if (SizeConfig.isMobilePortrait)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            0.5 * SizeConfig.heightMultiplier),
                                        child: Text(
                                          "height",
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            0.5 * SizeConfig.heightMultiplier),
                                        child: Text(
                                          "170",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                      FlutterToggleTab(
                                        isScroll: false,
                                        width: resWidth(7.0, 2.0),
                                        height: resHeight(4.0, 4.0),
                                        borderRadius: 10,
                                        initialIndex: 0,
                                        selectedTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        unSelectedTextStyle: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                        labels: ["cm", "ft"],
                                        selectedLabelIndex: (index) {
                                          print("Selected Index $index");
                                        },
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    if (!SizeConfig.isMobilePortrait)
                                      Flexible(
                                        flex: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(0.5 *
                                                  SizeConfig.heightMultiplier),
                                              child: Text(
                                                "height",
                                              ),
                                            ),
                                            Container(
                                              width: 70,
                                              padding: EdgeInsets.all(0.5 *
                                                  SizeConfig.heightMultiplier),
                                              child: Expanded(
                                                child: TextField(
                                                  enabled: true,
                                                  maxLength: 3,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    hintText: '180',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            FlutterToggleTab(
                                              isScroll: false,
                                              width: resWidth(7.0, 1.5),
                                              height: resHeight(4.0, 4.0),
                                              borderRadius: 10,
                                              initialIndex: 0,
                                              selectedTextStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                              unSelectedTextStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                              labels: ["cm", "ft"],
                                              selectedLabelIndex: (index) {
                                                print("Selected Index $index");
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    Flexible(
                                      flex: 65,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.0 *
                                                SizeConfig.heightMultiplier,
                                            horizontal: 3.0 *
                                                SizeConfig.heightMultiplier),
                                        child: SliderWidget(
                                          Parameter.height,
                                          sliderHeight:
                                              6.0 * SizeConfig.heightMultiplier,
                                          min: 130,
                                          max: 220,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("age"),
                                    ),
                                    FlutterToggleTab(
                                      isScroll: false,
                                      width: resWidth(10.0, 3.0),
                                      height: resHeight(6.0, 6.0),
                                      borderRadius: 15,
                                      initialIndex: 0,
                                      selectedTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600),
                                      unSelectedTextStyle: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400),
                                      labels: ["-21", "+21"],
                                      selectedLabelIndex: (index) {
                                        print("Selected Index $index");
                                      },
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/woman.svg",
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: resWidth(2.0, 4.0),
                                        ),
                                        VerticalDivider(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        SvgPicture.asset(
                                            "assets/images/man.svg"),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(
                              top: resHeight(0.5, 1.0),
                              left: resHeight(1.0, 2.0),
                              right: resHeight(1.0, 2.0),
                              bottom: resHeight(1.0, 2.0)),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            // side: BorderSide(width: 5, color: Colors.green),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("underweight"),
                                    Text("normal"),
                                    Text(
                                      "overweight",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text("obiouse"),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("=<17.5"),
                                    Text("17.5-24.5"),
                                    Text(
                                      "24.5-35.5",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(">=35.5"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
