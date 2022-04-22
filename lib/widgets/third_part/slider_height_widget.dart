import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class SliderHeightWidget extends StatefulWidget {
  final fullWidth;

  SliderHeightWidget({
    this.fullWidth = true,
  });

  @override
  _SliderHeightWidgetState createState() => _SliderHeightWidgetState();
}

class _SliderHeightWidgetState extends State<SliderHeightWidget> {
  double _value = 0.0;
  double _height = 150.0;
  final double sliderHeight = SizeConfig.responsiveHeight(5.0, 10.0);

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .1;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth ? double.infinity : sliderHeight * 5.5,
      height: SizeConfig.responsiveHeight(5.0, 10.0),
      decoration: new BoxDecoration(
        // color: Colors.black26,
        borderRadius: new BorderRadius.all(
          Radius.circular((sliderHeight * .15)),
        ),
        gradient: new LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.3),
            Colors.orange.withOpacity(0.7),
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
                '${CalculationConstants.min_height}',
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
                    thumbColor: Colors.blue,
                    // thumbShape: SliderComponentShape.noThumb,
                    // CustomSliderThumbCircle(
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
                      _height = bmiModel.height;
                      // _value = bmiModel.height;
                      // print(
                      //     "$_value *******************************************");
                      if (state is HeightChanged) _height = state.height;
                      return Slider(
                        value: (_height - CalculationConstants.min_height) /
                            (CalculationConstants.max_height -
                                CalculationConstants.min_height),
                        // label: '${(_height).toStringAsFixed(1)}',
                        divisions: (CalculationConstants.max_height -
                                CalculationConstants.min_height) *
                            2,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });

                          _height = CalculationConstants.min_height +
                              value *
                                  (CalculationConstants.max_height -
                                      CalculationConstants.min_height);
                          BlocProvider.of<BmiCalcBloc>(context)
                              .add(HeightHasBeenSet(_height));
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
              '${CalculationConstants.max_height}',
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
