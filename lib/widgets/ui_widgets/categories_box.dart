import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/size_constants.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesBox extends StatefulWidget {
  @override
  _CategoriesBoxState createState() => _CategoriesBoxState();
}

class _CategoriesBoxState extends State<CategoriesBox> {
  @override
  Widget build(BuildContext context) {
    List<String> _weightCategories = [
      "${AppLocalizations.of(context).translate(TranslationConstants.underweight)}",
      "${AppLocalizations.of(context).translate(TranslationConstants.normal)}",
      "${AppLocalizations.of(context).translate(TranslationConstants.overweight)}",
      "${AppLocalizations.of(context).translate(TranslationConstants.obese)}"
    ];
    // print(_weightCategoryPercentiles.toString());

    return BlocBuilder<BmiCalcBloc, BmiCalcState>(
      builder: (context, state) {
        final bmiModel = BlocProvider.of<BmiCalcBloc>(context).bmiCalcModel;
        final currentCategory = bmiModel.getBmiValueCategory;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.responsiveHeight(
              SizeConstants.mobileHorizontalPaddingFactorText,
              SizeConstants.tabletHorizontalPaddingFactorText,
            ),
            vertical: SizeConfig.responsiveHeight(2.0, 2.0),
          ),
          child: Column(
            children: [
              for (int i = 0; i < _weightCategories.length; i++)
                i != currentCategory
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${_weightCategories[i]}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Expanded(child: Text("")),
                          Text(
                            "${bmiModel.getPercentileCategories[i]}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${_weightCategories[i]}",
                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: bmiModel.getRangeColor),
                          ),
                          Expanded(child: Text("")),
                          Text(
                            "${bmiModel.getPercentileCategories[i]}",
                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: bmiModel.getRangeColor),
                          ),
                        ],
                      ),
            ],
          ),
        );
      },
    );
  }
}
