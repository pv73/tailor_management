import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Update_button_Widget extends StatelessWidget {
  final void Function()? onUpdatePress;
  final void Function()? onCancelPress;

  const Update_button_Widget({super.key, this.onUpdatePress, this.onCancelPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Container()),
        Expanded(
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              child: FittedBox(
                child: Text(
                  "Cancel",
                  style: mTextStyle13(mFontWeight: FontWeight.w500, mColor: AppColor.textColorWhite),
                ),
              ),
              onPressed: onCancelPress,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                ),
              ),
            ),
          ),
        ),
        widthSpacer(mWidth: 1),
        Expanded(
          child: SizedBox(
            height: 35,
            child: ElevatedButton(
              child: FittedBox(
                child: Text(
                  "Update",
                  style: mTextStyle13(mFontWeight: FontWeight.w500, mColor: AppColor.textColorWhite),
                ),
              ),
              onPressed: onUpdatePress,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: AppColor.cardBtnBgGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
