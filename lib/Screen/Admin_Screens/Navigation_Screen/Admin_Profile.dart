import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor/Screen/Admin_Screens/Admin_Home_Page/Pdf_Viewer_Screen.dart';
import 'package:tailor/app_widget/Admin_NameCard_Widget.dart';
import 'package:tailor/app_widget/Drawer_Widget.dart';
import 'package:tailor/modal/CompanyModel.dart';
import 'package:tailor/ui_helper.dart';

class Admin_Profile extends StatefulWidget {
  final User firebaseUser;
  final CompanyModel companyModel;

  const Admin_Profile(
      {super.key, required this.firebaseUser, required this.companyModel});

  @override
  State<Admin_Profile> createState() => _Admin_ProfileState();
}

class _Admin_ProfileState extends State<Admin_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(text: "Company ", style: mTextStyle20(), children: [
            TextSpan(
                text: "Profile",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start Profile Box
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Admin_NameCard_Widget(
                    firebaseUser: widget.firebaseUser,
                    companyModel: widget.companyModel,
                    mTextColor: AppColor.textColorBlack,
                  ),
                ),

                // Contact Person Name
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {},
                        mIcon: Icons.edit,
                        title: "Contact Person Name",
                        buttonName: "Edit",
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "${widget.companyModel.user_name}",
                        style: mTextStyle13(),
                      )
                    ],
                  ),
                ),

                //  Company Name
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {},
                        mIcon: Icons.edit,
                        title: "Company",
                        buttonName: "Edit",
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "${widget.companyModel.company_name}",
                        style: mTextStyle13(),
                      )
                    ],
                  ),
                ),

                // Email
                heightSpacer(),
                Card_Container_Widget(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {},
                        mIcon: Icons.edit,
                        title: "Email",
                        buttonName: "Edit",
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "${widget.companyModel.email}",
                        style: mTextStyle13(),
                      )
                    ],
                  ),
                ),

                // Contact Person Name
                widget.companyModel.company_number != null
                    ? Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Detail_Box(
                              onPressed: () {},
                              mIcon: Icons.edit,
                              title: "Company Number",
                              buttonName: "Edit",
                            ),
                            heightSpacer(mHeight: 5),
                            Text(
                              "${widget.companyModel.company_number}",
                              style: mTextStyle13(),
                            )
                          ],
                        ),
                      )
                    : Container(),

                // Company Gst No
                widget.companyModel.gst_no != null
                    ? Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Detail_Box(
                              onPressed: () {},
                              mIcon: Icons.edit,
                              title: "Company GST No.",
                              buttonName: "Edit",
                            ),
                            heightSpacer(mHeight: 5),
                            Text(
                              "${widget.companyModel.gst_no}",
                              style: mTextStyle13(),
                            ),
                            heightSpacer(mHeight: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pdf_Viewer_Screen(
                                            pdfUrl:
                                                "${widget.companyModel.gst_file}",
                                          )),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColor.cardBtnBgGreen)),
                                child: Text(
                                    "${widget.companyModel.gst_fileName}",
                                    style: mTextStyle10(
                                        mColor: AppColor.cardBtnBgGreen)),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),

                // Company Pan Card Number
                widget.companyModel.pan_no != null
                    ? Card_Container_Widget(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Detail_Box(
                              onPressed: () {},
                              mIcon: Icons.edit,
                              title: "Company Pan Card No.",
                              buttonName: "Edit",
                            ),
                            heightSpacer(mHeight: 5),
                            Text(
                              "${widget.companyModel.pan_no}",
                              style: mTextStyle13(),
                            )
                          ],
                        ),
                      )
                    : Container(),

                // Company Address
                Card_Container_Widget(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Detail_Box(
                        onPressed: () {},
                        mIcon: Icons.edit,
                        title: "Company Address",
                        buttonName: "Edit",
                      ),
                      heightSpacer(mHeight: 5),
                      Text(
                        "${widget.companyModel.address}",
                        style: mTextStyle13(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //================================================================

  ////   Details Box Widget
  Widget Detail_Box(
      {title, required void Function()? onPressed, buttonName, mIcon}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: mTextStyle13(mFontWeight: FontWeight.w700),
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Row(
              children: [
                Icon(
                  mIcon,
                  size: 12,
                  color: AppColor.cardBtnBgGreen,
                ),
                widthSpacer(mWidth: 2),
                Text(
                  buttonName,
                  style: mTextStyle12(
                      mFontWeight: FontWeight.w700,
                      mColor: AppColor.cardBtnBgGreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
