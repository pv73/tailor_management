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

TextStyle mTextStyle10({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 10,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle11({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 11,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle12({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
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
  return TextStyle(fontSize: 13, color: mColor, fontWeight: mFontWeight, letterSpacing: letterSpacing, height: mHeight
      // fontFamily: 'Acumin Variable'
      );
}

TextStyle mTextStyle14({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 14,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle15({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: 15,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle16({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 16,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle17({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 17,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle18({Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 18,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Acumin Variable'
  );
}

TextStyle mTextStyle19({Color mColor = AppColor.textColorBlue, double? mHeight, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(fontSize: 19, color: mColor, fontWeight: mFontWeight, height: mHeight
      // fontFamily: 'Acumin Variable'
      );
}

TextStyle mTextStyle20(
    {Color mColor = AppColor.textColorBlack, FontWeight mFontWeight = FontWeight.w800, FontStyle = FontStyle.italic}) {
  return TextStyle(
    fontSize: 22,
    color: mColor,
    fontWeight: mFontWeight,
    fontStyle: FontStyle,
    // fontFamily: 'Poppins'
  );
}

TextStyle mTextStyle22({Color mColor = AppColor.textColorBlue, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 20,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Poppins'
  );
}

TextStyle mTextStyle24({Color mColor = AppColor.textColorBlue, FontWeight mFontWeight = FontWeight.normal}) {
  return TextStyle(
    fontSize: 24,
    color: mColor,
    fontWeight: mFontWeight,
    // fontFamily: 'Poppins'
  );
}

TextStyle mTextStyle28({Color mColor = AppColor.textColorBlue, FontWeight mFontWeight = FontWeight.normal}) {
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
OutlineInputBorder mGetBorder({double radius = 10, Color borderColor = AppColor.textColorBlack, double borderWidth = 1}) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius), borderSide: BorderSide(color: borderColor, width: borderWidth));
}

// ------------------------------------ //
//   GroupButtonOptions Selection  //
// ------------------------------------ //
GroupButtonOptions mGroupButtonOptions({
  EdgeInsets? textPadding,
}) {
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
    textPadding: textPadding == null ? EdgeInsets.symmetric(horizontal: 13) : textPadding,
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
    backgroundColor: backgroundColor == null ? Colors.grey.shade50 : backgroundColor,
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
        borderRadius: BorderRadius.circular(5.0), // Set your desired radius here
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: titleColor, fontWeight: FontWeight.w500),
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
            style: mTextStyle14(mFontWeight: FontWeight.w600, mColor: AppColor.btnBgColorGreen),
          ),
        ),
      ],
    ),
  );
}

// -------------------------------------------//
//   Card design in used of About us page  //
// -------------------------------------------//

Widget aboutCard_Helper({
  ImageProvider<Object>? image,
  heading,
  text,
}) {
  return Card_Container_Widget(
    mColor: Colors.transparent,
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    child: Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              image: DecorationImage(image: image!),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColor.textColorLightBlack)),
        ),
        heightSpacer(),
        Text(heading!, style: mTextStyle15(), textAlign: TextAlign.center),
        heightSpacer(),
        Text(
          text,
          style: mTextStyle14(),
          textAlign: TextAlign.justify,
        )
      ],
    ),
  );
}

// -------------------------------------------//
//   Text Filed Used in Post Job for Skills member  //
// -------------------------------------------//

Widget Job_TextField({
  TextEditingController? controller,
  required void Function(String)? onChanged,
  String? Text_Hint,
  TextInputType? keyboardType,
  TextCapitalization textCapitalization = TextCapitalization.none,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType == null ? TextInputType.number : keyboardType,
    onChanged: onChanged,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    decoration: mInputDecoration(
      padding: EdgeInsets.only(top: 3, left: 10),
      radius: 5,
      hint: Text_Hint,
      hintColor: AppColor.textColorLightBlack,
      mCounterText: "",
    ),
    textCapitalization: textCapitalization,
  );
}

// -------------------------------------------//
//   Read More Or Read Less Button Used in terms & condition  //
// -------------------------------------------//

Widget ReadMoreAndLessMore_Btn({
  void Function()? onPress,
  String? mText,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 28,
      width: 100,
      alignment: Alignment.topLeft,
      child: Text(
        mText!,
        style: mTextStyle14(mColor: AppColor.btnBgColorGreen, mFontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
      ),
    ),
  );
}

// -------------------------------------------//
/// this code get name word's first letter
/// like Mukesh Kumar then get MK
// -------------------------------------------//

String getInitials(String name) {
  List<String> nameParts = name.split(" "); // Split the name into parts
  String initials = "";

  for (var part in nameParts) {
    if (part.isNotEmpty) {
      initials += part[0]; // Get the first letter of each non-empty part
    }
  }

  return initials;
}

// ==================================================================
//    List for category_Option
Upload_btn({required String btnName, EdgeInsetsGeometry? padding}) {
  return Container(
    padding: padding == null ? EdgeInsets.symmetric(vertical: 14, horizontal: 15) : padding,
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
      btnName,
      style: mTextStyle13(),
      textAlign: TextAlign.center,
    ),
  );
}

// -------------------------------------------//
//   Card design in used of About us page  //
// -------------------------------------------//

Widget Privacy_Policy_Helper({
  required Function()? onPress,
  bool isVisible = false,
  String? heading,
  String? text,
  String? hideText,
  String? btn_Name,
  double? width,
}) {
  return Card_Container_Widget(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.send,
              color: AppColor.btnBgColorGreen,
            ),
            widthSpacer(),
            Expanded(child: Text(heading!, style: mTextStyle15())),
          ],
        ),
        heightSpacer(),
        Text(
          "${text}",
          style: mTextStyle14(),
          textAlign: TextAlign.justify,
        ),

        // Hide and Show
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: width,
          child: isVisible
              ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "${hideText}",
                    style: mTextStyle14(),
                    textAlign: TextAlign.justify,
                  ),
                )
              : null,
        ),

        heightSpacer(mHeight: 5),
        ReadMoreAndLessMore_Btn(onPress: onPress, mText: "${btn_Name}"),
      ],
    ),
  );
}
