import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../blocs/bmi_calc/bmi_calc_bloc.dart';
import '../utils/size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatelessWidget {
  // double value;
  RadialGauge({
    // this.value = 12.0,
    Key key,
  }) : super(key: key);

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
    final _width = resHeight(8.5, 10.0);
    print("gauge repainted ------------------------------------- ");
    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final double bmiValue =
            state is BmiCalculated ? (state.bmiValue ?? 20) : 24;

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              axisLabelStyle: GaugeTextStyle(
                fontSize: resText(1.5, 1.5),
              ),
              tickOffset: resHeight(7.0, 9.2),
              minimum: 12.0,
              maximum: 42.0,
              interval: 5.0,
              startAngle: 180,
              endAngle: 0,
              ranges: <GaugeRange>[
                GaugeRange(
                  label: "underweight",
                  labelStyle: GaugeTextStyle(
                    fontSize: resText(2.0, 2.0),
                    color: Colors.white,
                  ),
                  rangeOffset: 0,
                  startValue: 12,
                  endValue: 22,
                  color: Colors.blue,
                  startWidth: _width,
                  endWidth: _width,
                ),
                GaugeRange(
                  label: "normal",
                  labelStyle: GaugeTextStyle(
                    fontSize: resText(2.0, 2.0),
                    color: Colors.white,
                  ),
                  startValue: 22,
                  endValue: 32,
                  color: Colors.green,
                  startWidth: _width,
                  endWidth: _width,
                ),
                GaugeRange(
                  label: "overweight",
                  labelStyle: GaugeTextStyle(
                    fontSize: resText(2.0, 2.0),
                    color: Colors.white,
                  ),
                  startValue: 32,
                  endValue: 42,
                  color: Colors.orange,
                  startWidth: _width,
                  endWidth: _width,
                )
              ],
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: bmiValue,
                  markerHeight: resHeight(3.0, 4.0),
                  markerWidth: resHeight(3.0, 4.0),
                  markerType: MarkerType.triangle,
                  markerOffset: resHeight(6.5, 7.7),
                  color: Colors.white,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Container(
                    padding: EdgeInsets.all(0.5 * SizeConfig.heightMultiplier),
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.blueAccent, width: 3),
                    //     borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      '${bmiValue.toStringAsFixed(1)}',
                      style: TextStyle(
                          fontSize: resText(4.0, 4.0),
                          fontWeight: FontWeight.bold),
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
