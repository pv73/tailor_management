import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:tailor/Screen/Users_Screens/Introduction/location_into_screen.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class About_Me extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const About_Me({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<About_Me> createState() => _About_MeState();
}

class _About_MeState extends State<About_Me> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? gender;

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start Profile Box
                Profile_box_Widget(userModel: widget.userModel, firebaseUser: widget.firebaseUser),

                // Start All Text Field
                heightSpacer(mHeight: 20),
                Text(
                  "About Me",
                  style: mTextStyle19(mColor: AppColor.textColorBlack, mFontWeight: FontWeight.w700),
                ),

                // ============= Name Field =================
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: mTextStyle13(mFontWeight: FontWeight.w500),
                    ),
                    heightSpacer(mHeight: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: userNameController,
                        enabled: widget.userModel.user_name == null ? true : false,
                        style: mTextStyle14(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          hintText: widget.userModel.user_name == null ? "User Name" : "${widget.userModel.user_name}",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.textColorBlack, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // =============Mobile Number =================
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile No.",
                      style: mTextStyle13(mFontWeight: FontWeight.w500),
                    ),
                    heightSpacer(mHeight: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: userNameController,
                        enabled: widget.userModel.phone == null ? true : false,
                        style: mTextStyle14(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          hintText: widget.userModel.user_name == null ? "Mobile no." : "${widget.userModel.phone}",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.textColorBlack, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //========= Email Field=================
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email (Optional)",
                      style: mTextStyle13(mFontWeight: FontWeight.w500),
                    ),
                    heightSpacer(mHeight: 5),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: emailController,
                        enabled: widget.userModel.email == null ? true : false,
                        style: mTextStyle14(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.textColorBlack, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.textColorBlack, width: 2),
                          ),
                          hintText: widget.userModel.email == null ? "Email" : "${widget.userModel.email}",
                        ),
                      ),
                    ),
                  ],
                ),

                // Date Of Birth Field
                heightSpacer(mHeight: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(text: "Date of birth", style: mTextStyle13(mFontWeight: FontWeight.w500), children: [
                        TextSpan(
                          text: " *",
                          style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                        )
                      ]),
                    ),

                    heightSpacer(mHeight: 5),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: dateInputController,
                        style: mTextStyle14(),
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        decoration: mInputDecoration(
                          hint: "Enter Date",
                          suffixIcon: Icon(Icons.calendar_month_outlined),
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
                    RichText(
                      text: TextSpan(text: "Gender", style: mTextStyle13(mFontWeight: FontWeight.w500), children: [
                        TextSpan(
                          text: " *",
                          style: mTextStyle14(mFontWeight: FontWeight.w700, mColor: Colors.red),
                        )
                      ]),
                    ),
                    heightSpacer(mHeight: 5),
                    GroupButton(
                        options: mGroupButtonOptions(),
                        isRadio: true,
                        buttons: ["Male", "Female"],
                        onSelected: (btn_name, index, isSelected) {
                          // print("print ${btn_name}");
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
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UserLoadedState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Location_Into_Screen(userModel: widget.userModel, firebaseUser: widget.firebaseUser),
                  ),
                );
              } else if (state is UserErrorState) {
                showSnackBar_Widget(context, mHeading: "Error", title: "${state.error}");
              }
            },
            builder: (context, state) {
              return Rounded_Btn_Widget(
                title: "Next",
                mTextColor: Colors.white,
                btnBgColor: AppColor.btnBgColorGreen,
                borderColor: AppColor.btnBgColorGreen,
                onPress: () {
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
    String get_user_name = userNameController.text.toString();
    String get_email = emailController.text.toString();

    // firebase database se check ker rahe h ki ager null nahi h to text field ka store ho nahi to stored data
    String? user_name = get_user_name.isEmpty ? widget.userModel.user_name : get_user_name;
    String? email = get_email.isEmpty ? widget.userModel.email : get_email;

    if (dateInputController.text == "" || gender == null || user_name == null) {
      showSnackBar_Widget(context, mHeading: "Error", title: "Fill in the DOB and Gender field");
    } else {
      widget.userModel.user_name = user_name;
      widget.userModel.email = email;
      widget.userModel.dob = dateInputController.text.trim();
      widget.userModel.gender = gender;

      BlocProvider.of<UserCubit>(context).addUserModel(widget.userModel);
    }
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
              style: mTextStyle13(mFontWeight: FontWeight.w600, mColor: AppColor.textColorLightBlack),
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
        firstDate: DateTime(1970), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now());

    if (pickedDate != null) {
      // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat.yMMMMd('en_US').format(pickedDate);
      // print(
      //     formattedDate); //formatted date output using intl package => October 20, 2023

      setState(() {
        dateInputController.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
}
