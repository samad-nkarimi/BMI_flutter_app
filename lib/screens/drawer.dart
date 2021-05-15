import 'package:flutter/material.dart';

class MbiDrawer extends StatelessWidget {
  const MbiDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height,
      ),
      color: Colors.red,
      child: Drawer(
        child: IconButton(
          icon: Icon(Icons.ac_unit_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
