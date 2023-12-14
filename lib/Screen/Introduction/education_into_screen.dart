import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/interest_into_screen.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';

import '../../ui_helper.dart';

class Education_Into_Screen extends StatefulWidget {
  @override
  State<Education_Into_Screen> createState() => _Education_Into_ScreenState();
}

class _Education_Into_ScreenState extends State<Education_Into_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pass_year = TextEditingController();
  TextEditingController collage_name = TextEditingController();

  //
  // Variables
  String? UserId;
  String? education;
  var education_year;
  var course;
  bool _isDropDownOption = false;
  late SingleValueDropDownController branch_value =
      SingleValueDropDownController();

  //dropdown options
  List<DropDownValueModel> currentOptions = [];

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Function to retrieve the UserId from shared preferences
  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserId = prefs.getString('UserId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height - 120,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number Indicator Row
                  Row(
                    children: [
                      // 1st number
                      Intro_Number_Widget(number: 1, name: "About"),
                      Expanded(
                        child: Divider(color: AppColor.cardBtnBgGreen),
                      ),

                      // 2nd Number
                      Intro_Number_Widget(
                          number: 2, name: "Education", active_no: 2),
                      Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                      // 3rd Number
                      Intro_Number_Widget(number: 3, name: "Interest"),
                      Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                      // 4th Number
                      Intro_Number_Widget(number: 4, name: "Skills"),
                    ],
                  ),

                  Divider(height: 35),

                  // Start Profile Box
                  UserId == null
                      ? Center(child: CircularProgressIndicator())
                      : Profile_box_Widget(UserId: UserId),

                  // Education Details
                  heightSpacer(mHeight: 20),
                  Text(
                    "Your Highest Eduction",
                    style: mTextStyle19(
                        mColor: AppColor.textColorBlack,
                        mFontWeight: FontWeight.w700),
                  ),

                  /// Education Button
                  heightSpacer(mHeight: 10),
                  GroupButton(
                    options: mGroupButtonOptions(),
                    isRadio: true,
                    buttons: [
                      "10th or Below 10th",
                      "12th Pass",
                      "Diploma",
                      "ITI",
                      "Graduate",
                      "Post Graduate"
                          "Other"
                    ],
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
                                style: mTextStyle15(),
                              ),
                              heightSpacer(mHeight: 5),
                              SizedBox(
                                height: 45,
                                child: DropDownTextField(
                                  controller: branch_value,
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
                                      course =
                                          branch_value.dropDownValue!.value;
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
                      Text(
                        "Collage/Institute Name",
                        style: mTextStyle15(),
                      ),
                      heightSpacer(mHeight: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: collage_name,
                          keyboardType: TextInputType.text,
                          decoration: mInputDecoration(
                            hint: "",
                            radius: 5,
                            padding: EdgeInsets.only(top: 10, left: 15),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "please enter institute name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  ///  Passing Year
                  heightSpacer(mHeight: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Passing Year",
                        style: mTextStyle15(),
                      ),
                      heightSpacer(mHeight: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: pass_year,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: mInputDecoration(
                              hint: "Passing Year",
                              radius: 5,
                              padding: EdgeInsets.only(top: 10, left: 15),
                              mCounterText: ""),
                          onChanged: (value) {
                            education_year = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
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
          child: Rounded_Btn_Widget(
            title: "Next",
            mTextColor:
                education == null ? AppColor.btnBgColorGreen : Colors.white,
            btnBgColor: AppColor.btnBgColorGreen,
            borderColor: AppColor.btnBgColorGreen,
            onPress: education == null
                ? null
                : () {
                    if (pass_year.text.isNotEmpty &&
                        pass_year.text.length >= 4 &&
                        int.tryParse(pass_year.text) != null &&
                        int.parse(pass_year.text) <= 2023 &&
                        collage_name.text.isNotEmpty) {
                      var qualification = {
                        'education': '${education}',
                        'course': course == null ? null : "${course}",
                        'education_year': '${pass_year.text}',
                        'collage_name': '${collage_name.text}'
                      };

                      FirebaseFirestore.instance
                          .collection('clients')
                          .doc(UserId)
                          .update(qualification);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Interest_Into_Screen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Center(
                            child: Text(
                                "Please Enter education year less then 2023 or mini. 4 digit"),
                          ),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  },
            mHeight: 40,
            borderRadius: 5,
            mAlignment: Alignment.center,
          ),
        ),
      ),
    );
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
              style: mTextStyle13(
                  mFontWeight: FontWeight.w600,
                  mColor: AppColor.textColorLightBlack),
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
    DropDownValueModel(
        name: "Computer Science Engineering", value: "Computer_Science_Eng."),
    DropDownValueModel(
        name: "Mechanical Engineering", value: "Mechanical_Eng."),
    DropDownValueModel(
        name: "Electrical Engineering", value: "Electrical_Eng."),
    DropDownValueModel(name: "Civil Engineering", value: "Civil_Eng."),
    DropDownValueModel(
        name: "Electronics Engineering", value: "Electronics_Eng."),
    DropDownValueModel(name: "Automobile Engineering", value: "Automobile_Eng.")
  ];

  List<DropDownValueModel> itiOptions = [
    DropDownValueModel(name: "Carpenter", value: "Carpenter"),
    DropDownValueModel(name: "Computer Operator", value: "Computer_Operator"),
    DropDownValueModel(name: "Electrician", value: "Electrician"),
    DropDownValueModel(
        name: "Electronic Mechanic", value: "Electronic_Mechanic"),
    DropDownValueModel(name: "Fitter", value: "Fitter"),
    DropDownValueModel(name: "Plumber", value: "Plumber")
  ];
}
