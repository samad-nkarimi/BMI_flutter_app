import 'package:BMI/screens/home_screen.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:BMI/utils/theme/prefs.dart';
import 'package:BMI/utils/theme/styling.dart';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './blocs/blocs.dart';

import './models/bmi_calc.dart';
import 'utils/size/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final Prefs prefs = Prefs();
  themetype theme = await prefs.getThemeType();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BmiCalcBloc(
            bmiCalcModel:
                BmiCalcModel(bmiValue: 26.1, age: 20, height: 175, weight: 80),
          ),
        ),
        BlocProvider(create: (context) => LanguageBloc()),
        BlocProvider(
          create: (context) => ThemeBloc(theme, prefs),
        ),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
        isToolbarVisible: true,
        data: DevicePreviewData(
          deviceIdentifier: Devices.android.largeTablet.toString(),
          isFrameVisible: true,

          // locale: 'fr_FR',
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orient) {
            SizeConfig().init(constraints, orient);
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                if (state is LanguageLoaded) {
                  var lang = state.locale.languageCode;
                  AppTheme.lang = lang;
                  return BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, themeState) {
                    return MaterialApp(
                      useInheritedMediaQuery: true,
                      // locale: DevicePreview.locale(context),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                          child: child,
                        );
                      },
                      theme: AppTheme.getTheme(themeState.theme).copyWith(
                        appBarTheme: Theme.of(context).appBarTheme.copyWith(
                              // backgroundColor: Colors.blue,
                              color: Colors.green,
                              systemOverlayStyle: SystemUiOverlayStyle(
                                statusBarColor: Colors.green,
                                systemStatusBarContrastEnforced: true,
                                statusBarBrightness: Brightness.light,
                              ),
                            ),
                      ),

                      debugShowCheckedModeBanner: false,
                      locale: state.locale,
                      //localization
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        // GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: [
                        Locale('en', 'US'), // English, no country code
                        Locale('fa', 'IR'), // Persian, no country code
                      ],

                      home: AnnotatedRegion<SystemUiOverlayStyle>(
                        value: SystemUiOverlayStyle(
                          statusBarColor: Colors.green,
                          statusBarBrightness: Brightness.light,
                          systemNavigationBarColor: Colors.green,
                          //
                          systemNavigationBarDividerColor: Colors.transparent,
                          systemNavigationBarIconBrightness: Brightness.light,
                        ),
                        child: MBIHome(),
                      ),
                    );
                  });
                }
                return SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }
}
