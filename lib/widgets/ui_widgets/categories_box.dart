import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/blocs/overlay/overlay_bloc.dart';
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
        context.read<OverlayCubit>().setOverlayColor(currentCategory);
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.responsiveHeight(
              SizeConstants.mobileHorizontalPaddingFactorText,
              SizeConstants.tabletHorizontalPaddingFactorText,
            ),
            vertical: SizeConfig.responsiveHeight(1.0, 2.0),
          ),
          child: Column(
            children: [
              for (int i = 0; i < _weightCategories.length; i++)
                i != currentCategory
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(
                                "${_weightCategories[i]}",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              child: Text(
                                "${bmiModel.getPercentileCategories[i]}",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //       width: 1, color: Colors.green.shade200),
                        //   borderRadius: BorderRadius.circular(5),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${_weightCategories[i]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: bmiModel.getRangeColor),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              "${bmiModel.getPercentileCategories[i]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: bmiModel.getRangeColor),
                            ),
                          ],
                        ),
                      ),
            ],
          ),
        );
      },
    );
  }
}
