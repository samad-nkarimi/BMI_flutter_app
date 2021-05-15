import 'package:flutter/material.dart';

class MBIHome extends StatefulWidget {
  MBIHome({Key key}) : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("MBICalc"),
        ),
        body: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
