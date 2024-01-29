import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/View_Jobs_Details.dart';
import 'package:tailor/app_widget/Attendence_HomePage_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/app_widget/OurProfile_HomePage_Widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/dynimic_list/job_referral_list.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class Home_Page extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const Home_Page(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  //
  String selectedOption = 'Our Profile'; // Default selected option
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        titleSpacing: 0,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            text: TextSpan(text: "Tailor ", style: mTextStyle20(), children: [
              TextSpan(
                  text: "Management",
                  style: mTextStyle20(mColor: AppColor.textColorBlue))
            ]),
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
                      items: <String>['Our Profile', 'Attendance Activity']
                          .map<DropdownMenuItem<String>>((String value) {
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

                    // Recommended Job Section
                    // heightSpacer(),
                    // Container(
                    //   color: AppColor.bgColorBlue,
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.only(left: 10),
                    //         width: double.infinity,
                    //         child: Text(
                    //           "Recommended Jobs",
                    //           style: mTextStyle17(mFontWeight: FontWeight.w500),
                    //         ),
                    //       ),
                    //       heightSpacer(mHeight: 2),
                    //       Container(
                    //         padding: EdgeInsets.only(left: 10),
                    //         width: double.infinity,
                    //         child: Text(
                    //           "Jobs based on your preferences",
                    //           style: mTextStyle15(
                    //             mFontWeight: FontWeight.w400,
                    //             mColor: AppColor.textColorLightBlack,
                    //           ),
                    //         ),
                    //       ),
                    //       heightSpacer(mHeight: 15),
                    //       Row(
                    //         children: [
                    //           Expanded(
                    //             child: Recomnded_Job_HomePage_Widget(
                    //                 mTitle: "From home",
                    //                 mIcon:
                    //                     "assets/images/logo/ic_work_home.png",
                    //                 onPress: () {
                    //                   print("From Home");
                    //                 }),
                    //           ),
                    //           Expanded(
                    //             child: Recomnded_Job_HomePage_Widget(
                    //                 mTitle: "Part Time",
                    //                 mIcon:
                    //                     "assets/images/logo/ic_part_time.png",
                    //                 mIcon_width: 48,
                    //                 onPress: () {
                    //                   print("Part Time");
                    //                 }),
                    //           ),
                    //           Expanded(
                    //             child: Recomnded_Job_HomePage_Widget(
                    //                 mTitle: "Night Shift",
                    //                 mIcon:
                    //                     "assets/images/logo/ic_night_shift.png",
                    //                 mIcon_width: 60,
                    //                 onPress: () {
                    //                   print("Night Shift");
                    //                 }),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                            itemCount: getJobPostList.length > 5
                                ? 5
                                : getJobPostList.length,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Posted Date: ",
                                                style: mTextStyle13(
                                                  mFontWeight: FontWeight.w600,
                                                  mColor:
                                                      AppColor.btnBgColorGreen,
                                                ),
                                              ),
                                              Text(
                                                "${DateFormat("d MMM yy").format(dateTime)} ",
                                                style: mTextStyle13(
                                                  mFontWeight: FontWeight.w600,
                                                  mColor:
                                                      AppColor.btnBgColorGreen,
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
                                                  mFontWeight: FontWeight.w500),
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
                                            itemCount: (jobPost['tailor_skill']
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
                                                      color:
                                                          Colors.grey.shade400),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
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
                                                      color:
                                                          Colors.grey.shade600,
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
                                                      CrossAxisAlignment.center,
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

              // only  image name img_2
              Container(
                child: Image.asset("assets/images/banner/img_2.jpg"),
              ),

              // business image
              Container(
                child: Image.asset("assets/images/banner/img_business.jpg"),
              ),

              // Only Image
              heightSpacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  "assets/images/banner/working_home.jpg",
                  fit: BoxFit.cover,
                ),
              ),

              // People from Your field
              heightSpacer(),
              Container(
                width: double.infinity,
                color: Colors.blue.shade50,
                padding: EdgeInsets.all(10),
                child: Text(
                  "People from your filed",
                  style: mTextStyle17(mFontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue.shade50,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                      referral_list.length > 4 ? 4 : referral_list.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 220),
                  itemBuilder: (context, releted_job_Index) {
                    return Container(
                      child: Card(
                        color: AppColor.textColorWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColor.textColorBlue,
                                child: Text(
                                  getInitials(referral_list[releted_job_Index]
                                      ['name']!),
                                  style: mTextStyle18(
                                      mFontWeight: FontWeight.w700,
                                      mColor: AppColor.textColorWhite),
                                ),
                              ),
                              heightSpacer(mHeight: 7),
                              Text(
                                referral_list[releted_job_Index]['name']
                                    .toString(),
                                style:
                                    mTextStyle15(mFontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              heightSpacer(mHeight: 7),
                              Text(
                                referral_list[releted_job_Index]['skills']
                                    .toString(),
                                style: mTextStyle12(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              heightSpacer(mHeight: 7),
                              Text(
                                referral_list[releted_job_Index]['company_name']
                                    .toString(),
                                style: mTextStyle12(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Rounded_Btn_Widget(
                                title: "Ask for eferral",
                                mFontWeight: FontWeight.w600,
                                mfontSize: 12,
                                mAlignment: Alignment.center,
                                btnBgColor: AppColor.cardBtnBgGreen,
                                mHeight: 25,
                                onPress: () {
                                  print(releted_job_Index);
                                  print(referral_list[releted_job_Index]['name']
                                      .toString());
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
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

  //================================================================
// ================= UI design end  ===========================

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
}
