import 'package:BMI/screens/home_screen.dart';
import 'package:BMI/utils/app_localizations.dart';
import 'package:BMI/utils/styling.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './blocs/blocs.dart';
import './blocs/bmi_calc/bmi_calc_bloc.dart';
import './blocs/simple_bloc_observer.dart';
import './models/bmi_calc.dart';
import './utils/size_config.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerItemsBloc()),
        BlocProvider(
          create: (context) => BmiCalcBloc(
            bmiCalcModel: BmiCalcModel(bmiValue: 26.1, age: 25, height: 150, weight: 120),
          ),
        ),
        BlocProvider(create: (context) => LanguageBloc()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orient) {
            SizeConfig().init(constraints, orient);
            return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
              if (state is LanguageLoaded) {
                print("${state.locale} ****************************************");
                var lang = state.locale.languageCode;
                return MaterialApp(
                  title: 'MBI Calc',
                  theme: AppTheme.lightTheme,
                  debugShowCheckedModeBanner: false,
                  locale:state.locale,
                  //localization
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    // GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    Locale('en', 'US'), // English, no country code
                    Locale('fa', 'IR'), // Spanish, no country code
                  ],
                  // localeResolutionCallback: (locale, supportedLocales) {
                  //   for (var supportedLocaleLanguage in supportedLocales) {
                  //     if (supportedLocaleLanguage.languageCode == locale.languageCode &&
                  //         supportedLocaleLanguage.countryCode == locale.countryCode) {
                  //       return supportedLocaleLanguage;
                  //     }
                  //   }
                  //   return supportedLocales.first;
                  // },
                  home: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,

                      // systemNavigationBarColor: Color(0xff75C28C),
                      // systemNavigationBarDividerColor: Colors.transparent,
                      // systemNavigationBarIconBrightness: Brightness.light,
                    ),
                    child: MBIHome(),
                  ),
                );
              }
              return SizedBox.shrink();
            });
          });
        },
      ),
    );
  }
}
