import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/View_Jobs_Details.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/jab_department_widget.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
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
        leadingWidth: 25,
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
      drawer: Drawer_Widget(),
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
                  child: BlocBuilder<JobPostCubit, JobPostState>(
                    builder: (context, state) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: BlocProvider.of<JobPostCubit>(context)
                            .getDataFilterByOrder(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // first get jobPosts List from JobPostCubit file the store getJobPostList variable
                            var getJobPostList =
                                BlocProvider.of<JobPostCubit>(context).jobPosts;

                            getJobPostList.clear();

                            // var jobPosts = snapshot.data!.docs;
                            for (DocumentSnapshot doc in snapshot.data!.docs) {
                              Map<String, dynamic> data =
                                  doc.data() as Map<String, dynamic>;

                              // Add all Data in jobPosts list
                              getJobPostList.add(data);
                            }

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: getJobPostList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var jobPost = getJobPostList[index];

                                // Assuming 'timestampField' is the field storing Timestamp in FireStore
                                Timestamp timestamp = jobPost['dateTime'];
                                // Convert Timestamp to DateTime
                                DateTime dateTime = timestamp.toDate();

                                return Column(
                                  children: [
                                    Card_Container_Widget(
                                      mColor: Colors.white,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Post Date
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            color: Colors.green.shade50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Posted Date: ",
                                                  style: mTextStyle13(
                                                    mFontWeight:
                                                        FontWeight.w600,
                                                    mColor: AppColor
                                                        .btnBgColorGreen,
                                                  ),
                                                ),
                                                Text(
                                                  "${DateFormat("d MMM yy").format(dateTime)} ",
                                                  style: mTextStyle13(
                                                    mFontWeight:
                                                        FontWeight.w600,
                                                    mColor: AppColor
                                                        .btnBgColorGreen,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          // Image & JobType & company_name
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        View_Jobs_Details(
                                                            jobIndex: index)),
                                              );
                                            },
                                            child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "${jobPost['company_logo']}"),
                                              ),
                                              title: Text(
                                                "${jobPost['job_type']}",
                                                style: mTextStyle16(
                                                    mFontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                "${jobPost['company_name']}",
                                                style: mTextStyle12(),
                                              ),
                                            ),
                                          ),

                                          // type of job
                                          Container(
                                            height: 20,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                                  (jobPost['tailor_skill']
                                                                  as List)
                                                              .length >
                                                          3
                                                      ? 3
                                                      : (jobPost['tailor_skill']
                                                              as List)
                                                          .length,
                                              itemBuilder:
                                                  (context, skill_Child) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Text(
                                                    "${jobPost['tailor_skill'][skill_Child]}",
                                                    style: mTextStyle12(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),

                                          // Total Employee, work Shift and work type
                                          heightSpacer(mHeight: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: Text(
                                                      "Shift: ${jobPost['worked_shift']}",
                                                      style: mTextStyle13(
                                                        mFontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                widthSpacer(mWidth: 5),
                                                Expanded(
                                                  child: Container(
                                                    child: Text(
                                                      "Type: ${jobPost['worked_type']}",
                                                      style: mTextStyle13(
                                                        mFontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          // Job Details
                                          heightSpacer(mHeight: 2),
                                          Container(
                                            padding: EdgeInsets.all(7),
                                            color: Colors.grey.shade100,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.wallet,
                                                        size: 15,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                      widthSpacer(mWidth: 2),
                                                      Expanded(
                                                        child: CalculateSalary(
                                                            jobPost),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.location_city,
                                                          size: 15,
                                                          color: Colors
                                                              .grey.shade600),
                                                      widthSpacer(mWidth: 4),
                                                      Expanded(
                                                        child: Text(
                                                          "${jobPost['state']}",
                                                          style: mTextStyle12(
                                                            mFontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .group_add_outlined,
                                                          size: 15,
                                                          color: Colors
                                                              .grey.shade600),
                                                      widthSpacer(mWidth: 4),
                                                      Expanded(
                                                        child: Text(
                                                          " ${jobPost['total_employee']} Emp.",
                                                          style: mTextStyle12(
                                                            mFontWeight:
                                                                FontWeight.w500,
                                                          ),
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
                                    ),

                                    // Explore jobs by department
                                    if (isDepartment_hide == false && index == 1)
                                      Container(
                                        width: double.infinity,
                                        color: Colors.blue.shade50,
                                        padding: EdgeInsets.all(12),
                                        margin: EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: "Explore jobs by ",
                                                    style: mTextStyle15(
                                                        mFontWeight:
                                                            FontWeight.w500,
                                                        mColor: AppColor
                                                            .textColorBlack),
                                                    children: [
                                                      TextSpan(
                                                        text: "department",
                                                        style: mTextStyle16(
                                                            mFontWeight:
                                                                FontWeight.w500,
                                                            mColor: AppColor
                                                                .btnBgColorGreen),
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
                                                  ? mq.size.height * 0.12
                                                  : mq.size.height * 0.17,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                children: [
                                                  Job_Department_widget(
                                                    title:
                                                        "Single Needle\n Operator",
                                                    onPress: () {},
                                                    image:
                                                        "assets/images/logo/single_operator.png",
                                                  ),

                                                  //
                                                  widthSpacer(mWidth: 25),
                                                  Job_Department_widget(
                                                    title:
                                                        "OverLock\n Operator",
                                                    onPress: () {},
                                                    image:
                                                        "assets/images/logo/overlock_operator.png",
                                                  ),

                                                  //
                                                  widthSpacer(mWidth: 25),
                                                  Job_Department_widget(
                                                    title:
                                                        "Flat Lock\n Operator",
                                                    onPress: () {},
                                                    image:
                                                        "assets/images/logo/cutting_operator.png",
                                                  ),

                                                  //
                                                  widthSpacer(mWidth: 20),
                                                  Job_Department_widget(
                                                    title:
                                                        "Consie Machine\n Operator",
                                                    onPress: () {},
                                                    image:
                                                        "assets/images/logo/consie_operator.png",
                                                  ),

                                                  //
                                                  widthSpacer(mWidth: 20),
                                                  Job_Department_widget(
                                                    title:
                                                        "Bartack Machine\n Operator",
                                                    onPress: () {},
                                                    image:
                                                        "assets/images/logo/single_operator.png",
                                                  ),

                                                  //
                                                  widthSpacer(mWidth: 20),
                                                  Job_Department_widget(
                                                    title:
                                                        "Cutting Machine\n Operator",
                                                    onPress: () {},
                                                    image:
                                                        "assets/images/logo/consie_operator.png",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      Container(),
                                  ],
                                );
                              },
                            );
                          }
                          return Center(
                            child: Lottie.asset(
                                "assets/images/lottie_animation/loading_animation.json",
                                width: 130),
                          );
                        },
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

  // ===============================================
  // Convert Salary in K
  CalculateSalary(jobPost) {
    // Minimun Salary
    var totalMini_salary = int.parse(jobPost['minimun_Salary']);
    var mini_Salary = totalMini_salary / 1000;

    // If there are no decimal places, display without any decimal places
    // If there are decimal places, display with one decimal place
    var formattedMiniSalary = (mini_Salary % 1 == 0)
        ? mini_Salary.toStringAsFixed(0)
        : mini_Salary.toStringAsFixed(1);

    // Maximum Salary
    var totalMax_salary = int.parse(jobPost['maxmimum_Salary']);
    var maximum_Salary = totalMax_salary / 1000;

    var formattedMaxSalary = (maximum_Salary % 1 == 0)
        ? maximum_Salary.toStringAsFixed(0)
        : maximum_Salary.toStringAsFixed(1);

    return Container(
      child: Text(
        " INR ${formattedMiniSalary}-${formattedMaxSalary}K",
        style: mTextStyle12(mFontWeight: FontWeight.w600),
      ),
    );
  }
}
