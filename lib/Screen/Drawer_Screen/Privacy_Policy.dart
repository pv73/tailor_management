import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy_Policy extends StatefulWidget {
  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: 'https://tailormanagement.com/privacy-policy.html',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
