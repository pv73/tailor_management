import 'dart:developer';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Company_Details.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/dynimic_list/Job_Dropdown_list.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Post_Job extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  Post_Job({super.key, required this.firebaseUser, required this.companyModel});

  @override
  State<Post_Job> createState() => _Post_JobState();
}

class _Post_JobState extends State<Post_Job> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController garmentQtyController = TextEditingController();
  TextEditingController jobDesController = TextEditingController();
  TextEditingController totalTailorController = TextEditingController();
  TextEditingController stitchingPriceController = TextEditingController();
  TextEditingController cateSalaryController = TextEditingController();
  TextEditingController grade_Salary_Controller = TextEditingController();
  TextEditingController part_Rate_Text_Controller = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController expMinimumController = TextEditingController();
  TextEditingController expMaximumController = TextEditingController();
  TextEditingController job_Responsibilities = TextEditingController();
  TextEditingController interviewAddressController = TextEditingController();
  TextEditingController minimumSalaryController = TextEditingController();
  TextEditingController maxmimumSalaryController = TextEditingController();
  List<String> selectedSkills = [];
  List<String> selectedEducation = [];

  //Garment filed all Dropdown value
  late SingleValueDropDownController garment_value =
      SingleValueDropDownController();
  late SingleValueDropDownController department_value =
      SingleValueDropDownController();
  late SingleValueDropDownController job_type_value =
      SingleValueDropDownController();
  late SingleValueDropDownController totalSkillEmp_value =
      SingleValueDropDownController();
  late SingleValueDropDownController category_value =
      SingleValueDropDownController();
  late SingleValueDropDownController Part_Time_Cate_value =
      SingleValueDropDownController();
  late SingleValueDropDownController part_Time_Sub_Cate_value =
      SingleValueDropDownController();
  late SingleValueDropDownController grade_Salary_value =
      SingleValueDropDownController();
  late SingleValueDropDownController part_Rate_value =
      SingleValueDropDownController();
  late SingleValueDropDownController full_Pc_value =
      SingleValueDropDownController();
  late SingleValueDropDownController workType_value =
      SingleValueDropDownController();
  late SingleValueDropDownController workShift_value =
      SingleValueDropDownController();
  late SingleValueDropDownController interviewMode_value =
      SingleValueDropDownController();
  late SingleValueDropDownController workLocation_value =
      SingleValueDropDownController();

  //dropdown options
  List<DropDownValueModel> currentCategoryOptions = [];
  List<DropDownValueModel> currentPartTimeCateOptions = [];

  //
  DateTime? mDateTime;
  String? garment_type;
  String? department;
  String? job_type;
  String? category;
  String? part_Time_Category;
  String? part_Time_Sub_Category;
  String? grade_Salary;
  String? part_Rate;
  String? full_Pc;
  File? garment_pic;
  File? partRateImage;
  String selectedValue = "Image";
  String? workType;
  String? workShift;
  String? interviewMode;
  String? workLocation;
  bool? isLodding = false;
  bool? isGarmentImage = false;

  // ExpansionTile change when any required filed is empty
  Color? detailsErrorColor;
  Color? totalErrorColor;
  Color? experienceErrorColor;
  Color? moreInfoErrorColor;
  Color? interviewErrorColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(text: "Post ", style: mTextStyle20(), children: [
            TextSpan(
                text: "new job",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
        ),
      ),
      drawer: Drawer_Widget(
          isCurUserCom: true,
          firebaseUser: widget.firebaseUser,
          companyModel: widget.companyModel),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                    child: Text(
                      "Post your new job for users",
                      style: mTextStyle16(mFontWeight: FontWeight.w800),
                    ),
                  ),
                  heightSpacer(mHeight: 1),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                    child: Text(
                      "Fill all fields to upload job",
                      style: mTextStyle13(
                          mColor: AppColor.textColorLightBlack,
                          mFontWeight: FontWeight.w500),
                    ),
                  ),

                  /// Form
                  heightSpacer(mHeight: 20),
                  Form(
                    key: _formKey,
                    child: Container(
                      color: AppColor.textColorWhite,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Company Details ExpansionTile
                          Custom_ExpansionTile(
                            collapsedBackgroundColor: Color(0x47BEDFFF),
                            title: Text(
                              "Company Details",
                              style: mTextStyle14(mFontWeight: FontWeight.w600),
                            ),
                            children: [
                              CompanyDetailsComponents(
                                firebaseUser: widget.firebaseUser,
                                companyModel: widget.companyModel,
                              )
                            ],
                          ),

                          // Job Details ExpansionTile
                          heightSpacer(),
                          Custom_ExpansionTile(
                            collapsedBackgroundColor: detailsErrorColor != null
                                ? detailsErrorColor
                                : Color(0x47BEDFFF),
                            backgroundColor: detailsErrorColor != null
                                ? detailsErrorColor
                                : Colors.grey.shade50,
                            title: Row(
                              children: [
                                Text(
                                  "Job Details",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w600),
                                ),
                                Text(
                                  " *",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w800,
                                      mColor: Colors.red),
                                ),
                              ],
                            ),
                            children: [
                              // GARMENT TYPE
                              Custom_DropDownTextField(
                                hint: "Garment Type *",
                                controller: garment_value,
                                dropDownList: garment_Option,
                                onChanged: (value) {
                                  if (value != null) {
                                    garment_type =
                                        garment_value.dropDownValue?.name;
                                    setState(() {
                                      detailsErrorColor = null;
                                    });
                                  } else {
                                    // Handle the case when nothing is selected
                                    garment_type = null;
                                  }

                                  setState(() {});
                                },
                              ),

                              // Garment Order
                              heightSpacer(),
                              TextFormField(
                                controller: garmentQtyController,
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                decoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Garment Order Quantity",
                                  hintColor: AppColor.textColorLightBlack,
                                  mCounterText: "",
                                ),
                              ),

                              // Job Type
                              heightSpacer(),
                              Custom_DropDownTextField(
                                hint: "Job Type *",
                                controller: job_type_value,
                                dropDownList: job_Type_Option,
                                onChanged: (value) {
                                  if (value != null) {
                                    job_type =
                                        job_type_value.dropDownValue?.name;
                                    setState(() {
                                      detailsErrorColor = null;
                                    });
                                  } else {
                                    // Handle the case when nothing is selected
                                    job_type = null;
                                  }

                                  setState(() {});
                                },
                              ),

                              // Department
                              heightSpacer(),
                              Custom_DropDownTextField(
                                hint: "Tailor Department *",
                                controller: department_value,
                                dropDownList: department_Option,
                                onChanged: (value) {
                                  // Store department data
                                  if (value != null) {
                                    department =
                                        department_value.dropDownValue?.name;
                                    setState(() {
                                      detailsErrorColor = null;
                                    });
                                  } else {
                                    // Handle the case when nothing is selected
                                    department = null;
                                  }

                                  // this line create because i check which selected value in department and Store value in isDepartment
                                  String? isDepartment =
                                      department_value.dropDownValue?.value;

                                  setState(() {
                                    // Close the dropdown list when the education value changes
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    if (isDepartment == "Simpling") {
                                      EmptyFields(isDepartment);
                                      currentCategoryOptions =
                                          sampling_Alter_Option;
                                    } else if (isDepartment == "Production") {
                                      EmptyFields(isDepartment);
                                      currentCategoryOptions =
                                          production_Option;
                                    } else if (isDepartment ==
                                        "Finishing_Alert_Tailor") {
                                      EmptyFields(isDepartment);
                                      currentCategoryOptions =
                                          sampling_Alter_Option;
                                    } else {
                                      // For other education types, you can set a hide branch name and Option text field.
                                      currentCategoryOptions;
                                    }
                                  });
                                },
                              ),

                              // This Container Only Show when Select Simpling and Finishing_Alert_Tailor in Tailor Department
                              Container(
                                child: Column(
                                  children: [
                                    // Category dropdown
                                    heightSpacer(),
                                    department == "Simpling" ||
                                            department ==
                                                "Finishing Alert tailor"
                                        ? Row(
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Custom_DropDownTextField(
                                                  hint: "Tailor Category",
                                                  controller: category_value,
                                                  dropDownList:
                                                      currentCategoryOptions,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      category = category_value
                                                          .dropDownValue?.name;
                                                    } else {
                                                      // Handle the case when nothing is selected
                                                      category = null;
                                                    }

                                                    setState(() {});
                                                  },
                                                ),
                                              ),

                                              // If Salary is Yes then fill Salary in Tailor Category dropdown
                                              category == "Salary"
                                                  ? Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: TextFormField(
                                                          controller:
                                                              cateSalaryController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          decoration:
                                                              mInputDecoration(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 3,
                                                                    left: 10),
                                                            radius: 5,
                                                            hint:
                                                                "Amount (INR)",
                                                            hintColor: AppColor
                                                                .textColorLightBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          )
                                        : Container(),

                                    // part_Rate_Department, this only visible when Part Time selected in Tailor Category
                                    category == "Part Time"
                                        ? Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Custom_DropDownTextField(
                                              hint: "Part Time Department",
                                              controller: Part_Time_Cate_value,
                                              dropDownList: part_Time_Option,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  part_Time_Category =
                                                      Part_Time_Cate_value
                                                          .dropDownValue?.name;
                                                  // print(job_type_value.dropDownValue?.name);
                                                } else {
                                                  // Handle the case when nothing is selected
                                                  part_Time_Category = null;
                                                }

                                                // this line create because i check which selected value in department and Store value in isDepartment
                                                String? isPTime_Department =
                                                    Part_Time_Cate_value
                                                        .dropDownValue?.value;

                                                setState(() {
                                                  // Close the dropdown list when the education value changes
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());

                                                  if (isPTime_Department ==
                                                      "PC_Rate") {
                                                    currentPartTimeCateOptions =
                                                        pc_Rate_Option;
                                                    part_Time_Sub_Cate_value
                                                        .clearDropDown();
                                                    part_Time_Sub_Category =
                                                        null;
                                                  } else if (isPTime_Department ==
                                                      "Hourly_Basis") {
                                                    currentPartTimeCateOptions =
                                                        hourly_Base_Option;
                                                    part_Time_Sub_Cate_value
                                                        .clearDropDown();
                                                    part_Time_Sub_Category =
                                                        null;
                                                  } else {
                                                    currentPartTimeCateOptions;
                                                  }
                                                });
                                              },
                                            ),
                                          )
                                        : Container(),

                                    // this Filed show when select any option in Part Time Department
                                    part_Time_Category == null ||
                                            department == null
                                        ? Container()
                                        : Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Custom_DropDownTextField(
                                              hint: part_Time_Category ==
                                                      "PC Rate"
                                                  ? "Select PC Rate"
                                                  : "Select Hourly Basis",
                                              controller:
                                                  part_Time_Sub_Cate_value,
                                              dropDownList:
                                                  currentPartTimeCateOptions,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  part_Time_Sub_Category =
                                                      part_Time_Sub_Cate_value
                                                          .dropDownValue?.name;
                                                  // print(part_Time_value.dropDownValue?.name);
                                                } else {
                                                  // Handle the case when nothing is selected
                                                  part_Time_Sub_Category = null;
                                                }

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              // This Container Show Only when Select Production in Tailor Department
                              Container(
                                child: Column(
                                  children: [
                                    department == "Production"
                                        ? Row(
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Custom_DropDownTextField(
                                                  hint: "Tailor Category",
                                                  controller: category_value,
                                                  dropDownList:
                                                      currentCategoryOptions,
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      category = category_value
                                                          .dropDownValue?.name;
                                                      // print(category_value.dropDownValue?.name);
                                                    } else {
                                                      // Handle the case when nothing is selected
                                                      category = null;
                                                    }
                                                    setState(() {
                                                      EmptyFields(category);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),

                                    // This Salary Part only visible If selected salary in Production Department
                                    category == "Salary" &&
                                            department == "Production"
                                        ? Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child:
                                                      Custom_DropDownTextField(
                                                    hint: "Grade Salary",
                                                    controller:
                                                        grade_Salary_value,
                                                    dropDownList: salary_Option,
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        grade_Salary =
                                                            grade_Salary_value
                                                                .dropDownValue
                                                                ?.name;
                                                      } else {
                                                        // Handle the case when nothing is selected
                                                        grade_Salary = null;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              widthSpacer(),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: TextFormField(
                                                    controller:
                                                        grade_Salary_Controller,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 5,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    decoration:
                                                        mInputDecoration(
                                                      padding: EdgeInsets.only(
                                                          top: 3, left: 10),
                                                      radius: 5,
                                                      hint: "Amount *",
                                                      hintColor: AppColor
                                                          .textColorLightBlack,
                                                      mCounterText: "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),

                                    // This Option Part only visible If selected Part Rate in Production Department
                                    category == "Part Rate" &&
                                            department == "Production"
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child:
                                                          Custom_DropDownTextField(
                                                        hint: "Select Option",
                                                        controller:
                                                            part_Rate_value,
                                                        dropDownList:
                                                            part_Rate_Option,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            // Close the dropdown list when the education value changes
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    FocusNode());

                                                            if (value != null) {
                                                              String?
                                                                  isPart_Rate =
                                                                  part_Rate_value
                                                                      .dropDownValue
                                                                      ?.value;
                                                              if (isPart_Rate ==
                                                                  "part_rate_excel") {
                                                                part_Rate =
                                                                    "part_Rate_Excel";
                                                              } else if (isPart_Rate ==
                                                                  "part_rate_image") {
                                                                part_Rate =
                                                                    "part_Rate_Image";
                                                              } else if (isPart_Rate ==
                                                                  "part_rate_text") {
                                                                part_Rate =
                                                                    "part_Rate_Text";
                                                              } else {
                                                                part_Rate =
                                                                    null;
                                                              }
                                                            } else {
                                                              part_Rate_value;
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                  // PartRate Upload Button not Visible if not select any option and select Part Rate Text option
                                                  part_Rate == null ||
                                                          part_Rate ==
                                                              "part_Rate_Text"
                                                      ? Container()
                                                      : Expanded(
                                                          flex: 2,
                                                          child: part_Rate ==
                                                                  "part_Rate_Excel"
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              10),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child: Upload_btn(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                14,
                                                                            horizontal:
                                                                                5),
                                                                        btnName:
                                                                            "Upload"),
                                                                  ),
                                                                )
                                                              : Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              10),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child: Upload_btn(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                14,
                                                                            horizontal:
                                                                                5),
                                                                        btnName:
                                                                            "Upload"),
                                                                  ),
                                                                ),
                                                        ),
                                                ],
                                              ),

                                              // This TextField is Show when selected part_Rate_Text in part_Rate_Option]
                                              part_Rate == "part_Rate_Text"
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller:
                                                            part_Rate_Text_Controller,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        decoration:
                                                            mInputDecoration(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 3,
                                                                  left: 10),
                                                          radius: 5,
                                                          hint:
                                                              "Part Rate Text",
                                                          hintColor: AppColor
                                                              .textColorLightBlack,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          )
                                        : Container(),

                                    // This Fer PC Rate only visible If selected Full PC in Production Department
                                    category == "Full PC" &&
                                            department == "Production"
                                        ? Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Custom_DropDownTextField(
                                              hint: "Select Option",
                                              controller: full_Pc_value,
                                              dropDownList: full_Pc_Option,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  full_Pc = full_Pc_value
                                                      .dropDownValue?.name;
                                                }
                                                setState(() {});
                                              },
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          //Total Tailor & Skills
                          heightSpacer(),
                          Custom_ExpansionTile(
                            collapsedBackgroundColor: totalErrorColor != null
                                ? totalErrorColor
                                : Color(0x47BEDFFF),
                            backgroundColor: totalErrorColor != null
                                ? totalErrorColor
                                : Colors.grey.shade50,
                            title: Row(
                              children: [
                                Text(
                                  "Total Tailor & Skills",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w600),
                                ),
                                Text(
                                  " *",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w800,
                                      mColor: Colors.red),
                                ),
                              ],
                            ),
                            children: [
                              // Total Tailor
                              TextFormField(
                                controller: totalTailorController,
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                onChanged: (value) {
                                  setState(() {
                                    totalErrorColor = null;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                decoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Total Tailor *",
                                  hintColor: AppColor.textColorLightBlack,
                                  mCounterText: "",
                                ),
                              ),

                              // Stitching price
                              heightSpacer(),
                              TextFormField(
                                controller: stitchingPriceController,
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                decoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Stitching Price (INR)",
                                  hintColor: AppColor.textColorLightBlack,
                                  mCounterText: "",
                                ),
                              ),

                              /// Skills Button
                              heightSpacer(),
                              Card_Container_Widget(
                                padding: EdgeInsets.all(8),
                                mBorderColor: AppColor.textColorLightBlack,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Select Tailor Skills",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          " *",
                                          style: mTextStyle14(
                                              mFontWeight: FontWeight.w800,
                                              mColor: Colors.red),
                                        ),
                                      ],
                                    ),
                                    heightSpacer(),
                                    GroupButton(
                                      options: mAdminPageGroupButtonOptions(),
                                      isRadio: false,
                                      buttons: [
                                        "Single Needle Operator",
                                        "Feedup Machine Operator",
                                        "Cutting Machine Operator",
                                        "Consie Machine Operator",
                                        "Bartack Machine Operator",
                                        "Flatlock Operator",
                                        "Overlock Operator",
                                        "Other"
                                      ],
                                      onSelected:
                                          (skills_btn_name, index, isSelected) {
                                        if (isSelected) {
                                          selectedSkills.add(skills_btn_name);
                                          setState(() {
                                            totalErrorColor = null;
                                          });
                                        } else {
                                          selectedSkills
                                              .remove(skills_btn_name);
                                        }

                                        print(selectedSkills);
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              /// Salary
                              // heightSpacer(),
                              // Card_Container_Widget(
                              //   padding: EdgeInsets.all(8),
                              //   mBorderColor: AppColor.textColorLightBlack,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Row(
                              //         children: [
                              //           Text(
                              //             "Enter Salary",
                              //             style: mTextStyle13(
                              //                 mFontWeight: FontWeight.w600),
                              //           ),
                              //           Text(
                              //             " *",
                              //             style: mTextStyle14(
                              //                 mFontWeight: FontWeight.w800,
                              //                 mColor: Colors.red),
                              //           ),
                              //         ],
                              //       ),
                              //       heightSpacer(),
                              //       Row(
                              //         children: [
                              //           // minimum Salary
                              //           Expanded(
                              //             child: TextFormField(
                              //               controller: minimumSalaryController,
                              //               keyboardType: TextInputType.number,
                              //               maxLength: 5,
                              //               validator: (value) {
                              //                 if (value == null ||
                              //                     value.isEmpty) {
                              //                   return 'Please enter minimum Salary';
                              //                 }
                              //                 return null;
                              //               },
                              //               style: TextStyle(
                              //                   fontSize: 13,
                              //                   fontWeight: FontWeight.w400),
                              //               decoration: mInputDecoration(
                              //                 padding: EdgeInsets.only(
                              //                     top: 3, left: 10),
                              //                 radius: 5,
                              //                 hint: "Minimum (INR)",
                              //                 mCounterText: "",
                              //                 hintColor:
                              //                     AppColor.textColorLightBlack,
                              //               ),
                              //             ),
                              //           ),
                              //           widthSpacer(),
                              //           // maxmimum Salary
                              //           Expanded(
                              //             child: TextFormField(
                              //               controller:
                              //                   maxmimumSalaryController,
                              //               keyboardType: TextInputType.number,
                              //               maxLength: 5,
                              //               style: TextStyle(
                              //                   fontSize: 13,
                              //                   fontWeight: FontWeight.w400),
                              //               decoration: mInputDecoration(
                              //                 padding: EdgeInsets.only(
                              //                     top: 3, left: 10),
                              //                 radius: 5,
                              //                 hint: "Maxmimum (INR)",
                              //                 mCounterText: "",
                              //                 hintColor:
                              //                     AppColor.textColorLightBlack,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),

                          // Upload Image
                          heightSpacer(),
                          Custom_ExpansionTile(
                              collapsedBackgroundColor: Color(0x47BEDFFF),
                              title: Text(
                                "Upload Image",
                                style:
                                    mTextStyle14(mFontWeight: FontWeight.w600),
                              ),
                              children: [
                                //Garment Image upload
                                heightSpacer(),
                                TextFormField(
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  readOnly: true,
                                  decoration: mInputDecoration(
                                    padding: EdgeInsets.only(top: 3),
                                    prefixIcon: garment_pic == null
                                        ? Icon(Icons.file_upload_outlined)
                                        : Icon(Icons.done_all),
                                    preFixColor: garment_pic == null
                                        ? AppColor.textColorLightBlack
                                        : AppColor.btnBgColorGreen,
                                    mIconSize: 18,
                                    radius: 5,
                                    hint: garment_pic == null
                                        ? "Garment Images"
                                        : "${garmentImageName}",
                                    hintColor: garment_pic == null
                                        ? AppColor.textColorLightBlack
                                        : AppColor.btnBgColorGreen,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        showBottomSheet();
                                        isGarmentImage = true;
                                      },
                                      child: Upload_btn(btnName: "Upload"),
                                    ),
                                  ),
                                ),

                                // TextField Part Rate
                                heightSpacer(),
                                TextFormField(
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  readOnly: true,
                                  decoration: mInputDecoration(
                                    padding: EdgeInsets.only(top: 3),
                                    prefixIcon: partRateImage == null
                                        ? Icon(Icons.file_upload_outlined)
                                        : Icon(Icons.done_all),
                                    preFixColor: partRateImage == null
                                        ? AppColor.textColorLightBlack
                                        : AppColor.btnBgColorGreen,
                                    mIconSize: 18,
                                    radius: 5,
                                    hint: partRateImage == null
                                        ? "Part Rate Image"
                                        : "${partRateImageName}",
                                    hintColor: partRateImage == null
                                        ? AppColor.textColorLightBlack
                                        : AppColor.btnBgColorGreen,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        showBottomSheet();
                                        isGarmentImage = false;
                                      },
                                      child: Upload_btn(btnName: "Upload"),
                                    ),
                                  ),
                                ),
                              ]),

                          // Work Type & Experience
                          heightSpacer(),
                          Custom_ExpansionTile(
                            collapsedBackgroundColor: moreInfoErrorColor != null
                                ? moreInfoErrorColor
                                : Color(0x47BEDFFF),
                            backgroundColor: moreInfoErrorColor != null
                                ? moreInfoErrorColor
                                : Colors.grey.shade50,
                            title: Row(
                              children: [
                                Text(
                                  "Work & Experience",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w600),
                                ),
                                Text(
                                  " *",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w800,
                                      mColor: Colors.red),
                                ),
                              ],
                            ),
                            children: [
                              // job Worked Type
                              Custom_DropDownTextField(
                                hint: "Job worked type *",
                                controller: workType_value,
                                dropDownList: workType_Option,
                                onChanged: (value) {
                                  if (value != null) {
                                    workType =
                                        workType_value.dropDownValue?.name;
                                    setState(() {
                                      moreInfoErrorColor = null;
                                    });
                                  } else {
                                    // Handle the case when nothing is selected
                                    workType = null;
                                  }

                                  setState(() {});
                                },
                              ),

                              // job Worked Shift
                              heightSpacer(),
                              Custom_DropDownTextField(
                                hint: "Worked shift type *",
                                controller: workShift_value,
                                dropDownList: workShift_Option,
                                onChanged: (value) {
                                  if (value != null) {
                                    workShift =
                                        workShift_value.dropDownValue?.name;
                                    setState(() {
                                      moreInfoErrorColor = null;
                                    });
                                  } else {
                                    // Handle the case when nothing is selected
                                    workShift = null;
                                  }

                                  setState(() {});
                                },
                              ),

                              //Work Experience
                              heightSpacer(),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "Experiences",
                                  style: mTextStyle13(
                                      mFontWeight: FontWeight.w500),
                                ),
                              ),
                              heightSpacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Minimum",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w400),
                                        ),
                                        TextFormField(
                                          controller: expMinimumController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                          decoration: mInputDecoration(
                                            padding: EdgeInsets.only(
                                                top: 3, left: 10),
                                            radius: 5,
                                            hint: "In Years ",
                                            mCounterText: "",
                                            hintColor:
                                                AppColor.textColorLightBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  widthSpacer(),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Maximum",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w400),
                                        ),
                                        TextFormField(
                                          controller: expMaximumController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                          decoration: mInputDecoration(
                                            padding: EdgeInsets.only(
                                                top: 3, left: 10),
                                            radius: 5,
                                            hint: "In Years",
                                            mCounterText: "",
                                            hintColor:
                                                AppColor.textColorLightBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),

                          // Job more Information & Details
                          heightSpacer(),
                          Custom_ExpansionTile(
                            collapsedBackgroundColor: moreInfoErrorColor != null
                                ? moreInfoErrorColor
                                : Color(0x47BEDFFF),
                            backgroundColor: moreInfoErrorColor != null
                                ? moreInfoErrorColor
                                : Colors.grey.shade50,
                            title: Row(
                              children: [
                                Text(
                                  "Job more information & details",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w600),
                                ),
                                Text(
                                  " *",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w800,
                                      mColor: Colors.red),
                                ),
                              ],
                            ),
                            children: [
                              // Need Education
                              Card_Container_Widget(
                                padding: EdgeInsets.all(8),
                                mBorderColor: AppColor.textColorLightBlack,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Select Tailor Education",
                                          style: mTextStyle13(
                                              mFontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          " *",
                                          style: mTextStyle14(
                                              mFontWeight: FontWeight.w800,
                                              mColor: Colors.red),
                                        ),
                                      ],
                                    ),
                                    heightSpacer(),
                                    GroupButton(
                                      options: mAdminPageGroupButtonOptions(),
                                      isRadio: false,
                                      buttons: [
                                        "10th or Below 10th",
                                        "12th Pass",
                                        "Diploma",
                                        "ITI",
                                        "Graduate",
                                        "Post Graduate",
                                        "Other"
                                      ],
                                      onSelected: (education_btn_name, index,
                                          isSelected) {
                                        if (isSelected) {
                                          selectedEducation
                                              .add(education_btn_name);
                                          setState(() {
                                            moreInfoErrorColor = null;
                                          });
                                        } else {
                                          selectedEducation
                                              .remove(education_btn_name);
                                        }

                                        // print(selectedEducation);
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Job Responsibilities
                              heightSpacer(),
                              TextFormField(
                                controller: job_Responsibilities,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                decoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Job Responsibilities",
                                  hintColor: AppColor.textColorLightBlack,
                                ),
                              ),

                              // Job Description
                              heightSpacer(),
                              TextFormField(
                                controller: jobDesController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) {
                                  setState(() {
                                    moreInfoErrorColor = null;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                decoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Job Description *",
                                  hintColor: AppColor.textColorLightBlack,
                                ),
                              ),
                            ],
                          ),

                          // InterView & address Details
                          heightSpacer(),
                          Custom_ExpansionTile(
                              collapsedBackgroundColor:
                                  interviewErrorColor != null
                                      ? interviewErrorColor
                                      : Color(0x47BEDFFF),
                              backgroundColor: interviewErrorColor != null
                                  ? interviewErrorColor
                                  : Colors.grey.shade50,
                              title: Row(
                                children: [
                                  Text(
                                    "Interview & address details",
                                    style: mTextStyle14(
                                        mFontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    " *",
                                    style: mTextStyle14(
                                        mFontWeight: FontWeight.w800,
                                        mColor: Colors.red),
                                  ),
                                ],
                              ),
                              children: [
                                // job InterView mode
                                heightSpacer(),
                                Custom_DropDownTextField(
                                  hint: "Interview mode *",
                                  controller: interviewMode_value,
                                  dropDownList: interviewMode_Option,
                                  onChanged: (value) {
                                    if (value != null) {
                                      interviewMode = interviewMode_value
                                          .dropDownValue?.name;
                                      setState(() {
                                        interviewErrorColor = null;
                                      });
                                    } else {
                                      // Handle the case when nothing is selected
                                      interviewMode = null;
                                    }

                                    setState(() {});
                                  },
                                ),

                                // Work Location
                                heightSpacer(),
                                Custom_DropDownTextField(
                                  hint: "Work Location *",
                                  controller: workLocation_value,
                                  dropDownList: workLocation_Option,
                                  onChanged: (value) {
                                    if (value != null) {
                                      workLocation = workLocation_value
                                          .dropDownValue?.name;
                                      setState(() {
                                        interviewErrorColor = null;
                                      });
                                      // print(interviewMode_value.dropDownValue?.name);
                                    } else {
                                      // Handle the case when nothing is selected
                                      workLocation = null;
                                    }
                                  },
                                ),

                                // Interview Address
                                heightSpacer(),
                                TextFormField(
                                  controller: interviewAddressController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  readOnly: workLocation == "Company address"
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    interviewErrorColor = null;
                                    setState(() {});
                                  },
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  decoration: mInputDecoration(
                                    padding: EdgeInsets.only(top: 3, left: 10),
                                    radius: 5,
                                    hint: workLocation == "Company address"
                                        ? "${widget.companyModel.address}"
                                        : "Interview Address/Contact *",
                                    hintColor: workLocation == "Company address"
                                        ? Colors.black
                                        : AppColor.textColorLightBlack,
                                  ),
                                ),

                                // State
                                heightSpacer(),
                                TextFormField(
                                  controller: stateController,
                                  keyboardType: TextInputType.streetAddress,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  decoration: mInputDecoration(
                                    padding: EdgeInsets.only(top: 3, left: 10),
                                    radius: 5,
                                    hint: "State *",
                                    hintColor: AppColor.textColorLightBlack,
                                  ),
                                ),
                              ]),

                          // btn
                          heightSpacer(mHeight: 20),
                          BlocConsumer<JobPostCubit, JobPostState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              showSnackBar_Widget(context,
                                  mHeading: "Success",
                                  title: "Your form is submitted successfully");
                              clearForm();
                              setState(() {});
                            },
                            builder: (context, state) {
                              if (state is JobPostLoadingState ||
                                  isLodding == true) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return Rounded_Btn_Widget(
                                mfontSize: 15,
                                mAlignment: Alignment.center,
                                borderRadius: 5,
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    _uploadFileData();
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //       content: Text('Processing Data')),
                                    // );
                                  }
                                },
                                title: "Submit ",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: ============ Pick select Option ================
  Future<void> showBottomSheet() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 75.h,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 35,
                        ),
                        Text("Camera")
                      ],
                    ),
                  ),
                  widthSpacer(mWidth: 50),
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 35,
                        ),
                        Text("Gallery")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // TODO: ============ Pick Image Function ================
  String? garmentImagePath;
  String? garmentImageName;
  String? partRateImagePath;
  String? partRateImageName;

  pickImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      if (isGarmentImage == true) {
        garmentImagePath = pickedFile.path;
        garmentImageName = pickedFile.name;
      } else {
        partRateImagePath = pickedFile.path;
        partRateImageName = pickedFile.name;
      }
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      compressQuality: 15,
    );

    if (croppedImage != null) {
      File newFile = File(croppedImage.path);
      setState(() {
        if (isGarmentImage == true) {
          log("croped garment ${isGarmentImage}");
          garment_pic = newFile;
        } else {
          log("croped partRateImage ${isGarmentImage}");
          partRateImage = newFile;
        }
      });
    }
  }

