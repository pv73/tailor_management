import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/about_into_screen.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';
import 'package:image_picker/image_picker.dart';

class Aadhar_Card_Screen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const Aadhar_Card_Screen(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<Aadhar_Card_Screen> createState() => _Aadhar_Card_ScreenState();
}

class _Aadhar_Card_ScreenState extends State<Aadhar_Card_Screen> {
  //
  TextEditingController aadhaarController = TextEditingController();

  late MediaQueryData mq;
  var aadhaar_no_length;
  double upload_Percentage = 0.0;

  // For Image
  bool? isLodding = false;
  bool? isFontDocument = false;
  File? frontDocument;
  String? frontDocumentName;
  File? backDocument;
  String? backDocumentName;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: mq.size.width,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: mq.size.height * 0.10,
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset("assets/images/logo/aadhaar_logo.png"),
                ),
                heightSpacer(),
                Text(
                  "Aadhaar Authentication",
                  style: mTextStyle28(
                      mColor: AppColor.textColorBlack,
                      mFontWeight: FontWeight.w500),
                ),
                heightSpacer(mHeight: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Select any 1 option to proceed",
                    style: mTextStyle16(mFontWeight: FontWeight.w600),
                  ),
                ),

                heightSpacer(mHeight: 25),
                ExpansionTile(
                  childrenPadding: EdgeInsets.only(bottom: 20),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                  title: Text(
                    "Enter Aadhaar Number",
                    style: mTextStyle16(mFontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Enter valid 12 digit Aadhaar Number",
                    style: mTextStyle12(mColor: AppColor.textColorLightBlack),
                  ),
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: aadhaarController,
                        style: mTextStyle14(),
                        maxLength: 12,
                        readOnly:
                            widget.userModel.aadhaar_no != null ? true : false,
                        onChanged: (aadhaar) {
                          aadhaar_no_length = aadhaar.length;
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        decoration: mInputDecoration(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          hint: widget.userModel.aadhaar_no != null
                              ? "${widget.userModel.aadhaar_no}"
                              : "Enter 12 digit aadhaar number",
                          hintColor: AppColor.textColorLightBlack,
                          mCounterText: "",
                          radius: 5,
                        ),
                      ),
                    ),

                    /// Submit btn is Enable when aadhaar no is 12
                    heightSpacer(),
                    aadhaar_no_length != 12 &&
                            widget.userModel.aadhaar_no == null
                        ? Rounded_Btn_Widget(
                            title: "Submit",
                            mTextColor: AppColor.textColorBlue,
                            borderColor: AppColor.textColorBlue,
                            onPress: null,
                            mWidth: 200,
                            mHeight: 40,
                            borderRadius: 5,
                            mAlignment: Alignment.center,
                          )
                        : BlocConsumer<UserCubit, UserState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is UserLoadedState) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => About_Me(
                                        firebaseUser: widget.firebaseUser,
                                        userModel: widget.userModel),
                                  ),
                                );
                              } else if (state is UserErrorState) {
                                showSnackBar_Widget(context,
                                    mHeading: "Error", title: "${state.error}");
                              }
                            },
                            builder: (context, state) {
                              if (state is UserLoadingState) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Rounded_Btn_Widget(
                                title: "Submit",
                                onPress: () {
                                  widget.userModel.aadhaar_no =
                                      aadhaarController.text.trim();

                                  BlocProvider.of<UserCubit>(context)
                                      .addUserModel(widget.userModel);
                                },
                                mWidth: 200,
                                mHeight: 40,
                                borderRadius: 5,
                                mAlignment: Alignment.center,
                              );
                            },
                          ),
                  ],
                ),

                // Or Section Start
                heightSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Divider(
                          color: AppColor.textColorLightBlack,
                          indent: 40,
                        )),
                    Expanded(
                        child: Text(
                      "OR",
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        flex: 3,
                        child: Divider(
                          color: AppColor.textColorLightBlack,
                          endIndent: 40,
                        )),
                  ],
                ),

                // ID Proof Section
                heightSpacer(),
                ExpansionTile(
                  childrenPadding: EdgeInsets.only(bottom: 20),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                  title: Text(
                    "Upload ID Proof",
                    style: mTextStyle16(mFontWeight: FontWeight.w600),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                        "Valid ID Proofs: Aadhaar Card/Passport/Voter ID Card/ Driving License",
                        style:
                            mTextStyle12(mColor: AppColor.textColorLightBlack)),
                  ),
                  children: [
                    // View Image
                    heightSpacer(),
                    Container(
                      child: frontDocument != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Front Image",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w600),
                                ),
                                heightSpacer(mHeight: 4),
                                Image.file(
                                  frontDocument!,
                                  height: 150,
                                ),
                              ],
                            )
                          : Container(
                              height: 120,
                              child: Lottie.asset(
                                  "assets/images/lottie_animation/file_upload.json"),
                            ),
                    ),

                    heightSpacer(),
                    Container(
                      child: backDocument != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Back Image",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w600),
                                ),
                                heightSpacer(mHeight: 4),
                                Image.file(
                                  backDocument!,
                                  height: 150,
                                ),
                              ],
                            )
                          : Container(),
                    ),

                    // file Upload btn
                    heightSpacer(mHeight: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Rounded_Btn_Widget(
                              title: 'Browse File ',
                              mAlignment: Alignment.center,
                              borderRadius: 5,
                              mHeight: 35,
                              btnBgColor: AppColor.btnBgColorGreen,
                              onPress: () {
                                select_Front_Back();
                              },
                            ),
                          ),

                          /// If File is selected then Visible btn
                          widthSpacer(),
                          frontDocument != null
                              ? BlocConsumer<UserCubit, UserState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                    if (state is UserLoadedState) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => About_Me(
                                              firebaseUser: widget.firebaseUser,
                                              userModel: widget.userModel),
                                        ),
                                      );
                                    } else if (state is UserErrorState) {
                                      showSnackBar_Widget(context,
                                          mHeading: "Error",
                                          title: "${state.error}");
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is UserLoadingState ||
                                        isLodding == true) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _uploadDocument();
                                        },
                                        child: GFProgressBar(
                                          percentage: upload_Percentage == 0.0
                                              ? 0.0
                                              : upload_Percentage / 100,
                                          lineHeight: 33,
                                          backgroundColor: AppColor.navBgColor,
                                          progressBarColor: Colors.green,
                                          animation: true,
                                          progressHeadType:
                                              GFProgressHeadType.square,
                                          margin: EdgeInsets.zero,
                                          child: Center(
                                            child: Text(
                                              'Submit',
                                              style: mTextStyle12(
                                                  mColor:
                                                      AppColor.bgColorWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),

                    heightSpacer(mHeight: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: function for Front and Back Document

  Future<void> select_Front_Back() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 110.h,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Rounded_Btn_Widget(
                      title: 'Select Front Document',
                      mAlignment: Alignment.center,
                      borderRadius: 5,
                      mHeight: 40,
                      btnBgColor: AppColor.btnBgColorGreen,
                      onPress: () {
                        setState(() {
                          isFontDocument = true;
                          Navigator.pop(context);
                          showBottomSheet();
                        });
                      },
                    ),
                    heightSpacer(mHeight: 5),
                    Rounded_Btn_Widget(
                      title: 'Select Back Document',
                      mAlignment: Alignment.center,
                      borderRadius: 5,
                      mHeight: 40,
                      btnBgColor: AppColor.btnBgColorGreen,
                      onPress: () {
                        setState(() {
                          Navigator.pop(context);
                          isFontDocument = false;
                          showBottomSheet();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // TODO: Open Image Upload Option
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
                      _pickImage(ImageSource.camera);
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
                      _pickImage(ImageSource.gallery);
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

  /// ============== Image Picker ======================
  String? frontDocumentPath;
  String? backDocumentPath;

  _pickImage(ImageSource imageSource) async {
    //
    XFile? selectedDocument =
        await ImagePicker().pickImage(source: imageSource);
    if (selectedDocument != null) {
      if (isFontDocument == true) {
        frontDocumentName = selectedDocument.name;
        frontDocumentPath = selectedDocument.path;
      } else {
        backDocumentName = selectedDocument.name;
        backDocumentPath = selectedDocument.path;
      }

      cropImage(selectedDocument);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      compressQuality: 15,
    );

    if (croppedImage != null) {
      File newFile = File(croppedImage.path);
      setState(() {
        if (isFontDocument == true) {
          frontDocument = newFile;
        } else {
          backDocument = newFile;
        }
      });
    }
  }

  //=================================
  // Upload Document
  //
  void _uploadDocument() async {
    UploadTask? uploadTask;

    if (frontDocument == null || backDocument == null) {
      // Show Error message
      showSnackBar_Widget(context,
          mHeading: "Error", title: "select both side document");
    } else {
      setState(() {
        isLodding = true;
      });
      uploadTask = FirebaseStorage.instance
          .ref()
          .child("tailor_documents")
          .child("documents")
          .child(frontDocumentName!)
          .putFile(File(frontDocumentPath!));
      uploadTask = FirebaseStorage.instance
          .ref()
          .child("tailor_documents")
          .child("documents")
          .child(backDocumentName!)
          .putFile(File(backDocumentPath!));

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
      String front_DownloadUrl = await taskSnapshot.ref.getDownloadURL();
      String back_DownloadUrl = await taskSnapshot.ref.getDownloadURL();

      widget.userModel.front_document = front_DownloadUrl;
      widget.userModel.back_document = back_DownloadUrl;

      BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
      isLodding = false;
      // Show Successfully message
      showSnackBar_Widget(
        context,
        mHeading: "Success",
        title: "Your form is submitted successfully",
      );
    }
  }
}
