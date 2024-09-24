
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tailor/ui_helper.dart';

class Image_Viewer_Screen extends StatelessWidget {
  final String ImageUrl;

  const Image_Viewer_Screen({super.key, required this.ImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(
            text: "View ",
            style: mTextStyle20(),
            children: [
              TextSpan(
                text: "Image",
                style: mTextStyle20(
                  mColor: AppColor.textColorBlue,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Image.network("${ImageUrl}"),
      ),
    );
  }
}

//============ Image_Viewer_Screen_Aadhaar from Tailor profile ==========
class Image_Viewer_Screen_Aadhaar extends StatefulWidget {
  final String frontImageUrl;
  final String backImageUrl;

  Image_Viewer_Screen_Aadhaar({super.key, required this.frontImageUrl, required this.backImageUrl});

  @override
  State<Image_Viewer_Screen_Aadhaar> createState() => _Image_Viewer_Screen_AadhaarState();
}

class _Image_Viewer_Screen_AadhaarState extends State<Image_Viewer_Screen_Aadhaar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        titleSpacing: 0,
        title: RichText(
          text: TextSpan(
            text: "Aadhaar ",
            style: mTextStyle20(),
            children: [
              TextSpan(
                text: "document",
                style: mTextStyle20(
                  mColor: AppColor.textColorBlue,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========== Front Image ================
                  Text(
                    "Front Image",
                    style: mTextStyle15(mFontWeight: FontWeight.w600),
                  ),
                  heightSpacer(),
                  Container(
                    alignment: Alignment.center,
                    child: Image.network("${widget.frontImageUrl}"),
                  ),

                  heightSpacer(mHeight: 20),

                  // ========= Back Image ===============
                  Text(
                    "Back Image",
                    style: mTextStyle15(mFontWeight: FontWeight.w600),
                  ),
                  heightSpacer(),
                  Container(
                    alignment: Alignment.center,
                    child: Image.network("${widget.backImageUrl}"),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 25),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: AppColor.textColorWhite,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              _frontDownload();
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_download_outlined),
                                  Text("Front Download"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        widthSpacer(),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: AppColor.textColorWhite,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              _backDownload();
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_download_outlined),
                                  Text("Back Download"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void _frontDownload() async {
    String path = "${widget.frontImageUrl}";
    GallerySaver.saveImage(path).then((value) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.btnBgColorGreen,
            content: Center(child: Text('Image downloaded successfully')),
          ),
        );
      });
    });
  }

  void _backDownload() async {
    String path = "${widget.backImageUrl}";
    GallerySaver.saveImage(path).then((value) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.btnBgColorGreen,
            content: Center(child: Text('Image downloaded successfully')),
          ),
        );
      });
    });
  }
}
