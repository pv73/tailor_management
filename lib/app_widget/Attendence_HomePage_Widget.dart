import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor/app_widget/activity_widget.dart';
import 'package:tailor/ui_helper.dart';

class Attendence_HomePage_Widget extends StatefulWidget {
  const Attendence_HomePage_Widget({super.key});

  @override
  State<Attendence_HomePage_Widget> createState() =>
      _Attendence_HomePage_WidgetState();
}

class _Attendence_HomePage_WidgetState
    extends State<Attendence_HomePage_Widget> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ExpandablePageView(
            onPageChanged: (index) {
              setState(() {
                activeIndex = index;
              });
            },
            children: <Widget>[
              /// Slider Container page 1
              Container(
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Activity_Widget(
                          mImage: "assets/images/logo/ic_attendence.png",
                          mText: "Total Attendence",
                          mTextNo: "31",
                          mColor: AppColor.textColorBlue,
                          mBgColor: Colors.grey.shade50,
                        ),
                        Activity_Widget(
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
                          mImage: "assets/images/logo/ic_absent.png",
                          mText: "Total Absent",
                          mTextNo: "02",
                          mColor: Colors.red,
                        ),
                        Activity_Widget(
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

              /// Slider Container Page 2
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(mHeight: 5),
                    Text(
                      "Today Activity",
                      style: mTextStyle15(mFontWeight: FontWeight.w600),
                    ),
                    heightSpacer(mHeight: 15),
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
                  ],
                ),
              ),
            ],
          ),
        ),

        //// Slider Indicator ///
        heightSpacer(mHeight: 8),
        buildIndicator(),
      ],
    );
  }

  /// slider Indicator //
  Widget buildIndicator() {
    return Align(
      alignment: Alignment.center,
      child: AnimatedSmoothIndicator(
        count: 2,
        activeIndex: activeIndex,
        effect: WormEffect(
            spacing: 4.0,
            radius: 8.0,
            dotWidth: 8.0,
            dotHeight: 5.0,
            paintStyle: PaintingStyle.stroke,
            activeDotColor: Colors.indigo),
      ),
    );
  }
}
