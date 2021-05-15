import 'package:flutter/material.dart';
import 'package:mbi_app/mbi_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBI Calc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MBIHome(),
    );
  }
}
