import 'package:flutter/material.dart';
import 'package:mbi_app/screens/drawer.dart';

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
        drawer: MbiDrawer(),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: -160,
                right: -60,
                child: Container(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 2.0),
                  child: Image.asset(
                    "assets/images/ellipse.png",
                    scale: .85,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 50,
                child: Text(
                  "MBICalc",
                  style: TextStyle(fontSize: 25, fontFamily: "ANasr"),
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                child: Builder(
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      iconSize: 50,
                      icon: Image.asset("assets/icons/menu.png"),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
