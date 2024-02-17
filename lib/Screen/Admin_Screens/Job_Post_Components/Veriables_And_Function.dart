import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

TextEditingController garmentQtyController = TextEditingController();
TextEditingController sampling_SalaryController = TextEditingController();
TextEditingController partT_Sub_Cat_Controller = TextEditingController();
TextEditingController grade_Salary_Controller = TextEditingController();
TextEditingController part_Rate_Text_Controller = TextEditingController();
TextEditingController full_Pc_Controller = TextEditingController();
TextEditingController totalTailorController = TextEditingController();
TextEditingController expMiniController = TextEditingController();
TextEditingController expMaxiController = TextEditingController();
TextEditingController stateController = TextEditingController();

List<String> selectedSkills = [];
List<TextEditingController> selectedSkillsControllers = [];
List<String> selectedSkillsEmployee = [];

//Garment filed all Dropdown value
late SingleValueDropDownController garment_value =
    SingleValueDropDownController();
late SingleValueDropDownController job_type_value =
    SingleValueDropDownController();
late SingleValueDropDownController department_value =
    SingleValueDropDownController();
late SingleValueDropDownController category_value =
    SingleValueDropDownController();
late SingleValueDropDownController partTime_Cat_value =
    SingleValueDropDownController();
late SingleValueDropDownController partTime_Sub_Cat_value =
    SingleValueDropDownController();
late SingleValueDropDownController grade_Salary_value =
    SingleValueDropDownController();
late SingleValueDropDownController part_Rate_value =
    SingleValueDropDownController();
late SingleValueDropDownController full_Pc_value =
    SingleValueDropDownController();

// DropDown Option
List<DropDownValueModel> currentCategoryOptions = [];
List<DropDownValueModel> currentPartTimeSubCatOptions = [];

//==== Store Dropdown selected value in String field =======
String? garment;
String? job_Type;
String? department;
String? category;
String? partTime_Cat;
String? partTime_Sub_Cat;
String? grade_Salary;
String? full_Pc;

// =========== Others Variable =================
File? garment_Pic;
String? garmentPicName;
String? work_Type;
String? work_Shift;
String? part_Rate;
File? partRateUrl;
String? partRateUrlName;
String? partRateExcelError;
bool? isLodding;

//  ======== Others Variable for Image path and Name =========
String? garmentImagePath;
String? partRateImagePath;
String? partRate_downloadUrl;
String? garment_downloadUrl;
UploadTask? garmentUploadTask;
UploadTask? pTFileUploadTask;


// ExpansionTile change when any required filed is empty
Color? detailsErrorColor;
Color? totalTailorErrorColor;

//TODO: ===========================================
// ==== Empty Field If change dropdown ==========
SamplingEmptyFields() {
  category_value.clearDropDown();
  category = null;
  partTime_Cat_value.clearDropDown();
  partTime_Cat = null;
  partTime_Sub_Cat_value.clearDropDown();
  partTime_Sub_Cat = null;
  sampling_SalaryController.text = "";
  partT_Sub_Cat_Controller.text = "";
}

ProSalaryEmptyFields() {
  grade_Salary_value.clearDropDown();
  grade_Salary = null;
  grade_Salary_Controller.text = "";
}

PartRateEmptyFields() {
  part_Rate_value.clearDropDown();
  part_Rate = null;
  partRateUrl = null;
  partRateUrlName = null;
  part_Rate_Text_Controller.text = "";
}

FullPcEmptyFields() {
  full_Pc_value.clearDropDown();
  full_Pc = null;
  full_Pc_Controller.text = "";
}

PartRateImgEmptyFields() {
  part_Rate_Text_Controller.text = "";
  partRateUrl = null; // Empty Image
  partRateUrlName = null; // Emp Image Name
}

//TODO: ===========================================
// ==== If job post done then Empty all Fields ==========
void isSubmit_ClearFormFields() {
  garment_value.clearDropDown();
  garment = null;
  garment_Pic = null;
  garmentQtyController.text = "";
  work_Type = null;
  work_Shift = null;
  job_type_value.clearDropDown();
  job_Type = null;
  department_value.clearDropDown();
  department = null;
  category_value.clearDropDown();
  category = null;
  sampling_SalaryController.text = "";
  partTime_Cat_value.clearDropDown();
  partTime_Cat = null;
  partT_Sub_Cat_Controller.text = "";
  partTime_Sub_Cat_value.clearDropDown();
  partTime_Sub_Cat = null;
  grade_Salary_value.clearDropDown();
  grade_Salary = null;
  grade_Salary_Controller.text = "";
  part_Rate_Text_Controller.text = "";
  part_Rate_value.clearDropDown();
  part_Rate = null;
  partRateUrl = null;
  full_Pc_value.clearDropDown();
  full_Pc = null;
  full_Pc_Controller.text = "";
  totalTailorController.text = "";
  expMiniController.text = "";
  expMaxiController.text = "";
  selectedSkills.clear();
  selectedSkillsEmployee.clear();
}

// TODO : ==================================================
// first check filed is not empty then change Expansion color ===========

void CheckFieldThenChangeColor() {
  // ========== Job Details ==========
  if (garment == null ||
      work_Type == null ||
      work_Shift == null ||
      job_Type == null ||
      department == null) {
    detailsErrorColor = Colors.red.shade50;
  } else {
    detailsErrorColor = null;
  }

  // =========== Total Tailor ===========
  if (totalTailorController.text.isEmpty) {
    totalTailorErrorColor = Colors.red.shade50;
  } else {
    totalTailorErrorColor = null;
  }

}




