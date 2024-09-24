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
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/modal/ApplyJobModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_Helper.dart';

class Filter_Page_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  final String? work_Shift;
  final String? work_Type;

  const Filter_Page_Screen({super.key, required this.firebaseUser, required this.userModel, this.work_Shift, this.work_Type});

  @override
  State<Filter_Page_Screen> createState() => _Filter_Page_Screen();
}

class _Filter_Page_Screen extends State<Filter_Page_Screen> {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var JobID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 2,
        title: RichText(
          text: TextSpan(
            text: "Filtered by ",
            style: mTextStyle20(),
            children: [
              TextSpan(
                  text: widget.work_Type == null ? "${widget.work_Shift}" : "${widget.work_Type}",
                  style: mTextStyle20(mColor: AppColor.textColorBlue)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                    widget.work_Type == null
                        ? "Jobs are shown according to ${widget.work_Shift}"
                        : "Jobs are shown according to ${widget.work_Type}",
                    style: mTextStyle15(mFontWeight: FontWeight.w700)),
              ),
              Container(
                child: BlocBuilder<JobPostCubit, JobPostState>(
                  builder: (context, state) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: widget.work_Type == null
                          ? _fireStore.collection("jobs").where('work_shift', isEqualTo: "${widget.work_Shift}").snapshots()
                          : _fireStore.collection("jobs").where("work_type", isEqualTo: "${widget.work_Type}").snapshots(),
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
                            itemCount: getJobPostList.length > 5 ? 5 : getJobPostList.length,
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
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
                                    applyPress: () {
                                      JobApplyFunction();
                                    },
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
}
