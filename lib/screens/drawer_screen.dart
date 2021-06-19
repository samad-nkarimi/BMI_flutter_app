import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbi_app/blocs/blocs.dart';
import 'package:mbi_app/models/drawer_item.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mbi_app/utils/constants.dart';
import 'package:mbi_app/utils/images.dart';
import 'package:mbi_app/utils/size_config.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';

class MbiDrawer extends StatefulWidget {
  MbiDrawer({Key key}) : super(key: key);

  @override
  _MbiDrawerState createState() => _MbiDrawerState();
}

class _MbiDrawerState extends State<MbiDrawer> {
  bool _showAboutUs = false;

  final Email email = Email(
    body: Constants.EMAIL_BODY,
    subject: Constants.EMAIL_SUBJECT,
    recipients: Constants.EMAIL_RECIP,
    // cc: ["samad.nkarimi@gmail.com"],
    // bcc: ["samad.nkarimi@gmail.com"],
    // attachmentPaths: null,
    isHTML: false,
  );

  double resHeight(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.heightMultiplier;
  }

  double resWidth(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) *
        SizeConfig.widthMultiplier;
  }

  Widget drawerItem(String title, Function func) {
    return InkWell(
      child: Text(title, style: Theme.of(context).textTheme.subtitle2),
      onTap: func,
    );
  }

  Widget _drawerTopSection() {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: double.infinity,
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(50),
        child: Image.asset(
          Images.LOGO_IMAGE,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: resHeight(8.0, 4.0),
        left: resHeight(8.0, 6.0),
        child: Container(
          width: resWidth(12.0, 8.0),
          height: resWidth(12.0, 8.0),
          child: IconButton(
            icon: Image.asset(
              "assets/icons/back.png",
              fit: BoxFit.fill,
              width: resWidth(12.0, 8.0),
              height: resWidth(12.0, 8.0),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    ]);
  }

  Widget _aboutUsSection() {
    return Column(
      children: [
        Text("About Us", style: Theme.of(context).textTheme.subtitle2),
        SizedBox(height: 15),
        Text(
          Constants.ABOUT_US_BODY,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Container(
          width: resWidth(30.0, 20.0),
          height: resWidth(15.0, 10.0),
          child: InkWell(
            onTap: () => setState(() {
              _showAboutUs = !_showAboutUs;
            }),
            child: Stack(alignment: Alignment.center, children: [
              Image.asset(
                "assets/images/back_btn.png",
                width: resWidth(30.0, 20.0),
                height: resWidth(15.0, 10.0),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _drawerBottomSection() {
    return Column(
      children: [
        drawerItem("Help&Feedback", () => FlutterEmailSender.send(email)),
        SizedBox(height: resHeight(1.0, 3.0)),
        drawerItem("Share App", () => Share.share(Constants.APP_LINK)),
        SizedBox(height: resHeight(1.0, 3.0)),
        drawerItem(
            "More Apps",
            () => StoreRedirect.redirect(
                  androidAppId: Constants.STORE_ANDROID_APP_ID,
                  iOSAppId: Constants.STORE_IOS_APP_ID,
                )),
        SizedBox(height: resHeight(1.0, 3.0)),
        drawerItem(
          "About Us",
          () => setState(() {
            _showAboutUs = !_showAboutUs;
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<DrawerItemsBloc, DrawerItem>(
        builder: (context, drawerItem) {
      return Container(
        constraints: BoxConstraints(
          minWidth: screenWidth,
          minHeight: screenHeight,
        ),
        color: Colors.red,
        child: Drawer(
          child: Column(
            children: [
              _drawerTopSection(),
              Divider(color: Colors.black45),
              SizedBox(height: resHeight(1.4, 1.5)),
              if (_showAboutUs) _aboutUsSection(),
              if (!_showAboutUs) _drawerBottomSection(),
            ],
          ),
        ),
      );
    });
  }
}
