import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tailor/Screen/user_onboard/First_Dashboard.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
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

    Timer(Duration(seconds: 2), () {
      if (currentUser == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => First_Dashboard()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.bgColorWhite,
      body: mq.orientation == Orientation.portrait ? _PortraitLay(context) : _LandscapeLay(context),
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
          child: Image.asset("assets/images/logo/logo.png", width: mq.size.width * 0.6),
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
          child: Image.asset("assets/images/logo/logo.png", width: mq.size.width * 0.3),
        ),
      );
    });
  }
}
