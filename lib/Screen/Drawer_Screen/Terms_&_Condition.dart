
import 'package:flutter/material.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_helper.dart';

class Terms_And_Condition extends StatefulWidget {
  @override
  State<Terms_And_Condition> createState() => _Terms_And_ConditionState();
}

class _Terms_And_ConditionState extends State<Terms_And_Condition> {
  late MediaQueryData mq;

  bool isTermsVisible = false;
  bool isGeneralVisible = false;
  bool isAccuracyVisible = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========== Top Banner and Text ============
          Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: mq.size.height * 0.18,
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/banner/about_banner.jpg"),
                      fit: BoxFit.fitWidth),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Terms and Conditions",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white24,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 17,
                        color: AppColor.textColorWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ================ Start Terms and Conditions Text ==================
                    heightSpacer(mHeight: 15),
                    Text(
                      "Terms and Conditions",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),

                     Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.6,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Tailor Management operates this website. Terms, such as “we”, “our”, and “us” refer to TailorManagement.com. Tailor Management provides this website with all the data, services featured, and tools. All the services available to tailormanagement.com users from this website are conditioned to the acceptance of terms, policies, and conditions described on this page.",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // Hide / Show Content Container
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: isTermsVisible ? mq.size.width : 0,
                      child: isTermsVisible
                          ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Users comply with these terms and conditions by visiting this website, using our services, using our products, and buying/using our services. Users, who visit this website and use our services, agree to follow the terms and conditions (Terms of Service) described on this page. \n\n"
                              "We recommend users carefully read these Terms of Service before accessing our website. By using or accessing our website or any web page of this website you agree to comply with these terms and conditions. Users/visitors, who do not agree to any or all the Terms and Conditions described in this agreement, should not use our services or access our website. ",
                              style: mTextStyle14(),
                              textAlign: TextAlign.justify,
                            ),
                          )
                          : null,
                    ),

                    heightSpacer(mHeight: 5),
                    ReadMoreAndLessMore_Btn(
                      onPress: () {
                        setState(() {
                          isTermsVisible = !isTermsVisible;
                        });
                      },
                      mText: !isTermsVisible ? "Read More..." : "Read Less...",
                    ),


                    // ================ Start General Conditions ==================

                    heightSpacer(mHeight: 20),
                    Text(
                      "General Conditions ",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.63,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Users understand that their information (excluding credit card data) can be transferred in unencrypted form. That information may be transferred over several networks and it might be changed to adapt to meet the technical requirements of connected devices or networks. Users’ credit card information is always shared in encrypted form. ",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // Hide / Show Content Container
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: isGeneralVisible ? mq.size.width : 0,
                      child: isGeneralVisible
                          ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Users agree to not duplicate, reproduce, copy, sell, or exploit services provided on this website. You agree to not access or abuse services offered on this website. Users cannot use our website, content, and services without our consent. \n\n"
                              "Headings used in this Terms and Conditions agreement are only for the convenience of readers. They do not affect or limit the terms of service described in this agreement. We can refuse to serve any user at any time and for any reason without any explanation.  ",
                              style: mTextStyle14(),
                              textAlign: TextAlign.justify,
                            ),
                          )
                          : null,
                    ),

                    heightSpacer(mHeight: 5),
                    ReadMoreAndLessMore_Btn(
                      onPress: () {
                        setState(() {
                          isGeneralVisible = !isGeneralVisible;
                        });
                      },
                      mText:
                          !isGeneralVisible ? "Read More..." : "Read Less...",
                    ),

                    // ================ Start Completeness  ==================
                    heightSpacer(mHeight: 20),
                    Text(
                      "Completeness, Accuracy, and Timeliness of Information",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.78,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "The information we publish on this website is only to help users find the required product or service readily. Users cannot make us liable in case the information published on this website is inaccurate, non-current, or incomplete. We provide materials on this website only for general information. Users should not completely rely on the published information to make important decisions.  ",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // Hide / Show Content Container
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: isAccuracyVisible ? mq.size.width : 0,
                      child: isAccuracyVisible
                          ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "We recommend users rely on primary, more complete, more accurate, and more timely sources to verify the information. Any decision made by tailormanagement.com’s users is at their own risk. \n\n"
                              "Any historical information provided on this website is only for reference. We can change, edit, or replace that information without informing users. We are not bound by any law to notify users about changes to any historical information published on this website. Users agree that they will timely monitor changes to stay updated with the latest information.  ",
                              style: mTextStyle14(),
                              textAlign: TextAlign.justify,
                            ),
                          )
                          : null,
                    ),

                    heightSpacer(mHeight: 5),
                    ReadMoreAndLessMore_Btn(
                      onPress: () {
                        setState(() {
                          isAccuracyVisible = !isAccuracyVisible;
                        });
                      },
                      mText:!isAccuracyVisible ? "Read More..." : "Read Less...",
                    ),

                    // ================ Start Changes in Services and Price ==================

                    heightSpacer(mHeight: 30),
                    Text(
                      "Changes in Services and Price",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.4,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Tailor Management connects users with skilled professionals in the textile industry. Their service charges are subject to change and there will not be any prior notice. We can change or discontinue any service or product provided on this website without informing users. \n\n"
                      "We are not liable to any third-party user or you to notify regarding service price changes, modifications, suspending any services, or discontinuing specific services offered through this website.",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // ================ Start Third-party Tools ==================

                    heightSpacer(mHeight: 30),
                    Text(
                      "Third-party Tools",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.64,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Users of this website may be able to access certain third-party tools. Tailormanagement.com does not monitor or control any of those tools. Users acknowledge that they access the provided tools “as they are” without any warranties from this website. Users cannot make us liable if any kind of loss (data or others) is caused by those third-party tools. \n\n"
                      "Optional tools (if provided) used by tailormanagement.com users are completely at their own risk. We do not direct users to rely on those tools and we recommend users familiarize themselves with the pros and cons of those optional tools before using them. Users should check the terms and conditions of third-party tool providers before accessing those optional tools. \n\n"
                      "Tailor Management may also add new services and promote them through this website in future. Any new features and services provided through this website will be subject to this Terms and Conditions agreement. ",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // ================ Start Third-party Links ==================

                    heightSpacer(mHeight: 30),
                    Text(
                      "Third-party Links",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.64,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Certain products, services, and content endorsed on this website may feature materials from third parties. Users may find third-party links on certain pages of this website. Those links will direct users to the website of the third-party service provider. That website may not be affiliated with Tailor Management. \n\n"
                      "It is not our responsibility to evaluate or examine the content provided on third-party websites whose links users may find on our website. We do not claim to evaluate the accuracy of the content those third-party websites provide. We are not responsible or liable for any material or product third-party websites provide or claim to provide. Any products, services or materials you use through those third-party websites are at your own risk. \n\n"
                      "If you access any third-party website through third-party links, buy any product or service, and experience any loss or damage, we will not be responsible or liable for that loss or damage. We recommend you carefully examine, assess, and evaluate the product or service before making any financial transactions. Any complaints, concerns, or claims regarding third-party products should be directed to the product/service provider and not toward us.",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // ================ Start User Feedback ==================
                    heightSpacer(mHeight: 30),
                    Text(
                      "User Feedback, Comments, and Other Submissions",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.72,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Any comment or feedback made by the user in the form of creative ideas, proposals, suggestions, plans, or other submissions, via email or other means of communication, he or she agrees that we may copy, edit, distribute, publish, translate, or use that material without any notification. We are under no obligation to pay compensation, maintain users’ comments, or respond to any query/question/comment. \n\n"
                      "Tailor Management may monitor users’ comments, but users cannot hold us liable or responsible for consistently monitoring, removing, or deleting certain or all comments. We have the right to remove any unlawful, libellous, threatening, pornographic, defamatory, or other objectionable comments, but we do not guarantee any specific timeframe to take those actions. \n\n"
                      "Users of this website agree that they will not publish any comments, ideas, or plans violating the rights of other persons or entities. We strictly prohibit users from publishing abusive, harmful, and threatening content on our website. ",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),


                    // ================ Start Personal Information ==================

                    heightSpacer(mHeight: 30),
                    Text(
                      "Personal Information",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.58,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Our Privacy Policy governs the submission of user’s personal information.",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // ================ Start Inaccuracies ==================
                    heightSpacer(mHeight: 30),
                    Text(
                      "Inaccuracies, Errors, and Omissions ",
                      style: mTextStyle15(mFontWeight: FontWeight.w700),
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: mq.size.width * 0.31,
                      color: AppColor.btnBgColorGreen,
                    ),

                    heightSpacer(mHeight: 5),
                    Text(
                      "Some information published on our website may contain inaccurate data, typographical errors, or other types of errors in product descriptions, pricing, and promotions. Tailormanagement.com has the right to rectify those errors, correct inaccurate data, or improve typographical errors. We can change or update product or service information at any given time. We have the right to cancel the order if there are typographical or price-related errors in the product or service description.   ",
                      style: mTextStyle14(),
                      textAlign: TextAlign.justify,
                    ),

                    // ================ End Personal Information ==================

                    heightSpacer(mHeight: 70),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Rounded_Btn_Widget(
          mfontSize: 15,
          btnBgColor: AppColor.btnBgColorGreen,
          mAlignment: Alignment.center,
          borderRadius: 5,
          onPress: () {
            Navigator.pop(context);
          },
          title: "Okay ",
        ),
      ),
    );
  }
}
