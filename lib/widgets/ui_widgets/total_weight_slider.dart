
import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:BMI/widgets/third_part/slider_weight_widget.dart';
import 'package:BMI/widgets/ui_widgets/mobile_weight_label.dart';
import 'package:flutter/material.dart';

class TotalWeightSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return Row(
        children: [
          if (!SizeConfig.isMobilePortrait)
            Flexible(
              flex: 30,
              child:MobileWeightLabel(),
            ),
          Flexible(
            flex: 65,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.responsiveWidth(3.0, 2.0),
              ),
              child: SliderWeightWidget(
                sliderHeight: SizeConfig.responsiveHeight(5.0, 10.0),
                min: CalculationConstants.min_weight,
                max: CalculationConstants.max_weight,
              ),
            ),
          ),
        ],
      );
    }

}
