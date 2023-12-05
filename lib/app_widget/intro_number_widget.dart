import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Intro_Number_Widget extends StatelessWidget {
  var active_no;
  var number;
  var name;

  Intro_Number_Widget({
    required this.number,
    required this.name,
    this.active_no,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: number == active_no
                ? Border.all(color: AppColor.cardBtnBgGreen, width: 2)
                : Border.all(color: AppColor.btnBgColorGreen),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "$number",
              style: mTextStyle17(
                mColor: AppColor.cardBtnBgGreen,
                mFontWeight:
                    number == active_no ? FontWeight.w800 : FontWeight.w400,
              ),
            ),
          ),
        ),
        heightSpacer(mHeight: 3),
        Container(
          alignment: Alignment.center,
          child: Text(
            "$name",
            style: mTextStyle12(
              mColor: AppColor.cardBtnBgGreen,
              mFontWeight: number == active_no ? FontWeight.w600 : FontWeight.w400
            ),
          ),
        )
      ],
    );
  }
}
