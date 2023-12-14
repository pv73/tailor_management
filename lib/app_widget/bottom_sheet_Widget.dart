import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_Helper.dart';

////////// Show Modal Bottom Sheet /////
/// this modale create for How It Works

void bottom_Sheet_Widget(context, mq) {
  showModalBottomSheet(
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    backgroundColor: Colors.grey.shade50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        height: mq.size.height > 800
            ? mq.size.height * 0.65.h
            : mq.size.height * 0.92.h,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 13,
                      color: Colors.white,
                    )),
              ),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade50,
              child: Image.asset(
                "assets/images/logo/interview.png",
                width: 40,
              ),
            ),
            heightSpacer(mHeight: 10),
            Text(
              "Welcome to Interview Invites",
              style: mTextStyle19(
                  mFontWeight: FontWeight.w500,
                  mColor: AppColor.textColorBlack),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            heightSpacer(),
            Text(
              "HR can search your profile and send you interview invites without you applying to job",
              style: mTextStyle14(
                  mFontWeight: FontWeight.normal,
                  mColor: AppColor.textColorLightBlack),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            //
            Divider(
              color: Colors.grey.shade400,
              height: 25,
            ),

            Text(
              "How it works",
              style: mTextStyle15(),
            ),

            heightSpacer(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade50,
                child: Icon(
                  Icons.person,
                  size: 24,
                  color: Colors.amber,
                ),
              ),
              title: FittedBox(
                child: Text(
                  "Keep your profile updated to get invites",
                  style: mTextStyle15(),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Tailor Management recommend your profile to HR so keep it updated to get selected by HR.",
                  style: mTextStyle14(mColor: AppColor.textColorLightBlack),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Divider(
              indent: 55,
              color: Colors.grey.shade400,
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.purple.shade50,
                child: Icon(
                  Icons.thumb_up,
                  size: 18,
                  color: Colors.purple,
                ),
              ),
              title: FittedBox(
                child: Text(
                  "Accept/reject the interview invite",
                  style: mTextStyle15(),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Accept or decline the interview invite to show you interest in the role",
                  style: mTextStyle14(mColor: AppColor.textColorLightBlack),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Divider(
              indent: 55,
              color: Colors.grey.shade400,
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(
                  Icons.call,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
              title: Text(
                "Connect with HR",
                style: mTextStyle15(),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                    "If interested, connect with HR through Call or WhatsApp to discuss on next steps",
                    style: mTextStyle14(mColor: AppColor.textColorLightBlack),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),

            Spacer(),
            Rounded_Btn_Widget(
              title: "Okay, got it",
              btnBgColor: AppColor.btnBgColorGreen,
              mAlignment: Alignment.center,
              onPress: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}
