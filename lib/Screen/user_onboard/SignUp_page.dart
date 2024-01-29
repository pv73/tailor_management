import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Factory_details.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/aadhar_into_screen.dart';
import 'package:tailor/Screen/user_onboard/Login_Page.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class SignUp_page extends StatefulWidget {
  final bool isCompany;

  SignUp_page({required this.isCompany});

  @override
  State<SignUp_page> createState() => _SignUp_pageState();
}

class _SignUp_pageState extends State<SignUp_page> {
  TextEditingController user_nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conf_PasswordController = TextEditingController();

  bool _isPassHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/banner/splash_bg.jpg"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    heightSpacer(mHeight: 60),
                    widget.isCompany == true
                        ? Text(
                      "Create Company Account",
                      style: mTextStyle24(
                          mFontWeight: FontWeight.w900,
                          mColor: AppColor.textColorBlue),
                    )
                        : Text(
                      "Create Tailor Account",
                      style: mTextStyle24(
                          mFontWeight: FontWeight.w900,
                          mColor: AppColor.textColorBlue),
                    ),

                    heightSpacer(),
                    Text(
                      "Create an account so you can explore \nall the existing jobs",
                      style: mTextStyle14(
                        mFontWeight: FontWeight.w600,
                        mColor: AppColor.textColorBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    heightSpacer(mHeight: 40),
                    TextFormField(
                      controller: user_nameController,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        prefixIcon: Icon(Icons.person),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 5,
                        hint: "User Name",
                        hintColor: AppColor.textColorLightBlack,
                      ),
                    ),

                    heightSpacer(mHeight: 20),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
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

                    heightSpacer(mHeight: 20),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        prefixIcon: Icon(Icons.phone),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 5,
                        hint: "Phone Number",
                        hintColor: AppColor.textColorLightBlack,
                        mCounterText: "",
                      ),
                    ),

                    heightSpacer(mHeight: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isPassHide,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 5,
                        hint: "Password",
                        hintColor: AppColor.textColorLightBlack,
                        prefixIcon: IconButton(
                          icon: _isPassHide == false
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            if (_isPassHide == false) {
                              _isPassHide = true;
                            } else {
                              _isPassHide = false;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),

                    heightSpacer(mHeight: 20),
                    TextFormField(
                      controller: conf_PasswordController,
                      obscureText: _isPassHide,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 5,
                        hint: "Conform Password",
                        hintColor: AppColor.textColorLightBlack,
                        prefixIcon: IconButton(
                          icon: _isPassHide == false
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            if (_isPassHide == false) {
                              _isPassHide = true;
                            } else {
                              _isPassHide = false;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),

                    // Login Btn
                    heightSpacer(mHeight: 50),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is AuthEmailStoreState) {
                          // hear check isTailor or not then Navigate
                          checkedAndNavigate();

                          //
                        } else if (state is AuthErrorState) {
                          showSnackBar_Widget(context,
                              mHeading: "Error", title: "${state.error}");
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Rounded_Btn_Widget(
                          mfontSize: 15,
                          mAlignment: Alignment.center,
                          borderRadius: 5,
                          onPress: () {
                            checkValues();
                          },
                          title: "Sign Up ",
                        );
                      },
                    ),

                    heightSpacer(mHeight: 15),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          text: "You have already an account ",
                          style: mTextStyle13(
                              mColor: AppColor.textColorBlack,
                              mFontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: " Login",
                              style: mTextStyle13(
                                  mColor: AppColor.textColorBlue,
                                  mFontWeight: FontWeight.w700),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogIn_Page()),
                                  );
                                },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================
  //            Functions
  // ======================================
  void checkValues() {
    String user_name = user_nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confPassword = conf_PasswordController.text.trim();

    if (user_name == "" ||
        phone == "" ||
        email == "" ||
        password == "" ||
        confPassword == "") {
      showSnackBar_Widget(context,
          mHeading: "Error",
          title: "Incomplete Data, Please fill all the fields");
    } else if (password != confPassword && password.length >= 6) {
      showSnackBar_Widget(context,
          mHeading: "Error",
          title: "Do not match password OR Min. enter 6 Digit password");
    } else {
      if (widget.isCompany == true) {
        // register company

        CompanyModel newCompany = CompanyModel(
          user_name: user_name,
          phone: phone,
          is_company: widget.isCompany,
        );
        log(widget.isCompany.toString());

        BlocProvider.of<AuthCubit>(context)
            .companySignUp(email, password, newCompany);
      } else {
        // register tailor (Users).

        UserModel newUser = UserModel(
          user_name: user_name,
          phone: phone,
          is_company: widget.isCompany,
        );

        BlocProvider.of<AuthCubit>(context)
            .tailorSignUp(email, password, newUser);
      }
    }
  }

  // Checked Admin OR not and the Navigate page by according Admin or Not
  void checkedAndNavigate() async {
    String uid = credential!.user!.uid;

    if (widget.isCompany == false) {
      // if register user is Client

      DocumentSnapshot userData =
      await FirebaseFirestore.instance.collection("clients").doc(uid).get();

      UserModel userModel =
      UserModel.fromMap(userData.data() as Map<String, dynamic>);

      showSnackBar_Widget(context,
          mHeading: "Success",
          title: "Your form is submitted successfully and you are loggedIn");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Aadhar_Card_Screen(
                firebaseUser: credential!.user!,
                userModel: userModel,
              ),
        ),
      );
    } else {
      // if register user is Company

      DocumentSnapshot companyData =
      await FirebaseFirestore.instance.collection("company").doc(uid).get();

      CompanyModel companyModel =
      CompanyModel.fromMap(companyData.data() as Map<String, dynamic>);


      showSnackBar_Widget(context,
          mHeading: "Success",
          title: "Your form is submitted successfully and you are loggedIn");
      Navigator.popUntil(context, (route) => route.isFirst);
      // Get.to used because Navigate newPage with animation

      Get.to(Factory_Details(
          firebaseUser: credential!.user!, companyModel: companyModel));

      var prefs = await SharedPreferences.getInstance();
      prefs.setBool("is_Company", true);
    }
  }
}
