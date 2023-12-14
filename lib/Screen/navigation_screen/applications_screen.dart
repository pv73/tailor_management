import 'package:flutter/material.dart';
import 'package:tailor/app_widget/bottom_sheet_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_helper.dart';

class Applications_Screen extends StatefulWidget {
  @override
  State<Applications_Screen> createState() => _Applications_Screen();
}

class _Applications_Screen extends State<Applications_Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: RichText(
            text: TextSpan(text: "Tailor ", style: mTextStyle20(), children: [
              TextSpan(
                  text: "Applications",
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide.none,
                    bottom: BorderSide(width: 2, color: Colors.green.shade100),
                  ),
                ),
                child: TabBar(
                  labelColor: AppColor.textColorBlack,
                  unselectedLabelColor: AppColor.textColorLightBlack,
                  indicator: BoxDecoration(
                    border: Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide.none,
                      bottom:
                          BorderSide(width: 3, color: AppColor.cardBtnBgGreen),
                    ),
                  ),
                  tabs: [
                    Tab(
                      text: "Applied jobs",
                    ),
                    Tab(
                      text: "Interview Invites",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  Applied_Job_Tab(),
                  Interview_Tab(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================
//           Applied_Job_Tab page Screen
// ================================================
class Applied_Job_Tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("1 applied jobs"),
          ),
          heightSpacer(mHeight: 15),
          Card_Container_Widget(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full Piece",
                  style: mTextStyle18(mFontWeight: FontWeight.w700),
                ),
                heightSpacer(),
                Row(
                  children: [
                    Icon(
                      Icons.home_work_outlined,
                      size: 18,
                    ),
                    widthSpacer(),
                    Text(
                      "Okhala, New Delhi",
                      style: mTextStyle13(mColor: AppColor.textColorLightBlack),
                    )
                  ],
                ),
                heightSpacer(),
                Row(
                  children: [
                    Icon(
                      Icons.money,
                      size: 18,
                    ),
                    widthSpacer(),
                    Icon(
                      Icons.currency_rupee,
                      size: 13,
                      color: AppColor.textColorLightBlack,
                    ),
                    Text(
                      "25,000 - 30,000 Monthly",
                      style: mTextStyle13(mColor: AppColor.textColorLightBlack),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//

//
// ==============================================================
//           Interview_Tab Page Screen
// ================================================
class Interview_Tab extends StatefulWidget {
  @override
  State<Interview_Tab> createState() => _Interview_TabState();
}

class _Interview_TabState extends State<Interview_Tab> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: Image.asset(
                "assets/images/logo/interview.png",
                width: 50,
              ),
            ),
            heightSpacer(mHeight: 20),
            Text(
              "Welcome to Interview Invites",
              style: mTextStyle19(
                  mFontWeight: FontWeight.w700,
                  mColor: AppColor.textColorBlack),
              textAlign: TextAlign.center,
            ),
            heightSpacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "HR can search your profile and send you interview invites without you applying to job",
                style: mTextStyle15(
                    mFontWeight: FontWeight.normal,
                    mColor: AppColor.textColorLightBlack),
                textAlign: TextAlign.center,
              ),
            ),
            heightSpacer(mHeight: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Rounded_Btn_Widget(
                title: "How it works",
                btnBgColor: AppColor.btnBgColorGreen,
                mAlignment: Alignment.center,
                onPress: () {
                  bottom_Sheet_Widget(context, mq);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
