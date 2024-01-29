import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Recomnded_Job_HomePage_Widget extends StatefulWidget {
  void Function()? onPress;
  String mTitle;
  String mIcon;
  double mIcon_width;

  Recomnded_Job_HomePage_Widget(
      {required this.onPress,
      required this.mTitle,
      required this.mIcon,
      this.mIcon_width = 30.0});

  @override
  State<Recomnded_Job_HomePage_Widget> createState() =>
      _Recomnded_Job_HomePage_WidgetState();
}

class _Recomnded_Job_HomePage_WidgetState
    extends State<Recomnded_Job_HomePage_Widget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.bgColorWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "${widget.mTitle}",
                style: mTextStyle15(),
                textAlign: TextAlign.center,
              ),
            ),
            heightSpacer(mHeight: 10),
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              radius: 20,
              child: Image.asset(
                "${widget.mIcon}",
                width: widget.mIcon_width,
              ),
            ),
            heightSpacer(),
            TextButton(
              onPressed: widget.onPress,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "View all >",
                  style: mTextStyle15(mColor: AppColor.cardBtnBgGreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
