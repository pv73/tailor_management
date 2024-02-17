import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Drawer_Screen/About_us.dart';
import 'package:tailor/Screen/Drawer_Screen/Disclaimer.dart';
import 'package:tailor/Screen/Drawer_Screen/Privacy_Policy.dart';
import 'package:tailor/Screen/Drawer_Screen/Terms_&_Condition.dart';
import 'package:tailor/Screen/user_onboard/First_Dashboard.dart';
import 'package:tailor/Screen/user_onboard/Login_Page.dart';
import 'package:tailor/Screen/user_onboard/Number_Login.dart';
import 'package:tailor/Screen/user_onboard/SignUp_page.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Drawer_Widget extends StatefulWidget {
  // hear value get current user is Company Or Users
  final bool? isCurUserCom;
  final User? firebaseUser;
  final UserModel? userModel;
  final CompanyModel? companyModel;

  Drawer_Widget(
      {this.isCurUserCom,
      this.userModel,
      this.firebaseUser,
      this.companyModel});

  @override
  State<Drawer_Widget> createState() => _Drawer_WidgetState();
}

class _Drawer_WidgetState extends State<Drawer_Widget> {
  User? currentUser;
  UserModel? currentUserModel;
  CompanyModel? currentCompanyModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColor.textColorWhite, AppColor.bgColorBlue],
          ),
        ),
        child: Column(
          children: [
            heightSpacer(mHeight: 45),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoggedInState) {
                    if (widget.isCurUserCom == true) {
                      return currentUserWidget(widget.companyModel);
                    } else {
                      return currentUserWidget(widget.userModel);
                    }
                  } else if (state is AuthLoggedOutState) {
                    return loggedOutWidget();
                  }
                  return Text("print else");
                },
              ),
            ),

            // menu
            heightSpacer(),
            Divider(),


            List_Name(
              onPres: () {},
              mIcon: Icons.menu,
              mText: "Tailor blog",
            ),

            List_Name(
              onPres: () {},
              mIcon: Icons.help_outline,
              mText: "How Tailor works",
            ),

            List_Name(
              onPres: () {},
              mIcon: Icons.poll,
              mText: "Tailor blog",
            ),

            List_Name(
              onPres: () {},
              mIcon: Icons.email_outlined,
              mText: "Write to us",
            ),

            List_Name(
              onPres: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: About_Us(),
                    type: PageTransitionType.rightToLeftWithFade,
                  ),
                );
              },
              mIcon: Icons.info_outline,
              mText: "About us",
            ),

             List_Name(
              onPres: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: Terms_And_Condition(),
                    type: PageTransitionType.rightToLeftWithFade,
                  ),
                );
              },
              mIcon: Icons.title,
              mText: "Terms and Condition",
            ),

            List_Name(
              onPres: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: Privacy_Policy(),
                    type: PageTransitionType.rightToLeftWithFade,
                  ),
                );
              },
              mIcon: Icons.privacy_tip_outlined,
              mText: "Privacy Policy",
            ),

            List_Name(
              onPres: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    child: Disclaimer(),
                    type: PageTransitionType.rightToLeftWithFade,
                  ),
                );
              },
              mIcon: Icons.not_interested,
              mText: "Disclaimer",
            ),

            // This code show only if Company or Tailor are LoggedIn OtherWise Hide
            if (widget.isCurUserCom == true || widget.isCurUserCom == false)
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => First_Dashboard(),
                    ),
                  );
                },
                builder: (context, state) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    child: Column(
                      children: [
                        // List_Name(
                        //   onPres: () {},
                        //   mIcon: Icons.person,
                        //   mText: "profile",
                        // ),
                        List_Name(
                          onPres: () async {
                            BlocProvider.of<AuthCubit>(context).logOut();
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setBool("is_Company", false);
                          },
                          mIcon: Icons.logout,
                          mText: "Log Out",
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              Container(child: Text("")),

          ],
        ),
      ),
    );
  }

  // TODO: = ==================== UI end Functions and Widgets Start this page =============

  /// this code get name word's first letter
  /// like Mukesh Kumar then get MK
  String getInitials(String name) {
    List<String> nameParts = name.split(" "); // Split the name into parts
    String initials = "";

    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0]; // Get the first letter of each non-empty part
      }
    }

    return initials;
  }

  /// hear check current User Company and Tailor(users) and get model
  Widget currentUserWidget<model>(model) {
    return Row(
      children: [
        if (model is CompanyModel)
          model.company_logo != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 30,
                  backgroundImage: NetworkImage("${model.company_logo}"),
                )
              : CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 30,
                  child: Text(
                    getInitials("${model.user_name}"),
                    style: mTextStyle19(mFontWeight: FontWeight.w700),
                  ),
                )
        else if (model is UserModel)
          model.profile_pic != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 30,
                  backgroundImage: NetworkImage("${model.profile_pic}"),
                )
              : CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 30,
                  child: Text(
                    getInitials("${model.user_name}"),
                    style: mTextStyle19(mFontWeight: FontWeight.w700),
                  ),
                ),
        widthSpacer(mWidth: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.user_name}",
                style: mTextStyle16(
                    mColor: AppColor.textColorBlack,
                    mFontWeight: FontWeight.w700),
              ),
              heightSpacer(mHeight: 1),
              Text(
                "${model.email}",
                style: mTextStyle13(),
              )
            ],
          ),
        )
      ],
    );
  }

  /// When User are LoggedOut then Show this Widget
  Widget loggedOutWidget() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 30,
                  child: Icon(Icons.person)),
            ),
            widthSpacer(mWidth: 10),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpacer(mHeight: 5),
                  Text(
                    "Build your profile",
                    style: mTextStyle19(
                        mColor: AppColor.textColorBlack,
                        mFontWeight: FontWeight.w700),
                  ),
                  heightSpacer(mHeight: 1),
                  Text(
                    "Job opportunities waiting for you at Tailor Management.",
                    style: mTextStyle13(
                      mFontWeight: FontWeight.w500,
                      mColor: AppColor.textColorLightBlack,
                    ),
                  )
                ],
              ),
            )
          ],
        ),

        /// buttons
        heightSpacer(mHeight: 20),
        Row(
          children: [
            Expanded(
              child: Rounded_Btn_Widget(
                onPress: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 500),
                        child: SignUp_page(isCompany: true)),
                  );
                },
                mHeight: 40,
                mAlignment: Alignment.center,
                borderRadius: 10,
                mfontSize: 12,
                mPadding: EdgeInsets.symmetric(horizontal: 13),
                title: "Register Company",
              ),
            ),
            widthSpacer(mWidth: 2),
            Expanded(
              child: Rounded_Btn_Widget(
                onPress: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 500),
                        child: SignUp_page(isCompany: false)),
                  );
                },
                mHeight: 40,
                mAlignment: Alignment.center,
                borderRadius: 10,
                mfontSize: 12,
                mPadding: EdgeInsets.symmetric(horizontal: 13),
                title: "Register Tailor",
              ),
            ),
          ],
        ),

        heightSpacer(mHeight: 5),
        Row(
          children: [
            Expanded(
              child: Rounded_Btn_Widget(
                onPress: () {
                  Navigator.pop(context);

                  // pageTransition used for pageNavigate with animation
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: Duration(milliseconds: 500),
                      isIos: true,
                      child: LogIn_Page(),
                    ),
                  );
                },
                mHeight: 40,
                mAlignment: Alignment.center,
                borderRadius: 10,
                mfontSize: 12,
                borderColor: Colors.orange,
                btnBgColor: Colors.orange,
                mPadding: EdgeInsets.symmetric(horizontal: 13),
                title: "Login",
              ),
            ),
            widthSpacer(mWidth: 2),
            Expanded(
              flex: 2,
              child: Rounded_Btn_Widget(
                onPress: () {
                  // Navigator.pop(context);
                  alertBox(
                    context,
                    title: "Be careful if you are company",
                    content:
                        "Phone login for tailors only: If you login by phone then your are tailor",
                    titleColor: Colors.red,
                    okayPress: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Number_login_Screen()),
                      );
                    },
                  );
                },
                mHeight: 40,
                mAlignment: Alignment.center,
                borderRadius: 10,
                mfontSize: 12,
                mPadding: EdgeInsets.symmetric(horizontal: 13),
                title: "SignUp with Phone",
              ),
            ),
          ],
        ),
      ],
    );
  }

  // menu Button
  Widget List_Name({required mIcon, required void Function()? onPres, mText}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      width: double.infinity,
      child: InkWell(
        onTap: onPres,
        child: Row(
          children: [
            Icon(
              mIcon,
              size: 20,
              color: AppColor.textColorBlue,
            ),
            widthSpacer(),
            Text(mText, style: mTextStyle14(mFontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
