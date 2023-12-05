import 'package:flutter/material.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_Helper.dart';

class Panding_Task_Widget extends StatelessWidget {
  Color? mCardBgColor;
  Color? mIconBgColor;
  String? mImage;
  String? mText;
  void Function()? onPress;
  String? BtnText;

  Panding_Task_Widget(
      {required this.onPress,
      this.mText,
      this.BtnText,
      this.mCardBgColor,
      this.mIconBgColor,
      this.mImage});

  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Card(
      color: mCardBgColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: 65,
                height: 65,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mIconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  "${mImage}",
                ),
              ),
            ),
            widthSpacer(mWidth: 10),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${mText}",
                    style: mTextStyle12(),
                    // maxLines: 2,
                  ),
                  heightSpacer(),
                  Rounded_Btn_Widget(
                    onPress: onPress,
                    title: "${BtnText}",
                    mHeight: 25,
                    mWidth: mq.size.width * 0.26,
                    mfontSize: 11,
                    mFontWeight: FontWeight.bold,
                    btnBgColor: AppColor.cardBtnBgGreen,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
