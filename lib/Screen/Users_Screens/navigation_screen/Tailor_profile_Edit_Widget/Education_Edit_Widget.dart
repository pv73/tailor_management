import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/ui_helper.dart';

class Education_Edit_Widget extends StatelessWidget {
  dynamic controller;
  List<DropDownValueModel>? dropDownList;
  dynamic Function(String, int, bool)? onSelected;
  void Function(dynamic)? onChanged;
  TextEditingController collage_name;
  TextEditingController pass_year;
  void Function() onCancelPress;
  void Function() onUpdatePress;
  bool isDropDownOption;

  Education_Edit_Widget({
    required this.controller,
    required this.dropDownList,
    required this.onSelected,
    required this.onChanged,
    required this.collage_name,
    required this.pass_year,
    required this.onCancelPress,
    required this.onUpdatePress,
    this.isDropDownOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpacer(mHeight: 10),
        GroupButton(
          options: mGroupButtonOptions(
            textPadding: EdgeInsets.zero,
          ),
          isRadio: true,
          buttons: [" 10th or Below 10th ", " 12th Pass ", "Diploma", "ITI", "Graduate", "  Post Graduate  ", "Other"],
          onSelected: onSelected,
        ),

        /// ==========  Course Options field ===============
        isDropDownOption == false
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Course",
                      style: mTextStyle13(mFontWeight: FontWeight.w500),
                    ),
                    heightSpacer(mHeight: 5),
                    SizedBox(
                      height: 45,
                      child: DropDownTextField(
                        controller: controller,
                        textStyle: mTextStyle13(),
                        listTextStyle: mTextStyle13(),
                        readOnly: true,
                        dropdownRadius: 5,
                        listPadding: ListPadding(bottom: 8, top: 8),
                        textFieldDecoration: mInputDecoration(
                          hint: "Select Course",
                          radius: 5,
                          padding: EdgeInsets.only(top: 10, left: 15),
                        ),
                        dropDownList: dropDownList!,
                        onChanged: onChanged,
                      ),
                    ),
                  ],
                ),
              ),

        // ============= Collage/Institute Name ====================
        heightSpacer(mHeight: 15),
        Text(
          "Collage/Institute Name",
          style: mTextStyle13(mFontWeight: FontWeight.w500),
        ),
        heightSpacer(mHeight: 10),
        SizedBox(
          height: 45,
          child: TextFormField(
            controller: collage_name,
            style: mTextStyle14(),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: mInputDecoration(
              hint: "Collage/Institute Name",
              radius: 5,
              padding: EdgeInsets.only(top: 10, left: 15),
            ),
          ),
        ),

        // ========= Passing Year ============
        heightSpacer(mHeight: 15),
        Text(
          "Passing Year",
          style: mTextStyle13(mFontWeight: FontWeight.w500),
        ),
        heightSpacer(mHeight: 10),
        SizedBox(
          height: 45,
          child: TextFormField(
            controller: pass_year,
            style: mTextStyle14(),
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration:
                mInputDecoration(hint: "Passing Year", radius: 5, padding: EdgeInsets.only(top: 10, left: 15), mCounterText: ""),
          ),
        ),

        // ========== Update button ==============
        heightSpacer(mHeight: 15),
        Update_button_Widget(
          onUpdatePress: onUpdatePress,
          onCancelPress: onCancelPress,
        ),
      ],
    );
  }
}

// =====================================================================
// =================== DropDown Lists ===================================

List<DropDownValueModel> diplomaOptions = [
  DropDownValueModel(name: "Computer Science Engineering", value: "Computer_Science_Eng."),
  DropDownValueModel(name: "Mechanical Engineering", value: "Mechanical_Eng."),
  DropDownValueModel(name: "Electrical Engineering", value: "Electrical_Eng."),
  DropDownValueModel(name: "Civil Engineering", value: "Civil_Eng."),
  DropDownValueModel(name: "Electronics Engineering", value: "Electronics_Eng."),
  DropDownValueModel(name: "Automobile Engineering", value: "Automobile_Eng.")
];

List<DropDownValueModel> itiOptions = [
  DropDownValueModel(name: "Carpenter", value: "Carpenter"),
  DropDownValueModel(name: "Computer Operator", value: "Computer_Operator"),
  DropDownValueModel(name: "Electrician", value: "Electrician"),
  DropDownValueModel(name: "Electronic Mechanic", value: "Electronic_Mechanic"),
  DropDownValueModel(name: "Fitter", value: "Fitter"),
  DropDownValueModel(name: "Plumber", value: "Plumber")
];
