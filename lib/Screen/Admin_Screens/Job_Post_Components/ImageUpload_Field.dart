import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class ImageUpload_field extends StatelessWidget {
  final File? selected_pic;
  final String? hintText;
  final String? ImageName;
  final void Function()? Upload;
  final EdgeInsetsGeometry? padding;

  ImageUpload_field({
    required this.selected_pic,
    required this.hintText,
    required this.ImageName,
    required this.Upload,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextFormField(
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        readOnly: true,
        decoration: mInputDecoration(
          padding: EdgeInsets.only(top: 3),
          prefixIcon: selected_pic == null
              ? Icon(Icons.file_upload_outlined)
              : Icon(Icons.done_all),
          preFixColor: selected_pic == null
              ? AppColor.textColorLightBlack
              : AppColor.btnBgColorGreen,
          mIconSize: 18,
          radius: 5,
          hint: selected_pic == null ? "$hintText" : "$ImageName",
          hintColor: selected_pic == null
              ? AppColor.textColorLightBlack
              : AppColor.btnBgColorGreen,
          suffixIcon: InkWell(
            onTap: Upload,
            child: Upload_btn(btnName: "Upload"),
          ),
        ),
      ),
    );
  }
}
