import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/cubits/job_post_cubit/job_post_cubit.dart';
import 'package:tailor/ui_helper.dart';

class View_Jobs_Details extends StatefulWidget {
  final int jobIndex;

  const View_Jobs_Details({super.key, required this.jobIndex});

  @override
  State<View_Jobs_Details> createState() => _View_Jobs_DetailsState();
}

class _View_Jobs_DetailsState extends State<View_Jobs_Details> {
  late MediaQueryData mq;
  late var getJobListData;

  @override
  void initState() {
    super.initState();
    // First get all List data which is Stored all jobsData then fetch data by Using jobIndex
    getJobListData =
        BlocProvider.of<JobPostCubit>(context).jobPosts[widget.jobIndex];
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFBDBDBD))),
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
                Navigator.pop(context);
              },
              child: Container(
                height: 37,
                width: 37,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFBDBDBD))),
                child: Icon(
                  Icons.share,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: mq.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // company Logo
              CircleAvatar(
                radius: 42,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 39,
                  backgroundImage:
                      NetworkImage("${getJobListData['company_logo']}"),
                ),
              ),

              // Company details
              heightSpacer(mHeight: 15),
              Text("${getJobListData['job_type']}",
                  style: mTextStyle18(mFontWeight: FontWeight.w600)),
              heightSpacer(mHeight: 3),
              Text("at ${getJobListData['company_name']}",
                  style: mTextStyle14()),
              heightSpacer(mHeight: 3),
              Text("${getJobListData['state']}", style: mTextStyle14()),

              // Experience
              Card_Container_Widget(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 16),
                mBorderColor: AppColor.navBgColor,
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/banner/experience.png",
                            width: 22),
                        widthSpacer(mWidth: 5),
                        Expanded(
                          child: Text(
                            "${getJobListData['minimum_experience']}-${getJobListData['maxmimum_experience']} Years",
                            style: mTextStyle13(mFontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                    Container(
                      height: 25,
                      child: VerticalDivider(color: AppColor.navBgColor),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/banner/total_employee.png",
                              width: 22, alignment: Alignment.centerRight),
                          widthSpacer(mWidth: 7),
                          Text(
                            "${getJobListData['total_employee']}",
                            style: mTextStyle13(mFontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 25,
                      child: VerticalDivider(color: AppColor.navBgColor),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/banner/day_night_shift.png",
                            width: 22),
                        widthSpacer(mWidth: 5),
                        Expanded(
                          child: Text(
                            "${getJobListData['worked_shift']}",
                            style: mTextStyle13(mFontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),

              // Other Details
              Container(
                width: mq.size.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Others Details",
                  style: mTextStyle14(mFontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
              heightSpacer(),
              Card_Container_Widget(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                mBorderColor: AppColor.navBgColor,
                mColor: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: _OtherDetails(
                          title: "Salary",
                          titleText:
                              "${getJobListData['minimun_Salary']}-${getJobListData['maxmimum_Salary']}",
                        )),
                        Container(
                          height: 25,
                          child: VerticalDivider(color: AppColor.navBgColor),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: _OtherDetails(
                            title: "Interview",
                            titleText: "${getJobListData['interview_mode']}",
                          ),
                        )),
                      ],
                    ),
                    Divider(
                      color: AppColor.navBgColor,
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _OtherDetails(
                              title: "Garment Type",
                              titleText: "${getJobListData['garment_type']}"),
                        ),
                        Container(
                          height: 25,
                          child: VerticalDivider(color: AppColor.navBgColor),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: _OtherDetails(
                                title: "Type",
                                titleText: "${getJobListData['worked_type']}"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Category
              getJobListData['tailor_category'] == null
                  ? Container()
                  : Card_Container_Widget(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      mBorderColor: AppColor.navBgColor,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Category:",
                                  style: mTextStyle13(
                                      mFontWeight: FontWeight.w500,
                                      mColor: AppColor.textColorLightBlack),
                                ),
                                Expanded(
                                  child: Text(
                                    "${getJobListData['tailor_category']}",
                                    style: mTextStyle13(
                                        mFontWeight: FontWeight.w600),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 20,
                            child: VerticalDivider(color: AppColor.navBgColor),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Salary :",
                                  style: mTextStyle13(
                                      mFontWeight: FontWeight.w500,
                                      mColor: AppColor.textColorLightBlack),
                                ),
                                Expanded(
                                  child: Text(
                                    "${getJobListData['categorySalary']}",
                                    style: mTextStyle13(
                                        mFontWeight: FontWeight.w600),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

              // Garment Order Quantity
              getJobListData['garment_order_qty'] == null
                  ? Container()
                  : Card_Container_Widget(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      mBorderColor: AppColor.navBgColor,
                      child: Row(
                        children: [
                          Text(
                            "Garment Order Quantity:",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w500,
                                mColor: AppColor.textColorLightBlack),
                          ),
                          Expanded(
                            child: Text(
                              "${getJobListData['garment_order_qty']}",
                              style: mTextStyle13(mFontWeight: FontWeight.w600),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),

              // Tailor Department
              Card_Container_Widget(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                mBorderColor: AppColor.navBgColor,
                child: Row(
                  children: [
                    Text(
                      "Tailor Department :",
                      style: mTextStyle13(
                          mFontWeight: FontWeight.w500,
                          mColor: AppColor.textColorLightBlack),
                    ),
                    Expanded(
                      child: Text(
                        "${getJobListData['tailor_department']}",
                        style: mTextStyle13(mFontWeight: FontWeight.w600),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              // Stitching Price
              getJobListData['stitching_price'] == null
                  ? Container()
                  : Card_Container_Widget(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      mBorderColor: AppColor.navBgColor,
                      child: Row(
                        children: [
                          Text(
                            "Stitching Price :",
                            style: mTextStyle13(
                                mFontWeight: FontWeight.w500,
                                mColor: AppColor.textColorLightBlack),
                          ),
                          Expanded(
                            child: Text(
                              "${getJobListData['stitching_price']}",
                              style: mTextStyle13(mFontWeight: FontWeight.w600),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),

              // Need Education
              Card_Container_Widget(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                mBorderColor: AppColor.navBgColor,
                child: Row(
                  children: [
                    Text(
                      "Need Education :",
                      style: mTextStyle13(
                          mFontWeight: FontWeight.w400,
                          mColor: AppColor.textColorLightBlack),
                    ),
                    widthSpacer(),
                    Expanded(
                        child: Wrap(
                      children: List.generate(
                          (getJobListData['tailor_education'] as List).length,
                          (index) {
                        return Text(
                          "${getJobListData['tailor_education'][index]},  ",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                        );
                      }),
                    )),
                  ],
                ),
              ),

              // Tailor Skills
              Card_Container_Widget(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                mBorderColor: AppColor.navBgColor,
                child: Row(
                  children: [
                    Text(
                      "Tailor Skills :",
                      style: mTextStyle13(
                          mFontWeight: FontWeight.w500,
                          mColor: AppColor.textColorLightBlack),
                    ),
                    widthSpacer(),
                    Expanded(
                        child: Wrap(
                      children: List.generate(
                          (getJobListData['tailor_skill'] as List).length,
                          (index) {
                        return Text(
                          "${getJobListData['tailor_skill'][index]},  ",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                        );
                      }),
                    )),
                  ],
                ),
              ),

              // Job Description
              heightSpacer(),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      width: mq.size.width,
                      child: Text(
                        "Job Description",
                        style: mTextStyle17(mFontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    heightSpacer(),
                    Text(
                      "${getJobListData['job_description']}",
                      style: mTextStyle13(),
                    ),
                  ],
                ),
              ),

              // Job Responsibilities
              getJobListData['job_responsibilities'] == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            width: mq.size.width,
                            child: Text(
                              "Job Responsibilities",
                              style: mTextStyle17(mFontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          heightSpacer(),
                          Text(
                            "${getJobListData['job_responsibilities']}",
                            style: mTextStyle13(),
                          ),
                        ],
                      ),
                    ),

              /// Interview Address
              Card_Container_Widget(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  mBorderColor: AppColor.navBgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: mq.size.width,
                        child: Text(
                          "Interview Address",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      heightSpacer(mHeight: 6),
                      Text(
                        "${getJobListData['interviewAddress']}",
                        style: mTextStyle13(),
                      ),

                      /// work Location
                      heightSpacer(mHeight: 20),
                      Container(
                        width: mq.size.width,
                        child: Text(
                          "Worked Location",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      Text("${getJobListData['workLocation']}"),
                    ],
                  )),

              /// Garments Images
              heightSpacer(),
              getJobListData['garment_image'] == null  &&
                      getJobListData['part_rate_image'] == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: mq.size.width,
                      child: Text(
                        "Garments Images",
                        style: mTextStyle17(mFontWeight: FontWeight.w700),
                      ),
                    ),

               /// Image View
               getJobListData['garment_image'] == null  &&
                      getJobListData['part_rate_image'] == null
                  ? Container()
                  : Card_Container_Widget(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  mBorderColor: AppColor.navBgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: mq.size.width,
                        child: Text(
                          "Garment Image",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      heightSpacer(mHeight: 6),
                      Container(
                        child:
                            Image.network("${getJobListData['garment_image']}"),
                      ),

                      /// work Location
                      heightSpacer(mHeight: 30),
                      Container(
                        width: mq.size.width,
                        child: Text(
                          "Worked Location",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      Container(
                        child: Image.network(
                            "${getJobListData['part_rate_image']}"),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
       // Submit bottom Sheet bottom Sheet Btn
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Rounded_Btn_Widget(
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
              ),
        ),
      ),
    );
  }

  //============= UI part End ==================
  Widget _OtherDetails({required String title, titleText}) {
    return Row(
      children: [
        Text(
          "${title} :",
          style: mTextStyle13(mFontWeight: FontWeight.w500),
          textAlign: TextAlign.right,
        ),
        widthSpacer(mWidth: 7),
        Expanded(
          child: Text(
            "${titleText}",
            style: mTextStyle13(mFontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
