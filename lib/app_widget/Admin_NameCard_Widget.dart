import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_NameCard_Widget extends StatelessWidget {
  final User firebaseUser;
  final CompanyModel companyModel;
  final Color mTextColor;

  const Admin_NameCard_Widget(
      {super.key,
      required this.firebaseUser,
      required this.companyModel,
      required this.mTextColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${companyModel.user_name}".toUpperCase(),
                        style: mTextStyle19(
                          mFontWeight: FontWeight.w800,
                          mColor: mTextColor,
                        ),
                      ),
                    ),

                    // Email
                    heightSpacer(mHeight: 2),
                    Text(
                      "${companyModel.email}",
                      style: mTextStyle13(mColor: mTextColor),
                    ),

                    // Email
                    heightSpacer(mHeight: 3),
                    companyModel.gst_no == null
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                "GST No. ",
                                style: mTextStyle13(
                                    mFontWeight: FontWeight.w600,
                                    mColor: mTextColor),
                              ),
                              Expanded(
                                child: Text(
                                  "${companyModel.gst_no}",
                                  style: mTextStyle13(mColor: mTextColor),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: companyModel.company_logo != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 30,
                          backgroundImage:
                              NetworkImage("${companyModel.company_logo}"),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 30,
                          child: Text(
                            getInitials("${companyModel.user_name}"),
                            style: mTextStyle24(mFontWeight: FontWeight.w700),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),

        // Number and Address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "Mobile No: ",
                      style: mTextStyle13(
                          mFontWeight: FontWeight.w600, mColor: mTextColor),
                      children: [
                        TextSpan(
                          text: "${companyModel.phone}",
                          style: mTextStyle13(mColor: mTextColor),
                        )
                      ],
                    ),
                  ),
                ),
                widthSpacer(mWidth: 5),
                companyModel.company_number != null
                    ? Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Phone No: ",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w600,
                                mColor: mTextColor),
                            children: [
                              TextSpan(
                                text: "${companyModel.company_number}",
                                style: mTextStyle13(mColor: mTextColor),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),

            /// Address
            heightSpacer(mHeight: 3),
            Row(
              children: [
                Text(
                  "Address: ",
                  style: mTextStyle13(
                      mFontWeight: FontWeight.w600, mColor: mTextColor),
                ),
                Expanded(
                  child: Text(
                    "${companyModel.address}",
                    style: mTextStyle13(mColor: mTextColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  /// this code get name word's first letter
  /// like Mukesh Kumar then get MK
  String getInitials(String name) {
    List<String> nameParts = name.split(" "); // Split the name into parts
    String initials = "";

    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0]; // Get the first letter of each non-empty part
      }
    }

    return initials;
  }
}
