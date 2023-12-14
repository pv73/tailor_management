import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Rounded_Btn_Widget extends StatelessWidget {
  double mWidth;
  double mHeight;
  String title;
  double? mfontSize;
  double? mIconSize;
  FontWeight? mFontWeight;
  Color? mTextColor;
  Color? btnBgColor;
  Color? borderColor;
  Color? disabledBgColor;
  Color? iconColor;
  void Function()? onPress;
  double borderRadius;
  IconData? mIcon;
  Alignment mAlignment;

  Rounded_Btn_Widget(
      {required this.title,
      required this.onPress,
      this.mfontSize = 15,
      this.mIconSize = 15,
      this.mFontWeight = FontWeight.w600,
      this.mWidth = double.infinity,
      this.mHeight = 45,
      this.mTextColor = AppColor.textColorWhite,
      this.btnBgColor = AppColor.textColorBlue,
      this.borderColor = AppColor.bgColorWhite,
      this.disabledBgColor = AppColor.bgColorWhite,
      this.borderRadius = 5,
      this.mIcon,
      this.iconColor,
      this.mAlignment = Alignment.centerLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
      height: mHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: btnBgColor,
            disabledBackgroundColor: disabledBgColor,
            alignment: mAlignment,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(color: borderColor!))),
        onPressed: onPress,
        child: FittedBox(
          fit: BoxFit.cover,
          child: mIcon == null
              ? Text(
                  title,
                  style: TextStyle(
                      color: mTextColor!,
                      fontSize: mfontSize,
                      fontWeight: mFontWeight),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      mIcon,
                      color: iconColor,
                      size: mIconSize,
                    ),
                    widthSpacer(mWidth: 5),
                    Text(
                      title,
                      style: TextStyle(
                          color: mTextColor!,
                          fontSize: mfontSize,
                          fontWeight: mFontWeight),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
