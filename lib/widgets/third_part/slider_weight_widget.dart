import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class SliderWeightWidget extends StatefulWidget {
  final fullWidth;

  SliderWeightWidget({
    this.fullWidth = true,
  });

  @override
  _SliderWeightWidgetState createState() => _SliderWeightWidgetState();
}

class _SliderWeightWidgetState extends State<SliderWeightWidget> {
  // double _value = 0.0;
  double _weight = 50;
  final double sliderHeight = SizeConfig.responsiveHeight(5.0, 10.0);
  final int min = CalculationConstants.min_weight;
  final int max = CalculationConstants.max_weight;

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .1;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth ? double.infinity : sliderHeight * 5.5,
      height: SizeConfig.responsiveHeight(5.0, 10.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((sliderHeight * .15)),
        ),
        gradient: new LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.3),
            Colors.orange.withOpacity(0.7),
            // const Color(0xaa00c6ff),
            // const Color(0xFF00ddaa),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.00),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            sliderHeight * paddingFactor, 2, sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                '$min',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sliderHeight * .3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(
            //   width: this.widget.sliderHeight * .1,
            // ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),
                    trackHeight: 6.0,
                    // thumbShape: CustomSliderThumbCircle(
                    //   thumbRadius: this.widget.sliderHeight * .4,
                    //   min: this.widget.min,
                    //   max: this.widget.max,
                    // ),
                    // overlayShape: CustomSliderThumbCircle(
                    //   thumbRadius: this.widget.sliderHeight * .3,
                    //   min: this.widget.min,
                    //   max: this.widget.max,
                    // ),
                    overlayColor: Colors.white.withOpacity(.4),
                    // thumbColor: Colors.black,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.blueAccent,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
                    builder: (context, state) {
                      final bmiModel =
                          BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                      _weight = bmiModel.weight;
                      // if (state is WeightChanged) _weight = state.weight;
                      // print(
                      //     "$_weight vvvvvv**********************************************************");
                      if (state is WeightChanged) _weight = state.weight;
                      return Slider(
                        value: (_weight - min) / (max - min),
                        // label: '${(_weight).toStringAsFixed(1)}',
                        divisions: (max - min) * 2,
                        onChanged: (value) {
                          // setState(() {
                          //   _value = value;
                          // });

                          _weight = min + value * (max - min);

                          BlocProvider.of<BmiCalcBloc>(context)
                              .add(WeightHasBeenSet(_weight));
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: sliderHeight * .05,
            ),
            Text(
              '$max',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
