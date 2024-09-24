import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/View_Jobs_Details.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/View_Job_List_Widget.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/jobs_screen.dart';
import 'package:tailor/app_widget/Attendence_HomePage_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/OurProfile_HomePage_Widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/modal/ApplyJobModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home_Page extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Home_Page({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  //
  String selectedOption = 'Our Profile'; // Default selected option
  late MediaQueryData mq;
  var JobID;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        titleSpacing: 0,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            text: TextSpan(
                text: "Tailor ",
                style: mTextStyle20(),
                children: [TextSpan(text: "Management", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColor.textColorBlack,
              child: Icon(
                Icons.question_mark,
                size: 17,
                color: AppColor.bgColorWhite,
              ),
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
        isCurUserCom: false,
        userModel: widget.userModel,
        firebaseUser: widget.firebaseUser,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // first top 2 Section in this Container
              // with 10px padding
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    // Dropdown menu for OurProfile and Attendence Activity
                    DropdownButton<String>(
                      elevation: 0,
                      underline: Container(),
                      value: selectedOption,
                      style: mTextStyle16(mFontWeight: FontWeight.w700),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                      items: <String>['Our Profile', 'Attendance Activity'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    selectedOption == 'Our Profile'
                        ? OurProfile_HomePage_Widget(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                          )
                        : Attendence_HomePage_Widget(),
                  ],
                ),
              ),

              /// search job
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Latest Jobs",
                  style: mTextStyle16(mFontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
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
                            itemCount: getJobPostList.length > 10 ? 10 : getJobPostList.length,
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
                                    // isApplied: getJobPostList[index]['isApplied'],
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

                                  // ======= If index is 2 then Show this Business image ===========
                                  if (index == 1)
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      child: Image.asset("assets/images/banner/img_business.jpg"),
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

              // ================ See more button ===========
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Jobs_Screen(
                        firebaseUser: widget.firebaseUser,
                        userModel: widget.userModel,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 30),
                  padding: EdgeInsets.all(7),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    "See more..",
                    style: mTextStyle14(mFontWeight: FontWeight.w600, mColor: Colors.green),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  //          Skills build
  Widget buildSkills(List<dynamic> skills) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      children: List.generate(
        skills.length > 1 ? 1 : skills.length,
        (index) {
          return Container(
            padding: EdgeInsets.only(right: 4),
            child: Text(
              "${skills[index]},",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: mTextStyle12(
                mFontWeight: FontWeight.w500,
              ),
            ),
          );
        },
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

  //================================================================
// ================= UI design end  ===========================

  /// this code get name word's first letter like Mukesh Kumar then get MK
  String getInitials(String name) {
    List<String> nameParts = name.split(" "); // Split the name into parts
    String initials = "";

    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0]; // Get the first letter of each non-empty part
      }
    }

    return initials;
  }
}

// ===== openGoogleMaps ==============
Future<void> openGoogleMaps(String address) async {
  String query = Uri.encodeComponent(address);
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$query';

  await canLaunchUrlString(googleUrl) ? await launchUrlString(googleUrl) : throw 'Could not Lunch';
}
