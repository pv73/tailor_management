import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class About_Us extends StatefulWidget {
  @override
  State<About_Us> createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  late MediaQueryData mq;

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
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/banner/about_banner.jpg"),
                        fit: BoxFit.fitWidth),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "About Us",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Colors.white),
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

            // ========== Tailor Management App- About us ========
            heightSpacer(mHeight: 7),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tailor Management App- About us",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.45,
                        color: AppColor.btnBgColorGreen,
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "Founded in 2020, Tailor Management is on a mission to empower India’s skilled tailors and stitchers. Demands for made-in-India products are growing with every passing day. Buyers are seeking high-quality outfits prepared by talented professionals in the country. Most skilled individuals do not get recognition for their skilful work and Tailor Management aims to provide them a platform. \n\n"
                        "Users can discover many tailor profiles on this website. Startups and established businesses can get in touch with numerous tailors offering top-class solutions at fair prices. It is a one-stop destination where you will find tailors for preparing all sorts of clothes on demand.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),


                      // ========== What Do We Do? ========
                      heightSpacer(mHeight: 40),
                      Text("What Do We Do?",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.75,
                        color: AppColor.btnBgColorGreen,
                      ),

                      heightSpacer(mHeight: 5),
                      Text(
                        "It can be daunting for new clothing brands, startups, and businesses to find a skilled workforce from the textile industry. A new business demands skilled labors as it grows and starts entertaining customers from new regions. Thousands of well-trained tailors work in different parts of India. Many of them do not have a common platform to find bulk work. \n\n"
                        "Tailor Management has become a dedicated platform for businesses, where we consistently list new tailoring professionals. We are working to meet the tailor requirements of clients through our tailor management solutions.",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),


                      heightSpacer(mHeight: 25),
                      Container(
                        width: mq.size.width,
                        child: Text("Tailor Management provides \ntalented tailors for:", style: mTextStyle15(mFontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                        ),
                      ),

                      heightSpacer(mHeight: 20),
                      aboutCard_Helper(
                        image: AssetImage("assets/images/banner/bulk_order.jpg"),
                        heading: "Bulk orders",
                        text: "This platform is a one-stop destination for finding tailors for garment stitching. Clothing retailers and businesses can find skilled professionals, who can prepare garments from scratch. Perfectly tailored products will be delivered to your destination.",
                      ),

                      heightSpacer(mHeight: 20),
                      aboutCard_Helper(
                        image: AssetImage("assets/images/banner/stitching.jpg"),
                        heading: "Top-notch stitching for men & \nwomen’s garments",
                        text: "If your business requires flawlessly stitched garments for men and women, Tailor Management should be your first destination for booking skilled tailors. Here you will find reliable tailors for placing bulk orders for various types of tailored outfits for women. ",
                      ),

                      heightSpacer(mHeight: 20),
                      aboutCard_Helper(
                        image: AssetImage("assets/images/banner/garments.jpg"),
                        heading: "Preparing tailored garments for kids",
                        text: "Millions of Indian parents seek top-quality clothes prepared in India for their kids. Brands, producing high-quality kids’ garments, should use tailormanagement.com to find skilled tailors for preparing kids’ garments in large quantities.",
                      ),


                      // =================================================
                      // ========== Our Vision ========
                      heightSpacer(mHeight: 40),
                       Text("Our Vision",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.80,
                        color: AppColor.btnBgColorGreen,
                      ),

                       heightSpacer(mHeight: 5),
                      Text(
                        "Whether you are targeting young Indian customers, adults, or a specific section of buyers, tailormanagement.com can help you find tailors who can produce top-notch clothes for target customers. We have been helping businesses connect with the right people since 2020. \n\n"
                        "Skilled tailors which you find through Tailor Management have proven their skills time and again. Your business will also grow exponentially when it receives orders of skillfully stitched clothes on time. ",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),


                      // ========== Download the Tailor Management App  ========
                      heightSpacer(mHeight: 40),
                       Text("Download the Tailor Management App to Find Tailors for Your Business on the Go",
                        style: mTextStyle15(mFontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        endIndent: mq.size.width * 0.40,
                        color: AppColor.btnBgColorGreen,
                      ),

                       heightSpacer(mHeight: 5),
                      Text(
                        "This Tailor Management app is built to work smoothly on all modern devices. Our team consistently updates tailor profiles to ensure new businesses, startups, retailers, and wholesalers can find top professionals for stitching garments. \n\n"
                        "We have designed this app to make your search simpler. Take advantage of this platform to meet your business’s growing demands for tailors and stitchers. Here you can connect with highly professional individuals, who have been stitching outfits for kids, men, women, and other users for many years. Get this app on your device and join our platform now to take advantage of the new services we add. ",
                        style: mTextStyle14(),
                        textAlign: TextAlign.justify,
                      ),

                      heightSpacer(mHeight: 30),
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
