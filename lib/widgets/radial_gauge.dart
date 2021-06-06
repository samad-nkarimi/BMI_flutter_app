import 'package:flutter/material.dart';
import 'package:mbi_app/utils/size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatelessWidget {
  const RadialGauge({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      // backgroundColor: Colors.black26,
      // title: GaugeTitle(
      //     text: "null",
      //     textStyle:
      //         const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      axes: <RadialAxis>[
        RadialAxis(
          axisLabelStyle: GaugeTextStyle(
            fontSize: 1.5 * SizeConfig.heightMultiplier,
          ),
          tickOffset: 8.5 * SizeConfig.heightMultiplier,
          minimum: 12,
          maximum: 42,
          startAngle: 180,
          endAngle: 0,
          ranges: <GaugeRange>[
            GaugeRange(
              rangeOffset: 0,
              startValue: 12,
              endValue: 22,
              color: Colors.green,
              startWidth: 10 * SizeConfig.heightMultiplier,
              endWidth: 10 * SizeConfig.heightMultiplier,
            ),
            GaugeRange(
              startValue: 22,
              endValue: 32,
              color: Colors.orange,
              startWidth: 10 * SizeConfig.heightMultiplier,
              endWidth: 10 * SizeConfig.heightMultiplier,
            ),
            GaugeRange(
              startValue: 32,
              endValue: 42,
              color: Colors.red,
              startWidth: 10 * SizeConfig.heightMultiplier,
              endWidth: 10 * SizeConfig.heightMultiplier,
            )
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              needleColor: Colors.blue,
              value: 30,
              tailStyle: TailStyle(width: 8, length: 0.08),
              lengthUnit: GaugeSizeUnit.factor,
              needleLength: 0.4,
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    padding: EdgeInsets.all(0.5 * SizeConfig.heightMultiplier),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text('90.0',
                        style: TextStyle(
                            fontSize: 4 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.25)
          ],
        )
      ],
    );
  }
}