// Upload File and all data
  void _uploadFileData() async {
    String? part_rate_downloadUrl;
    String? garment_downloadUrl;
    UploadTask? logoUploadTask;
    UploadTask? gstFileUploadTask;

    try {
      if (garment_type != null &&
          department != null &&
          job_type != null &&
          selectedSkills.isNotEmpty &&
          totalTailorController.text.isNotEmpty &&
          minimumSalaryController.text.isNotEmpty &&
          workType != null &&
          workShift != null &&
          selectedEducation.isNotEmpty &&
          jobDesController.text.isNotEmpty &&
          interviewMode != null &&
          workLocation != null &&
          stateController.text.isNotEmpty) {
        // condition true
        setState(() {
          isLodding = true;
        });

        // upload Garment Image and Part Rate image
        if (garment_pic != null || partRateImage != null) {
          // uploadGarment Image
          logoUploadTask = FirebaseStorage.instance
              .ref()
              .child("job_documents")
              .child("garment_images")
              .child(garmentImageName!)
              .putFile(File(garmentImagePath!));

          TaskSnapshot garmentTaskSnapshot = await logoUploadTask;
          garment_downloadUrl = await garmentTaskSnapshot.ref.getDownloadURL();

          // upload Part Rate  Image
          gstFileUploadTask = FirebaseStorage.instance
              .ref()
              .child("job_documents")
              .child("part_rate_images")
              .child(partRateImageName!)
              .putFile(File(partRateImagePath!));

          TaskSnapshot partRateTaskSnapshot = await gstFileUploadTask;
          part_rate_downloadUrl =
              await partRateTaskSnapshot.ref.getDownloadURL();
        }

        /// upload in CompanyModel data

        // JobPostModel newJobPost = JobPostModel(
        //   uid: widget.companyModel.uid,
        //   dateTime: DateTime.now(),
        //   company_logo: widget.companyModel.company_logo,
        //   company_name: widget.companyModel.company_name,
        //   address: widget.companyModel.address,
        //   garment_type: garment_type,
        //   garment_order_qty: garmentQtyController.text.toString(),
        //   tailor_department: department,
        //   job_type: job_type,
        //   tailor_skill: selectedSkills,
        //   total_employee: totalTailorController.text.toString(),
        //   tailor_category: category,
        //   categorySalary: cateSalaryController.text,
        //   stitching_price: stitchingPriceController.text,
        //   minimun_Salary: minimumSalaryController.text.toString(),
        //   maxmimum_Salary: maxmimumSalaryController.text.toString(),
        //   garment_image: garment_downloadUrl,
        //   part_rate_image: part_rate_downloadUrl,
        //   worked_type: workType,
        //   worked_shift: workShift,
        //   minimum_experience: expMinimumController.text.toString(),
        //   maxmimum_experience: expMaximumController.text.toString(),
        //   tailor_education: selectedEducation,
        //   job_responsibilities: job_Responsibilities.text.toString(),
        //   job_description: jobDesController.text.toString(),
        //   interview_mode: interviewMode,
        //   interviewAddress: interviewAddressController.text.toString(),
        //   workLocation: workLocation,
        //   state: stateController.text.toString(),
        // );
        //
        // BlocProvider.of<JobPostCubit>(context).addJobPostModel(newJobPost);

        isLodding = false;
        setState(() {});
        //
      } else {
        //first check filed is not empty then change Expansion color
        CheckFieldThenChangeColor();

        showSnackBar_Widget(context,
            mHeading: "Error", title: "Some field is empty");
        setState(() {});
      }
    } catch (ex) {
      log(ex.toString());
    }
  }

  // All form field are Clear after Submit job
  void clearForm() {
    garment_value.clearDropDown();
    garment_type = null;
    garmentQtyController.text = "";
    department_value.clearDropDown();
    department = null;
    job_type_value.clearDropDown();
    job_type = null;
    selectedSkills.clear();
    totalTailorController.text = "";
    // category_value.clearDropDown();
    category = null;
    cateSalaryController.text = "";
    stitchingPriceController.text = "";
    minimumSalaryController.text = "";
    maxmimumSalaryController.text = "";
    garment_pic = null;
    partRateImage = null;
    workType_value.clearDropDown();
    workType = null;
    workShift_value.clearDropDown();
    workShift = null;
    expMinimumController.text = "";
    expMaximumController.text = "";
    selectedEducation.clear();
    job_Responsibilities.text = "";
    jobDesController.text = "";
    interviewMode_value.clearDropDown();
    interviewMode = null;
    interviewAddressController.text = "";
    workLocation_value.clearDropDown();
    workLocation = null;
    stateController.text = "";

    setState(() {});
  }

  //first check filed is not empty then change Expansion color
  void CheckFieldThenChangeColor() {
    // Job Details
    if (garment_type == null ||
        department == null ||
        job_type == null ||
        selectedSkills.isEmpty) {
      detailsErrorColor = Colors.red.shade50;
    } else {
      detailsErrorColor = null;
    }

    // Total Tailor & Salary
    if (totalTailorController.text.isEmpty || selectedSkills.isEmpty) {
      totalErrorColor = Colors.red.shade50;
    } else {
      totalErrorColor = null;
    }

    // Work & Experience
    if (workType == null || workShift == null) {
      experienceErrorColor = Colors.red.shade50;
    } else {
      experienceErrorColor = null;
    }

    //Job more information & details
    if (selectedEducation.isEmpty || jobDesController.text.isEmpty) {
      moreInfoErrorColor = Colors.red.shade50;
    } else {
      moreInfoErrorColor = null;
    }

    // Interview & address details
    if (interviewMode == null ||
        interviewAddressController.text.isEmpty ||
        workLocation == null ||
        stateController.text.isEmpty) {
      interviewErrorColor = Colors.red.shade50;
    } else {
      interviewErrorColor = null;
    }
  }

  // When Change dropdown Option in Tailor Department Filed then Empty Filed according options
  void EmptyFields(isTextEqualTo) {
    if (isTextEqualTo == "Production") {
      category = null;
      category_value.clearDropDown();
      cateSalaryController.text = "";
      Part_Time_Cate_value.clearDropDown();
      part_Time_Category = null;
      part_Time_Sub_Cate_value.clearDropDown();
      part_Time_Sub_Category = null;
    }

    if (category == "Salary") {
      part_Rate_value.clearDropDown();
      part_Rate = null;
      part_Rate_Text_Controller.text.isEmpty;
      full_Pc_value.clearDropDown();
      full_Pc = null;
    }

    if (category == "Part Rate") {
      grade_Salary = null;
      grade_Salary_value.clearDropDown();
      grade_Salary_Controller.text.isEmpty;
      full_Pc_value.clearDropDown();
      full_Pc = null;
    }

    if (category == "Full PC") {
      part_Rate_value.clearDropDown();
      part_Rate = null;
      part_Rate_Text_Controller.text.isEmpty;
      grade_Salary = null;
      grade_Salary_value.clearDropDown();
      grade_Salary_Controller.text.isEmpty;
    }
  }
}
