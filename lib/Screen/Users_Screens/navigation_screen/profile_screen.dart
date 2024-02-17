import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Veriables_And_Function.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Education_Edit_Widget.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Experience_Edit_Widget.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/JobType_Edit_Widget.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/Tailor_profile_Edit_Widget/Update_Button_widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

class Profile_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Profile_Screen({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Profile_Screen> createState() => _Profile_Screen();
}

class _Profile_Screen extends State<Profile_Screen> {
  late MediaQueryData mq;

  TextEditingController collage_nameController = TextEditingController();
  TextEditingController passing_yearController = TextEditingController();
  TextEditingController experience_companyController = TextEditingController();
  TextEditingController totalExpYearsController = TextEditingController();
  TextEditingController totalExpMonthsController = TextEditingController();
  TextEditingController totalSalaryController = TextEditingController();
  late SingleValueDropDownController branch_value = SingleValueDropDownController();
  List<DropDownValueModel> currentOptions = [];
  List<String> selectedEditSkills = [];
  List<String> selectedEditGarment = [];
  List<String> selectedEditInterest = [];
  List<String> selectedEditLanguage = [];

  String? isEditedByName;
  String? education;
  String? course;
  String? job_type;
  bool _isDropDownOption = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leadingWidth: 25,
        title: RichText(
          text: TextSpan(
              text: "Tailor ",
              style: mTextStyle20(),
              children: [TextSpan(text: "Profile", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
        ],
      ),
      drawer: Drawer_Widget(
        firebaseUser: widget.firebaseUser,
        userModel: widget.userModel,
        isCurUserCom: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===========  Start Profile Box ===========
                Card_Container_Widget(
                  padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: NetworkImage("${widget.userModel.profile_pic}"),
                              radius: 30,
                            ),
                          ),
                        ),
                      ),

                      //
                      Expanded(
                        flex: 6,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${widget.userModel.user_name}".toUpperCase(),
                                  style: mTextStyle19(mFontWeight: FontWeight.w600, mColor: AppColor.btnBgColorGreen),
                                ),
                              ),

                              // Eduction
                              heightSpacer(mHeight: 3),
                              widget.userModel.education == null
                                  ? Container()
                                  : FittedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.book_outlined,
                                            size: 14,
                                          ),
                                          widthSpacer(mWidth: 5),
                                          Text(
                                            "${widget.userModel.education}  | ",
                                            style: mTextStyle13(mFontWeight: FontWeight.w500),
                                          ),

                                          // Course display

                                          widget.userModel.course == null
                                              ? Container()
                                              : Text(
                                                  "${widget.userModel.course}  | ",
                                                  style: mTextStyle13(
                                                    mFontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                          // Course display
                                          widget.userModel.passing_year == null
                                              ? Container()
                                              : Text(
                                                  "${widget.userModel.passing_year}",
                                                  style: mTextStyle13(
                                                    mFontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),

                              // Skill
                              heightSpacer(mHeight: 3),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Icon(
                                      Icons.streetview,
                                      size: 14,
                                    ),
                                  ),
                                  widthSpacer(mWidth: 5),
                                  Expanded(
                                    flex: 30,
                                    child: widget.userModel.interest == null
                                        ? Container()
                                        : Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            // Align items to the start of the line
                                            children: (widget.userModel.interest ?? []).map((interest) {
                                              return Container(
                                                padding: EdgeInsets.only(right: 4),
                                                child: Text(
                                                  "${interest},",
                                                  style: mTextStyle12(
                                                    mFontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                  ),
                                ],
                              ),

                              // Phone Number
                              heightSpacer(mHeight: 20),
                              Icon_Text(
                                mIcon: Icons.phone,
                                mText: "${widget.userModel.phone}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //
                heightSpacer(mHeight: 30),
                Text(
                  "About me",
                  style: mTextStyle15(mFontWeight: FontWeight.w700),
                ),

                // ================ Eduction details =====================
                heightSpacer(),
                // ======== Editable all Eduction fields =====
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Education",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              // First store value from firebase
                              education = widget.userModel.education;
                              collage_nameController.text = widget.userModel.collage_name!;
                              passing_yearController.text = widget.userModel.passing_year!;

                              isEditedByName = "EducationEdit";
                              setState(() {});
                            },
                            child: Text(
                              "+ Add",
                              style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.cardBtnBgGreen),
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(mHeight: 5),
                      isEditedByName == "EducationEdit"
                          ? Education_Edit_Widget(
                              controller: branch_value,
                              dropDownList: currentOptions,
                              isDropDownOption: _isDropDownOption,
                              collage_name: collage_nameController,
                              pass_year: passing_yearController,

                              //============= For Change dropDown Menu ===============
                              onSelected: (btn_name, index, isSelected) {
                                education = btn_name;
                                setState(() {
                                  // Close the dropdown list when the education value changes
                                  FocusScope.of(context).requestFocus(FocusNode());

                                  // Set the currentOptions based on the selected education type
                                  if (education == "Diploma") {
                                    _isDropDownOption = true;
                                    currentOptions = diplomaOptions;
                                  } else if (education == "ITI") {
                                    _isDropDownOption = true;
                                    currentOptions = itiOptions;
                                  } else {
                                    // For other education types, you can set a hide branch name and Option text field.
                                    _isDropDownOption = false;
                                  }
                                });
                              },

                              // =============  For course Option ===================
                              onChanged: (value) {
                                if (value != null) {
                                  course = branch_value.dropDownValue!.value;
                                } else {
                                  course = null;
                                }
                                setState(() {});
                              },

                              // ========== Update button ==========
                              onUpdatePress: () {
                                widget.userModel.education = education;
                                widget.userModel.course = course;
                                widget.userModel.collage_name = collage_nameController.text;
                                widget.userModel.passing_year = passing_yearController.text;

                                BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                                isEditedByName = null;
                                setState(() {});
                              },

                              // ========== Cancel button ===========
                              onCancelPress: () {
                                setState(() {
                                  isEditedByName = null;
                                });
                              },
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Highest education",
                                  style: mTextStyle13(),
                                ),
                                Text(
                                  "${widget.userModel.education}",
                                  style: mTextStyle13(),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),

                //  ======== Eduction field Show only and update operation are up ======
                heightSpacer(mHeight: 10),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ======= Education name, branch =======
                      RichText(
                        text: TextSpan(
                          text: "${widget.userModel.education}",
                          style: mTextStyle16(mFontWeight: FontWeight.w800),
                          children: [
                            TextSpan(
                              text: widget.userModel.course == null ? "" : ", ${widget.userModel.course}",
                              style: mTextStyle16(mFontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),

                      // ======== Collage Name and year ===========
                      heightSpacer(mHeight: 2),
                      Text(
                        capitalize("${widget.userModel.collage_name}"),
                        style: mTextStyle13(mFontWeight: FontWeight.w400, mColor: AppColor.textColorLightBlack),
                      ),
                      heightSpacer(mHeight: 7),
                      Container(
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.navBgColor)),
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "Batch of ${widget.userModel.passing_year}",
                          style: mTextStyle11(),
                        ),
                      )
                    ],
                  ),
                ),

                //======== Experience===============
                heightSpacer(),
                InkWell(
                  onTap: () {
                    experience_companyController.text = widget.userModel.experience_company!;
                    totalExpYearsController.text = widget.userModel.totalExpYears!;
                    totalExpMonthsController.text = widget.userModel.totalExpMonths!;

                    isEditedByName = "ExperienceEdit";
                    setState(() {});
                  },
                  child: Card_Container_Widget(
                    padding: EdgeInsets.all(10),
                    child: isEditedByName == "ExperienceEdit"
                        ? Experience_Edit_Widget(
                            editExperience_company: experience_companyController,
                            editTotalExpYears: totalExpYearsController,
                            editTotalExpMonths: totalExpMonthsController,
                            editCancelPress: () {
                              setState(() {
                                isEditedByName = null;
                              });
                            },
                            editUpdatePress: () {
                              widget.userModel.experience_company = experience_companyController.text;
                              widget.userModel.totalExpYears = totalExpYearsController.text;
                              widget.userModel.totalExpMonths = totalExpMonthsController.text;

                              BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                              isEditedByName = null;
                              setState(() {});
                            },
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 17,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Experience",
                                      style: mTextStyle13(mFontWeight: FontWeight.w700),
                                    ),
                                    heightSpacer(mHeight: 5),
                                    Text(
                                      capitalize("${widget.userModel.experience_company}"),
                                      style: mTextStyle13(mFontWeight: FontWeight.w400, mColor: AppColor.textColorLightBlack),
                                    ),
                                  ],
                                ),
                              ),
                              // Spacer(),
                              widget.userModel.totalExpYears!.isEmpty && widget.userModel.totalExpMonths!.isEmpty
                                  ? Container()
                                  : Expanded(
                                      flex: 15,
                                      child: Text(
                                        "${widget.userModel.totalExpYears} Years, ${widget.userModel.totalExpMonths} Months",
                                        style: mTextStyle13(mFontWeight: FontWeight.w700),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                              widthSpacer(mWidth: 5),
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.btnBgColorGreen,
                                  size: 13,
                                ),
                              )
                            ],
                          ),
                  ),
                ),

                //========== Salary==============
                heightSpacer(),
                InkWell(
                  onTap: () {
                    totalSalaryController.text = widget.userModel.salary!;
                    isEditedByName = "SalaryEdit";
                    setState(() {});
                  },
                  child: Card_Container_Widget(
                    padding: EdgeInsets.all(10),
                    child: isEditedByName == "SalaryEdit"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enter salary",
                                style: mTextStyle13(mFontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: totalSalaryController,
                                  style: mTextStyle13(),
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  decoration: mInputDecoration(
                                    hint: "Total months",
                                    radius: 5,
                                    padding: EdgeInsets.only(left: 15),
                                    mCounterText: "",
                                  ),
                                ),
                              ),
                              Update_button_Widget(
                                onCancelPress: () {
                                  setState(() {
                                    isEditedByName = null;
                                  });
                                },
                                onUpdatePress: () {
                                  widget.userModel.salary = totalSalaryController.text;

                                  BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                                  isEditedByName = null;
                                  setState(() {});
                                },
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 27,
                                child: Text(
                                  "Current monthly salary",
                                  style: mTextStyle13(),
                                ),
                              ),
                              // Spacer(),
                              Expanded(
                                flex: 12,
                                child: Text(
                                  "INR ${widget.userModel.salary}",
                                  style: mTextStyle13(mFontWeight: FontWeight.w700),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              widthSpacer(mWidth: 5),
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.btnBgColorGreen,
                                  size: 13,
                                ),
                              )
                            ],
                          ),
                  ),
                ),

                //========== Job Type ==============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: isEditedByName == "GarmentCateEdit"
                      ? JobType_Edit_Widget(
                          selected_JobType: job_type,
                          EditGarmentPress: (Garment_btn_name, index, isSelected) {
                            if (isSelected) {
                              selectedEditGarment.add(Garment_btn_name);
                            } else {
                              selectedEditGarment.remove(Garment_btn_name);
                            }
                            setState(() {});
                          },
                          JobTypeOnSelected: (type_btn_name, index, isSelected) {
                            if (isSelected) {
                              job_type = type_btn_name;
                            } else {
                              job_type = null;
                            }
                            setState(() {});
                          },
                          TailorOnSelected: (category_btn_name, index, isSelected) {
                            if (isSelected) {
                              category = category_btn_name;
                            } else {
                              category = null;
                            }
                            setState(() {});
                          },
                          EditCancelPress: () {
                            setState(() {
                              isEditedByName = null;
                            });
                          },
                          EditUpdatePress: () {
                            widget.userModel.garment_category = selectedEditGarment;
                            widget.userModel.job_type = job_type;
                            widget.userModel.category = category;

                            BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                            isEditedByName = null;
                            setState(() {});
                          },
                        )
                      // ========= Only View Garment and JobType =============
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ========= Garment Category ================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Garment category",
                                  style: mTextStyle13(mFontWeight: FontWeight.w700),
                                ),
                                InkWell(
                                  onTap: () {
                                    job_type = widget.userModel.job_type!;
                                    category = widget.userModel.category!;
                                    selectedEditGarment = List<String>.from(widget.userModel.garment_category!);
                                    selectedEditGarment.clear();
                                    isEditedByName = "GarmentCateEdit";
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Edit",
                                    style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.btnBgColorGreen),
                                  ),
                                ),
                              ],
                            ),
                            heightSpacer(mHeight: 5),
                            Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              // Align items to the start of the line
                              children: (widget.userModel.garment_category ?? []).map((garment_category) {
                                return Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: AppColor.textColorBlue,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    margin: EdgeInsets.all(2),
                                    child: Text(
                                      "${garment_category}",
                                      style: mTextStyle11(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            // ======== Tailor job type =============
                            heightSpacer(mHeight: 10),
                            Text(
                              "Tailor job type",
                              style: mTextStyle13(mFontWeight: FontWeight.w700),
                            ),
                            heightSpacer(mHeight: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Job type",
                                    style: mTextStyle13(),
                                  ),
                                ),
                                // Spacer(),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${widget.userModel.job_type}",
                                    style: mTextStyle13(mFontWeight: FontWeight.w700),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),

                            // ====== If Job_type value is Equal to "Tailor" then show is filed ============
                            widget.userModel.job_type == "Tailor"
                                ? Container(
                                    margin: EdgeInsets.only(top: 7),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 27,
                                          child: Text(
                                            "Category of tailor",
                                            style: mTextStyle13(),
                                          ),
                                        ),
                                        // Spacer(),
                                        Expanded(
                                          flex: 12,
                                          child: Text(
                                            "${widget.userModel.category}",
                                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                ),

                /// ===========  Department of Interest ===============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Department of Interest",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              selectedEditInterest = List<String>.from(widget.userModel.interest!);
                              selectedEditInterest.clear();
                              isEditedByName = "InterestEdit";
                              setState(() {});
                            },
                            child: Text(
                              "+ Add",
                              style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.cardBtnBgGreen),
                            ),
                          ),
                        ],
                      ),

                      /// =========== Edit Department of Interest ============
                      heightSpacer(),
                      isEditedByName == "InterestEdit"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GroupButton(
                                  options: mGroupButtonOptions(textPadding: EdgeInsets.symmetric(horizontal: 8)),
                                  isRadio: false,
                                  buttons: ["Sampling", "Finishing", "Production", "Other"],
                                  onSelected: (interest_btn_name, index, isSelected) {
                                    if (isSelected) {
                                      selectedEditInterest.add(interest_btn_name);
                                    } else {
                                      selectedEditInterest.remove(interest_btn_name);
                                    }
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Update_button_Widget(
                                    onCancelPress: () {
                                      setState(() {
                                        isEditedByName = null;
                                      });
                                    },
                                    onUpdatePress: () {
                                      widget.userModel.interest = selectedEditInterest;

                                      BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                                      isEditedByName = null;
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            )
                          : Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              // Align items to the start of the line
                              children: (widget.userModel.interest ?? []).map((interest) {
                                return Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: AppColor.textColorBlue,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    margin: EdgeInsets.all(2),
                                    child: Text(
                                      "${interest}",
                                      style: mTextStyle11(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),

                /// ===========  Skills Button ===============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal skills",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              selectedEditSkills = List<String>.from(widget.userModel.skills!);
                              selectedEditSkills.clear();
                              isEditedByName = "skillsEdit";
                              setState(() {});
                            },
                            child: Text(
                              "+ Add",
                              style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.cardBtnBgGreen),
                            ),
                          ),
                        ],
                      ),

                      /// =========== Edit Skills filed ============
                      heightSpacer(),
                      isEditedByName == "skillsEdit"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GroupButton(
                                  options: mGroupButtonOptions(textPadding: EdgeInsets.symmetric(horizontal: 8)),
                                  isRadio: false,
                                  buttons: [
                                    "Single Needle Operator",
                                    "Feedup Machine Operator",
                                    "Consie Machine Operator",
                                    "Cutting Machine Operator",
                                    "Bartack Machine Operator",
                                    "Flatlock Operator",
                                    "Overlock Operator",
                                    "Other"
                                  ],
                                  onSelected: (skills_btn_name, index, isSelected) {
                                    if (isSelected) {
                                      selectedEditSkills.add(skills_btn_name);
                                    } else {
                                      selectedEditSkills.remove(skills_btn_name);
                                    }
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Update_button_Widget(
                                    onCancelPress: () {
                                      setState(() {
                                        isEditedByName = null;
                                      });
                                    },
                                    onUpdatePress: () {
                                      widget.userModel.skills = selectedEditSkills;

                                      BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                                      isEditedByName = null;
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            )
                          : Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              // Align items to the start of the line
                              children: (widget.userModel.skills ?? []).map((skills) {
                                return Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: AppColor.textColorBlue,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    margin: EdgeInsets.all(2),
                                    child: Text(
                                      "${skills}",
                                      style: mTextStyle11(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),

                /// ================ Language Known ==================
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Language known",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              selectedEditLanguage = List<String>.from(widget.userModel.language!);
                              selectedEditLanguage.clear();
                              isEditedByName = "languageEdit";
                              setState(() {});
                            },
                            child: Text(
                              "+ Add",
                              style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.cardBtnBgGreen),
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(),
                      // ========== Edit Language ===========
                      isEditedByName == "languageEdit"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GroupButton(
                                  options: mGroupButtonOptions(textPadding: EdgeInsets.symmetric(horizontal: 8)),
                                  isRadio: false,
                                  buttons: [
                                    "English",
                                    "Hindi",
                                    "Marathi",
                                    "Urdu",
                                  ],
                                  onSelected: (language_btn_name, index, isSelected) {
                                    if (isSelected) {
                                      selectedEditLanguage.add(language_btn_name);
                                    } else {
                                      selectedEditLanguage.remove(language_btn_name);
                                    }
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Update_button_Widget(
                                    onCancelPress: () {
                                      setState(() {
                                        isEditedByName = null;
                                      });
                                    },
                                    onUpdatePress: () {
                                      widget.userModel.language = selectedEditLanguage;

                                      BlocProvider.of<UserCubit>(context).updateUserModel(widget.userModel);
                                      isEditedByName = null;
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            )
                          : Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              // Align items to the start of the line
                              children: (widget.userModel.language ?? []).map((language) {
                                return Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: AppColor.textColorLightBlack)),
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    margin: EdgeInsets.all(2),
                                    child: Text(
                                      "${language}",
                                      style: mTextStyle12(
                                        mFontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),

                /// ============= Aadhaar No., Aadhaar document and bank details ==============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Aadhaar Number & bank details",
                            style: mTextStyle14(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Edit",
                            style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.btnBgColorGreen),
                          )
                        ],
                      ),
                      heightSpacer(),

                      // ======= Aadhaar No. ==============
                      widget.userModel.aadhaar_no == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Expanded(child: Text("Aadhaar No.", style: mTextStyle13(mFontWeight: FontWeight.w500))),
                                  Expanded(
                                    child: Text(
                                      "${widget.userModel.aadhaar_no}",
                                      style: mTextStyle13(mFontWeight: FontWeight.w700),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],

                              ),
                            ),

                      // ============= Aadhaar Image Or Document =====================
                      widget.userModel.front_document == null && widget.userModel.back_document == null
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Aadhaar Image",
                                    style: mTextStyle13(mFontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.btnBgColorGreen)),
                                  child: Text(
                                    "View front aadhaar document",
                                    style: mTextStyle13(mColor: AppColor.btnBgColorGreen),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.btnBgColorGreen)),
                                  child: Text(
                                    "View back aadhaar document",
                                    style: mTextStyle13(mColor: AppColor.btnBgColorGreen),
                                  ),
                                )
                              ],
                            ),

                      // =============== Bank Details ======================
                      heightSpacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank details",
                            style: mTextStyle13(mFontWeight: FontWeight.w500),
                          ),
                          heightSpacer(),
                          Bank_Row(
                            mTitle: "Bank request:",
                            mText: widget.userModel.bank_request == true ? "Yes" : "No",
                          ),

                          // ====== If bank request is No then show bank details ===================
                          widget.userModel.bank_request == true
                              ? Container()
                              : Container(
                                  child: Column(
                                    children: [
                                      heightSpacer(mHeight: 5),
                                      Bank_Row(
                                        mTitle: "Bank name:",
                                        mText: "${widget.userModel.bank_name}",
                                      ),
                                      heightSpacer(mHeight: 5),
                                      Bank_Row(
                                        mTitle: "IFSC Code:",
                                        mText: "${widget.userModel.ifsc_code}",
                                      ),
                                      heightSpacer(mHeight: 5),
                                      Bank_Row(
                                        mTitle: "Account No.",
                                        mText: "${widget.userModel.account_number}",
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                ),

                /// ============= Our Details ==============
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Details",
                            style: mTextStyle13(mFontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Update fields",
                            style: mTextStyle13(mFontWeight: FontWeight.w700, mColor: AppColor.cardBtnBgGreen),
                          ),
                        ],
                      ),
                      heightSpacer(),
                      RichText(
                        text: TextSpan(
                          text: "Name: ${widget.userModel.user_name}\n",
                          style: mTextStyle12(),
                          children: [
                            //
                            widget.userModel.gender == null
                                ? TextSpan(text: "Gender: \n")
                                : TextSpan(text: "Gender: ${widget.userModel.gender}\n"),

                            //
                            widget.userModel.dob == null
                                ? TextSpan(text: "DOB: \n")
                                : TextSpan(text: "DOB: ${widget.userModel.dob}\n"),

                            //
                            widget.userModel.phone == null
                                ? TextSpan(text: "Mobile: \n")
                                : TextSpan(text: "Mobile: ${widget.userModel.phone}\n"),

                            //
                            widget.userModel.email == null
                                ? TextSpan(text: "Email: \n")
                                : TextSpan(text: "Email: ${widget.userModel.email}\n"),

                            //

                            widget.userModel.address == null
                                ? TextSpan(text: "Permanent Address: \n")
                                : TextSpan(text: "Permanent Address: ${widget.userModel.permanent_address}\n"),

                            widget.userModel.address == null
                                ? TextSpan(text: "Address: \n")
                                : TextSpan(text: "Address: ${widget.userModel.address}\n"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO : =====================================
  //  TextCapitalization
  String capitalize(String input) {
    return input
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join(' ');
  }

//================================================================
// ================= UI design end  ===========================

  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle12(mFontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // ============ bank Row Widget ===============
  Widget Bank_Row({mTitle, mText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${mTitle}",
          style: mTextStyle13(),
        ),
        Expanded(
          child: Text(
            "${mText}",
            style: mTextStyle13(mFontWeight: FontWeight.w700),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
