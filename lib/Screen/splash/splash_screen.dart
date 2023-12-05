import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Screen/navigation_screen/navigation_bar.dart';
import 'package:tailor/Screen/user_onboard/number_login_screen.dart';
import 'package:tailor/ui_helper.dart';

class Splash_Screen extends StatefulWidget {
  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  late MediaQueryData mq;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Navigation_Bar()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Number_login_Screen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColor.bgColorWhite,
      body: mq.orientation == Orientation.portrait
          ? _PortraitLay(context)
          : _LandscapeLay(context),
    );
  }

// ------------------------------------ //
  //   _PortraitLay  //

  Widget _PortraitLay(context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/banner/splash_bg.jpg"),
        )),
        child: Center(
          child: Image.asset("assets/images/logo/logo.png",
              width: mq.size.width * 0.7),
        ),
      );
    });
  }

// ------------------------------------ //
  //   _LandscapeLay  //

  Widget _LandscapeLay(context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        child: Center(
          child: Image.asset("assets/images/logo/logo.png",
              width: mq.size.width * 0.3),
        ),
      );
    });
  }
}
