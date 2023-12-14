import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/ui_helper.dart';

class Job_Referral_Details extends StatelessWidget {
  var index;

  Job_Referral_Details({required this.index});

  @override
  Widget build(BuildContext context) {
    // client_data list all data store in client_Index by using Index
    var client_Index = clients_data[index];
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.navBgColor, Color.fromARGB(255, 21, 236, 229)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leadingWidth: 23,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            "Get a job referral from peers from tailor management",
            style: mTextStyle15(mColor: AppColor.textColorWhite),
            textAlign: TextAlign.start,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.textColorWhite),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          client_Index['profile_pic'] != null
                              ? CircularPercentIndicator(
                                  radius: 51.0,
                                  lineWidth: 10,
                                  percent: 0.4,
                                  progressColor: Colors.green,
                                  center: CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                        "${client_Index['profile_pic']}"),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 45,
                                  backgroundColor: AppColor.navBgColor,
                                  child: Text(
                                    "${getInitials(client_Index['user_name'].toUpperCase())}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                          // name
                          heightSpacer(),
                          Text(
                            "${client_Index['user_name']}",
                            style: mTextStyle19(
                                mColor: AppColor.navBgColor,
                                mFontWeight: FontWeight.w700),
                          ),

                          // skills and experience company name
                          buildSkills(client_Index['skills'], client_Index),

                          // About Clients
                          heightSpacer(mHeight: 20),
                          Card_Container_Widget(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About ${client_Index['user_name']}",
                                  style: mTextStyle13(
                                      mFontWeight: FontWeight.w500,
                                      mColor: AppColor.textColorLightBlack,
                                      letterSpacing: 0.2),
                                ),

                                // Experience Company Name
                                heightSpacer(mHeight: 15),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 18,
                                      color: AppColor.textColorLightBlack,
                                    ),
                                    widthSpacer(),
                                    RichText(
                                      text: TextSpan(
                                        text: "Worked at ",
                                        style: mTextStyle13(
                                            mColor:
                                                AppColor.textColorLightBlack,
                                            mFontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${client_Index['experience_company']}",
                                            style: mTextStyle13(
                                                mFontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                // Known Language
                                heightSpacer(mHeight: 15),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.translate_sharp,
                                      size: 18,
                                      color: AppColor.textColorLightBlack,
                                    ),
                                    widthSpacer(),
                                    RichText(
                                      text: TextSpan(
                                          text: "Speaks ",
                                          style: mTextStyle13(
                                              mColor:
                                                  AppColor.textColorLightBlack,
                                              mFontWeight: FontWeight.w500),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${client_Index['language']}",
                                                style: mTextStyle13(
                                                    mFontWeight:
                                                        FontWeight.w600))
                                          ]),
                                    )
                                  ],
                                ),

                                // Studied collage Name
                                heightSpacer(mHeight: 15),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book,
                                      size: 18,
                                      color: AppColor.textColorLightBlack,
                                    ),
                                    widthSpacer(),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Studied ",
                                          style: mTextStyle13(
                                              mColor:
                                                  AppColor.textColorLightBlack,
                                              mFontWeight: FontWeight.w500),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${client_Index['education']}",
                                              style: mTextStyle13(
                                                  mFontWeight: FontWeight.w600),
                                            ),
                                            client_Index['course'] == null
                                                ? TextSpan(text: "")
                                                : TextSpan(
                                                    text:
                                                        " in ${client_Index['course']} ",
                                                    style: mTextStyle13(
                                                        mFontWeight:
                                                            FontWeight.w600),
                                                  ),
                                            TextSpan(text: " from "),
                                            TextSpan(
                                              text:
                                                  "${client_Index['collage_name']}",
                                              style: mTextStyle13(
                                                  mFontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Clients Skills
                          heightSpacer(mHeight: 15),
                          Card_Container_Widget(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${client_Index['user_name']}'s Skills",
                                  style: mTextStyle13(
                                      mFontWeight: FontWeight.w500,
                                      mColor: AppColor.textColorLightBlack,
                                      letterSpacing: 0.2),
                                ),

                                // Skills
                                heightSpacer(mHeight: 15),
                                client_Index['skills'] == null
                                    ? Container()
                                    : Wrap(
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.start,
                                        children: List.generate(
                                          (client_Index['skills']
                                                  as List<dynamic>)
                                              .length,
                                          (index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 9, right: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4, vertical: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade400)),
                                              child: Text(
                                                "${client_Index['skills'][index]}",
                                                style: mTextStyle12(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),

                          // Clients Interest
                          heightSpacer(mHeight: 15),
                          Card_Container_Widget(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${client_Index['user_name']}'s Interest",
                                  style: mTextStyle13(
                                      mFontWeight: FontWeight.w500,
                                      mColor: AppColor.textColorLightBlack,
                                      letterSpacing: 0.2),
                                ),

                                // Skills
                                heightSpacer(mHeight: 15),
                                client_Index['interest'] == null
                                    ? Container()
                                    : Wrap(
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.start,
                                        children: List.generate(
                                          (client_Index['interest']
                                                  as List<dynamic>)
                                              .length,
                                          (inter_Index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 9, right: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4, vertical: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade400)),
                                              child: Text(
                                                "${client_Index['interest'][inter_Index]}",
                                                style: mTextStyle12(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Button
                    heightSpacer(mHeight: 30),
                    Rounded_Btn_Widget(
                      onPress: () {},
                      borderRadius: 10,
                      mAlignment: Alignment.center,
                      mIcon: Icons.message,
                      iconColor: AppColor.textColorWhite,
                      title: "Ask for referral",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  //          Skills build
  Widget buildSkills(List<dynamic> skills, client_Index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: List.generate(
          skills.length > 1 ? 1 : skills.length,
          (index) {
            return Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 4),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "${skills[index]},",
                      style: mTextStyle14(mFontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: " at ${client_Index['experience_company']}",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
