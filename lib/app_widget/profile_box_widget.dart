import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/ui_Helper.dart';

class Profile_box_Widget extends StatefulWidget {
  String? UserId;
  File? proflie_pic;

  Profile_box_Widget({this.UserId, this.proflie_pic});

  @override
  State<Profile_box_Widget> createState() => _Profile_box_WidgetState();
}

class _Profile_box_WidgetState extends State<Profile_box_Widget> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userData;

  @override
  void initState() {
    super.initState();

    userData = getUserData(widget.UserId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.hasError}");
          } else {
            //
            // all data Store in userData from userId fields
            var userData = snapshot.data?.data();
            return Container(
              child: Stack(
                children: [

                  /// stack box height
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                        Border.all(color: AppColor.textColorLightBlack)),
                  ),

                  // Box profile Image

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: _profileShow(userData),
                    ),
                  ),

                  // Box all Text Details
                  Container(
                    alignment: Alignment.topLeft,
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: EdgeInsets.only(left: 65),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userData?['user_name'] == null
                              ? " "
                              : "${userData?['user_name']}".toUpperCase(),
                          style: mTextStyle19(
                              mFontWeight: FontWeight.w600,
                              mColor: AppColor.btnBgColorGreen),
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
                                color: AppColor.textColorLightBlack,
                              ),
                              widthSpacer(mWidth: 5),
                              Text(
                                "${userData?['education']}  | ",
                                style: mTextStyle13(
                                    mFontWeight: FontWeight.w600,
                                    mColor: AppColor.textColorLightBlack),
                              ),

                              // Course display

                              userData?['course'] == null
                                  ? Container()
                                  : Text(
                                "${userData?['course']}  | ",
                                style: mTextStyle13(
                                    mFontWeight: FontWeight.w600,
                                    mColor: AppColor
                                        .textColorLightBlack),
                              ),

                              // Course display
                              userData?['education_year'] == null
                                  ? Container()
                                  : Text(
                                "${userData?['education_year']}",
                                style: mTextStyle13(
                                    mFontWeight: FontWeight.w600,
                                    mColor: AppColor
                                        .textColorLightBlack),
                              ),
                            ],
                          ),
                        ),


                        // Phone Number
                        Spacer(),
                        Icon_Text(
                          mIcon: Icons.phone,
                          mText: userData?['phone'] == null
                              ? " "
                              : "${userData?['phone']}",
                        ),

                        // Email Id
                        heightSpacer(mHeight: 5),
                        Icon_Text(
                          mIcon: Icons.email_outlined,
                          mText: userData?['email'] == null
                              ? " "
                              : "${userData?['email']}",
                        ),

                        // Location
                        heightSpacer(mHeight: 5),
                        Icon_Text(
                          mIcon: Icons.location_on_outlined,
                          mText: userData?['address'] == null
                              ? " "
                              : "${userData?['address']}",
                        ),
                      ],
                    ),
                  ),

                  // Start QR Code
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: QrImageView(
                      size: MediaQuery
                          .of(context)
                          .size
                          .width * 0.22,
                      data:
                      "Name: '${userData?['user_name']}', Number: '${userData?['phone']}', Email: '${userData?['email']}', Address: '${userData?['address']}'",
                      version: QrVersions.auto,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  // ==========================================
  // =============================================
  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
            color: AppColor.textColorLightBlack,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle13(
                  mFontWeight: FontWeight.w600,
                  mColor: AppColor.textColorLightBlack),
              maxLines: 1,
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  /// Profile Pic Show Function
  _profileShow(Map<String, dynamic>? userData) {
    try {
      if ((userData?['profile_pic'] != null)) {
        return CircleAvatar(
          backgroundImage: NetworkImage(userData?['profile_pic']),
          radius: 28,
        );
      } else {
        return (widget.proflie_pic != null)
            ? CircleAvatar(
          backgroundImage: FileImage(widget.proflie_pic!),
          radius: 28,
        )
            : CircleAvatar(
          backgroundColor: Color(0xffE7BDBDBD),
          radius: 28,
        );
      }
    } catch (ex) {
      log(ex.toString());
    }
  }
}
