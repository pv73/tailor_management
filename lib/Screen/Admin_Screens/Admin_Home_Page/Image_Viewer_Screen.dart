import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Image_Viewer_Screen extends StatelessWidget {
  final String ImageUrl;

  const Image_Viewer_Screen({super.key, required this.ImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          titleSpacing: 0,
          title: RichText(
            text: TextSpan(
              text: "View ",
              style: mTextStyle20(),
              children: [
                TextSpan(
                  text: "Image",
                  style: mTextStyle20(
                    mColor: AppColor.textColorBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Image.network("${ImageUrl}"),
        ),
    );
  }
}
