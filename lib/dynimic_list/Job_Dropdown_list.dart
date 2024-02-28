import 'package:dropdown_textfield/dropdown_textfield.dart';

// TODO : ========== Job Post Dropdown list UI Part Widget & etc =====================

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
  DropDownValueModel(name: "Pattern Master", value: "Pattern"),
  DropDownValueModel(name: "Cutting Master", value: "Cutting"),
  DropDownValueModel(name: "Helper", value: "Helper"),
  DropDownValueModel(name: "Supervisor", value: "Supervisor"),
  DropDownValueModel(name: "Pressman", value: "Pressman"),
  DropDownValueModel(name: "Line In Charge", value: "Line_In"),
  DropDownValueModel(name: "Thread Cutter", value: "Thread"),
  DropDownValueModel(name: "Quality Controller", value: "Quality"),
];

// ==================================================================
//    List for department_Option
List<DropDownValueModel> department_Option = [
  DropDownValueModel(name: "Sampling", value: "Sampling"),
  DropDownValueModel(name: "Production", value: "Production"),
  DropDownValueModel(name: "Finishing", value: "Finishing"),
];

// ==================================================================
//    List for category_Options Start
// Category_options are Show 3 Options
// This list create for Category 1st sampling and 3rd alter Options.
List<DropDownValueModel> sampling_Alter_Option = [
  DropDownValueModel(name: "Salary", value: "Samp_Salary"),
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
  DropDownValueModel(name: "Salary", value: "Pro_Salary"),
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
  DropDownValueModel(
      name: "Upload operation breakdown excel (Pdf)", value: "part_rate_excel"),
  DropDownValueModel(
      name: "Upload picture of operation breakdown", value: "part_rate_image"),
  DropDownValueModel(
      name: "Mention part wise rate by inserting boxes",
      value: "part_rate_text"),
];

// If select Full PC in production_Option then show this Options
List<DropDownValueModel> full_Pc_Option = [
  DropDownValueModel(name: "Per PC Rate", value: "Per_PC_Rate"),
];

//    List for category_Options End
// ==================================================================



