import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class CompanyDetailsComponents extends StatelessWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const CompanyDetailsComponents(
      {super.key, required this.firebaseUser, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            companyModel.company_logo != null
                ? CircleAvatar(
                    backgroundColor: AppColor.navBgColor,
                    radius: 35,
                    child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage("${companyModel.company_logo}"),
                    ),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColor.navBgColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 38,
                      child: Text(
                        getInitials("${companyModel.user_name}"),
                        style: mTextStyle24(mFontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.grey.shade300,
            //     radius: 13,
            //     child: Icon(
            //       Icons.camera_alt,
            //       size: 15,
            //     ),
            //   ),
            // ),
          ],
        ),

        // Company Name
        heightSpacer(mHeight: 15),
        TextFormField(
          keyboardType: TextInputType.text,
          maxLines: null,
          readOnly: true,
          style: TextStyle(fontSize: 13),
          decoration: mInputDecoration(
            padding: EdgeInsets.only(top: 3, left: 10),
            radius: 5,
            hint: "${companyModel.company_name}",
            hintColor: AppColor.textColorBlack,
          ),
        ),

        // company Address
        heightSpacer(mHeight: 15),
        TextFormField(
          keyboardType: TextInputType.text,
          maxLines: null,
          readOnly: true,
          style: TextStyle(fontSize: 13),
          decoration: mInputDecoration(
            padding: EdgeInsets.only(top: 3, left: 10),
            radius: 5,
            hint: "${companyModel.address}",
            hintColor: AppColor.textColorBlack,
          ),
        ),
      ],
    );
  }
}
