import 'package:flutter/material.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/ui_helper.dart';

class Experience_Edit_Widget extends StatelessWidget {
  final TextEditingController editExperience_company;
  final TextEditingController editTotalExpYears;
  final TextEditingController editTotalExpMonths;
  final void Function()? editUpdatePress;
  final void Function()? editCancelPress;

  const Experience_Edit_Widget({
    super.key,
    required this.editExperience_company,
    required this.editTotalExpYears,
    required this.editTotalExpMonths,
    required this.editUpdatePress,
    required this.editCancelPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Edit experience fields",
          style: mTextStyle14(mFontWeight: FontWeight.w500),
        ),
        heightSpacer(),

        // ========= Experience company ==============
        Text(
          "Experience company name",
          style: mTextStyle13(),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: TextFormField(
            controller: editExperience_company,
            style: mTextStyle13(),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: mInputDecoration(
              hint: "Experience company name",
              radius: 5,
              padding: EdgeInsets.only(left: 15),
            ),
          ),
        ),

        // =========== Experience year and months ============
        heightSpacer(),
        Text(
          "Total experience",
          style: mTextStyle13(),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: editTotalExpYears,
                  style: mTextStyle13(),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: mInputDecoration(
                    hint: "Total years",
                    radius: 5,
                    padding: EdgeInsets.only(left: 15),
                    mCounterText: "",
                  ),
                ),
              ),
              widthSpacer(mWidth: 5),
              Expanded(
                child: TextFormField(
                  controller: editTotalExpMonths,
                  style: mTextStyle13(),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: mInputDecoration(
                    hint: "Total months",
                    radius: 5,
                    padding: EdgeInsets.only(left: 15),
                    mCounterText: "",
                  ),
                ),
              ),
            ],
          ),
        ),


        // =========== Update and Cancel Button ===========
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Update_button_Widget(
            onCancelPress: editCancelPress,
            onUpdatePress: editUpdatePress,
          ),
        )
      ],
    );
  }
}
