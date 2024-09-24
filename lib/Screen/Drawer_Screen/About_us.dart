import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class About_Us extends StatefulWidget {
  @override
  State<About_Us> createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: 'https://tailormanagement.com/about.html',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
