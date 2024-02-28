import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Pdf_Viewer_Screen.dart';
import 'package:tailor/app_widget/Admin_NameCard_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/edit_Update_btn.dart';
import 'package:tailor/cubits/company_cubit/company_cubit.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_Profile extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const Admin_Profile({super.key, required this.firebaseUser, required this.companyModel});

  @override
  State<Admin_Profile> createState() => _Admin_ProfileState();
}

class _Admin_ProfileState extends State<Admin_Profile> {
  late MediaQueryData mq;

  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNumberController = TextEditingController();
  TextEditingController gst_noController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? isEditByName;
  File? gst_file;
  String? gstFileName;
  String? gstFileError;
  bool? isLodding = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(
              text: "Company ",
              style: mTextStyle20(),
              children: [TextSpan(text: "Profile", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
        ),
      ),
      drawer: Drawer_Widget(isCurUserCom: true, firebaseUser: widget.firebaseUser, companyModel: widget.companyModel),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =============  Start Profile Box ============
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Admin_NameCard_Widget(
                    firebaseUser: widget.firebaseUser,
                    companyModel: widget.companyModel,
                    mTextColor: AppColor.textColorBlack,
                  ),
                ),

                // ============= Contact Person Name ==============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {
                          nameController.text = widget.companyModel.user_name!;
                          isEditByName = "Name";
                          setState(() {});
                        },
                        mIcon: Icons.edit,
                        title: "Contact Person Name",
                        buttonName: "Edit",
                      ),

                      // ========= If Edit Name ================
                      heightSpacer(mHeight: 5),
                      isEditByName == "Name"
                          ? Edit_Update_Btn(
                              Controller: nameController,
                              keyboardType: TextInputType.name,
                              hintText: "${widget.companyModel.user_name}",
                              textCapitalization: TextCapitalization.words,
                              onCancelPress: () {
                                isEditByName = null;
                                setState(() {});
                              },
                              onUpdatePress: () {
                                widget.companyModel.user_name = nameController.text.toString();
                                BlocProvider.of<CompanyCubit>(context).updateCompanyModel(widget.companyModel);
                                isEditByName = null;
                                setState(() {});
                              },
                            )
                          : Text(
                              "${widget.companyModel.user_name}",
                              style: mTextStyle13(),
                            )
                    ],
                  ),
                ),

                // ================= Company Name ================
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {
                          companyNameController.text = widget.companyModel.company_name!;
                          isEditByName = "Company";
                          setState(() {});
                        },
                        mIcon: Icons.edit,
                        title: "Company",
                        buttonName: "Edit",
                      ),

                      // ========= If Edit Company Name ================
                      heightSpacer(mHeight: 5),
                      isEditByName == "Company"
                          ? Edit_Update_Btn(
                              Controller: companyNameController,
                              hintText: '${widget.companyModel.user_name}',
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.words,
                              onCancelPress: () {
                                isEditByName = null;
                                setState(() {});
                              },
                              onUpdatePress: () {
                                widget.companyModel.company_name = companyNameController.text.toString();
                                BlocProvider.of<CompanyCubit>(context).updateCompanyModel(widget.companyModel);
                                isEditByName = null;
                                setState(() {});
                              },
                            )
                          : Text(
                              "${widget.companyModel.company_name}",
                              style: mTextStyle13(),
                            ),
                    ],
                  ),
                ),

                // ============= Email ============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Detail_Box(onPressed: () {},mIcon: Icons.edit,title: "Email",buttonName: "Edit",),
                      Text(
                        "Email",
                        style: mTextStyle13(mFontWeight: FontWeight.w700),
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "${widget.companyModel.email}",
                        style: mTextStyle13(),
                      )
                    ],
                  ),
                ),

                // ================= Company Number =================
                widget.companyModel.company_number != null
                    ? Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Detail_Box(
                              onPressed: () {
                                companyNumberController.text = widget.companyModel.company_number!;
                                isEditByName = "Company_Number";
                                setState(() {});
                              },
                              mIcon: Icons.edit,
                              title: "Company Number",
                              buttonName: "Edit",
                            ),
                            heightSpacer(mHeight: 5),
                            isEditByName == "Company_Number"
                                ? Edit_Update_Btn(
                                    Controller: companyNumberController,
                                    hintText: '${widget.companyModel.company_number}',
                                    keyboardType: TextInputType.number,
                                    onCancelPress: () {
                                      isEditByName = null;
                                      setState(() {});
                                    },
                                    onUpdatePress: () {
                                      widget.companyModel.company_number = companyNumberController.text.toString();
                                      BlocProvider.of<CompanyCubit>(context).updateCompanyModel(widget.companyModel);
                                      isEditByName = null;
                                      setState(() {});
                                    },
                                  )
                                : Text(
                                    "${widget.companyModel.company_number}",
                                    style: mTextStyle13(),
                                  )
                          ],
                        ),
                      )
                    : Container(),

                //==============  Company Gst No ===================
                widget.companyModel.gst_no != null
                    ? Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Detail_Box(
                              onPressed: () {
                                gst_noController.text = widget.companyModel.gst_no!;
                                gstFileName = widget.companyModel.gst_fileName;
                                isEditByName = "gst_no";
                                setState(() {});
                              },
                              mIcon: Icons.edit,
                              title: "Company GST No.",
                              buttonName: "Edit",
                            ),

                            // ======== Display Data and Edit Data ==========
                            isEditByName == "gst_no"
                                ? BlocConsumer<CompanyCubit, CompanyState>(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                      isEditByName = null;
                                      isLodding = false;
                                    },
                                    builder: (context, state) {
                                      if (isLodding == true) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Edit_Update_Btn(
                                        Controller: gst_noController,
                                        hintText: widget.companyModel.gst_no == null || widget.companyModel.gst_no == ""
                                            ? "Enter GST number"
                                            : '${widget.companyModel.gst_no}',
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.characters,
                                        gstFileName: gstFileName,
                                        isGst_no: true,
                                        gstFileError: gstFileError,
                                        onCancelPress: () {
                                          isEditByName = null;
                                          setState(() {});
                                        },
                                        onUpdatePress: () {
                                          UploadFile();
                                        },
                                        onUploadFile: () {
                                          _pickGstFile();
                                        },
                                      );
                                    },
                                  )

                                // ======= Only view gst Ui ==============
                                : widget.companyModel.gst_no == null || widget.companyModel.gst_no == ""
                                    ? Container()
                                    : Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            heightSpacer(mHeight: 5),
                                            Text(
                                              "${widget.companyModel.gst_no}",
                                              style: mTextStyle13(),
                                            ),
                                            heightSpacer(mHeight: 10),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Pdf_Viewer_Screen(
                                                      pdfUrl: "${widget.companyModel.gst_file}",
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(color: AppColor.cardBtnBgGreen)),
                                                child: Text("${widget.companyModel.gst_fileName}",
                                                    style: mTextStyle10(mColor: AppColor.cardBtnBgGreen)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                          ],
                        ),
                      )
                    : Container(),

                // ============ Company Pan Card Number ===========
                widget.companyModel.pan_no != null
                    ? Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Detail_Box(
                              onPressed: () {
                                panCardController.text = widget.companyModel.pan_no!;
                                isEditByName = "pan_card";
                                setState(() {});
                              },
                              mIcon: Icons.edit,
                              title: "Company Pan Card No.",
                              buttonName: "Edit",
                            ),
                            heightSpacer(mHeight: 5),
                            isEditByName == "pan_card"
                                ? Edit_Update_Btn(
                                    Controller: panCardController,
                                    hintText: '${widget.companyModel.pan_no}',
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.characters,
                                    onCancelPress: () {
                                      isEditByName = null;
                                      setState(() {});
                                    },
                                    onUpdatePress: () {
                                      widget.companyModel.pan_no = panCardController.text.toString();
                                      BlocProvider.of<CompanyCubit>(context).updateCompanyModel(widget.companyModel);
                                      isEditByName = null;
                                      setState(() {});
                                    },
                                  )
                                : widget.companyModel.pan_no == null || widget.companyModel.pan_no == ""
                                    ? Container()
                                    : Text(
                                        "${widget.companyModel.pan_no}",
                                        style: mTextStyle13(),
                                      )
                          ],
                        ),
                      )
                    : Container(),

                // Company Address
                Card_Container_Widget(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {
                          addressController.text = widget.companyModel.address!;
                          isEditByName = "company_address";
                          setState(() {});
                        },
                        mIcon: Icons.edit,
                        title: "Company Address",
                        buttonName: "Edit",
                      ),
                      heightSpacer(mHeight: 5),
                      isEditByName == "company_address"
                          ? Edit_Update_Btn(
                              Controller: addressController,
                              hintText: '${widget.companyModel.address}',
                              keyboardType: TextInputType.multiline,
                              onCancelPress: () {
                                isEditByName = null;
                                setState(() {});
                              },
                              onUpdatePress: () {
                                widget.companyModel.address = addressController.text.toString();
                                BlocProvider.of<CompanyCubit>(context).updateCompanyModel(widget.companyModel);
                                isEditByName = null;
                                setState(() {});
                              },
                            )
                          : Text(
                              "${widget.companyModel.address}",
                              style: mTextStyle13(),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //================================================================

  ////   Details Box Widget
  Widget Detail_Box({title, required void Function()? onPressed, buttonName, mIcon}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: mTextStyle13(mFontWeight: FontWeight.w700),
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Row(
              children: [
                Icon(
                  mIcon,
                  size: 12,
                  color: AppColor.cardBtnBgGreen,
                ),
                widthSpacer(mWidth: 2),
                Text(
                  buttonName,
                  style: mTextStyle12(mFontWeight: FontWeight.w700, mColor: AppColor.cardBtnBgGreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============
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
        });
      } else {
        setState(() {
          gstFileError = "Please Upload file less than 2 MB";
          isLodding = false;
        });
      }

      // Upload file
    }
  }

  void UploadFile() async {
    setState(() {});
    isLodding = true;
    try {
      UploadTask gstFileUploadTask =
          FirebaseStorage.instance.ref().child("company_documents").child("documents").child("$gstFileName").putFile(gst_file!);

      TaskSnapshot getFileTaskSnapshot = await gstFileUploadTask;
      String gst_file_downloadUrl = await getFileTaskSnapshot.ref.getDownloadURL();

      widget.companyModel.gst_no = gst_noController.text;
      widget.companyModel.gst_file = gst_file_downloadUrl;
      widget.companyModel.gst_fileName = gstFileName;

      BlocProvider.of<CompanyCubit>(context).updateCompanyModel(widget.companyModel);
    } catch (error) {
      log(error.toString());
    }
  }
}
