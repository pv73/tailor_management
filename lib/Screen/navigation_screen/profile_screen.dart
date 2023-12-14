import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/ui_Helper.dart';

class Profile_Screen extends StatefulWidget {
  @override
  State<Profile_Screen> createState() => _Profile_Screen();
}

class _Profile_Screen extends State<Profile_Screen> {
  late MediaQueryData mq;
  String? UserId;
  var allData;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Function to retrieve the UserId from shared preferences
  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserId = prefs.getString('UserId');
      allData = FirebaseFirestore.instance
          .collection('clients')
          .doc(UserId)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: UserId == null
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("loading"),
                        ],
                      ),
                    )
                  : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: allData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("Error : ${snapshot.hasError}");
                        } else {
                          // all data Store in userData from userId fields
                          var userData = snapshot.data?.data();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Start Profile Box
                              Card_Container_Widget(
                                padding: EdgeInsets.only(
                                    top: 10, right: 10, bottom: 10),
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
                                          child: userData?['profile_pic'] !=
                                                  null
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  backgroundImage: NetworkImage(
                                                      userData?['profile_pic']),
                                                  radius: 30,
                                                )
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/logo/programmer.png"),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "${userData?['user_name']}"
                                                    .toUpperCase(),
                                                style: mTextStyle19(
                                                    mFontWeight:
                                                        FontWeight.w600,
                                                    mColor: AppColor
                                                        .btnBgColorGreen),
                                              ),
                                            ),

                                            // Eduction
                                            heightSpacer(mHeight: 3),
                                            userData?['education'] == null
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
                                                          "${userData?['education']}  | ",
                                                          style: mTextStyle13(
                                                              mFontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),

                                                        // Course display

                                                        userData?['course'] ==
                                                                null
                                                            ? Container()
                                                            : Text(
                                                                "${userData?['course']}  | ",
                                                                style:
                                                                    mTextStyle13(
                                                                  mFontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),

                                                        // Course display
                                                        userData?['education_year'] ==
                                                                null
                                                            ? Container()
                                                            : Text(
                                                                "${userData?['education_year']}",
                                                                style:
                                                                    mTextStyle13(
                                                                  mFontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                                  child:
                                                      userData?['interest'] ==
                                                              null
                                                          ? Container()
                                                          : Wrap(
                                                              direction: Axis
                                                                  .horizontal,
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              // Align items to the start of the line
                                                              children:
                                                                  List.generate(
                                                                (userData?['interest']
                                                                        as List<
                                                                            dynamic>)
                                                                    .length,
                                                                (index) {
                                                                  return Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                4),
                                                                    child: Text(
                                                                      "${userData?['interest'][index]},",
                                                                      style:
                                                                          mTextStyle12(
                                                                        mFontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                ),
                                              ],
                                            ),

                                            // Phone Number
                                            heightSpacer(mHeight: 20),
                                            Icon_Text(
                                              mIcon: Icons.phone,
                                              mText: "${userData?['phone']}",
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
                                style:
                                    mTextStyle15(mFontWeight: FontWeight.w700),
                              ),

                              // Eduction
                              heightSpacer(),
                              Card_Container_Widget(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Education",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w700),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Highest education",
                                          style: mTextStyle13(),
                                        ),
                                        Text(
                                          "${userData?['education']}",
                                          style: mTextStyle13(),
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
                                      child: Text(
                                        "Total years of experience",
                                        style: mTextStyle13(),
                                      ),
                                    ),
                                    // Spacer(),
                                    Expanded(
                                      flex: 15,
                                      child: Text(
                                        "2 Year, 3 Months",
                                        style: mTextStyle13(
                                            mFontWeight: FontWeight.w700),
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
                                        style: mTextStyle13(
                                            mFontWeight: FontWeight.w700),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Person skills",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w700),
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
                                    userData?['skills'] == null
                                        ? Container()
                                        : Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            // Align items to the start of the line
                                            children: List.generate(
                                              (userData?['skills'] as List)
                                                  .length,
                                              (index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .textColorLightBlack)),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                                  margin: EdgeInsets.all(2),
                                                  child: Text(
                                                    "${userData?['skills'][index]}",
                                                    style: mTextStyle12(),
                                                  ),
                                                );
                                              },
                                            ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Category of tailor",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w700),
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
                                    userData?['category'] == null
                                        ? Container()
                                        : Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: AppColor
                                                        .textColorLightBlack)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8),
                                            margin: EdgeInsets.all(2),
                                            child: Text(
                                              "${userData?['category']}",
                                              style: mTextStyle12(),
                                            ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Language known",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w700),
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
                                    userData?['language_known'] == null
                                        ? Container(
                                            child: Text(
                                              "Update language",
                                              style: mTextStyle12(),
                                            ),
                                          )
                                        : Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            // Align items to the start of the line
                                            children: List.generate(
                                              (userData?['language_known']
                                                      as List)
                                                  .length,
                                              (index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .textColorLightBlack)),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                                  margin: EdgeInsets.all(2),
                                                  child: Text(
                                                    "${userData?['language_known'][index]}",
                                                    style: mTextStyle12(),
                                                  ),
                                                );
                                              },
                                            ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Our Details",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w700),
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
                                        text:
                                            "Name: ${userData?['user_name']}\n",
                                        style: mTextStyle12(),
                                        children: [
                                          //
                                          userData?['gender'] == null
                                              ? TextSpan(text: "Gender: \n")
                                              : TextSpan(
                                                  text:
                                                      "Gender: ${userData?['gender']}\n"),

                                          //
                                          userData?['dob'] == null
                                              ? TextSpan(text: "DOB: \n")
                                              : TextSpan(
                                                  text:
                                                      "DOB: ${userData?['dob']}\n"),

                                          //
                                          userData?['phone'] == null
                                              ? TextSpan(text: "Mobile: \n")
                                              : TextSpan(
                                                  text:
                                                      "Mobile: ${userData?['phone']}\n"),

                                          //
                                          userData?['email'] == null
                                              ? TextSpan(text: "Email: \n")
                                              : TextSpan(
                                                  text:
                                                      "Email: ${userData?['email']}\n"),

                                          //

                                          userData?['address'] == null
                                              ? TextSpan(text: "Address: \n")
                                              : TextSpan(
                                                  text:
                                                      "Address: ${userData?['address']}\n"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    )),
        ),
      ),
    );
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
