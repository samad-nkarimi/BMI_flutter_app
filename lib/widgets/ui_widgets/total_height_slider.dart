import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:BMI/widgets/third_part/slider_height_widget.dart';
import 'package:BMI/widgets/ui_widgets/mobile_height_label.dart';
import 'package:flutter/material.dart';

class TotalHeightSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          if (!SizeConfig.isMobilePortrait)
            Flexible(
              flex: 30,
              child: MobileHeightLabel(),
            ),
          Flexible(
            flex: 65,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.responsiveWidth(3.0, 2.0),
              ),
              child: SliderHeightWidget(

              ),
            ),
          ),
        ],
      );

  }
}
