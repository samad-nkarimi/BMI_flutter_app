import 'package:BMI/blocs/overlay/overlay_bloc.dart';
import 'package:BMI/utils/constants/size_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/widgets/ui_widgets/age_and_gender_widget.dart';
import 'package:BMI/widgets/ui_widgets/categories_box.dart';
import 'package:BMI/widgets/ui_widgets/customized_app_bar.dart';
import 'package:BMI/widgets/ui_widgets/mobile_height_label.dart';
import 'package:BMI/widgets/ui_widgets/mobile_weight_label.dart';
import 'package:BMI/widgets/ui_widgets/total_height_slider.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../screens/drawer_screen.dart';
import '../utils/size/size_config.dart';
import '../widgets/third_part/radial_gauge.dart';

class MBIHome extends StatefulWidget {
  final Color transparentColor;
  MBIHome({Key key, this.transparentColor = Colors.transparent})
      : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverlayCubit, OverlayColorState>(
        builder: (context, state) {
      print(state);
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: state.color,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: state.color,
          //
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  drawer: MbiDrawer(),
                  appBar: PreferredSize(
                    preferredSize: Size(double.infinity,
                        SizeConfig.responsiveHeight(8.0, 10.0)),
                    child: CustomizedAppBar(),
                  ),
                  body: Stack(
                    // alignment: Alignment.topCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(50))),
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                            // top: SizeConfig.responsiveWidth(5.0, 0.0),
                            left: 10.0,
                            right: 10.0),
                        height: SizeConfig.responsiveHeight(50.0, 55.0),
                        child: RadialGauge(),
                      ),
                      Container(
                        // color: Colors.white,
                        // color: Colors.white,
                        height: double.infinity,
                        width: double.infinity,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // if (kIsWeb) SizedBox(height: 400),
                            BlocBuilder<BmiCalcBloc, BmiCalcState>(
                              builder: (context, state) {
                                final bmiModel =
                                    BlocProvider.of<BmiCalcBloc>(context)
                                        .bmiCalcModel;
                                // showing normal weight on screen
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.3),
                                    border: Border.all(
                                        width: 1, color: Colors.green),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.responsiveHeight(5.0, 10.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: SizeConfig.responsiveHeight(
                                      2, // adding 1.0 for card margin
                                      SizeConstants
                                              .tabletHorizontalPaddingFactorText +
                                          1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context).translate(TranslationConstants.normal_weight)}(kg)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                      Text(
                                          "${bmiModel.minimumNormalWeight().toStringAsFixed(1)} - ${bmiModel.maximumNormalWeight().toStringAsFixed(1)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2)
                                    ],
                                  ),
                                );
                              },
                            ),
                            // the box relevant to sliders
                            // showing controller height/weight/age/gender widgets
                            Card(
                              color: Theme.of(context).colorScheme.surface,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.responsiveHeight(1.0, 1.0),
                                  left: SizeConfig.responsiveHeight(1.0, 2.0),
                                  right: SizeConfig.responsiveHeight(1.0, 2.0),
                                  bottom:
                                      SizeConfig.responsiveHeight(0.5, 0.5)),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                // side: BorderSide(width: 5, color: Colors.green),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        SizeConfig.responsiveHeight(1.0, 2.5)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //  age & gender segment
                                    AgeAndGender(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Divider(
                                          height: 0.5, color: Colors.black26),
                                    ),
                                    //  weight segment
                                    SizedBox(
                                        height: SizeConfig.responsiveHeight(
                                            1.0, 2.0)),
                                    if (SizeConfig.isMobilePortrait)
                                      MobileWeightLabel(),
                                    TotalHeightOrWeightSlider(
                                        heightorweight.weight),
                                    /* for tablets */
                                    Divider(
                                      height: 5.0,
                                      color: Colors.transparent,
                                    ),

                                    //  height segment
                                    if (SizeConfig.isMobilePortrait)
                                      MobileHeightLabel(),
                                    TotalHeightOrWeightSlider(heightorweight
                                        .height), /* for tablets */
                                  ],
                                ),
                              ),
                            ),
                            // showing category section
                            Card(
                              color: Theme.of(context).colorScheme.surface,
                              margin: EdgeInsets.only(
                                top: SizeConfig.responsiveHeight(0.5, 0.5),
                                left: SizeConfig.responsiveHeight(1.0, 2.0),
                                right: SizeConfig.responsiveHeight(1.0, 2.0),
                                bottom: SizeConfig.responsiveHeight(1.0, 2.0),
                              ),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: CategoriesBox(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //mode 1 -> two next widgets

                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          tileMode: TileMode.clamp,
                          colors: [
                            state.color,
                            widget.transparentColor,
                            widget.transparentColor,
                            widget.transparentColor,
                            state.color,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 0.07, 0.5, 0.93, 1]),
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          tileMode: TileMode.repeated,
                          colors: [
                            state.color,
                            widget.transparentColor,
                            widget.transparentColor,
                            widget.transparentColor,
                            state.color,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.05, 0.5, 0.95, 1]),
                    ),
                  ),
                ),

                // // mode 2
                // IgnorePointer(
                //   ignoring: true,
                //   child: Container(
                //     height: double.infinity,
                //     width: double.infinity,
                //     child: secondColorizeMode(
                //         state.color, widget.transparentColor),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget secondColorizeMode(Color primary, Color transparent) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 20,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                primary,
                transparent,
              ],
              stops: [0.2, 0.7],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 20,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                primary,
                transparent,
              ],
              stops: [0.2, 0.7],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            )),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                primary,
                transparent,
              ],
              stops: [0.2, 0.7],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                primary,
                transparent,
              ],
              stops: [0.2, 0.7],
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            )),
          ),
        )
      ],
    );
  }
}
