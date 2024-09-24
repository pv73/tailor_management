import 'package:flutter/material.dart';
import 'package:tailor/ui_Helper.dart';

class FilterBoxContainer extends StatelessWidget {
  final void Function()? onClose;
  final void Function()? onDayShift;
  final void Function()? onNightShift;
  final void Function()? onSite;

  const FilterBoxContainer({super.key, this.onClose, this.onDayShift, this.onNightShift, this.onSite});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Filter by work shift and work type", style: mTextStyle14(mFontWeight: FontWeight.w600)),
            InkWell(
              onTap: onClose,
              child: Icon(Icons.close, color: Colors.red, size: 22),
            )
          ],
        ),
        heightSpacer(),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onDayShift,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/logo/summer.png"), width: 50),
                      heightSpacer(mHeight: 5),
                      Text("Day Shift", style: mTextStyle13(mFontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
            widthSpacer(mWidth: 5),
            Expanded(
              child: InkWell(
                onTap: onNightShift,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/logo/ic_night_shift.png"), width: 50),
                      heightSpacer(mHeight: 5),
                      Text("Night Shift", style: mTextStyle13(mFontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
            widthSpacer(mWidth: 5),
            Expanded(
              child: InkWell(
                onTap: onSite,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: Column(
                    children: [
                      Image(image: AssetImage("assets/images/logo/single_operator.png"), width: 50),
                      heightSpacer(mHeight: 5),
                      Text("Onsite", style: mTextStyle13(mFontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
