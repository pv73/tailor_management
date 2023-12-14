import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor/app_widget/jab_department_widget.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/ui_Helper.dart';

class Jobs_Screen extends StatefulWidget {
  @override
  State<Jobs_Screen> createState() => _Jobs_Screen();
}

class _Jobs_Screen extends State<Jobs_Screen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> bannerStream;
  final sliderImage = [];
  int activeIndex = 0;
  bool isDepartment_hide = false;
  late MediaQueryData mq;

  @override
  void initState() {
    super.initState();
    bannerStream = FirebaseProvider().getBanner();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(text: "Tailor ", style: mTextStyle20(), children: [
            TextSpan(
                text: "Jobs",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
        ),
        backgroundColor: AppColor.textColorWhite,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 11,
              backgroundColor: AppColor.textColorBlack,
              child: Icon(
                Icons.question_mark,
                size: 17,
                color: AppColor.textColorWhite,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              size: 23,
              color: AppColor.textColorBlack,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 23,
              color: AppColor.textColorBlack,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: bannerStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.hasError}");
                    } else if (snapshot.hasData) {
                      sliderImage.clear();
                      for (DocumentSnapshot doc in snapshot.data!.docs) {
                        sliderImage.add(doc.get('img'));
                      }
                      return Container(
                        height: 90,
                        child: CarouselSlider.builder(
                          itemCount: sliderImage.length,
                          itemBuilder: (context, index, realIndex) {
                            //// Widget Return
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColor.textColorLightBlack),
                                  image: DecorationImage(
                                      image: NetworkImage(sliderImage[index]),
                                      fit: BoxFit.cover)),
                            );
                          },
                          options: CarouselOptions(
                              height: 160,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              autoPlayInterval: Duration(seconds: 2),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                          color: AppColor.bgColorBlue),
                    );
                  },
                ),

                //// Slider Indicator ///
                heightSpacer(mHeight: 8),
                buildIndicator(),

                /// dream job
                heightSpacer(mHeight: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Get the ",
                          style: mTextStyle20(
                              mFontWeight: FontWeight.w600,
                              mColor: AppColor.textColorBlack),
                          children: [
                            TextSpan(
                              text: "job ",
                              style: mTextStyle20(
                                  mFontWeight: FontWeight.w800,
                                  mColor: AppColor.btnBgColorGreen),
                            ),
                            TextSpan(
                              text: "that your",
                            ),
                            TextSpan(
                              text: " dream...",
                              style: mTextStyle20(
                                  mFontWeight: FontWeight.w800,
                                  mColor: AppColor.btnBgColorGreen),
                            ),
                          ],
                        ),
                      ),
                      heightSpacer(mHeight: 5),
                      RichText(
                        text: TextSpan(
                          text:
                              "Find your dream job just in one click by using our ",
                          style: mTextStyle14(
                              mFontWeight: FontWeight.w500,
                              mColor: AppColor.textColorBlack),
                          children: [
                            TextSpan(
                              text: "Tailor Management app ",
                              style: mTextStyle14(
                                  mFontWeight: FontWeight.w500,
                                  mColor: AppColor.btnBgColorGreen),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// search job
                Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, job) {
                      return Card_Container_Widget(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/logo/logo.png"),
                              ),
                              title: Text(
                                "Single Needle Operator",
                                style:
                                    mTextStyle17(mFontWeight: FontWeight.w500),
                              ),
                              subtitle: Text("Tailor Management Pvt. Ltd."),
                              trailing: Icon(Icons.chevron_right),
                            ),

                            // type of job
                            Container(
                              height: 20.h,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, job_Child) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "Full Piece",
                                      style: mTextStyle12(),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                            ),
                            heightSpacer(mHeight: 5),

                            // Job Details
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.wallet,
                                            size: 15.h,
                                            color: Colors.grey.shade600),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "INR. 10-15K",
                                            style: mTextStyle12(
                                                mFontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Icon(Icons.location_city,
                                              size: 15.h,
                                              color: Colors.grey.shade600),
                                        ),
                                        // widthSpacer(mWidth: 4),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Gurugram",
                                            style: mTextStyle12(
                                                mFontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Icon(Icons.group_add_outlined,
                                              size: 15.h,
                                              color: Colors.grey.shade600),
                                        ),
                                        widthSpacer(mWidth: 4),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "200 Emp.",
                                            style: mTextStyle12(
                                                mFontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// Explore job by department
                if (isDepartment_hide == false)
                  Container(
                    width: double.infinity,
                    color: Colors.blue.shade50,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Explore jobs by ",
                                style: mTextStyle15(
                                    mFontWeight: FontWeight.w500,
                                    mColor: AppColor.textColorBlack),
                                children: [
                                  TextSpan(
                                    text: "department",
                                    style: mTextStyle16(
                                        mFontWeight: FontWeight.w500,
                                        mColor: AppColor.btnBgColorGreen),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                isDepartment_hide = true;
                                setState(() {});
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),

                        //
                        heightSpacer(mHeight: 25),
                        Container(
                          height: mq.size.height > 807
                              ? mq.size.height * 0.12.h
                              : mq.size.height * 0.17,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              Job_Department_widget(
                                title: "Single Needle\n Operator",
                                onPress: () {},
                                image: "assets/images/logo/single_operator.png",
                              ),

                              //
                              widthSpacer(mWidth: 25),
                              Job_Department_widget(
                                title: "OverLock\n Operator",
                                onPress: () {},
                                image:
                                    "assets/images/logo/overlock_operator.png",
                              ),

                              //
                              widthSpacer(mWidth: 25),
                              Job_Department_widget(
                                title: "Flat Lock\n Operator",
                                onPress: () {},
                                image:
                                    "assets/images/logo/cutting_operator.png",
                              ),

                              //
                              widthSpacer(mWidth: 20),
                              Job_Department_widget(
                                title: "Consie Machine\n Operator",
                                onPress: () {},
                                image: "assets/images/logo/consie_operator.png",
                              ),

                              //
                              widthSpacer(mWidth: 20),
                              Job_Department_widget(
                                title: "Bartack Machine\n Operator",
                                onPress: () {},
                                image: "assets/images/logo/single_operator.png",
                              ),

                              //
                              widthSpacer(mWidth: 20),
                              Job_Department_widget(
                                title: "Cutting Machine\n Operator",
                                onPress: () {},
                                image: "assets/images/logo/consie_operator.png",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                /// search job
                Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, job) {
                      return Card_Container_Widget(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/logo/logo.png"),
                              ),
                              title: Text(
                                "Single Needle Operator",
                                style:
                                    mTextStyle17(mFontWeight: FontWeight.w500),
                              ),
                              subtitle: Text("Tailor Management Pvt. Ltd."),
                              trailing: Icon(Icons.chevron_right),
                            ),

                            // type of job
                            Container(
                              height: 20.h,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (context, job_Child) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "Full Piece",
                                      style: mTextStyle12(),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                            ),
                            heightSpacer(mHeight: 5),

                            // Job Details
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.wallet,
                                            size: 15.h,
                                            color: Colors.grey.shade600),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "INR. 10-15K",
                                            style: mTextStyle12(
                                                mFontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Icon(Icons.location_city,
                                              size: 15.h,
                                              color: Colors.grey.shade600),
                                        ),
                                        // widthSpacer(mWidth: 4),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Gurugram",
                                            style: mTextStyle12(
                                                mFontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Icon(Icons.group_add_outlined,
                                              size: 15.h,
                                              color: Colors.grey.shade600),
                                        ),
                                        widthSpacer(mWidth: 4),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "200 Emp.",
                                            style: mTextStyle12(
                                                mFontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// slider Indicator //
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      // count: sliderImage.length,
      count: 5,
      activeIndex: activeIndex,
      effect: WormEffect(
          spacing: 4.0,
          radius: 8.0,
          dotWidth: 8.0,
          dotHeight: 5.0,
          paintStyle: PaintingStyle.stroke,
          activeDotColor: Colors.indigo),
    );
  }
}
