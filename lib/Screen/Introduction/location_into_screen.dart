import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor/Screen/Introduction/education_into_screen.dart';
import 'package:tailor/app_widget/intro_number_widget.dart';
import 'package:tailor/app_widget/profile_box_widget.dart';
import 'package:tailor/app_widget/rounded_btn_widget.dart';
import 'package:tailor/ui_Helper.dart';

class Location_Into_Screen extends StatefulWidget {
  @override
  State<Location_Into_Screen> createState() => _Location_Into_Screen();
}

class _Location_Into_Screen extends State<Location_Into_Screen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userData;

  // This variable for get Location
  String? UserId;
  double? lat;
  double? long;
  String? address_1;
  String? address_2;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Function to retrieve the UserId from shared preferences
  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserId = prefs.getString('UserId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number Indicator Row
                Row(
                  children: [
                    // 1st number
                    Intro_Number_Widget(number: 1, name: "About", active_no: 1),
                    Expanded(
                      child: Divider(color: AppColor.cardBtnBgGreen),
                    ),

                    // 2nd Number
                    Intro_Number_Widget(
                      number: 2,
                      name: "Education",
                    ),
                    Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                    // 3rd Number
                    Intro_Number_Widget(number: 3, name: "Interest"),
                    Expanded(child: Divider(color: AppColor.cardBtnBgGreen)),

                    // 4th Number
                    Intro_Number_Widget(number: 4, name: "Skills"),
                  ],
                ),

                Divider(height: 35),

                // Start Profile Box
                UserId == null
                    ? Center(child: CircularProgressIndicator())
                    : Profile_box_Widget(UserId: UserId),

                // Location Icon
                heightSpacer(mHeight: 50),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/lottie_animation/location.png",
                    width: 130,
                    color: AppColor.textColorLightBlack,
                  ),
                ),
                heightSpacer(mHeight: 25),

                // Location text
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      // Text Section Start
                      address_1 == null
                          ? Container()
                          : Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Your Location",
                          style: mTextStyle16(
                              mFontWeight: FontWeight.w600,
                              mColor: AppColor.btnBgColorGreen),
                        ),
                      ),

                      address_1 == null
                          ? Text(
                        "Discover the best jobs near you",
                        style: mTextStyle18(mFontWeight: FontWeight.w600),
                      )
                          : Text(
                        "${address_1}",
                        style: mTextStyle17(
                            mFontWeight: FontWeight.w600,
                            mColor: AppColor.textColorBlack),
                      ),

                      //==========================
                      //     Second Address

                      heightSpacer(mHeight: 5),
                      address_2 == null
                          ? Container(
                        color: Colors.green.shade100,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Text(
                          "Help us know where you currently live",
                          style: mTextStyle12(),
                        ),
                      )
                          : Text(
                        "${address_2}",
                        style: mTextStyle16(
                          mColor: AppColor.textColorBlack,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Submit bottom Sheet bottom Sheet Btn
      bottomSheet: Container(
        color: AppColor.bgColorWhite,
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.btnBgColorGreen,
                  ),
                )
                    : Rounded_Btn_Widget(
                  title: address_1 == null
                      ? "Pick current location"
                      : "Next",
                  btnBgColor: AppColor.btnBgColorGreen,
                  onPress: address_1 == null
                      ? () {
                    setState(() {
                      isLoading = true;
                    });
                    getLatLong();
                  }
                      : () {
                    var location = {
                      'address': '${address_1}, ${address_2}',
                    };

                    FirebaseFirestore.instance
                        .collection('clients')
                        .doc(UserId)
                        .update(location);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Education_Into_Screen(),
                      ),
                    );
                  },
                  mHeight: 40,
                  borderRadius: 5,
                  mAlignment: Alignment.center,
                ),
              ),
              heightSpacer(mHeight: 5),
              Container(
                child: Rounded_Btn_Widget(
                  // title: "Search Manually",
                  title: "Skip Location",
                  borderColor: AppColor.btnBgColorGreen,
                  btnBgColor: Colors.transparent,
                  mTextColor: AppColor.cardBtnBgGreen,
                  onPress: () {
                    var location = {
                      'address': '',
                    };

                    FirebaseFirestore.instance
                        .collection('clients')
                        .doc(UserId)
                        .update(location);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Education_Into_Screen()),
                    );

                    /// Show Dialog
                    ///
                    // showDialog<String>(
                    //   context: context,
                    //   builder: (BuildContext context) => AlertDialog(
                    //     title: const Text('Alert'),
                    //     content: const Text('Now This Button is not Working'),
                    //     actions: <Widget>[
                    //       TextButton(
                    //         onPressed: () => Navigator.pop(context, 'Cancel'),
                    //         child: const Text('Cancel'),
                    //       ),
                    //       TextButton(
                    //         onPressed: () => Navigator.pop(context, 'OK'),
                    //         child: const Text('OK'),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  },
                  mHeight: 40,
                  borderRadius: 5,
                  mAlignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================== End UI =======================================
  Widget Icon_Text({mIcon, mText}) {
    return Container(
      child: Row(
        children: [
          Icon(
            mIcon,
            size: 14,
            color: AppColor.textColorLightBlack,
          ),
          widthSpacer(mWidth: 4),
          Expanded(
            flex: 3,
            child: Text(
              "${mText}",
              style: mTextStyle13(
                  mFontWeight: FontWeight.w600,
                  mColor: AppColor.textColorLightBlack),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  // For Location Fatch Function
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(10),
          content: Text('Location services are disabled.'),
        ),
      );

      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Text("Location permissions are denied"),
        ));
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(
            "Location permissions are permanently denied, we cannot request permissions."),
      ));
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
      setState(() {
        // Set loading state to false once address is obtained
        isLoading = false;
      });
    });
  }

  // =================================================
  //         For convert lat long to address
  // ==================================================
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      address_1 =
          placemarks[3].name! + ", " + placemarks[3].subLocality! + ", ";
      address_2 = placemarks[3].locality! +
          ", " +
          placemarks[3].postalCode! +
          ", " +
          placemarks[3].country!;

// Set loading state to false once address is obtained
      isLoading = false;
    });

    for (int i = 1; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }
}
