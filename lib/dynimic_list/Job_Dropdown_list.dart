import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../ui_helper.dart';

// TODO : ========== Job Post Dropdown list UI Part Widget & etc =====================
/// this code get name word's first letter
/// like Mukesh Kumar then get MK
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
//    List for garment_Option
List<DropDownValueModel> garment_Option = [
  DropDownValueModel(name: "Knits", value: "Knits"),
  DropDownValueModel(name: "Woven", value: "Woven"),
  DropDownValueModel(name: "High Fashion", value: "High_Fashion"),
  DropDownValueModel(name: "Boutique", value: "Boutique"),
];


// ==================================================================
//    List for department_Option
List<DropDownValueModel> job_Type_Option = [
  DropDownValueModel(name: "Tailor", value: "Tailor"),
  DropDownValueModel(
      name: "Cutting Machine Operator", value: "Cutting_Machine_Operator"),
  DropDownValueModel(name: "Helper", value: "Helper"),
  DropDownValueModel(name: "Supervisor", value: "Supervisor"),
  DropDownValueModel(name: "Line In-charge", value: "Line_In-Charge"),
  DropDownValueModel(name: "Quality Controller", value: "Quality_Controller"),
  DropDownValueModel(name: "Pressman", value: "Pressman"),
];

// ==================================================================
//    List for department_Option
List<DropDownValueModel> department_Option = [
  DropDownValueModel(name: "Simpling", value: "Simpling"),
  DropDownValueModel(name: "Production", value: "Production"),
  DropDownValueModel(
      name: "Finishing Alert tailor", value: "Finishing_Alert_Tailor"),
];


// ==================================================================
//    List for category_Options Start
// Category_options are Show 3 Options
// This list create for Category 1st sampling and 3rd alter Options.
List<DropDownValueModel> sampling_Alter_Option = [
  DropDownValueModel(name: "Salary", value: "Salary"),
  DropDownValueModel(name: "Part Time", value: "Part_Time"),
];
        // If select Part Time then show this Options
List<DropDownValueModel> part_Time_Option = [
  DropDownValueModel(name: "PC Rate", value: "PC_Rate"),
  DropDownValueModel(name: "Hourly Basis", value: "Hourly_Basis"),
];

        // If select PC Rate then show this Options
List<DropDownValueModel> pc_Rate_Option = [
  DropDownValueModel(name: "Per PC Rate", value: "Per_PC_Rate"),
];

        // If select Hourly Basis then show this Options
List<DropDownValueModel> hourly_Base_Option = [
  DropDownValueModel(name: "Time Slot", value: "Time_Slot"),
  DropDownValueModel(name: "Per Hourly Rate", value: "Per_Hourly_Rate"),
];

// This list create for Category 2nd production Options.
List<DropDownValueModel> production_Option = [
  DropDownValueModel(name: "Salary", value: "Salary"),
  DropDownValueModel(name: "Part Rate", value: "Part_Rate"),
  DropDownValueModel(name: "Full PC", value: "Full_PC"),
];

        // If select Salary in production_Option then show this Options
List<DropDownValueModel> salary_Option = [
  DropDownValueModel(name: "A Grade", value: "A_Grade"),
  DropDownValueModel(name: "B Grade", value: "B_Grade"),
  DropDownValueModel(name: "C Grade", value: "C_Grade"),
];

        // If select Part Rate in production_Option then show this Options
List<DropDownValueModel> part_Rate_Option = [
  DropDownValueModel(name: "Upload operation breakdown excel", value: "part_rate_excel"),
  DropDownValueModel(name: "Upload picture of operation breakdown", value: "part_rate_image"),
  DropDownValueModel(name: "Mention part wise rate by inserting boxes", value: "part_rate_text"),
];

        // If select Full PC in production_Option then show this Options
List<DropDownValueModel> full_Pc_Option = [
  DropDownValueModel(name: "Per PC Rate", value: "Per_PC_Rate"),
];

//    List for category_Options End
// ==================================================================


// ==================================================================
//    List for WorkedType_Option
List<DropDownValueModel> workType_Option = [
  DropDownValueModel(name: "Work from home", value: "work_fro_home"),
  DropDownValueModel(name: "Part time", value: "part_time"),
  DropDownValueModel(name: "Full time", value: "full_time"),
];

// ==================================================================
//    List for worked Shift_Option
List<DropDownValueModel> workShift_Option = [
  DropDownValueModel(name: "Night Shift", value: "Night_Shift"),
  DropDownValueModel(name: "Day Shift", value: "Day_Shift"),
];

// ==================================================================
//    List for worked Shift_Option
List<DropDownValueModel> interviewMode_Option = [
  DropDownValueModel(name: "In person", value: "In_person"),
  DropDownValueModel(name: "Online", value: "Online"),
];

// ==================================================================
//    List for workLocation_Option
List<DropDownValueModel> workLocation_Option = [
  DropDownValueModel(
      name: "Interview address", value: "interview address"),
  DropDownValueModel(
      name: "Company address", value: "company address"),
];

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
