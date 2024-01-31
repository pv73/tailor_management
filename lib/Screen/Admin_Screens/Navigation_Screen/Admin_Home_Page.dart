import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Post_Job.dart';
import 'package:tailor/app_widget/Admin_NameCard_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/admin_Dashboard_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_Home_Page extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const Admin_Home_Page(
      {super.key, required this.firebaseUser, required this.companyModel});

  @override
  State<Admin_Home_Page> createState() => _Admin_Home_PageState();
}

class _Admin_Home_PageState extends State<Admin_Home_Page> {
  late MediaQueryData mq;
  var getJobPostedList;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        titleSpacing: 0,
        title: SizedBox(
          width: mq.size.width * 0.81,
          height: 38,
          child: TextFormField(
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            decoration: mInputDecoration(
              padding: EdgeInsets.only(top: 3),
              prefixIcon: Icon(Icons.search),
              mIconSize: 18,
              hint: "Search job hear...",
              hintColor: AppColor.textColorLightBlack,
            ),
          ),
        ),
      ),
      drawer: Drawer_Widget(
          isCurUserCom: true,
          firebaseUser: widget.firebaseUser,
          companyModel: widget.companyModel),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                // Admin Details Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColor.textColorBlue, AppColor.activeColor],
                    ),
                  ),
                  child: Admin_NameCard_Widget(
                    firebaseUser: widget.firebaseUser,
                    companyModel: widget.companyModel,
                    mTextColor: AppColor.textColorWhite,
                  ),
                ),

                // top Dashboard Selection
                heightSpacer(mHeight: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          BlocBuilder<JobPostCubit, JobPostState>(
                            builder: (context, state) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: BlocProvider.of<JobPostCubit>(context)
                                    .getDataFilterByOrder(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    // var getAllJobPosts = snapshot.data!.docs;
                                    totalPostedJob(snapshot);

                                    return Admin_Dashboard_Widget(
                                      mBgColor: Colors.white,
                                      mImage:
                                          "assets/images/logo/ic_attendence.png",
                                      mText: "Applied Job",
                                      mTextNo: getJobPostedList.length.isNaN
                                          ? "0"
                                          : "${getJobPostedList.length}",
                                      mColor: AppColor.textColorBlue,
                                    );
                                  }
                                  return Admin_Dashboard_Widget(
                                    mBgColor: Colors.white,
                                    mImage:
                                        "assets/images/logo/ic_attendence.png",
                                    mText: "Applied Job",
                                    widget: Lottie.asset(
                                        "assets/images/lottie_animation/loading_animation.json",
                                        width: 50),
                                    mColor: AppColor.textColorBlue,
                                  );
                                },
                              );
                            },
                          ),

                          Admin_Dashboard_Widget(
                            mBgColor: Colors.white,
                            mImage: "assets/images/logo/applied_job.png",
                            mText: "Applied Job",
                            mTextNo: "25",
                            mColor: AppColor.cardBtnBgGreen,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.white,
                            mImage: "assets/images/logo/total_employee.png",
                            mText: "Total Employee",
                            mTextNo: "200",
                            mColor: AppColor.textColorBlack,
                          ),
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.white,
                            mImage: "assets/images/logo/total_company.png",
                            mText: "Total Company",
                            mTextNo: "500",
                            mColor: AppColor.textColorBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Total Job Post
                heightSpacer(mHeight: 25),
                Card_Container_Widget(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpacer(mHeight: 5),
                      Text(
                        "Total job post for",
                        style: mTextStyle15(mFontWeight: FontWeight.w500),
                      ),
                      heightSpacer(mHeight: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/ic_attendence.png",
                            mText: "Total Full Piece",
                            mTextNo: "1202",
                            mColor: AppColor.cardBtnBgGreen,
                          ),
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/applied_job.png",
                            mText: "Total Part Rate",
                            mTextNo: "2500",
                            mColor: AppColor.textColorBlack,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/total_employee.png",
                            mText: "Other Total",
                            mTextNo: "200",
                            mColor: AppColor.textColorBlue,
                          ),
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/total_company.png",
                            mText: "Total full Piece",
                            mTextNo: "500",
                            mColor: AppColor.textColorBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Create new Job
                heightSpacer(mHeight: 20),
                Rounded_Btn_Widget(
                  mWidth: MediaQuery.of(context).size.width * 0.75,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Post_Job(
                          companyModel: widget.companyModel,
                          firebaseUser: widget.firebaseUser,
                        ),
                      ),
                    );
                  },
                  title: "Create New Job",
                  mAlignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// this code get name word's first letter
  /// like Mukesh Kumar then get MK
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

  //
  void totalPostedJob(snapshot) {
    // first get jobPosts List from JobPostCubit file the store getJobPostList variable
    getJobPostedList = BlocProvider.of<JobPostCubit>(context).jobPosts;
    getJobPostedList.clear();

    // var jobPosts = snapshot.data!.docs;
    for (DocumentSnapshot doc in snapshot.data!.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Check if the UserId isNotEqual to the current user's ID
      if (data.containsKey("uid") && data["uid"] != widget.firebaseUser.uid) {
        // Skip adding this document to clients_data
        continue;
      }
      // Add all Data in jobPosts list
      getJobPostedList.add(data);
    }
  }
}
