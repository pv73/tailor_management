import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor/Screen/user_onboard/verification_code.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/ui_helper.dart';

class Number_login_Screen extends StatefulWidget {
  @override
  State<Number_login_Screen> createState() => _Number_login_ScreenState();
}

class _Number_login_ScreenState extends State<Number_login_Screen> {
  late MediaQueryData mq;
  bool isChecked = false;
  bool isError = false;

  TextEditingController phoneController = TextEditingController();
  String? phoneNumber;
  String? verifyId;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner/splash_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Image.asset("assets/images/logo/logo.png",
                    width: mq.size.width * 0.7),
              ),
            ),

            heightSpacer(mHeight: 20),

            // start Number Box
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColor.textColorBlue)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter Mobile No.",
                    style: mTextStyle24(mFontWeight: FontWeight.w600),
                  ),
                  heightSpacer(mHeight: 15),
                  SizedBox(
                    height: 47,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColor.textColorBlue),
                      maxLength: 10,
                      decoration: mInputDecoration(
                        hint: "Mobile No.",
                        hintColor: AppColor.textColorBlue,
                        filledColor: AppColor.bgColorWhite,
                        padding: EdgeInsets.only(top: 12),
                        prefixIcon: Icons.call,
                        mCounterText: "",
                        radius: 10,
                      ),
                    ),
                  ),
                  heightSpacer(),
                  Container(
                    width: double.infinity,
                    child: Text("Have an Invite code?",
                        style: mTextStyle12(), textAlign: TextAlign.right),
                  ),
                  heightSpacer(),

                  // CheckBox section
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.zero,
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              color: AppColor.bgColorWhite,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: AppColor.textColorBlue)),
                          child: Checkbox(
                            checkColor: AppColor.textColorBlue,
                            activeColor: Colors.transparent,
                            side: BorderSide(color: AppColor.bgColorWhite),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                                if (isChecked == true) {
                                  isError = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      widthSpacer(),
                      Expanded(
                        flex: 23,
                        child: Text("I confirm that I am 18+ years in age",
                            style: mTextStyle13(
                                mColor: AppColor.textColorBlue,
                                mFontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),

                  heightSpacer(),

                  isError == false
                      ? Container()
                      : Container(
                          child: Text(
                            "Please check the checkbox",
                            style: mTextStyle12(mColor: Colors.red),
                          ),
                        ),

                  /// Button Continue ///
                  heightSpacer(mHeight: 20),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is AuthCodeSentState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Verification_Code(phoneNumber: phoneNumber!),
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
                        onPress: () {
                          if (isChecked == true) {
                            phoneNumber = "+91" + phoneController.text;

                            BlocProvider.of<AuthCubit>(context)
                                .sendOTP(phoneNumber!);
                          } else {
                            isError = true;
                            setState(() {});
                          }
                        },
                        btnBgColor: AppColor.btnBgColorGreen,
                        title: "CONTINUE",
                        mAlignment: Alignment.center,
                        mTextColor: AppColor.textColorWhite,
                      );
                    },
                  ),

                  heightSpacer(),
                  Text(
                    "Terms & Conditions And privacy Policy",
                    style: TextStyle(color: AppColor.textColorBlue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
