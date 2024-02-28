import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/interest_into_screen.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Education_Into_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Education_Into_Screen({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Education_Into_Screen> createState() => _Education_Into_ScreenState();
}

class _Education_Into_ScreenState extends State<Education_Into_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pass_year = TextEditingController();
  TextEditingController collage_name = TextEditingController();

  String? education;
  String? course;
  bool _isDropDownOption = false;
  String? collageError;
  String? yearError;
  late SingleValueDropDownController branch_value = SingleValueDropDownController();

  //dropdown options
  List<DropDownValueModel> currentOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          children: [
            // 1st number
            Intro_Number_Widget(
              number: 1,
              name: "About",
            ),
            Expanded(
              child: Divider(color: AppColor.cardBtnBgGreen),
            ),

            // 2nd Number
            Intro_Number_Widget(
              number: 2,
              name: "Education",
              active_no: 2,
            ),
            Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

            // 3rd Number
            Intro_Number_Widget(number: 3, name: "Interest"),
            Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

            // 4th Number
            Intro_Number_Widget(number: 4, name: "Skills"),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Start Profile Box
                    Profile_box_Widget(firebaseUser: widget.firebaseUser, userModel: widget.userModel),

                    // ========= Education Details ============
                    heightSpacer(mHeight: 20),
                    RichText(
                      text: TextSpan(text: "Your Highest Eduction", style: mTextStyle17(mFontWeight: FontWeight.w700), children: [
                        TextSpan(
                          text: " *",
                          style: mTextStyle17(mFontWeight: FontWeight.w700, mColor: Colors.red),
                        )
                      ]),
                    ),

                    /// =======  Education Button ========
                    heightSpacer(mHeight: 10),
                    GroupButton(
                      options: mGroupButtonOptions(),
                      isRadio: true,
                      buttons: ["10th or Below 10th", "12th Pass", "Diploma", "ITI", "Graduate", "Post Graduate", "Other"],
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
                    ),

                    ///  Course Options field
                    _isDropDownOption == false
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
                                    controller: branch_value,
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
                                    dropDownList: currentOptions,
                                    onChanged: (value) {
                                      if (value != null) {
                                        course = branch_value.dropDownValue!.value;
                                        // print(branch_value.dropDownValue!.name);
                                      } else {
                                        // Handle the case when nothing is selected
                                        course = null;
                                      }

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                    ///  Collage Name
                    heightSpacer(mHeight: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(text: "Collage/Institute Name", style: mTextStyle13(mFontWeight: FontWeight.w500), children: [
                            TextSpan(
                              text: " *",
                              style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                            )
                          ]),
                        ),
                        heightSpacer(mHeight: 10),
                        TextFormField(
                          controller: collage_name,
                          style: mTextStyle14(),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: mInputDecoration(
                            hint: "Institute name",
                            radius: 5,
                            padding: EdgeInsets.only(top: 10, left: 15),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              collageError = null;
                            } else {
                              collage_name.text = value;
                            }
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null) {
                              return "please enter institute name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        collageError == null ? Container() : Text("${collageError}", style: mTextStyle13(mColor: Colors.red)),
                      ],
                    ),

                    /// ============ Passing Year =============
                    heightSpacer(mHeight: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(text: "Passing Year", style: mTextStyle13(mFontWeight: FontWeight.w500), children: [
                            TextSpan(
                              text: " *",
                              style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                            )
                          ]),
                        ),
                        heightSpacer(mHeight: 10),
                        TextFormField(
                          controller: pass_year,
                          style: mTextStyle14(),
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              yearError = null;
                            } else {
                              pass_year.text = value;
                            }
                            setState(() {});
                          },
                          decoration: mInputDecoration(
                              hint: "Passing Year", radius: 5, padding: EdgeInsets.only(top: 10, left: 15), mCounterText: ""),
                        ),
                        yearError == null ? Container() : Text("${yearError}", style: mTextStyle13(mColor: Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // Submit bottom Sheet bottom Sheet Btn
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UserLoadedState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Interest_Into_Screen(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                  ),
                );
              } else if (state is UserErrorState) {
                showSnackBar_Widget(context, mHeading: "Error", title: "${state.error}");
              }
            },
            builder: (context, state) {
              return Rounded_Btn_Widget(
                title: "Next",
                mTextColor: education == null ? AppColor.btnBgColorGreen : Colors.white,
                btnBgColor: AppColor.btnBgColorGreen,
                borderColor: AppColor.btnBgColorGreen,
                onPress: education == null
                    ? null
                    : () {
                        checkValue();
                      },
                mHeight: 40,
                borderRadius: 5,
                mAlignment: Alignment.center,
              );
            },
          ),
        ),
      ),
    );
  }

  void checkValue() {
    if (pass_year.text.isNotEmpty &&
        pass_year.text.length >= 4 &&
        int.tryParse(pass_year.text) != null &&
        int.parse(pass_year.text) <= 2023 &&
        collage_name.text.isNotEmpty) {
      //
      // Variable store in userModel
      widget.userModel.education = education;
      widget.userModel.course = course ?? null;
      widget.userModel.passing_year = pass_year.text;
      widget.userModel.collage_name = collage_name.text;

      BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
      showSnackBar_Widget(context, mHeading: "Success", title: "Your form is submitted successfully");
    } else {
      if (collage_name.text.isEmpty) {
        collageError = "Please fill institute name";
      }
      if (pass_year.text.isEmpty) {
        yearError = "Please fill field and year less then 2023";
      }

      showSnackBar_Widget(context, mHeading: "Error", title: "Please filled all field and year less then 2023");
      setState(() {});
    }
  }

// ========================================================================
  // ================== UI end and  Widget and list Start ==================
  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
            color: AppColor.textColorLightBlack,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle13(mFontWeight: FontWeight.w600, mColor: AppColor.textColorLightBlack),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
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
}
