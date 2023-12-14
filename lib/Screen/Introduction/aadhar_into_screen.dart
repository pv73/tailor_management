import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/about_into_screen.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_helper.dart';
import 'package:image_picker/image_picker.dart';

class Aadhar_Card_Screen extends StatefulWidget {
  @override
  State<Aadhar_Card_Screen> createState() => _Aadhar_Card_ScreenState();
}

class _Aadhar_Card_ScreenState extends State<Aadhar_Card_Screen> {
  String? UserId;
  late MediaQueryData mq;
  var aadhaar_no_length;
  double upload_Percentage = 0.0;
  TextEditingController aadhaarController = TextEditingController();

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

  // For Image
  File? documentImage;

  @override
  Widget build(BuildContext context) {
    // MediaQuery
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
                        maxLength: 12,
                        onChanged: (aadhaar) {
                          aadhaar_no_length = aadhaar.length;
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        decoration: mInputDecoration(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          hint: "Enter 12 digit aadhaar number",
                          hintColor: AppColor.textColorLightBlack,
                          radius: 5,
                        ),
                      ),
                    ),

                    /// Submit btn is Enable when aadhaar no is 12
                    aadhaar_no_length != 12
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
                        : Rounded_Btn_Widget(
                            title: "Submit",
                            onPress: () {
                              var aadhaar = {
                                'aadhaar_no':
                                    aadhaarController.text.trim().toString()
                              };

                              // print("${UserId}  ${aadhaar}");
                              try {
                                FirebaseFirestore.instance
                                    .collection('clients')
                                    .doc(UserId)
                                    .update(aadhaar);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => About_Me(),
                                  ),
                                );
                                aadhaarController.text = " ";
                              } on FirebaseException catch (ex) {
                                print(ex.toString());
                              }
                            },
                            mWidth: 200,
                            mHeight: 40,
                            borderRadius: 5,
                            mAlignment: Alignment.center,
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
                    Container(
                      height: 120,
                      child: Lottie.asset(
                          "assets/images/lottie_animation/file_upload.json"),
                    ),

                    //
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
                              child: Text(
                                '${upload_Percentage}',
                                style:
                                    mTextStyle12(mColor: AppColor.bgColorWhite),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                    // file Upload btn
                    heightSpacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Rounded_Btn_Widget(
                              title: 'Browse File',
                              mAlignment: Alignment.center,
                              borderRadius: 5,
                              mHeight: 35,
                              btnBgColor: AppColor.btnBgColorGreen,
                              onPress: () {
                                showBottomSheet();
                              },
                            ),
                          ),

                          /// If File is selected then Visible btn
                          documentImage != null
                              ? Expanded(
                                  child: Rounded_Btn_Widget(
                                    title: "Submit",
                                    onPress: () {
                                      _uploadDocument();
                                    },
                                    mHeight: 35,
                                    borderRadius: 5,
                                    mAlignment: Alignment.center,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),

                    // View Image
                    heightSpacer(),
                    Container(
                      child: documentImage != null
                          ? Image.file(
                              documentImage!,
                              height: 150,
                            )
                          : Container(),
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

  // Open Image Upload Option
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

  // Image Picker
  Future _pickImage(ImageSource imageSource) async {
    XFile? selectedDocument =
        await ImagePicker().pickImage(source: imageSource);

    if (selectedDocument != null) {
      log("Image selected");
      File convertedFile = File(selectedDocument.path);
      setState(() {
        documentImage = convertedFile;
      });
    } else {
      log("No Image selected");
    }
  }

  //=================================
  // Upload Document
  //
  void _uploadDocument() async {
    // Store Firebase Storage. first create folder which is name document then Store file
    // UploadTask uploadTask = FirebaseStorage.instance
    //     .ref()
    //     .child("documents")
    //     .child(Uuid().v1())
    //     .putFile(documentImage!);

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("documents")
        .child(UserId!)
        .putFile(documentImage!);

    // this get how many % upload
    uploadTask.snapshotEvents.listen((snapshot) {
      double percentage = snapshot.bytesTransferred / snapshot.totalBytes * 100;
      setState(() {
        upload_Percentage = percentage;
      });

      log(upload_Percentage.toString());
    });

    //
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    var uploadDocument = {"document": downloadUrl};

    // image save in database
    FirebaseFirestore.instance
        .collection('clients')
        .doc(UserId)
        .update(uploadDocument);

    //
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => About_Me(),
      ),
    );

    documentImage = null;
  }
}
