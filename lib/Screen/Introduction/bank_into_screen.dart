import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/navigation_screen/navigation_bar.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_Helper.dart';

class Bank_Into_Screen extends StatefulWidget {
  @override
  State<Bank_Into_Screen> createState() => _Bank_Into_ScreenState();
}

class _Bank_Into_ScreenState extends State<Bank_Into_Screen> {
  TextEditingController account_no = TextEditingController();
  TextEditingController ifsc_code = TextEditingController();

  var _Selected_Bank;
  String? bank_Name;
  String? UserId;

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
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add bank account",
                  style: mTextStyle17(mFontWeight: FontWeight.w700),
                ),
                heightSpacer(mHeight: 15),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Popular Banks",
                        style: mTextStyle16(mFontWeight: FontWeight.w700),
                      ),

                      /// bank list
                      heightSpacer(mHeight: 15),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: bank_list.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            mainAxisExtent: 115),
                        itemBuilder: (context, bank_Index) {
                          var bank_list_index = bank_list[bank_Index];
                          return InkWell(
                            onTap: () {
                              _Selected_Bank = bank_Index;
                              _Selected_Bank = bank_list[_Selected_Bank];
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue.shade50,
                                  child: Image.asset(
                                    bank_list[bank_Index]['bank_Icon']!,
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
                heightSpacer(mHeight: 15),
                _Selected_Bank == null
                    ? Container()
                    : Card_Container_Widget(
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
                                          mFontWeight: FontWeight.w600,
                                          mColor: AppColor.textColorLightBlack),
                                    ),
                                    heightSpacer(mHeight: 2),
                                    Text(
                                      _Selected_Bank['bank_Name']!,
                                      style: mTextStyle19(
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
                            TextFormField(
                              controller: account_no,
                              maxLength: 16,
                              keyboardType: TextInputType.number,
                              decoration: mInputDecoration(
                                  hint: "Account Number",
                                  radius: 5,
                                  mCounterText: ""),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 25,
                            ),
                            TextFormField(
                              controller: ifsc_code,
                              maxLength: 11,
                              keyboardType: TextInputType.text,
                              decoration: mInputDecoration(
                                  mLabelText: "IFSC",
                                  hint: "IFSC Number",
                                  mCounterText: "",
                                  radius: 5),
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
              _showDialog();
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
              TextButton(
                onPressed: () async {
                  var account_page;

                  if (_Selected_Bank == null) {
                    account_page = {
                      'bank_name': "",
                      'account_number': account_no.text.toString(),
                      'ifsc_code': ifsc_code.text.toString().trim(),
                      'final_submit': true
                    };
                  } else {
                    account_page = {
                      'bank_name': _Selected_Bank['bank_Name'],
                      'account_number': account_no.text.toString(),
                      'ifsc_code': ifsc_code.text.toString().trim(),
                      'final_submit': true
                    };
                  }

                  FirebaseFirestore.instance
                      .collection('clients')
                      .doc(UserId)
                      .update(account_page);

                  // Save UserId to shared preferences
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('final_submit', true);

                  // All Page close then Navigate to Navigation_Bar
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Navigation_Bar(),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          );
        });
  }
}

/// Bank List
final bank_list = [
  {
    "bank_Icon": "assets/images/logo/ic_sbi.png",
    "bank_Name": "State Bank of India"
  },
  {
    "bank_Icon": "assets/images/logo/ic_pnb.png",
    "bank_Name": "Punjab National Bank"
  },
  {"bank_Icon": "assets/images/logo/ic_hdfc.png", "bank_Name": "HDFC Bank"},
  {
    "bank_Icon": "assets/images/logo/ic_kotak.png",
    "bank_Name": "Kotak Mahindra Bank"
  },
  {
    "bank_Icon": "assets/images/logo/ic_baroda.png",
    "bank_Name": "Bank of Baroda"
  },
  {"bank_Icon": "assets/images/logo/ic_icici.png", "bank_Name": "ICICI Bank"},
  {"bank_Icon": "assets/images/logo/ic_axis.png", "bank_Name": "Axis Bank"},
  {
    "bank_Icon": "assets/images/logo/ic_union.png",
    "bank_Name": "Union Bank of India"
  },
];
