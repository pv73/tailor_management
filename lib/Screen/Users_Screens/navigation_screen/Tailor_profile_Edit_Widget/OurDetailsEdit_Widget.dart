import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/ui_helper.dart';

class OurDetailsEdit_Widget extends StatelessWidget {
  TextEditingController? userNameController;
  TextEditingController? dateInputController;
  TextEditingController? mobileController;
  TextEditingController? emailController;
  TextEditingController? permanentAddressController;
  TextEditingController? addressController;
  dynamic Function(String, int, bool)? onSelectedGender;
  void Function()? onUpdatePress;
  void Function()? onCancelPress;
  void Function()? dateClick;

  OurDetailsEdit_Widget({
    this.userNameController,
    this.dateInputController,
    this.mobileController,
    this.emailController,
    this.permanentAddressController,
    this.addressController,
    this.onSelectedGender,
    this.onUpdatePress,
    this.onCancelPress,
    this.dateClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  ============ Name Field =============
          Text(
            "Full Name",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          TextFiled(
            textController: userNameController,
            hint: "Enter you name",
          ),

          //  ============ DOB Field =============
          heightSpacer(),
          Text(
            "Date of Birth",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          TextFormField(
            controller: dateInputController,
            style: mTextStyle14(),
            keyboardType: TextInputType.datetime,
            readOnly: true,
            decoration: mInputDecoration(
              hint: "Enter Date",
              suffixIcon: Icon(Icons.calendar_month_outlined),
              radius: 5,
              padding: EdgeInsets.only(top: 10, left: 15),
            ),
            onTap: dateClick,
          ),

          //  ============ Phone Field =============
          heightSpacer(),
          Text(
            "Mobile number",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          TextFiled(
            textController: mobileController,
            keyboardType: TextInputType.number,
            hint: "Mobile number",
          ),

          //  ============ Email Field =============
          heightSpacer(),
          Text(
            "Email Id",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          TextFormField(
            controller: emailController,
            enabled: false,
            style: mTextStyle14(),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.textColorBlack, width: 2),
              ),
              hintText: "Email Id",
            ),
          ),

          //  ============ Gender Field =============
          heightSpacer(),
          Text(
            "Gender",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          GroupButton(
            options: mGroupButtonOptions(),
            isRadio: true,
            buttons: ["Male", "Female"],
            onSelected: onSelectedGender,
          ),

          //  ============ permanentAddress Field =============
          heightSpacer(),
          Text(
            "Permanent Address",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          TextFiled(
            textController: permanentAddressController,
            keyboardType: TextInputType.multiline,
            hint: "Permanent Address",
          ),

          //  ============ address Field =============
          heightSpacer(),
          Text(
            "Address",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
          ),
          heightSpacer(mHeight: 10),
          TextFiled(
            textController: addressController,
            keyboardType: TextInputType.multiline,
            hint: "Address",
          ),

          // =========== Submit Button =============
          heightSpacer(),
          Update_button_Widget(
            onUpdatePress: onUpdatePress,
            onCancelPress: onCancelPress,
          )
        ],
      ),
    );
  }

  Widget TextFiled({TextEditingController? textController, hint, TextInputType? keyboardType = TextInputType.text,}) {
    return TextFormField(
      controller: textController,
      style: mTextStyle14(),
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.textColorBlack, width: 2),
        ),
      ),
    );
  }
}
