import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/skill_into_screen.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';

import '../../app_widget/rounded_btn_widget.dart';
import '../../ui_helper.dart';

class Interest_Into_Screen extends StatefulWidget {
  @override
  State<Interest_Into_Screen> createState() => _Interest_Into_ScreenState();
}

class _Interest_Into_ScreenState extends State<Interest_Into_Screen> {
  TextEditingController experience = TextEditingController();
  List<String> interest = [];
  String? category;
  bool _is_invite = false;

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
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 120,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number Indicator Row
                Row(
                  children: [
                    // 1st number
                    Intro_Number_Widget(number: 1, name: "About"),
                    Expanded(
                      child: Divider(color: AppColor.cardBtnBgGreen),
                    ),

                    // 2nd Number
                    Intro_Number_Widget(number: 2, name: "Education"),
                    Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                    // 3rd Number
                    Intro_Number_Widget(
                        number: 3, name: "Interest", active_no: 3),
                    Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                    // 4th Number
                    Intro_Number_Widget(number: 4, name: "Skills"),
                  ],
                ),

                Divider(height: 35),

                // Start Profile Box
                UserId == null
                    ? Center(child: CircularProgressIndicator())
                    : Profile_box_Widget(UserId: UserId),

                // Interest Details
                heightSpacer(mHeight: 20),
                Text(
                  "Area of Interest",
                  style: mTextStyle19(
                      mColor: AppColor.textColorBlack,
                      mFontWeight: FontWeight.w700),
                ),

                /// Interest Button
                heightSpacer(mHeight: 10),
                GroupButton(
                  options: mGroupButtonOptions(),
                  isRadio: false,
                  buttons: [
                    "Sampling",
                    "Alter Tailor for Finishing",
                    "Production",
                    "Other"
                  ],
                  onSelected: (Interest_btn_name, index, isSelected) {
                    if (isSelected) {
                      interest.add(Interest_btn_name);
                    } else {
                      interest.remove(Interest_btn_name);
                    }

                    // print(interest);
                  },
                ),

                /// Category Details
                heightSpacer(mHeight: 20),
                Text(
                  "Category of Tailor",
                  style: mTextStyle19(
                      mColor: AppColor.textColorBlack,
                      mFontWeight: FontWeight.w700),
                ),

                ///  Category Button
                heightSpacer(mHeight: 10),
                GroupButton(
                  options: mGroupButtonOptions(),
                  isRadio: true,
                  buttons: [
                    "Full Piece",
                    "Part Rate",
                    "Salary",
                    "Want to Work on Group",
                    "Other"
                  ],
                  onSelected: (cat_btn_name, index, isSelected) {
                    if (index == 3) {
                      _is_invite = true;
                    } else {
                      _is_invite = false;
                    }
                    // print(cat_btn_name);
                    category = cat_btn_name;

                    setState(() {});
                  },
                ),

                /// Category Details
                heightSpacer(mHeight: 20),
                _is_invite == false
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text(
                                "Then Invite group members",
                                style:
                                    mTextStyle16(mFontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Rounded_Btn_Widget(
                              title: "Invite Group",
                              mAlignment: Alignment.center,
                              btnBgColor: AppColor.activeColor,
                              mHeight: 35,
                              onPress: () {
                                /// Show Dialog
                                ///
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Alert'),
                                        content: const Text(
                                          'Now This Button is not Working',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),

                /// Experience
                heightSpacer(mHeight: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experience & Worked",
                      style: mTextStyle15(),
                    ),
                    heightSpacer(mHeight: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: experience,
                        keyboardType: TextInputType.text,
                        decoration: mInputDecoration(
                          hint: "Experience & at worked",
                          radius: 5,
                          padding: EdgeInsets.only(top: 10, left: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // Submit bottom Sheet bottom Sheet Btn
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Rounded_Btn_Widget(
            title: "Next",
            btnBgColor: AppColor.btnBgColorGreen,
            borderColor: AppColor.btnBgColorGreen,
            onPress: () {
              if (experience.text.isNotEmpty) {
                var interestData = {
                  'interest':
                      interest.isEmpty ? null : FieldValue.arrayUnion(interest),
                  'category': category == null ? null : '${category}',
                  'experience_company': experience.text.toString(),
                };

                FirebaseFirestore.instance
                    .collection('clients')
                    .doc(UserId)
                    .update(interestData);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Skills_Into_Screen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Center(child: Text('Experience field is Empty')),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            mHeight: 40,
            mAlignment: Alignment.center,
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // ================== UI end and  Widget and list Start ==================
  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
            color: AppColor.textColorLightBlack,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle13(
                  mFontWeight: FontWeight.w600,
                  mColor: AppColor.textColorLightBlack),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
