import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/View_Jobs_Details.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/View_Job_List_Widget.dart';
import 'package:tailor/Screen/Users_Screens/navigation_screen/jobs_screen.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/bottom_sheet_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Applications_Screen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Applications_Screen({super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Applications_Screen> createState() => _Applications_Screen();
}

class _Applications_Screen extends State<Applications_Screen> {
  late Future<List<Map<String, dynamic>>> appliedJobs;

  Future<List<Map<String, dynamic>>> getAppliedJobs() async {
    List<Map<String, dynamic>> jobsData = [];

    // Retrieves documents from "apply_job" subCollection
    QuerySnapshot applyJobQuerySnapshot = await FirebaseFirestore.instance.collectionGroup('apply_job').get();

    for (QueryDocumentSnapshot applyJobDoc in applyJobQuerySnapshot.docs) {
      if (applyJobDoc.get('userId') == widget.userModel.uid) {
        // For each document in apply_job subCollection and  Get the parent document reference
        DocumentReference jobRef = applyJobDoc.reference.parent.parent!;
        DocumentSnapshot jobSnapshot = await jobRef.get(); // Retrieve the parent document data from the jobs collection
        jobsData.add(jobSnapshot.data() as Map<String, dynamic>); // Add the parent document data to the jobsData list
      } else {
        // ====== If UserId not same current logged user then skip ============
        continue;
      }
    }

    return jobsData;
  }

  @override
  void initState() {
    super.initState();
    appliedJobs = getAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.textColorWhite,
        appBar: AppBar(
          leadingWidth: 25,
          title: RichText(
            text: TextSpan(
                text: "Tailor ",
                style: mTextStyle20(),
                children: [TextSpan(text: "Applications", style: mTextStyle20(mColor: AppColor.textColorBlue))]),
          ),
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.settings,
                size: 25,
                color: AppColor.textColorBlack,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 25,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide.none,
                  bottom: BorderSide(width: 2, color: Colors.green.shade100),
                ),
              ),
              child: TabBar(
                labelColor: AppColor.textColorBlack,
                unselectedLabelColor: AppColor.textColorLightBlack,
                indicator: BoxDecoration(
                  border: Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide.none,
                    bottom: BorderSide(width: 3, color: AppColor.cardBtnBgGreen),
                  ),
                ),
                tabs: [
                  Tab(
                    text: "Applied jobs",
                  ),
                  Tab(
                    text: "Interview Invites",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Applied_Job_Tab(
                    appliedJobs: appliedJobs,
                    userModel: widget.userModel,
                    firebaseUser: widget.firebaseUser,
                  ),
                  Interview_Tab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==============================================================
//           Applied_Job_Tab page Screen
// ==============================================================
class Applied_Job_Tab extends StatefulWidget {
  var appliedJobs;
  final User firebaseUser;
  final UserModel userModel;
  Applied_Job_Tab({this.appliedJobs, required this.firebaseUser, required this.userModel});

  @override
  State<Applied_Job_Tab> createState() => _Applied_Job_TabState();
}

class _Applied_Job_TabState extends State<Applied_Job_Tab> {
  String? totalLength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: FutureBuilder(
            future: widget.appliedJobs,
            builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // ======= Store list length ===========
                totalLength = (snapshot.data!.length).toString();

                return totalLength == "0"
                    // ===== This Column show when user not applied any job ==========
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "You haven't applied any job",
                              style: mTextStyle18(mFontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              "assets/images/banner/apply.jpg",
                              width: 200,
                            ),
                          ),
                          heightSpacer(),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Everything you need in one app",
                              style: mTextStyle22(mFontWeight: FontWeight.w800, mColor: AppColor.textColorBlack),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Finding your dream job in the tailor field is more easiler and faster than ever with Tailor Management",
                              style: mTextStyle14(mFontWeight: FontWeight.normal, mColor: AppColor.textColorBlack),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpacer(mHeight: 25),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5), // Shadow color
                                  spreadRadius: 3, // Spread radius
                                  blurRadius: 2, // Blur radius
                                  offset: Offset(0, 1), // Offset in x and y directions
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: Jobs_Screen(firebaseUser: widget.firebaseUser, userModel: widget.userModel),
                                    type: PageTransitionType.rightToLeftWithFade,
                                    duration: Duration(milliseconds: 500),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColor.cardBtnBgGreen,
                                radius: 35,
                                child: CircleAvatar(
                                  backgroundColor: AppColor.btnBgColorGreen,
                                  radius: 33,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: AppColor.textColorWhite,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )

                    // ===== This Column show when user applied any job ==========
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "${totalLength} Applied jobs",
                              style: mTextStyle14(mFontWeight: FontWeight.w500),
                            ),
                          ),
                          ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var jobPost = snapshot.data![index];

                              // Assuming 'dateTime' is the field storing DateTime in Firestore
                              DateTime jobDateTime = jobPost['dateTime'].toDate();
                              // Calculate the difference in days
                              int daysDifference = DateTime.now().difference(jobDateTime).inDays;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ============== Job list view Widget ==============
                                  View_Job_List_Widget(
                                    date: "${DateFormat("d MMM yy").format(jobDateTime)} ",
                                    daysAgo: "${daysDifference}",
                                    jobPost: jobPost,
                                    isApplied: true,
                                    applyPress: () {},
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          child: View_Jobs_Details(
                                            jobId: jobPost['jobId'],
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
                          ),
                        ],
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}

//

//
// ==============================================================
//           Interview_Tab Page Screen
// ================================================
class Interview_Tab extends StatefulWidget {
  @override
  State<Interview_Tab> createState() => _Interview_TabState();
}

class _Interview_TabState extends State<Interview_Tab> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: Image.asset(
                "assets/images/logo/interview.png",
                width: 50,
              ),
            ),
            heightSpacer(mHeight: 20),
            Text(
              "Welcome to Interview Invites",
              style: mTextStyle19(mFontWeight: FontWeight.w700, mColor: AppColor.textColorBlack),
              textAlign: TextAlign.center,
            ),
            heightSpacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "HR can search your profile and send you interview invites without you applying to job",
                style: mTextStyle15(mFontWeight: FontWeight.normal, mColor: AppColor.textColorLightBlack),
                textAlign: TextAlign.center,
              ),
            ),
            heightSpacer(mHeight: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Rounded_Btn_Widget(
                title: "How it works",
                btnBgColor: AppColor.btnBgColorGreen,
                mAlignment: Alignment.center,
                onPress: () {
                  bottom_Sheet_Widget(context, mq);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
