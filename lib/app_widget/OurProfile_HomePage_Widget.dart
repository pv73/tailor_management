import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tailor/modal/UserModel.dart';
import 'package:tailor/ui_helper.dart';

class OurProfile_HomePage_Widget extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;

  const OurProfile_HomePage_Widget(
      {super.key, required this.firebaseUser, required this.userModel});

  @override
  State<OurProfile_HomePage_Widget> createState() =>
      _OurProfile_HomePage_WidgetState();
}

class _OurProfile_HomePage_WidgetState
    extends State<OurProfile_HomePage_Widget> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "Mr. ${widget.userModel.user_name}"
                                        .toUpperCase(),
                                    style: mTextStyle20(
                                        mFontWeight: FontWeight.w900,
                                        FontStyle: FontStyle.normal,
                                        mColor: AppColor.btnBgColorGreen),
                                    maxLines: 2,
                                  ),
                                ),

                                // Tailor Type
                                Text(
                                    "Tailor Type: ${widget.userModel.tailor_type}",
                                    style: mTextStyle14(
                                        mFontWeight: FontWeight.w700)),

                                // Phone Number
                                heightSpacer(mHeight: 5),
                                widget.userModel.email == null
                                    ? Container()
                                    : Icon_Text(
                                        mIcon: Icons.email,
                                        mText: "${widget.userModel.email}",
                                      ),

                                // Phone Number
                                heightSpacer(mHeight: 5),
                                Icon_Text(
                                  mIcon: Icons.phone,
                                  mText: "${widget.userModel.phone}",
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: widget.userModel.profile_pic == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: AssetImage(
                                        "assets/images/logo/programmer.png"),
                                    radius: 35,
                                  )
                                : CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                        "${widget.userModel.profile_pic}"),
                                  ),
                          ),
                        ),

                        //
                      ],
                    ),
                  ],
                ),
              ),

              /// Slider Container Page 2
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Education
                    Row(
                      children: [
                        Text(
                          "${widget.userModel.education}",
                          style: mTextStyle13(mFontWeight: FontWeight.w600),
                        ),
                        widget.userModel.course == null
                            ? Text("")
                            : Text(
                                ", ${widget.userModel.course}",
                                style:
                                    mTextStyle13(mFontWeight: FontWeight.w600),
                              ),
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: AppColor.textColorLightBlack)),
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                      margin: EdgeInsets.all(2),
                      child: Text(
                        "Batch of ${widget.userModel.passing_year}",
                        style: mTextStyle11(),
                      ),
                    ),

                    // garment_category
                    heightSpacer(),
                    Row(
                      children: [
                        Text(
                          "Garment Category -",
                          style: mTextStyle13(mFontWeight: FontWeight.w500),
                        ),
                        widthSpacer(mWidth: 5),
                        Container(
                          child: widget.userModel.tailor_type == null
                              ? Container()
                              : Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.start,
                                  // Align items to the start of the line
                                  children:
                                      (widget.userModel.garment_category ?? [])
                                          .map((garment_category) {
                                    return Container(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Text(
                                        "${garment_category},",
                                        style: mTextStyle13(
                                          mFontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ),
                      ],
                    ),

                    // Total Experience
                    heightSpacer(mHeight: 2),
                    widget.userModel.totalExpMonths == null
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                "Total Experience - ",
                                style:
                                    mTextStyle13(mFontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${widget.userModel.totalExpYears} Year, ${widget.userModel.totalExpMonths} Months",
                                style:
                                    mTextStyle13(mFontWeight: FontWeight.w700),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),

                    // Buttons
                    heightSpacer(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: AppColor.btnBgColorGreen)),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          margin: EdgeInsets.all(2),
                          child: Text(
                            "Share Profile",
                            style:
                                mTextStyle11(mColor: AppColor.btnBgColorGreen),
                          ),
                        ),
                        widthSpacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: AppColor.btnBgColorGreen)),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          margin: EdgeInsets.all(2),
                          child: Text(
                            "View Details",
                            style:
                                mTextStyle11(mColor: AppColor.btnBgColorGreen),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //// Slider Indicator ///
        heightSpacer(mHeight: 10),
        buildIndicator(),
      ],
    );
  }

  //================================================
  //        UI Complete

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

  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle13(mFontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
