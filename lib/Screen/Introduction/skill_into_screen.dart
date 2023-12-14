import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/bank_into_screen.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_Helper.dart';

class Skills_Into_Screen extends StatefulWidget {
  @override
  State<Skills_Into_Screen> createState() => _Skills_Into_ScreenState();
}

class _Skills_Into_ScreenState extends State<Skills_Into_Screen> {
  List<String> selectedSkills = [];

  String? UserId;

  // For Image
  File? profile_pic;
  double upload_Percentage = 0.0;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number Indicator Row
                Row(
                  children: [
                    // 1st number
                    Intro_Number_Widget(number: 1, name: "About"),
                    Expanded(
                      child: Divider(color: AppColor.cardBtnBgGreen),
                    ),

                    // 2nd Number
                    Intro_Number_Widget(number: 2, name: "Education"),
                    Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                    // 3rd Number
                    Intro_Number_Widget(number: 3, name: "Interest"),
                    Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                    // 4th Number
                    Intro_Number_Widget(
                        number: 4, name: "Skills", active_no: 4),
                  ],
                ),

                Divider(height: 35),

                // Start Profile Box
                UserId == null
                    ? Center(child: CircularProgressIndicator())
                    : Profile_box_Widget(
                        UserId: UserId, proflie_pic: profile_pic),

                // Skills Details
                heightSpacer(mHeight: 20),
                Text(
                  "Personal Skills",
                  style: mTextStyle19(
                      mColor: AppColor.textColorBlack,
                      mFontWeight: FontWeight.w700),
                ),

                /// Interest Button
                heightSpacer(mHeight: 10),
                GroupButton(
                  options: mGroupButtonOptions(),
                  isRadio: false,
                  buttons: [
                    "Single Needle Operator",
                    "Feedup Machine Operator",
                    "Cutting Machine Operator",
                    "Consie Machine Operator",
                    "Bartack Machine Operator",
                    "Flatlock Operator",
                    "Overlock Operator",
                    "Other"
                  ],
                  onSelected: (skills_btn_name, index, isSelected) {
                    if (isSelected) {
                      selectedSkills.add(skills_btn_name);
                    } else {
                      selectedSkills.remove(skills_btn_name);
                    }

                    print(selectedSkills);
                  },
                ),

                // Profile Photo Update
                heightSpacer(mHeight: 20),
                Text(
                  "Upload Photo",
                  style: mTextStyle19(
                      mColor: AppColor.textColorBlack,
                      mFontWeight: FontWeight.w700),
                ),

                /// Profile Photo details
                heightSpacer(mHeight: 10),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      heightSpacer(mHeight: 10),
                      Container(
                        child: Text(
                          "Upload Profile Photo from our File \n Manager and  Gallery",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      upload_Percentage == 0.0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GFProgressBar(
                                percentage: upload_Percentage == 0.0
                                    ? 0.0
                                    : upload_Percentage / 100,
                                lineHeight: 15,
                                radius: 100,
                                backgroundColor: Colors.black38,
                                progressBarColor: Colors.green,
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          // _pickImageFromGallery();
                          showBottomSheet();
                        },
                        child: Container(
                          height: 170,
                          child: Lottie.asset(
                              "assets/images/lottie_animation/upload_photo.json"),
                        ),
                      ),
                      heightSpacer(mHeight: 35),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Submit bottom Sheet bottom Sheet Btn
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Rounded_Btn_Widget(
            title: "Submit",
            btnBgColor: AppColor.btnBgColorGreen,
            borderColor: AppColor.btnBgColorGreen,
            onPress: () {
              _uploadProfile();
            },
            mHeight: 40,
            mAlignment: Alignment.center,
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // ================== UI end and  Widget and list Start ==================

  Future<void> showBottomSheet() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 90,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 35,
                        ),
                        Text("Camera")
                      ],
                    ),
                  ),
                  widthSpacer(mWidth: 50),
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 35,
                        ),
                        Text("Gallery")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //
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
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  // ========================================================================
  // ================== Image Picker ==================

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        profile_pic = tempImage;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  //=================================
  // Upload Document
  //
  void _uploadProfile() async {
    // Store Firebase Storage. first create folder which is name document then
    // Store file

    try {
      var skills_page;
      if (profile_pic != null && selectedSkills.isNotEmpty) {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child("documents")
            .child(UserId!)
            .putFile(profile_pic!);

        // this get how many % upload
        uploadTask.snapshotEvents.listen((snapshot) {
          double percentage =
              snapshot.bytesTransferred / snapshot.totalBytes * 100;
          setState(() {
            upload_Percentage = percentage;
          });

          log(upload_Percentage.toString());
        });

        //
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        skills_page = {
          'skills': selectedSkills.isEmpty
              ? null
              : FieldValue.arrayUnion(selectedSkills),
          "profile_pic": downloadUrl,
        };
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            content: Center(child: Text("Plz. Select min. 1 filed")),
          ),
        );
      }

      // Update user profile in Firestore
      FirebaseFirestore.instance
          .collection('clients')
          .doc(UserId)
          .update(skills_page);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Bank_Into_Screen(),
        ),
      );
    } catch (ex) {
      log(ex.toString());
    }
  }
}
