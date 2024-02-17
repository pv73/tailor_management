import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Disclaimer extends StatefulWidget {
  const Disclaimer({super.key});

  @override
  State<Disclaimer> createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SafeArea(
        child: Column(
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
                      "Disclaimer",
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
                        "Tailor Management Disclaimer",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.45,
                        color: AppColor.btnBgColorGreen,
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "This disclaimer agreement states the terms and conditions, which apply to users who access this website (https://tailormanagement.com).  ",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //========== General ==========
                      heightSpacer(mHeight: 30),
                      Text(
                        "General",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(),
                      Text(
                        "This website is owned by Tailor Management and endorses services provided by the company. Content published on this website is protected by trademark and copyright laws. Users are restricted from copying, modifying, reproducing, uploading, and republishing content published on this website. \n\n"
                        "By using this Tailor Management website, users agree to follow the guidelines, terms, and conditions stated here. This website does not represent, guarantee, or warrant that your use of tailormanagement.com will be timely, uninterrupted, or error-free. \n\n"
                        "Users should know that we do not guarantee or warrant that the results of accessing and using services featured on this website will be reliable or accurate. You should carefully assess services before taking advantage of offered services and solutions and investing money. \n\n"
                        "Users agree that we may remove or replace services from time to time without informing them. We may remove certain services for indefinite time or we may completely stop providing specific services without any notice. \n\n"
                        "Users consent that their ability or inability to use this website is at their own risk. Services and solutions provided through this website are delivered as they are available at the time of delivery. We may promote certain services without any warranties, representations, or conditions. ",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //========== Limitation of Liability ==========
                      heightSpacer(mHeight: 30),
                      Text(
                        "Limitation of Liability",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(),
                      Text(
                        "We are not liable if users experience any harm due to using this website, its content, or links associated with this website. We do not have liability for consequential, direct, indirect, business, and other losses. Users experiencing loss of income, revenue, or profits cannot make us liable if they experience them due to using services found on this website. Users agree that they will be liable for losses of described types if they make decisions that hurt their interests. ",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //========== Copyright ==========
                      heightSpacer(mHeight: 30),
                      Text(
                        "Copyright",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(),
                      Text(
                        "Content, pictures, material, and illustrations featured on this Tailor Management website cannot be used for commercial purposes. Users cannot download, copy, or print content published on this website for commercial use. They can access the content of this website for personal use and they agree to comply with copyright laws. \n\n"
                        "We strictly prohibit users from copying, downloading, and uploading content from this website for redistribution. Tailor Management can take legal or other necessary actions if users are found copying and using information, material, pictures, and other copyright content made available on this website.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //========== Updates and New Entries ==========
                      heightSpacer(mHeight: 30),
                      Text(
                        "Updates and New Entries",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(),
                      Text(
                        "Tailor Management has the right to make new updates, entries, and adaptions to this website’s disclaimer agreement without informing users. We can make changes to the website disclaimer at any given time and will not notify regular or occasional users. It is the users’ responsibility to timely check changes made to this agreement to be aware of new changes and updates.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      //========== Updates and New Entries ==========
                      heightSpacer(mHeight: 30),
                      Text(
                        "Acceptance",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),

                      heightSpacer(),
                      Text(
                        "We recommend all https://tailormanagement.com/ users read this disclaimer before they use our website. By accessing and using our website, users agree that they accept all the terms and conditions described on this page. Users, who visit and use this website, agree to conditions and limitations of liability described in this agreement. \n\n"
                        "If any user does not accept or agree with the terms and conditions described in this disclaimer agreement, he/she should not visit or use our website.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),


                      heightSpacer(mHeight: 30)
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
