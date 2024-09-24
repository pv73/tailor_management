import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms_And_Condition extends StatefulWidget {
  @override
  State<Terms_And_Condition> createState() => _Terms_And_ConditionState();
}

class _Terms_And_ConditionState extends State<Terms_And_Condition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: 'https://tailormanagement.com/terms-and-condition.html',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
