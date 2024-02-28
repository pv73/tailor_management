import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Image_Viewer_Screen.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Pdf_Viewer_Screen.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Show_Experience_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/modal/ApplyJobModel.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class View_Jobs_Details extends StatefulWidget {
  final String? jobId;
  final bool? isTailorJobView;
  final UserModel? userModel;

  View_Jobs_Details({super.key, required this.jobId, this.isTailorJobView = false, this.userModel});

  @override
  State<View_Jobs_Details> createState() => _View_Jobs_DetailsState();
}

class _View_Jobs_DetailsState extends State<View_Jobs_Details> {
  late Future<Map<String, dynamic>> jobIdData;

  late MediaQueryData mq;
  bool isApplied = false;

  @override
  void initState() {
    super.initState();
    // First get all List data which is Stored all jobsData then fetch data by Using JoId
    jobIdData = BlocProvider.of<JobPostCubit>(context).getAllDataByJobId(widget.jobId!);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
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
                "Job Details",
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
      body: SingleChildScrollView(
        child: Container(
          width: mq.size.width,
          child: FutureBuilder(
            future: jobIdData,
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // ====== Store Data in getFieldByJobId var ============
                var getFieldByJobId = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // company Logo
                    CircleAvatar(
                      radius: 39,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 37,
                        backgroundImage: NetworkImage("${getFieldByJobId['company_logo']}"),
                      ),
                    ),

                    // Company details
                    heightSpacer(mHeight: 15),
                    Text("${getFieldByJobId['job_type']}", style: mTextStyle18(mFontWeight: FontWeight.w600)),
                    heightSpacer(mHeight: 3),
                    Text("at ${getFieldByJobId['company_name']}", style: mTextStyle14()),
                    heightSpacer(mHeight: 3),

                    // ==== Experience, vacancy and shift ==============
                    Card_Container_Widget(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 16),
                      mBorderColor: AppColor.navBgColor,
                      child: Row(
                        children: [
                          // If any one is not null then Show other value who is not null
                          getFieldByJobId['minimum_experience'] != null || getFieldByJobId['maximum_experience'] != null
                              ? Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Experience",
                                        style: mTextStyle12(),
                                      ),
                                      heightSpacer(mHeight: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/images/banner/experience.png", width: 20),
                                          Expanded(
                                            child: Show_Experience_Widget(
                                              getJobListData: getFieldByJobId,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Container(),

                          // If both Experience filed are empty then not show anything
                          getFieldByJobId['minimum_experience'] == null && getFieldByJobId['maximum_experience'] == null
                              ? Container()
                              : Container(
                                  height: 42,
                                  child: VerticalDivider(color: AppColor.navBgColor),
                                ),

                          // ======= Total Employee ===========
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Vacancy",
                                  style: mTextStyle12(),
                                ),
                                heightSpacer(mHeight: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/banner/total_employee.png",
                                        width: 20, alignment: Alignment.centerRight),
                                    widthSpacer(mWidth: 7),
                                    Text(
                                      "${getFieldByJobId['total_tailor']}",
                                      style: mTextStyle13(mFontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 42,
                            child: VerticalDivider(color: AppColor.navBgColor),
                          ),

                          // =========== Work Shift =========
                          Expanded(
                              child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Work Shift",
                                  style: mTextStyle12(),
                                ),
                                heightSpacer(mHeight: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/banner/day_night_shift.png",
                                        width: 20, alignment: Alignment.centerRight),
                                    widthSpacer(mWidth: 5),
                                    Text(
                                      "${getFieldByJobId['work_shift']}",
                                      style: mTextStyle13(mFontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),

                    // =========== Other Details =========
                    Container(
                      width: mq.size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Others Details",
                        style: mTextStyle14(mFontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    // =========== Inside Other Details fields ===============
                    heightSpacer(),
                    Card_Container_Widget(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      mBorderColor: AppColor.navBgColor,
                      mColor: Colors.transparent,
                      child: Column(
                        children: [
                          //=========== Garment Type and job type ==================
                          Row(
                            children: [
                              Expanded(
                                child: _OtherDetails(title: "Garment Type", titleText: "${getFieldByJobId['garment_type']}"),
                              ),
                              Container(
                                height: 35,
                                child: VerticalDivider(color: AppColor.navBgColor),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: _OtherDetails(title: "Job type", titleText: "${getFieldByJobId['job_type']}"),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColor.navBgColor,
                            height: 30,
                          ),

                          //  ====== all type of Salary ==================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ==== If sampling Salary and grade Salary is Empty then Nothing Show
                              getFieldByJobId['samp_salary'] == "" && getFieldByJobId['grade_salary'] == null
                                  ? Container()

                                  // If Only sampling Salary is Empty then show grade salary otherwise sampling salary show
                                  : getFieldByJobId['samp_salary'] != ""
                                      ? Expanded(
                                          child: _OtherDetails(
                                            title: "Salary",
                                            titleText: "${getFieldByJobId['samp_salary']}",
                                          ),
                                        )
                                      : Expanded(
                                          child: _OtherDetails(
                                            title: "Salary",
                                            titleText:
                                                "${getFieldByJobId['grade_salary']} : ${getFieldByJobId['grade_salary_amount']}",
                                          ),
                                        ),

                              // ==== If sampling Salary and grade Salary is Empty then Nothing Show
                              getFieldByJobId['samp_salary'] == "" && getFieldByJobId['grade_salary'] == null
                                  ? Container()
                                  : Container(
                                      height: 35,
                                      margin: EdgeInsets.only(right: 10),
                                      child: VerticalDivider(color: AppColor.navBgColor),
                                    ),

                              // ========== Work Type ============
                              Expanded(
                                child: _OtherDetails(
                                  title: "Work type",
                                  titleText: "${getFieldByJobId['work_type']}",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // =========== Tailor Skills ================
                    (getFieldByJobId['tailor_skill'] as List).isNotEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Card_Container_Widget(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              mBorderColor: AppColor.navBgColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              "Tailor skills",
                                              style: mTextStyle13(mFontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text(
                                              "Employees",
                                              style: mTextStyle13(mFontWeight: FontWeight.w500),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ======= Skill & Skills Employee List ================
                                  heightSpacer(mHeight: 5),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: (getFieldByJobId['tailor_skill'] as List).length,
                                    itemBuilder: (context, skillIndex) {
                                      return Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 9,
                                                child: Container(
                                                  child: Text(
                                                    "${getFieldByJobId['tailor_skill'][skillIndex]}",
                                                    style: mTextStyle13(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  child: Text(
                                                    "${getFieldByJobId['skills_tailor_employee'][skillIndex]}",
                                                    style: mTextStyle15(mFontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),

                    // ============= Department =============
                    Card_Container_Widget(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      mBorderColor: AppColor.navBgColor,
                      child: Column(
                        children: [
                          // ===== Garment Order ============
                          _Department_Row_Widget(
                            title: "Garment Order",
                            titleText: "${getFieldByJobId['garment_order']}",
                          ),

                          // ===== Tailor Department ============
                          heightSpacer(),
                          _Department_Row_Widget(
                            title: "Tailor department",
                            titleText: "${getFieldByJobId['department']}",
                          ),

                          // ======= Tailor Category ===========
                          heightSpacer(),
                          _Department_Row_Widget(
                            title: "Tailor category",
                            titleText: "${getFieldByJobId['category']}",
                          ),

                          // ======= If Tailor category is Equal To "Part Time" Then Slow This ===========
                          getFieldByJobId['part_time_category'] != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      _Department_Row_Widget(
                                        title: "${getFieldByJobId['part_time_category']}",
                                        titleText: "${getFieldByJobId['part_time_sub_cat']}",
                                      ),
                                      heightSpacer(),
                                      _Department_Row_Widget(
                                        title: "${getFieldByJobId['part_time_sub_cat']}",
                                        titleText: "${getFieldByJobId['pt_sub_cat_text']}",
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),

                          // ======= If Tailor category is Equal To "Part Rate" Then Slow This ===========
                          getFieldByJobId['part_rate'] != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      // If part rate is Equal to execl and image then show part rate & his downloadUrl
                                      getFieldByJobId['part_rate'] == "Part rate excel" ||
                                              getFieldByJobId['part_rate'] == "Part rate image"
                                          ? _Department_Row_Widget(
                                              title: "${getFieldByJobId['part_rate']}",
                                              titleText: "${getFieldByJobId['part_rate_url_name']}",
                                            )
                                          : Container(),

                                      // If part rate is Equal to text then show part rate & his part_rate_text
                                      getFieldByJobId['part_rate'] == "Part rate text"
                                          ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${getFieldByJobId['part_rate']}",
                                                  style: mTextStyle13(),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    "${getFieldByJobId['part_rate_text']}",
                                                    style: mTextStyle12(mFontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              : Container(),

                          // ======= If Tailor category is Equal To "Part Rate" Then Slow This ===========
                          getFieldByJobId['full_pc'] != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: _Department_Row_Widget(
                                    title: "${getFieldByJobId['full_pc']}",
                                    titleText: "${getFieldByJobId['full_pc_amount']}",
                                  ),
                                )
                              : Container(),

                          // If Garment Image and Part Rate Image Any one not null then show
                          getFieldByJobId['garment_image'] != null || getFieldByJobId['part_rate_url'] != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Divider(),
                                      Text(
                                        "Image View",
                                        style: mTextStyle13(mFontWeight: FontWeight.w500),
                                      ),

                                      // ======== If Garment Image is not null then show "Garment Image" =========
                                      getFieldByJobId['garment_image'] != null
                                          ? Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Garment Image",
                                                    style: mTextStyle13(),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            child: Image_Viewer_Screen(
                                                              ImageUrl: getFieldByJobId['garment_image'],
                                                            ),
                                                            type: PageTransitionType.fade,
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "${getFieldByJobId['garmentPicName']}",
                                                        style:
                                                            mTextStyle13(mFontWeight: FontWeight.w500, mColor: AppColor.activeColor),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),

                                      // ======== If Garment Image is not null then show "Garment Image" =========
                                      getFieldByJobId['part_rate_url'] != null
                                          ? Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Part Rate Image",
                                                    style: mTextStyle13(),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (getFieldByJobId['part_rate'] == "Part rate image") {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              child: Image_Viewer_Screen(
                                                                ImageUrl: getFieldByJobId['part_rate_url'],
                                                              ),
                                                              type: PageTransitionType.fade,
                                                            ),
                                                          );
                                                        } else if (getFieldByJobId['part_rate'] == "Part rate excel") {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              child: Pdf_Viewer_Screen(
                                                                pdfUrl: getFieldByJobId['part_rate_url'],
                                                              ),
                                                              type: PageTransitionType.fade,
                                                            ),
                                                          );
                                                        } else {
                                                          null;
                                                        }
                                                      },
                                                      child: Text(
                                                        "${getFieldByJobId['part_rate_url_name']}",
                                                        style:
                                                            mTextStyle13(mFontWeight: FontWeight.w500, mColor: AppColor.activeColor),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),

                    heightSpacer(mHeight: 80),
                  ],
                );
              }
            },
          ),
        ),
      ),

      // Submit bottom Sheet bottom Sheet Btn
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: widget.isTailorJobView == false
              //======= If Admin Job view then slow Apply button =============
              ? Rounded_Btn_Widget(
                  title: "Done",
                  mTextColor: Colors.white,
                  btnBgColor: AppColor.navBgColor,
                  borderColor: AppColor.navBgColor,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  mHeight: 40,
                  borderRadius: 5,
                  mAlignment: Alignment.center,
                )

              //======= If Tailor Job view then slow Apply button =============
              : StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('jobs')
                      .doc(widget.jobId)
                      .collection('apply_job')
                      .doc(widget.userModel!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      // Data is still loading
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.data!.exists) {
                      // Document does not exist, set isApplied to false
                      isApplied = false;
                    } else {
                      // Document exists, retrieve the isApplied field value
                      isApplied = snapshot.data!.get('isApplied') ?? false;
                    }

                    return Rounded_Btn_Widget(
                      title: isApplied ? "Applied" : "Job Apply",
                      mFontWeight: FontWeight.w500,
                      mTextColor: isApplied ? Colors.blue.shade400 : Colors.white,
                      btnBgColor: isApplied ? Colors.blue.shade100 : AppColor.btnBgColorGreen,
                      borderColor: isApplied ? Colors.blue.shade100 : AppColor.btnBgColorGreen,
                      onPress: isApplied
                          ? () {}
                          : () {
                              // ===== call the job apply function =============
                              JobApplyFunction();
                            },
                      mHeight: 40,
                      borderRadius: 5,
                      mAlignment: Alignment.center,
                    );
                  }),
        ),
      ),
    );
  }

  // ========== JobApplyFunction button clicked ===============
  void JobApplyFunction() async {
    try {
      // ========== store value in variable ==========
      String? jobId = widget.jobId;
      String? userId = widget.userModel!.uid;

      ApplyJobModel newApplyJob = ApplyJobModel(
        dateTime: DateTime.now(),
        jobId: jobId,
        userId: userId,
        user_name: widget.userModel!.user_name,
        emailId: widget.userModel!.email,
        isApplied: true,
        garment_category: widget.userModel!.garment_category,
        skills: widget.userModel!.skills,
        profilePicUrl: widget.userModel!.profile_pic,
      );

      await FirebaseFirestore.instance.collection("jobs").doc(jobId).collection("apply_job").doc(userId).set(newApplyJob.toMap());

      log("JobApply Successfully");
    } catch (err) {
      log(err.toString());
    }
  }

  //TODO ============= UI part End ==================
  // ========== Other Details Widget ===============
  Widget _OtherDetails({required String title, titleText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${title} :",
          style: mTextStyle12(mFontWeight: FontWeight.w400),
          textAlign: TextAlign.right,
        ),
        widthSpacer(),
        FittedBox(
          child: Text(
            "${titleText}",
            style: mTextStyle13(mFontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  //TODO =============================
  // ===== Other Details inside widget ==============
  Widget _Department_Row_Widget({required String title, titleText}) {
    return Row(
      children: [
        Text(
          "${title}:",
          style: mTextStyle13(),
        ),
        Expanded(
          child: Text(
            "${titleText}",
            style: mTextStyle13(mFontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
