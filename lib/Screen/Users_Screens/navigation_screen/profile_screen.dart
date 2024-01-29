import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

class Profile_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Profile_Screen(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Profile_Screen> createState() => _Profile_Screen();
}

class _Profile_Screen extends State<Profile_Screen> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leadingWidth: 25,
        title: RichText(
          text: TextSpan(text: "Tailor ", style: mTextStyle20(), children: [
            TextSpan(
                text: "Profile",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
        ],
      ),
      drawer: Drawer_Widget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start Profile Box
                Card_Container_Widget(
                  padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
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
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: NetworkImage(
                                  "${widget.userModel.profile_pic}"),
                              radius: 30,
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
                                  "${widget.userModel.user_name}".toUpperCase(),
                                  style: mTextStyle19(
                                      mFontWeight: FontWeight.w600,
                                      mColor: AppColor.btnBgColorGreen),
                                ),
                              ),

                              // Eduction
                              heightSpacer(mHeight: 3),
                              widget.userModel.education == null
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
                                            "${widget.userModel.education}  | ",
                                            style: mTextStyle13(
                                                mFontWeight: FontWeight.w500),
                                          ),

                                          // Course display

                                          widget.userModel.course == null
                                              ? Container()
                                              : Text(
                                                  "${widget.userModel.course}  | ",
                                                  style: mTextStyle13(
                                                    mFontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),

                                          // Course display
                                          widget.userModel.passing_year == null
                                              ? Container()
                                              : Text(
                                                  "${widget.userModel.passing_year}",
                                                  style: mTextStyle13(
                                                    mFontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),

                              // Skill
                              heightSpacer(mHeight: 3),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Icon(
                                      Icons.streetview,
                                      size: 14,
                                    ),
                                  ),
                                  widthSpacer(mWidth: 5),
                                  Expanded(
                                    flex: 30,
                                    child: widget.userModel.interest == null
                                        ? Container()
                                        : Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            // Align items to the start of the line
                                            children:
                                                (widget.userModel.interest ??
                                                        [])
                                                    .map((interest) {
                                              return Container(
                                                padding:
                                                    EdgeInsets.only(right: 4),
                                                child: Text(
                                                  "${interest},",
                                                  style: mTextStyle12(
                                                    mFontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                  ),
                                ],
                              ),

                              // Phone Number
                              heightSpacer(mHeight: 20),
                              Icon_Text(
                                mIcon: Icons.phone,
                                mText: "${widget.userModel.phone}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //
                heightSpacer(mHeight: 30),
                Text(
                  "About me",
                  style: mTextStyle15(mFontWeight: FontWeight.w700),
                ),

                // Eduction
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Education",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ Add",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w700,
                                mColor: AppColor.cardBtnBgGreen),
                          ),
                        ],
                      ),
                      heightSpacer(mHeight: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Highest education",
                            style: mTextStyle13(),
                          ),
                          Text(
                            "${widget.userModel.education}",
                            style: mTextStyle13(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Eduction
                heightSpacer(mHeight: 10),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 11,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.userModel.education}",
                                        style: mTextStyle17(
                                            mFontWeight: FontWeight.w800),
                                      ),
                                      widget.userModel.course == null
                                          ? Text("")
                                          : Text(
                                              ", ${widget.userModel.course}",
                                              style: mTextStyle17(
                                                  mFontWeight: FontWeight.w800),
                                            ),
                                    ],
                                  ),
                                  heightSpacer(mHeight: 2),
                                  Text(
                                    capitalize(
                                        "${widget.userModel.collage_name}"),
                                    style: mTextStyle13(
                                        mFontWeight: FontWeight.w400,
                                        mColor: AppColor.textColorLightBlack),
                                  ),
                                  heightSpacer(mHeight: 7),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColor
                                                  .textColorLightBlack)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 8),
                                      margin: EdgeInsets.all(2),
                                      child: Text(
                                        "Batch of ${widget.userModel.passing_year}",
                                        style: mTextStyle11(),
                                      ))
                                ],
                              )),
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: AppColor.btnBgColorGreen,
                                    size: 13,
                                  ),
                                  widthSpacer(mWidth: 4),
                                  Text(
                                    "Edit",
                                    style: mTextStyle13(
                                        mFontWeight: FontWeight.w700,
                                        mColor: AppColor.cardBtnBgGreen),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Experience
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 17,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total years of experience",
                              style: mTextStyle13(mFontWeight: FontWeight.w700),
                            ),
                            heightSpacer(mHeight: 2),
                            Text(
                              capitalize(
                                  "${widget.userModel.experience_company}"),
                              style: mTextStyle13(
                                  mFontWeight: FontWeight.w400,
                                  mColor: AppColor.textColorLightBlack),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      Expanded(
                        flex: 15,
                        child: Text(
                          "2 Years, 3 Months",
                          style: mTextStyle13(mFontWeight: FontWeight.w700),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      widthSpacer(mWidth: 5),
                      Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.btnBgColorGreen,
                          size: 13,
                        ),
                      )
                    ],
                  ),
                ),

                // Salary
                heightSpacer(),
                Card_Container_Widget(
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
                          "INR 15,000",
                          style: mTextStyle13(mFontWeight: FontWeight.w700),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      widthSpacer(mWidth: 5),
                      Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.btnBgColorGreen,
                          size: 13,
                        ),
                      )
                    ],
                  ),
                ),

                /// Skills Button
                heightSpacer(mHeight: 10),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Person skills",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ Add",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w700,
                                mColor: AppColor.cardBtnBgGreen),
                          ),
                        ],
                      ),

                      /// Skills filed
                      heightSpacer(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        // Align items to the start of the line
                        children: (widget.userModel.skills ?? []).map((skills) {
                          return Container(
                            padding: EdgeInsets.only(right: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: AppColor.textColorLightBlack)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              margin: EdgeInsets.all(2),
                              child: Text(
                                "${skills}",
                                style: mTextStyle11(
                                  mFontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                /// Category of tailor
                heightSpacer(mHeight: 10),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category of tailor",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ Add",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w700,
                                mColor: AppColor.cardBtnBgGreen),
                          ),
                        ],
                      ),
                      heightSpacer(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        // Align items to the start of the line
                        children:
                            (widget.userModel.category ?? []).map((category) {
                          return Container(
                            padding: EdgeInsets.only(right: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: AppColor.textColorLightBlack)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              margin: EdgeInsets.all(2),
                              child: Text(
                                "${category}",
                                style: mTextStyle12(
                                  mFontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                /// Language Known
                heightSpacer(mHeight: 10),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Language known",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ Add",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w700,
                                mColor: AppColor.cardBtnBgGreen),
                          ),
                        ],
                      ),
                      heightSpacer(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        // Align items to the start of the line
                        children:
                            (widget.userModel.language ?? []).map((language) {
                          return Container(
                            padding: EdgeInsets.only(right: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: AppColor.textColorLightBlack)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              margin: EdgeInsets.all(2),
                              child: Text(
                                "${language}",
                                style: mTextStyle12(
                                  mFontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                /// Details
                heightSpacer(mHeight: 10),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Details",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "+ Add",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w700,
                                mColor: AppColor.cardBtnBgGreen),
                          ),
                        ],
                      ),
                      heightSpacer(),
                      RichText(
                        text: TextSpan(
                          text: "Name: ${widget.userModel.user_name}\n",
                          style: mTextStyle12(),
                          children: [
                            //
                            widget.userModel.gender == null
                                ? TextSpan(text: "Gender: \n")
                                : TextSpan(
                                    text:
                                        "Gender: ${widget.userModel.gender}\n"),

                            //
                            widget.userModel.dob == null
                                ? TextSpan(text: "DOB: \n")
                                : TextSpan(
                                    text: "DOB: ${widget.userModel.dob}\n"),

                            //
                            widget.userModel.phone == null
                                ? TextSpan(text: "Mobile: \n")
                                : TextSpan(
                                    text:
                                        "Mobile: ${widget.userModel.phone}\n"),

                            //
                            widget.userModel.email == null
                                ? TextSpan(text: "Email: \n")
                                : TextSpan(
                                    text: "Email: ${widget.userModel.email}\n"),

                            //

                            widget.userModel.address == null
                                ? TextSpan(text: "Permanent Address: \n")
                                : TextSpan(
                                    text:
                                        "Permanent Address: ${widget.userModel.permanent_address}\n"),

                            widget.userModel.address == null
                                ? TextSpan(text: "Address: \n")
                                : TextSpan(
                                    text:
                                        "Address: ${widget.userModel.address}\n"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO : =====================================
  //  TextCapitalization
  String capitalize(String input) {
    return input
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }

//================================================================
// ================= UI design end  ===========================

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
}
