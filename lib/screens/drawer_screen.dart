import 'dart:ui';

import 'package:BMI/utils/app_localizations.dart';
import 'package:BMI/utils/translation_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';

import '../utils/constants.dart';
import '../utils/images.dart';
import '../utils/size_config.dart';

class MbiDrawer extends StatefulWidget {
  MbiDrawer({Key key}) : super(key: key);

  @override
  _MbiDrawerState createState() => _MbiDrawerState();
}

class _MbiDrawerState extends State<MbiDrawer> {
  bool _showAboutUs = false;
  final double _topMenuSizeFraction = 0.3;

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
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) * SizeConfig.heightMultiplier;
  }

  double resWidth(mobileRes, tabletRes) {
    return (SizeConfig.isMobilePortrait ? mobileRes : tabletRes) * SizeConfig.widthMultiplier;
  }

  Widget drawerItem(String title, Function func) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            // color: Colors.red,
            height: resHeight(7.0, 8.0),
            child: Text(title, style: Theme.of(context).textTheme.subtitle2),
          ),
        ],
      ),
      onTap: func,
    );
  }

  Widget _drawerTopSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
        ),
        Container(
          height: MediaQuery.of(context).size.height * _topMenuSizeFraction,
          padding: EdgeInsets.all(50),
          child: Image.asset(
            Images.LOGO_IMAGE,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: resHeight(2.0, 4.0),
          left: resHeight(2.0, 6.0),
          child: Container(
            width: resWidth(12.0, 8.0),
            height: resWidth(12.0, 8.0),
            child: IconButton(
              icon: SvgPicture.asset("assets/images/back_icon.svg"),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _aboutUsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: resWidth(5, 7.0)),
      // color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text("${AppLocalizations.of(context).translate(TranslationConstants.about_us)}", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: 15),
              Text(
                // Constants.ABOUT_US_BODY,
                "${AppLocalizations.of(context).translate(TranslationConstants.about_us_description)}",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            // color: Colors.yellow,

            // alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(resHeight(8.0, 8.0)),
            width: resWidth(22.0, 20.0),
            height: resHeight(7.0, 10.0),
            child: ElevatedButton(
              onPressed: () => setState(() {
                _showAboutUs = !_showAboutUs;
              }),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF75C28C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "${AppLocalizations.of(context).translate(TranslationConstants.ok)}",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // GestureDetector(
  //   onTap: () => setState(() {
  //     _showAboutUs = !_showAboutUs;
  //   }),
  //   child: Stack(alignment: Alignment.center, children: [
  //     Image.asset(
  //       "assets/images/back_btn.png",
  //       width: resWidth(30.0, 20.0),
  //       height: resWidth(15.0, 10.0),
  //       fit: BoxFit.fill,
  //     ),
  //     Padding(
  //       padding: const EdgeInsets.only(bottom: 8),
  //       child: Text(
  //         "${AppLocalizations.of(context).translate(TranslationConstants.ok)}",
  //         style: TextStyle(color: Colors.white, fontSize: 18),
  //       ),
  //     ),
  //   ]),
  // ),

  Widget _drawerBottomSection() {
    return Container(
      // color: Colors.yellow,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          drawerItem("${AppLocalizations.of(context).translate(TranslationConstants.help_and_feedback)}", () => FlutterEmailSender.send(email)),
          drawerItem("${AppLocalizations.of(context).translate(TranslationConstants.share_app)}", () => Share.share(Constants.APP_LINK)),
          drawerItem(
            "${AppLocalizations.of(context).translate(TranslationConstants.more_apps)}",
            () => StoreRedirect.redirect(
              androidAppId: Constants.STORE_ANDROID_APP_ID,
              iOSAppId: Constants.STORE_IOS_APP_ID,
            ),
          ),
          drawerItem(
            "${AppLocalizations.of(context).translate(TranslationConstants.about_us)}",
            () => setState(
              () {
                _showAboutUs = !_showAboutUs;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("drawer reloaded   ***********************************");
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // constraints: BoxConstraints(
      //   minWidth: screenWidth,
      //   minHeight: screenHeight,
      // ),
      // color: Colors.red,
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _drawerTopSection(),
            Divider(color: Colors.black45),
            // SizedBox(height: resHeight(1.4, 1.5)),
            if (_showAboutUs) Expanded(child: _aboutUsSection()),
            if (!_showAboutUs) Expanded(child: _drawerBottomSection()),
          ],
        ),
      ),
    );
  }
}
