import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './blocs/bmi_calc/bmi_calc_bloc.dart';
import './models/bmi_calc.dart';
import './utils/app_theme.dart';
import './blocs/blocs.dart';
import './blocs/simple_bloc_observer.dart';
import './screens/home_screen.dart';
import './utils/size_config.dart';
import './utils/styling.dart';

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
                bmiCalcModel: BmiCalcModel(
                    bmiValue: 26.1, age: 25, height: 150, weight: 120))),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orient) {
            SizeConfig().init(constraints, orient);
            return MaterialApp(
              title: 'MBI Calc',
              theme: AppTheme.lightTheme,
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
          });
        },
      ),
    );
  }
}
