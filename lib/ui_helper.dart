import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

// ------------------------------------ //
//       All Colors Selection  //

class AppColor {
  // background and btn color
  static const bgColorWhite = Color(0xffffffff);
  static const btnBgColorGreen = Color(0xff1f8168);
  static const activeColor = Color(0xff5fb8f0);
  static const cardBtnBgGreen = Color(0xff048126);
  static const navBgColor = Color(0xff3a5999);
  static const bgColorBlue = Color(0xffE3F2FD);

  // text Color
  static const textColorWhite = Color(0xffffffff);
  static const textColorBlue = Color(0xff3a5999);
  static const textColorBlack = Color(0xff000000);
  static const textColorLightBlack = Color(0xff767676);
}

// ------------------------------------ //
//       Text Style Selection  //
// ------------------------------------ //

TextStyle mTextStyle10(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 10,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle11(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 11,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle12(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 12,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle13(
    {Color mColor = AppColor.textColorBlack,
    double? mHeight,
    FontWeight mFontWeight = FontWeight.normal,
    double letterSpacing = 0.0}) {
  return TextStyle(
      fontSize: 13,
      color: mColor,
      fontWeight: mFontWeight,
      letterSpacing: letterSpacing,
      height: mHeight
      // fontFamily: 'Acumin Variable'
      );
}

TextStyle mTextStyle14(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 14,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle15(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: 15,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle16(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 16,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle17(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 17,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle18(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 18,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle19(
    {Color mColor = AppColor.textColorBlue,
    double? mHeight,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
      fontSize: 19, color: mColor, fontWeight: mFontWeight, height: mHeight
      // fontFamily: 'Acumin Variable'
      );
}

TextStyle mTextStyle20(
    {Color mColor = AppColor.textColorBlack,
    FontWeight mFontWeight = FontWeight.w800,
    FontStyle = FontStyle.italic}) {
  return TextStyle(
    fontSize: 22,
    color: mColor,
    fontWeight: mFontWeight,
    fontStyle: FontStyle,
    // fontFamily: 'Poppins'
  );
}

TextStyle mTextStyle22(
    {Color mColor = AppColor.textColorBlue,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 20,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Poppins'
  );
}

TextStyle mTextStyle24(
    {Color mColor = AppColor.textColorBlue,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 24,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Poppins'
  );
}

TextStyle mTextStyle28(
    {Color mColor = AppColor.textColorBlue,
    FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 28,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

// ------------------------------------ //
//   Spacer Widget Selection  //
// ------------------------------------ //

Widget widthSpacer({double mWidth = 10.0}) {
  return SizedBox(
    width: mWidth,
  );
}

Widget heightSpacer({double mHeight = 10.0}) {
  return SizedBox(
    height: mHeight,
  );
}

// ------------------------------------ //
//   InputDecoration Selection  //
// ------------------------------------ //

InputDecoration mInputDecoration({
  String? hint,
  String? mLabelText,
  double? mFontSize,
  double? mIconSize,
  Color? filledColor = AppColor.bgColorWhite,
  Color? preFixColor = AppColor.textColorBlue,
  Color? suffixColor = AppColor.textColorBlue,
  Color? hintColor = AppColor.textColorLightBlack,
  Color? labelColor = AppColor.textColorBlue,
  double radius = 15,
  Widget? prefixIcon,
  EdgeInsetsGeometry? padding,
  Widget? suffixIcon,
  String? mCounterText,
}) {
  return InputDecoration(
    filled: true,
    fillColor: filledColor,
    hintText: hint,
    hintStyle: TextStyle(color: hintColor, fontSize: mFontSize),
    labelText: mLabelText,
    labelStyle: TextStyle(color: labelColor, fontSize: mFontSize),
    prefixIcon: prefixIcon != null ? prefixIcon : null,
    prefixIconColor: preFixColor,
    counterText: mCounterText,
    contentPadding: padding,
    suffixIcon: suffixIcon != null ? suffixIcon : null,
    suffixIconColor: suffixColor,
    enabledBorder: mGetBorder(radius: radius),
    focusedBorder: mGetBorder(radius: radius),
  );
}

// ------------------------------------ //
//   InputDecoration Selection  //
// ------------------------------------ //
OutlineInputBorder mGetBorder(
    {double radius = 10,
    Color borderColor = AppColor.textColorBlack,
    double borderWidth = 1}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: borderWidth));
}

// ------------------------------------ //
//   GroupButtonOptions Selection  //
// ------------------------------------ //
GroupButtonOptions mGroupButtonOptions() {
  return GroupButtonOptions(
    mainGroupAlignment: MainGroupAlignment.start,
    spacing: 5,
    unselectedTextStyle: mTextStyle12(),
    selectedTextStyle: mTextStyle12(mColor: Colors.white),
    borderRadius: BorderRadius.circular(20),
    buttonHeight: 30,
    unselectedBorderColor: AppColor.textColorLightBlack,
    selectedColor: AppColor.activeColor,
    selectedBorderColor: AppColor.activeColor,
    textPadding: EdgeInsets.symmetric(horizontal: 13),
  );
}

// ------------------------------------ //
//   GroupButtonOptions Selection  //
// ------------------------------------ //
GroupButtonOptions mAdminPageGroupButtonOptions() {
  return GroupButtonOptions(
    mainGroupAlignment: MainGroupAlignment.start,
    spacing: 5,
    unselectedTextStyle: mTextStyle11(),
    selectedTextStyle: mTextStyle11(mColor: Colors.white),
    borderRadius: BorderRadius.circular(5),
    buttonHeight: 30,
    unselectedBorderColor: AppColor.textColorLightBlack,
    selectedColor: AppColor.activeColor,
    selectedBorderColor: AppColor.activeColor,
    textPadding: EdgeInsets.symmetric(horizontal: 10),
  );
}

// ------------------------------------ //
//  Card_Container Widget  //
// ------------------------------------ //
Widget Card_Container_Widget(
    {Widget? child,
    double? mHeight,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? mColor = Colors.white,
    Color? mBorderColor = const Color(0xFFBDBDBD)}) {
  return Container(
    width: double.infinity,
    height: mHeight,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      color: mColor,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: mBorderColor!,
      ),
    ),
    child: child,
  );
}

// --------------------------------------------- //
//   ExpansionTile in page job post page
// --------------------------------------------//

Widget Custom_ExpansionTile({
  required Widget title,
  void Function(bool)? onExpansionChanged,
  List<Widget> children = const <Widget>[],
  Widget? trailing,
  Color? collapsedBackgroundColor,
  Color? backgroundColor,
  bool initiallyExpanded = false,
}) {
  return ExpansionTile(
    initiallyExpanded: initiallyExpanded,
    trailing: trailing,
    collapsedBackgroundColor: collapsedBackgroundColor,
    childrenPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    backgroundColor:
        backgroundColor == null ? Colors.grey.shade50 : backgroundColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: AppColor.navBgColor),
    ),
    collapsedShape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    title: title,
    children: children,
    onExpansionChanged: onExpansionChanged,
  );
}

// ------------------------------------------//
//    DropDownTextField in page job post page
// ------------------------------------------//

Widget Custom_DropDownTextField({
  required List<DropDownValueModel> dropDownList,
  dynamic controller,
  void Function(dynamic)? onChanged,
  String? hint,
}) {
  return DropDownTextField(
      listTextStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      controller: controller,
      readOnly: true,
      dropdownRadius: 5,
      listPadding: ListPadding(bottom: 10, top: 7),
      textFieldDecoration: mInputDecoration(
        padding: EdgeInsets.only(top: 3, left: 10, bottom: 3),
        radius: 5,
        hint: hint,
        hintColor: AppColor.textColorLightBlack,
      ),
      dropDownList: dropDownList,
      onChanged: onChanged);
}

// -------------------------------------------//
//   Alert Box //
// -------------------------------------------//
alertBox(
  BuildContext context, {
  titleColor,
  title,
  content,
  required void Function()? okayPress,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(5.0), // Set your desired radius here
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16, color: titleColor, fontWeight: FontWeight.w500),
      ),
      content: Text(content),
      actions: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: mTextStyle14(mFontWeight: FontWeight.w600),
            )),
        widthSpacer(),
        InkWell(
          onTap: okayPress,
          child: Text(
            "Okay",
            style: mTextStyle14(
                mFontWeight: FontWeight.w600, mColor: AppColor.btnBgColorGreen),
          ),
        ),
      ],
    ),
  );
}


