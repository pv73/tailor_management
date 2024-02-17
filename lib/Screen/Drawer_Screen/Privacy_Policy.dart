import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Privacy_Policy extends StatefulWidget {
  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  late MediaQueryData mq;

  bool isInformation = false;
  bool isCookies = false;
  bool isEngaging = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SafeArea(
        child: Column(
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
                    image: DecorationImage(image: AssetImage("assets/images/banner/about_banner.jpg"), fit: BoxFit.fitWidth),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy Policy- TailorManagement.com",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.25,
                        color: AppColor.btnBgColorGreen,
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "The described Privacy Policy explains how the information provided by the user or collected from the user is processed by Tailor Management. It is our topmost priority to maintain the privacy and trust of our users. We are using the best tech and tools to protect users’ data and prevent unauthorized access to information shared by our users. ",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      // ========== Information Collected ========
                      heightSpacer(mHeight: 30),
                      Text(
                        "The Type of Information Collected, Received, and Stored by Tailormanagement.com",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.29,
                        color: AppColor.btnBgColorGreen,
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "Tailormanagement.com can collect some specific types of details or all the information users share while using this platform and our services. The information users share can vary depending on the services they are trying to access. \n\n"
                        "The commonly collected information about the user includes the data he/she provides, information tracked when the user is navigating our website, and information collected through other sources.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      // =========== Storing and using users’ information =================
                      Privacy_Policy_Helper(
                        width: isInformation ? mq.size.width : 0,
                        btn_Name: !isInformation ? "Read More..." : "Read Less...",
                        isVisible: isInformation,
                        heading: "Storing and using users’ information",
                        text:
                            "Tailor Management users do not need to share their data to access services we provide through our website. They need to share certain information when using this platform to find professionals related to the solutions our service associates provide. That information includes the user’s name, email ID, phone number, and preferences. It might be necessary for users to share essential information in case they own a brand or business to promote their products on this platform.",
                        hideText:
                            "We store users’ personal data only when they voluntarily provide details. For example, users will have to provide certain details when using this website to access tailors, stitchers, and other service associates. We use state-of-the-art data storage solutions to protect users’ data against entities, which may try to exploit such information. We are committed to protecting users’ personal information and we have invested in top-notch security solutions to meet our commitment. ",
                        onPress: () {
                          setState(() {
                            isInformation = !isInformation;
                          });
                        },
                      ),

                      // =========== Cookies =================
                      Privacy_Policy_Helper(
                        width: isCookies ? mq.size.width : 0,
                        btn_Name: !isCookies ? "Read More..." : "Read Less...",
                        isVisible: isCookies,
                        heading: "Cookies",
                        text:
                            "Tailormanagement.com relies on cookies to gather essential details. We may also collect important details of non-registered users with the purpose of providing better services.\n\n"
                            "This website is based on a cutting-edge web infrastructure, which helps us in providing services demanded by clients along with relevant links, images, videos, text, and other crucial elements.",
                        hideText:
                            "Our website’s server logs are designed by top-skilled professionals, which we use to collect information, such as users’ IP addresses, language preferences, browser type, and the time of visit. This information plays an essential role in improving our services for regular users. \n\n"
                            "We may allocate one or multiple cookies to collect information for delivering uninterrupted services efficiently. We may also use certain cookies to offer a more personalized information in the form of the latest products offered on this website. \n\n"
                            "We may publish products, their images, prices, and links with associated services to inform users about those products and services. ",
                        onPress: () {
                          setState(() {
                            isCookies = !isCookies;
                          });
                        },
                      ),

                      //======== Engaging with Third Parties ================
                      Privacy_Policy_Helper(
                        btn_Name: !isEngaging ? "Read More..." : "Read Less...",
                        isVisible: isEngaging,
                        heading: "Engaging with Third Parties",
                        text:
                            "Users need to engage with third-party platforms, which they may find on our website, responsibly to reveal more details about products and services. Tailormanagement.com does not manage the information third-party websites promote to attract buyers and users. It is completely up to the user whether he or she wishes to buy promoted products or not. Users cannot hold us responsible or make us liable for damages or losses caused by third-party websites or products they provide. ",
                        hideText:
                            "We do not share data provided by users. This platform displays ads provided by third-party ad networks. Those ad networks can access and use cookies to learn about users’ devices and preferences for displaying more relevant ads. \n\n"
                            "It is not in our control who reads users’ comments and posts. TailorManagement.com cannot control or manage how other users read the information you share or how they use it. Users are strictly prohibited from revealing and sharing sensitive information. It will help us in protecting your interest and privacy. ",
                        onPress: () {
                          setState(() {
                            isEngaging = !isEngaging;
                          });
                        },
                      ),

                      // ========== Information Collected ========
                      heightSpacer(mHeight: 30),
                      Text(
                        "Users Rights",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.79,
                        color: AppColor.btnBgColorGreen,
                      ),

                      heightSpacer(mHeight: 5),
                      Text(
                        "Users have the following rights:",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //=========== The right to access ===================
                      heightSpacer(mHeight: 15),
                      Text(
                        "•	The right to access",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(mHeight: 5),
                      Text(
                        "TailorManagement.com users have the right to request information regarding the personal data they have shared. They can request to access the stored information at any time. Users need to contact us in order to access the data stored about them",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //===========•	Data portability ===================
                      heightSpacer(mHeight: 15),
                      Text(
                        "•	Data portability",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(mHeight: 5),
                      Text(
                        "Users’ information processed by our website in consent with the user can be requested by the user. You have the right to copy the data in fully organized form and you can request it to transfer to another party. It applies only to the personal data shared by the user.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //===========•	Right to correct the information ===================
                      heightSpacer(mHeight: 15),
                      Text(
                        "•	Right to correct the information",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(mHeight: 5),
                      Text(
                        "The user has the right to request corrections if any entry made by him/her is inaccurate. Users can rectify the error, correct the entry, and then provide the information for storage.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //===========•	Right to delete the information ===================
                      heightSpacer(mHeight: 15),
                      Text(
                        "•	Right to delete the information",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(mHeight: 5),
                      Text(
                        "The user has the right to request to delete the information at any given time. We may not be able to process the user’s request in the following scenarios:",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            heightSpacer(),
                            Text("•	When the user has an ongoing communication with the customer service ",
                                style: mTextStyle14(), textAlign: TextAlign.justify),
                            heightSpacer(),
                            Text("•	When the user has an active order, which is not fully delivered by our service associates",
                                style: mTextStyle14(), textAlign: TextAlign.justify),
                            heightSpacer(),
                            Text(
                                "•	It won’t be possible to process the request to delete the user’s data if the user has an unpaid debt.",
                                style: mTextStyle14(),
                                textAlign: TextAlign.justify),
                            heightSpacer(),
                            Text("•	When the user has misbehaved or abused our services.",
                                style: mTextStyle14(), textAlign: TextAlign.justify),
                          ],
                        ),
                      ),

                      heightSpacer(),
                      Text(
                          "It is our legal obligation to store the user’s personal data when he/she has placed the order and that information be used to store transaction details. \n\n"
                          "If you have any queries or questions regarding the processing or storage of your personal information, you can contact us through this website.",
                          style: mTextStyle14(),
                          textAlign: TextAlign.justify),

                      heightSpacer(mHeight: 25),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
