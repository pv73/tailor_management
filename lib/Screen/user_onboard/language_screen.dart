import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/aadhar_into_screen.dart';

import '../../ui_helper.dart';

class Language_Screen extends StatefulWidget {
  @override
  State<Language_Screen> createState() => _Language_ScreenState();
}

class _Language_ScreenState extends State<Language_Screen> {
  void Function()? onPress;

  String? UserId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Function to retrieve the UserId from shared preferences
  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserId = prefs.getString('UserId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/banner/splash_bg.jpg"))),
          child: Column(
            children: [
              // =========================
              //       Language Text
              // =========================
              heightSpacer(),
              Text(
                "Choose Language",
                style: mTextStyle22(mFontWeight: FontWeight.w600),
              ),
              heightSpacer(),
              Text("Welcome to Tailor Management"),
              heightSpacer(mHeight: 20),

              // =========================
              //       Language Box
              // =========================

              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: language_option(
                          onPress: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Center(
                                  child: Text(
                                      "This page is not available in Hindi right now"),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                          title: "अ",
                          subtitle: "Hindi"),
                    ),
                    widthSpacer(),
                    Expanded(
                      child: language_option(
                          onPress: () async {
                            var language = {'language': "English"};

                            FirebaseFirestore.instance
                                .collection('clients')
                                .doc(UserId)
                                .update(language);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Aadhar_Card_Screen(),
                              ),
                            );
                          },
                          title: "A",
                          subtitle: "English"),
                    ),
                    widthSpacer(),
                    Expanded(
                      child: language_option(
                          onPress: () {
                            print("Bangali");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Center(
                                  child: Text(
                                      "This page is not available in Bangali right now"),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                          title: "अ",
                          subtitle: "Bangali"),
                    ),
                  ],
                ),
              ),

              // =========================
              //       Language Warning
              // =========================
              heightSpacer(mHeight: 40),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.red.shade100),
                padding: EdgeInsets.all(15),
                child: Text(
                  "Please choose a language from above. \n You can change language from profile setting later",
                  style: mTextStyle13(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Button Widget
  Widget language_option({onPress, title, subtitle = "English"}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: AppColor.textColorLightBlack, //New
              blurRadius: 1.0,
            )
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          title == null
              ? Container()
              : Text(
                  title,
                  style: mTextStyle28(mFontWeight: FontWeight.w800),
                ),
          Text(
            subtitle,
            style: mTextStyle16(
                mFontWeight: FontWeight.w600, mColor: AppColor.textColorBlack),
          ),
        ]),
      ),
    );
  }
}
