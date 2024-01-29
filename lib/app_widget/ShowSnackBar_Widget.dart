import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

// ------------------------------------ //
//  ScaffoldMessenger  //
// ------------------------------------ //

void showSnackBar_Widget(
  BuildContext context, {
  required mHeading,
  required title,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      margin: EdgeInsets.all(5),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            // height: 90,
            decoration: BoxDecoration(
              color:
                  mHeading == "Error" ? Color(0xffa21418) : Color(0xff187701),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: mHeading == "Error"
                      ? AssetImage(
                          "assets/images/banner/shape_1.png",
                        )
                      : AssetImage(
                          "assets/images/banner/shape_4.png",
                        ),
                  alignment: Alignment.bottomLeft),
            ),
            child: Row(
              children: [
                widthSpacer(mWidth: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mHeading == "Error"
                          ? Text("Opps !!",
                              style: mTextStyle18(
                                  mFontWeight: FontWeight.w600,
                                  mColor: AppColor.textColorWhite))
                          : Text(mHeading,
                              style: mTextStyle18(
                                  mFontWeight: FontWeight.w600,
                                  mColor: AppColor.textColorWhite)),
                      Text(
                        title,
                        style: mTextStyle12(mColor: AppColor.textColorWhite),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Image
          Positioned(
            top: -20,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                mHeading == "Error"
                    ? Image.asset(
                        "assets/images/banner/shape_2.png",
                        height: 50,
                        width: 50,
                      )
                    : Image.asset(
                        "assets/images/banner/shape_3.png",
                        height: 50,
                        width: 50,
                      ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: mHeading == "Error"
                      ? Icon(
                          Icons.clear,
                          color: AppColor.textColorWhite,
                        )
                      : Icon(
                          Icons.check_outlined,
                          color: AppColor.textColorWhite,
                        ),
                )
              ],
            ),
          )
        ],
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
