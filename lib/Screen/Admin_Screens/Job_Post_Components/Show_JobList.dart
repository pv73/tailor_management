import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Show_JobList extends StatefulWidget {
  var mDateTime;
  void Function()? onPress;
  var jobPost;

  Show_JobList({this.mDateTime, this.jobPost, this.onPress});


  @override
  State<Show_JobList> createState() => _Show_JobListState();
}

class _Show_JobListState extends State<Show_JobList> {
  @override
  Widget build(BuildContext context) {
    return Card_Container_Widget(
      mColor: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Date
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.green.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posted Date: ",
                  style: mTextStyle13(
                    mFontWeight: FontWeight.w600,
                    mColor: AppColor.btnBgColorGreen,
                  ),
                ),
                // Text(
                //   "${DateFormat("d MMM yy").format(dateTime)} ",
                //   style: mTextStyle13(
                //     mFontWeight: FontWeight.w600,
                //     mColor: AppColor.btnBgColorGreen,
                //   ),
                // )
              ],
            ),
          ),

          // Image & JobType & company_name
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => View_Jobs_Details(jobIndex: index)),
              // );
            },
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 10),
              leading: CircleAvatar(
                backgroundImage: NetworkImage("${widget.jobPost['company_logo']}"),
              ),
              title: Text(
                "${widget.jobPost['job_type']}",
                style: mTextStyle16(mFontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                "${widget.jobPost['company_name']}",
                style: mTextStyle12(),
              ),
            ),
          ),

          // type of job
          Container(
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: (widget.jobPost['tailor_skill'] as List).length > 3
                  ? 3
                  : (widget.jobPost['tailor_skill'] as List).length,
              itemBuilder: (context, skill_Child) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    "${widget.jobPost['tailor_skill'][skill_Child]}",
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
                      "Shift: ${widget.jobPost['worked_shift']}",
                      style: mTextStyle13(
                        mFontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                widthSpacer(mWidth: 5),
                Expanded(
                  child: Container(
                    child: Text(
                      "Type: ${widget.jobPost['worked_type']}",
                      style: mTextStyle13(
                        mFontWeight: FontWeight.w500,
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
                        color: Colors.grey.shade600,
                      ),
                      widthSpacer(mWidth: 2),
                      Expanded(
                        child: CalculateSalary(widget.jobPost),
                      ),
                    ],
                  ),
                ),

                //
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_city,
                          size: 15, color: Colors.grey.shade600),
                      widthSpacer(mWidth: 4),
                      Expanded(
                        child: Text(
                          "${widget.jobPost['state']}",
                          style: mTextStyle12(
                            mFontWeight: FontWeight.w500,
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
                      Icon(Icons.group_add_outlined,
                          size: 15, color: Colors.grey.shade600),
                      widthSpacer(mWidth: 4),
                      Expanded(
                        child: Text(
                          " ${widget.jobPost['total_employee']} Emp.",
                          style: mTextStyle12(
                            mFontWeight: FontWeight.w500,
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
    );
  }

  // ===============================================
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
}
