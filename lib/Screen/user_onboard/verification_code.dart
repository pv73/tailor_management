import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/aadhar_into_screen.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/navigation_bar.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

import '../../controller/firebase_connection.dart';

class Verification_Code extends StatefulWidget {
  final String phoneNumber;

  // final String verificationId;
  Verification_Code({required this.phoneNumber});

  @override
  State<Verification_Code> createState() => _Verification_Code();
}

class _Verification_Code extends State<Verification_Code> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userData;
  late MediaQueryData mq;
  TextEditingController otpController = TextEditingController();

  int _Counter = 30;
  late Timer _timer;
  User? currentUser;
  UserModel? thisUserModel;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_Counter > 0) {
        setState(() {
          _Counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          width: mq.size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Verification code",
                  style: mTextStyle22(mFontWeight: FontWeight.w600)),
              heightSpacer(mHeight: 4),
              Text("We have sent the code verification to",
                  style: mTextStyle13(mColor: AppColor.textColorBlack)),

              heightSpacer(),

              RichText(
                text: TextSpan(
                  text: 'OTP sent to ${widget.phoneNumber} ',
                  style: mTextStyle15(mFontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                      text: 'Change Number?',
                      style: mTextStyle13(mColor: AppColor.activeColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    ),
                  ],
                ),
              ),

              /// OTP number line ////
              heightSpacer(mHeight: 19),

              heightSpacer(mHeight: mq.size.height * 0.05),

              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColor.textColorBlue),
                  ),
                  child: Column(
                    children: [
                      Text("Enter the OTP you received", style: mTextStyle17()),
                      heightSpacer(mHeight: 20),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: otpController,
                          maxLength: 6,
                          keyboardType: TextInputType.phone,
                          decoration: mInputDecoration(
                            radius: 5,
                            mCounterText: "",
                            padding: EdgeInsets.only(bottom: 10, left: 10),
                          ),
                        ),
                      ),

                      /// Button Continue ///
                      heightSpacer(mHeight: 20),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) async {
                          // TODO: implement listener
                          if (state is AuthLoggedInState) {
                            _timer.cancel();
                            //
                            getUserModel();

                            //
                          } else if (state is AuthErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(state.error),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Rounded_Btn_Widget(
                            mHeight: 40,
                            onPress: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .verifyOTP(otpController.text);
                            },
                            btnBgColor: AppColor.btnBgColorGreen,
                            title: "Verify OTP",
                            mAlignment: Alignment.center,
                            mTextColor: AppColor.textColorWhite,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),

              /// timer Text //
              heightSpacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You should receive the OTP in ", style: mTextStyle13()),
                  Text(
                    "${_Counter} Second",
                    style: mTextStyle13(mColor: Colors.red),
                  )
                ],
              ),

              heightSpacer(mHeight: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't Get your Code? ", style: mTextStyle12()),
                  Text("RESEND",
                      style: mTextStyle13(mFontWeight: FontWeight.w800)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ///   verify login
  getUserModel() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // LoggedIn
      thisUserModel = await FirebaseHelper.getUserModelById(currentUser!.uid);
    }

    Navigator.popUntil(context, (route) => route.isFirst);
    if (thisUserModel!.final_submit == true) {
      log("enter final submited in verification page");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Navigation_Bar(
              firebaseUser: currentUser!,
              userModel: thisUserModel!,
            ),
          ));

      var prefs = await SharedPreferences.getInstance();
      prefs.setBool("final_submit", true);
    } else {
      log("enter final submited in verification page");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Aadhar_Card_Screen(
            firebaseUser: currentUser!,
            userModel: thisUserModel!,
          ),
        ),
      );
    }
  }
}
