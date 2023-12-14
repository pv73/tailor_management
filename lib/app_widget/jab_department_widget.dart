import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tailor/ui_Helper.dart';

class Job_Department_widget extends StatelessWidget {
  String? title;
  String? image;
  void Function()? onPress;

  Job_Department_widget(
      {required this.onPress, required this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 27.h,
            backgroundImage: image == null ? null : AssetImage(image!),
          ),
          heightSpacer(),
          Text(
            title!,
            style: mTextStyle13(mFontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
