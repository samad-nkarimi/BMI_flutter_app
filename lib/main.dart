import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbi_app/utils/app_theme.dart';
import 'package:mbi_app/blocs/blocs.dart';
import 'package:mbi_app/blocs/simple_bloc_observer.dart';
import 'package:mbi_app/screens/home_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => DrawerItemsBloc())],
      child: MaterialApp(
        title: 'MBI Calc',
        theme: appTheme,
        home: MBIHome(),
      ),
    );
  }
}
