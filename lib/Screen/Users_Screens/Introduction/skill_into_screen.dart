import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_progress_type.dart';
import 'package:group_button/group_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/bank_into_screen.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/modal/UserModel.dart';

import '../../../ui_helper.dart';

class Skills_Into_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Skills_Into_Screen({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Skills_Into_Screen> createState() => _Skills_Into_ScreenState();
}

class _Skills_Into_ScreenState extends State<Skills_Into_Screen> {
  List<String> selectedSkills = [];

  // For Image
  File? profile_pic;
  String? profilePicName;
  double upload_Percentage = 0.0;
  bool isLodding = false;
  String? profilePicError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          children: [
            // 1st number
            Intro_Number_Widget(
              number: 1,
              name: "About",
            ),
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
              number: 4,
              name: "Skills",
              active_no: 4,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start Profile Box
                Profile_box_Widget(
                  firebaseUser: widget.firebaseUser,
                  userModel: widget.userModel,
                  proflie_pic: profile_pic,
                ),

                /// ========== Skills Button ============
                heightSpacer(mHeight: 20),
                RichText(
                  text: TextSpan(text: "Personal Skills", style: mTextStyle17(mFontWeight: FontWeight.w600), children: [
                    TextSpan(
                      text: " *",
                      style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                    )
                  ]),
                ),

                heightSpacer(mHeight: 10),
                GroupButton(
                  options: mGroupButtonOptions(),
                  isRadio: false,
                  buttons: [
                    "Single Needle Operator",
                    "Feedup Machine Operator",
                    "Cutting Machine Operator",
                    "Flatlock Operator",
                    "Consie Machine Operator",
                    "Overlock Operator",
                    "Bartack Machine Operator",
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

                ///========== Profile Photo details ===============
                heightSpacer(mHeight: 20),
                RichText(
                  text: TextSpan(text: "Upload Photo", style: mTextStyle17(mFontWeight: FontWeight.w600), children: [
                    TextSpan(
                      text: " *",
                      style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                    )
                  ]),
                ),


                heightSpacer(mHeight: 10),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      heightSpacer(mHeight: 5),
                      Container(
                        child: Text(
                          "Upload Profile Photo from our File \n Manager and  Gallery",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Image_Picker_showBottomSheet(
                            context,
                            fromCameraPress: (){
                               pickImage(ImageSource.camera);
                            },
                            fromGalleryPress: (){
                               pickImage(ImageSource.gallery);
                            },
                          );
                        },
                        child: Container(
                          height: 140,
                          child: Lottie.asset("assets/images/lottie_animation/upload_photo.json"),
                        ),

                      ),

                       profilePicError == null ? Container() : Padding(
                         padding: const EdgeInsets.only(bottom: 15),
                         child: Text("${profilePicError}", style: mTextStyle13(mColor: Colors.red),),
                       ),
                    ],
                  ),
                ),

                //=========== Submit button====================
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is UserLoadedState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bank_Into_Screen(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                        ),
                      );
                    } else if (state is UserErrorState) {
                      showSnackBar_Widget(context, mHeading: "Error", title: "${state.error}");
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoadingState || isLodding == true) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return InkWell(
                      onTap: () {
                        _uploadProfile();
                      },
                      child: GFProgressBar(
                        percentage: upload_Percentage == 0.0 ? 0.0 : upload_Percentage / 100,
                        lineHeight: 40,
                        backgroundColor: AppColor.navBgColor,
                        progressBarColor: Colors.green,
                        animation: true,
                        progressHeadType: GFProgressHeadType.square,
                        margin: EdgeInsets.zero,
                        child: upload_Percentage == 100
                            ? Center(
                                child: Text(
                                  'Submit',
                                  style: mTextStyle14(mColor: AppColor.bgColorWhite),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Upload',
                                  style: mTextStyle14(mColor: AppColor.bgColorWhite),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: =========================================================

  // ================== Image Picker ==================
  String? profilePicPath;

  pickImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      profilePicName = pickedFile.name;
      profilePicPath = pickedFile.path;
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 15,
    );

    if (croppedImage != null) {
      File newFile = File(croppedImage.path);
      setState(() {
        profile_pic = newFile;
      });
      Navigator.pop(context);
    }
  }

  //=================================
  // Upload Document
  //

  void _uploadProfile() async {
    // Store Firebase Storage. first create folder which is name document then Store file

    try {
      if (selectedSkills.isNotEmpty && profile_pic != null) {
        setState(() {
          isLodding = true;
        });
        UploadTask uploadTask =
            FirebaseStorage.instance.ref().child("tailor_documents").child("profile_pic").child(profilePicName!).putFile(profile_pic!);

        // this get how many % upload
        uploadTask.snapshotEvents.listen((snapshot) {
          double percentage = snapshot.bytesTransferred / snapshot.totalBytes * 100;
          setState(() {
            upload_Percentage = percentage;
          });
        });

        //
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        widget.userModel.skills = selectedSkills.isEmpty ? null : selectedSkills;
        widget.userModel.profile_pic = downloadUrl;

        //
        BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
        isLodding = false;
        showSnackBar_Widget(context, mHeading: "Success", title: "Your form is submitted successfully");
        //
      } else {
        if(profile_pic == null){
           profilePicError = "Plz. upload profile pic";
        }
        showSnackBar_Widget(context, mHeading: "Error", title: "Plz. select min. one skills");
        setState(() {});
      }
    } catch (ex) {
      log(ex.toString());
    }
  }
}
