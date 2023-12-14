import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor/Screen/Home/Home_page_details/job_referral_details.dart';
import 'package:tailor/Screen/user_onboard/number_login_screen.dart';
import 'package:tailor/app_widget/activity_widget.dart';
import 'package:tailor/app_widget/panding_task_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/controller/firebase_connection.dart';
import 'package:tailor/cubits/auth_cubit/auth_cubit.dart';
import 'package:tailor/cubits/auth_cubit/auth_state.dart';
import 'package:tailor/dynimic_list/job_referral_list.dart';
import '../../ui_helper.dart';

class Home_Page extends StatefulWidget {
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  //
  late Stream<QuerySnapshot<Map<String, dynamic>>> clientsStream;

  //
  late MediaQueryData mq;
  int activeIndex = 0;
  String? UserId;

  @override
  void initState() {
    super.initState();
    // _getUserId();
    clientsStream = FirebaseProvider().getClients();
  }

  // Function to retrieve the UserId from shared preferences
  // Future<void> _getUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     UserId = prefs.getString('UserId');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
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
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              // TODO: implement listener

              if (state is AuthLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Number_login_Screen(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logOut();
                },
                icon: Icon(
                  Icons.logout,
                  size: 23,
                  color: Colors.red,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // first top 2 Section in this Container
              // with 10px padding
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attendance Activity",
                      style: mTextStyle16(mFontWeight: FontWeight.w700),
                    ),

                    // Attendance Box
                    heightSpacer(),
                    Container(
                      child: ExpandablePageView(
                        onPageChanged: (index) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        children: <Widget>[
                          /// Slider Container page 1
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Activity_Widget(
                                      mImage:
                                          "assets/images/logo/ic_attendence.png",
                                      mText: "Total Attendence",
                                      mTextNo: "31",
                                      mColor: AppColor.textColorBlue,
                                      mBgColor: Colors.grey.shade50,
                                    ),
                                    Activity_Widget(
                                      mImage:
                                          "assets/images/logo/ic_present.png",
                                      mText: "Total Present",
                                      mTextNo: "25",
                                      mColor: AppColor.cardBtnBgGreen,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //
                                    Activity_Widget(
                                      mImage:
                                          "assets/images/logo/ic_absent.png",
                                      mText: "Total Absent",
                                      mTextNo: "02",
                                      mColor: Colors.red,
                                    ),
                                    Activity_Widget(
                                      mImage: "assets/images/logo/ic_leave.png",
                                      mText: "Total Leave",
                                      mTextNo: "03",
                                      mColor: AppColor.textColorBlack,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// Slider Container Page 2
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightSpacer(mHeight: 5),
                                Text(
                                  "Today Activity",
                                  style: mTextStyle15(
                                      mFontWeight: FontWeight.w600),
                                ),
                                heightSpacer(mHeight: 15.h),
                                Row(
                                  children: [
                                    // 1st container
                                    Today_Activity(
                                      mIcon: Icons.arrow_circle_right_outlined,
                                      mText: "Check In",
                                      mTimeText: "09:30 AM",
                                      mActionText: "On Time",
                                      mColor: AppColor.cardBtnBgGreen,
                                    ),

                                    // 2nd Container
                                    widthSpacer(mWidth: 8.w),
                                    Today_Activity(
                                      mIcon: Icons.arrow_circle_left_outlined,
                                      mText: "Check Out",
                                      mTimeText: "06:30 PM",
                                      mActionText: "On Time",
                                      mColor: Colors.red,
                                    ),
                                  ],
                                ),

                                //
                                heightSpacer(),
                                Row(
                                  children: [
                                    // 1st container
                                    Today_Activity(
                                      mIcon: Icons.alarm,
                                      mText: "Start Overtime",
                                      mTimeText: "06:30 PM",
                                      mColor: AppColor.cardBtnBgGreen,
                                    ),

                                    // 2nd Container
                                    widthSpacer(mWidth: 8),
                                    Today_Activity(
                                      mIcon: Icons.arrow_circle_left_outlined,
                                      mText: "Finish Overtime",
                                      mTimeText: "11:00 PM",
                                      mColor: Colors.red,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //// Slider Indicator ///
                    heightSpacer(mHeight: 8),
                    buildIndicator(),

                    //  Complete pending tasks
                    heightSpacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                                "assets/images/logo/pending_pic.jpg"),
                          ),
                        ),
                        widthSpacer(),
                        Expanded(
                          flex: 11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  "Complete Your pending tasks",
                                  style: mTextStyle17(
                                      mFontWeight: FontWeight.w500),
                                ),
                              ),
                              heightSpacer(mHeight: 2),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Increase your chances of getting calls from HRs",
                                  style: mTextStyle14(
                                      mColor: AppColor.textColorLightBlack),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // Complete pending tasks slider
                    heightSpacer(),
                    Container(
                      height: 75.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: mq.size.width * 0.8,
                            child: Panding_Task_Widget(
                              mImage: "assets/images/logo/ic_email.png",
                              mText:
                                  "Verify your email so HRs can reach out to you",
                              BtnText: "Verify email",
                              mCardBgColor: Colors.blue.shade50,
                              mIconBgColor: Colors.blue.shade100,
                              onPress: () {},
                            ),
                          ),
                          widthSpacer(mWidth: 5),
                          Container(
                            width: mq.size.width * 0.8,
                            child: Panding_Task_Widget(
                              mImage: "assets/images/logo/ic_details.png",
                              mText:
                                  "New details add our profile and update profile",
                              BtnText: "Add details",
                              mCardBgColor: Colors.orange.shade50,
                              mIconBgColor: Colors.orange.shade100,
                              onPress: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // business image
              Container(
                child: Image.asset("assets/images/banner/img_business.jpg"),
              ),

              // Get a Job referral Section
              heightSpacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: AppColor.bgColorBlue,
                child: Column(
                  children: [
                    // get a job Heading
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Get a job referral from peers from tailor management",
                            style: mTextStyle17(mFontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            "assets/images/banner/job_image.png",
                          ),
                        )
                      ],
                    ),

                    // Get a job Card
                    heightSpacer(mHeight: 5),
                    StreamBuilder<QuerySnapshot>(
                      stream: clientsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.hasError}");
                        } else if (snapshot.hasData) {
                          clients_data.clear();
                          for (DocumentSnapshot doc in snapshot.data!.docs) {
                            clients_data.add(doc.data());
                          }

                          return Container(
                            height: 220.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: clients_data.length > 6
                                  ? 6
                                  : clients_data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, jobIndex) {
                                //
                                var nameText = getInitials(
                                    clients_data[jobIndex]['user_name']!
                                        .toUpperCase());
                                var field_data = clients_data[jobIndex];
                                //
                                return Container(
                                  width: 148.h,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Job_Referral_Details(
                                                  index: jobIndex),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: AppColor.textColorWhite,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            field_data['profile_pic'] == null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        AppColor.textColorBlue,
                                                    radius: 25,
                                                    child: Text(
                                                      nameText,
                                                      style: mTextStyle18(
                                                          mFontWeight:
                                                              FontWeight.w700,
                                                          mColor: AppColor
                                                              .textColorWhite),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      field_data['profile_pic'],
                                                    ),
                                                  ),

                                            //
                                            heightSpacer(mHeight: 7),
                                            Text(
                                              field_data['user_name']
                                                  .toString(),
                                              style: mTextStyle15(
                                                  mFontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            heightSpacer(mHeight: 7),
                                            field_data['skills'] == null
                                                ? Container()
                                                : buildSkills(
                                                    field_data['skills']),

                                            //
                                            heightSpacer(mHeight: 7),
                                            field_data['experience_company']
                                                    .isEmpty
                                                ? Container()
                                                : Text(
                                                    field_data[
                                                            'experience_company']
                                                        .toString(),
                                                    style: mTextStyle12(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ),

                                            //
                                            Spacer(),
                                            Rounded_Btn_Widget(
                                              title: "Ask for eferral",
                                              mFontWeight: FontWeight.w600,
                                              mfontSize: 11,
                                              mAlignment: Alignment.center,
                                              btnBgColor:
                                                  AppColor.cardBtnBgGreen,
                                              mHeight: 25,
                                              onPress: () {
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        //
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    //
                    heightSpacer(),
                    Rounded_Btn_Widget(
                      title: "View All",
                      mAlignment: Alignment.center,
                      mHeight: 30,
                      btnBgColor: AppColor.textColorWhite,
                      mTextColor: AppColor.cardBtnBgGreen,
                      onPress: () {},
                    ),
                  ],
                ),
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
                      mainAxisExtent: 220.h),
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

              // Recommended Job Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Recommended Jobs",
                        style: mTextStyle17(mFontWeight: FontWeight.w500),
                      ),
                    ),
                    heightSpacer(mHeight: 2),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Jobs based on your preferences",
                        style: mTextStyle15(
                          mFontWeight: FontWeight.w400,
                          mColor: AppColor.textColorLightBlack,
                        ),
                      ),
                    ),
                    heightSpacer(mHeight: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Recomnd_job_Widget(
                              mTitle: "From home",
                              mIcon: "assets/images/logo/ic_work_home.png",
                              mOnPressed: () {
                                print("From Home");
                              }),
                        ),
                        Expanded(
                          child: Recomnd_job_Widget(
                              mTitle: "Part Time",
                              mIcon: "assets/images/logo/ic_part_time.png",
                              mIcon_width: 48,
                              mOnPressed: () {
                                print("Part Time");
                              }),
                        ),
                        Expanded(
                          child: Recomnd_job_Widget(
                              mTitle: "Night Shift",
                              mIcon: "assets/images/logo/ic_night_shift.png",
                              mIcon_width: 60,
                              mOnPressed: () {
                                print("Night Shift");
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // only  image name img_2
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue.shade50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/banner/img_2.jpg")),
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

  /// slider Indicator //
  Widget buildIndicator() {
    return Align(
      alignment: Alignment.center,
      child: AnimatedSmoothIndicator(
        count: 2,
        activeIndex: activeIndex,
        effect: WormEffect(
            spacing: 4.0,
            radius: 8.0,
            dotWidth: 8.0,
            dotHeight: 5.0,
            paintStyle: PaintingStyle.stroke,
            activeDotColor: Colors.indigo),
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

  /// this code for Recommended jobs card design Widget
  /// Create card Widget
  Widget Recomnd_job_Widget(
      {required mOnPressed, mTitle, mIcon, double mIcon_width = 38.0}) {
    return Card(
      color: AppColor.bgColorWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "${mTitle}",
                style: mTextStyle15(),
                textAlign: TextAlign.center,
              ),
            ),
            heightSpacer(mHeight: 15),
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              radius: 30,
              child: Image.asset(
                "${mIcon}",
                width: mIcon_width,
              ),
            ),
            heightSpacer(),
            TextButton(
              onPressed: mOnPressed,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "View all >",
                  style: mTextStyle15(mColor: AppColor.cardBtnBgGreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
