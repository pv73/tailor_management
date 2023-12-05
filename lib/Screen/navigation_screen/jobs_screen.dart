import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tailor/dynimic_list/video_page_list.dart';
import 'package:tailor/ui_Helper.dart';
import 'package:video_player/video_player.dart';

class Jobs_Screen extends StatefulWidget {
  @override
  State<Jobs_Screen> createState() => _Jobs_Screen();
}

class _Jobs_Screen extends State<Jobs_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(text: "Tailor ", style: mTextStyle20(), children: [
            TextSpan(
                text: "Jobs",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
        ),
        backgroundColor: AppColor.textColorWhite,
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
                color: AppColor.textColorWhite,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 25,
              color: AppColor.textColorBlack,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          child: Text(
            "Comming Soon",
            style: TextStyle(fontSize: 25),
          ),
        ),
      )),
    );
  }
}
