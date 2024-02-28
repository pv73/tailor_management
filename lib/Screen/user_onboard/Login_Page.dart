import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Admin_Dashboard.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Factory_details.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/aadhar_into_screen.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/navigation_bar.dart';
import 'package:tailor/Screen/user_onboard/First_Dashboard.dart';
import 'package:tailor/Screen/user_onboard/Forget_Password.dart';
import 'package:tailor/Screen/user_onboard/Number_Login.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class LogIn_Page extends StatefulWidget {
  @override
  State<LogIn_Page> createState() => _LogIn_PageState();
}

class _LogIn_PageState extends State<LogIn_Page> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late MediaQueryData mq;
  bool _isPassHide = true;
  UserModel? userModel;
  CompanyModel? companyModel;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: mq.size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner/language_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    heightSpacer(mHeight: 30),
                    Text(
                      "Login Here",
                      style: mTextStyle24(mFontWeight: FontWeight.w900, mColor: AppColor.textColorBlue),
                    ),

                    // heightSpacer(),
                    Text(
                      "Welcome back you've been missed!",
                      style: mTextStyle15(
                        mFontWeight: FontWeight.w700,
                        mColor: AppColor.textColorBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Image Selection
                    heightSpacer(mHeight: 15),
                    Image(
                      width: 140,
                      image: AssetImage("assets/images/logo/logo.png"),
                    ),

                    heightSpacer(mHeight: 30),
                    TextFormField(
                      controller: emailController,
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

                    heightSpacer(mHeight: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isPassHide,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 5,
                        hint: "Password",
                        hintColor: AppColor.textColorLightBlack,
                        prefixIcon: IconButton(
                          icon: _isPassHide != false ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
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

                    heightSpacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: Duration(milliseconds: 500),
                                child: Forget_Password()),
                          );
                        },
                        child: Text(
                          "Forget your password?",
                          style: mTextStyle13(mColor: AppColor.textColorBlue),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),

                    // Login Btn
                    heightSpacer(mHeight: 25),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        // TODO: implement listener
                        //
                        if (state is AuthLoggedInState) {
                          if (credential != null) {
                            String uid = credential!.user!.uid;

                            // Check in the "client" table
                            DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('clients').doc(uid).get();

                            if (userDoc.exists) {
                              userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
                              //
                              CheckAndNavigate(userModel);
                            } else {
                              // Check in the "company" table
                              DocumentSnapshot companyDoc = await FirebaseFirestore.instance.collection('company').doc(uid).get();

                              if (companyDoc.exists) {
                                companyModel = CompanyModel.fromMap(companyDoc.data() as Map<String, dynamic>);
                                //
                                CheckAndNavigate(companyModel);
                              }
                            }
                          }
                        } else if (state is AuthErrorState) {
                          showSnackBar_Widget(context, mHeading: "Error", title: "${state.error}");
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
                          title: "Login ",
                        );
                      },
                    ),

                    heightSpacer(mHeight: 15),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          text: "You have not account?  ",
                          style: mTextStyle13(mColor: AppColor.textColorBlack, mFontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: "Employer Create",
                              style: mTextStyle13(mColor: AppColor.textColorBlue, mFontWeight: FontWeight.w700),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => First_Dashboard()),
                                  );
                                },
                            )
                          ],
                        ),
                      ),
                    ),

                    heightSpacer(mHeight: 25),
                    Row(
                      children: [
                        Expanded(flex: 4, child: Divider()),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "OR",
                              style: mTextStyle14(mFontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(flex: 4, child: Divider()),
                      ],
                    ),

                    // Phone button
                    heightSpacer(mHeight: 20),
                    Rounded_Btn_Widget(
                      mfontSize: 15,
                      mAlignment: Alignment.center,
                      borderRadius: 5,
                      btnBgColor: Color(0xD3182B64),
                      onPress: () {
                        alertBox(
                          context,
                          title: "Be careful if you are company",
                          content: "Phone login for tailors only: If you login by phone then your are tailor",
                          titleColor: Colors.red,
                          okayPress: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Number_login_Screen()),
                            );
                          },
                        );
                      },
                      title: "Login with phone ",
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

  void checkValues() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      showSnackBar_Widget(context, mHeading: "Error", title: "Incomplete Data, Please fill all the fields");
    } else {
      BlocProvider.of<AuthCubit>(context).logIn(email, password);
    }
  }

  /// Check which model get then decide navigate pages between Tailor(Users) and Company
  void CheckAndNavigate(model) async {
    if (model == userModel) {
      if (userModel!.final_submit == true) {
        showSnackBar_Widget(context, mHeading: "Success", title: "Your are login successfully");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 500),
              child: Navigation_Bar(
                firebaseUser: credential!.user!,
                userModel: userModel!,
              ),
            ));

        var prefs = await SharedPreferences.getInstance();
        prefs.setBool("final_submit", true);
      } else {
        showSnackBar_Widget(context, mHeading: "Success", title: "Your are login successfully");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 500),
            child: Aadhar_Card_Screen(
              firebaseUser: credential!.user!,
              userModel: userModel!,
            ),
          ),
        );
      }
    } else {
      if (companyModel!.final_submit == true) {
        showSnackBar_Widget(context, mHeading: "Success", title: "Your are login successfully");

        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 500),
              child: Admin_Dashboard(
                firebaseUser: credential!.user!,
                companyModel: companyModel!,
              ),
            ));

        var prefs = await SharedPreferences.getInstance();
        prefs.setBool("company_final_submit", true);
        prefs.setBool("is_Company", true);
      } else {
        showSnackBar_Widget(context, mHeading: "Success", title: "Your are login successfully");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 500),
            child: Factory_Details(
              firebaseUser: credential!.user!,
              companyModel: companyModel!,
            ),
          ),
        );
      }
    }
  }
}
