import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/View_Jobs_Details.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/View_Job_List_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Total_Posted_Job extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  Total_Posted_Job({
    super.key,
    required this.firebaseUser,
    required this.companyModel,
  });

  @override
  State<Total_Posted_Job> createState() => _Total_Posted_Job();
}

class _Total_Posted_Job extends State<Total_Posted_Job> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(
            text: "Company ",
            style: mTextStyle20(),
            children: [
              TextSpan(
                text: "Posted Job",
                style: mTextStyle20(mColor: AppColor.textColorBlue),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(mq.size.height * 0.035),
          child: SizedBox(
            width: mq.size.width * 0.93,
            height: 40,
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              child: TextFormField(
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                decoration: mInputDecoration(
                  padding: EdgeInsets.only(top: 3),
                  prefixIcon: Icon(Icons.search),
                  mIconSize: 18,
                  hint: "Search by job title",
                  hintColor: AppColor.textColorLightBlack,
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer_Widget(
        isCurUserCom: true,
        firebaseUser: widget.firebaseUser,
        companyModel: widget.companyModel,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "See ",
                        style: mTextStyle20(mFontWeight: FontWeight.w600, mColor: AppColor.textColorBlack),
                        children: [
                          TextSpan(
                            text: "all job ",
                            style: mTextStyle20(mFontWeight: FontWeight.w800, mColor: AppColor.btnBgColorGreen),
                          ),
                          TextSpan(
                            text: "that's your are",
                          ),
                          TextSpan(
                            text: " posted",
                            style: mTextStyle20(mFontWeight: FontWeight.w800, mColor: AppColor.btnBgColorGreen),
                          ),
                        ],
                      ),
                    ),
                    heightSpacer(mHeight: 5),
                    RichText(
                      text: TextSpan(
                        text: "List of all posted job for clients in ",
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

              // View Job

              Expanded(
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

                            // Check if the UserId isNotEqual to the current user's ID
                            if (data.containsKey("uid") && data["uid"] != widget.firebaseUser.uid) {
                              // Skip adding this document to clients_data
                              continue;
                            }

                            // Add all Data in jobPosts list
                            getJobPostList.add(data);
                          }

                          return ListView.builder(
                            itemCount: getJobPostList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var jobPost = getJobPostList[index];

                              // Assuming 'dateTime' is the field storing DateTime in Firestore
                              DateTime jobDateTime = jobPost['dateTime'].toDate();
                              // Calculate the difference in days
                              int daysDifference = DateTime.now().difference(jobDateTime).inDays;

                              return View_Job_List_Widget(
                                date: "${DateFormat("d MMM yy").format(jobDateTime)} ",
                                daysAgo: "${daysDifference}",
                                jobPost: jobPost,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: View_Jobs_Details(
                                        jobId: jobPost['jobId'],
                                          isTailorJobView: false,
                                      ),
                                      type: PageTransitionType.rightToLeftWithFade,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                },
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

  // ===============================================
  // Convert Salary in K
  // CalculateSalary(jobPost) {
  //   // Minimun Salary
  //   var totalMini_salary = int.parse(jobPost['minimun_Salary']);
  //   var mini_Salary = totalMini_salary / 1000;
  //
  //   // If there are no decimal places, display without any decimal places
  //   // If there are decimal places, display with one decimal place
  //   var formattedMiniSalary = (mini_Salary % 1 == 0) ? mini_Salary.toStringAsFixed(0) : mini_Salary.toStringAsFixed(1);
  //
  //   // Maximum Salary
  //   var totalMax_salary = int.parse(jobPost['maxmimum_Salary']);
  //   var maximum_Salary = totalMax_salary / 1000;
  //
  //   var formattedMaxSalary = (maximum_Salary % 1 == 0) ? maximum_Salary.toStringAsFixed(0) : maximum_Salary.toStringAsFixed(1);
  //
  //   return Container(
  //     child: Text(
  //       " INR ${formattedMiniSalary}-${formattedMaxSalary}K",
  //       style: mTextStyle12(mFontWeight: FontWeight.w600),
  //     ),
  //   );
  // }

  // ===============================================
  //   PopupMenuButton

  CustomPopupMenuButton(jobId) {
    String? value;
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: AppColor.btnBgColorGreen,
                  size: 15,
                ),
                widthSpacer(mWidth: 7),
                Text(
                  "Edit",
                  style: mTextStyle13(
                    mColor: AppColor.btnBgColorGreen,
                    mFontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'details',
            child: Row(
              children: [
                Icon(
                  Icons.motion_photos_on_rounded,
                  size: 15,
                ),
                widthSpacer(mWidth: 7),
                Text(
                  "Details",
                  style: mTextStyle13(
                    mFontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                  size: 15,
                ),
                widthSpacer(mWidth: 7),
                Text(
                  "Delete",
                  style: mTextStyle13(
                    mColor: Colors.red,
                    mFontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () {
              value = value;
            },
          ),
        ];
      },
      onSelected: (String value) {
        if (value == "details") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => View_Jobs_Details(
                  jobId: jobId,
                isTailorJobView: false,
              ),
            ),
          );
        }
      },
    );
  }
}
