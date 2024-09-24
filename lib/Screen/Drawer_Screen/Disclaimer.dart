import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Disclaimer extends StatefulWidget {
  const Disclaimer({super.key});

  @override
  State<Disclaimer> createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  late MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.textColorWhite,
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl: 'https://tailormanagement.com/disclaimer.html',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
