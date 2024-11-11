import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Post_Job.dart';
import 'package:tailor/Screen/Admin_Screens/Navigation_Screen/Total_Posted_Job.dart';
import 'package:tailor/app_widget/Admin_NameCard_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/admin_Dashboard_widget.dart';
import 'package:tailor/cubits/company_cubit/company_cubit.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_Home_Page extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const Admin_Home_Page({super.key, required this.firebaseUser, required this.companyModel});

  @override
  State<Admin_Home_Page> createState() => _Admin_Home_PageState();
}

class _Admin_Home_PageState extends State<Admin_Home_Page> {
  late MediaQueryData mq;
  var getJobPostedList;
  int allAppliedJobCount = 0;
  int userPostedJobCount = 0;
  int TotalCompanyLength2 = 0;

  @override
  void initState() {
    super.initState();
    fetchAppliedJobsByUserId(widget.firebaseUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      drawer: Drawer_Widget(isCurUserCom: true, firebaseUser: widget.firebaseUser, companyModel: widget.companyModel),

      // Floating Action button
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.navBgColor,
        foregroundColor: AppColor.textColorWhite,
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: Post_Job(
                companyModel: widget.companyModel,
                firebaseUser: widget.firebaseUser,
                isButtonClick: true,
              ),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 400),
            ),
          );
        },
        label: const Text("Create New Job"),
      ),
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
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.white,
                            mImage: "assets/images/logo/ic_attendence.png",
                            mText: "Posted Job",
                            mTextNo: "${userPostedJobCount}",
                            mColor: AppColor.textColorBlue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Total_Posted_Job(
                                    companyModel: widget.companyModel,
                                    firebaseUser: widget.firebaseUser,
                                  ),
                                ),
                              );
                            },
                          ),

                          Admin_Dashboard_Widget(
                            mBgColor: Colors.white,
                            mImage: "assets/images/logo/applied_job.png",
                            mText: "Applied Job",
                            mTextNo: "${allAppliedJobCount}",
                            mColor: AppColor.cardBtnBgGreen,
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
                        "Total available Tailor and Job on Tailor Management Apps.",
                        style: mTextStyle14(mFontWeight: FontWeight.w500),
                      ),
                      heightSpacer(mHeight: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/total_employee.png",
                            mText: "Available Tailor",
                            mTextNo: "5000",
                            mColor: AppColor.cardBtnBgGreen,
                          ),
                          Admin_Dashboard_Widget(
                            mBgColor: Colors.grey.shade50,
                            mImage: "assets/images/logo/applied_job.png",
                            mText: "Available Job",
                            mTextNo: "500",
                            mColor: AppColor.textColorBlack,
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

                          BlocProvider(
                            create: (context) => CompanyCubit()..fetchCompanyDocsLength(), // Call fetch method here
                            child: BlocBuilder<CompanyCubit, CompanyState>(
                              builder: (context, state) {
                                if (state is CompanyLoadingState) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (state is CompanyLoadedState) {
                                  return Admin_Dashboard_Widget(
                                    mBgColor: Colors.white,
                                    mImage: "assets/images/logo/total_company.png",
                                    mText: "Total Company",
                                    mTextNo: "${state.companyDocsLength}",
                                    mColor: AppColor.textColorBlue,
                                  );
                                } else if (state is CompanyErrorState) {
                                  return Text('Error: ${state.error}');
                                }
                                return Container();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Create new Job
                // heightSpacer(mHeight: 20),
                // Rounded_Btn_Widget(
                //   mWidth: MediaQuery.of(context).size.width * 0.75,
                //   onPress: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Post_Job(
                //           companyModel: widget.companyModel,
                //           firebaseUser: widget.firebaseUser,
                //           isButtonClick: true,
                //         ),
                //       ),
                //     );
                //   },
                //   title: "Create New Job",
                //   mAlignment: Alignment.center,
                // ),
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

  // --------- fetchAppliedJobsLength and Posted Job ------------
  Future<void> fetchAppliedJobsByUserId(String userId) async {
    try {
      // Fetch all jobs
      QuerySnapshot jobsSnapshot = await FirebaseFirestore.instance.collection('jobs').get();

      for (var jobDoc in jobsSnapshot.docs) {
        // Check if the userId matches the specified userId
        if (jobDoc['uid'] == userId) {
          userPostedJobCount++; // Increment count if userId matches

          CollectionReference applyJobRef = jobDoc.reference.collection('apply_job');

          // Get the documents in apply_job collection
          QuerySnapshot applyJobSnapshot = await applyJobRef.get();

          // Get the length of apply_job documents
          allAppliedJobCount += applyJobSnapshot.docs.length;
          setState(() {});
        }
      }
    } catch (e) {
      print("Error fetching jobs: $e");
    }
  }
}
