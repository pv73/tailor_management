import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:tailor/ui_helper.dart';

class Multi_And_Single_Btn extends StatelessWidget {
  final String? heading_Text;
  final String? isRequired_start;
  final List<String> buttons;
  final bool isRadio;
  final void Function(String, int, bool)? onSelected;

  Multi_And_Single_Btn({
    super.key,
    this.heading_Text,
    this.isRequired_start,
    required this.buttons,
    required this.onSelected,
    this.isRadio = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card_Container_Widget(
      padding: EdgeInsets.all(8),
      mBorderColor: AppColor.textColorLightBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "${heading_Text}",
              style: mTextStyle14(mFontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: "${isRequired_start}",
                  style: mTextStyle14(
                      mFontWeight: FontWeight.w800, mColor: Colors.red),
                )
              ],
            ),
          ),

          // Work Place Type
          heightSpacer(),
          GroupButton(
              options: mAdminPageGroupButtonOptions(),
              isRadio: isRadio,
              buttons: buttons,
              onSelected: onSelected),


        ],
      ),
    );
  }
}
