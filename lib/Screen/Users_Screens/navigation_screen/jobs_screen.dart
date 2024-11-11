import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor/Filter_Pages/Filter_Page_Screen.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/View_Jobs_Details.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/View_Job_List_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/FilterBoxContainer.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/modal/ApplyJobModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

class Jobs_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Jobs_Screen({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Jobs_Screen> createState() => _Jobs_Screen();
}

class _Jobs_Screen extends State<Jobs_Screen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> bannerStream;
  final sliderImage = [];
  int activeIndex = 0;
  bool isDepartment_hide = false;
  late MediaQueryData mq;
  var JobID;
  bool _isShowFilterSection = false;

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
          text: TextSpan(
              text: "Tailor ",
              style: mTextStyle20(),
              children: [TextSpan(text: "Jobs", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
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
      drawer: Drawer_Widget(
        firebaseUser: widget.firebaseUser,
        userModel: widget.userModel,
        isCurUserCom: false,
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
                                  border: Border.all(color: AppColor.textColorLightBlack),
                                  image: DecorationImage(image: NetworkImage(sliderImage[index]), fit: BoxFit.cover)),
                            );
                          },
                          options: CarouselOptions(
                              height: 160,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              autoPlayInterval: Duration(seconds: 2),
                              onPageChanged: (index, reason) {
                                // setState(() {
                                //   activeIndex = index;
                                // });
                              }),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.bgColorBlue),
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
                          style: mTextStyle20(mFontWeight: FontWeight.w600, mColor: AppColor.textColorBlack),
                          children: [
                            TextSpan(
                              text: "job ",
                              style: mTextStyle20(mFontWeight: FontWeight.w800, mColor: AppColor.btnBgColorGreen),
                            ),
                            TextSpan(
                              text: "that your",
                            ),
                            TextSpan(
                              text: " dream...",
                              style: mTextStyle20(mFontWeight: FontWeight.w800, mColor: AppColor.btnBgColorGreen),
                            ),
                          ],
                        ),
                      ),
                      heightSpacer(mHeight: 5),
                      RichText(
                        text: TextSpan(
                          text: "Find your dream job just in one click by using our ",
                          style: mTextStyle14(mFontWeight: FontWeight.w500, mColor: AppColor.textColorBlack),
                          children: [
                            TextSpan(
                              text: "Tailor Management app ",
                              style: mTextStyle14(mFontWeight: FontWeight.w500, mColor: AppColor.btnBgColorGreen),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =============== Show all jobs ===================
                Container(
                  child: BlocBuilder<JobPostCubit, JobPostState>(
                    builder: (context, state) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: BlocProvider.of<JobPostCubit>(context).getDataFilterByOrder(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // first get jobPosts List from JobPostCubit file the store getJobPostList variable
                            var getJobPostList = BlocProvider.of<JobPostCubit>(context).jobPosts;

                            getJobPostList.clear();

                            // var jobPosts = snapshot.data!.docs;
                            for (DocumentSnapshot doc in snapshot.data!.docs) {
                              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

                              // Add all Data in jobPosts list
                              getJobPostList.add(data);
                            }

                            return ListView.builder(
                              itemCount: getJobPostList.length < 5 ? 5 : getJobPostList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var jobPost = getJobPostList[index];
                                JobID = getJobPostList[index]['jobId'];

                                // Assuming 'dateTime' is the field storing DateTime in Firestore
                                DateTime jobDateTime = jobPost['dateTime'].toDate();
                                // Calculate the difference in days
                                int daysDifference = DateTime.now().difference(jobDateTime).inDays;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ============== Job list view Widget ==============
                                    View_Job_List_Widget(
                                      isAdmin: false,
                                      firebaseUser: widget.firebaseUser,
                                      userModel: widget.userModel,
                                      jobId: JobID,
                                      date: "${DateFormat("d MMM yy").format(jobDateTime)} ",
                                      daysAgo: "${daysDifference}",
                                      jobPost: jobPost,
                                      applyPress: () {},
                                      onPress: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            child: View_Jobs_Details(
                                              jobId: getJobPostList[index]['jobId'],
                                              isTailorJobView: true,
                                              userModel: widget.userModel,
                                            ),
                                            type: PageTransitionType.rightToLeftWithFade,
                                            duration: Duration(milliseconds: 500),
                                          ),
                                        );
                                      },
                                    ),

                                    // ======= If index is 2 then Show this Filter sections ===========
                                    if (index == 1)
                                      _isShowFilterSection == true
                                          ? Container()
                                          : Container(
                                              margin: EdgeInsets.symmetric(horizontal: 12),
                                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade50,
                                                  borderRadius: BorderRadius.circular(3),
                                                  border: Border.all(color: Colors.blue)),
                                              child: FilterBoxContainer(
                                                onClose: () {
                                                  setState(() {
                                                    _isShowFilterSection = true;
                                                  });
                                                },
                                                onDayShift: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Filter_Page_Screen(
                                                        userModel: widget.userModel,
                                                        firebaseUser: widget.firebaseUser,
                                                        work_Shift: "Day Shift",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                onNightShift: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Filter_Page_Screen(
                                                        userModel: widget.userModel,
                                                        firebaseUser: widget.firebaseUser,
                                                        work_Shift: "Night Shift",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                onSite: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Filter_Page_Screen(
                                                        userModel: widget.userModel,
                                                        firebaseUser: widget.firebaseUser,
                                                        work_Type: "Onsite",
                                                      ),
                                                    ),
                                                  );
                                                },
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
                            child: Lottie.asset("assets/images/lottie_animation/loading_animation.json", width: 130),
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

  // ========== JobApplyFunction button clicked ===============
  void JobApplyFunction() async {
    try {
      // ========== store value in variable ==========
      String? jobId = JobID;
      String? userId = widget.userModel.uid;

      ApplyJobModel newApplyJob = ApplyJobModel(
        dateTime: DateTime.now(),
        jobId: jobId,
        userId: userId,
        user_name: widget.userModel.user_name,
        emailId: widget.userModel.email,
        isApplied: true,
        garment_category: widget.userModel.garment_category,
        skills: widget.userModel.skills,
        profilePicUrl: widget.userModel.profile_pic,
      );

      await FirebaseFirestore.instance.collection("jobs").doc(jobId).collection("apply_job").doc(userId).set(newApplyJob.toMap());

      log("JobApply Successfully");
    } catch (err) {
      log(err.toString());
    }
  }

  /// slider Indicator //
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      // count: sliderImage.length,
      count: 5,
      activeIndex: activeIndex,
      effect: WormEffect(
          spacing: 4.0, radius: 8.0, dotWidth: 8.0, dotHeight: 5.0, paintStyle: PaintingStyle.stroke, activeDotColor: Colors.indigo),
    );
  }
}
