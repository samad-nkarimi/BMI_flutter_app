import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/calculation_constants.dart';
import 'package:BMI/utils/constants/size_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:BMI/widgets/ui_widgets/utils/selectable_container.dart';
import 'package:BMI/widgets/ui_widgets/utils/weight_data_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileWeightLabel extends StatefulWidget {
  @override
  _MobileWeightLabelState createState() => _MobileWeightLabelState();
}

class _MobileWeightLabelState extends State<MobileWeightLabel> {
  double currentWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.isMobilePortrait
            ? SizeConfig.responsiveHeight(
                SizeConstants.mobileHorizontalPaddingFactorText,
                SizeConstants.tabletHorizontalPaddingFactorText,
              )
            : 0.1,
        // vertical: SizeConfig.responsiveHeight(.7, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${AppLocalizations.of(context).translate(TranslationConstants.weight)} (${TranslationConstants.weight_unit}): ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          //*********** decimalNumberPicker segment  ************/

          InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              return showDialog(
                context: context,
                builder: (ctx) {
                  return WeightDataPicker(CalculationConstants.min_weight,
                      CalculationConstants.max_weight);
                },
              ).then((value) {
                setState(() {
                  currentWeight = value;
                });
              });
            },
            child: BlocBuilder<BmiCalcBloc, BmiCalcState>(
              builder: (context, state) {
                final bmiModel =
                    BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
                currentWeight = bmiModel.weight;
                return SelectableContainer(
                  child: Text(
                    "${currentWeight.toStringAsFixed(1)}",
                    style: Theme.of(context).textTheme.bodyText1,
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
