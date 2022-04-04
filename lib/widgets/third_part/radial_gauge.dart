import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../blocs/blocs.dart';
import '../../blocs/bmi_calc/bmi_calc_bloc.dart';
import '../../utils/size/size_config.dart';

class RadialGauge extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    final _width = SizeConfig.responsiveHeight(8.5, 10.0);
    print("gauge repainted ------------------------------------- ");
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        // print(bmiModel);
        // calculate min,max
        double _normalMin = double.parse("${bmiModel.percentile5th.toStringAsFixed(1)}");
        double _normalMax = double.parse("${bmiModel.percentile85th.toStringAsFixed(1)}");
        double _normalDomain = _normalMax - _normalMin;
        double _min = _normalMin - _normalDomain;
        double _max = _normalMax + _normalDomain;

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              axisLabelStyle: GaugeTextStyle(
                fontSize: SizeConfig.responsiveHeight(1.5, 1.5),
              ),
              tickOffset: SizeConfig.responsiveHeight(7.0, 9.2),
              minimum: _min,
              maximum: _max,
              interval: _normalDomain,
              startAngle: 180,
              endAngle: 0,
              ranges: <GaugeRange>[
                GaugeRange(
                  label: AppLocalizations.of(context).translate(TranslationConstants.underweight),
                  labelStyle:
                  GaugeTextStyle(
                    fontSize: SizeConfig.responsiveText(2.0, 2.0),
                    color: Colors.white,
                  ),
                  rangeOffset: 0,
                  startValue: _min,
                  endValue: _normalMin,
                  color: Colors.blue,
                  startWidth: _width,
                  endWidth: _width,
                ),
                GaugeRange(
                  // label: "normal",
                  label: AppLocalizations.of(context).translate(TranslationConstants.normal),
                  labelStyle: GaugeTextStyle(
                    fontSize: SizeConfig.responsiveText(2.0, 2.0),
                    color: Colors.white,
                  ),
                  startValue: _normalMin,
                  endValue: _normalMax,
                  color: Colors.green,
                  startWidth: _width,
                  endWidth: _width,
                ),
                GaugeRange(
                  label: AppLocalizations.of(context).translate(TranslationConstants.overweight),
                  labelStyle: GaugeTextStyle(
                    fontSize: SizeConfig.responsiveText(2.0, 2.0),
                    color: Colors.white,
                  ),
                  startValue: _normalMax,
                  endValue: _max,
                  color: Colors.orange,
                  startWidth: _width,
                  endWidth: _width,
                ),
              ],
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: bmiModel.bmiValue,
                  markerHeight: SizeConfig.responsiveHeight(3.0, 4.0),
                  markerWidth: SizeConfig.responsiveHeight(3.0, 4.0),
                  markerType: MarkerType.triangle,
                  markerOffset: SizeConfig.responsiveHeight(6.5, 7.7),
                  color: Colors.white,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Container(
                    padding: EdgeInsets.all(0.5 * SizeConfig.heightMultiplier),
                    // padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black.withOpacity(0.08),
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.blueAccent, width: 3),
                    //     borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      '${bmiModel.bmiValue.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: SizeConfig.responsiveText(4.0, 4.0),
                        fontWeight: FontWeight.bold,
                        color: bmiModel.getRangeColor,
                      ),
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.0,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
