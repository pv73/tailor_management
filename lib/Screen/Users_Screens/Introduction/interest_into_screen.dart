import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/skill_into_screen.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Interest_Into_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Interest_Into_Screen({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Interest_Into_Screen> createState() => _Interest_Into_ScreenState();
}

class _Interest_Into_ScreenState extends State<Interest_Into_Screen> {
  List<String> interest = [];
  List<String> garment_category = [];
  List<String> category = [];

  String? job_type;
  String? tailor;
  String? group_btn;
  String? totalExpYears;
  String? totalExpMonths;
  String? leaderNameError;

  TextEditingController experienceCompany = TextEditingController();
  TextEditingController leaderNameController = TextEditingController();
  SingleValueDropDownController groupNoValue = SingleValueDropDownController();
  // List<DropDownValueModel> groupNoList = [];

  // for Experience
  SingleValueDropDownController expYearsValue = SingleValueDropDownController();
  List<DropDownValueModel> expYearsNoList = [];

  SingleValueDropDownController expMonthsValue = SingleValueDropDownController();
  List<DropDownValueModel> expMonthsNoList = [];

  //

  @override
  void initState() {
    super.initState();
    generateDropDownList();
  }

  void generateDropDownList() {
    for (int expyear = 0; expyear <= 20; expyear++) {
      String year = expyear.toString().padLeft(2, '0');
      // Convert number to two-digit format
      expYearsNoList.add(DropDownValueModel(name: year, value: year));
    }

    for (int expmonth = 0; expmonth <= 12; expmonth++) {
      String month = expmonth.toString().padLeft(2, '0');
      // Convert number to two-digit format
      expMonthsNoList.add(DropDownValueModel(name: month, value: month));
    }
  }

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
            Intro_Number_Widget(number: 2, name: "Education"),
            Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

            // 3rd Number
            Intro_Number_Widget(
              number: 3,
              name: "Interest",
              active_no: 3,
            ),
            Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

            // 4th Number
            Intro_Number_Widget(number: 4, name: "Skills"),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Profile_box_Widget(
                    userModel: widget.userModel,
                    firebaseUser: widget.firebaseUser,
                  ),

                  //============ Garment Category Details ===============
                  heightSpacer(mHeight: 20),
                  RichText(
                    text: TextSpan(text: "Garment Category", style: mTextStyle15(mFontWeight: FontWeight.w700), children: [
                      TextSpan(
                        text: " *",
                        style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                      )
                    ]),
                  ),

                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: false,
                    buttons: ["Knits", "Woven", "High Fashion", "Boutique"],
                    onSelected: (Garment_btn_name, index, isSelected) {
                      if (isSelected) {
                        garment_category.add(Garment_btn_name);
                      } else {
                        garment_category.remove(Garment_btn_name);
                      }
                    },
                  ),
                  heightSpacer(mHeight: 10),
                  Divider(),

                  //============ Interest Details===============
                  heightSpacer(mHeight: 5),
                  RichText(
                    text: TextSpan(text: "Department of Interest", style: mTextStyle15(mFontWeight: FontWeight.w700), children: [
                      TextSpan(
                        text: " *",
                        style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                      )
                    ]),
                  ),

                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: false,
                    buttons: ["Sampling", "Finishing", "Production", "Other"],
                    onSelected: (Interest_btn_name, index, isSelected) {
                      if (isSelected) {
                        interest.add(Interest_btn_name);
                      } else {
                        interest.remove(Interest_btn_name);
                      }
                      setState(() {});
                    },
                  ),

                  heightSpacer(mHeight: 10),
                  Divider(),

                  /// ============= Job Type =================
                  heightSpacer(mHeight: 5),
                  RichText(
                    text: TextSpan(text: "Job type", style: mTextStyle15(mFontWeight: FontWeight.w500), children: [
                      TextSpan(
                        text: " *",
                        style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                      )
                    ]),
                  ),

                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: true,
                    buttons: [
                      "Tailor",
                      "Pattern Master",
                      "Cutting Master",
                      "Helper",
                      "Supervisor",
                      "Pressman",
                      "Line In Charge",
                      "Thread Cutter",
                      "Quality Controller"
                    ],
                    onSelected: (type_btn_name, index, isSelected) {
                      if (isSelected) {
                        job_type = type_btn_name;
                      } else {
                        job_type = null;
                      }
                      setState(() {});
                    },
                  ),

                  Divider(height: 40),

                  /// ============= Category Button =================
                  RichText(
                    text: TextSpan(text: "Category of Tailor", style: mTextStyle15(mFontWeight: FontWeight.w500), children: [
                      TextSpan(
                        text: " *",
                        style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                      )
                    ]),
                  ),

                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: false,
                    buttons: ["Salary", "Full Piece", "Part Rate", "Part Time", "Hours Basis"],
                    onSelected: (tailor_btn_name, index, isSelected) {
                      if (isSelected) {
                        category.add(tailor_btn_name);
                      } else {
                        category.remove(tailor_btn_name);
                      }
                      setState(() {});
                    },
                  ),

                  heightSpacer(mHeight: 10),
                  Divider(),

                  /// ============  Group or Individual ================
                  heightSpacer(mHeight: 5),
                  RichText(
                    text: TextSpan(text: "Group or Individual", style: mTextStyle15(mFontWeight: FontWeight.w500), children: [
                      TextSpan(
                        text: " *",
                        style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                      )
                    ]),
                  ),

                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: true,
                    buttons: [
                      "individual",
                      "Group",
                    ],
                    onSelected: (btn_name, index, isSelected) {
                      if (isSelected) {
                        group_btn = btn_name;
                      }
                      // print(group_btn);
                      setState(() {});
                    },
                  ),

                  /// Category Details
                  group_btn != "Group"
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    // flex: 6,
                                    child: TextFormField(
                                      controller: leaderNameController,
                                      style: mTextStyle13(),
                                      keyboardType: TextInputType.text,
                                      textCapitalization: TextCapitalization.words,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          leaderNameError = null;
                                        } else {
                                          leaderNameController.text = value;
                                        }
                                        setState(() {});
                                      },
                                      decoration: mInputDecoration(
                                        hint: "Group leader name",
                                        radius: 5,
                                        padding: EdgeInsets.only(left: 15),
                                      ),
                                    ),
                                  ),
                                  // widthSpacer(),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: DropDownTextField(
                                  //     clearOption: true,
                                  //     dropDownItemCount: 10,
                                  //     listTextStyle: TextStyle(
                                  //         fontSize: 13,
                                  //         fontWeight: FontWeight.w400),
                                  //     textStyle: TextStyle(
                                  //         fontSize: 13,
                                  //         fontWeight: FontWeight.w400),
                                  //     controller: groupNoValue,
                                  //     readOnly: true,
                                  //     dropdownRadius: 5,
                                  //     listPadding: ListPadding(bottom: 8, top: 8),
                                  //     textFieldDecoration: mInputDecoration(
                                  //       padding:
                                  //       EdgeInsets.only(top: 3, left: 10),
                                  //       radius: 5,
                                  //       hint: "No",
                                  //       hintColor: AppColor.textColorLightBlack,
                                  //     ),
                                  //     dropDownList: groupNoList,
                                  //     onChanged: (value) {
                                  //       if (value != null) {
                                  //         groupNo =
                                  //             groupNoValue.dropDownValue?.value;
                                  //         print(groupNoValue.dropDownValue?.name);
                                  //       } else {
                                  //         // Handle the case when nothing is selected
                                  //         groupNo = null;
                                  //       }
                                  //
                                  //       setState(() {});
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                              leaderNameError == null
                                  ? Container()
                                  : Text(
                                      "${leaderNameError}",
                                      style: mTextStyle13(mColor: Colors.red),
                                    ),
                              heightSpacer(mHeight: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Text(
                                        "Then Invite group members",
                                        style: mTextStyle16(mFontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Rounded_Btn_Widget(
                                      title: "Invite Group",
                                      mAlignment: Alignment.center,
                                      btnBgColor: AppColor.activeColor,
                                      mHeight: 35,
                                      onPress: () {
                                        /// Show Dialog
                                        ///
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Alert'),
                                                content: const Text(
                                                  'Now This Button is not Working',
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context, 'Cancel');
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context, 'OK');
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                  heightSpacer(mHeight: 10),
                  Divider(),

                  /// ===========  Experience ================
                  heightSpacer(mHeight: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Experience & Worked",
                        style: mTextStyle15(),
                      ),
                      heightSpacer(mHeight: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: experienceCompany,
                          style: mTextStyle13(),
                          keyboardType: TextInputType.text,
                          decoration: mInputDecoration(
                            hint: "Company Name",
                            radius: 5,
                            padding: EdgeInsets.only(left: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightSpacer(mHeight: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Years of Experience",
                        style: mTextStyle15(),
                      ),
                      heightSpacer(mHeight: 10),
                      SizedBox(
                        height: 45,
                        child: Row(
                          children: [
                            // Exprience year
                            Expanded(
                              child: DropDownTextField(
                                clearOption: true,
                                dropDownItemCount: 10,
                                listTextStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                                textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                                controller: expYearsValue,
                                readOnly: true,
                                dropdownRadius: 5,
                                listPadding: ListPadding(bottom: 8, top: 8),
                                textFieldDecoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Years",
                                  hintColor: AppColor.textColorLightBlack,
                                ),
                                dropDownList: expYearsNoList,
                                onChanged: (value) {
                                  if (value != null) {
                                    totalExpYears = expYearsValue.dropDownValue?.value;
                                    // print(expYearsValue.dropDownValue?.name);
                                  } else {
                                    // Handle the case when nothing is selected
                                    totalExpYears = null;
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                            widthSpacer(),

                            // Experience months
                            Expanded(
                              child: DropDownTextField(
                                clearOption: true,
                                dropDownItemCount: 10,
                                listTextStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                                textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                                controller: expMonthsValue,
                                readOnly: true,
                                dropdownRadius: 5,
                                listPadding: ListPadding(bottom: 8, top: 8),
                                textFieldDecoration: mInputDecoration(
                                  padding: EdgeInsets.only(top: 3, left: 10),
                                  radius: 5,
                                  hint: "Months",
                                  hintColor: AppColor.textColorLightBlack,
                                ),
                                dropDownList: expMonthsNoList,
                                onChanged: (value) {
                                  if (value != null) {
                                    totalExpMonths = expMonthsValue.dropDownValue?.value;
                                    // print(expMonthsValue.dropDownValue?.name);
                                  } else {
                                    // Handle the case when nothing is selected
                                    totalExpMonths = null;
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Submit Btn
                  heightSpacer(mHeight: 35),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is UserLoadedState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Skills_Into_Screen(
                              userModel: widget.userModel,
                              firebaseUser: widget.firebaseUser,
                            ),
                          ),
                        );
                      } else if (state is UserErrorState) {
                        return showSnackBar_Widget(context, mHeading: "Error", title: "${state.error}");
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Rounded_Btn_Widget(
                        title: "Next",
                        btnBgColor: AppColor.btnBgColorGreen,
                        borderColor: AppColor.btnBgColorGreen,
                        onPress: () {
                          checkValue();
                        },
                        mHeight: 40,
                        mAlignment: Alignment.center,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: checkValues =========================
  void checkValue() {
    if (garment_category.isNotEmpty && interest.isNotEmpty && category.isNotEmpty && group_btn != null) {
      if (group_btn != "Group") {
        // if all field is not empty then store data

        widget.userModel.garment_category = garment_category;
        widget.userModel.interest = interest;
        widget.userModel.category = category;
        widget.userModel.job_type = job_type;
        widget.userModel.tailor_type = group_btn;
        widget.userModel.experience_company = experienceCompany.text.toString();
        widget.userModel.totalExpYears = totalExpYears;
        widget.userModel.totalExpMonths = totalExpMonths;

        BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
        //
      } else if (group_btn == "Group") {
        if (leaderNameController.text.isNotEmpty
            // && groupNo != null
            ) {
          // if client selete Group then required both field
          widget.userModel.garment_category = garment_category;
          widget.userModel.interest = interest;
          widget.userModel.category = category;
          widget.userModel.job_type = job_type;
          widget.userModel.tailor_type = group_btn;
          widget.userModel.experience_company = experienceCompany.text.toString();
          widget.userModel.totalExpYears = totalExpYears;
          widget.userModel.totalExpMonths = totalExpMonths;
          widget.userModel.line_leader_name = leaderNameController.text.toString();
          // widget.userModel.group_no = groupNo;

          BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
        } else {
          leaderNameError = "Please fill group leader name";
          showSnackBar_Widget(context, mHeading: "Error", title: "Please fill group leader name and group no.");
          setState(() {});
        }
      } else {
        showSnackBar_Widget(context, mHeading: "Error", title: "Please fill group leader name and group no.");
      }
    } else {
      showSnackBar_Widget(context, mHeading: "Error", title: "Please fill all required fields");
    }
  }
}
