import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/AdminSeen_TailorProfile.dart';
import 'package:tailor/app_widget/NoDataFound_ThenShow_Widget.dart';
import 'package:tailor/ui_Helper.dart';

class View_Jobs_Applied extends StatefulWidget {
  final String? getJobId;

  const View_Jobs_Applied({super.key, this.getJobId});

  @override
  State<View_Jobs_Applied> createState() => _View_Jobs_AppliedState();
}

class _View_Jobs_AppliedState extends State<View_Jobs_Applied> {
  String? totalLength;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 37,
                width: 37,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFBDBDBD))),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 15,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Applied job",
                style: mTextStyle17(mFontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Container(
                height: 37,
                width: 37,
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFBDBDBD))),
                child: Icon(
                  Icons.turned_in_not_outlined,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('jobs').doc("${widget.getJobId}").collection('apply_job').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/images/lottie_animation/loading-2.json", width: 80),
              ); // or another loading indicator
            } else if (snapshot.hasData) {
              var appliedJobs = snapshot.data!.docs;

              return appliedJobs.length == 0
                  ? NoDataFound_ThenShow_Widget(
                      headingText: "",
                      image: "assets/images/banner/empty_people.png",
                      subHeadingText: "No any one job applied",
                      subHeadingParagraph:
                          "When someone applies for a job, it will be shown to you. Thanks for using Tailor Management App.",
                      imageSize: 270,
                      btnName: "Go Back",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )

                  // ==== job Applied people list ===============
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text(
                            "${appliedJobs.length} People applied",
                            style: mTextStyle14(mFontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: appliedJobs.length,
                          itemBuilder: (context, index) {
                            var appliedJobData = appliedJobs[index].data() as Map<String, dynamic>;

                            DateTime jobDateTime = appliedJobData['dateTime'].toDate(); // 'dateTime' is the field storing DateTime
                            int daysAgo = DateTime.now().difference(jobDateTime).inDays; // Calculate the difference in days

                            // Build your UI here using appliedJobData
                            return Card_Container_Widget(
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              mBorderColor: Colors.green.shade200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // =========== Show date and Time  ================
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          int.parse("${daysAgo}") == 0
                                              ? "Today"
                                              : int.tryParse("${daysAgo}") != null && int.parse("${daysAgo}") > 30
                                                  ? "30+ d ago"
                                                  : "${daysAgo}d ago",
                                          style: mTextStyle13(mColor: Colors.green.shade600, mFontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${DateFormat("d MMM yy").format(jobDateTime)}",
                                          style: mTextStyle13(
                                            mFontWeight: FontWeight.w500,
                                            mColor: Colors.green.shade600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  // ============ Name, email and profile pic Show ==========
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            child: AdminSeen_TailorProfile_Screen(
                                              getUserId: appliedJobData['userId'],
                                            ),
                                            type: PageTransitionType.fade),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${appliedJobData['user_name']}",
                                                  style: mTextStyle15(mFontWeight: FontWeight.w500),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  "${appliedJobData['emailId']}",
                                                  style: mTextStyle13(),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 23,
                                            backgroundColor: AppColor.btnBgColorGreen,
                                            child: CircleAvatar(
                                              radius: 26,
                                              backgroundImage: NetworkImage("${appliedJobData['profilePicUrl']}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // ========== Tailor Skills Show ============
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.local_library_outlined,
                                          color: AppColor.cardBtnBgGreen,
                                          size: 20,
                                        ),
                                        widthSpacer(mWidth: 4),
                                        Expanded(
                                          child: Container(
                                            height: 18.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: (appliedJobData['skills'] as List).length > 3
                                                  ? 3
                                                  : (appliedJobData['skills'] as List).length,
                                              itemBuilder: (context, skill_Child) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                                  child: Text(
                                                    "${appliedJobData['skills'][skill_Child]}, ",
                                                    style: mTextStyle13(mColor: AppColor.textColorLightBlack),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // =========== Tailor garment Category =========
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.work_outline,
                                          color: AppColor.cardBtnBgGreen,
                                          size: 20,
                                        ),
                                        widthSpacer(mWidth: 4),
                                        Expanded(
                                          child: Container(
                                            height: 18.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: (appliedJobData['garment_category'] as List).length > 3
                                                  ? 3
                                                  : (appliedJobData['garment_category'] as List).length,
                                              itemBuilder: (context, garment_Child) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                                  child: Text(
                                                    "${appliedJobData['garment_category'][garment_Child]}, ",
                                                    style: mTextStyle13(mColor: AppColor.textColorLightBlack),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
            } else {
              return Center(child: Text("No data Found"));
            }
          },
        ),
      ),
    );
  }
}
