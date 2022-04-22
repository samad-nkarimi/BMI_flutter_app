import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:BMI/widgets/third_part/slider_height_widget.dart';
import 'package:BMI/widgets/third_part/slider_weight_widget.dart';
import 'package:BMI/widgets/ui_widgets/mobile_height_label.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/size_constants.dart';
import 'mobile_weight_label.dart';

enum heightorweight { height, weight }

class TotalHeightOrWeightSlider extends StatelessWidget {
  final heightorweight type;
  TotalHeightOrWeightSlider(this.type) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.isMobilePortrait
            ? 0.1
            : SizeConfig.responsiveHeight(
                SizeConstants.mobileHorizontalPaddingFactorText,
                SizeConstants.tabletHorizontalPaddingFactorText,
              ),
      ),
      child: Row(
        children: [
          if (!SizeConfig.isMobilePortrait)
            Flexible(
              flex: 50,
              child: Container(
                // color: Colors.blue.shade100,
                child: type == heightorweight.height
                    ? MobileHeightLabel()
                    : MobileWeightLabel(),
              ),
            ),
          Flexible(
            flex: 65,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.responsiveWidth(3.0, 1.0),
                // right: SizeConfig.responsiveHeight(
                //   SizeConstants.mobileHorizontalPaddingFactorText,
                //   SizeConstants.tabletHorizontalPaddingFactorText,
                // ),
              ),
              child: type == heightorweight.height
                  ? SliderHeightWidget()
                  : SliderWeightWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
