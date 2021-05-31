import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatelessWidget {
  const RadialGauge({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      // title: GaugeTitle(
      //     text: "null",
      //     textStyle:
      //         const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      axes: <RadialAxis>[
        RadialAxis(
          tickOffset: 40,
          minimum: 0,
          maximum: 120,
          startAngle: 140,
          endAngle: 40,
          ranges: <GaugeRange>[
            GaugeRange(
                rangeOffset: 0,
                startValue: 0,
                endValue: 40,
                color: Colors.green,
                startWidth: 60,
                endWidth: 60),
            GaugeRange(
                startValue: 40,
                endValue: 80,
                color: Colors.orange,
                startWidth: 60,
                endWidth: 60),
            GaugeRange(
                startValue: 80,
                endValue: 120,
                color: Colors.red,
                startWidth: 60,
                endWidth: 60)
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: 30,
              tailStyle: TailStyle(width: 8, length: 0.08),
              lengthUnit: GaugeSizeUnit.factor,
              needleLength: 0.4,
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Text('90.0',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.3)
          ],
        )
      ],
    );
  }
}
