import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbi_app/blocs/bmi_calc/bmi_calc_bloc.dart';
import 'package:mbi_app/models/bmi_calc.dart';
import 'package:mbi_app/utils/app_theme.dart';
import 'package:mbi_app/blocs/blocs.dart';
import 'package:mbi_app/blocs/simple_bloc_observer.dart';
import 'package:mbi_app/screens/home_screen.dart';
import 'package:mbi_app/utils/size_config.dart';
import 'package:mbi_app/utils/styling.dart';

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
            create: (context) => BmiCalcBloc(bmiCalcModel: BmiCalcModel())),
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
                  statusBarColor: Colors.green,
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
