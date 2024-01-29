import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:tailor/ui_helper.dart';

class Pdf_Viewer_Screen extends StatefulWidget {
  final String pdfUrl;

  const Pdf_Viewer_Screen({super.key, required this.pdfUrl});

  @override
  State<Pdf_Viewer_Screen> createState() => _Pdf_Viewer_ScreenState();
}

class _Pdf_Viewer_ScreenState extends State<Pdf_Viewer_Screen> {
  PDFDocument? document;

  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialisePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(text: "View ", style: mTextStyle20(), children: [
            TextSpan(
                text: "Pdf",
                style: mTextStyle20(mColor: AppColor.textColorBlue))
          ]),
        ),
      ),
      body: document != null
          ? PDFViewer(
              progressIndicator: Image(
                image: AssetImage("assets/images/lottie_animation/book.gif"),
                width: 100,
              ),
              scrollDirection: Axis.vertical,
              document: document!,
            )
          : Center(
              child: Image(
                image: AssetImage("assets/images/lottie_animation/book.gif"),
                width: 100,
              ),
            ),
    );
  }
}
