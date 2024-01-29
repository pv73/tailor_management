import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailor/Screen/user_onboard/Login_Page.dart';
import 'package:tailor/Screen/user_onboard/SignUp_page.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class First_Dashboard extends StatefulWidget {
  final User? firebaseUser;
  final UserModel? userModel;

  const First_Dashboard({super.key, this.firebaseUser, this.userModel});

  @override
  State<First_Dashboard> createState() => _First_Dashboard();
}

class _First_Dashboard extends State<First_Dashboard> {
  late MediaQueryData mq;
  bool _isCompany = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        titleSpacing: 0,
        title: SizedBox(
          height: 38,
          width: mq.size.width * 0.78,
          child: TextFormField(
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            decoration: mInputDecoration(
              padding: EdgeInsets.only(top: 3),
              prefixIcon: Icon(Icons.search),
              mIconSize: 18,
              hint: "Search job hear",
              hintColor: AppColor.textColorLightBlack,
            ),
          ),
        ),
      ),
      drawer: Drawer_Widget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            heightSpacer(mHeight: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Make the Most of Tailor by creating your Tailor profile",
                style: mTextStyle19(
                    mFontWeight: FontWeight.w900,
                    mColor: AppColor.textColorBlack),
              ),
            ),

            //  Text with star
            heightSpacer(mHeight: 15),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/banner/bg_man.png"),
                    alignment: Alignment.bottomRight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                      widthSpacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get discovered directly by Textile Industry",
                            style: mTextStyle13(mFontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Recruiters will not post a job 70% of the time",
                            style: mTextStyle11(),
                          )
                        ],
                      )
                    ],
                  ),

                  //  Text with star
                  heightSpacer(mHeight: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                      ),
                      widthSpacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Find relevant job recommendations",
                            style: mTextStyle13(mFontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Relevance is better for complete profile",
                            style: mTextStyle11(),
                          )
                        ],
                      )
                    ],
                  ),

                  // buttons
                  heightSpacer(mHeight: 15),
                  Rounded_Btn_Widget(
                    onPress: () {
                      setState(() {
                        _isCompany = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp_page(
                                    isCompany: _isCompany,
                                  )),
                        );
                      });
                    },
                    mWidth: mq.size.width * 0.51,
                    mHeight: 40,
                    mAlignment: Alignment.center,
                    borderRadius: 10,
                    mfontSize: 12,
                    borderColor: AppColor.textColorBlue,
                    btnBgColor: AppColor.textColorBlue,
                    mPadding: EdgeInsets.symmetric(horizontal: 13),
                    title: "Register Tailor",
                  ),

                  heightSpacer(mHeight: 5),
                  Rounded_Btn_Widget(
                    onPress: () {
                      setState(() {
                        _isCompany = true;

                        // Get.to used because Navigate newPage with animation
                        Get.to(
                          SignUp_page(
                            isCompany: _isCompany,
                          ),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 500),
                        );
                      });
                    },
                    mWidth: mq.size.width * 0.51,
                    mHeight: 40,
                    mAlignment: Alignment.center,
                    borderRadius: 10,
                    mfontSize: 12,
                    borderColor: AppColor.textColorBlue,
                    btnBgColor: AppColor.textColorBlue,
                    mPadding: EdgeInsets.symmetric(horizontal: 13),
                    title: "Register Company",
                  ),

                  heightSpacer(mHeight: 5),
                  Rounded_Btn_Widget(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn_Page()),
                      );
                    },
                    mWidth: mq.size.width * 0.51,
                    mHeight: 40,
                    mAlignment: Alignment.center,
                    borderRadius: 10,
                    mfontSize: 12,
                    borderColor: Colors.orange,
                    btnBgColor: Colors.orange,
                    mPadding: EdgeInsets.symmetric(horizontal: 13),
                    title: "Login",
                  ),
                ],
              ), // Column
            ),

            /// Find Your Job tailor
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20),
              color: Colors.white54,
              child: Column(
                children: [
                  Image(
                    width: 130,
                    image: AssetImage("assets/images/banner/search_man.png"),
                  ),
                  heightSpacer(),
                  Text(
                    "Find your tailor job",
                    style: mTextStyle15(),
                  ),
                  heightSpacer(mHeight: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        prefixIcon: Icon(Icons.location_city),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 10,
                        hint: "Enter skill, designations and company",
                        hintColor: AppColor.textColorLightBlack,
                      ),
                    ),
                  ),
                  heightSpacer(mHeight: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      decoration: mInputDecoration(
                        padding: EdgeInsets.only(top: 3),
                        prefixIcon: Icon(Icons.location_on_outlined),
                        preFixColor: AppColor.textColorLightBlack,
                        mIconSize: 18,
                        radius: 10,
                        hint: "Enter Location",
                        hintColor: AppColor.textColorLightBlack,
                      ),
                    ),
                  ),
                  heightSpacer(mHeight: 20),
                  Rounded_Btn_Widget(
                    mWidth: mq.size.width * 0.50,
                    mHeight: 40,
                    mfontSize: 13,
                    mAlignment: Alignment.center,
                    borderRadius: 10,
                    onPress: () {},
                    title: "Search Job",
                  ),

                  // Hiring Job Section
                  heightSpacer(mHeight: 50),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "70% hiring \nhappens without \nany job post",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        heightSpacer(mHeight: 15),
                        Text(
                          "Top companies on tailor are hiring by directly \nreaching out to jobseeks without osting a job. \nLearn how you can make the best of this opportunity",
                          style: mTextStyle13(
                              mFontWeight: FontWeight.w500,
                              mHeight: 1.4,
                              mColor: Colors.grey.shade900),
                        ),
                        heightSpacer(mHeight: 20),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Learn More...",
                            style: mTextStyle14(
                              mColor: AppColor.navBgColor,
                              mFontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        heightSpacer(mHeight: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
