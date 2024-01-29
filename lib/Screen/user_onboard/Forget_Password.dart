import 'package:flutter/material.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_helper.dart';

class Forget_Password extends StatefulWidget {
  @override
  State<Forget_Password> createState() => _Forget_Password();
}

class _Forget_Password extends State<Forget_Password> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/banner/login_bg.jpg"),
        )),
        child: SafeArea(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  heightSpacer(mHeight: 55),
                  Text(
                    "Forget Password",
                    style: mTextStyle24(
                        mFontWeight: FontWeight.w900,
                        mColor: AppColor.textColorBlue),
                  ),

                  heightSpacer(),
                  Text(
                    "To reset your password, you need your email or mobile \nnumber that can be authenticated",
                    style: mTextStyle12(
                      mFontWeight: FontWeight.w500,
                      mColor: AppColor.textColorBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Image Selection
                  heightSpacer(mHeight: 15),
                  Image(
                    width: 120,
                    image: AssetImage("assets/images/banner/forget_icon.png"),
                  ),

                  heightSpacer(mHeight: 30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    decoration: mInputDecoration(
                      padding: EdgeInsets.only(top: 3),
                      prefixIcon: Icon(Icons.email_outlined),
                      preFixColor: AppColor.textColorLightBlack,
                      mIconSize: 18,
                      radius: 5,
                      hint: "Email",
                      hintColor: AppColor.textColorLightBlack,
                    ),
                  ),

                  // Reset Btn
                  heightSpacer(mHeight: 30),
                  Rounded_Btn_Widget(
                    mfontSize: 15,
                    mAlignment: Alignment.center,
                    borderRadius: 5,
                    onPress: () {},
                    title: "Reset Password ",
                  ),

                  // back to login
                  heightSpacer(mHeight: 15),
                  Rounded_Btn_Widget(
                    mfontSize: 15,
                    mAlignment: Alignment.center,
                    borderRadius: 5,
                    borderColor: AppColor.textColorBlue,
                    btnBgColor: Colors.transparent,
                    mTextColor: AppColor.textColorBlue,
                    onPress: () {
                      Navigator.pop(context);
                    },
                    title: "Back to login ",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
