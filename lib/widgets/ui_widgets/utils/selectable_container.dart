import 'package:flutter/material.dart';

import '../../../utils/constants/size_constants.dart';
import '../../../utils/size/size_config.dart';

class SelectableContainer extends StatelessWidget {
  final Widget child;
  const SelectableContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConstants.sliderHeight,
      constraints: BoxConstraints(
        minWidth: SizeConfig.responsiveWidth(
            SizeConstants.mobileSelectableItemsBackgroundWidth,
            SizeConstants.tabletSelectableItemsBackgroundWidth),
      ),
      // width: SizeConfig.responsiveWidth(
      //   SizeConstants.mobileSelectableItemsBackgroundWidth,
      //   SizeConstants.tabletSelectableItemsBackgroundWidth,
      // ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(SizeConstants.sliderHeight * .15),
        color: Colors.black.withOpacity(0.08),
      ),
      child: child,
    );
  }
}
