import 'dart:ui';

import 'package:BMI/blocs/blocs.dart';
import 'package:BMI/utils/constants/translation_constants.dart';
import 'package:BMI/utils/localization/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../utils/constants/constants.dart';
import '../utils/constants/images.dart';
import '../utils/size/size_config.dart';

class MbiDrawer extends StatefulWidget {
  MbiDrawer({Key key}) : super(key: key);

  @override
  _MbiDrawerState createState() => _MbiDrawerState();
}

class _MbiDrawerState extends State<MbiDrawer> {
  bool _showAboutUs = false;
  final double _topMenuSizeFraction = 0.35;

  final Email email = Email(
    body: Constants.EMAIL_BODY,
    subject: Constants.EMAIL_SUBJECT,
    recipients: Constants.EMAIL_RECIP,
    // cc: ["samad.nkarimi@gmail.com"],
    // bcc: ["samad.nkarimi@gmail.com"],
    // attachmentPaths: null,
    isHTML: false,
  );

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
            height: SizeConfig.responsiveHeight(7.0, 8.0),
            child: Text(title, style: Theme.of(context).textTheme.subtitle2),
          ),
        ],
      ),
      onTap: func,
    );
  }

  Widget _drawerTopSection() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
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
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: SizeConfig.responsiveHeight(2.0, 2.0),
            left: SizeConfig.responsiveHeight(2.0, 3.0),
            child: Container(
              child: IconButton(
                iconSize: SizeConfig.responsiveWidth(8.0, 8.0),
                icon: SvgPicture.asset(
                  "assets/images/back_icon.svg",
                  width: SizeConfig.responsiveWidth(8.0, 8.0),
                  height: SizeConfig.responsiveWidth(8.0, 8.0),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            int initialIndex = 0;
            if (state.theme == themetype.light) {
              initialIndex = 1;
            }

            return Positioned(
              bottom: SizeConfig.responsiveHeight(2.0, 2.0),
              // left: SizeConfig.responsiveHeight(2.0, 3.0),

              child: ToggleSwitch(
                minWidth: 70.0,
                minHeight: 50.0,
                initialLabelIndex: initialIndex,
                cornerRadius: 20.0,
                activeFgColor: Colors.orange,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                icons: [
                  Icons.mode_night_rounded,
                  Icons.sunny,
                ],
                iconSize: 30.0,
                activeBgColors: [
                  [Colors.black87],
                  [Colors.yellow]
                ],
                animate:
                    true, // with just animate set to true, default curve = Curves.easeIn
                curve: Curves
                    .bounceInOut, // animate must be set to true when using custom curve
                onToggle: (index) {
                  Future.delayed(Duration.zero, () {
                    BlocProvider.of<ThemeBloc>(context).add(ThemeChangedEvent(
                        index == 1 ? themetype.light : themetype.dark));
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _aboutUsSection() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.responsiveWidth(5, 7.0)),
      // color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Text(
                  "${AppLocalizations.of(context).translate(TranslationConstants.about_us)}",
                  style: Theme.of(context).textTheme.subtitle2),
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
            margin: EdgeInsets.all(SizeConfig.responsiveHeight(8.0, 8.0)),
            width: SizeConfig.responsiveHeight(22.0, 20.0),
            height: SizeConfig.responsiveHeight(7.0, 10.0),
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
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: SizeConfig.responsiveHeight(1.75, 2.0),
          ),
          drawerItem(
              "${AppLocalizations.of(context).translate(TranslationConstants.help_and_feedback)}",
              () => FlutterEmailSender.send(email)),
          drawerItem(
              "${AppLocalizations.of(context).translate(TranslationConstants.share_app)}",
              () => Share.share(Constants.APP_LINK)),
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
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: Theme.of(context).colorScheme.surface,
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
            Container(
              height: 0.5,
              width: double.infinity,
              color: Theme.of(context).colorScheme.onPrimary,
              // child: Divider(color: Colors.black45),
            ),
            // SizedBox(height: resHeight(1.4, 1.5)),
            if (_showAboutUs) Expanded(child: _aboutUsSection()),
            if (!_showAboutUs) Expanded(child: _drawerBottomSection()),
          ],
        ),
      ),
    );
  }
}
