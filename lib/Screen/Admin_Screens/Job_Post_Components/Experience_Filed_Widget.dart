import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Experience_Filed_Widget extends StatelessWidget {
  final String? mTitle;
  final String? mHintText;
  final TextEditingController? textController;
  final void Function(String)? onChanged;

  const Experience_Filed_Widget({
      this.mTitle,
      this.mHintText,
      this.textController,
      this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "${mTitle}",
              style: mTextStyle13(mFontWeight: FontWeight.w400),
              // children: [
              //   TextSpan(
              //     text: " *",
              //     style: mTextStyle13(
              //         mFontWeight: FontWeight.w800, mColor: Colors.red),
              //   )
              // ],
            ),
          ),
          heightSpacer(mHeight: 5),
          TextFormField(
              controller: textController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              decoration: mInputDecoration(
                padding: EdgeInsets.only(top: 3, left: 10),
                radius: 5,
                hint: "${mHintText}",
                mCounterText: "",
                hintColor: AppColor.textColorLightBlack,
              ),
              onChanged: onChanged),
        ],
      ),
    );
  }
}
