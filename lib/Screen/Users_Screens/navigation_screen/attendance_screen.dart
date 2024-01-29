import 'package:flutter/material.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/activity_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_helper.dart';

class Attendance_Screen extends StatefulWidget {
  @override
  State<Attendance_Screen> createState() => _Attendance_ScreenState();
}

class _Attendance_ScreenState extends State<Attendance_Screen> {
  bool _is_Persent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leadingWidth: 25,
        title: RichText(
          text: TextSpan(text: "Tailor ", style: mTextStyle20(), children: [
            TextSpan(
                text: "Attendence",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.settings,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
        ],
      ),
      drawer: Drawer_Widget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                //  Section in this Container
                // Card_Container_Widget is own created Widget
                Card_Container_Widget(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attendance Dashboard",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      // Card row Start
                      heightSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Activity_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/ic_attendence.png",
                            mText: "Total Attendence",
                            mTextNo: "31",
                            mColor: AppColor.textColorBlue,
                          ),
                          Activity_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/ic_present.png",
                            mText: "Total Present",
                            mTextNo: "25",
                            mColor: AppColor.cardBtnBgGreen,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Activity_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/ic_absent.png",
                            mText: "Total Absent",
                            mTextNo: "02",
                            mColor: Colors.red,
                          ),
                          Activity_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/ic_leave.png",
                            mText: "Total Leave",
                            mTextNo: "03",
                            mColor: AppColor.textColorBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Today Activity
                heightSpacer(mHeight: 15),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today Activity",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      // Card Box
                      heightSpacer(),
                      Row(
                        children: [
                          // 1st container
                          Today_Activity(
                            mIcon: Icons.arrow_circle_right_outlined,
                            mText: "Check In",
                            mTimeText: "09:30 AM",
                            mActionText: "On Time",
                            mColor: AppColor.cardBtnBgGreen,
                          ),

                          // 2nd Container
                          widthSpacer(mWidth: 8),
                          Today_Activity(
                            mIcon: Icons.arrow_circle_left_outlined,
                            mText: "Check Out",
                            mTimeText: "06:30 PM",
                            mActionText: "On Time",
                            mColor: Colors.red,
                          ),
                        ],
                      ),

                      //
                      heightSpacer(),
                      Row(
                        children: [
                          // 1st container
                          Today_Activity(
                            mIcon: Icons.alarm,
                            mText: "Start Overtime",
                            mTimeText: "06:30 PM",
                            mColor: AppColor.cardBtnBgGreen,
                          ),

                          // 2nd Container
                          widthSpacer(mWidth: 8),
                          Today_Activity(
                            mIcon: Icons.arrow_circle_left_outlined,
                            mText: "Finish Overtime",
                            mTimeText: "11:00 PM",
                            mColor: Colors.red,
                          ),
                        ],
                      ),

                      // Today Activity
                      heightSpacer(),
                      Card_Container_Widget(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 18,
                            ),
                            Expanded(
                              child: Text(
                                "Today",
                                style:
                                    mTextStyle14(mFontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "5h 00m",
                                style: mTextStyle14(
                                    mFontWeight: FontWeight.w700,
                                    mColor: AppColor.cardBtnBgGreen),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            //
                            Expanded(
                              child: Text(
                                "Today",
                                style:
                                    mTextStyle14(mFontWeight: FontWeight.w700),
                              ),
                            ),

                            Expanded(
                              child: Text(
                                "5h 00m",
                                style: mTextStyle14(
                                    mFontWeight: FontWeight.w700,
                                    mColor: AppColor.cardBtnBgGreen),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Image only
                      heightSpacer(mHeight: 15),
                      Container(
                        child: Image.asset("assets/images/banner/img_3.png"),
                      ),

                      // Older Activity
                      heightSpacer(mHeight: 15),
                      Card_Container_Widget(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Older Activity",
                                  style: mTextStyle15(),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("See More");
                                  },
                                  child: Text(
                                    "See More",
                                    style: mTextStyle13(
                                        mColor: AppColor.cardBtnBgGreen,
                                        mFontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),

                            // =================================
                            //        older box
                            heightSpacer(mHeight: 15),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                shrinkWrap: true,
                                itemBuilder: (context, old_data_index) {
                                  return Card_Container_Widget(
                                    margin: EdgeInsets.only(bottom: 7),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Column(
                                      children: [
                                        /// Check In

                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_right_outlined,
                                                      size: 18,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  widthSpacer(mWidth: 3),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      "Check In",
                                                      style: mTextStyle15(
                                                          mColor: AppColor
                                                              .btnBgColorGreen),
                                                      // maxLines: 1,
                                                      // overflow:
                                                      //     TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      "23 Feb 2023",
                                                      style: mTextStyle12(),
                                                    ),
                                                  ),
                                                  Text(
                                                    "2H 15 Min. Overtime",
                                                    style: mTextStyle12(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "08:45 PM",
                                                style: mTextStyle15(),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// Check Out
                                        heightSpacer(mHeight: 15),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_left_outlined,
                                                      size: 18,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  widthSpacer(mWidth: 3),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      "Check Out",
                                                      style: mTextStyle15(
                                                          mColor: Colors.red),
                                                      // maxLines: 1,
                                                      // overflow:
                                                      //     TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      "23 Feb 2023",
                                                      style: mTextStyle12(),
                                                    ),
                                                  ),
                                                  Text(
                                                    "2H 15 Min. Overtime",
                                                    style: mTextStyle12(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "08:45 PM",
                                                style: mTextStyle15(),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),

                      /// ===================================
                      /// Buttons
                      heightSpacer(mHeight: 20),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Rounded_Btn_Widget(
                                title: "Leave",
                                mAlignment: Alignment.center,
                                borderRadius: 10,
                                onPress: () {
                                  print("Leave");
                                },
                              ),
                            ),
                            widthSpacer(mWidth: 5),
                            Expanded(
                              child: Rounded_Btn_Widget(
                                title: "Absent",
                                mAlignment: Alignment.center,
                                borderRadius: 10,
                                btnBgColor: Colors.red,
                                onPress: () {
                                  print("Absent");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Second Row btn
                      heightSpacer(),
                      Container(
                        child: Rounded_Btn_Widget(
                          title: _is_Persent == false ? "Persent" : "Check Out",
                          mAlignment: Alignment.center,
                          borderRadius: 10,
                          btnBgColor: _is_Persent == false
                              ? AppColor.cardBtnBgGreen
                              : Colors.red,
                          onPress: () {
                            if (_is_Persent == false) {
                              print("Present");
                              _is_Persent = true;
                            } else {
                              print("Check Out");
                              _is_Persent = false;
                            }
                            setState(() {});
                          },
                        ),
                      ),

                      heightSpacer(mHeight: 15)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
