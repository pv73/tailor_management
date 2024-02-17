import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Show_Experience_Widget extends StatelessWidget {
  var getJobListData;
   FontWeight mFontWeight;

  Show_Experience_Widget({required this.getJobListData, this.mFontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getJobListData['minimum_experience'] == "" && getJobListData['maximum_experience'] == ""
          ? Text(
              "Fresher",
              style: mTextStyle13(mFontWeight: mFontWeight),
              textAlign: TextAlign.center,
            )
          : getJobListData['minimum_experience'] != "" && getJobListData['maximum_experience'] != ""
              ? Text(
                  "${getJobListData['minimum_experience']}-${getJobListData['maximum_experience']} Years",
                  style: mTextStyle13(mFontWeight: mFontWeight),
                  textAlign: TextAlign.center,
                )
              : getJobListData['minimum_experience'] == ""
                  ? Text(
                      "${getJobListData['maximum_experience']} Years",
                      style: mTextStyle13(mFontWeight: mFontWeight),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      "${getJobListData['minimum_experience']} Years",
                      style: mTextStyle13(mFontWeight: mFontWeight),
                      textAlign: TextAlign.center,
                    ),
    );
  }
}
