import 'package:flutter/material.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/ui_helper.dart';

class Edit_Update_Btn extends StatelessWidget {
  final String hintText;
  final String? gstFileName;
  final String? gstFileError;
  bool? isGst_no = false;
  TextEditingController Controller;
  TextInputType keyboardType;
  TextCapitalization textCapitalization;
  void Function() onCancelPress;
  void Function() onUpdatePress;
  void Function()? onUploadFile;

  Edit_Update_Btn(
      {required this.hintText,
      required this.Controller,
      required this.keyboardType,
      required this.onCancelPress,
      required this.onUpdatePress,
      this.textCapitalization = TextCapitalization.none,
      this.onUploadFile,
      this.gstFileName,
      this.isGst_no,
      this.gstFileError});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          TextFormField(
            controller: Controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            decoration: mInputDecoration(
              padding: EdgeInsets.only(top: 3, left: 10),
              radius: 5,
              hint: hintText,
              hintColor: AppColor.textColorLightBlack,
            ),
          ),

          isGst_no == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                        readOnly: true,
                        decoration: mInputDecoration(
                          padding: EdgeInsets.only(top: 3),
                          prefixIcon: gstFileName == null ? Icon(Icons.file_upload_outlined) : Icon(Icons.done_all),
                          preFixColor: gstFileName == null ? AppColor.textColorLightBlack : AppColor.btnBgColorGreen,
                          mIconSize: 18,
                          radius: 5,
                          hint: gstFileName == null ? "Upload GST File" : "${gstFileName}",
                          hintColor: gstFileName == null ? AppColor.textColorLightBlack : AppColor.btnBgColorGreen,
                          suffixIcon: InkWell(
                            onTap: onUploadFile,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
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
                    gstFileError != null
                        ? Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              "${gstFileError}",
                              style: mTextStyle12(mColor: Colors.red),
                            ),
                          )
                        : Container(),
                  ],
                )
              : Container(),

          // =========== Update button ================
          heightSpacer(mHeight: 15),
          Update_button_Widget(
            onCancelPress: onCancelPress,
            onUpdatePress: onUpdatePress,
          )
        ],
      ),
    );
  }
}
