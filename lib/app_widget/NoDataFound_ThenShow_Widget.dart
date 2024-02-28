import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class NoDataFound_ThenShow_Widget extends StatelessWidget {
  String? headingText;
  String? image;
  String? subHeadingText;
  String? subHeadingParagraph;
  void Function()? onPressed;
  String? btnName;
  double? imageSize;

  NoDataFound_ThenShow_Widget(
      {this.headingText, this.image, this.subHeadingText, this.subHeadingParagraph, this.onPressed, this.btnName, this.imageSize = 200});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "${headingText}",
            style: mTextStyle18(mFontWeight: FontWeight.w600),
          ),
        ),
        Container(
          child: Image.asset(
            "${image}",
            width: imageSize,
          ),
        ),
        heightSpacer(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            "${subHeadingText}",
            style: mTextStyle19(mFontWeight: FontWeight.w800, mColor: AppColor.textColorBlack),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "${subHeadingParagraph}",
            style: mTextStyle14(mFontWeight: FontWeight.normal, mColor: AppColor.textColorBlack),
            textAlign: TextAlign.center,
          ),
        ),
        heightSpacer(mHeight: 25),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.btnBgColorGreen, foregroundColor: AppColor.textColorWhite),
            onPressed: onPressed,
            child: Text("${btnName}"))
      ],
    );
  }
}
