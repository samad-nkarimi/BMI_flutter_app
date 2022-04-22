import 'dart:math' as math;

import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/localization/language_entity.dart';
import 'package:BMI/utils/localization/languages.dart';
import 'package:BMI/utils/size/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomizedAppBar extends StatelessWidget {
  CustomizedAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang;
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is LanguageLoaded) lang = state.locale.languageCode;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.7),
                Colors.orange.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.responsiveWidth(3.0, 3.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => Container(
                  // padding: const EdgeInsets.all(10.0),
                  // margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Container(
                    // width: SizeConfig.responsiveWidth(12.0, 16.0),
                    // height: SizeConfig.responsiveWidth(12.0, 16.0),
                    child: IconButton(
                      iconSize: SizeConfig.responsiveWidth(8.0, 8.0),
                      icon: Transform(
                        alignment: Alignment.center,
                        transform: lang == 'fa'
                            ? Matrix4.rotationY(math.pi)
                            : Matrix4.rotationY(0),
                        child: SvgPicture.asset(
                          "assets/images/menu_icon.svg",
                          width: SizeConfig.responsiveWidth(8.0, 8.0),
                          height: SizeConfig.responsiveWidth(8.0, 8.0),
                        ),
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ),
              Container(
                // color: Colors.black12,
                // width: resWidth(50.0, 40.0),
                // height: resHeight(20.0, 15.0),
                child:
                    // SvgPicture.asset("assets/images/bmi_name.svg"),
                    DropdownButton<LanguageEntity>(
                  items: Languages.languages
                      .map<DropdownMenuItem<LanguageEntity>>(
                        (e) => DropdownMenuItem<LanguageEntity>(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(e.value),
                                Image.asset(
                                  e.flag,
                                  height: SizeConfig.responsiveHeight(5.0, 6.0),
                                  width: SizeConfig.responsiveHeight(5.0, 6.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  underline: SizedBox(),
                  icon: Image.asset(
                    lang == 'en'
                        ? "assets/images/flag_english.png"
                        : "assets/images/flag_persian.png",
                    width: SizeConfig.responsiveHeight(5.0, 6.0),
                    height: SizeConfig.responsiveHeight(5.0, 6.0),
                  ),
                  onChanged: (index) {
                    // index is LanguageEntity
                    BlocProvider.of<LanguageBloc>(context).add(
                      ToggleLanguageEvent(index),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
