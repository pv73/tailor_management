import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/navigation_bar.dart';
import 'package:tailor/app_widget/ShowSnackBar_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/user_cubit/user_cubit.dart';
import 'package:tailor/dynimic_list/Bank_Name_List.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

class Bank_Into_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Bank_Into_Screen(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Bank_Into_Screen> createState() => _Bank_Into_ScreenState();
}

class _Bank_Into_ScreenState extends State<Bank_Into_Screen> {
  TextEditingController account_no = TextEditingController();
  TextEditingController ifsc_code = TextEditingController();

  var _Selected_Bank;
  String? bank_Name;
  bool? bank_request = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 38,
          child: TextFormField(
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            decoration: mInputDecoration(
              padding: EdgeInsets.only(top: 3),
              prefixIcon: Icon(Icons.search),
              mIconSize: 18,
              hint: "Search bank hear",
              hintColor: AppColor.textColorLightBlack,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "If you have not any bank account",
                  style: mTextStyle15(mFontWeight: FontWeight.w700),
                ),

                heightSpacer(mHeight: 5),
                Row(
                  children: [
                    Expanded(child: Text("Request Bank Account apply")),
                    FlutterSwitch(
                      activeColor: AppColor.btnBgColorGreen,
                      height: 30,
                      width: 58,
                      activeIcon: Icon(
                        Icons.check_circle_rounded,
                        color: AppColor.btnBgColorGreen,
                      ),
                      valueFontSize: 12,
                      value: bank_request!,
                      showOnOff: true,
                      onToggle: (value) {
                        bank_request = value;
                        setState(() {});
                        print(bank_request);
                      },
                    )
                  ],
                ),

                heightSpacer(),
                Divider(),
                //
                heightSpacer(mHeight: 15),
                bank_request != false
                    ? Text("")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add bank account",
                            style: mTextStyle15(mFontWeight: FontWeight.w700),
                          ),

                          // bank Name
                          heightSpacer(mHeight: 15),
                          Card_Container_Widget(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Popular Banks",
                                  style: mTextStyle14(
                                      mFontWeight: FontWeight.w700),
                                ),

                                /// bank list
                                heightSpacer(mHeight: 15),
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: bank_list.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                          mainAxisExtent: 115),
                                  itemBuilder: (context, bank_Index) {
                                    var bank_list_index = bank_list[bank_Index];
                                    return InkWell(
                                      onTap: () {
                                        _Selected_Bank = bank_Index;
                                        _Selected_Bank =
                                            bank_list[_Selected_Bank];
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.blue.shade50,
                                            child: Image.asset(
                                              bank_list[bank_Index]
                                                  ['bank_Icon']!,
                                              width: 38,
                                            ),
                                          ),
                                          heightSpacer(mHeight: 7),
                                          Text(
                                            bank_list_index['bank_Name']!,
                                            style: mTextStyle13(
                                                mFontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                heightSpacer(mHeight: 15),
                if (_Selected_Bank == null || bank_request == true)
                  Container()
                else
                  Card_Container_Widget(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade50,
                              radius: 23,
                              child: Image.asset(
                                _Selected_Bank['bank_Icon']!,
                                width: 28,
                              ),
                            ),
                            widthSpacer(mWidth: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selected bank",
                                  style: mTextStyle15(
                                      mFontWeight: FontWeight.w500,
                                      mColor: AppColor.textColorLightBlack),
                                ),
                                heightSpacer(mHeight: 2),
                                Text(
                                  _Selected_Bank['bank_Name']!,
                                  style: mTextStyle17(
                                      mFontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 25,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: account_no,
                            maxLength: 16,
                            style: mTextStyle13(),
                            keyboardType: TextInputType.number,
                            decoration: mInputDecoration(
                                hint: "Account Number",
                                radius: 5,
                                padding: EdgeInsets.only(left: 15),
                                mCounterText: ""),
                          ),
                        ),
                        heightSpacer(mHeight: 15),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: ifsc_code,
                            maxLength: 11,
                            style: mTextStyle13(),
                            keyboardType: TextInputType.text,
                            decoration: mInputDecoration(
                                hint: "IFSC",
                                radius: 5,
                                padding: EdgeInsets.only(left: 15),
                                mCounterText: ""),
                          ),
                        ),
                      ],
                    ),
                  ),
                heightSpacer(mHeight: 60),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Rounded_Btn_Widget(
            title: "Next",
            mTextColor: Colors.white,
            btnBgColor: AppColor.btnBgColorGreen,
            onPress: () {
              if (_Selected_Bank != null || bank_request == true) {
                if (_Selected_Bank != null) {
                  if (account_no.text.isNotEmpty && ifsc_code.text.isNotEmpty) {
                    _showDialog();
                  } else {
                    showSnackBar_Widget(context,
                        mHeading: "Error",
                        title: "Account Number and IFSC Code are required");
                  }
                } else {
                  _showDialog();
                }
              } else {
                showSnackBar_Widget(context,
                    mHeading: "Error", title: "Min one field required");
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

// ============== UI end
// ================================================
// ================ Submit logic =============

  void _showDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            content: Lottie.asset(
                "assets/images/lottie_animation/form_submited.json"),
            // contentPadding: EdgeInsets.zero,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Cancel'),
              ),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is UserLoadedState) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navigation_Bar(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser),
                      ),
                    );
                  } else if (state is UserErrorState) {
                    showSnackBar_Widget(context,
                        mHeading: "Error", title: "${state.error}");
                  }
                },
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return TextButton(
                    onPressed: () async {
                      // add data in userModel

                      if (_Selected_Bank == null) {
                        widget.userModel.bank_request = bank_request;
                        widget.userModel.final_submit = true;
                      } else {
                        widget.userModel.bank_name =
                            _Selected_Bank['bank_Name'];
                        widget.userModel.account_number =
                            account_no.text.toString();
                        widget.userModel.ifsc_code =
                            ifsc_code.text.toString().trim();
                        widget.userModel.final_submit = true;
                      }

                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool("final_submit", true);

                      BlocProvider.of<UserCubit>(context)
                          .addUserModel(widget.userModel);
                    },
                    child: const Text('Submit'),
                  );
                },
              ),
            ],
          );
        });
  }
}
