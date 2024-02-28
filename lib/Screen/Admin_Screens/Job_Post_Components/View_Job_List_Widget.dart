import 'package:flutter/material.dart';
import 'package:tailor/Screen/Admin_Screens/Job_Post_Components/Show_Experience_Widget.dart';
import 'package:tailor/ui_helper.dart';

class View_Job_List_Widget extends StatelessWidget {
  String? date;
  void Function()? onPress;
  void Function()? applyPress;
  var jobPost;
  String? daysAgo;
  bool? isApplied;
  Widget? morePopupButton;


  View_Job_List_Widget({
    required this.date,
    required this.onPress,
    this.applyPress,
    required this.jobPost,
    required this.daysAgo,
    this.isApplied = false,
    this.morePopupButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.textColorWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
            color: Colors.green.shade200),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //============== Post Date ===============
          // ============== If Job already Applied this job then hide==============
          isApplied == true
              ? Container()
              : Container(
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
                        "Posted Date: ",
                        style: mTextStyle13(
                          mFontWeight: FontWeight.w500,
                          mColor: AppColor.btnBgColorGreen,
                        ),
                      ),
                      Text(
                        "${date}",
                        style: mTextStyle13(
                          mFontWeight: FontWeight.w600,
                          mColor: AppColor.btnBgColorGreen,
                        ),
                      )
                    ],
                  ),
                ),

          // ===========  Image & JobType & company_name ============
          InkWell(
            splashColor: Colors.transparent,
            onTap: onPress,
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${jobPost['job_type']}",
                          style: mTextStyle17(mFontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          "Posted by ${jobPost['company_name']}",
                          style: mTextStyle13(mFontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: AppColor.btnBgColorGreen,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage("${jobPost['company_logo']}"),
                    ),
                  ),
                  morePopupButton == null ? Container() : Container(child: morePopupButton),
                ],
              ),
            ),
          ),

          // ========== Company Address ===========
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Row(
              children: [
                Icon(
                  Icons.place,
                  size: 18,
                  color: AppColor.textColorLightBlack,
                ),
                widthSpacer(mWidth: 5),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${jobPost['company_address']}",
                      style: mTextStyle14(mFontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ========== Experience ===========
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.business_center,
                  size: 18,
                  color: AppColor.textColorLightBlack,
                ),
                widthSpacer(mWidth: 5),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Show_Experience_Widget(
                      getJobListData: jobPost,
                      mFontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================= total Employee, workShift and garment_order ==============
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.group,
                        size: 15,
                        color: Colors.grey.shade600,
                      ),
                      widthSpacer(mWidth: 5),
                      Expanded(
                        child: Container(
                          child: Text(
                            "${jobPost['total_tailor']}",
                            style: mTextStyle13(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      jobPost['work_shift'] == "Day Shift"
                          ? Icon(
                              Icons.sunny,
                              size: 15,
                              color: Colors.grey.shade600,
                            )
                          : Icon(
                              Icons.nights_stay,
                              size: 15,
                              color: Colors.grey.shade600,
                            ),
                      widthSpacer(mWidth: 4),
                      Expanded(
                        child: Text(
                          "${jobPost['work_shift']}",
                          style: mTextStyle13(),
                        ),
                      ),
                    ],
                  ),
                ),

                // ========= garment_orders =========
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.store, size: 15, color: Colors.grey.shade600),
                      widthSpacer(mWidth: 4),
                      Expanded(
                        child: Text(
                          " ${jobPost['garment_order']} Orders",
                          style: mTextStyle13(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ============ Tailor Skill =============
          (jobPost['tailor_skill'] as List).isNotEmpty
              ? isApplied == false
                  ? Container(
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: (jobPost['tailor_skill'] as List).length > 3 ? 3 : (jobPost['tailor_skill'] as List).length,
                        itemBuilder: (context, skill_Child) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            // alignment: Alignment.center,
                            // margin: EdgeInsets.only(right: 5),
                            // padding: EdgeInsets.symmetric(horizontal: 6),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.grey.shade400),
                            //   borderRadius: BorderRadius.circular(3),
                            // ),
                            child: Text(
                              "${jobPost['tailor_skill'][skill_Child]}, ",
                              style: mTextStyle13(mColor: AppColor.textColorLightBlack),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    )
                  : Container()
              : Container(),

          // ================ Other Details ==============
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 10, top: 2),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      daysAgo == "0"
                          ? "Today"
                          : int.tryParse("${daysAgo}") != null && int.parse("${daysAgo}") > 30
                              ? "30+d ago"
                              : "${daysAgo}d ago",
                      style: mTextStyle13(mColor: Colors.grey.shade500),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onPress,
                    child: Text(
                      "View More..",
                      style: mTextStyle13(mColor: AppColor.btnBgColorGreen, mFontWeight: FontWeight.w500),
                      textAlign: isApplied == true ? TextAlign.right : TextAlign.center,
                    ),
                  ),
                ),

                // =========== If Job Applied then hide ================
                isApplied == true
                    ? Container()
                    : Expanded(
                        child: InkWell(
                          onTap: applyPress,
                          child: Text(
                            "Apply Now",
                            style: mTextStyle13(mColor: AppColor.btnBgColorGreen, mFontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
