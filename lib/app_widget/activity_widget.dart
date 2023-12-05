import 'package:flutter/material.dart';
import 'package:tailor/ui_Helper.dart';

//// Attendance Activity First page Widget ////
//=============================================

class Activity_Widget extends StatelessWidget {
  String? mText;
  String? mTextNo;
  Color? mColor;
  Color? mBgColor;
  String? mImage;

  Activity_Widget(
      {required this.mText,
      required this.mTextNo,
      this.mColor,
      this.mBgColor,
      required this.mImage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        color: mBgColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(flex: 2, child: Image.asset("${mImage}")),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "${mTextNo}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: mColor),
                    ),
                  )
                ],
              ),
              // heightSpacer(mHeight: 4),
              Text(
                "${mText}",
                style:
                    mTextStyle13(mFontWeight: FontWeight.w500, mColor: mColor!),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//==========================================================
///      Attendence activity Second page Widget  /////

class Today_Activity extends StatelessWidget {
  String? mText;
  String? mActionText;
  String? mTimeText;
  IconData? mIcon;
  Color? mColor;

  Today_Activity(
      {required this.mText,
      this.mActionText,
      this.mTimeText,
      this.mIcon,
      this.mColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: AppColor.textColorWhite,
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  mIcon,
                  color: mColor,
                  size: 18,
                ),
                widthSpacer(mWidth: 2),
                Text(
                  "${mText}",
                  style: mTextStyle12(
                      mFontWeight: FontWeight.w600,
                      mColor: mActionText == null
                          ? mColor!
                          : AppColor.textColorBlack),
                ),
                Spacer(),
                mActionText == null
                    ? Container()
                    : Text(
                        "${mActionText}",
                        style: mTextStyle12(
                            mFontWeight: FontWeight.w700, mColor: mColor!),
                      )
              ],
            ),
            heightSpacer(),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "${mTimeText}",
                style: mTextStyle15(mFontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
