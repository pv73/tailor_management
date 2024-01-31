import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor/cubits/company_cubit/company_cubit.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_NameCard_Widget extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;
  final Color mTextColor;

  const Admin_NameCard_Widget({
    super.key,
    required this.firebaseUser,
    required this.companyModel,
    required this.mTextColor,
  });

  @override
  State<Admin_NameCard_Widget> createState() => _Admin_NameCard_WidgetState();
}

class _Admin_NameCard_WidgetState extends State<Admin_NameCard_Widget> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  File? company_logo;
  String? companyLogoName;
  bool? isLodding = false;

  @override
  void initState() {
    super.initState();
  }


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
                        "${widget.companyModel.user_name}".toUpperCase(),
                        style: mTextStyle19(
                          mFontWeight: FontWeight.w800,
                          mColor: widget.mTextColor,
                        ),
                      ),
                    ),

                    // Email
                    heightSpacer(mHeight: 2),
                    Text(
                      "${widget.companyModel.email}",
                      style: mTextStyle13(mColor: widget.mTextColor),
                    ),

                    // Email
                    heightSpacer(mHeight: 3),
                    widget.companyModel.gst_no == null
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                "GST No. ",
                                style: mTextStyle13(
                                    mFontWeight: FontWeight.w600,
                                    mColor: widget.mTextColor),
                              ),
                              Expanded(
                                child: Text(
                                  "${widget.companyModel.gst_no}",
                                  style:
                                      mTextStyle13(mColor: widget.mTextColor),
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
                  child: widget.companyModel.company_logo != null
                      ? BlocConsumer<CompanyCubit, CompanyState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            isLodding = false;
                          },
                          builder: (context, state) {
                            if (isLodding == true) {
                              return Opacity(
                                opacity: 0.3,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(company_logo!),
                                  radius: 30,
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                showBottomSheet();
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "${widget.companyModel.company_logo}"),
                              ),
                            );
                          },
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 30,
                          child: Text(
                            getInitials("${widget.companyModel.user_name}"),
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
                          mFontWeight: FontWeight.w600,
                          mColor: widget.mTextColor),
                      children: [
                        TextSpan(
                          text: "${widget.companyModel.phone}",
                          style: mTextStyle13(mColor: widget.mTextColor),
                        )
                      ],
                    ),
                  ),
                ),
                widthSpacer(mWidth: 5),
                widget.companyModel.company_number != null
                    ? Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Phone No: ",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w600,
                                mColor: widget.mTextColor),
                            children: [
                              TextSpan(
                                text: "${widget.companyModel.company_number}",
                                style: mTextStyle13(mColor: widget.mTextColor),
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
                      mFontWeight: FontWeight.w600, mColor: widget.mTextColor),
                ),
                Expanded(
                  child: Text(
                    "${widget.companyModel.address}",
                    style: mTextStyle13(mColor: widget.mTextColor),
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

  // TODO: ====================== UI End ===================================
  // ================== UI end and  Widget and list Start ==================

  Future<void> showBottomSheet() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 75.h,
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

  // ================== Image Picker ==================
  String? companyLogoPath;

  pickImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      companyLogoPath = pickedFile.path;
      companyLogoName = pickedFile.name;
      cropImage(pickedFile);
    }
  }

  cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: companyLogoPath!,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 15,
    );

    if (croppedImage != null) {
      File newFile = File(croppedImage.path);
      setState(() {
        company_logo = newFile;
        UploadCompanyLogo();
      });
    }
  }

  // ======== Upload Company Logo =============
  void UploadCompanyLogo() async {
    setState(() {});
    isLodding = true;

    try {
      UploadTask logoUploadTask = FirebaseStorage.instance
          .ref()
          .child("company_documents")
          .child("profile_pic")
          .child(companyLogoName!)
          .putFile(File(companyLogoPath!));

      TaskSnapshot logoTaskSnapshot = await logoUploadTask;
      String logo_downloadUrl = await logoTaskSnapshot.ref.getDownloadURL();

      // === Hear Update company logo Url in Company Model
      widget.companyModel.company_logo = logo_downloadUrl;
      BlocProvider.of<CompanyCubit>(context)
          .updateCompanyModel(widget.companyModel);

      // yeha job table me company ka logo update ho raha h
      getJobs(logo_downloadUrl);

    } catch (error) {
      log(error.toString());
    }
  }

  // Update company Logo in Jobs table  when Company logo update in CompanyProfile
  void getJobs(String logoUrl) async {
    QuerySnapshot querySnapshot = await firestore.collection('jobs').get();

    for (var doc in querySnapshot.docs) {
      String getUid = doc.get("uid");

      if (getUid == widget.firebaseUser.uid) {
        await firestore.collection('jobs').doc(doc.id).update({
          'company_logo': '${logoUrl}', // Change this to the new image URL
        });
      }
    }
  }
}
