import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbi_app/blocs/blocs.dart';
import 'package:mbi_app/models/drawer_item.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mbi_app/utils/constants.dart';
import 'package:mbi_app/utils/images.dart';
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

  Widget _drawerTopSection() {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(50),
        child: Image.asset(
          Images.LOGO_IMAGE,
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
    ]);
  }

  Widget _aboutUsSection() {
    return Column(
      children: [
        Text("About Us", style: Theme.of(context).textTheme.headline5),
        SizedBox(height: 15),
        Text(
          Constants.ABOUT_US_BODY,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Container(
          child: InkWell(
            onTap: () => setState(() {
              _showAboutUs = !_showAboutUs;
            }),
            child: Stack(alignment: Alignment.center, children: [
              Image.asset("assets/images/back_btn.png"),
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
        InkWell(
          child: Text("Help&Feedback",
              style: Theme.of(context).textTheme.headline5),
          onTap: () => FlutterEmailSender.send(email),
          // onLongPress: ,
        ),
        SizedBox(height: 15),
        InkWell(
          child:
              Text("Share App", style: Theme.of(context).textTheme.headline5),
          onTap: () => Share.share(Constants.APP_LINK),
        ),
        SizedBox(height: 15),
        InkWell(
          child:
              Text("More Apps", style: Theme.of(context).textTheme.headline5),
          onTap: () => StoreRedirect.redirect(
            androidAppId: Constants.STORE_ANDROID_APP_ID,
            iOSAppId: Constants.STORE_IOS_APP_ID,
          ),
        ),
        SizedBox(height: 15),
        InkWell(
            child:
                Text("About Us", style: Theme.of(context).textTheme.headline5),
            onTap: () => setState(() {
                  _showAboutUs = !_showAboutUs;
                })),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerItemsBloc, DrawerItem>(
        builder: (context, drawerItem) {
      return Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: Colors.red,
        child: Drawer(
          child: Column(
            children: [
              _drawerTopSection(),
              Divider(color: Colors.black),
              SizedBox(height: 15),
              if (_showAboutUs) _aboutUsSection(),
              if (!_showAboutUs) _drawerBottomSection(),
            ],
          ),
        ),
      );
    });
  }
}
