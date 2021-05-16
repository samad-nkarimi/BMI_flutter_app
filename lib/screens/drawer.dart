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
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.all(50),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Image.asset("assets/icons/back.png"),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ]),
            Divider(color: Colors.black),
            SizedBox(height: 30),
            Text("Help&Feedback", style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 15),
            Text("Share App", style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 15),
            Text("More Apps", style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 15),
            Text("About Us", style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 40),
            Container(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Stack(alignment: Alignment.center, children: [
                  Image.asset("assets/images/back_btn.png"),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/icons/back.png",
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
