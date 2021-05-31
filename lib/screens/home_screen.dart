import 'package:flutter/material.dart';
import 'package:mbi_app/screens/drawer_screen.dart';
import '../widgets/custom_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/radial_gauge.dart';

class MBIHome extends StatefulWidget {
  MBIHome({Key key}) : super(key: key);

  @override
  _MBIHomeState createState() => _MBIHomeState();
}

class _MBIHomeState extends State<MBIHome> {
  String _selectedWeightUnit = "kg";
  String _selectedHeightUnit = "ft";
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
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        // constraints: BoxConstraints(
                        //     minWidth: MediaQuery.of(context).size.width / 2.0),
                        child: SvgPicture.asset("assets/images/top_shape.svg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "MBICalc",
                          style: TextStyle(fontSize: 25, fontFamily: "ANasr"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height * .4,
                  child: RadialGauge()),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    // side: BorderSide(width: 5, color: Colors.green),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 12,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("weight"),
                                ),
                              ),
                              Expanded(
                                child: SliderWidget(),
                                flex: 40,
                              ),
                              Flexible(
                                flex: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new DropdownButton<String>(
                                    value: _selectedWeightUnit,
                                    items: <String>["kg", "lb"].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedWeightUnit = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                flex: 12,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("height"),
                                ),
                              ),
                              Expanded(
                                child: SliderWidget(),
                                flex: 40,
                              ),
                              Flexible(
                                flex: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DropdownButton<String>(
                                    value: _selectedHeightUnit,
                                    items: <String>["ft", "cm"].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedHeightUnit = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("age"),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: Colors.blue, width: 3),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("-20"),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0x0075C28C)),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.black),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: Colors.blue, width: 3),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("+20"),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/woman.svg",
                                  color: Colors.red,
                                ),
                                VerticalDivider(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                SvgPicture.asset("assets/images/man.svg"),
                              ],
                            ),
                          ],
                        ),

                        // _scoreRow(" very severely underweight", "=< 15.9"),
                        // _scoreRow("severely underweight", "16.0 - 16.9"),
                        // _scoreRow("underweight", "17.0 - 18.4"),
                        // _scoreRow("normal", "18.5 - 24.9"),
                        // _scoreRow("overweight", "25.0 - 29.9"),
                        // _scoreRow("obese class|", "30.0 - 34.9"),
                        // _scoreRow("obese class||", "35.0 - 39.9"),
                        // _scoreRow("obese class|||", ">=40.0"),
                      ],
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
