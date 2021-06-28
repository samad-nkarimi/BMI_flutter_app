import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbi_app/blocs/blocs.dart';

import 'custom_slider_thumb_circle.dart';

class SliderHeightWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;

  SliderHeightWidget({
    this.sliderHeight = 48,
    this.max = 220,
    this.min = 20,
    this.fullWidth = true,
  });

  @override
  _SliderHeightWidgetState createState() => _SliderHeightWidgetState();
}

class _SliderHeightWidgetState extends State<SliderHeightWidget> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .1;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF00c6ff),
              const Color(0xFF00ffaa),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                '${this.widget.min}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: this.widget.sliderHeight * .3,
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
                    trackHeight: 10.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
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
                      _value = bmiModel.height;
                      print(
                          "$_value *******************************************");
                      return Slider(
                        value:
                            (_value - widget.min) / (widget.max - widget.min),
                        label: '${(_value).toStringAsFixed(1)}',
                        divisions: (widget.max - widget.min) * 2,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });

                          bmiModel.height =
                              widget.min + value * (widget.max - widget.min);
                          BlocProvider.of<BmiCalcBloc>(context)
                              .add(DataInputChanged(bmiModel));
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .05,
            ),
            Text(
              '${this.widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
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
