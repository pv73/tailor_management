import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/ui_helper.dart';

class JobType_Edit_Widget extends StatelessWidget {
  dynamic Function(String, int, bool)? JobTypeOnSelected;
  dynamic Function(String, int, bool)? TailorOnSelected;
  dynamic Function(String, int, bool)? EditGarmentPress;
  void Function()? EditUpdatePress;
  void Function()? EditCancelPress;
  String? selected_JobType;

  JobType_Edit_Widget(
      {required this.JobTypeOnSelected,
      required this.TailorOnSelected,
      required this.selected_JobType,
      required this.EditGarmentPress,
      this.EditUpdatePress,
      this.EditCancelPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================ Garment Category Details ====================
        Text(
          "Garment Category",
          style: mTextStyle13(mColor: AppColor.textColorBlack, mFontWeight: FontWeight.w700),
        ),

        /// =============== Garment Category Button =================
        heightSpacer(mHeight: 10),
        GroupButton(
          options: mGroupButtonOptions(),
          isRadio: false,
          buttons: ["Knits", "Woven", "High Fashion", "Boutique"],
          onSelected: EditGarmentPress,
        ),
        heightSpacer(mHeight: 10),
        Divider(),

        Text(
          "Job type",
          style: mTextStyle15(mColor: AppColor.textColorBlack, mFontWeight: FontWeight.w700),
        ),
        heightSpacer(mHeight: 10),
        GroupButton(
          options: mGroupButtonOptions(),
          isRadio: true,
          buttons: [
            "Tailor",
            "Cutting Machine Operator",
            "Helper",
            "Supervisor",
            "Line In Charge",
            "Quality Controller",
            "Pressman",
            "Thread Cutter"
          ],
          onSelected: JobTypeOnSelected,
        ),

        /// ============ If Tailor Selected ================
        Divider(
          height: 30,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tailor",
              style: mTextStyle15(mColor: AppColor.textColorBlack, mFontWeight: FontWeight.w700),
            ),
            heightSpacer(mHeight: 10),
            GroupButton(
              options: mGroupButtonOptions(),
              isRadio: false,
              buttons: [
                "Salary",
                "Full Piece",
                "Part Rate",
                "Part Time",
                "Hours Basis",
              ],
              onSelected: TailorOnSelected,
            ),
          ],
        ),

        // ========= Update Button ============
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Update_button_Widget(
            onUpdatePress: EditUpdatePress,
            onCancelPress: EditCancelPress,
          ),
        )
      ],
    );
  }
}
