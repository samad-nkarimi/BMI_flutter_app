import 'package:flutter/material.dart';
import 'package:mbi_app/screens/drawer_screen.dart';

class MBIHome extends StatefulWidget {
  MBIHome({Key key}) : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  Widget _scoreRow(String text, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            text2,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: MbiDrawer(),
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Container(
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
        body: Column(
          children: [
            Card(
              child: Text("Salam"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 2,
                // shape,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      _scoreRow(" very severely underweight", "=< 15.9"),
                      _scoreRow("severely underweight", "16.0 - 16.9"),
                      _scoreRow("underweight", "17.0 - 18.4"),
                      _scoreRow("normal", "18.5 - 24.9"),
                      _scoreRow("overweight", "25.0 - 29.9"),
                      _scoreRow("obese class|", "30.0 - 34.9"),
                      _scoreRow("obese class||", "35.0 - 39.9"),
                      _scoreRow("obese class|||", ">=40.0"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
