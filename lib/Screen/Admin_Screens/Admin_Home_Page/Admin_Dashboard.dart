import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Admin_Profile.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Post_Job.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Total_Posted_Job.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Admin_Home_Page.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_Dashboard extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const Admin_Dashboard({
    super.key,
    required this.firebaseUser,
    required this.companyModel,
  });

  @override
  State<Admin_Dashboard> createState() => _Admin_Dashboard();
}

class _Admin_Dashboard extends State<Admin_Dashboard> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    /// Screen page
    final screens = [
      Admin_Home_Page(
        firebaseUser: widget.firebaseUser,
        companyModel: widget.companyModel,
      ),
      Post_Job(
        firebaseUser: widget.firebaseUser,
        companyModel: widget.companyModel,
      ),
      Total_Posted_Job(
        firebaseUser: widget.firebaseUser,
        companyModel: widget.companyModel,
      ),
      Admin_Profile(
        firebaseUser: widget.firebaseUser,
        companyModel: widget.companyModel,
      )
    ];

    final items = <Widget>[
      // Videos
      if (index == 0) Nav_Icon_Text(mIcon: Icons.home) else Nav_Icon_Text(mIcon: Icons.home, mTitle: "Home"),

      // Post Job
      if (index == 1) Nav_Icon_Text(mIcon: Icons.shopping_bag) else Nav_Icon_Text(mIcon: Icons.shopping_bag, mTitle: "Post Job"),

      //Invite
      if (index == 2) Nav_Icon_Text(mIcon: Icons.poll) else Nav_Icon_Text(mIcon: Icons.poll, mTitle: "Posted post"),

      // Profile
      if (index == 3)
        Nav_Icon_Text(mIcon: Icons.person_outline_outlined)
      else
        Nav_Icon_Text(mIcon: Icons.person_outline_outlined, mTitle: "Profile"),
    ];

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          buttonBackgroundColor: AppColor.textColorBlue,
          backgroundColor: Colors.white10,
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

  Widget Nav_Icon_Text({mIcon, mTitle}) {
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
