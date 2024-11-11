import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Admin_Dashboard_Widget extends StatelessWidget {
  String? mText;
  String? mTextNo;
  Color? mColor;
  Color? mBgColor;
  String? mImage;
  Widget? widget;
  Function()? onPressed;

  Admin_Dashboard_Widget({
    this.mText,
    this.mTextNo,
    this.mColor,
    this.mBgColor,
    this.mImage,
    this.widget,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.transparent,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          color: mBgColor,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.asset(
                          "${mImage}",
                        )),
                    widthSpacer(),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${mText}",
                            style: mTextStyle13(mFontWeight: FontWeight.w500, mColor: mColor!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          widget == null
                              ? Text(
                                  "${mTextNo}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: mColor),
                                )
                              : widget!,
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
