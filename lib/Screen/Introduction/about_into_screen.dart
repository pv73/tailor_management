import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/location_into_screen.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_Helper.dart';

class About_Me extends StatefulWidget {
  @override
  State<About_Me> createState() => _About_MeState();
}

class _About_MeState extends State<About_Me> {
  TextEditingController full_name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  String? UserId;
  String? user_name;
  String? Email_Id_Value;
  String? gender;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number Indicator Row
                Row(
                  children: [
                    // 1st number
                    Intro_Number_Widget(
                      number: 1,
                      name: "About",
                      active_no: 1,
                    ),
                    Expanded(
                      child: Divider(color: AppColor.cardBtnBgGreen),
                    ),

                    // 2nd Number
                    Intro_Number_Widget(number: 2, name: "Education"),
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

                // Start All Text Field
                heightSpacer(mHeight: 20),
                Text(
                  "About Me",
                  style: mTextStyle19(
                      mColor: AppColor.textColorBlack,
                      mFontWeight: FontWeight.w700),
                ),

                // Name Field
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: mTextStyle15(),
                    ),
                    heightSpacer(mHeight: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: full_name,
                        keyboardType: TextInputType.text,
                        onChanged: (name_value) {
                          user_name = name_value;
                          setState(() {});
                        },
                        decoration: mInputDecoration(
                            hint: "Enter Name",
                            radius: 5,
                            padding: EdgeInsets.only(top: 10, left: 15)),
                      ),
                    ),
                  ],
                ),

                // Email Field
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email (Optional)",
                      style: mTextStyle15(),
                    ),
                    heightSpacer(mHeight: 5),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: emailId,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (email_value) {
                          Email_Id_Value = email_value;
                          setState(() {});
                        },
                        decoration: mInputDecoration(
                            hint: "Email Id",
                            radius: 5,
                            padding: EdgeInsets.only(top: 10, left: 15)),
                      ),
                    ),
                  ],
                ),

                // Date Of Birth Field
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date of birth",
                      style: mTextStyle15(),
                    ),
                    heightSpacer(mHeight: 5),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: dateInput,
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        decoration: mInputDecoration(
                          hint: "Enter Date",
                          suffixIcon: Icons.calendar_month_outlined,
                          suffixColor: AppColor.textColorBlack,
                          radius: 5,
                          padding: EdgeInsets.only(top: 10, left: 15),
                        ),
                        onTap: () {
                          DateInput();
                        },
                      ),
                    ),
                  ],
                ),

                // Gender Field
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: mTextStyle15(),
                    ),
                    heightSpacer(mHeight: 5),
                    GroupButton(
                        options: mGroupButtonOptions(),
                        isRadio: true,
                        buttons: ["Male", "Female"],
                        onSelected: (btn_name, index, isSelected) {
                          // print("${btn_name}");
                          gender = btn_name;
                        })
                  ],
                ),
                heightSpacer(mHeight: 100),
              ],
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
                user_name == null ? AppColor.btnBgColorGreen : Colors.white,
            btnBgColor: AppColor.btnBgColorGreen,
            borderColor: AppColor.btnBgColorGreen,
            onPress: user_name == null
                ? null
                : () {
                    var aboutData = {
                      'user_name': full_name.text.toString().trim(),
                      "email": emailId.text.toString().trim(),
                      "dob": dateInput.text.trim(),
                      "gender": gender,
                    };

                    FirebaseFirestore.instance
                        .collection('clients')
                        .doc(UserId)
                        .update(aboutData);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Location_Into_Screen(),
                      ),
                    );
                  },
            mHeight: 40,
            borderRadius: 5,
            mAlignment: Alignment.center,
          ),
        ),
      ),
    );
  }

  // ========================== End UI =======================================
  // ==========================================================================

  // Icon and Text for number and email etc Widget
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

  // ============================================
  //  Date of Birth section and date Calender open
  // ==============================================
  DateInput() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            1970), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now());

    if (pickedDate != null) {
      // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat.yMMMMd('en_US').format(pickedDate);
      // print(
      //     formattedDate); //formatted date output using intl package => October 20, 2023

      setState(() {
        dateInput.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
}
