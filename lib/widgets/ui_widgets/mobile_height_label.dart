import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/size_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:BMI/widgets/ui_widgets/utils/height_data_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileHeightLabel extends StatefulWidget {
  @override
  _MobileHeightLabelState createState() => _MobileHeightLabelState();
}

class _MobileHeightLabelState extends State<MobileHeightLabel> {
  double currentHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.responsiveHeight(
          SizeConstants.mobileHorizontalPaddingFactorText,
          SizeConstants.tabletHorizontalPaddingFactorText,
        ),
        // vertical: SizeConfig.responsiveHeight(.7, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              "${AppLocalizations.of(context).translate(TranslationConstants.height)} (${TranslationConstants.height_unit}): ",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          //*********** decimalNumberPicker segment  ************/
          InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              return showDialog(
                context: context,
                builder: (ctx) {
                  return HeightDataPicker();
                },
              ).then((value) {
                setState(() {
                  currentHeight = value;
                });
              });
            },
            child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
              builder: (context, state) {
                final bmiModel =
                    BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                currentHeight = bmiModel.height;
                if (state is HeightChanged) currentHeight = state.height;
                // print("BMI: ${(state as BmiCalculating).value}");

                return Container(
                  height: SizeConfig.responsiveHeight(5.0, 8.0),
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
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: Text(
                    "${currentHeight.toStringAsFixed(1)}",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
