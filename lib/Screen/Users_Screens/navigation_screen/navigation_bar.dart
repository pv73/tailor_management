import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Screen/Users_Screens/Home/home_page.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/applications_screen.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/attendance_screen.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/jobs_screen.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/profile_screen.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Navigation_Bar extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Navigation_Bar(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Navigation_Bar> createState() => _Navigation_BarState();
}

class _Navigation_BarState extends State<Navigation_Bar> {
  late MediaQueryData mq;
  int index = 2;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    /// Screen page
    final screens = [
      Jobs_Screen(),
      Attendance_Screen(),
      Home_Page(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
      Applications_Screen(),
      Profile_Screen(
          userModel: widget.userModel, firebaseUser: widget.firebaseUser)
    ];

    final items = <Widget>[
      // Videos
      if (index == 0)
        Nav_Icon_Text(mIcon: Icons.shopping_bag)
      else
        Nav_Icon_Text(mIcon: Icons.shopping_bag, mTitle: "Jobs"),

      // Attendance
      if (index == 1)
        Nav_Icon_Text(mIcon: Icons.calendar_month)
      else
        Nav_Icon_Text(mIcon: Icons.calendar_month, mTitle: "Attendance"),

      //Chat
      if (index == 2)
        Nav_Icon_Text(mIcon: Icons.home)
      else
        Nav_Icon_Text(mIcon: Icons.home, mTitle: "Home"),

      // Calls
      if (index == 3)
        Nav_Icon_Text(mIcon: Icons.file_copy_outlined)
      else
        Nav_Icon_Text(mIcon: Icons.file_copy_outlined, mTitle: "Applications"),

      // profile
      if (index == 4)
        Nav_Icon_Text(mIcon: Icons.person_outline_outlined)
      else
        Nav_Icon_Text(mIcon: Icons.person_outline_outlined, mTitle: "Profile"),
    ];

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          buttonBackgroundColor: AppColor.textColorBlue,
          backgroundColor: Colors.transparent,
          color: AppColor.textColorBlue,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: items,
          index: index,
          onTap: (mIndex) {
            setState(() {
              this.index = mIndex;
            });
          },
        ),
        body: screens[index]);
  }

  //================================================================
// ================= nav bar icon widget ===========================

  Widget Nav_Icon_Text({required mIcon, mTitle}) {
    return mTitle == null
        ? Icon(
            mIcon,
            size: 25,
            color: Colors.white,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(mIcon, size: 25, color: Colors.white),
                heightSpacer(mHeight: 5),
                Text(
                  mTitle,
                  style: mTextStyle12(mColor: AppColor.textColorWhite),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
  }
}
