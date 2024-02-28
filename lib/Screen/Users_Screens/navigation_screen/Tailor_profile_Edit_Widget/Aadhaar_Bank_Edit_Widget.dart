import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/dynimic_list/Bank_Name_List.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Aadhaar_Bank_Edit_Widget extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  Aadhaar_Bank_Edit_Widget({required this.firebaseUser, required this.userModel});

  @override
  State<Aadhaar_Bank_Edit_Widget> createState() => _Aadhaar_Bank_Edit_WidgetState();
}

class _Aadhaar_Bank_Edit_WidgetState extends State<Aadhaar_Bank_Edit_Widget> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController aadhaarEditController = TextEditingController();
  TextEditingController accountNoEditController = TextEditingController();
  TextEditingController ifsc_codeEditController = TextEditingController();

  var aadhaar_no_length;
  bool? isLodding = false;
  bool? isFontDocument = false;
  File? frontEditDocument;
  String? frontDocumentName;
  File? backEditDocument;
  String? backDocumentName;
  var _Selected_Bank;
  String? bank_Name;
  bool? bank_request = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      appBar: AppBar(
        leadingWidth: 25,
        title: RichText(
          text: TextSpan(
              text: "Aadhaar &",
              style: mTextStyle20(),
              children: [TextSpan(text: " Bank Edit", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: aadhaarEditController,
                        style: mTextStyle14(),
                        maxLength: 12,
                        // readOnly: widget.userModel.aadhaar_no != null ? true : false,
                        onChanged: (aadhaar) {
                          aadhaar_no_length = aadhaar.length;
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        decoration: mInputDecoration(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          hint:
                              widget.userModel.aadhaar_no != null ? "${widget.userModel.aadhaar_no}" : "Enter 12 digit aadhaar number",
                          hintColor: AppColor.textColorLightBlack,
                          mCounterText: "",
                          radius: 5,
                        ),
                      ),
                    ),
                  ],
                ),

                // ============= Or Section Start ===============
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

                // =========== ID Proof Section ===========
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
                    child: Text("Valid ID Proofs: Aadhaar Card/Passport/Voter ID Card/ Driving License",
                        style: mTextStyle12(mColor: AppColor.textColorLightBlack)),
                  ),
                  children: [
                    // View Image
                    heightSpacer(),
                    Text(
                      "Upload both side",
                      style: mTextStyle13(mFontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: frontEditDocument != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Front Image",
                                  style: mTextStyle14(mFontWeight: FontWeight.w600),
                                ),
                                heightSpacer(mHeight: 4),
                                Text("${frontDocumentName}",
                                    style: mTextStyle13(mFontWeight: FontWeight.w600, mColor: AppColor.cardBtnBgGreen)),
                                heightSpacer(mHeight: 5),
                                Image.file(
                                  frontEditDocument!,
                                ),
                              ],
                            )
                          : Container(),
                    ),

                    heightSpacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: backEditDocument != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Back Image",
                                  style: mTextStyle14(mFontWeight: FontWeight.w600),
                                ),
                                heightSpacer(mHeight: 4),
                                Text("${backDocumentName}",
                                    style: mTextStyle13(mFontWeight: FontWeight.w600, mColor: AppColor.cardBtnBgGreen)),
                                heightSpacer(mHeight: 5),
                                Image.file(
                                  backEditDocument!,
                                ),
                              ],
                            )
                          : Container(),
                    ),

                    // ============ file Upload btn =================
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 20),
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
                        ],
                      ),
                    ),
                  ],
                ),

                // ============= Or Section Start ===============
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

                // ============= Update bank details  ==============
                heightSpacer(),
                Card_Container_Widget(
                  mBorderColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Update bank details",
                    style: mTextStyle13(mFontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),

                // ======== Popular bank -==============
                heightSpacer(),
                Row(
                  children: [
                    Expanded(child: Text("Request Bank Account apply")),
                    FlutterSwitch(
                      activeColor: AppColor.btnBgColorGreen,
                      height: 30,
                      width: 58,
                      activeIcon: Icon(
                        Icons.check_circle_rounded,
                        color: AppColor.btnBgColorGreen,
                      ),
                      valueFontSize: 12,
                      value: bank_request!,
                      showOnOff: true,
                      onToggle: (value) {
                        bank_request = value;
                        setState(() {});
                      },
                    )
                  ],
                ),

                /// =============== Bank Name ======================

                heightSpacer(mHeight: 15),
                bank_request != false
                    ? Text("")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add bank account",
                            style: mTextStyle15(mFontWeight: FontWeight.w700),
                          ),

                          // bank Name
                          heightSpacer(mHeight: 15),
                          Card_Container_Widget(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Popular Banks",
                                  style: mTextStyle14(mFontWeight: FontWeight.w700),
                                ),

                                /// bank list
                                heightSpacer(mHeight: 15),
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: bank_list.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5, mainAxisExtent: 115),
                                  itemBuilder: (context, bank_Index) {
                                    var bank_list_index = bank_list[bank_Index];
                                    return InkWell(
                                      onTap: () {
                                        _Selected_Bank = bank_Index;
                                        _Selected_Bank = bank_list[_Selected_Bank];
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.blue.shade50,
                                            child: Image.asset(
                                              bank_list[bank_Index]['bank_Icon']!,
                                              width: 38,
                                            ),
                                          ),
                                          heightSpacer(mHeight: 7),
                                          Text(
                                            bank_list_index['bank_Name']!,
                                            style: mTextStyle13(mFontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                // ================ Bank Filed like A/c Ifsc code =================
                heightSpacer(mHeight: 15),
                if (_Selected_Bank == null || bank_request == true)
                  Container()
                else
                  Card_Container_Widget(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade50,
                              radius: 23,
                              child: Image.asset(
                                _Selected_Bank['bank_Icon']!,
                                width: 28,
                              ),
                            ),
                            widthSpacer(mWidth: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selected bank",
                                  style: mTextStyle12(mFontWeight: FontWeight.w500),
                                ),
                                Text(
                                  _Selected_Bank['bank_Name']!,
                                  style: mTextStyle15(mFontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 25,
                        ),
                        TextFormField(
                          controller: accountNoEditController,
                          maxLength: 16,
                          style: mTextStyle13(),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter account number';
                            }
                            return null;
                          },
                          decoration: mInputDecoration(
                            hint: widget.userModel.account_number == null ? "Account Number" : widget.userModel.account_number,
                            radius: 5,
                            padding: EdgeInsets.only(left: 15),
                            mCounterText: "",
                          ),
                        ),
                        heightSpacer(mHeight: 15),
                        TextFormField(
                          controller: ifsc_codeEditController,
                          maxLength: 11,
                          style: mTextStyle13(),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter IFSC Code';
                            }
                            return null;
                          },
                          decoration: mInputDecoration(
                            hint: widget.userModel.ifsc_code == null ? "IFSC" : widget.userModel.ifsc_code,
                            radius: 5,
                            padding: EdgeInsets.only(left: 15),
                            mCounterText: "",
                          ),
                        ),
                      ],
                    ),
                  ),

                // ========== Update Button ===============
                heightSpacer(),

                Row(
                  children: [
                    Expanded(
                      child: Rounded_Btn_Widget(
                        title: "Back",
                        mTextColor: Colors.white,
                        btnBgColor: Colors.red.shade500,
                        onPress: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        mHeight: 40,
                        borderRadius: 5,
                        mAlignment: Alignment.center,
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<UserCubit, UserState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          isLodding = false;
                          if (state is UserLoadedState) {
                            Navigator.pop(context);
                          }
                          setState(() {});
                        },
                        builder: (context, state) {
                          if (state is UserLoadingState || isLodding == true) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Rounded_Btn_Widget(
                            title: "Update",
                            mTextColor: Colors.white,
                            btnBgColor: AppColor.btnBgColorGreen,
                            onPress: () {
                              UpdateData();
                            },
                            mHeight: 40,
                            borderRadius: 5,
                            mAlignment: Alignment.center,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                heightSpacer(mHeight: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== TODO: function for Front and Back Document ==========
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
                          Image_Picker_showBottomSheet(
                            context,
                            fromCameraPress: () {
                              _pickImage(ImageSource.camera);
                            },
                            fromGalleryPress: () {
                              _pickImage(ImageSource.gallery);
                            },
                          );
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
                          Image_Picker_showBottomSheet(
                            context,
                            fromCameraPress: () {
                              _pickImage(ImageSource.camera);
                            },
                            fromGalleryPress: () {
                              _pickImage(ImageSource.gallery);
                            },
                          );
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

  /// ============== Image Picker ======================
  String? frontDocumentPath;
  String? backDocumentPath;

  _pickImage(ImageSource imageSource) async {
    //
    XFile? selectedDocument = await ImagePicker().pickImage(source: imageSource);
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
      compressQuality: 40,
    );

    if (croppedImage != null) {
      File newFile = File(croppedImage.path);
      setState(() {
        if (isFontDocument == true) {
          frontEditDocument = newFile;
        } else {
          backEditDocument = newFile;
        }
      });
    }
  }

  // ============= Update aadhaar and bank detailsFunction  =====================
  void UpdateData() async {
    UploadTask? frontUploadTask;
    UploadTask? backUploadTask;

    // ======= store aadhaar no  ==========
    widget.userModel.aadhaar_no = aadhaarEditController.text.isEmpty ? widget.userModel.aadhaar_no : aadhaarEditController.text;

    // ======== Store Document if both side not Empty then ===============
    if (frontEditDocument != null && backEditDocument != null) {
      setState(() {
        isLodding = true;
      });

      frontUploadTask = FirebaseStorage.instance
          .ref()
          .child("tailor_documents")
          .child("documents")
          .child(frontDocumentName!)
          .putFile(frontEditDocument!);

      backUploadTask = FirebaseStorage.instance
          .ref()
          .child("tailor_documents")
          .child("documents")
          .child(backDocumentName!)
          .putFile(backEditDocument!);

      //
      TaskSnapshot frontTaskSnapshot = await frontUploadTask;
      TaskSnapshot backTaskSnapshot = await backUploadTask;

      String front_DownloadUrl = await frontTaskSnapshot.ref.getDownloadURL();
      String back_DownloadUrl = await backTaskSnapshot.ref.getDownloadURL();

      widget.userModel.front_document = front_DownloadUrl;
      widget.userModel.back_document = back_DownloadUrl;
    }

    if (bank_request == true) {
      widget.userModel.bank_request = bank_request;
      // ====== Empty other fields If bank Request is true ==========
      widget.userModel.account_number = null;
      widget.userModel.ifsc_code = null;
      widget.userModel.bank_name = null;
    } else if (_Selected_Bank != null) {
      widget.userModel.bank_name = _Selected_Bank['bank_Name'];
      widget.userModel.account_number = accountNoEditController.text.toString();
      widget.userModel.ifsc_code = ifsc_codeEditController.text.toString().trim();
    } else {
      log("all field empty");
    }

    if (frontEditDocument != null || backEditDocument != null) {
      if (frontEditDocument == null || backEditDocument == null) {
        // Show Error message
        showSnackBar_Widget(context, mHeading: "Error", title: "select both side document");
      } else {
        BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
        isLodding = false;
      }
    } else {
      BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
      isLodding = false;
    }
  }
}
