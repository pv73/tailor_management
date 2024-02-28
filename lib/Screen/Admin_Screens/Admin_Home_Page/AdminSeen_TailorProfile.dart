import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor/ui_helper.dart';

class AdminSeen_TailorProfile_Screen extends StatelessWidget {
  final String? getUserId;

  AdminSeen_TailorProfile_Screen({this.getUserId});

  FirebaseFirestore _Firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    log(getUserId.toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 37,
                width: 37,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFBDBDBD))),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 15,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Tailor Details",
                style: mTextStyle17(mFontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 37,
              width: 37,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFBDBDBD))),
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 15,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _Firebase.collection("clients").doc(getUserId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/images/lottie_animation/loading-2.json", width: 80),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final tailorData = snapshot.data!.data();
              return Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ===========  Start Profile Box ===========
                      Card_Container_Widget(
                        padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                        mBorderColor: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      backgroundImage: NetworkImage("${tailorData!['profile_pic']}"),
                                      radius: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${tailorData['user_name']}".toUpperCase(),
                                        style: mTextStyle19(mFontWeight: FontWeight.w600, mColor: AppColor.btnBgColorGreen),
                                      ),
                                    ),

                                    Text(
                                      "${tailorData['email']}",
                                      style: mTextStyle13(),
                                    ),

                                    // =========== Eduction ================
                                    heightSpacer(mHeight: 3),
                                    tailorData['education'] == null
                                        ? Container()
                                        : FittedBox(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.book_outlined,
                                                  size: 14,
                                                ),
                                                widthSpacer(mWidth: 5),
                                                Text(
                                                  "${tailorData['education']}  | ",
                                                  style: mTextStyle13(mFontWeight: FontWeight.w500),
                                                ),

                                                //========= Course display=================

                                                tailorData['course'] == null
                                                    ? Container()
                                                    : Text(
                                                        "${tailorData['course']}  | ",
                                                        style: mTextStyle13(
                                                          mFontWeight: FontWeight.w500,
                                                        ),
                                                      ),

                                                //======= Course display =============
                                                tailorData['passing_year'] == null
                                                    ? Container()
                                                    : Text(
                                                        "${tailorData['passing_year']}",
                                                        style: mTextStyle13(
                                                          mFontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),

                                    // Phone Number
                                    heightSpacer(mHeight: 20),
                                    Icon_Text(
                                      mIcon: Icons.phone,
                                      mText: "${tailorData['phone']}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ======== Eduction fields =============
                      Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Highest education",
                                  style: mTextStyle13(),
                                ),
                                Text(
                                  "${tailorData['education']}",
                                  style: mTextStyle13(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //  ======== Eduction field Show  ======
                      heightSpacer(mHeight: 10),
                      Card_Container_Widget(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ======= Education name, branch =======
                            RichText(
                              text: TextSpan(
                                text: "${tailorData['education']}",
                                style: mTextStyle16(mFontWeight: FontWeight.w800),
                                children: [
                                  TextSpan(
                                    text: tailorData['course'] == null ? "" : ", ${tailorData['course']}",
                                    style: mTextStyle16(mFontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),

                            // ======== Collage Name and year ===========
                            heightSpacer(mHeight: 2),
                            Text(
                              capitalize("${tailorData['collage_name']}"),
                              style: mTextStyle13(mFontWeight: FontWeight.w400, mColor: AppColor.textColorLightBlack),
                            ),
                            heightSpacer(mHeight: 7),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.navBgColor)),
                              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                              margin: EdgeInsets.all(2),
                              child: Text(
                                "Batch of ${tailorData['passing_year']}",
                                style: mTextStyle11(),
                              ),
                            )
                          ],
                        ),
                      ),

                      //======== Experience ===============
                      tailorData['totalExpYears'] == null && tailorData['totalExpMonths'] == null
                          ? Container()
                          : Card_Container_Widget(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 17,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Experience",
                                          style: mTextStyle13(mFontWeight: FontWeight.w700),
                                        ),
                                        heightSpacer(mHeight: 5),
                                        Text(
                                          capitalize("${tailorData['experience_company']}"),
                                          style: mTextStyle13(mFontWeight: FontWeight.w400, mColor: AppColor.textColorLightBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Spacer(),

                                  Expanded(
                                    flex: 15,
                                    child: Text(
                                      "${tailorData['totalExpYears']} Years, ${tailorData['totalExpMonths']} Months",
                                      style: mTextStyle13(mFontWeight: FontWeight.w700),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      //========== Salary==============
                      Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 27,
                              child: Text(
                                "Current monthly salary",
                                style: mTextStyle13(),
                              ),
                            ),
                            // Spacer(),
                            Expanded(
                              flex: 12,
                              child: Text(
                                tailorData['salary'] == null ? "" : "INR ${tailorData['salary']}",
                                style: mTextStyle13(mFontWeight: FontWeight.w700),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //========== Job Type ==============
                      Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Visibility(
                                visible: (tailorData['garment_category'] != null && tailorData['garment_category'].isNotEmpty),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Garment category",
                                      style: mTextStyle13(mFontWeight: FontWeight.w700),
                                    ),
                                    // Display garment_category if available
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        tailorData['garment_category'] != null ? tailorData['garment_category'].join(", ") : '',
                                        style: mTextStyle13(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // ======== Tailor job type =============
                            Text(
                              "Tailor job type",
                              style: mTextStyle13(mFontWeight: FontWeight.w700),
                            ),
                            heightSpacer(mHeight: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Job type",
                                    style: mTextStyle13(),
                                  ),
                                ),
                                // Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${tailorData['job_type']}",
                                    style: mTextStyle13(mFontWeight: FontWeight.w700),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),

                            // ====== Only view Category of Tailor ============
                            Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Category of tailor",
                                    style: mTextStyle13(mFontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      tailorData['category'] != null ? tailorData['category'].join(", ") : 'No category available',
                                      style: mTextStyle13(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      /// ===========  Department of Interest ===============
                      heightSpacer(),
                      Card_Container_Widget(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Department of Interest",
                              style: mTextStyle13(mFontWeight: FontWeight.w700),
                            ),

                            /// =========== Edit Department of Interest ============
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                tailorData['interest'] != null ? tailorData['interest'].join(", ") : 'No interest available',
                                style: mTextStyle13(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ===========  Skills and Language ===============
                      Card_Container_Widget(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal skills",
                              style: mTextStyle13(mFontWeight: FontWeight.w700),
                            ),

                            /// =========== Edit Skills filed ============
                            Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Text(
                                tailorData['skills'] != null ? tailorData['skills'].join(", ") : 'No skills available',
                                style: mTextStyle13(),
                              ),
                            ),

                            /// ================ Language Known ==================
                            heightSpacer(),
                            Visibility(
                              visible: (tailorData['language'] != null && tailorData['language'].isNotEmpty),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Language known",
                                    style: mTextStyle13(mFontWeight: FontWeight.w700),
                                  ),
                                  // Display languages if available
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                      tailorData['language'] != null ? tailorData['language'].join(", ") : '',
                                      style: mTextStyle13(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      /// ============ Tailor Group =================
                      Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tailor type and line leader's name",
                              style: mTextStyle13(mFontWeight: FontWeight.w500),
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Bank_Row(
                                    mTitle: "Our type",
                                    mText: "${tailorData['tailor_type']}",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7),
                                  child: Bank_Row(
                                    mTitle: "Line leader's name",
                                    mText: tailorData['line_leader_name'] == null ? "" : "${tailorData['line_leader_name']}",
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      /// ============= Our Details ==============
                      heightSpacer(),
                      Card_Container_Widget(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Our Details",
                              style: mTextStyle13(mFontWeight: FontWeight.w700),
                            ),
                            heightSpacer(),
                            RichText(
                              text: TextSpan(
                                text: "Name: ${tailorData['user_name']}\n",
                                style: mTextStyle12(),
                                children: [
                                  //
                                  tailorData['gender'] == null
                                      ? TextSpan(text: "Gender: \n")
                                      : TextSpan(text: "Gender: ${tailorData['gender']}\n"),

                                  //
                                  tailorData['dob'] == null
                                      ? TextSpan(text: "DOB: \n")
                                      : TextSpan(text: "DOB: ${tailorData['dob']}\n"),

                                  //
                                  tailorData['phone'] == null
                                      ? TextSpan(text: "Mobile: \n")
                                      : TextSpan(text: "Mobile: ${tailorData['phone']}\n"),

                                  //
                                  tailorData['email'] == null
                                      ? TextSpan(text: "Email: \n")
                                      : TextSpan(text: "Email: ${tailorData['email']}\n"),

                                  //
                                  tailorData['address'] == null
                                      ? TextSpan(text: "Permanent Address: \n")
                                      : TextSpan(text: "Permanent Address: ${tailorData['permanent_address']}\n"),

                                  tailorData['address'] == null
                                      ? TextSpan(text: "Address: \n")
                                      : TextSpan(text: "Address: ${tailorData['address']}\n"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // ================= UI design end  ===========================
  //  TextCapitalization
  String capitalize(String input) {
    return input
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join(' ');
  }

  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle12(mFontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ============ bank Row Widget ===============
  Widget Bank_Row({mTitle, mText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${mTitle}",
          style: mTextStyle13(),
        ),
        Expanded(
          child: Text(
            "${mText}",
            style: mTextStyle13(mFontWeight: FontWeight.w700),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
