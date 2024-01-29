import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

class Profile_box_Widget extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  File? proflie_pic;

  Profile_box_Widget(
      {super.key,
      required this.firebaseUser,
      required this.userModel,
      this.proflie_pic});

  @override
  State<Profile_box_Widget> createState() => _Profile_box_WidgetState();
}

class _Profile_box_WidgetState extends State<Profile_box_Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          /// stack box height
          Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.textColorLightBlack)),
          ),

          // Box profile Image

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: _profileShow(widget.userModel),
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
                widget.userModel.user_name == null
                    ? Container(
                        child: Text("Name"),
                      )
                    : Text(
                        "${widget.userModel.user_name}".toUpperCase(),
                        style: mTextStyle19(
                            mFontWeight: FontWeight.w600,
                            mColor: AppColor.btnBgColorGreen),
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
                              color: AppColor.textColorLightBlack,
                            ),
                            widthSpacer(mWidth: 5),
                            Text(
                              "${widget.userModel.education}  | ",
                              style: mTextStyle13(
                                  mFontWeight: FontWeight.w600,
                                  mColor: AppColor.textColorLightBlack),
                            ),

                            // Course display

                            widget.userModel.course == null
                                ? Container()
                                : Text(
                                    "${widget.userModel.course}  | ",
                                    style: mTextStyle13(
                                        mFontWeight: FontWeight.w600,
                                        mColor: AppColor.textColorLightBlack),
                                  ),

                            // Course display
                            widget.userModel.passing_year == null
                                ? Container()
                                : Text(
                                    "${widget.userModel.passing_year}",
                                    style: mTextStyle13(
                                      mFontWeight: FontWeight.w600,
                                      mColor: AppColor.textColorLightBlack,
                                    ),
                                  ),
                          ],
                        ),
                      ),

                // Phone Number
                Spacer(),
                Icon_Text(
                  mIcon: Icons.phone,
                  mText: widget.userModel.phone,
                ),

                // Email Id
                heightSpacer(mHeight: 5),
                Icon_Text(
                  mIcon: Icons.email_outlined,
                  mText: widget.userModel.email ?? "",
                ),

                // Location
                heightSpacer(mHeight: 5),
                Icon_Text(
                  mIcon: Icons.location_on_outlined,
                  mText: widget.userModel.address ?? "",
                ),
              ],
            ),
          ),

          // Start QR Code
          Positioned(
            bottom: 0,
            right: 0,
            child: QrImageView(
              size: MediaQuery.of(context).size.width * 0.22,
              data:
                  "Name: ${widget.userModel.user_name}, Number: ${widget.userModel.phone}, Email: ${widget.userModel.email}, Address: ${widget.userModel.address}",
              version: QrVersions.auto,
            ),
          ),
        ],
      ),
    );
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
  _profileShow(UserModel userModel) {
    try {
      if (widget.proflie_pic != null) {
        return CircleAvatar(
          backgroundImage: FileImage(widget.proflie_pic!),
          radius: 28,
        );
      } else if (widget.userModel.profile_pic != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage("${widget.userModel.profile_pic}"),
          radius: 28,
        );
      } else {
        // If no profile picture is available, show a default avatar
        return CircleAvatar(
          backgroundColor: Color(0xffE7BDBDBD),
          radius: 28,
        );
      }
    } catch (ex) {
      log(ex.toString());
      // Handle the exception if necessary
      return CircleAvatar(
        backgroundColor: Color(0xffE7BDBDBD),
        radius: 28,
      );
    }
  }
}
