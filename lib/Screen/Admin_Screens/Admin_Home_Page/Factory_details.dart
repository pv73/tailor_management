import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Admin_Dashboard.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/company_cubit/company_cubit.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Factory_Details extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const Factory_Details({
    super.key,
    required this.firebaseUser,
    required this.companyModel,
  });

  @override
  State<Factory_Details> createState() => _Factory_DetailsState();
}

class _Factory_DetailsState extends State<Factory_Details> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController gstNoController = TextEditingController();
  TextEditingController panNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // For Image
  bool? company_final_submit = false;
  File? company_logo;
  String? companyLogoName;
  File? gst_file;
  String? gstFileName;
  String? gstFileError;
  bool? isLodding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner/splash_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      heightSpacer(mHeight: 20),
                      Text(
                        "Factory Details",
                        style: mTextStyle24(
                            mFontWeight: FontWeight.w900,
                            mColor: AppColor.textColorBlue),
                      ),

                      heightSpacer(),
                      Text(
                        "Enter your company details and \nfill all the fields ",
                        style: mTextStyle14(
                          mFontWeight: FontWeight.w500,
                          mColor: AppColor.textColorBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // profile Pic
                      heightSpacer(mHeight: 15),
                      Stack(
                        children: [
                          company_logo == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 40,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey.shade500,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(company_logo!),
                                  radius: 40,
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showBottomSheet();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 13,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        controller: companyNameController,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.business_sharp),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "Company Name",
                          hintColor: AppColor.textColorLightBlack,
                        ),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.person),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "${widget.companyModel.user_name}",
                          hintColor: AppColor.textColorLightBlack,
                        ),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.email_outlined),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "${widget.companyModel.email}",
                          hintColor: AppColor.textColorLightBlack,
                        ),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.mobile_friendly),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "${widget.companyModel.phone}",
                          hintColor: AppColor.textColorLightBlack,
                        ),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        controller: companyPhoneController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        maxLength: 10,
                        decoration: mInputDecoration(
                            padding: EdgeInsets.only(top: 3),
                            prefixIcon: Icon(Icons.phone),
                            preFixColor: AppColor.textColorLightBlack,
                            mIconSize: 18,
                            radius: 5,
                            hint: "Company Phone number",
                            hintColor: AppColor.textColorLightBlack,
                            mCounterText: ""),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        controller: gstNoController,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        maxLength: 15,
                        textCapitalization: TextCapitalization.characters,
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.description_outlined),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "GST No.",
                          hintColor: AppColor.textColorLightBlack,
                          mCounterText: "",
                        ),
                        onChanged: (value) {
                          setState(() {
                            isLodding = false;
                          });
                        },
                      ),

                      // Gst File
                      gstNoController.text.isEmpty
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                readOnly: true,
                                decoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3),
                                  prefixIcon: gstFileName == null
                                      ? Icon(Icons.file_upload_outlined)
                                      : Icon(Icons.done_all),
                                  preFixColor: gstFileName == null
                                      ? AppColor.textColorLightBlack
                                      : AppColor.btnBgColorGreen,
                                  mIconSize: 18,
                                  radius: 5,
                                  hint: gstFileName == null
                                      ? "Upload GST File"
                                      : "${gstFileName}",
                                  hintColor: gstFileName == null
                                      ? AppColor.textColorLightBlack
                                      : AppColor.btnBgColorGreen,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _pickGstFile();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border(
                                          top: BorderSide(
                                            color: AppColor.textColorLightBlack,
                                          ),
                                          right: BorderSide(
                                            color: AppColor.textColorLightBlack,
                                          ),
                                          bottom: BorderSide(
                                            color: AppColor.textColorLightBlack,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Upload",
                                        style: mTextStyle13(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      // gst File Error message show
                      Align(
                        alignment: Alignment.topLeft,
                        child: gstFileError == null
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "${gstFileError}",
                                  style: mTextStyle10(mColor: Colors.red),
                                ),
                              ),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        controller: panNoController,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        maxLength: 10,
                        textCapitalization: TextCapitalization.characters,
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.credit_card),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "Pan No.",
                          hintColor: AppColor.textColorLightBlack,
                          mCounterText: "",
                        ),
                      ),
                      heightSpacer(mHeight: 5),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Note:- If the company has PAN card no. yes then fill this",
                          style: mTextStyle10(mColor: Colors.red),
                        ),
                      ),

                      heightSpacer(mHeight: 15),
                      TextFormField(
                        controller: addressController,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: Icon(Icons.location_pin),
                          preFixColor: AppColor.textColorLightBlack,
                          mIconSize: 18,
                          radius: 5,
                          hint: "Address",
                          hintColor: AppColor.textColorLightBlack,
                        ),
                      ),

                      // Login Btn
                      heightSpacer(mHeight: 25),

                      BlocConsumer<CompanyCubit, CompanyState>(
                        listener: (context, state) async {
                          // TODO: implement listener
                          if (state is CompanyLoadedState) {
                            // Navigate Admin Dashboard
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Admin_Dashboard(
                                        companyModel: widget.companyModel,
                                        firebaseUser: widget.firebaseUser,
                                      )),
                            );
                            //
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setBool("company_final_submit", true);

                            // Show SnackBar
                            showSnackBar_Widget(context,
                                mHeading: "Success",
                                title: "Your form is submitted successfully");

                            //
                          } else if (state is CompanyErrorState) {
                            return showSnackBar_Widget(context,
                                mHeading: "Error", title: "${state.error}");
                          }
                        },
                        builder: (context, state) {
                          if (state is CompanyLoadingState ||
                              isLodding == true) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Rounded_Btn_Widget(
                            title: "Submit",
                            mTextColor: Colors.white,
                            btnBgColor: AppColor.btnBgColorGreen,
                            borderColor: AppColor.btnBgColorGreen,
                            onPress: () {
                              _uploadFileData();
                            },
                            mHeight: 40,
                            borderRadius: 5,
                            mAlignment: Alignment.center,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
        isLodding = false;
      });
    }
  }

  // ==================== Pick GstFile ================
  void _pickGstFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      gst_file = File(pickedFile.files.single.path!);

      // Check if the file size is less than or equal to 2 MB
      if (gst_file!.lengthSync() <= 2 * 1024 * 1024) {
        setState(() {
          gstFileName = pickedFile.files[0].name;
          gstFileError = null;
          isLodding = false;
        });
      } else {
        setState(() {
          gstFileError = "Please Upload file less than 2 MB";
          isLodding = false;
        });
      }
    }
  }

  // Upload File and all data
  void _uploadFileData() async {
    String companyName = companyNameController.text.toString();
    String companyPhone = companyPhoneController.text.toString();
    String gstNo = gstNoController.text.toString();
    String panNo = panNoController.text.toString();
    String address = addressController.text.toString();
    String gst_file_downloadUrl = "";
    UploadTask? logoUploadTask;
    UploadTask? gstFileUploadTask;

    try {
      if (companyName.isNotEmpty &&
          companyPhone.isNotEmpty &&
          company_logo != null &&
          address.isNotEmpty) {
        // condition true
        setState(() {
          isLodding = true;
        });
        // upload company Logo
        logoUploadTask = FirebaseStorage.instance
            .ref()
            .child("company_documents")
            .child("profile_pic")
            .child(companyLogoName!)
            .putFile(File(companyLogoPath!));

        TaskSnapshot logoTaskSnapshot = await logoUploadTask;
        String logo_downloadUrl = await logoTaskSnapshot.ref.getDownloadURL();

        //
        // upload gst file
        if (gst_file != null) {
          gstFileUploadTask = FirebaseStorage.instance
              .ref()
              .child("company_documents")
              .child("documents")
              .child("$gstFileName")
              .putFile(gst_file!);

          TaskSnapshot getFileTaskSnapshot = await gstFileUploadTask;
          gst_file_downloadUrl = await getFileTaskSnapshot.ref.getDownloadURL();
        }

        /// upload in CompanyModel data
        widget.companyModel.company_logo = logo_downloadUrl;
        widget.companyModel.company_name = companyName;
        widget.companyModel.company_number = companyPhone;
        widget.companyModel.gst_no = gstNo;
        widget.companyModel.gst_file = gst_file_downloadUrl;
        widget.companyModel.gst_fileName = gstFileName;
        widget.companyModel.pan_no = panNo;
        widget.companyModel.address = address;
        widget.companyModel.final_submit = true;

        BlocProvider.of<CompanyCubit>(context).addCompanyModel(widget.companyModel);

        isLodding = false;
        //
      } else {
        showSnackBar_Widget(context,
            mHeading: "Error", title: "Some field is empty");
      }
    } catch (ex) {
      log(ex.toString());
    }
  }
}
