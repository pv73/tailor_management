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

  const Interest_Into_Screen(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Interest_Into_Screen> createState() => _Interest_Into_ScreenState();
}

class _Interest_Into_ScreenState extends State<Interest_Into_Screen> {
  List<String> interest = [];
  List<String> category = [];
  List<String> garment_category = [];
  // String? groupNo;
  String? group_btn;
  String? totalExpYears;
  String? totalExpMonths;

  TextEditingController experienceCompany = TextEditingController();
  TextEditingController leaderNameController = TextEditingController();
  SingleValueDropDownController groupNoValue = SingleValueDropDownController();
  // List<DropDownValueModel> groupNoList = [];

  // for Experience
  SingleValueDropDownController expYearsValue = SingleValueDropDownController();
  List<DropDownValueModel> expYearsNoList = [];

  SingleValueDropDownController expMonthsValue =
  SingleValueDropDownController();
  List<DropDownValueModel> expMonthsNoList = [];

  //

  @override
  void initState() {
    super.initState();
    generateDropDownList();
  }

  void generateDropDownList() {
    // for (int i = 1; i <= 50; i++) {
    //   String number = i.toString().padLeft(2, '0');
    //   // Convert number to two-digit format
    //   groupNoList.add(DropDownValueModel(name: number, value: number));
    // }

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

                  // Garment Category Details
                  heightSpacer(mHeight: 20),
                  Text(
                    "Garment Category",
                    style: mTextStyle19(
                        mColor: AppColor.textColorBlack,
                        mFontWeight: FontWeight.w700),
                  ),

                  /// Garment Category Button
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

                      // print(garment_category);
                    },
                  ),
                  heightSpacer(mHeight: 10),
                  Divider(),

                  // Interest Details
                  heightSpacer(mHeight: 5),
                  Text(
                    "Department of Interest",
                    style: mTextStyle19(
                        mColor: AppColor.textColorBlack,
                        mFontWeight: FontWeight.w700),
                  ),

                  /// Interest Button
                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: false,
                    buttons: [
                      "Sampling",
                      "Alter Tailor for Finishing",
                      "Production",
                      "Other"
                    ],
                    onSelected: (Interest_btn_name, index, isSelected) {
                      if (isSelected) {
                        interest.add(Interest_btn_name);
                      } else {
                        interest.remove(Interest_btn_name);
                      }

                      // print(interest);
                    },
                  ),

                  heightSpacer(mHeight: 10),
                  Divider(),

                  /// Category Details
                  heightSpacer(mHeight: 5),
                  Text(
                    "Category of Tailor",
                    style: mTextStyle19(
                        mColor: AppColor.textColorBlack,
                        mFontWeight: FontWeight.w700),
                  ),

                  ///  Category Button
                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: false,
                    buttons: [
                      "Full Piece",
                      "Part Rate",
                      "Salary",
                      "Other"
                    ],
                    onSelected: (cat_btn_name, index, isSelected) {
                      if (isSelected) {
                        category.add(cat_btn_name);
                      } else {
                        category.remove(cat_btn_name);
                      }
                      // print(category);
                    },
                  ),

                  heightSpacer(mHeight: 10),
                  Divider(),

                  /// Group or individual
                  heightSpacer(mHeight: 5),
                  Text(
                    "Group or Individual",
                    style: mTextStyle19(
                        mColor: AppColor.textColorBlack,
                        mFontWeight: FontWeight.w700),
                  ),

                  ///  Category Button
                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: true,
                    buttons: [
                      "Group",
                      "individual",
                    ],
                    onSelected: (btn_name, index, isSelected) {
                      if (isSelected) {
                        group_btn = btn_name;
                      }
                      print(group_btn);
                      setState(() {});
                    },
                  ),

                  /// Category Details
                  heightSpacer(mHeight: 20),
                  group_btn != "Group"
                      ? Container()
                      : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            // flex: 6,
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: leaderNameController,
                                style: mTextStyle13(),
                                keyboardType: TextInputType.text,
                                decoration: mInputDecoration(
                                  hint: "Group leader name",
                                  radius: 5,
                                  padding: EdgeInsets.only(left: 15),
                                ),
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
                      heightSpacer(mHeight: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Text(
                                "Then Invite group members",
                                style: mTextStyle16(
                                    mFontWeight: FontWeight.w600),
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
                                              Navigator.pop(
                                                  context, 'Cancel');
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context, 'OK');
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

                  heightSpacer(mHeight: 10),
                  Divider(),

                  /// Experience
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

                  /// Experience
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
                                listTextStyle: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                textStyle: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
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
                                    totalExpYears =
                                        expYearsValue.dropDownValue?.value;
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
                                listTextStyle: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                textStyle: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
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
                                    totalExpMonths =
                                        expMonthsValue.dropDownValue?.value;
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
                            builder: (context) =>
                                Skills_Into_Screen(
                                  userModel: widget.userModel,
                                  firebaseUser: widget.firebaseUser,
                                ),
                          ),
                        );
                      } else if (state is UserErrorState) {
                        return showSnackBar_Widget(context,
                            mHeading: "Error", title: "${state.error}");
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
    if (garment_category.isNotEmpty &&
        interest.isNotEmpty &&
        category.isNotEmpty &&
        group_btn != null) {
      if (group_btn != "Group") {
        // if all field is not empty then store data

        widget.userModel.garment_category = garment_category;
        widget.userModel.interest = interest;
        widget.userModel.category = category;
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
          widget.userModel.tailor_type = group_btn;
          widget.userModel.experience_company =
              experienceCompany.text.toString();
          widget.userModel.totalExpYears = totalExpYears;
          widget.userModel.totalExpMonths = totalExpMonths;
          widget.userModel.line_leader_name =
              leaderNameController.text.toString();
          // widget.userModel.group_no = groupNo;

          BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
        } else {
          showSnackBar_Widget(context,
              mHeading: "Error",
              title: "Please fill group leader name and group no.");
        }
      } else {
        showSnackBar_Widget(context,
            mHeading: "Error",
            title: "Please fill group leader name and group no.");
      }

      // BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
    } else {
      showSnackBar_Widget(context,
          mHeading: "Error",
          title: "Some fields are empty");
    }
  }
}
